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
        picture = getRandomPicture($, images)
        maxTries = 5
        while maxTries > 0 and picture and !picture.indexOf('200_s') > 0
          picture = getRandomPicture($, images)
          maxTries--
        msg.send picture.replace '200_s', 'giphy'


getRandomPicture = ($, images) ->
  random = undefined
  returnVal = undefined
  random = Math.floor(Math.random() * images.length + 1)
  returnVal = ''
  images.each((i, elem) ->
    if i == random
      returnVal = $(this).attr('src')
    return
  )
  returnVal

