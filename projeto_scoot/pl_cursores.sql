/*
    Todo select usa uma �rea de contexto onde temos: linhas processadas, um apontador e, para consultas, um conjunto ativo.
    O conjunto ativo � composto pelas linhas recuperadas na consulta.
*/

SELECT ename,job
FROM emp
where deptno = 20;

/*
    O CURSOR � o apondador da �rea ade contexto, permitindo permitindo a nomea��o de uma instru��o SQL.
    Tamb�m permite o acesso a inforna��o na �rea de contexto e, ate certo ponto, controle do proprocessamento.
    
    o CURSOR impl�cito n�o � declarado � � craido automaticamente para todas as intru��es DDL, DML, DQL que retornam uma linha.
    Se a instru��o retornar mais de uma linha, um erro ser� gerado
    

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
     - ORA-01422: a extra��o exata retorna mais do que o n�mero solicitado de linhas
     = ORA-06512: em line 4
     
    Segundo a Oracle (2026), um CURSOR expl�cito deve ser declarado na �rea declarativa do Bloco An�nimo PL/SQL.
    Com o CURSOR declarado, podemos processar um conjunto ativo de v�rias linhas e colunas.
*/

BEGIN
   DELETE FROM emp
   WHERE deptno = 10;
   dbms_output.put_line('Linhas apagadas = ' || SQL%ROWCOUNT);
   ROLLBACK;
END;

-- ATRIBUTOS COMUNS AOS CURSORES EXPL�CITOS E IMPL�CITOS
-- %FOUND retorna verdadeiro (TRUE), caso alguma linha (tupla) tenha sido afetada. 
-- %ISOPEN retorna verdadeiro (TRUE), caso o CURSOR esteja aberto. 
-- %NOTFOUND retorna verdadeiro (TRUE), caso n�o tenha encontrado nenhuma tupla. Caso tenha encontrado, retornar� falso (FALSE) at� a �ltima tupla. 
-- %ROWCOUNT retorna o n�meoro de tuplas manipuladas pelo cursor

/*
    ETAPAS DE USO DO CURSOR
        - Decla��o do cursor na �rea declarativa;
        - Abertura do cursor na �rea de execu��o;
        - Recupera��o das linhas atrav�s de um SELECT;
        - Verifica��ao dos t�rminos da stuplas;
        - Fechamento do cursor
*/
declare
    emprec emp%rowtype; -- Conjunto que arameza linhas (tuplas)
    cursor cr_emp is -- Cursor declarado para armazenar informa��o do select
        select -- Seleciona os dados e os p�e na �rea de contexto
            deptno, SUM(sal)
        from emp
       group by deptno;   
begin
    open cr_emp; -- Abertura do cursor
    loop -- Lop para extrair os dados sequencialment 
        FETCH cr_emp into emprec.deptno, emprec.sal; -- instru��o de extra��o de dados
        exit when cr_emp%notfound; -- Condi��o de fechamento do loop, que � quando a pr�xima linha do cursos n�o existe.
        dbms_output.put_line
        ('Departamento: ' || emprec.deptno);
       dbms_output.put_line
        ('Salario     : ' || emprec.sal);
    end loop;
    close cr_emp; -- Fecha o cursor, mas a re-abertura pode ser feita em outro momento.
end;


/*
    INSTRU��O FETCH :: RECUPERARA��O DAS LINHAS DO CURSOR:
        - FETCH � o nome da instru��o;
        - Ap�s cada execu��o, o FETCH pula para a pr�xima linha do cojunto ativo salvo no CURSOR.
        - Possui vari�veis para armazenar resultados individualmente.
        - Record_name � uma vari�vel de registro que pode ser declarado usando o %rowtipe
        
    *Recupera as linhas de maneira sequencial.
*/

/* 
    Maneira simplificada de usar um  CURSOR
        - O CURSOR � abertor implicitamente e o cojunto � extra�do � cada itera��o.
        - O CURSOR � aberto implicitamente assim que ultima linha � processada
    
    *Instru��es OPEN, FETCH e CLOSE s�o executada implicitamente no exemplo abaixo.
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
        - O CURSOR pode ser substitu�do por uma subconsulta dentro do FOR.
        - N�o ser� poss�vel fazer refer�ncia aos atributos de cursotes nesse caso, pois sua declara��o, abertura e fechamento � impl�cita.
*/

/*
    SELECT FOR UPDATE
        - Esse comendao permite o LOCK de linha espec�ficas de uma tabela, para garantir que nenhuma altera��o seja feita antes da valida��o.
        - Identifica as linhas que ser�o atualizadas e bloquear� cada linha no conjunto de dados.
        - Palavra chave opcional NOWAIT retorna o cotrole do programa se algum outro usu�rio realizou o bloquio das linhas.
        - Sem o uso do NOWAIT, o Oracle espera at� que o outro usu�rio libere as linhas da tabela.

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