module.exports = (max) ->
  if max?
    Math.floor(50 + Math.random() * max)
  else
    Math.floor(50 + Math.random() * 550)