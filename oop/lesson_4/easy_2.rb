# 1. Will return a string with a randomly chosen ending. 

# 2. Will return a string with an ending from RoadTrip

# 3. Ruby will look in the method, its modules, its ancestors (can be found 
#    with #ancestors on the class). 

module Taste; end

class HotSauce
  include Taste
end

p HotSauce.ancestors #=> [HotSauce, Taste, Object, Kernel, BasicObject]
# tabasco = HotSauce.new
# p tabasco.ancestors #=> NoMethodError because it's a class method, not instance method.

# 4. attr_accessor 

# 5. local, instance, class. Can tell by the prefix @, @@, or none.

# 6. class method name starts with self.

# 7. Keeps track of how many objects of the class have been created.
#    Test by creating new objects and calling Cats.cats_count

# 8. < Game

# 9. A Bingo game would use the play method from the Bingo class, not inherit.

# 10. Benefits of oop:

#     - DRYness when we can inherit methods
#     - defining new behaviors to go with objects 
#     - fun - allows for abstract thinking
#     - manage complexity, including with namespacing