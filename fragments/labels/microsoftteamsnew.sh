microsoftteamsnew)
    name="Microsoft Teams (work or school)"
    type="pkg"
    teamsBuilds=$(curl -fs "https://config.teams.microsoft.com/config/v1/MicrosoftTeams/50_1.0.0.0?environment=prod&audienceGroup=general&teamsRing=general&agent=TeamsBuilds")
    appNewVersion=$(echo "$teamsBuilds" | jq -r '.BuildSettings.WebView2Canary.macOS.latestVersion')
    downloadURL="https://statics.teams.cdn.office.net/production-osx/$appNewVersion/MicrosoftTeams.pkg"
    expectedTeamID="UBF8T346G9"
    blockingProcesses=( MSTeams "Microsoft Teams" "Microsoft Teams WebView" "Microsoft Teams Launcher" "Microsoft Teams (work preview)")
    # msupdate requires a PPPC profile pushed out from Jamf to work, https://github.com/pbowden-msft/MobileConfigs/tree/master/Jamf-MSUpdate
    if [[ -x "/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate" && $INSTALL != "force" && $DEBUG -eq 0 ]]; then
        printlog "Running msupdate --list"
        "/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate" --list
    fi
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps TEAMS21 ) # --wait 600 # TEAM01
    ;;
