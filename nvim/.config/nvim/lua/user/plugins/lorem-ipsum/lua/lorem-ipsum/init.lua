local dictionary = require "lorem-ipsum.dictionary"

local sv = require "lorem-ipsum.dicts.sv"
local en = require "lorem-ipsum.dicts.en"
local fr = require "lorem-ipsum.dicts.fr"

local function write_under_line(text)
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos + 1) .. text .. line:sub(pos + 2)
  vim.api.nvim_set_current_line(nline)
end

local M = {}

local function args_valid(args) return #args == 1 or tonumber(args[1]) ~= nil or tonumber(args[2]) ~= nil end

local function parse_args(args)
  local word_count = 20
  local language = "en"

  if args[2] == nil then
    word_count = tonumber(args[1])

    if word_count == nil then return { nil, args[1] } end

    return { word_count, nil }
  end

  word_count = tonumber(args[1]) or tonumber(args[2])

  language = tonumber(args[1]) == word_count and args[2] or args[1]

  return { word_count, language }
end

function M.write_lorem_ipsum(arguments)
  local args = arguments == nil and { nil, nil } or vim.split(arguments, " ")

  if not args_valid(args) then
    error "arguments are malformed"
    return
  end

  local word_count, language = unpack(parse_args(args))

  word_count = word_count or 20
  language = language or "en"

  if language == "en" then
    write_under_line(dictionary(en).paragraph(word_count))
  elseif language == "sv" then
    write_under_line(dictionary(sv).paragraph(word_count))
  elseif language == "fr" then
    write_under_line(dictionary(fr).paragraph(word_count))
  else
    error("Language not supported: " .. language)
  end
end

return M
