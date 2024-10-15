-- *******DROP TABLES*******

DROP TABLE T_MC_SGV_SAC CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_FUNCIONARIO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_END_FUNC CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_DEPTO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_CLIENTE CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_CLI_FISICA CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_CLI_JURIDICA CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_VISUALIZACAO_VIDEO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_VIDEO_PRODUTO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_CLASSIFICACAO_VIDEO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_PRODUTO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_CATEGORIA_PRODUTO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_END_CLI CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_BAIRRO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_LOGRADOURO CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_CIDADE CASCADE CONSTRAINTS;
DROP TABLE T_MC_SGV_ESTADO CASCADE CONSTRAINTS;

-- CRIACAO TABELA SAC
CREATE TABLE t_mc_sgv_sac (
    nr_chamado               NUMBER(10)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_funcionario           NUMBER(10) NOT NULL,
    cd_produto               NUMBER(10) NOT NULL,
    nr_cliente               NUMBER(5) NOT NULL,
    ds_detalhada_cliente     VARCHAR2(4000) NOT NULL,
    dt_abertura_chamado      DATE NOT NULL,
    dt_atendimento           DATE NULL,
    dt_minutos_atendimento   DATE NOT NULL,
    nr_tempo_total_sac       NUMBER(10) NULL,
    ds_detalhada_retorno_sac VARCHAR2(100) NULL,
    tp_chamado               CHAR(1) NOT NULL,
    st_chamado               CHAR(1) NOT NULL,
    nr_indice_satisfacao     NUMBER(2) NULL
);
    
-- CRIACAO TABELA FUNCIONARIO
CREATE TABLE t_mc_sgv_funcionario (
    cd_funcionario   NUMBER(10)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_gerente   NUMBER(10) NULL,
    cd_depto         NUMBER(3) NOT NULL,
    nm_funcionario   VARCHAR2(160) NOT NULL,
    nr_cpf           NUMBER(11) NOT NULL,
    dt_nascimento    DATE NOT NULL,
    nm_telefone      NUMBER(11) NOT NULL,
    ds_email         VARCHAR2(80) NOT NULL,
    ds_cargo         VARCHAR2(80) NOT NULL,
    vl_salario       NUMBER(10, 2) NULL,
    st_func          CHAR(1) NOT NULL,
    dt_cadastramento DATE NOT NULL,
    dt_desligamento  DATE NULL
);
    
-- CRIACAO TABELA ENDERECO FUNCIONARIO
CREATE TABLE t_mc_sgv_end_func (
    nr_end             NUMBER(8)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_logradouro      NUMBER(10) NOT NULL,
    cd_funcionario     NUMBER(10) NOT NULL,
    ds_complemento_end VARCHAR2(80) NULL,
    dt_inicio          DATE NOT NULL,
    dt_termino         DATE NULL,
    st_end             CHAR(1) NOT NULL
);

-- CRIACAO TABELA ENDERE�COO CLIENTE 
CREATE TABLE t_mc_sgv_end_cli (
    nr_end             NUMBER(8)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_logradouro      NUMBER(10) NOT NULL,
    nr_cliente         NUMBER(5) NOT NULL,
    ds_complemento_end VARCHAR2(80),
    dt_inicio          DATE NOT NULL,
    dt_termino         DATE,
    st_end             CHAR(1) NOT NULL
);
   
-- CRIACAO TABELA DEPARTAMENTO
CREATE TABLE t_mc_sgv_depto (
    cd_depto NUMBER(3)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    nm_depto VARCHAR2(100) NOT NULL,
    st_depto CHAR(1) NOT NULL
);
    
-- CRIACAO TABELA CLIENTE
CREATE TABLE t_mc_sgv_cliente (
    nr_cliente        NUMBER(5)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    nm_cliente        VARCHAR2(160) NOT NULL,
    st_cliente         CHAR(1) NOT NULL,
    dt_nasc           DATE NOT NULL,
    nm_login          VARCHAR2(50) NOT NULL,
    ds_email          VARCHAR2(100),
    ds_senha          VARCHAR2(50) NOT NULL,
    fl_sexo_biologico VARCHAR2(50) NOT NULL,
    qt_estrelas       NUMBER(1),
    nr_telefone       number(11),
    ds_genero         VARCHAR2(50),
    vl_medio_compra   NUMBER(10, 2)
);
    
-- CRIACAO TABELA CLIENTE PESSOA FISICA
CREATE TABLE t_mc_sgv_cli_fisica (
    nr_cliente    NUMBER NOT NULL,
    dt_nascimento DATE NOT NULL,
    nr_cpf        number(11) NOT NULL
);

    
-- CRIACAO TABELA CLIENTE PESSOA JURIDICA
CREATE TABLE t_mc_sgv_cli_juridica (
    nr_cliente   NUMBER NOT NULL,
    dt_fundacao  DATE,
    nr_cnpj      number(14),
    nr_inscr_est number(9)
);
    
