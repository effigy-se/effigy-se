/// Slashco Stuff
/// The amount of fuel generators require.
GLOBAL_VAR_INIT(required_fuel, 4)
/// How many generators are active?
GLOBAL_VAR_INIT(active_generators, 0)
/// How many generators are required?
GLOBAL_VAR_INIT(required_generators, 2)
/// Have we spawned the generators?
GLOBAL_VAR_INIT(generators_spawned, FALSE)
/// Every possible generator spawn point.
GLOBAL_LIST_EMPTY(genstart)
/// Every possible plasma sheet spawn point. These are scattered, almost one per room.
GLOBAL_LIST_EMPTY(fuelstart)
/// Every possible item spawn point. These are scattered throughout the map.
GLOBAL_LIST_EMPTY(slashitemstart)
/// Every possible battery spawn point. These are always nearby generator spawnpoints.
/// TODO: In slashco proper, these spawn near the actual generators, not just their spawnpoints.
/// This will need some revisiting.
GLOBAL_LIST_EMPTY(batterystart)
