*** Settings ***
Documentation    Suite description
Resource    ../PageObjects/Teste_PageObjects.robot
Resource    ../Functions/Teste_Keywords.robot
Resource    ../PageObjects/Teste_InputData.robot

*** Test Cases ***
Test title
    [Tags]    Teste1
    Login Google
    Busca Google