config = require "lapis.config"
import sql_password, session_secret from require "secret"

config "production", ->
    session_name "noskies"
    secret session_secret
    postgres ->
        host "127.0.0.1"
        user "postgres"
        password sql_password
        database "noskies"
    port 11029
    num_workers 2
    code_cache "on"
    githook true
