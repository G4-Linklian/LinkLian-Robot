*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Library           RequestsLibrary
Library           String
Library           BuiltIn
Library           DateTime
Library           JSONLibrary

*** Variables ***
${URL_LOGIN}                      https://uat-app.linklian.org/registration/login
${BROWSER}                        Chrome
${USERNAME_SCHOOL}                registration@khp.ac.th
${PASSWORD_SCHOOL}                khpRegistration!
${USERNAME_UNI}                   info@kmutt.ac.th
${PASSWORD_UNI}                   kmuttRegistration!
${URL_HOME_SCHOOL}                https://uat-app.linklian.org/registration/home
${URL_HOME_UNI}                   https://uat-app.linklian.org/registration/home

*** Keywords ***

LoginSchoolAccount
    [Documentation]    Login with a school account.
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button

Open App Sch
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Input Credentials Sch
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    id=input-email    10s
    Input Text    //*[@id="input-email"]    ${username}
    Input Text    //*[@id="input-password"]    ${password}

Click Login Button Sch
    Click Element    //*[@id="rememberMe"]
    Click Element    //*[@id="submit-button"]

Close App Sch
    Close Browser

LoginUniversityAccount
    [Documentation]    Login with a university account.
    Open App Uni
    Input Credentials Uni    ${USERNAME_UNI}    ${PASSWORD_UNI}
    Click Login Button

Open App Uni
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Input Credentials Uni
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    id=input-email    10s
    Input Text    //*[@id="input-email"]    ${username}
    Input Text    //*[@id="input-password"]    ${password}

Click Login Button Uni
    Click Element    //*[@id="rememberMe"]
    Click Element    //*[@id="submit-button"]

Close App Uni
    Close Browser