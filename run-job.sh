#!/bin/sh
ruby github-delete-old-branches.rb --retain="$RETENTION_DAYS" "$REPO" "$ACCESS_TOKEN"