-- CRIACAO TABELA VISUALIZACAO VIDEO
CREATE TABLE t_mc_sgv_visualizacao_video (
    cd_visualizacao NUMBER(7)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_video        NUMBER(4) NOT NULL,
    cd_produto      NUMBER(10) NOT NULL,
    nr_cliente      NUMBER(5),
    dt_visualizacao DATE NOT NULL
);
    
-- CRIACAO TABELA VIDEO PRODUTO
CREATE TABLE t_mc_sgv_video_produto (
    cd_video           NUMBER(4)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_produto         NUMBER(10) NOT NULL,
    cd_classificacao_video NUMBER(4) NOT NULL,
    dt_cadastro        DATE NOT NULL,
    st_video           CHAR(1) NOT NULL
);
    
-- CRIACAO TABELA CATEGORIA VIDEO
CREATE TABLE t_mc_sgv_classificacao_video (
    cd_classificacao_video NUMBER(4) 
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    tp_video               VARCHAR2(30) NOT NULL,
    dt_criacao             DATE NOT NULL
);
    
-- CRIACAO TABELA PRODUTO
CREATE TABLE t_mc_sgv_produto (
    cd_produto            NUMBER(10)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_categoria_produto  NUMBER(4) NOT NULL,
    ds_normal_produto     VARCHAR2(80) NOT NULL,
    ds_completa_produto   VARCHAR2(4000) NOT NULL,
    nr_cod_barras_produto VARCHAR2(50) NULL,
    vl_unitario           NUMBER(8, 2) NOT NULL,
    tp_embalagem          VARCHAR2(15) NULL,
    vl_percentual_lucro   NUMBER(8, 2) NULL,
    st_produto            CHAR(1) NOT NULL
);
    
-- CRIACAO TABELA CATEGORIA PRODUTO
CREATE TABLE t_mc_sgv_categoria_produto (
    cd_categoria_produto NUMBER(4)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    ds_categoria         VARCHAR2(30) NOT NULL,
    dt_inicio            DATE NOT NULL,
    dt_termino           DATE NULL,
    st_categoria         CHAR(1) NOT NULL
); 
-- CRIACAO TABELA ESTADO
CREATE TABLE t_mc_sgv_estado (
    cd_estado NUMBER(4)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    nm_estado VARCHAR2(30) NOT NULL
);
    
 
-- CRIACAO BAIRRO
CREATE TABLE t_mc_sgv_bairro (
    cd_bairro      NUMBER(8)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_cidade      NUMBER(8) NOT NULL,
    nm_bairro      VARCHAR2(45),
    nm_zona_bairro VARCHAR2(20)
); 

-- CRIACAO TABELA LOGRADOURO
CREATE TABLE t_mc_sgv_logradouro (
    cd_logradouro NUMBER(10)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_bairro     NUMBER(8) NOT NULL,
    nm_logradouro VARCHAR2(160) NOT NULL,
    nr_cep        NUMBER(8) NOT NULL
); 
    
-- CRIACAO TABELA CIDADE
CREATE TABLE t_mc_sgv_cidade (
    cd_cidade NUMBER(8)
        GENERATED ALWAYS AS IDENTITY
    NOT NULL,
    cd_estado NUMBER(4) NOT NULL,
    nm_cidade VARCHAR2(60) NOT NULL,
    cd_ibge   NUMBER(8),
    nr_ddd    NUMBER(3)
); 


-- *******DEFINICAO DE CHAVE PRIMARIA*******

-- PK TABELA SAC
ALTER TABLE t_mc_sgv_sac ADD CONSTRAINT pk_mc_sgv_sac PRIMARY KEY ( nr_chamado );
    
-- PK TABELA FUNCIONARIO
ALTER TABLE t_mc_sgv_funcionario ADD CONSTRAINT pk_mc_funcionario PRIMARY KEY ( cd_funcionario );
    
 -- PK TABELA ENDERECO FUNCIONRIO
ALTER TABLE t_mc_sgv_end_func ADD CONSTRAINT pk_mc_end_func PRIMARY KEY ( nr_end );
    
-- PK TABELA DEPARTAMENTO
ALTER TABLE t_mc_sgv_depto ADD CONSTRAINT pk_mc_depto PRIMARY KEY ( cd_depto );

-- PK TABELA CLIENTE
ALTER TABLE t_mc_sgv_cliente ADD CONSTRAINT pk_sgv_cliente PRIMARY KEY ( nr_cliente );
    
-- PK TABELA CLIENTE PESSOA FISICA
ALTER TABLE t_mc_sgv_cli_fisica ADD CONSTRAINT pk_sgv_cli_fisica PRIMARY KEY ( nr_cliente );
    
-- PK TABELA CLIENTE PESSOA JURIDICA

ALTER TABLE t_mc_sgv_cli_juridica ADD CONSTRAINT pk_sgv_cli_juridica PRIMARY KEY ( nr_cliente );
    
-- PK TABELA VISUALIZACAO VIDEO
ALTER TABLE t_mc_sgv_visualizacao_video ADD CONSTRAINT pk_sgv_visualizacao_video PRIMARY KEY ( cd_visualizacao );
    
