/*
    PL/SQL também possúi uma estrutura de tratamento de excessões que podem acontecer em tempo de execução
    Uma excessão é uma ocorrência inesperada ou diferente dquela programada para ser executada. Em outras palavras, uma excessão é um erro.
*/

SET SERVEROUTPUT ON

DECLARE
   cinco NUMBER := 5;
BEGIN
  dbms_output.put_line(cinco / (cinco - cinco) );
END;

-- Estrutura básica de trabamento de excessões

EXCEPTION
WHEN exceção1 [OR exceção2 …] THEN
  comando1;
  comando2;
  …
[WHEN exceção3 [OR exceção4 …] THEN
  comando1;
  comando2;
  …]
[WHEN OTHERS THEN
  comando1;
  comando2;
  …]
  
/* 
    EXCEPTION:Indica o nício da seção de tratamento de excessões do bloco PL/SQL
    Excessão: indica o nome padrão de uma excessão predefinida ou o nome deuma excessão definida pelo desenvolvedor.
    Comando: Indica uma ou mais instruções PL/SQL ou SQL
    OTHERS: É um handler de excessão. Indica uma cláusula de tratamento genérico, em que é acionada se caso nenhuma das outras excessões forem capturadas.
*/  

-- Exemplo de uma excessão padrão:

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
    A excessão é sobreescrita com 'divisão por zero' e mantém o erro em tempo de execução, porém, com uma menságem mais amigável ao usuário.
    Isso acontece por conta da sessão exception, que capta o erro ocasionado no programa. Prodemos incluír outros cálculos dentro de cada excessão capturada.    
*/

/*
    Para Oracle, quando ocorre uma excessão, pode-se identificar o código ou a mensagem de erro associado usando duas funções SQLCOE e SQLERRM. 
    Com base no código ou mensagem, é possível definir uma ação subsequente para lidar com o erro.
    
    
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
    - SQLERR é uma função numérica que retorna o código do erro escolhido;
    - SQLCODE é uma função caractere que devolve o texto da mensagem de erro.
*/

/*
    Há momentos em que precisamos criar ou capturar erros específicos ao contexto de negócio.
    Para isso, usamos uma variável do tipo EXECTION, que é o equivalente a uma classe do Java ou Python.
    Qaundo um erro personalizado acontece através da condicional if, iremos dar um RAISE, que irá chamar a variável de erro.
    Com isso, usamos uma cláusula WHEN para definir qual exception será executado.
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
    É possível reescrever erros padrão do Oracle através da função PRAGMA EXEPTION_INIT.

*/

PRAGMA EXCEPTION_INIT(nome_exceção, código_Oracle_erro);

/*
    Onde:
        - nome_exceção: recebe a variável do tipo excessão criada em código
        - código_Oracle_erro: é o número de erro padrão do Oracle, em que iremos sobre escrever e personaliszar a excessão:
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
    O procedimento RAISE_APPLICATION_ERROR é uma ferramenta utilizada no PL/SQL da Oracle para enviar mensagens de erro personalizadas durante a execução de um programa. Ao usar esse procedimento, você pode:

    - Comunicar Erros: Informar a sua aplicação sobre uma exceção que ocorreu, permitindo que você trate o erro de maneira adequada e específica.
    - Código de Erro Personalizado: O RAISE_APPLICATION_ERROR permite que você retorne um código de erro que não faz parte das exceções padrão da Oracle. Isso oferece a flexibilidade de criar mensagens de erro que são mais relevantes para a lógica do seu programa.
    - Evitar Exceções Não Tratáveis: Ao comunicar um erro de maneira controlada com RAISE_APPLICATION_ERROR, você pode evitar que a aplicação retorne exceções não tratáveis, proporcionando uma experiência mais suave e compreensível para o usuário final.
*/

RAISE_APPLICATION_ERROR (numero_erro,	mensagem [, {TRUE | FALSE}]);

/*
    Número do Erro: Você pode escolher um número entre -20000 e -20999 para identificar seu próprio erro.
    Mensagem: É o texto que descreve o erro. Pode ter até 2.048 caracteres.
    Parâmetro Booleano (TRUE | FALSE):
        - TRUE: O novo erro é adicionado aos erros já existentes.
        - FALSE: (padrão): O novo erro substitui os erros anteriores.

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
