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
${URL_LOGIN}                      https://regis.linklian.org/registration/login
${BROWSER}                        Chrome
${USERNAME_SCHOOL}                registration@khp.ac.th
${PASSWORD_SCHOOL}                khpRegistration!
${USERNAME_UNI}                   info@kmutt.ac.th
${PASSWORD_UNI}                   kmuttRegistration!
${URL_HOME_SCHOOL}                https://regis.linklian.org/registration/home
${URL_HOME_UNI}                   https://www.saucedemo.com/

# Locators
${LOC_USERNAME}                   //*[@id="mantine-bb6h6b0z2"]
${LOC_PASSWORD}                   //*[@id="mantine-xjvqgr16q"]
${LOC_LOGIN_BTN1}                 //*[@id="mantine-a6tkggz0i"]
${LOC_LOGIN_BTN2}                 //*[@id="__next"]/div/div/div[4]/div/form/button
${LOC_LOGOUT_BTN}                 //*[@id="__next"]/div/div/div/div[2]/button[2]

*** Test Cases ***
LoginSchoolAccount
    [Documentation]    Login with a school account.
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    # Optional: Wait Until Location Contains    /registration/home
    Close App

LoginUniversityAccount
    [Documentation]    Login with a university account.
    Open App
    Input Credentials    ${USERNAME_UNI}    ${PASSWORD_UNI}
    Click Login Button
    Close App

*** Keywords ***
Open App
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Input Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${LOC_USERNAME}    10s
    Clear Element Text               ${LOC_USERNAME}
    Input Text                       ${LOC_USERNAME}    ${username}
    Clear Element Text               ${LOC_PASSWORD}
    Input Text                       ${LOC_PASSWORD}    ${password}

Click Login Button
    Click Element    ${LOC_LOGIN_BTN1}
    Click Element    ${LOC_LOGIN_BTN2}

Close App
    # ถ้าปุ่ม logout มีจริงค่อยกด ไม่งั้นก็ปิด browser เฉย ๆ
    Run Keyword And Ignore Error    Click Element    ${LOC_LOGOUT_BTN}
    Close Browser
    Click Element    //*[@id="__next"]/div/main/div/div/div/div[2]/div/div[1]/div/button[2]
    Click Element    //*[@id="mantine-831rcd1nj"]
    Click Element    /html/body/div[1]/div/main/div/div/div/div[2]/div/div[1]/div/button[2]
    Click Element    document.querySelector("#__next > div > main > div > div > div > div:nth-child(2) > div > div.flex.justify-between.items-center.mb-3.mt-1 > div > button:nth-child(3)")