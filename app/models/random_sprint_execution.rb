class RandomSprintExecution
  @@dice_values =     [  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12]
  @@velocity_values = [ -4, -4, -2, -2,  0,  0,  1,  1,  2,  2,  4]
  @@defects_values =  [  0,  0,  1,  1,  1,  2,  2,  3,  3,  4,  4]
  @@technical_debt =  [0,1,1,2,2,4]

  def RandomSprintExecution::random_data 
    dice1 = roll_dice
    dice2 = roll_dice
    return { :velocity => velocity(dice1), :defects => defects(dice2) }
  end
  
  def RandomSprintExecution::roll_dice
    2 + rand(6) + rand(6)
  end
  
  def RandomSprintExecution::velocity(dice_value)
    @@velocity_values[@@dice_values.index(dice_value)]
  end

  def RandomSprintExecution::defects(dice_value)
    @@defects_values[@@dice_values.index(dice_value)]
  end
  
  def RandomSprintExecution::technical_debt(defects)
    last_index = @@technical_debt.length - 1
    if (defects < last_index) 
      @@technical_debt[defects]
    else
      @@technical_debt[last_index]
    end
  end
  
end