-- PK TABELA VIDEO PRODUTO
ALTER TABLE t_mc_sgv_video_produto ADD CONSTRAINT pk_sgv_video_produto PRIMARY KEY ( cd_video );
    
-- PK TABELA CLASSIFICACAO VIDEO
ALTER TABLE t_mc_sgv_classificacao_video ADD CONSTRAINT pk_classificacao_video PRIMARY KEY ( cd_classificacao_video );

-- PK TABELA PRODUTO
ALTER TABLE t_mc_sgv_produto ADD CONSTRAINT pk_sgv_produto PRIMARY KEY ( cd_produto );
    
-- PK TABELA CATEGORIA PRODUTO
ALTER TABLE t_mc_sgv_categoria_produto ADD CONSTRAINT pk_sgv_categoria_prod PRIMARY KEY ( cd_categoria_produto );
    
-- PK TABELA ESTADO
ALTER TABLE t_mc_sgv_estado ADD CONSTRAINT pk_t_mc_sgv_estado PRIMARY KEY ( cd_estado ); 
    
-- PK TABELA ENDERECO CLIENTE 
ALTER TABLE t_mc_sgv_end_cli ADD CONSTRAINT pk_t_mc_sgv_end_cli PRIMARY KEY ( nr_end ); 
    
-- PK BAIRRO
ALTER TABLE t_mc_sgv_bairro ADD CONSTRAINT pk_t_mc_sgv_bairro PRIMARY KEY ( cd_bairro ); 

    
-- PK TABELA LOGRADOURO
ALTER TABLE t_mc_sgv_logradouro ADD CONSTRAINT pk_t_mc_sgv_logradouro PRIMARY KEY ( cd_logradouro ); 

    
-- PK TABELA CIDADE
ALTER TABLE t_mc_sgv_cidade ADD CONSTRAINT pk_t_mc_sgv_cidade PRIMARY KEY ( cd_cidade ); 



-- *******RESTRIOES DE CONTEUDO*******

-- RESTRICAO TABELA SAC
ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT ck_mc_sgv_sac_tp_chamado CHECK ( tp_chamado IN ( 'R', 'S' ) );

ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT ck_mc_sgv_sac_st_chamado CHECK ( st_chamado IN ( 'E', 'C', 'F', 'X' ) );

ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT ck_mc_sgv_sac_nr_indice_satisfacao CHECK ( nr_indice_satisfacao BETWEEN 1 AND 10 );
  

-- RESTRICAO TABELA FUNCIONARIO
ALTER TABLE t_mc_sgv_funcionario ADD CONSTRAINT un_mc_nr_cpf UNIQUE ( nr_cpf );

ALTER TABLE t_mc_sgv_funcionario
    ADD CONSTRAINT ck_mc_sgv_sac_st_func CHECK ( st_func IN ( 'A', 'I' ) );

-- RESTRICAO END CLI
ALTER TABLE t_mc_sgv_end_cli
    ADD CONSTRAINT ck_mc_sgv_end_cli CHECK ( st_end IN ( 'A', 'I' ) );
     
-- RESTRICAO END FUNC    

ALTER TABLE t_mc_sgv_end_func
    ADD CONSTRAINT ck_mc_sgv_end_func CHECK ( st_end IN ( 'A', 'I' ) );

-- RESTRICAO CLASSIFICACAO VIDEO

ALTER TABLE t_mc_sgv_classificacao_video ADD CONSTRAINT un_sgv_class_video_tp_video UNIQUE ( tp_video );


-- RESTRICAO PRODUTO
ALTER TABLE t_mc_sgv_produto ADD CONSTRAINT un_sgv_produto_ds_normal_produto UNIQUE ( ds_normal_produto );

ALTER TABLE t_mc_sgv_produto
    ADD CONSTRAINT ck_produto_st_produto CHECK ( st_produto IN ( 'A', 'I' ) );

ALTER TABLE t_mc_sgv_video_produto
    ADD CONSTRAINT ck_mc_video_produto_st_video CHECK ( st_video IN ( 'A', 'I' ) );

-- RESTRICAO CATEGORIA PRODUTO

ALTER TABLE t_mc_sgv_categoria_produto ADD CONSTRAINT un_sgv_categoria_prod_ds_categoria UNIQUE ( ds_categoria );

ALTER TABLE t_mc_sgv_categoria_produto
    ADD CONSTRAINT ck_mc_sgv_categoria_produto_st_categoria CHECK ( st_categoria IN ( 'A', 'I' ) );
    
-- RESTRICAO DPTO
ALTER TABLE t_mc_sgv_depto
    ADD CONSTRAINT ck_mc_sgv_depto CHECK ( st_depto IN ( 'A', 'I' ) );

-- RESTRICAO VIDEO PRODUTO
ALTER TABLE t_mc_sgv_video_produto
    ADD CONSTRAINT ck_mc_sgv_video_produto_st_video CHECK ( st_video IN ( 'A', 'I' ) );

