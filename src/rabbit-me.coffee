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
        images = $('img');
        picture = getRandomPicture(images)
        while !picture.contains('200_s')
            picture = getRandomPicture(images)
        msg.send picture.replace '200_s', 'giphy'


getRandomPicture = (images) ->
  random = Math.floor((Math.random() * images.length) + 1)
  images.each (i, elem) ->
    if i == random
      return $(this).attr('src')

