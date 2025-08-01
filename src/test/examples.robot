*** Settings ***
Resource    ../api/utils/base.robot

*** Test Cases ***
Test Case 001: Realizar Login
    [Tags]  Login
    [Documentation]    Efetua login
    Create Session    ${sessionName}    ${BASE_URL}
    ${data}    Create Dictionary    email=${usuarioLogin}    password=${senhaLogin}
    ${headers}    Create Dictionary    Content-Type=application/json
    ${response}    POST On Session    ${sessionName}    ${URL_LOGIN}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode}
    ${json_response}    Set Variable    ${response.json()}
    ${authorization}    Set Variable    ${json_response["authorization"]}
    Set Test Variable    ${TOKEN}    ${authorization}
    Log    ${authorization}
    Dictionary Should Contain Value    ${json_response}    ${msgLoginSuccess}

Test Case 001: Cadastrar Produto com Dados Aleatórios
    [Tags]  Produtos
    [Documentation]    Cadastra um produto com dados aleatórios
    ${fakeName}                 FakerLibrary.Name
    ${anotherFakeName}                 FakerLibrary.Name
    ${fakeNumber}                       FakerLibrary.Random Number          digits=4
    ${anotherFakeNumber}            FakerLibrary.Random Number          digits=3
    Create Session    ${sessionName}    ${BASE_URL}
    Criar Usario e Obter Token
    ${headers}    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    ${nome}    Set Variable    ${fakeName}
    ${preco}    Set Variable    ${fakeNumber}
    ${descricao}    Set Variable    ${anotherFakeName}
    ${quantidade}    Set Variable    ${anotherFakeNumber}
    ${data}    Create Dictionary    nome=${nome}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade}
    ${response}    POST On Session    ${sessionName}    ${URL_PRODUTOS}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode201}
    Log    ${response.content}

Test Case 002: Listar Produtos
    [Tags]  Produtos
    [Documentation]    Exemplo de simulação de chamada GET usando RequestsLibrary com token Bearer
    Criar Usario e Obter Token
    Create Session    ${sessionName}    ${BASE_URL}
    ${headers}    Create Dictionary    Authorization=Bearer ${TOKEN}    accept=application/json
    ${response}    GET On Session    ${sessionName}    ${URL_PRODUTOS}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode}
    Log    ${response.content}
    ${json_response}    Set Variable    ${response.json()}

    Log    Produtos: ${json_response["produtos"]}
    Dictionary Should Contain Key    ${json_response}    produtos
    ${produtos}    Set Variable If    "produtos" in ${json_response}    ${json_response["produtos"]}    ${EMPTY}
    Log    Tipo de produtos: ${produtos.__class__}
    Should Not Be Empty    ${produtos}

    FOR    ${produto}    IN    @{produtos}
        Should Not Be Empty    ${produto["nome"]}
        Should Not Be Empty    ${produto["descricao"]}
        ${preco}    Set Variable If    "preco" in ${produto}    ${produto["preco"]}    None
        ${quantidade}    Set Variable If    "quantidade" in ${produto}    ${produto["quantidade"]}    None
        Should Not Be Equal As Strings    ${preco}    ${None}
        Should Not Be Equal As Strings    ${quantidade}    ${None}
        Should Not Be Empty    ${produto["_id"]}
    END


Test Case 003: Cadastrar Produto com Dados Aleatórios
    [Tags]  Produtos
    [Documentation]    Cadastra um produto com dados aleatórios
    ${fakeName}                 FakerLibrary.Name
    ${anotherFakeName}                 FakerLibrary.Name
    ${fakeNumber}                       FakerLibrary.Random Number          digits=4
    ${anotherFakeNumber}            FakerLibrary.Random Number          digits=3
    Create Session    ${sessionName}    ${BASE_URL}
    Criar Usario e Obter Token
    ${headers}    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    ${nome}    Set Variable    ${fakeName}
    ${preco}    Set Variable    ${fakeNumber}
    ${descricao}    Set Variable    ${anotherFakeName}
    ${quantidade}    Set Variable    ${anotherFakeNumber}
    ${data}    Create Dictionary    nome=${nome}    preco=${preco}    descricao=${descricao}    quantidade=${quantidade}
    ${response}    POST On Session    ${sessionName}    ${URL_PRODUTOS}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode201}
    Log    ${response.content}

Test Case 001: Listar Usuarios
    [Tags]  Usuarios
    [Documentation]    Exemplo de simulação de chamada GET usando RequestsLibrary com token Bearer
    Criar Usario e Obter Token
    Create Session    ${sessionName}    ${BASE_URL}
    ${headers}    Create Dictionary    Authorization=Bearer ${TOKEN}    accept=application/json
    ${response}    GET On Session    ${sessionName}    ${URL_USUARIOS}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode}
    Log    ${response.content}
    ${json_response}    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    quantidade
    Should Not Be Equal As Strings    ${json_response["quantidade"]}    0
    Dictionary Should Contain Key    ${json_response}    usuarios
    ${usuarios}    Set Variable    ${json_response["usuarios"]}
    Should Not Be Empty    ${usuarios}
    FOR    ${usuario}    IN    @{usuarios}
        Should Not Be Empty    ${usuario["nome"]}
        Should Not Be Empty    ${usuario["email"]}
        Should Not Be Empty    ${usuario["password"]}
        Should Not Be Empty    ${usuario["administrador"]}
        Should Not Be Empty    ${usuario["_id"]}
    END

