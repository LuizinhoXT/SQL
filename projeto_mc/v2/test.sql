CREATE TABLE t_mc_video_produto(
    cd_video NUMBER(4) NOT NULL,
    cd_produto NUMBER(10) NOT NULL,
    cd_categoria_produto NUMBER(4) NOT NULL,
    dt_cadastro DATE NOT NULL,
    st_video CHAR(1) NOT NULL

);

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

CREATE TABLE t_mc_categoria_produto (
    cd_categoria_produto NUMBER(4) NOT NULL,
    tp_video VARCHAR2(30) NOT NULL,
    ds_categoria VARCHAR2(50) NOT NULL,
    dt_inicio_categoria DATE NOT NULL,
    dt_termino_categoria DATE NULL,
    st_categoria CHAR(1) NOT NULL  
);