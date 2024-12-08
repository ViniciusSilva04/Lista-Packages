 **PKG_ALUNO**: 
Este pacote lida com operações relacionadas aos alunos. Ele inclui as seguintes funcionalidades:

- **Exclusão de um aluno e suas matrículas associadas**: Permite excluir um aluno do sistema e remover as matrículas associadas a ele.
- **Listagem de alunos maiores de 18 anos**: Exibe os alunos que têm mais de 18 anos, incluindo seus nomes e datas de nascimento.
- **Listagem de alunos por curso**: Permite listar os alunos matriculados em um curso específico, dado seu `id_curso´.

### **PKG_DISCIPLINA**: 
Este pacote é responsável por manipular as disciplinas. As funcionalidades incluem:

- **Cadastro de novas disciplinas**: Permite cadastrar uma nova disciplina no sistema, fornecendo nome, descrição e carga horária.
- **Listagem de alunos de uma disciplina**: Exibe os alunos matriculados em uma disciplina específica, dado seu `id_disciplina`.
- **Cálculo da média de idade dos alunos por disciplina**: Calcula a média de idade dos alunos matriculados em uma disciplina específica.
- **Obter o total de alunos matriculados por disciplina**: Retorna o número total de alunos matriculados em cada disciplina, mas apenas para disciplinas com mais de 10 alunos.

### **PKG_PROFESSOR**: 
Este pacote trata das operações relacionadas aos professores. Ele inclui as seguintes funcionalidades:

- **Listagem do número de turmas por professor**: Exibe os professores e o número de turmas que eles lecionam, mostrando apenas os professores com mais de uma turma.
- **Cálculo do total de turmas de um professor**: Retorna o total de turmas em que um professor atua como responsável, dado seu `id_professor`.
- **Encontrar o professor responsável por uma disciplina**: Permite encontrar o nome do professor que ministra uma disciplina específica, dado o `id_disciplina`.
@C:\meus_scripts\pacotes.sql
EXEC PKG_ALUNO.excluir_aluno(123);
EXEC PKG_ALUNO.excluir_aluno(123);
