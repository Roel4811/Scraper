const { environment } = require('@rails/webpacker');

environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader'
});

const webpack = require('webpack');
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  jquery: 'jquery',
  'window.jQuery': 'jquery',
  Popper: ['popper.js', 'default'],
}));

module.exports = environment;
