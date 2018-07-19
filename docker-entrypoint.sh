#!/usr/bin/env bash
echo "edit default settings from environment variables"
declare -A CONFIG

CONFIG["access_token"]=${TWITTER_ACCESS_TOKEN}
CONFIG["access_token_secret"]=${TWITTER_ACCESS_TOKEN_SECRET}
CONFIG["consumer_key"]=${TWITTER_CONSUMER_KEY}
CONFIG["consumer_secret"]=${TWITTER_CONSUMER_SECRET}
CONFIG["private_key"]=${VAPID_PRIVATE_KEY}
CONFIG["public_key"]=${VAPID_PUBLIC_KEY}

for KEY in ${CONFIG[@]}; do
    if [ "${CONFIG[${KEY}]}" != "" ] ; then \
        sed -i "s/\([ \t]*\"${KEY}\": \"\)[^\"]*\",/\1${CONFIG[${KEY}]//\//\\\/}\",/" /code/src/config.json
    fi
done

/usr/bin/supervisord
