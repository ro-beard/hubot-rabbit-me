# Description:
#   Allows hubot to show up random rabbit-gifs from giphy
#
#
#
# Commands:
#   hubot rabbit-me: Shows URL to random rabbit-gif
#
# Author:
#   Robert Rosenberger
#

API_KEY = '279d30c866ad4f4f99d99c037a3b1f9d'
SEARCH = 'rabbit'
MAX_OFFSET = 1000
cheerio = require('cheerio')

module.exports = (robot) ->
  robot.hear /(^|.*\s)rabbit-me(\s.*|$)/gi, (msg) ->
    randomOffset = Math.floor(Math.random() * MAX_OFFSET)
    url = 'https://api.giphy.com/v1/gifs/search?api_key=' + API_KEY + '&q=' + SEARCH + '&offset=' + randomOffset
    robot.http(url).get() (err, res, body) ->
      json = JSON.parse(body)
      dataLength = json.data.length
      random = Math.floor(Math.random() * dataLength)
      msg.send json.data[random].images.original.url
