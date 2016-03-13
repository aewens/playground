Firebase = require "firebase"
fs = require('fs');

title = "Cloud"

exports.index = (req, res) ->
    res.render "index", { title : title }

exports.test_api = (req, res) ->
    value = req.params.data
    version = req.originalUrl.split("/")[2]
    search = req.query
    delete search["__proto__"]

    file = "public/javascripts/config.json"

    obj = JSON.parse(fs.readFileSync(file, "utf8"))

    ref = new Firebase(obj.db).child("api/test")

    info =
        value: value
        version: version
        search: search

    ref.push(info)
    console.log info

    res.redirect "/#/?data=#{value}"

exports.partials = (req, res) ->
    res.render "partials/" + req.params.name, { title : title }
