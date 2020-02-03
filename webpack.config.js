require('@babel/register'); // development.jsでES6を使えるようにする
const path = require('path')
module.exports = {
  mode: process.env.NODE_ENV || "development",
  entry: ["./src/js/testA.js"],
  output: {
    filename: "bundle.js",
    path: "/public/packs/javascripts"
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: "babel-loader",
        exclude: /node_modules/
      }
    ]
  }
};

