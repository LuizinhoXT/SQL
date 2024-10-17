
-- Recupera a implantação com maior tempo de uração em dias
select
    CONCAT(MAX(i.dt_saida- i.dt_entrada) , ' dias')  AS temp_duracao
from 
    t_sip_implantacao i;
    
-- Recupera a média salarial por departamento
select
    dp.cd_depto,
    dp.nm_depto,
    round(avg(fn.vl_salario_mensal), 2) as media_salarial
from
    t_sip_departamento dp
inner
    join t_sip_funcionario fn on (dp.cd_depto = fn.cd_depto)
group by 
    dp.cd_depto,
    dp.nm_depto;
    
-- Recupera a quantidade de implantações por projeto
select
    p.cd_projeto,
    p.nm_projeto,
    count(i.cd_implantacao) as qtde_implantacoes_totais
from
    t_sip_projeto p
right
    join t_sip_implantacao i on (p.cd_projeto = i.cd_projeto)
group by
    p.cd_projeto,
    p.nm_projeto;

-- Recupera a quantidade de implantações por projeto em andamento
select
    p.cd_projeto,
    p.nm_projeto,
    count(i.cd_implantacao) as qtde_implantacoes_em_andamento
from
    t_sip_projeto     p
right 
    join t_sip_implantacao i on ( p.cd_projeto = i.cd_projeto)    
where
    i.dt_saida is null
group by
    p.cd_projeto,
    p.nm_projeto
order by
    p.cd_projeto;
    
-- Recupera a quantidade de implantaçõe por projetos finalizados
select
    p.cd_projeto,
    p.nm_projeto,
    count(i.cd_implantacao) as qtde_implantacoes_finalizadas
from
    t_sip_projeto     p
right 
    join t_sip_implantacao i on ( p.cd_projeto = i.cd_projeto)    
where
    i.dt_saida is not null
group by
    p.cd_projeto,
    p.nm_projeto
order by
    p.cd_projeto;
    
-- Recupera a quantidade implantações por funcionaro
select
    f.nr_matricula,
    f.nm_funcionario,
    count(i.cd_implantacao) as qtde_implantacoes_func
from 
    t_sip_funcionario f
inner 
    join t_sip_implantacao i on ( f.nr_matricula = i.nr_matricula)
group by
    f.nr_matricula,
    f.nm_funcionario
order by 
    f.nr_matricula;

  