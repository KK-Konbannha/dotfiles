local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/path/to/workspace-root/' .. project_name

local config = {
    cmd = {
        '/usr/bin/jdtls'
    },

    root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),

    settings = {
        java = {
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
