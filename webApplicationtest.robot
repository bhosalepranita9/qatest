*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${BROWSER}    chrome    # Specify the browser you want to use
${URL}        http://ipmon95    # Replace with your web application URL

*** Test Cases ***
Open Web Application Page
    Open Browser    ${URL}    ${BROWSER}
    Sleep    30s
    Page Should Contain    Hello from the Backend!    # Verified Page Content
    Close Browser
