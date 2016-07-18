# Design

Only store information in one place. Since experience is an exact reflection of past contests, only use past contest data to evaluate experience (i.e. no need to store it in the battlepet management service).

_[v2]_

When a pet enters an arena, the battlepets arena services caches a local copy of the battlepet (we also check to make sure the user is authorized to battle with this pet and cache that authorization). The battlepet representation includes a list of the pet's available actions, moves and their initial health.

When a pet is inside an arena, available actions are to move and make battle actions. If the battlepet is capable of the move or action, the response is successful and the action or move is put on the arena's battle queue.

The arena also listens for updates in its respective battlepets' health.

## Resources

### Contests

#### Contest Resource Representation

#### Contest Resource Representation

```json
{
    "type": "wit",
    "winner": "Totoro",
    "loser": "Luna",
    "_self": "http://arena.battlepets.com/contests/1/"
}
```

#### Contest Resource Attributes

* `type`: wit, strength, agility, or senses
* `winner`: name of winning battlepet
* `loser`: name of lossing battlepet

_[v2]_

* `pets`
* `state`: either `finished` or `in_progress`
* `duration`: Length of contest, defaults to 0 seconds
* `arena`

#### Contest Resource Actions

**`POST /contests`**

Creates a new contest, enqueues the contest for evaluation by the referrees.

Request:

* Required parameters: `:pet_1, :pet_2, :type`
* Optional parameters: none

Response:

* Successful Response:
    * HTTP Resonse Status: 201
    * HTTP Resonse Body: _See Contest Resource Representation_

* `PATCH /contests/:contest_id`

Update contest. Called by referrees following contest evaluation.

Request:

* Required parameters: `:contest_id`
* Optional parameters: `:winner, :loser`

Response:

* Successful Response:
    * HTTP Resonse Status: 204
    * HTTP Resonse Body: none

* `GET /contests?pet=:name`

Get contests where pet with name `:name` participated.

Request:

* Required parameters: `:name`
* Optional parameters: none

Response:

* Successful Response:
    * HTTP Resonse Status: 200
    * HTTP Resonse Body: List of contest resources where pet with `:name` was either a winner or loser.

_[v2]_

* `GET,DELETE /contests/:contest_id`
* `PATCH /contests/:contest_id/action` (requires battlepet and action) enqueues an action

### _[v2]_ Arenas

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
* `GET /features`

### _[v2]_ Arena Features

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

