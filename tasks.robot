*** Settings ***
Documentation       Playwright template.

Library             RPA.Browser.Playwright
Library             RPA.Robocorp.Vault


*** Tasks ***
Login Task
    ${secret}=    Get Secret    credentials
    RPA.Browser.Playwright.Open Browser    https://myupway.com
    RPA.Browser.Playwright.Focus    id=Email
    Keyboard Input    insertText    ${secret}[username]
    Focus    id=Password
    Keyboard Input    insertText    ${secret}[password]
    Click    .LoginButton
