*** Settings ***
Library    Collections
Library    JSONLibrary
Library    RequestsLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***
${BASE_URL}             https://reqres.in/api
${API_KEY}              reqres-free-v1
${USER_NAME}            John Doe
${USER_JOB}             Developer
${SuccessStatusCode201}    201
${SuccessStatusCode200}    200
${SuccessStatusCode204}    204
${FailStatusCode401}       401

&{HEADERS_JSON}         Content-Type=application/json    x-api-key=${API_KEY}
&{HEADERS_NO_AUTH}      Content-Type=application/json

*** Test Cases ***
Criar Usuário com Sucesso
    Create Session    reqres    ${BASE_URL}
    ${body}=    Create Dictionary    name=${USER_NAME}    job=${USER_JOB}
    ${response}=    POST On Session    reqres    /users    json=${body}    headers=${HEADERS_JSON}
    Should Be Equal As Integers    ${response.status_code}    ${SuccessStatusCode201}
    ${json}=    To Json    ${response.content}
    Validate No Empty Fields    ${json}
    Set Suite Variable    ${CREATED_USER_ID}    ${json}[id]

Listar Usuários com Sucesso
    ${response}=    GET On Session    reqres    /users    headers=${HEADERS_JSON}
    Should Be Equal As Integers    ${response.status_code}    ${SuccessStatusCode200}
    ${json}=    To Json    ${response.content}
    Validate No Empty Fields    ${json}

Editar Usuário com Sucesso
    [Setup]    Run Keyword And Ignore Error    Criar Usuário com Sucesso
    ${update}=    Create Dictionary    name=John Doe Updated    job=Senior Developer
    ${response}=    PUT On Session    reqres    /users/${CREATED_USER_ID}    json=${update}    headers=${HEADERS_JSON}
    Should Be Equal As Integers    ${response.status_code}    ${SuccessStatusCode200}
    ${json}=    To Json    ${response.content}
    Validate No Empty Fields    ${json}

Buscar Usuário por ID
    ${response}=    GET On Session    reqres    /users/1    headers=${HEADERS_JSON}
    Should Be Equal As Integers    ${response.status_code}    ${SuccessStatusCode200}
    ${json}=    To Json    ${response.content}
    Dictionary Should Contain Key    ${json}    data
    Dictionary Should Contain Key    ${json}[data]    id
    Dictionary Should Contain Key    ${json}[data]    email
    Dictionary Should Contain Key    ${json}[data]    first_name
    Dictionary Should Contain Key    ${json}[data]    last_name
    Dictionary Should Contain Key    ${json}[data]    avatar

Excluir Usuário
    ${response}=    DELETE On Session    reqres    /users/2    headers=${HEADERS_JSON}
    Should Be Equal As Integers    ${response.status_code}    ${SuccessStatusCode204}
    Should Be Empty    ${response.content}

Erro 401 por Falta de API Key
    Create Session    reqres    ${BASE_URL}
    ${body}=    Create Dictionary    name=${USER_NAME}    job=${USER_JOB}
    ${response}=    POST On Session    reqres    /users    json=${body}    headers=${HEADERS_NO_AUTH}    expected_status=401
    ${json}=    To Json    ${response.content}
    Dictionary Should Contain Key    ${json}    error
    Should Be Equal    ${json}[error]    Missing API key

*** Keywords ***
Validate No Empty Fields
    [Arguments]    ${data}
    FOR    ${key}    IN    @{data.keys()}
        ${value}=    Get From Dictionary    ${data}    ${key}
        Run Keyword If    "${value}" == ""    Fail    Campo '${key}' está vazio
        Run Keyword If    "${value}" == []    Fail    Lista '${key}' está vazia
        Run Keyword If    "${value}" == None    Fail    Campo '${key}' está None
    END