-- RESTRICAO CLIENTE
ALTER TABLE t_mc_sgv_cliente
    ADD CONSTRAINT ck_mc_sgv_cliente_st_cliente CHECK ( st_cliente IN ( 'A', 'I' ) );

-- CRIACAO CHAVES ESTRANGEIRAS


-- FK SAC CLIENTE
ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT fk_mc_sgc_sac_cliente FOREIGN KEY ( nr_cliente )
        REFERENCES t_mc_sgv_cliente ( nr_cliente );
    

-- FK SAC FUNCIONARIO    
ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT fk_mc_sgc_sac_funcionario FOREIGN KEY ( cd_funcionario )
        REFERENCES t_mc_sgv_funcionario ( cd_funcionario );

-- FK SAC PRODUTO
ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT fk_mc_sgc_sac_produto FOREIGN KEY ( cd_produto )
        REFERENCES t_mc_sgv_produto ( cd_produto );
   

-- FK FUNCIONARIO DPTO   
ALTER TABLE t_mc_sgv_funcionario
    ADD CONSTRAINT fk_mc_funcionario_departamento FOREIGN KEY ( cd_depto )
        REFERENCES t_mc_sgv_depto ( cd_depto );

-- FK FUNCIONARIO GERENTE
ALTER TABLE t_mc_sgv_funcionario
    ADD CONSTRAINT fk_mc_funcionario_funcionario FOREIGN KEY ( cd_gerente )
        REFERENCES t_mc_sgv_funcionario ( cd_funcionario );
  
    
-- FK END LOGRADOURO
ALTER TABLE t_mc_sgv_end_func
    ADD CONSTRAINT fk_mc_end_func_logradouro FOREIGN KEY ( cd_logradouro )
        REFERENCES t_mc_sgv_logradouro ( cd_logradouro );
    

-- FK END FUNCIONARIO   
ALTER TABLE t_mc_sgv_end_func
    ADD CONSTRAINT fk_mc_end_func_funcionario FOREIGN KEY ( cd_funcionario )
        REFERENCES t_mc_sgv_funcionario ( cd_funcionario );
    

-- FK CLI FISICA CLIENTE FISICA    
ALTER TABLE t_mc_sgv_cli_fisica ADD CONSTRAINT fk_sgv_cli_fisica FOREIGN KEY ( nr_cliente )
    REFERENCES t_mc_sgv_cliente;

-- FK CLI JURIDICA CLIENTE JURIDICA
ALTER TABLE t_mc_sgv_cli_juridica ADD CONSTRAINT fk_sgv_cliente_juridica FOREIGN KEY ( nr_cliente )
    REFERENCES t_mc_sgv_cliente;

-- FK VISUALIZACAO VIDEO CLIENTE
ALTER TABLE t_mc_sgv_visualizacao_video ADD CONSTRAINT fk_sgv_visualizacao_video_cliente FOREIGN KEY ( nr_cliente )
    REFERENCES t_mc_sgv_cliente;

-- FK VISUALIZACAO VIDEO VIDEO PRODUTO
ALTER TABLE t_mc_sgv_visualizacao_video ADD CONSTRAINT fk_sgv_visualizacao_video_video_produto FOREIGN KEY ( cd_video )
    REFERENCES t_mc_sgv_video_produto;

-- FK VISUALIZACAO VIDEO PRODUTO
ALTER TABLE t_mc_sgv_visualizacao_video ADD CONSTRAINT fk_sgv_visualizacao_video_produto FOREIGN KEY ( cd_produto )
    REFERENCES t_mc_sgv_produto;

-- FK VIDEO PRODUTO CLASSIFICACAO VIDEO
ALTER TABLE t_mc_sgv_video_produto
    ADD CONSTRAINT fk_sgv_video_prod_class_video FOREIGN KEY ( cd_classificacao_video )
        REFERENCES t_mc_sgv_classificacao_video ( cd_classificacao_video );

-- FK VIDEO PRODUTO PRODUTO
ALTER TABLE t_mc_sgv_video_produto
    ADD CONSTRAINT fk_sgv_video_produto_produto FOREIGN KEY ( cd_produto )
        REFERENCES t_mc_sgv_produto ( cd_produto ); 

-- FK PRODUTO CATEGORIA
ALTER TABLE t_mc_sgv_produto
    ADD CONSTRAINT fk_sgv_prod_categ_prod FOREIGN KEY ( cd_categoria_produto )
        REFERENCES t_mc_sgv_categoria_produto ( cd_categoria_produto );

-- FK CIDADE ESTADO
ALTER TABLE t_mc_sgv_cidade
    ADD CONSTRAINT fk_mc_cidade_estado FOREIGN KEY ( cd_estado )
        REFERENCES t_mc_sgv_estado ( cd_estado ); 

-- FK LOGRADOURO BAIRRO
ALTER TABLE t_mc_sgv_logradouro
    ADD CONSTRAINT fk_t_mc_sgv_logradouro_bairro FOREIGN KEY ( cd_bairro )
        REFERENCES t_mc_sgv_bairro ( cd_bairro ); 
        
        
