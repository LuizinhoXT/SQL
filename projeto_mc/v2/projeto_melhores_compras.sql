CREATE TABLE t_mc_video_produto(
    cd_video NUMBER(4) NOT NULL, 
    cd_produto NUMBER(10) NOT NULL, --ok
    cd_categoria_video NUMBER(4) NOT NULL, --ok
    dt_cadastro DATE NOT NULL,
    st_video CHAR(1) NOT NULL

);

--TABELA DEPENDENTE
CREATE TABLE t_mc_categoria_video (
    cd_categoria_video NUMBER(4) NOT NULL,
    tp_video VARCHAR2(30) NOT NULL,
    ds_categoria VARCHAR2(50) NOT NULL,
    dt_inicio_categoria DATE NOT NULL,
    dt_termino_categoria DATE NULL,
    st_categoria CHAR(1) NOT NULL  
);


CREATE TABLE t_mc_produto (
    cd_produto NUMBER(10) NOT NULL,
    cd_categoria_produto NUMBER(4) NOT NULL,
    ds_normal_produto VARCHAR2(80) NOT NULL,
    ds_completa_produto VARCHAR2(4000) NOT NULL,
    nr_cd_barras_produto VARCHAR2(50) NULL,
    vl_unitario NUMBER(8,2) NOT NULL,
    tp_embalagem VARCHAR2(15) NULL,
    st_produto CHAR(1) NOT NULL,
    vl_preco_lucro NUMBER(8,2) NULL
);

--TABELA DEPENDENTE
CREATE TABLE t_mc_categoria_produto (
    cd_categoria_produto NUMBER(4) NOT NULL,
    tp_video VARCHAR2(30) NOT NULL,
    ds_categoria VARCHAR2(50) NOT NULL,
    dt_inicio_categoria DATE NOT NULL,
    dt_termino_categoria DATE NULL,
    st_categoria CHAR(1) NOT NULL  
);

-- ADICIONANDO PRIMARY KEY
ALTER TABLE t_mc_video_produto ADD CONSTRAINT pk_mc_video_produto PRIMARY KEY ( cd_video );
ALTER TABLE t_mc_categoria_video ADD CONSTRAINT pk_mc_categoria_video PRIMARY KEY ( cd_categoria_video ); 
ALTER TABLE t_mc_produto ADD CONSTRAINT pk_mc_produto PRIMARY KEY ( cd_produto );
ALTER TABLE t_mc_categoria_produto ADD CONSTRAINT pk_mc_categoria_produto PRIMARY KEY (cd_categoria_produto);



-- ADICIONANDO FOREING KEY
ALTER TABLE t_mc_video_produto ADD CONSTRAINT fk_mc_video_produto_categoria FOREIGN KEY ( cd_categoria_video ) REFERENCES t_mc_categoria_video (cd_categoria_video);
ALTER TABLE t_mc_video_produto ADD CONSTRAINT fk_mc_video_produto_produto FOREIGN KEY ( cd_produto ) REFERENCES t_mc_produto (cd_produto); 
ALTER TABLE t_mc_produto ADD CONSTRAINT fk_mc_produto_categoria_produto FOREIGN KEY ( cd_categoria_produto ) REFERENCES t_mc_categoria_produto (cd_categoria_produto);


-- ADICIONANDO CONSTRAINTS
ALTER TABLE t_mc_produto ADD CONSTRAINT un_mc_produto_normal_produto UNIQUE (ds_normal_produto);
ALTER TABLE t_mc_categoria_produto ADD CONSTRAINT un_mc_produto_categoria UNIQUE (ds_categoria);
ALTER TABLE t_mc_categoria_video ADD CONSTRAINT un_mc_categoria_video_categoria UNIque (ds_categoria);

ALTER TABLE t_mc_produto ADD CONSTRAINT ck_mc_produto_st_produto CHECK (ST_PRODUTO IN ( "A" , "I" , "P"));
ALTER TABLE t_mc_produto ADD CONSTRAINT ck_mc_video_produto_st_video CHECK (ST_VIDEO IN ("A" , "I"));
ALTER TABLE t_mc_categoria_video ADD CONSTRAINT ck_mc_categoria_video_st_categoria check (ST_CATEGORIA IN ('A','I'));
ALTER TABLE t_mc_categoria_produto ADD CONSTRAINT ck_mc_categoria_produto_st_categoria check (ST_CATEGORIA IN ('A','I'));