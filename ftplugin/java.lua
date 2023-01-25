-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = os.getenv("DATA_PROJ") .. project_name

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"/Library/Java/JavaVirtualMachines/jdk-17.0.2.jdk/Contents/Home/", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		"/Users/kartavyasharma/Library/Java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

		"-configuration",
		"/Users/kartavyasharma/Library/Java/jdtls/config_mac",

		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml", "gradlew" }),

	settings = {
		java = {
			-- configuration = {
			-- 	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
			-- 	-- And search for `interface RuntimeOption`
			-- 	-- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
			-- 	runtimes = {
			-- 		{
			-- 			name = "JavaSE-11",
   --                      path = "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/",
			-- 		},
			-- 		{
			-- 			name = "JavaSE-16",
   --                      path = "/Users/kartavyasharma/Library/Java/JavaVirtualMachines/openjdk-16.0.2/"
			-- 		},
			-- 	},
			-- },
		},
	},

	init_options = {
		bundles = {},
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
