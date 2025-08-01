# Automação robot framework

<p align="center">
   <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge" #vitrineqa/>
</p>

### Como executar
python run.py -reqres

### Tópicos 

 [Descrição do projeto](#descrição-do-projeto)

- [Ferramentas utilizadas](#ferramentas-utilizadas)

- [Pré requisitos](#pré-requisitos)

- [Metodos para execução](#metodos-para-execução)

- [Execuções multiplas com Pabot](#execuções-multiplas-com-pabot)

- [Linter com Makefile como utilizar](#linter-com-makefile-como-utilizar)

- [Contribuindo para Automação robot framework](#contribuindo-para-automação-robot-framework)

- [Colaboradores](#colaboradores)

- [Licença](#licença)

## Descrição do projeto

Projeto em desenvolvimento para automação de testes utilizando robot framework.

Testes automatizados têm como objetivo minimizar os problemas da abordagem manual, o tempo despendido e, consequentemente, o custo final. Para isso, se fundamentam no uso de ferramentas para controlar a execução de testes de software, por meio da aplicação de estratégias.

Os testes automatizados estão menos suscetíveis a falhas humanas, pois sempre são repetidos da mesma exata maneira. Isso permite uma confiabilidade constante na qualidade do produto, assim agilizando o processo de desenvolvimento e lançamento da aplicação.

### Ajustes e melhorias

O projeto ainda está em desenvolvimento e as próximas atualizações serão voltadas nas seguintes tarefas:

- [x] Criação do projeto base
- [x] Criação e inserção do linter
- [x] Criação e inserção de metodos para execução em python
- [x] Criação e inserção de execução utilizando a extensão robot code
- [ ] Desenvolvimento de novos cenários
- [ ] Criação de uma pipeline
- [ ] ...

## Ferramentas utilizadas

### Sistemas Operacionais

  ![Mac os](https://img.shields.io/badge/mac%20os-%23525252.svg?style=flat&logo=macos&logoColor=white>)
  ![Linux](https://img.shields.io/badge/-Linux%20-%23525252.svg?style=flat&logo=linux&logoColor=white&>)
  ![Windows](https://img.shields.io/badge/-Windows%20-%23525252.svg?style=flat&logo=Windows&>)

### Ferramentas de desenvolvimento

  ![Visual Studio Code](https://img.shields.io/badge/-Visual%20Studio%20Code-333333?style=flat&logo=visual-studio-code&logoColor=007ACC)
  ![Robot Framework](https://img.shields.io/badge/Robot%20Framework%20-%23525252.svg?style=flat&logo=robot-framework&logoColor=white>)
  ![Git](https://img.shields.io/badge/-Git-333333?style=flat&logo=git)
  ![GitHub](https://img.shields.io/badge/-GitHub-333333?style=flat&logo=github)
  ![Bitbucket](https://img.shields.io/badge/-Bitbucket-333333?style=flat&logo=bitbucket)
  ![Gitlab](https://img.shields.io/badge/Gitlab%20-%23525252.svg?style=flat&logo=Gitlab&logoColor=white>)
  ![Java](https://img.shields.io/badge/-Java-333333?style=flat&logo=Java&logoColor=007396)
  ![Python](https://img.shields.io/badge/Python%20-%23525252.svg?style=flat&logo=Python&logoColor=Blue&>)
  ![Node Js](https://img.shields.io/badge/Nodejs%20-%23525252.svg?style=flat&logo=Nodejs&logoColor=white>)
  ![Jenkins](https://img.shields.io/badge/Jenkins%20-%23525252.svg?style=flat&logo=Jenkins&logoColor=white>)
  ![Drone.io](https://img.shields.io/badge/Drone%20-%23525252.svg?style=flat&logo=Drone&logoColor=white>)
  ![Xcode](https://img.shields.io/badge/Xcode%20-%23525252.svg?style=flat&logo=xcode&logoColor=blue&%3E)
  ![Android Studio](https://img.shields.io/badge/Android%20Studio%20-%23525252.svg?style=flat&logo=android-studio&logoColor=green&%3E)
  ![Appium](https://img.shields.io/badge/Appium%20-%23525252.svg?style=flat&logo=appium&logoColor=white%3E)
  ![Appium Inspector](https://img.shields.io/badge/Appium%20Inspector%20-%23525252.svg?style=flat&logo=appium-inspector&logoColor=white%3E)

## Pré requisitos

Antes de começar, verifique se você atendeu aos seguintes requisitos:

Você instalou a versão mais recente  para automação web:

* Python e as libraryes do robot.

Este comando irá instalar todas as libraryes que estão na pasta requirements.txt:

* pip install -r requirements.txt

## Metodos para execução

### Existem diversos metodos para execução dos casos, deixei comentado no arquivo run.py.
### Alguns metodos de execução por linha de comando, lembrando que será necessário criar o parametro para execução:

* Para executar todos os testes de api utilizar:

robot -d ./logs src/test

Tambem existe o metodo mais simples de criar mais comandos para execução, nele podemos executar desta forma:

* Para executar todos os testes api utilizar:
python run.py -all

### Executando um cenario especifico:

* robot -d ./logs -t "Test Case 001: Realizar Login" src/test

### Onde, -t é o parâmetro que indica que deve ser executado o(s) teste(s) específico(s) chamado(s) (“Test Case 01: Login com sucesso”) das suítes contidas no diretório (path). OBS.: Se existirem testes em diferentes suítes, mas com esse mesmo nome, todos serão executados.

### Dando nome a execução:

* robot -N “exemplo de nome execução” -d ./logs  src/test

### Onde, -N é o parâmetro que indica que a execução receberá um identificador (“Nome de Exemplo”). OBS.: Deve vir antes do -d.

### Executando por tags:
### Inicialmente será necessario inserir as tags nos testes:
### Exemplos:
* Test Case 01: Login com sucesso
    [Tags]  testetag
    Dado que eu esteja na tela de login
    Quando inserir dados validos
    Então devo efetuar o login com sucesso

* Test Case 02: Alterar senha/Receber codigo de alteração de senha com sucesso
    [Tags]  testetag
    Dado que eu esteja na tela de login
    Quando entrar no menu de alterar senha
    Então valido que o codigo foi enviado com sucesso

### Executando:
* robot -d ./logs -i Login  src/test

### Executando pelo vs code utilizando a extensão robot code:
* nos arquivos de teste é possivel visualizar o botão de execução, onde será possivel executar os cenários com apenas um clique, para utilizar esta funcionalidade será necessário instalar a extensão robot code e a robotframework-tidy que ja esta no requirements, feito isto basta clicar no botão de execução que irá funcionar.

## Execuções multiplas com Pabot

Um executor paralelo para testes do Robot Framework. Divida uma execução em várias e economize tempo de execução de teste.

Para utilizar será necessário instalar a lib do pabot, porém ela ja esta no requirements.

 Comando a ser utilizado
* pabot --processes 4 -d ./logs src/test

todos os comandos de robot framework são compativeis com o pabot para execução em paralelo, para mais informações acessar a documentação oficial no github.

## Linter com Makefile como utilizar

Conhecimentos necessários
Antes de iniciar a instalação e criação do arquivo Makefile, leia mais sobre  as bibiotecas Robocop, Robotidy e também sobre Makefile.

Funcionalidades
1º Possibilita utilizar as duas bibliotecas de linting ao mesmos tempo
2º Com somente uma linha de comando é possível rodar várias ações
3º Você pode criar várias etapas antes e depois de rodar as transformações do código

Requisitos
Faça download e instalação dos componentes abaixo

Make para Windows: http://gnuwin32.sourceforge.net/packages/make.htm
OBS: Insira o caminho da pasta C:\Program Files (x86)\GnuWin32\bin do Make na variável Path

Make para Mac: brew install make 

Caracteristicas de usar o Makefile
Você poderá rodar várias linhas de comando com somente uma chamada

Por default o makefile não avança para o próximo comando a ser executado caso encotre algum erro, erro que pode ser causado por exemplo pela execução do teste. Então se houver algum erro no seu teste ele não rodar os comandos que sucedem ele, no meu exemplo abaixo para o Linter não irá rodar o relatório do Robocop e para o GitAdd não irá rodar o Git Add * para o stage.

Variáveis e Constantes no MakeFile:
Para rodar o linter basta configurar o caminho que deseja salvar os logs nessa campo do Makefile

    @echo ******************************** RODANDO TESTE *************************************
    robot -d './Logs/' '$(src)'	

Para rodar os comandos pelo Makefile há uma variável '$(src)' que você deverá inserir o caminho do arquivo ou diretório que deseja rodar

Exemplos:

* make Execute src=./src

Rodando o Linter:
Para rodar somente o Linter utilize o comando:

* make Indent src=./src

Para usar o linter em todas as pastas do projeto usar o comando:

* make Indent src=../automation-robot-framework-web-en

Rodando o Linter + Git Add:
Para rodar o Linter e ainda adicionar os arquivos na área de Stage utilize o comando:

* make GitAdd src=./src

Rodando atualização de libraryes:

* make Update Libs

## Contribuindo para Automação robot framework
Para contribuir com Automação robot framework, siga estas etapas:

1. Clone este repositório.
2. Crie um branch: `git checkout -b <nome_branch>`.
3. Faça suas alterações e confirme-as: `git commit -m '<mensagem_commit>'`
4. Envie para o branch original: `git push origin <nome_do_projeto> / <local>`
5. Crie a solicitação de pull.

## Colaboradores

Agradecemos às seguintes pessoas que contribuíram para este projeto:

### Criador do conteudo

| [<img src="https://avatars.githubusercontent.com/u/88514378?v=4" width=115><br><sub>João Marcos</sub>](https://github.com/joaomarcosqa) | 
| :---:

### Automatizadores

| [<img src="https://avatars.githubusercontent.com/u/88514378?v=4" width=115><br><sub>João Marcos</sub>](https://github.com/joaomarcosqa) | [<img src="https://avatars.githubusercontent.com/u/88514378?v=4" width=115><br><sub>João Marcos</sub>](https://github.com/joaomarcosqa)  |
| :---: | :---: 

[⬆ Voltar ao topo](#automação-robot-framework)<br>