Test Case 002: Cadastrar Usuario com Dados Aleatórios
    [Tags]  Usuarios
    [Documentation]    Cadastra um usuário com dados aleatórios
    ${fakeName}                 FakerLibrary.Name
    ${emailFake}            FakerLibrary.Email
    ${FakePassword}         FakerLibrary.Password
    Create Session    ${sessionName}    ${BASE_URL}
    Criar Usario e Obter Token
    ${headers}    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    ${nome}    Set Variable    ${fakeName}
    ${email}    Set Variable    ${emailFake}
    ${password}    Set Variable    ${FakePassword}
    ${administrador}   Random Boolean
    ${data}    Create Dictionary    nome=${nome}    email=${email}    password=${password}    administrador=${administrador}
    ${response}    POST On Session    ${sessionName}    ${URL_USUARIOS}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode201}
    Log    ${response.content}

Test Case 003: Cadastrar e Buscar Usuario
    [Tags]  Usuarios
    [Documentation]    Cadastra um usuário com dados aleatórios e busca o usuário cadastrado
    Create Session    ${sessionName}    ${BASE_URL}
    Criar Usario e Obter Token
    ${headers}    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    ${fakeName}                 FakerLibrary.Name
    ${emailFake}            FakerLibrary.Email
    ${FakePassword}         FakerLibrary.Password
    ${administrador}   Random Boolean
    ${data}    Create Dictionary    nome=${fakeName}    email=${emailFake}    password=${Fakepassword}    administrador=${administrador}
    ${response}    POST On Session    ${sessionName}    ${URL_USUARIOS}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode201}
    ${user_id}    Set Variable    ${response.json()["_id"]}
    Log    ${response.content}
    ${response}    GET On Session    ${sessionName}    ${URL_USUARIOS}/${user_id}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode}
    Log    ${response.content}

Test Case 004: Cadastrar e Excluir Usuario
    [Tags]  Usuarios
    [Documentation]    Cadastra um usuário com dados aleatórios e exclui o usuário cadastrado
    Create Session    ${sessionName}    ${BASE_URL}
    Criar Usario e Obter Token
    ${headers}    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    ${fakeName}                 FakerLibrary.Name
    ${emailFake}            FakerLibrary.Email
    ${FakePassword}         FakerLibrary.Password
    ${administrador}   Random Boolean
    ${data}    Create Dictionary    nome=${fakeName}    email=${emailFake}    password=${Fakepassword}    administrador=${administrador}
    ${response}    POST On Session    ${sessionName}    ${URL_USUARIOS}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode201}
    ${user_id}    Set Variable    ${response.json()["_id"]}
    Log    ${response.content}
    ${response}    DELETE On Session    ${sessionName}    ${URL_USUARIOS}/${user_id}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode}
    Log    ${response.content}

Test Case 005: Cadastrar e Atualizar Usuario
    [Tags]  Usuarios
    [Documentation]    Atualiza um usuário com dados aleatórios
    Create Session    ${sessionName}    ${BASE_URL}
    Criar Usario e Obter Token
    ${headers}    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    ${fakeName}                 FakerLibrary.Name
    ${emailFake}            FakerLibrary.Email
    ${FakePassword}         FakerLibrary.Password
    ${anotherFakeName}                 FakerLibrary.Name
    ${anotherEmailFake}            FakerLibrary.Email
    ${anotherFakePassword}         FakerLibrary.Password
    ${administrador}   Random Boolean
    ${data}    Create Dictionary    nome=${anotherFakeName}    email=${anotherEmailFake}    password=${anotherFakepassword}    administrador=${administrador}
    ${response}    POST On Session    ${sessionName}    ${URL_USUARIOS}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode201}
    ${user_id}    Set Variable    ${response.json()["_id"]}
    Log    ${response.content}
    ${update_data}    Create Dictionary    nome=${fakeName}   email=${emailFake}    password=${Fakepassword}   administrador=${administrador}
    ${update_response}    PUT On Session    ${sessionName}    ${URL_USUARIOS}/${user_id}    json=${update_data}    headers=${headers}
    Should Be Equal As Strings    ${update_response.status_code}    200
    Log    ${update_response.content}

Test Case 006: Listar Usuarios
    [Tags]  Usuarios
    [Documentation]    Exemplo de simulação de chamada GET usando RequestsLibrary com token Bearer
    Criar Usario e Obter Token
    Create Session    ${sessionName}    ${BASE_URL}
    ${headers}    Create Dictionary    Authorization=Bearer ${TOKEN}    accept=application/json
    ${response}    GET On Session    ${sessionName}    ${URL_USUARIOS}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode}
    Log    ${response.content}
    ${json_response}    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    quantidade
    Should Not Be Equal As Strings    ${json_response["quantidade"]}    0
    Dictionary Should Contain Key    ${json_response}    usuarios
    ${usuarios}    Set Variable    ${json_response["usuarios"]}
    Should Not Be Empty    ${usuarios}
    FOR    ${usuario}    IN    @{usuarios}
        Should Not Be Empty    ${usuario["nome"]}
        Should Not Be Empty    ${usuario["email"]}
        Should Not Be Empty    ${usuario["password"]}
        Should Not Be Empty    ${usuario["administrador"]}
        Should Not Be Empty    ${usuario["_id"]}
    END