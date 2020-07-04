*** Settings ***
Library     Selenium2Library
Library     RequestsLibrary

*** Variables ***
${Session_name}     test
${URL}      http://18.141.230.253:9080

*** Keywords ***
Open Session
    Create Session      ${Session_name}    ${URL}

Get
    [Arguments]     ${uri}
    ${resp}=    Get Request     ${Session_name}    ${uri}
    Status Should Be    200     ${resp}
    # ${content_resp}    To Json     ${resp}     True
    ${timenow}=     Get Time
    Log To Console      ${timenow}
    Log To Console      ${resp.content}

Post
    [Arguments]     ${uri}  ${data}
    ${header}=  Create Dictionary   Content-Type    application/json
    ${resp}=    Post Request    ${Session_name}     /add_info   headers=${header}   data=${data}
    Status Should Be    200     ${resp}
    # Log To Console      ${resp.content}
    Log     ${resp.content}
    Should Be Equal     Personal info updated   ${resp.content}    
    


*** Test Cases ***
Test root path
    Open Session
    Get     /
    Delete All Sessions

Test add_info
    Open Session
    ${data}=    Create Dictionary   id  1   firstname   Build   lastname    ione    age     24
    Post    /add_info   ${data}
    Delete All Sessions

