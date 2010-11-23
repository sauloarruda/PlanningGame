require 'spec_helper'

describe RandomSprintExecution do
  
    before(:all) do
      @dice_values = [2,3,4,5,6,7,8,9,10,11,12]
      @velocity_values = [-4,-4,-2,-2,0,0,1,1,2,2,4]
      @defects_values = [0,0,1,1,1,2,2,3,3,4,4]
      @technical_debt = [0,1,1,2,2,4]
    end

    it "should get value for velocity" do
      @velocity_values.each_index do |index|
        RandomSprintExecution.velocity(@dice_values[index]).should eql(@velocity_values[index])
      end
    end

    it "should get value for defects" do
      @defects_values.each_index do |index|
        RandomSprintExecution.defects(@dice_values[index]).should eql(@defects_values[index])
      end
    end
    
    it "should get value for technical debt" do
      0.upto(10) do |n|
        if (n < 5)
          RandomSprintExecution.technical_debt(n).should eql(@technical_debt[n])
        else
          RandomSprintExecution.technical_debt(n).should eql(@technical_debt[5])
        end
      end
    end
    
    it "should get ramdom data" do
      RandomSprintExecution.stub!(:roll_dice).and_return(11, 2)
      result = RandomSprintExecution.random_data
      result[:velocity].should eql(2)
      result[:defects].should eql(0)
    end
end