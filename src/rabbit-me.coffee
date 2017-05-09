# Description:
#   Robert Rosenberger
#
#
# Dependencies:
#   None
#
# Commands:
#   rabbit-me - Display a rabbit git
#
# Author:
#   Robert

fs = require 'fs'
cheerio = require 'cheerio'

module.exports = (robot) ->

  robot.hear /(^|.*\s)rabbit-me(\s.*|$)/gi, (msg) ->
    robot.http("https://giphy.com/search/rabbit")
      .get() (err, res, body) ->
        $ = cheerio.load body
        length = $('img').length;
        random = Math.floor((Math.random() * length) + 1)
        $('img').each (i, elem) ->
          if i == random
            src = $(this).attr('src')
            gifSrc = src.replace '200_s', 'giphy'
            msg.send gifSrc
        msg.send 'Rabbit'
