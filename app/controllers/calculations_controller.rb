class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.strip.gsub(/[^a-z0-9\s]/i, "").gsub(" ","").length

    @occurrences = @text.gsub(/[^a-z0-9\s]/i, "").downcase.split.count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def payment (r,n,p)
    r = r / 12 / 100
    n = n * 12
    pmt = (p * r * (1 + r)**n)/(((1 + r)**n) - 1)
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = payment(@apr,@years,@principal)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60.0
    @hours = @minutes/60.0
    @days = @hours/24.0
    @weeks = @days/7.0
    @years = @seconds/60.0/60.0/24.0/365.0

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.sort.first

    @maximum =  @numbers.sort.last

    @range = @maximum-@minimum

    if @count%2==0
      number1=@count/2-1
      number2=@count/2
      @median=(@sorted_numbers[number1]+@sorted_numbers[number2])/2
    end

    if @count%2==1
      number1=(@count+1)/2-1
      @median=@sorted_numbers[number1]
    end

    @sum = @numbers.sum

    @mean = @sum/@count

    addingvariance=[]
    @numbers.each do |num|
      variancenumber=(num-@mean)**2
      addingvariance.push(variancenumber)
    end

    @variance = (addingvariance.sum)/@count

    @standard_deviation = @variance**0.5

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @numbers.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
