Pacote PKG_ALUNO

CREATE OR REPLACE PACKAGE PKG_ALUNO AS
  PROCEDURE excluir_aluno(p_id_aluno IN NUMBER);
  CURSOR lista_maiores_18 IS
    SELECT nome, data_nascimento
    FROM alunos
    WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12) > 18;
  CURSOR lista_alunos_por_curso(p_id_curso IN NUMBER) IS
    SELECT nome
    FROM alunos
    WHERE id_curso = p_id_curso;
END PKG_ALUNO;
/

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS

  PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS
  BEGIN
    -- Exclui as matrículas do aluno
    DELETE FROM matriculas WHERE id_aluno = p_id_aluno;
    -- Exclui o aluno
    DELETE FROM alunos WHERE id_aluno = p_id_aluno;
    COMMIT;
  END excluir_aluno;

END PKG_ALUNO;
/


Pacote PKG_DISCIPLINA

CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS
  PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);
  CURSOR total_alunos_por_disciplina IS
    SELECT d.nome, COUNT(m.id_aluno) AS total_alunos
    FROM disciplinas d
    LEFT JOIN matriculas m ON d.id_disciplina = m.id_disciplina
    GROUP BY d.nome
    HAVING COUNT(m.id_aluno) > 10;
  CURSOR media_idade_por_disciplina(p_id_disciplina IN NUMBER) IS
    SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, a.data_nascimento) / 12)) AS media_idade
    FROM alunos a
    JOIN matriculas m ON a.id_aluno = m.id_aluno
    WHERE m.id_disciplina = p_id_disciplina;
  PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER);
END PKG_DISCIPLINA;
/

CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS

  PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER) IS
  BEGIN
    INSERT INTO disciplinas (nome, descricao, carga_horaria)
    VALUES (p_nome, p_descricao, p_carga_horaria);
    COMMIT;
  END cadastrar_disciplina;

  PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER) IS
  BEGIN
    FOR aluno IN 
      (SELECT a.nome 
       FROM alunos a
       JOIN matriculas m ON a.id_aluno = m.id_aluno
       WHERE m.id_disciplina = p_id_disciplina) 
    LOOP
      DBMS_OUTPUT.PUT_LINE(aluno.nome);
    END LOOP;
  END listar_alunos_disciplina;

END PKG_DISCIPLINA;
/


Pacote PKG_PROFESSOR


CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS
  CURSOR total_turmas_por_professor IS
    SELECT p.nome, COUNT(t.id_turma) AS total_turmas
    FROM professores p
    JOIN turmas t ON p.id_professor = t.id_professor
    GROUP BY p.nome
    HAVING COUNT(t.id_turma) > 1;
  FUNCTION total_turmas(p_id_professor IN NUMBER) RETURN NUMBER;
  FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2;
END PKG_PROFESSOR;
/

CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS

  FUNCTION total_turmas(p_id_professor IN NUMBER) RETURN NUMBER IS
    v_total NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM turmas
    WHERE id_professor = p_id_professor;
    RETURN v_total;
  END total_turmas;

  FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS
    v_nome_professor VARCHAR2(100);
  BEGIN
    SELECT p.nome
    INTO v_nome_professor
    FROM professores p
    JOIN turmas t ON p.id_professor = t.id_professor
    WHERE t.id_disciplina = p_id_disciplina
    FETCH FIRST 1 ROWS ONLY;  -- Caso mais de um professor ministre a disciplina
    RETURN v_nome_professor;
  END professor_disciplina;

END PKG_PROFESSOR;
/
