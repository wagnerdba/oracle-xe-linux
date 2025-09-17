# docker build -t oracle-xe-linux .
# docker run -it --name oracle-xe-linux -p 1521:1521 -p 5500:5500 oracle-xe-linux bash

FROM oraclelinux:8

# 1 - Atualiza pacotes e instala utilitários necessários
RUN dnf -y update && \
    dnf -y install wget unzip mc net-tools glibc libaio sudo && \
    dnf clean all

# 2 - Copia o pacote RPM do Oracle XE OL8
COPY oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm /tmp/

# 3 - Instala o Oracle XE
RUN dnf -y localinstall /tmp/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm && \
    rm -f /tmp/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

# 4 - Variáveis de ambiente do Oracle
ENV ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
ENV PATH=$ORACLE_HOME/bin:$PATH
ENV ORACLE_SID=XE

# 5 - Expor portas
# 1521 = SQL*Net
# 5500 = EM Express
EXPOSE 1521 5500

# 6 - Script de inicialização
# Roda o banco automaticamente quando o container sobe
CMD ["/bin/bash", "-c", "/etc/init.d/oracle-xe-21c start && tail -f /opt/oracle/diag/rdbms/*/*/alert*.log"]
