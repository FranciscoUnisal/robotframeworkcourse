*** Settings ***
Library    SeleniumLibrary
Resource    ../PageObjects/Teste_PageObjects.robot
Resource    ../TestSuite/Teste_TestSuite.robot
Resource    ../Functions/Teste_InputData.robot

*** Keywords ***
Login Google
    Open Browser    ${GOOGLEURL}    ${BROWSER}    options=add_argument("--incognito")
    Maximize Browser Window
    Go To         ${GOOGLEURL}

Busca Google
    Input Text    ${BUSCAGOOGLE}    ${BUSCAGOOGLEVALUE1}
    Press Keys    ${BUSCAGOOGLE}    RETURN
    Wait Until Page Contains Element    ${ROBOTORG}
#    Click Element    ${ROBOTORG}
    Capture Page Screenshot
