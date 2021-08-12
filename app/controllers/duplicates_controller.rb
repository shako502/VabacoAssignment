class DuplicatesController < ApplicationController
  def index
  end

  def create
    # GET String From Input
    string_to_count = params[:textToCount].downcase
    # Count Duplicate Chars
    duplicate_num = string_to_count.chars.uniq.count { |char| string_to_count.count(char) > 1 }

    ## Count repeatable chars
    # Convert string to array
    char_array = string_to_count.split('')
    # Sort array
    sorted_char_array = char_array.sort
    # Populate hash with letters as key and default value
    result = Hash[char_array.product([1])]
    # Define previous character
    prev_char = ''

    # Iterate over sorted array
    sorted_char_array.each { |c|
      if c == prev_char # Compare this character to saved character
        result[c] += 1 # Add value if matches
      end
      prev_char = c # If not save as previous character
    }

    # Return result as JSON object
    return render json: { count: duplicate_num, result: result}
  end
  
end
