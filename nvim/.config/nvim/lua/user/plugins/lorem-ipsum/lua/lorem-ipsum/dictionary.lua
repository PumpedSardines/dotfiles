local WORDS_IN_SENTENCE = { min = 5, max = 15 }
local SENTENCES_IN_PARAGRAPH = { min = 2, max = 7 }

local function random_int(min, max) return math.random(min, max) end

local function dictionary(dict)
  local function word() return dict[random_int(1, #dict)] end

  local function sentence(words_in_sentence)
    words_in_sentence = words_in_sentence or random_int(WORDS_IN_SENTENCE.min, WORDS_IN_SENTENCE.max)

    local words = {}
    for i = 1, words_in_sentence do
      words[i] = word()[i == 1 and 2 or 1]
    end

    return table.concat(words, " ")
  end

  local function sentence_combiner(sentences) return table.concat(sentences, ". ") .. "." end

  local function paragraph(words_in_paragraph)
    if words_in_paragraph then
      -- Defined word length

      if words_in_paragraph < WORDS_IN_SENTENCE.min then
        error("word count must be greater than " .. WORDS_IN_SENTENCE.min)
        return
      end

      local sentences_lengths = {}

      local words_left = words_in_paragraph
      while words_left > 0 do
        if words_left < WORDS_IN_SENTENCE.min then
          -- If there are less than min words left, just try again
          return paragraph(words_in_paragraph)
        end

        local sentence_length = random_int(WORDS_IN_SENTENCE.min, math.min(words_left, WORDS_IN_SENTENCE.max))
        sentences_lengths[#sentences_lengths + 1] = sentence_length
        words_left = words_left - sentence_length
      end

      local sentences = {}
      for i = 1, #sentences_lengths do
        sentences[i] = sentence(sentences_lengths[i])
      end

      return sentence_combiner(sentences)
    else
      -- Do everything random
      local sentences = {}
      local sentences_in_paragraph = random_int(SENTENCES_IN_PARAGRAPH.min, SENTENCES_IN_PARAGRAPH.max)
      for i = 1, sentences_in_paragraph do
        sentences[i] = sentence()
      end
      return sentence_combiner(sentences)
    end
  end

  return {
    word = word,
    sentence = sentence,
    paragraph = paragraph,
  }
end

return dictionary
