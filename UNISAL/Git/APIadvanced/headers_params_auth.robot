*** Settings ***
Documentation       Exemplos da própria Library: https://github.com/bulkan/robotframework-requests/blob/master/tests/testcase.robot
...                 Doc da API do GitHub: https://developer.github.com/v3/
Library             RequestsLibrary
Library             Collections
Library             HttpLibrary.HTTP
Resource            ./variables/my_user_and_passwords.robot

*** Variables ***
${GITHUB_HOST}      https://api.github.com
${ISSUES_URI}       /repos/franciscounisalcps/robotframeworkcourse/issues
&{headers}    Content-Type=application/json    Authorization=Basic ABCDEF==
${item}    0

*** Test Cases ***
Fazendo autenticacao basica
    [Tags]  api1
    Conectar com autenticação básica na API do GitHub
    Solicitar os dados do meu usuário

Lista Issues
    [Tags]  api2
    Conectar com autenticação básica na API do GitHub
    GET title de issues state "open" e com o label "bug"

Exemplo: Usando parâmetros
    [Tags]  api3
    # Conectar na API do GitHub sem autenticação
    Conectar com autenticação básica na API do GitHub
    Pesquisar issues com o state "open" e com o label "bug"

*** Keywords ***
Conectar com autenticação básica na API do GitHub
    # Create Session    GitHub  https://www.api.githbub.com
   ${AUTH}             Create List           ${MY_GITHUB_USER}      ${MY_GITHUB_PASS}
   # Create Session      alias=mygithubAuth    url=${GITHUB_HOST}     auth=${AUTH}     disable_warnings=True
   Create Session      alias=mygithubAuth    url=${GITHUB_HOST}     headers=${headers}     auth=${AUTH}

Solicitar os dados do meu usuário
    # ${MY_USER_DATA}     Get On Session          mygithubAuth      /user
    # ${MY_USER_DATA}    Get On Session     github  /  expected_status=200
    ${PARAMS}           Create Dictionary    state=open       labels=bug
    # ${MY_ISSUES}        Get On Session          alias=mygithub       uri=${ISSUES_URI}    params=${PARAMS}
    ${MY_ISSUES}        Get On Session          mygithubAuth       ${ISSUES_URI}    params=${PARAMS}
    Log                 Lista de Issues: ${MY_ISSUES.json()}
    Confere sucesso na requisição   ${MY_ISSUES}

    # ${json} =  To JSON  ${resp.content}  pretty_print=True
    # Log  \n${json}  console=yes

Confere sucesso na requisição
    [Arguments]      ${RESPONSE}
    #Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201'
    #...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Status Should Be    200    ${RESPONSE}

GET title de issues state "${STATE}" e com o label "${LABEL}"
    &{PARAMS}           Create Dictionary    state=${STATE}       labels=${LABEL}
    ${MY_ISSUES}        Get On Session    alias=mygithubAuth        url=${GITHUB_HOST}    params=${PARAMS}
    Log                 Lista de Issues: ${MY_ISSUES.json()}
#    ${​​json_object}​​                  To Json                     ${​​MY_ISSUES.content}​​
#    Log          ${​​MY_ISSUES.json()}​​
#    Log          ${​​MY_ISSUES.content}​​
#    ${json_object}                  To Json                     ${​​MY_ISSUES.content}
    ${ISSUES}=    To JSON    ${MY_ISSUES.content}
     # FOR    ${item}​​    IN    @{ISSUES}​​
     #     Log   ${item}​​
     #     Log   ${itemtitle']}​​
     # END
Conectar na API do GitHub sem autenticação
     # Create Session      alias=mygithub        url=${GITHUB_HOST}     disable_warnings=True
     Get On Session    alias=mygithubAuth    url=${GITHUB_HOST}     headers=${headers}     expected_status=200

Pesquisar issues com o state "${STATE}" e com o label "${LABEL}"
    &{PARAMS}           Create Dictionary    state=${STATE}       labels=${LABEL}
    ${MY_ISSUES}        Get On Session          alias=mygithubAuth    url=${GITHUB_HOST}    params=${PARAMS}
    Log                 Lista de Issues: ${MY_ISSUES.json()}
    Confere sucesso na requisição   ${MY_ISSUES}
