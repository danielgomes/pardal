class Student < ActiveRecord::Base

  validates_uniqueness_of :registration

  def self.find_by_registration(registration_or_number)
    first :conditions => { :registration => registration_with_initial_letter(registration_or_number) }
  end

  def self.registration_with_initial_letter(registration_or_number)
    unless registration_or_number[0,1] =~ /[[:alpha:]]/
      letter = case registration_or_number[0,3].to_i
                 when (700..1000) then "A"
                 when (0...81) then "F"
                 when (81...700) then "H"
                 end
      registration_or_number = letter + registration_or_number
    end
    registration_or_number
  end

  def self.registration_check_number(registration_number)
    mult = (1..7).to_a.reverse
    sum = registration_number.chars.to_a.inject(0) do |s,char|
      s += char.to_i * mult.shift
    end

    digit = sum % 11
    digit = 11 - digit if digit > 1

    digit
  end

  def valid_mothers_name_initials?(initials)
    
  end

end