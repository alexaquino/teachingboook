module DashboardHelper
  def gender_percent(options)
    if options.include?(:of) && [:males, :females].include?(options[:of])
      format(:value => percentage(options[:of]))
    end
  end

  private
  def format(options)
    case options[:value].class.name
      when 'Float'
        (options[:value] * 100).round(2)
      else
        options[:value]
    end
  end

  def percentage(gender)
    eval("@#{gender}") / genders_total
  end
end
