/*
    Todo select usa uma área de contexto onde temos: linhas processadas, um apontador e, para consultas, um conjunto ativo.
    O conjunto ativo é composto pelas linhas recuperadas na consulta.
*/

SELECT ename,job
FROM emp
where deptno = 20;

/*
    O CURSOR é o apondador da área ade contexto, permitindo permitindo a nomeação de uma instrução SQL.
    Também permite o acesso a infornação na área de contexto e, ate certo ponto, controle do proprocessamento.
    
    o CURSOR implícito não é declarado é é craido automaticamente para todas as intruções DDL, DML, DQL que retornam uma linha.
    Se a instrução retornar mais de uma linha, um erro será gerado
    

*/

DECLARE   
  emprec emp%rowtype; 
BEGIN 
SELECT SUM(sal)    
  INTO emprec.sal   
  FROM emp 
GROUP BY deptno;  
  dbms_output.put_line('Salario = ' || emprec.sal); 
END;

/*
    OUTPUT:
     - ORA-01422: a extração exata retorna mais do que o número solicitado de linhas
     = ORA-06512: em line 4
     
    Segundo a Oracle (2026), um CURSOR explícito deve ser declarado na área declarativa do Bloco Anônimo PL/SQL.
    Com o CURSOR declarado, podemos processar um conjunto ativo de várias linhas e colunas.
*/

BEGIN
   DELETE FROM emp
   WHERE deptno = 10;
   dbms_output.put_line('Linhas apagadas = ' || SQL%ROWCOUNT);
   ROLLBACK;
END;

-- ATRIBUTOS COMUNS AOS CURSORES EXPLÍCITOS E IMPLÍCITOS
-- %FOUND retorna verdadeiro (TRUE), caso alguma linha (tupla) tenha sido afetada. 
-- %ISOPEN retorna verdadeiro (TRUE), caso o CURSOR esteja aberto. 
-- %NOTFOUND retorna verdadeiro (TRUE), caso não tenha encontrado nenhuma tupla. Caso tenha encontrado, retornará falso (FALSE) até a última tupla. 
-- %ROWCOUNT retorna o númeoro de tuplas manipuladas pelo cursor

/*
    ETAPAS DE USO DO CURSOR
        - Declação do cursor na área declarativa;
        - Abertura do cursor na área de execução;
        - Recuperação das linhas através de um SELECT;
        - Verificaçãao dos términos da stuplas;
        - Fechamento do cursor
*/
declare
    emprec emp%rowtype; -- Conjunto que arameza linhas (tuplas)
    cursor cr_emp is -- Cursor declarado para armazenar informação do select
        select -- Seleciona os dados e os põe na área de contexto
            deptno, SUM(sal)
        from emp
       group by deptno;   
begin
    open cr_emp; -- Abertura do cursor
    loop -- Lop para extrair os dados sequencialment 
        FETCH cr_emp into emprec.deptno, emprec.sal; -- instrução de extração de dados
        exit when cr_emp%notfound; -- Condição de fechamento do loop, que é quando a próxima linha do cursos não existe.
        dbms_output.put_line
        ('Departamento: ' || emprec.deptno);
       dbms_output.put_line
        ('Salario     : ' || emprec.sal);
    end loop;
    close cr_emp; -- Fecha o cursor, mas a re-abertura pode ser feita em outro momento.
end;


/*
    INSTRUÇÃO FETCH :: RECUPERARAÇÃO DAS LINHAS DO CURSOR:
        - FETCH é o nome da instrução;
        - Após cada execução, o FETCH pula para a próxima linha do cojunto ativo salvo no CURSOR.
        - Possui variáveis para armazenar resultados individualmente.
        - Record_name é uma variável de registro que pode ser declarado usando o %rowtipe
        
    *Recupera as linhas de maneira sequencial.
*/

/* 
    Maneira simplificada de usar um  CURSOR
        - O CURSOR é abertor implicitamente e o cojunto é extraído à cada iteração.
        - O CURSOR é aberto implicitamente assim que ultima linha é processada
    
    *Instruções OPEN, FETCH e CLOSE são executada implicitamente no exemplo abaixo.
*/

DECLARE   
  CURSOR cursor_emp IS          
    SELECT deptno, SUM(sal) soma           
    FROM emp          
  GROUP BY deptno; 
BEGIN    
  FOR emprec IN cursor_emp LOOP        
    dbms_output.put_line
      ('Departamento: ' || emprec.deptno);       
    dbms_output.put_line
      ('Salario     : ' || emprec.soma);    
  END LOOP; 
END; 

/* 
    LOOPS FOR de CURSOR utilizando uma SUBCONSULTA
        - O CURSOR pode ser substituído por uma subconsulta dentro do FOR.
        - Não será possível fazer referência aos atributos de cursotes nesse caso, pois sua declaração, abertura e fechamento é implícita.
*/

/*
    SELECT FOR UPDATE
        - Esse comendao permite o LOCK de linha específicas de uma tabela, para garantir que nenhuma alteração seja feita antes da validação.
        - Identifica as linhas que serào atualizadas e bloqueará cada linha no conjunto de dados.
        - Palavra chave opcional NOWAIT retorna o cotrole do programa se algum outro usuário realizou o bloquio das linhas.
        - Sem o uso do NOWAIT, o Oracle espera até que o outro usuário libere as linhas da tabela.

*/

DECLARE
  emprec emp%rowtype;   
  CURSOR cursor_emp IS 
         SELECT empno, sal             
          FROM emp
            FOR UPDATE; 
BEGIN
   OPEN cursor_emp;
   LOOP
      FETCH cursor_emp INTO emprec.empno, emprec.sal;
      EXIT WHEN cursor_emp%notfound;
      UPDATE emp
      SET sal = sal * 1.05
      WHERE CURRENT OF cursor_emp;
   END LOOP;
   CLOSE cursor_emp;
END;
/