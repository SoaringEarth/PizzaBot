
**Pizzabot**

*Installation Instructions:*
The playground should run automatically when opened.

**Improvements:**

Here are a few of the improvements that I'd like to make:
- Visual output, step by step generated ASCII grids showing pizzabot traversing the route
- Route optimisation, I implemented a very basic optimisation approach for finding the closest grid points and sorting from nearest to farthest
    implementing a solution based around the travelling salesman / vehicle routing problems would be more optimal.
- Better logging, I just have a few prints dotted around but ideally a better way of surfacing process updates would be nicer.

**Potential New Features:**

**PizzaBot Return to home:**
Have functionality to enable pizzabot to path home once all delivery locations have been visited and a pizza dropped off. Abandoning Pizzabot in the middle / end of its route doesn't seem fair and so providing logic to allow them to return back to the start location seems like the right thing to do. The functionality already exists It would be a case of creating a local route within the pizza bot from its current location (end of pizza delivery route) back to (0, 0) and sending it on it's way using the existing functions, though an additional flag for `returningToHome` might be useful to enable / disable specific functionality for example it shouldn't be using the `drop pizza` instruction when returning home.

**Support for Multiple PizzaBots:**
Have a new object which could be named `Dispatcher` which receives the input, splits the drop locations based on certain criteria (grid location, distance from start, etc) and dispatches a unique PizzaBot to complete each split of the route based on the chosen criteria. This feature ties to the following potential features below. 

**Support for PizzaBot to deliver to multiple routes:**
Be able to parse 2 separate routes from input, pass multiple routes to PizzaBot and in series PizzaBot should be able to complete a route, return to home, start the next route and continue that pattern until all routes are completed and PizzaBot returns safely home.

**Support for multiple delivery grids and multiple routes of mixed input:**
Take the scenario that many orders for delivery come in with a wide variety of grid locations, the first 10 could belong to different grids ((0, 0) to (5, 5) OR (0, 0) to (-5, -5) OR (0, 0) to (5, -5) etc) and PizzaBot / a new entity (named Dispatcher) should be able to take those locations, assign them to the correct grid and then dispatch a PizzaBot to make the deliveries.  

**- Code Optimisation:**

**Location.isWithinDeliveryZone** *(done)*

I originally had this method within Pizzabot but felt it wasn't it's responsibility so I moved it to inside Location, that way a location can check whether its within a given grid but I don't feel that comfortable with it being here either due to needing to know about the DeliveryMap entity. Perhaps this function could live within the DeliverMap object as it already knows about Locations which better fits with Single Responsibility principles.


**Pizzabot.optimiseRoute** *(done)*
This I feel could be refactored to a "Optimiser" class that can handle/perform different kinds of optimisations on the route.


**Use Regex pattern matching** *(done):*

I initially implemented this feature using high order functions which turned out to work but be messy the implementation had everything in one place for parsing the input and while did support error handling and was quite robust in terms of catching failing inputs wouldn't stand up to scutiny.
Updating the implementation to use a pattern matching system would prove to be more testable, reliable, and stand up to production test cases.
