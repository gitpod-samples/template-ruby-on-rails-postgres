const environment = require("./environment");
const { merge } = require("webpack-merge");

process.env.NODE_ENV = process.env.NODE_ENV || "development";
const defaultConfig = environment.toWebpackConfig();

if (process.env.GITPOD_WORKSPACE_URL) {
	const [protocol, hostname] = process.env.GITPOD_WORKSPACE_URL.split("://");

	// ex: https://3035-fuchsia-lamprey-16r2m3h5.ws-us14.gitpod.io
	const devServerPublic = `https://3035-${hostname}`;

	const mergedConfig = merge(defaultConfig, {
		devServer: {
			public: devServerPublic,
		},
	});

	module.exports = mergedConfig;
} else {
	module.exports = defaultConfig;
}
