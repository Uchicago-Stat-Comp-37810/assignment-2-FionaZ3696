# assign value 100 to a variable called cars
cars = 100
# assign value 4.0(a float) to a variable called space_in_a_car
space_in_a_car = 4.0
# assign value 30 to a variable called drivers
drivers = 30
# assign value 100 to a variable called passengers
passengers = 90
# define variable cars_not_driven as the difference of cars and drivers
cars_not_driven = cars - drivers
# define variable cars_driven to be the same as drivers
cars_driven = drivers
# define variable carpool_capacity as the multiplication of cars_driven and space_in_a_car
carpool_capacity = cars_driven * space_in_a_car
# define variable average_passengers_per_car as the division of passengers and cars_driven
average_passengers_per_car = passengers / cars_driven


#print out There are 100 cars available
print("There are", cars, "cars available.")
#print out There are only 30 drivers available.
print("There are only", drivers, "drivers available.")
#print out There will be 70 empty cars today.
print("There will be", cars_not_driven, "empty cars today.")
#print out We can transport 120.0 people today.
print("We can transport", carpool_capacity, "people today.")
#print out we have 90 to carpool today.
print("We have", passengers, "to carpool today.")
#print out we need to put about 3.0 in each car.
print("We need to put about", average_passengers_per_car,
      "in each car.")

# study drills questions
# 1) use 4.0 will give carpool_capacity = 30*4.0=120.0, while use just 4 will give carpool_capacity= 30*4=120
#    so it is necessary to write 4.0 if you want to keep the result accurate to 1 demical place
