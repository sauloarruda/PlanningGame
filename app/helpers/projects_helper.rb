module ProjectsHelper
  
  def avg(sum, i)
    value = sum.to_f/i.to_f
    number_with_precision(value, :precision => 2, :separator => t('separator'))
  end
  
end
