*** Settings ***
Library     Selenium2Library
Library     RequestsLibrary

*** Variables ***
${Session_name}     test
${URL}      http://52.221.221.222:9080

*** Keywords ***
Open Session
    Create Session      ${Session_name}    ${URL}

Get
    [Arguments]     ${uri}
    ${resp}=    Get Request     ${Session_name}    ${uri}
    Status Should Be    200     ${resp}
    # ${content_resp}    To Json     ${resp}     True
    #Log To Console      ${timenow}
    Log To Console      ${resp.content}
    ${resp_msg}=	Convert To String	${resp.content}
    Log		${resp_msg}
    Return From Keyword		${resp_msg}

Post
    [Arguments]     ${uri}  ${data}
    ${header}=  Create Dictionary   Content-Type    application/json
    ${resp}=    Post Request    ${Session_name}     /add_info   headers=${header}   data=${data}
    Status Should Be    200     ${resp}
    # Log To Console      ${resp.content}
    ${resp_msg}=	Convert To String	${resp.content}
    Log     ${resp_msg}
    Return From Keyword   ${resp_msg}    
    


*** Test Cases ***
Test root path
    Open Session
    ${msg}=	Get     /
    Should Contain	${msg}	Hello welcome to the site
    ${timenow}=     Get Time
    Should Contain	${msg}	${timenow}
    Delete All Sessions

Test add_info
    Open Session
    ${data}=    Create Dictionary   id  1   firstname   Build   lastname    ione    age     12345
    ${resp_msg}=	Post    /add_info   ${data}
    Should Be Equal	Personal info added	${resp_msg}
    Delete All Sessions

Test Get info success
    Open Session
    ${msg}=	Get	/person/1
    Should Contain      ${msg}	Record FOUND!!

Test update
    Open Session
    ${data}=	Create Dictionary	id  1   firstname   Supakarn   lastname    J.    age     24
    ${msg}=	Post	/add_info	${data}
    Should Be Equal	Personal info updated	${msg}

Test delete success
    Open Session
    ${msg}=	Get	/delete/1
    Should Be Equal	Personal info removed	${msg}

TestGet info fail
    Open Session
    ${msg}	Get	/person/1
    Sould Be Equal	Record not found	${msg}

Test delete fail
    Open Session
    ${msg}	Get	/delete/1
    Should Be Equal	Invalid id	${msg}
