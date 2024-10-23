/*
    PL/SQL tamb�m poss�i uma estrutura de tratamento de excess�es que podem acontecer em tempo de execu��o
    Uma excess�o � uma ocorr�ncia inesperada ou diferente dquela programada para ser executada. Em outras palavras, uma excess�o � um erro.
*/

SET SERVEROUTPUT ON

DECLARE
   cinco NUMBER := 5;
BEGIN
  dbms_output.put_line(cinco / (cinco - cinco) );
END;

-- Estrutura b�sica de trabamento de excess�es

EXCEPTION
WHEN exce��o1 [OR exce��o2 �] THEN
  comando1;
  comando2;
  �
[WHEN exce��o3 [OR exce��o4 �] THEN
  comando1;
  comando2;
  �]
[WHEN OTHERS THEN
  comando1;
  comando2;
  �]
  
/* 
    EXCEPTION:Indica o n�cio da se��o de tratamento de excess�es do bloco PL/SQL
    Excess�o: indica o nome padr�o de uma excess�o predefinida ou o nome deuma excess�o definida pelo desenvolvedor.
    Comando: Indica uma ou mais instru��es PL/SQL ou SQL
    OTHERS: � um handler de excess�o. Indica uma cl�usula de tratamento gen�rico, em que � acionada se caso nenhuma das outras excess�es forem capturadas.
*/  

-- Exemplo de uma excess�o padr�o:

DECLARE
    cinco   NUMBER := 5;
BEGIN
    dbms_output.put_line(cinco / (cinco - cinco) );
EXCEPTION
    WHEN zero_divide THEN
        dbms_output.put_line('Divisao por zero');
    WHEN OTHERS THEN
        dbms_output.put_line('Erro imprevisto');
END;


/*
    A excess�o � sobreescrita com 'divis�o por zero' e mant�m o erro em tempo de execu��o, por�m, com uma mens�gem mais amig�vel ao usu�rio.
    Isso acontece por conta da sess�o exception, que capta o erro ocasionado no programa. Prodemos inclu�r outros c�lculos dentro de cada excess�o capturada.    
*/

/*
    Para Oracle, quando ocorre uma excess�o, pode-se identificar o c�digo ou a mensagem de erro associado usando duas fun��es SQLCOE e SQLERRM. 
    Com base no c�digo ou mensagem, � poss�vel definir uma a��o subsequente para lidar com o erro.
    
    
*/


CREATE TABLE erros
(usuario  VARCHAR2(30),
 data     DATE,
 cod_erro NUMBER,
 msg_erro VARCHAR2(100));

SET SERVEROUTPUT ON

DECLARE
   cod   erros.cod_erro%TYPE;
   msg   erros.msg_erro%TYPE;    
   cinco NUMBER := 0; 
BEGIN    
  DBMS_OUTPUT.PUT_LINE (cinco / ( cinco - cinco )); 
EXCEPTION    
  WHEN ZERO_DIVIDE THEN
        cod := SQLCODE;
        msg := SUBSTR(SQLERRM, 1, 100);
        insert into erros values (USER, SYSDATE, cod, msg);    
  WHEN OTHERS THEN         
        DBMS_OUTPUT.PUT_LINE ('Erro imprevisto'); 
END;
        
/*
    - SQLERR � uma fun��o num�rica que retorna o c�digo do erro escolhido;
    - SQLCODE � uma fun��o caractere que devolve o texto da mensagem de erro.
*/

/*
    H� momentos em que precisamos criar ou capturar erros espec�ficos ao contexto de neg�cio.
    Para isso, usamos uma vari�vel do tipo EXECTION, que � o equivalente a uma classe do Java ou Python.
    Qaundo um erro personalizado acontece atrav�s da condicional if, iremos dar um RAISE, que ir� chamar a vari�vel de erro.
    Com isso, usamos uma cl�usula WHEN para definir qual exception ser� executado.
*/

DECLARE
    e_meu_erro EXCEPTION;
    emprec   emp%rowtype;
    CURSOR cursor_emp IS 
       SELECT empno,ename  
       FROM emp
       WHERE empno = 1111;
BEGIN
    OPEN cursor_emp;
    LOOP
        FETCH cursor_emp 
        INTO emprec.deptno,emprec.sal;
        IF cursor_emp%notfound THEN
            RAISE e_meu_erro;
        END IF;
        dbms_output.put_line('Codigo : ' || emprec.empno);
        dbms_output.put_line('Nome   : ' || emprec.ename);
        EXIT WHEN cursor_emp%notfound;
    END LOOP;
EXCEPTION
    WHEN e_meu_erro THEN
        dbms_output.put_line('Codigo nao cadastrado');
        ROLLBACK;
END;


/*
    � poss�vel reescrever erros padr�o do Oracle atrav�s da fun��o PRAGMA EXEPTION_INIT.

*/

PRAGMA EXCEPTION_INIT(nome_exce��o, c�digo_Oracle_erro);

/*
    Onde:
        - nome_exce��o: recebe a vari�vel do tipo excess�o criada em c�digo
        - c�digo_Oracle_erro: � o n�mero de erro padr�o do Oracle, em que iremos sobre escrever e personaliszar a excess�o:
*/

DECLARE
    e_meu_erro EXCEPTION;
    PRAGMA exception_init ( e_meu_erro,-2292 );
BEGIN
    DELETE FROM dept
    WHERE deptno = 10;
    COMMIT;
EXCEPTION
    WHEN e_meu_erro THEN
        dbms_output.put_line('Integridade Referencial Violada');
        ROLLBACK;
END;
/*
    O procedimento RAISE_APPLICATION_ERROR � uma ferramenta utilizada no PL/SQL da Oracle para enviar mensagens de erro personalizadas durante a execu��o de um programa. Ao usar esse procedimento, voc� pode:

    - Comunicar Erros: Informar a sua aplica��o sobre uma exce��o que ocorreu, permitindo que voc� trate o erro de maneira adequada e espec�fica.
    - C�digo de Erro Personalizado: O RAISE_APPLICATION_ERROR permite que voc� retorne um c�digo de erro que n�o faz parte das exce��es padr�o da Oracle. Isso oferece a flexibilidade de criar mensagens de erro que s�o mais relevantes para a l�gica do seu programa.
    - Evitar Exce��es N�o Trat�veis: Ao comunicar um erro de maneira controlada com RAISE_APPLICATION_ERROR, voc� pode evitar que a aplica��o retorne exce��es n�o trat�veis, proporcionando uma experi�ncia mais suave e compreens�vel para o usu�rio final.
*/

RAISE_APPLICATION_ERROR (numero_erro,	mensagem [, {TRUE | FALSE}]);

/*
    N�mero do Erro: Voc� pode escolher um n�mero entre -20000 e -20999 para identificar seu pr�prio erro.
    Mensagem: � o texto que descreve o erro. Pode ter at� 2.048 caracteres.
    Par�metro Booleano (TRUE | FALSE):
        - TRUE: O novo erro � adicionado aos erros j� existentes.
        - FALSE: (padr�o): O novo erro substitui os erros anteriores.

    Exemplo abaixo
*/

DECLARE
    cinco   NUMBER := 5;
BEGIN
    dbms_output.put_line(cinco / (cinco - cinco) );
EXCEPTION
    WHEN zero_divide THEN
        raise_application_error(-20901,'Erro aritmetico. Reveja o programa');
    WHEN OTHERS THEN
        dbms_output.put_line('Erro imprevisto');
END;
/
ERROR at line 1:
ORA-20901: Erro aritmetico. Reveja o programa
