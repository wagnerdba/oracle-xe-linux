# ORACLE LINUX 8 COM O ORACLE DATABASE XE INSTALADO

- BAIXAR RPM 

  https://www.oracle.com/database/technologies/xe-downloads.html

- BAIXANDO DO DOCKER HUB

  docker pull wagnerpires/oracle-xe-linux:latest

- OU COMANDO PARA A CONSTRUÇÃO DA IMAGEM DOCKER (DOCKERFILE)

  docker build -t oracle-xe-linux .

- COMANDO PARA A CRIAÇÃO E PRIMEIRA EXECUÇÃO DO CONTAINER

  docker run -it --name oracle-xe-linux -p 1521:1521 -p 5500:5500 oracle-xe-linux bash

  OU (se fez o pull da imagem)

  docker run -it --name oracle-xe-linux -p 1521:1521 -p 5500:5500 wagnerpires/oracle-xe-linux bash

- ETAPA QUE CONFIGURA E CRIA A SENHA PARA ACESSO AO DB

  /etc/init.d/oracle-xe-21c configure
  
  sqlplus SYSTEM/123456@//localhost:1521/XE
  
  EXEC DBMS_XDB_CONFIG.SETLISTENERLOCALACCESS(FALSE);

PARA ENTRAR NO CONTAINER NOVAMENTE:

- START NO CONTAINER

  docker start oracle-xe-linux

- ACESSO AO BASH DO CONTAINER

  docker exec -it oracle-xe-linux bash

- STARTA O BANCO

$ /etc/init.d/oracle-xe-21c start

- CARREGA O PROFILE COM AS AMBVAR PARA ACESSO AO SQLPLUS NOVAMENTE

$ source /etc/profile

- SABER SE O ORACLE ESTÁ EM EXECUÇÃO/PARAR/INICIAR

$ lsnrctl status
$ lsnrctl stop
$ lsnrctl start

- COMMITAR CONTAINER E SUBIR PARA O DOCKER HUB

$ docker commit <CONTAINER_ID> wagnerpires/oracle-xe-linux:latest
$ docker login
$ docker push wagnerpires/oracle-xe-linux:latest

- ACESSO AO ENTERPRISE MANAGER VIA BROWSER

  https://localhost:5500/em
  ou
  https://127.0.0.1:5500/em


- ACESSO VIA DBWEAVER/JAVA

  Oracle Driver no dbweaver instalado

  Host: localhost
  Port: 1521
  Database: XE
  SID ou ServiceName

- COMANDOS SQL DIVERSOS

  Criar usuário (schema)
  
  CREATE USER C##shiva_modulos IDENTIFIED BY "123456";
  ALTER USER C##shiva_modulos QUOTA UNLIMITED ON USERS;

  Permitir login
  
  GRANT CREATE SESSION TO C##shiva_modulos;

  Permissões DDL (criar objetos no próprio schema)

  GRANT CREATE TABLE TO C##shiva_modulos;
  GRANT CREATE VIEW TO C##shiva_modulos;
  GRANT CREATE SEQUENCE TO C##shiva_modulos;
  GRANT CREATE PROCEDURE TO C##shiva_modulos;
  GRANT CREATE TRIGGER TO C##shiva_modulos;
  GRANT CREATE SYNONYM TO C##shiva_modulos;
  GRANT CREATE TYPE TO C##shiva_modulos;

  Permissões DML 
 
  GRANT SELECT ANY TABLE TO C##shiva_modulos;
  GRANT INSERT ANY TABLE TO C##shiva_modulos;
  GRANT UPDATE ANY TABLE TO C##shiva_modulos;
  GRANT DELETE ANY TABLE TO C##shiva_modulos;

  Definir tablespace padrão e liberar espaço
  
  ALTER USER C##shiva_modulos DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

  Comandos de usuário (exemplo)

  CREATE TABLE C##shiva_modulos.WR_TEMP (ID INT);
  
  INSERT INTO C##shiva_modulos.WR_TEMP (ID) VALUES (1);
  
  DELETE FROM C##shiva_modulos.WR_TEMP;
  
  SELECT * FROM C##shiva_modulos.WR_TEMP
  
  SELECT owner, table_name FROM all_tables WHERE table_name='WR_TEMP';

  INSERT INTO C##shiva_modulos.WR_TEMP (ID) SELECT LEVEL FROM dual CONNECT BY LEVEL <= 1000;

  SELECT COUNT(*) FROM C##shiva_modulos.WR_TEMP
  
