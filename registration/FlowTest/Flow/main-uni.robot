*** Settings ***
Resource    ../Common/login.robot
Resource    ../University/02-basic-info.robot
Resource    ../University/03-course-work.robot
Resource    ../University/04-scheduling-work.robot
Resource    ../University/05-student-registration-work.robot

Suite Setup       LoginUniversityAccount
Suite Teardown    Close Browser

*** Keywords ***

Complete University Registration Flow
    [Documentation]    Complete university registration flow including all steps with CSV imports.
    Basic Info Flow
    Course Work Flow
    Scheduling Work Flow
    Student Registration Flow
