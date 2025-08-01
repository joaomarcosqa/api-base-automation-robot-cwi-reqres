*** Settings ***
Library     String
Library     Telnet
Library     CSVLibrary
Library     Collections
Library     JSONLibrary
Library     RequestsLibrary
Library     FakerLibrary    locale=pt_br
Resource    tokens.robot
Resource    geradores.robot

*** Variables ***
${BASE_URL}     https://serverest.dev
${URL_LOGIN}    /login
${URL_USUARIOS}     /usuarios
${URL_PRODUTOS}    /produtos
${sessionName}      serverest
${successStatusCode}    200
${successStatusCode201}     201
${msgLoginSuccess}      Login realizado com sucesso
${usuarioLogin}        fulano@qa.com
${senhaLogin}            teste

*** Keywords ***
Criar Usario e Obter Token
    [Documentation]    Cadastra um usuário com dados aleatórios e salva o token
    ${fakeName}                 FakerLibrary.Name
    ${emailFake}            FakerLibrary.email
    ${FakePassword}         FakerLibrary.Password
    ${fakeName}    Set Variable   ${fakeName} 
    ${emailFake}    Set Variable    ${emailFake}
    ${fakePassword}    Set Variable    ${fakePassword}
    Create Session    ${sessionName}    ${BASE_URL}
    ${headers}    Create Dictionary       Content-Type=application/json
    ${nome}    Set Variable    ${fakeName}
    ${email}    Set Variable    ${emailFake}
    ${password}    Set Variable    ${FakePassword}
    ${administrador}   Random Boolean
    ${data}    Create Dictionary    nome=${nome}    email=${email}    password=${password}    administrador=${administrador}
    ${response}    POST On Session    ${sessionName}    ${URL_USUARIOS}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode201}
    Log    ${response.content}
    Create Session    ${sessionName}    ${BASE_URL}
    ${data}    Create Dictionary    email=${emailFake}   password=${FakePassword}
    ${headers}    Create Dictionary    Content-Type=application/json
    ${response}    POST On Session    ${sessionName}    ${URL_LOGIN}    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    ${successStatusCode}
    ${json_response}    Set Variable    ${response.json()}
    ${authorization}    Set Variable    ${json_response["authorization"]}
    Set Global Variable    ${TOKEN}    ${authorization}
    Log    ${authorization}

Random Boolean
    [Documentation]    Retorna aleatoriamente 'true' ou 'false'
    ${boolean}    Evaluate    random.choice(['true', 'false']).lower()    modules=random
    [Return]    ${boolean}