-- FK END CLI CLIENTE
ALTER TABLE t_mc_sgv_end_cli
    ADD CONSTRAINT fk_t_mc_sgv_end_cli_cliente FOREIGN KEY ( nr_cliente )
        REFERENCES t_mc_sgv_cliente ( nr_cliente );   

--FK END CLI LOGRADOURO

ALTER TABLE t_mc_sgv_end_cli
    ADD CONSTRAINT fk_t_mc_sgv_end_cli_logradouro FOREIGN KEY ( cd_logradouro )
        REFERENCES t_mc_sgv_logradouro ( cd_logradouro );
        
        
-- FK BAIRRO CIDADE
ALTER TABLE t_mc_sgv_bairro
    ADD CONSTRAINT fk_t_mc_sgv_bairro_cidade FOREIGN KEY ( cd_cidade )
        REFERENCES t_mc_sgv_cidade ( cd_cidade );

-- COMENTARIOS TABLEAS
COMMENT ON TABLE t_mc_sgv_estado IS
    'Estado  associado à cidade  em que uma cidade pertence a um único estado. E um esado  possui muitas cidades.';

COMMENT ON TABLE t_mc_sgv_cidade IS
    'Cidade associado ao  bairro  em que uma  cidade  possui muitos bairros. E um bairro possui uma cidade.';

COMMENT ON TABLE t_mc_sgv_bairro IS
    'Bairro associado ao logradouro em que um bairro possui muitos logradouros.';
    
COMMENT ON TABLE t_mc_sgv_logradouro IS
    'Logradouro associado ao endere�o, tando de um funcion�rio quanto de um cliente.';
    
COMMENT ON TABLE t_mc_sgv_end_func IS
    'Entidade associativa utilizada para armazenas os m�ltiplos endere�os que um funcionario  pode ter.';
    
COMMENT ON TABLE t_mc_sgv_depto IS
    'Entidade destinada a agrupar os funcion�rios por departamento atrav�s de um relacionamento muitos para muitos.';
    
COMMENT ON TABLE t_mc_sgv_depto IS
    'Funcion�rio que atende os chamados realizados pelos clientes.';

COMMENT ON TABLE t_mc_sgv_end_cli IS
    'Entidade associativa utilizada para armazenas os m�ltiplos endere�os que um cliente pode ter.';
    
COMMENT ON TABLE t_mc_sgv_sac IS
    'Armazenar informa��es relacionadas �s intera��es dos clientes com a empresa. Cada intera��o � um Chamado e � identificada por um n�mero �nico de SAC.';

COMMENT ON TABLE t_mc_sgv_produto IS
    'Objetos dispon�veisna plataforma. Necessitam de uma valida��o de disponibilidade atrav�s do atributo: status do produto.';

COMMENT ON TABLE t_mc_sgv_categoria_produto IS
    'Entidade destinada a classificar os produtos por categorias com um nome e uma desri��o �nica.';
    
COMMENT ON TABLE t_mc_sgv_classificacao_video IS
    'Classifica��o dos produtos. � um fator de convers�o de vendas ajudando noranqueamento de sites.';
    
COMMENT ON TABLE t_mc_sgv_video_produto IS
    'S�o v�deos disponiblizados pela �rea de neg�cio e est�o associados aos  produtos.  Um produto pode ter v�rios v�deos e um v�deo possui status (ativo ou inativo)';

COMMENT ON TABLE t_mc_sgv_video_produto IS
    'Entidade usada para quardar informa��es da visualiza��o do v�deo, bem como produto visualizado e o cliente logado que gerou a visualizac�o.';


-- COMENTARIOS CAMPOS

COMMENT ON COLUMN t_mc_sgv_estado.cd_estado IS
    'chave primária incrementada por um identity que gera automaticamente uma sequência no banco de dados';

COMMENT ON COLUMN t_mc_sgv_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado contendo apenas 2 caracteres ex: SP. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN t_mc_sgv_estado.nm_estado IS
    'Esta coluna irá receber o nome do estado iniciando com letra Maíuscula';

COMMENT ON COLUMN t_mc_sgv_cidade.cd_cidade IS
    'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório. Chave primária incrementada por um identity que gera automaticamente uma sequência no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_cidade.cd_estado IS
    'Chave estrangeira referenciando a chave primária da entidade estado, ondeo relacionamento 1:N é estabelecido entre cidade e estado'
    ;

COMMENT ON COLUMN t_mc_sgv_cidade.nm_cidade IS
    'Esta coluna ira receber o nome da Cidade. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN t_mc_sgv_cidade.cd_ibge IS
    'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.';

COMMENT ON COLUMN t_mc_sgv_cidade.nr_ddd IS
    'Esta coluna irá receber o número do DDD da cidade para ser utilizado no contato telefônico. Seu conteudo é opcional.';


