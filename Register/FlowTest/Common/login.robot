*** Setting ***
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Library           RequestsLibrary
Library           String
Library           BuiltIn
Library           DateTime
Library           JSONLibrary
Library           ExcelLibrary

*** Variables ***
${URL_LOGIN}                      https://regis.linklian.org/registration/login
${BROWSER}                        Chrome
${USERNAME_SCHOOL}                registration@khp.ac.th
${PASSWORD_PASSWORD}              khpRegistration!
${USERNAME_UNI}                   info@kmutt.ac.th
${PASSWORD_UNI}                   kmuttRegistration!
${URL_HOME_SCHOOL}                https://regis.linklian.org/registration/home
${URL_HOME_UNI}                   https://www.saucedemo.com/


*** Test Cases ***

# LoginSchoolAccount
# LoginUniversityAccount

*** Keywords ***

LoginSchoolAccount
    [Documentation]    Test case for logging in with a school account.
    Open Browser
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_PASSWORD}
    Click Login Button
    Close Browser

LoginUniversityAccount
    [Documentation]    Test case for logging in with a university account.
    Open Browser
    Input Credentials    ${USERNAME_UNI}    ${PASSWORD_UNI}
    Click Login Button
    Close Browser

Open Browser
    Open                ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Input Credentials
    Input Text    //*[@id="mantine-bb6h6b0z2"]    ${USERNAME_SCHOOL}
    Input Text    //*[@id="mantine-xjvqgr16q"]    ${PASSWORD_PASSWORD}

Click Login Button
    Click Element    //*[@id="mantine-a6tkggz0i"]
    Click Element    //*[@id="__next"]/div/div/div[4]/div/form/button

Close Browser
    Click Element    //*[@id="__next"]/div/div/div/div[2]/button[2]