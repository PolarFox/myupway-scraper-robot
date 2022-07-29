*** Settings ***
Library     RPA.Browser.Playwright
Library     RPA.Robocorp.Vault
Library     RPA.Robocorp.WorkItems
Library     RPA.HTTP
Library     DateTime


*** Variables ***
${HEATPUMP}=    %{HEATPUMP_ID}


*** Keywords ***
Login
    ${secret}=    Get Secret    credentials
    RPA.Browser.Playwright.Open Browser    https://myupway.com
    RPA.Browser.Playwright.Focus    id=Email
    Keyboard Input    insertText    ${secret}[username]
    Focus    id=Password
    Keyboard Input    insertText    ${secret}[password]
    Click    .LoginButton

Fetch Data
    Go To    https://myupway.com/System/108516/Status/ServiceInfo
    Take Screenshot
    ${webdate}=    Get Current Date    result_format=dd%2Fmm%2Fyyyy+hh%3Amm%3Ass
    ${referer}=    Set Variable    https://myupway.com/System/${HEATPUMP}/Status/ServiceInfo
    ${headers}=    Create Dictionary
    ...    referer=${referer}
    ...    origin=https://myupway.com
    ...    Content-Type=application/x-www-form-urlencoded; charset=UTF-8
    Log    ${headers}
    &{res}=    Http
    ...    https://myupway.com/PrivateAPI/Values
    ...    method=POST
    ...    headers=${headers}
    ...    body=hpid=${HEATPUMP}&currentWebDate=${webdate}&variables=40067&variables=40014&variables=40013&variables=40004&variables=40083&variables=40081&variables=40079&variables=43005&variables=43161&variables=47276&variables=43009&variables=40071&variables=40008&variables=40012&variables=40033&variables=10033&variables=47214&variables=43081&variables=43084&variables=47212&variables=40121&variables=44302&variables=44308&variables=44300&variables=44306&variables=44298&variables=44304&variables=40072&variables=44896&variables=44897&variables=44908&variables=10069&variables=47411&variables=47410&variables=47409&variables=47408&variables=47407&variables=47412&variables=48745
    Log    ${res}
    Create Output Work Item
    Set Work Item Payload    ${res.body}
    Save Work Item
