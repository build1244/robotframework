*** Settings ***
Library     Selenium2Library

*** Variables ***
${URL}      http://18.141.230.253:9000
${BROWSER}  headlesschrome

*** Keywords ***
Open Website
    Open Browser    ${URL}  ${BROWSER}

Verify
    ${text}=    Get Text    xpath:/html/body
    Log To Console  ${text}
    Should Be Equal     ${text}     Hello v1

*** Test Cases ***
Test web
    Open Website
    Verify
