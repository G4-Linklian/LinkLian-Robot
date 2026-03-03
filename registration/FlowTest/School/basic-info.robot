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
${URL_SCHOOL}                     https://regis.linklian.org/registration/info
${URL_HOME_UNI}                   https://www.saucedemo.com/

*** Test Cases ***
InsertAcademicStaffData
    [Documentation]    Insert academic staff data into the system.
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    # Optional: Wait Until Location Contains    /registration/home
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

InsertStaffData
    Click Element    <button class="mantine-focus-auto mantine-active m_77c9d27d mantine-Button-root m_87cf2631 mantine-UnstyledButton-root" data-size="xs" type="button" style="--button-height: var(--button-height-xs); --button-padding-x: var(--button-padding-x-xs); --button-fz: var(--mantine-font-size-xs); --button-radius: var(--mantine-radius-md); --button-color: var(--mantine-color-white);"><span class="m_80f1301b mantine-Button-inner"><span class="m_811560b9 mantine-Button-label">เพิ่มบุคลากร</span></span></button>
    Click Element    //*[@id="__next"]/div/main/div/div/div/div[2]/div/div[1]/div/button[2]