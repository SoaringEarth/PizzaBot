
Pizzabot

The playground should run automatically when opened.


Improvements:

Here are a few of the improvements that I'd like to make:
- Visual output, step by step generated ASCII grids showing pizzabot traversing the route
- Route optimisation, I implemented a very basic optimisation approach for finding the closest grid points and sorting from nearest to farthest
    implementing a solution based around the travelling salesman / vehicle routing problems would be more optimal.
- Better logging, I just have a few prints dotted around but ideally a better way of surfacing process updates would be nicer.
- Code Optimisation:

Location.isWithinDeliveryZone (done)

I originally had this method within Pizzabot but felt it wasn't it's responsibility so I moved it to inside Location, that way a location can check whether its within a given grid but I don't feel that comfortable with it being here either due to needing to know about the DeliveryMap entity. Perhaps this function could live within the DeliverMap object as it already knows about Locations which better fits with Single Responsibility principles.


Pizzabot.optimiseRoute (done)
This I feel could be refactored to a "Optimiser" class that can handle/perform different kinds of optimisations on the route.


Use Regex pattern matching (done):

I initially implemented this feature using high order functions which turned out to work but be messy the implementation had everything in one place for parsing the input and while did support error handling and was quite robust in terms of catching failing inputs wouldn't stand up to scutiny.
Updating the implementation to use a pattern matching system would prove to be more testable, reliable, and stand up to production test cases.
