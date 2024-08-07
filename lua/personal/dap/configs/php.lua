-- Import the 'dap' module
local dap = require('dap')


-- Configure the debugger adapter for PHP
dap.adapters.php = {
    type = "executable",
    command = "node",
   args = {
       require("mason-registry").get_package("php-debug-adapter"):get_install_path() .. "/extension/out/phpDebug.js",
   },
}

-- Debug configuratiolns specific to PHP
dap.configurations.php = {
    {
        type = "php",
        request = "launch",
        name = "Laravel",
        port = 9003,
        pathMappings = {
            ["/var/www/app"] = "${workspaceFolder}",
        },
    },
    {
        type = "php",
        request = "launch",
        name = "Symfony",
        port = 9003,
        pathMappings = {
            ["/app"] = "${workspaceFolder}",
        },
    },
    {
        type = "php",
        request = "launch",
        name = "Launch currently open script",
        program = "${file}",
        port = 9003,
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
    },
}
        require('dap').set_log_level('DEBUG')
