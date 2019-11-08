const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)


const webpack = require('webpack');
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/dist/jquery',
    jQuery: 'jquery/dist/jquery',
    Popper: 'popper.js/dist/popper'
  })
)

const datatables = require('./loaders/datatables')
environment.loaders.append('datatables', datatables)

module.exports = environment
