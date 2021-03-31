const { environment } = require('@rails/webpacker');

module.exports = environment;

const ForkTsCheckWebpackPlugin = require('fork-ts-checker-webpack-plugin');
const path = require('path');

environment.plugins.append(
  'ForkTsCheckerWebpackPlugin',
  new ForkTsCheckWebpackPlugin({
    typescript: {
      configFile: path.resolve(__dirname, '../../tsconfig.json')
    },
    async: false,
  })
);