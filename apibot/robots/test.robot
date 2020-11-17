*** Settings ***
Library     RequestsLibrary

*** Variable ***
${URL}  %{URL}

*** Test Case ***
Get Rrquests
    Create Session  sess  ${URL}
    ${res}=     Get Request     sess    /
    Log     ${res.status_code}
    Should Be Equal     ${200}  ${res.status_code}
