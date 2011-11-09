require 'yaml'

def process file
    h = YAML.load(File.read(file))
    
    m = h.entries
    
    begin
      c, m = test m.shuffle
      output_counts c, m
      output_mistakes m
    end while ask_repeat 
    
    STDIN.getc
end

def test entries
    correct = []
    mistakes = []
    
    for e in entries
        a, q = e                    
        
        puts "", q
        answer = STDIN.gets
        
        if normalize(answer) != normalize(a)
            puts a, "... is an expected answer. Does it matches to yours? [Ny]"
            ny = STDIN.gets.strip   # BUG: forgot: strip
            if ny.downcase == 'y'
                correct << e        # BUG: misuse: +=
            else
                mistakes << e       # BUG: misuse: +=
            end
        else
            correct << e            # BUG: misuse: +=
        end
    end
    
    [correct, mistakes]
end

def normalize s
    s.gsub(/\s+/, " ").strip.downcase
end

def output_counts c, m              # BUG: typo: count
    puts "
    ======
    correct: #{c.size}
    incorrect: #{m.size}
    ======
    "
end

def output_mistakes m
    puts "", m.map { |e| e.join ": " }
end

def ask_repeat
  puts "do you want to repeat? [Yn]"
  y = STDIN.gets.strip.downcase
  y == 'y' or y == ''
end

process ARGV[0]

# 50 min + ...
