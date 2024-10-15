DROP TABLE t_slv_categorua CASCADE CONSTRAINTS;
DROP TABLE t_slv_autor CASCADE CONSTRAINTS;    


-- CIRÇÃO DAS TABELAS    
CREATE TABLE t_slv_categoria (
    cd_categoria       NUMBER(3)
        GENERATED ALWAYS AS IDENTITY,
    ds_sigla_categoria CHAR(13) NOT NULL,
    ds_categoria       VARCHAR2(30) NOT NULL
);

    CREATE TABLE t_slv_autor (
        cd_autor          NUMBER(3)
            GENERATED ALWAYS AS IDENTITY,
        nm_primeiro_autor VARCHAR2(40) NOT NULL,
        nm_segundo_autor  VARCHAR2(40) NOT NULL
    );


-- CHAVE PRIMÁRIA

-- tabela categoria
    ALTER TABLE t_slv_categoria ADD CONSTRAINT pk_slv_categoria_cd_categoria PRIMARY KEY  (cd_categoria);

-- tabela autor
    ALTER TABLE t_slv_autor ADD CONSTRAINT pk_slv_autor_cd_autor PRIMARY KEY (cd_autor);

-- RESTRIÇãO DE CONTEÚDO

-- UNIQUE categoria sigla categoria
    ALTER TABLE t_slv_categoria ADD CONSTRAINT un_slv_categoria_sigla UNIQUE (ds_sigla_categoria);

-- UNIQUE categoria descricao categoria
    ALTER TABLE t_slv_categoria ADD CONSTRAINT un_slv_categoria_descricao UNIQUE (ds_categoria);
