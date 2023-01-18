local jdtls_dir = vim.fn.stdpath('data') .. '\\mason\\packages\\jdtls'
local config_dir = jdtls_dir .. '\\config_win'
local plugins_dir = jdtls_dir .. '\\plugins\\'
local path_to_jar = plugins_dir .. 'org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
local path_to_lombok = jdtls_dir .. '/lombok.jar'

local root_marker = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}
local root_dir = require('jdtls.setup').find_root(root_marker)

if root_dir == '' then
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. 'site/java/workspace-root' .. project_name
os.execute('mkdir' .. workspace_dir)

local config = {
  cmd = {
    'C:/Users/altres/AppData/Local/Programs/java18/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. path_to_lombok,
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', path_to_jar,
    '-configuration', config_dir,
    '-data', workspace_dir
  },
  root_dir = root_dir,
  settings = {
    java = {
      home = 'C:/Users/altres/AppData/Local/Programs/java',
      eclipse = {downloadSources = true},
      maven = {downloadSources = true},
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          name = 'JavaSE-8',
          path = 'C:/Users/altres/AppData/Local/Programs/java8'
        },
        {
          name = 'JavaSE-18',
          path = 'C:/Users/altres/AppData/Local/Programs/java18'
        }
      },
      implementationsCodeLens = {enabled = true},
      referencesCodeLens = {enabled = true},
      refernces = {includeDecompiledSources = true},
    },
    signatureHelp = {enabled = true},
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  }
}

config['on_attach'] = function(client, bufnr)
	require('lsp-keybind').on_attach(client, bufnr)
end

require('jdtls').start_or_attach(config)
