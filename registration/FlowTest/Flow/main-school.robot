*** Settings ***
Resource    ../Common/login.robot
Resource    ../School/02-basic-info.robot
Resource    ../School/03-course-work.robot
Resource    ../School/04-scheduling-work.robot
Resource    ../School/05-student-registration-work.robot

Suite Setup       LoginSchoolAccount
Suite Teardown    Close Browser

*** Keywords ***

Complete School Registration Flow
    [Documentation]    Complete school registration flow including all steps with CSV imports.
    Basic Info Flow
    Course Work Flow
    Scheduling Work Flow
    Student Registration Flow

