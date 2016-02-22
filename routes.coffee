title = "Cloud"

exports.index = (req, res) ->
    res.render "index", { title : title }

exports.partials = (req, res) ->
    res.render "partials/" + req.params.name, { title : title }
