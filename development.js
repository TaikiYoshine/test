import path from 'path'

const src  = path.resolve(__dirname, 'src')
const dist = path.resolve(__dirname, 'dist')
const ManifestPlugin = require('webpack-manifest-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')

// モード値を production に設定すると最適化された状態で、
// development に設定するとソースマップ有効でJSファイルが出力される

export default {
  mode: 'development',
  entry: [
         './src/js/testA.js',
  ],

  output: {
    path:  '/Users/yoshine-taiki/practice/practice_app3/public/packs/javascripts',
    filename: '[name]-[hash].js',
    //publicPath: 'http://localhost:8080/', // webpack-dev-serverのURLを指定する
  },

  module: {
    rules: [
      {
        test: /\.jsx$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          presets: ["@babel/preset-env"],
        },
      }
    ]
  },

  resolve: {
    extensions: ['.js', '.jsx']
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: src + '/index.html'
    }),
    new ManifestPlugin(),  // manifest.jsonを出力するプラグイン
  ]
}