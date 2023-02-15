local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/path/to/workspace-root/' .. project_name

local config = {
    cmd = {
        '/usr/bin/jdtls',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    },

    root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),

    settings = {
        java = {
            project = {
                referencedLibraries = {
                    '/usr/lib/jvm/java-19-openjdk/lib/javafx/javafx-swt.jar',
                    '/usr/lib/jvm/java-19-openjdk/lib/javafx/javafx.base.jar',
                    '/usr/lib/jvm/java-19-openjdk/lib/javafx/javafx.controls.jar',
                    '/usr/lib/jvm/java-19-openjdk/lib/javafx/javafx.fxml.jar',
                    '/usr/lib/jvm/java-19-openjdk/lib/javafx/javafx.graphics.jar',
                    '/usr/lib/jvm/java-19-openjdk/lib/javafx/javafx.media.jar',
                    '/usr/lib/jvm/java-19-openjdk/lib/javafx/javafx.swing.jar',
                    '/usr/lib/jvm/java-19-openjdk/lib/javafx/javafx.web.jar'
                }
            }
        }
    },

    init_options = {
        bundles = {}
    },
}
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.java" },
    callback = function()
        vim.api.nvim_command("%!/usr/bin/google-java-format -aosp -")
    end,
})

require('jdtls').start_or_attach(config)
