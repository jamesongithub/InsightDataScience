require 'set'

frequencies = Hash.new(0) # assumes word space fits in memory
medians = Hash.new(0)
numMedians = 0

uniques = Set.new

ft2 = File.open("tweet_output/ft2.txt", "w")

def computeMedian(medians, numMedians)
    rank = 0
    median = nil
    lastMedian = nil
    medianRank = numMedians / 2.0
    odd = numMedians % 2 == 0 ? false : true

    medians.sort.map do |currentMedian, count|
        rank += count
        if rank > medianRank
            if lastMedian == nil or odd
                median = currentMedian
            else
                median = (lastMedian + currentMedian) / 2.0
            end
            break
        end
        lastMedian = currentMedian
    end

    return median
end

File.open("tweet_input/tweets.txt", "r") do |tweets|
  tweets.each_line do |line|
    uniques.clear()
    line.split.map do |word|
        frequencies[word] += 1
        uniques.add(word)
    end
    medians[uniques.size()] += 1
    numMedians += 1
    ft2.puts computeMedian(medians, numMedians)
  end
end

ft2.close

ft1 = File.open("tweet_output/ft1.txt", "w")
frequencies.sort.map do |word, frequency|
    ft1.puts "#{word} #{frequency}"
end

ft1.close