COMMENT ON COLUMN t_mc_sgv_bairro.cd_bairro IS
    'Esta coluna ir� receber o codigo do bairro e seu conte�do � obrigat�rio. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_bairro.cd_cidade IS
    'Chave estrangeira referenciando a chave [rim�ria da entidade cidade';

COMMENT ON COLUMN t_mc_sgv_bairro.nm_bairro IS
    'Esta coluna ira receber o nome do Bairro. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_bairro.nm_zona_bairro IS
    'Esta coluna ir� receber a localiza��o da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.'
    ;

COMMENT ON COLUMN t_mc_sgv_logradouro.cd_logradouro IS
    'Esta coluna ir� receber o c�digo do logradouro e seu conte�do � obrigat�rio. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_logradouro.cd_bairro IS
    'Chave estrangeira referenciando � tabela Bairro, na qual � estabelecido o relacionamento 1:N';

COMMENT ON COLUMN t_mc_sgv_logradouro.nm_logradouro IS
    'Esta coluna ir� receber o nome do logradouro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_logradouro.nr_cep IS
    'Esta coluna ir� receber o numero do CEP do Logradouro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_end_func.nr_end IS
    'N�mero do Endere�o do Cliente. O n�mero da Rua/Localidade onde o cliente est� associado. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_end_func.cd_logradouro IS
    'Chave estrangeira que recebe o c�digo do logradouro associado ao endereco, ';

COMMENT ON COLUMN t_mc_sgv_end_func.cd_funcionario IS
    'Chave estrangeira que recebe o c�digo do funcionario associado, criando o relacionamento 1:n de funcionario e endereco.';

COMMENT ON COLUMN t_mc_sgv_end_func.ds_complemento_end IS
    'Comlemento opicional do endere�o, indicando um ponto de refer�ncia.';

COMMENT ON COLUMN t_mc_sgv_end_func.dt_inicio IS
    'Data de in�cio do endere�o associado ao cliente.';

COMMENT ON COLUMN t_mc_sgv_end_func.dt_termino IS
    'Data de t�rmino do endere�o associado ao cliente.';

COMMENT ON COLUMN t_mc_sgv_end_func.st_end IS
    'Status do entere�o do cliente, permitindo apenas (A)tivo ou (I)nativo';
    
COMMENT ON COLUMN t_mc_sgv_depto.cd_depto IS
    'Esta coluna ir� receber o codigo do departamento  e seu conte�do � obrigat�rio. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_depto.nm_depto IS
    'Esta coluna ir� receber o nome do  departamento  e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_depto.st_depto IS
    'Esta coluna ir� receber o status do  departamento  e seu conte�do � obrigat�rio. Os valores poss�veis s�o: (A)tivo e (I)nativo.'
    ;
COMMENT ON COLUMN t_mc_sgv_funcionario.cd_funcionario IS
    'Esta coluna ir� receber o codigo do funcion�rio e seu conte�do � obrigat�rio. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_funcionario.cd_gerente IS
    'C�digo  do gerente que  pode gerenciar um ou mais funcionarios';

COMMENT ON COLUMN t_mc_sgv_funcionario.cd_depto IS
    'C�digo do  departaamento ao qual o funcion�rio faz parte';

COMMENT ON COLUMN t_mc_sgv_funcionario.nm_funcionario IS
    'Esta coluna ir� receber o nome do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_funcionario.nr_cpf IS
    'Coluna destinada  � armezena o numero do CPF no formato:12345678911';

COMMENT ON COLUMN t_mc_sgv_funcionario.dt_nascimento IS
    'Esta coluna ir� receber a data de nascimento  do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_funcionario.nm_telefone IS
    'TELEFONE COM DDD APENAS N�MEROS';

COMMENT ON COLUMN t_mc_sgv_funcionario.ds_email IS
    'Esta coluna ir� receber o email do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_sgv_funcionario.ds_cargo IS
    'Esta coluna ir� receber o cargo do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_sgv_funcionario.vl_salario IS
    'Esta coluna ir� receber o valor do sal�rio do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_sgv_funcionario.st_func IS
    'Essa coluna ir� armazenar o stauts do funcion�rio da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN t_mc_sgv_funcionario.dt_cadastramento IS
    'Data de cadastramento do Funcionario  que cria a ideia de ger�ncia';

COMMENT ON COLUMN t_mc_sgv_funcionario.dt_desligamento IS
    'Data de desligamento  do Funcionario. Seu conte�do � opcional. ';
    
COMMENT ON COLUMN t_mc_sgv_sac.nr_chamado IS
    'Esse atributo ir� armazenar a chave prim�ria da tabela de SAC de v�deo  da Melhorees Compras. A cada SAC cadastrado pelo cliente ser� acionada a identity  que se encarregar� de gerar o pr�ximo n�mero �nico do chamado SAC feito pelo Cliente. Tamanho m�ximo � 10. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_sac.cd_funcionario IS
    'Esta coluna ir� receber o codigo do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_sac.cd_produto IS
    'Chave estrangeira que referencia o codigo do produto que est� associado o cahado';

