*** Settings ***
#Library		SeleniumLibrary
Library		Selenium2Library

*** Variables ***
${URL}      http://:52.221.221.222:9080
${BROWSER}  chrome

*** Keywords ***
Open Website
    ${chrome_options}=  Evaluate		sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method		${chrome_options}	add_argument    --headless
    Call Method		${chrome_options}	add_argument	--no-sandbox
    Call Method		${chrome_options}	add_argument    --disable-dev-shm-usage
    Call Method		${chrome_options}	add_argument	--disable-gpu
    ${options}=		Call method	${chrome_options}	to_capabilities
#    Log To Console	${chrome_options}
    Log To Console	${options}
#    Create Webdriver    Chrome    executable_path=/usr/lib/chromium/chromedriver
#   Set Window Size  1280  800
    Create Webdriver    Chrome   desired_capabilities=${options}
#    Open Browser    ${URL}  browser=${BROWSER}	desired_capabilities=${options}
    Go To    ${URL}
    [Teardown]	Close All Browsers

Verify
    ${text}=    Get Text    xpath:/html/body/h1
    Log To Console  ${text}
    Log ${text}
    Should Be Equal     ${text}     Hello welcome to the site
    Close Browser

*** Test Cases ***
Test web
    Open Website
    Verify
