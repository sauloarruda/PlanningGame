module ProjectsHelper
  
  def avg(sum, cont)
    value = sum.to_f/cont.to_f
    number_with_precision(value, :precision => 2, :separator => t('separator'))
  end
  
end