COMMENT ON COLUMN t_mc_sgv_sac.nr_cliente IS
    'Chave etrangeira do cliente logado que abrir o chamado';

COMMENT ON COLUMN t_mc_sgv_sac.ds_detalhada_cliente IS
    'Essa coluna  ir�  receber a descri��o completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio e de tamanho 4.000.
';

COMMENT ON COLUMN t_mc_sgv_sac.dt_abertura_chamado IS
    'Essa coluna  ir�  receber a data e hor�rio do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_sac.dt_atendimento IS
    'Essa coluna  ir�  receber a data e hor�rio do atendmiento SAC feita pelo funcion�rio da Melhores Compras. Seu conteudo deve ser opcional..'
    ;

COMMENT ON COLUMN t_mc_sgv_sac.dt_minutos_atendimento IS
    'Todo chamado deve ter o tempo total de atendimento computado desde a abertura at� a conclus�o dele. A unidade de medida � horas, ou seja, em quantas horas o chamado foi conclu�do desde a sua abertura'
    ;

COMMENT ON COLUMN t_mc_sgv_sac.nr_tempo_total_sac IS
    'Essa coluna  ir�  receber o tempo total em horas  (HH24) computado desde a abertura at� a conclus�o dele. A unidade de medida � horas, ou seja, em quantas horas o chamado foi conclu�do desde a sua abertura.'
    ;

COMMENT ON COLUMN t_mc_sgv_sac.ds_detalhada_retorno_sac IS
    'Essa coluna  ir�  receber a descri��o detalhada do retorno feito pelo funcion�rio a partir da solicita��o do cliente. Seu conte�do deve ser opcional e preenchido pelo funcion�rio.'
    ;

COMMENT ON COLUMN t_mc_sgv_sac.tp_chamado IS
    'Essa coluna  ir�  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: (S)ugest�o ou (R)eclama��o.'
    ;

COMMENT ON COLUMN t_mc_sgv_sac.st_chamado IS
    'Essa coluna  ir�  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: (A)berto; (E)m Atendimento; (C)ancelado; (F)echado ou (X)Fechado com Insatisfa��o do cliente.'
    ;

COMMENT ON COLUMN t_mc_sgv_sac.nr_indice_satisfacao IS
    'Essa coluna  ir�  receber o �ndice de satisfa��o, computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse �ndice de satisfa��o � opcional e informado pelo cliente ao final do atendimento.'
    ;
COMMENT ON COLUMN t_mc_sgv_end_cli.nr_end IS
    'N�mero do Endere�o do Cliente. O n�mero da Rua/Localidade onde o cliente est� associado. Utilizado para garantir a unicidade da linhas'
    ;

COMMENT ON COLUMN t_mc_sgv_end_cli.cd_logradouro IS
    'Essa coluna recebe a chave prim�ria da tabela logradouro ';

COMMENT ON COLUMN t_mc_sgv_end_cli.nr_cliente IS
    'chave estrangeira referenciando a chave prim�ria da tabela cliente';

COMMENT ON COLUMN t_mc_sgv_end_cli.ds_complemento_end IS
    'Esta coluna ir� receber o complemento do endere�o do cliente e seu conte�do pode ser opcional.';

COMMENT ON COLUMN t_mc_sgv_end_cli.dt_inicio IS
    'Data de in�cio do endere�o associado ao cliente.';

COMMENT ON COLUMN t_mc_sgv_end_cli.dt_termino IS
    'Data de t�rmino do endere�o associado ao cliente.';

COMMENT ON COLUMN t_mc_sgv_end_cli.st_end IS
    'Status do endere�o. (A)itvo ou (I)nativo.';

COMMENT ON COLUMN t_mc_sgv_cliente.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir de uma identity que ir� gerar os valores �nicos automaticamente'
    ;

COMMENT ON COLUMN t_mc_sgv_cliente.nm_cliente IS
    'Essa coluna ir� armazenar o nome do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_cliente.st_cliente IS
    'Essa coluna ir� armazenar o stauts do cliente da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN t_mc_sgv_cliente.dt_nasc IS
    'data de nascimento obrigat�ria';

COMMENT ON COLUMN t_mc_sgv_cliente.nm_login IS
    'Essa coluna ir� armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conte�do deve ser obrigat�rio e  �nico para cada cliente.'
    ;

COMMENT ON COLUMN t_mc_sgv_cliente.ds_senha IS
    'Essa coluna ir� armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

COMMENT ON COLUMN t_mc_sgv_cliente.fl_sexo_biologico IS
    'Esta coluna ir� receber o sexo biol�gico do funcion�rio e seu conte�do � obrigat�rio.Os valores permitidos aqui seriam: (F)eminino e (M)asculino. '
    ;

COMMENT ON COLUMN t_mc_sgv_cliente.qt_estrelas IS
    'Essa coluna ir� armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio e ser poss�vel de estar entre 1 e 5 estrelas.'
    ;

