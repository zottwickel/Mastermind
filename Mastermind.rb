
$colors = ["maroon", "red", "pink", "brown", "tan" , "orange", "yellow", "lime", "olive" , "green", "mint", "cyan", "turquoise" , "blue", "indigo", "purple", "black", "gray", "white", "transparent"]

def start
	puts "****Welcome to Mastermind****

	"
	puts "Here are the words to guess from:
	"
	$colors.each {|x| puts x + "\n"}
	puts "
Who guesses the word? (type \"me\" or \"you\")"
	$player = gets.chomp.downcase
	$my_color = $colors[rand($colors.length)]
	unless $player == "me" || $player == "you"
		system 'clear'
		puts "ERROR! Please type \"me\" or \"you\" without quotes."
		start
	end
end

def play_again?
	@choice = ""
	while @choice != "y" && @choice != "n"
		puts "Play again? (y/n)"
		@choice = gets.chomp.downcase
		if @choice == "y"
			load "./Mastermind.rb"
		elsif @choice == "n"
			exit
		else
			system 'clear'
			puts "You must choose y or n!"
		end
	end
end

def cpu_word
	$my_color = $colors[rand($colors.length)]
	counter = 12
	until counter == 0
		puts "Guess my color!"
		@guess = gets.chomp.downcase
		if $colors.include? @guess
			if @guess == $my_color
				system 'clear'
				puts "You're Right!! You WIN!"
				play_again?
			else
				counter -= 1
				system 'clear'
				puts "You're Wrong!! (#{counter.to_s} guesses left!)"
			end
		else
			system 'clear'
			puts "That color isn't on the list! Try from these:
			"
			$colors.each {|x| puts x + "\n"}
			puts "
			"
		end
	end
	system 'clear'
	puts "OUT OF GUESSES: GAME OVER! (The word was #{$my_color})."
	play_again?
end

def usr_word
	puts "Choose a word from the list:
	
"
	$colors.each {|x| puts x + "\n"}
	puts "
"
	@input = gets.chomp.downcase
	if $colors.include? @input
		$my_color = @input
	else
		system 'clear'
		puts "Sorry, your word isn't in the list!"
		usr_word
	end
	@wrong_guess = []
	12.times do
		while @wrong_guess.include? @guess
			@guess = $colors[rand($colors.length)]
		end
		if $my_color === @guess
			puts "I have guessed your word! It's #{$my_color}!"
			play_again?
		else
			puts "My guess is #{@guess}. I was wrong! Trying again..."
			@wrong_guess << @guess
		end
	end
	puts "I couldn\'t guess your word in 12 tries! You win!"
	play_again?
end

system 'clear'
start
case $player
when "me"
	system 'clear'
	puts "Try a color from the list!"
	$colors.each {|x| puts x + "\n"}
	puts "
"
	cpu_word
when "you"
	system 'clear'
	usr_word
else
	start
end