#!/bin/sh
ruby --retain "$RETENTION_DAYS" "$REPO" "$ACCESS_TOKEN"