COMMENT ON COLUMN t_mc_sgv_cliente.nr_telefone IS
    'Essa coluna ir� armazenar o n�mero do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pr� definida.'
    ;

COMMENT ON COLUMN t_mc_sgv_cliente.ds_email IS
    'Essa coluna ir� armazenar o email  do cliente da Melhorees Compras. No minimo � esperado um email contendo o caractere (@) em seu conte�do.'
    ;

COMMENT ON COLUMN t_mc_sgv_cliente.vl_medio_compra IS
    'Essa coluna ir� armazenar o valor  m�dio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio e deve ser calculado diariamente.'
    ;
    
COMMENT ON COLUMN t_mc_sgv_cli_fisica.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da tabela NC_CLIENTE. Valor salvo somente em numeros.'
    ;

COMMENT ON COLUMN t_mc_sgv_cli_fisica.dt_nascimento IS
    'Essa coluna ir� armazenar a data de nascimento do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio. '
    ;

COMMENT ON COLUMN t_mc_sgv_cli_fisica.nr_cpf IS
    'Essa coluna ir� armazenar o n�mero do CPF do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio. '
    ;
    
COMMENT ON COLUMN t_mc_sgv_cli_juridica.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da tabela NC_CLIENTE. '
    ;

COMMENT ON COLUMN t_mc_sgv_cli_juridica.dt_fundacao IS
    'Essa coluna ir� armazenar data  de funda��o do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

COMMENT ON COLUMN t_mc_sgv_cli_juridica.nr_cnpj IS
    'Essa coluna ir� armazenar o  numero do CNPJ do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

COMMENT ON COLUMN t_mc_sgv_cli_juridica.nr_inscr_est IS
    'Essa coluna ir� armazenar o  numero da Inscri��o Estadual  do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser opcional'
    ;
    
COMMENT ON COLUMN t_mc_sgv_visualizacao_video.cd_visualizacao IS
    'Ch�ve prim�ria que garante a unicidade de todas as linhas. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.cd_video IS
    'Chave estrangeira referenciando � chave prim�ria  de v�deo  produto, onde uma visualiza��o deve estar associada a um �nico produto.'
    ;

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.cd_produto IS
    'Armazena a informa��o do produto visualizado atrav�s do relacionamento 1:1 em que a entidade produto � dominante.';

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.nr_cliente IS
    'Armazenar a informa��o do cliente  se o seu login for vlidado na plataforma atrav�s das camadas de apresenta��o; se o valor for nullo, o cliente estava deslogado, portanto a informa��o n�o foi persistida.
';

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.dt_visualizacao IS
    'Armazenar Data, hora minuto e segundo da visualizacao do video';
    
COMMENT ON COLUMN t_mc_sgv_video_produto.cd_video IS
    'Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados';

COMMENT ON COLUMN t_mc_sgv_video_produto.cd_produto IS
    'C�digo do produto associado ao produto';

COMMENT ON COLUMN t_mc_sgv_video_produto.cd_classificacao_video IS
    'Chve estrangeira que referencia a chave primaria da classificacao  do video, gerando assim uma classificacao para o video.';

COMMENT ON COLUMN t_mc_sgv_video_produto.dt_cadastro IS
    'Campo utrilizado para guardar a informa��o do video utilizado';

COMMENT ON COLUMN t_mc_sgv_video_produto.st_video IS
    'Status do video. Deve ser restringido como ((a)tivo ou (i)nativo)';
    
COMMENT ON COLUMN t_mc_sgv_classificacao_video.cd_classificacao_video IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de classificacao  videos da Melhorees Compras. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_classificacao_video.tp_video IS
    'Tipo de classificacao de video que podem ser: Video de instala��o do produto; uso no cotidiano; Comercial com personlidad, entre outros.'
    ;

COMMENT ON COLUMN t_mc_sgv_categoria_produto.cd_categoria_produto IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de categoria de produtos da Melhorees Compras. Chave prim�ria incrementada por um identity que gera automaticamente uma sequ�ncia no banco de dados'
    ;

COMMENT ON COLUMN t_mc_sgv_categoria_produto.ds_categoria IS
    'Essa coluna ir� armazenar descri��o da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descri��o �nica e serve para organizar os produtos em categorias simliares, melhorando a tomada de decis�o.'
    ;

COMMENT ON COLUMN t_mc_sgv_categoria_produto.dt_inicio IS
    'Essa coluna ir� receber  a data de in�cio da categoria. Seu formato � dd/mm/yyyy e seu conte�do deve ser sempre  obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_categoria_produto.dt_termino IS
    'Essa coluna ir� receber  a data de encerramento  da categoria. Seu formato � dd/mm/yyyy e seu conte�do deve ser sempre  opcional. Conte�do obrigat�rio significa que a categoria foi encerrada a partir da data t�rmino. J� o conte�do opcional indica que a categoria est� ativa e operante.'
    ;

COMMENT ON COLUMN t_mc_sgv_categoria_produto.st_categoria IS
    'Essa coluna ir� armazenar o stauts da categoria da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

