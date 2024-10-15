create table t_cliente (
    nr_cliente number (4) not null,
    ds_nome VARCHAR2 (30) NOT NULL,
 CONSTRAINT pk_cliente PRIMARY KEY (nr_cliente)   
 );

create table t_end_cli (
    nr_end_cli number (4) not null,
    cd_logradouro number (4) NOT NULL,
    nr_cliente number (4) not null,
    ds_complemento varchar (20) not null,
CONSTRAINT pk_end_cli PRIMARY KEY (nr_end_cli)   
);

 create table t_logradouro (
    cd_logradouro number (4) NOT NULL,
    nm_logradouro VARCHAR2 (20) not null,
CONSTRAINT pk_logradouro PRIMARY KEY (cd_logradouro)   
)

alter table t_end_cli add constraint fk_end_cli_logradouro FOREIGN KEY (cd_logradouro) REFERENCES t_logradouro (cd_logradouro)

alter table t_end_cli add constraint fk_end_cli_cliente FOREIGN KEY (nr_cliente) REFERENCES t_cliente (nr_cliente)


