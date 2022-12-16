fx_version 'cerulean'
games { 'gta5' }

author 'Joris#6599'
description 'Tout mes scripts'
url 'https://github.com/Joris-Fivem'

client_scripts {
    '@mfa_menu/dependency/menumanager.lua',
    ---------------------------------------
    'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}

shared_script 'config.lua'