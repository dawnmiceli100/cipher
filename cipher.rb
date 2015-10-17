class Cipher
  attr_reader :key

  ALPHABET = ("abcdefghijklmnopqrstuvwxyz")

  def initialize(key=nil)
    if key.nil?
      generate_random_key
    elsif key == ""
      raise(ArgumentError)  
    else
      key.each_char do |char|
        if (char == char.upcase) || (char == " ") || ("0123456789".include? char)
          raise(ArgumentError)
        end 
      end 
      @key = key 
    end   
  end 

  def generate_random_key
    @key = ALPHABET.split("").shuffle.join
  end 

  def get_indexes_of_characters(text)
    indexes = []
    text.each_char do |char|
      indexes << ALPHABET.index(char)
    end
    return indexes  
  end 

  def calc_indexes_of_cipher_characters
    @ciphertext_indexes = []
    @plaintext_indexes.each.with_index do |value, idx|
      cipher_index = value + @key_indexes[idx]
      cipher_index-=26 if cipher_index > 25
      @ciphertext_indexes << cipher_index
    end 
  end  

  def calc_indexes_of_plaintext_characters
    @plaintext_indexes = []
    @ciphertext_indexes.each_with_index do |value, idx|
      plaintext_index = value - @key_indexes[idx]
      plaintext_index+=26 if plaintext_index < 0
      @plaintext_indexes << plaintext_index
    end 
  end  

  def encode(plaintext)
    @key_indexes = get_indexes_of_characters(@key) 
    @plaintext_indexes = get_indexes_of_characters(plaintext)
    calc_indexes_of_cipher_characters
    @ciphertext = ""
    @ciphertext_indexes.each do |ci|
      @ciphertext << ALPHABET[ci]
    end 
    return @ciphertext 
  end
  
  def decode(ciphertext)
    @key_indexes = get_indexes_of_characters(@key) 
    @ciphertext_indexes = get_indexes_of_characters(ciphertext)
    calc_indexes_of_plaintext_characters
    @plaintext = ""
    @plaintext_indexes.each do |pi|
      @plaintext << ALPHABET[pi]
    end 
    return @plaintext
  end  
end

