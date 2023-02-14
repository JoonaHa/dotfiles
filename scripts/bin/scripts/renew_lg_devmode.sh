#!/usr/bin/env bash

log_output() {
    local message="$1"
    local to_telegram=${2:-0}
    touch ${dir}/lg_renew.log

    printf "$(date --iso-8601=seconds): $message\n" | tee -a ${dir}/lg_renew.log
    
    if [[ "$to_telegram" -eq 1 ]]; then
        telegram_alert $message
    fi
}

telegram_alert() {
    local message=$1
    # TODO: Fix message quote escaping for telegram
    local api_url="https://api.telegram.org/bot${TELEGRAM_API_TOKEN}/sendMessage"
    local json='{ "chat_id": "%s", "text": "%s", "protect_content": "%s", "parse_mode": "%s" }'
    local payload=$(printf "$json" "$TELEGRAM_CHANNEL_ID" "Problem with *renew lg devmode*:\n\`"${message//\"/\\\"}"\`" "true" "MarkdownV2")

    local response=$(curl -s -X POST -H "Content-Type: application/json" -d "$payload" "$api_url")

    if [[ $(echo "$response" | jq '.ok') != "true" ]]; then
        log_output 'Telegram problem: '"$response"' Payload: '"$payload" 
    fi
    
}

main() {
    local dir=$(cd -P -- "$(dirname -- ${BASH_SOURCE[0]})" && pwd -P)

    if [[ ! -f  "${dir}/.env" ]]; then
        log_output "Can not find .env file ${dir}/.env" 1
        exit 1 
    else
        export $(cat ${dir}/.env | xargs)
    fi


    local url="https://developer.lge.com/secure/ResetDevModeSession.dev?sessionToken=${LG_TOKEN}"
    local response=$(curl -L "$url")
    if [[ $(echo $response | jq '.errorCode') != '"200"' ]]; then
        log_output "$response" 1
        return 1
    else
        log_output "$response"
        return 0
    fi

}
main "$@"
