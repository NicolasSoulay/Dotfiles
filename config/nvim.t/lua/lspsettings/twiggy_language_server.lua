return {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        twiggy = {
            -- before 0.8.0:
            -- phpBinConsoleCommand = 'php bin/console',
            framework = 'symfony',
            phpExecutable = '/usr/bin/php',
            symfonyConsolePath = 'bin/console',
        },
    },
}
