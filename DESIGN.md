# Design

When a pet enters an arena, the battlepets arena services caches a local copy of the battlepet (we also check to make sure the user is authorized to battle with this pet and cache that authorization). The battlepet representation includes a list of the pet's available actions, moves and their initial health.

When a pet is inside an arena, available actions are to move and make battle actions. If the battlepet is capable of the move or action, the response is successful and the action or move is put on the arena's battle queue.

The arena also listens for updates in its respective battlepets' health. 

## Resources

### Arenas

**Attributes**

* `dimensions`: 3-d array of arena space
* _[v2]_ `features`: An arena may have zero to many features, which impact possible movement of battling pets

**Actions**

* `GET /arenas` - list of arenas with links to enter
* `GET /arenas/:arena_name`
* `PATCH /arenas/:arena_name/enter`: (requires battlepet) returns ok unless arena is busy, returns link to start_contest if another battlepet is in the arena
* `PATCH /arenas/:arena_name/leave`: (requires battlepet) returns ok if in arena, if contest is active, battlepet has forfeited
* `GET /arenas/:arena_name/positions`
* `PATCH /arenas/:arena_name/move`: (requires battlepet) updates arena positions

* _[v2]_ `GET /features`

### Contests

**Attributes**

* `duration`: Length of contest, defaults to 0 seconds
* `type`: intelligence, stealth, brawn, or race
* `pets`
* `arena`
* `state`: either `finished` or `in_progress`
* `winner`
* `loser`

**Actions**

* `GET /contests`
* `POST /contests` - creates a new contest, enqueues a start and finish contest object. The finish contest object is delayed dependent on contest length.
* `GET,DELETE /contests/:contest_id`
* `PATCH /contests/:contest_id` update contest state (called by workers when contest is finished)
* `PATCH /contests/:contest_id/action` (requires battlepet and action) enqueues an action


### _[v2]_ Features

**Attributes**

* `type`
* `location`
* `size`

## Ideas

#### Technical

* Initiate arena objects as part of application launch

#### Features

* Does it matter if an arena is occupied?
* Schedule a battle?
* Cache pets in a battle (but they probably get updated too often on the pet management side)
* A battle of with could include a q&a request response cycle

