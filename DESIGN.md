# Design

Only store information in one place. Since experience is an exact reflection of past contests, only use past contest data to evaluate experience (i.e. no need to store it in the battlepet management service).

_[v2]_

When a pet enters an arena, the battlepets arena services caches a local copy of the battlepet (we also check to make sure the user is authorized to battle with this pet and cache that authorization). The battlepet representation includes a list of the pet's available actions, moves and their initial health.

When a pet is inside an arena, available actions are to move and make battle actions. If the battlepet is capable of the move or action, the response is successful and the action or move is put on the arena's battle queue.

The arena listens for updates in its respective battlepets' health.

## Resources

### Contests

#### Contest Resource Representation

```json
{
    "battlepet_traits": "wit",
    "battlepets": ["Totoro","Luna"],
    "contest_type": "simple",
    "_self": "http://arena.battlepets.com/contests/1",
    "_result": "http://arena.battlepets.com/contest_results/1"
}
```

#### Contest Resource Attributes

* `contest_type`: Type of contest, only supported type at this time is `simple`.
* `battlepets`: array of battle pets participating in the contest.
* `battlepet_traits`: array of battle pet traits to evaluate in the contest.

_[v2]_

* `state`: either `finished` or `in_progress`
* `duration`: Length of contest, defaults to 0 seconds
* `arena`

#### Contest Resource Actions

**`POST /contests`**

Creates a new contest, enqueues the contest for evaluation by the referrees.

Request:

* Required parameters: `:type, :battle_pets`

Response:

* Successful Response:
    * HTTP Resonse Status: 201
    * HTTP Resonse Body: _See Contest Resource Representation_

### Contest Results

#### Contest Results Resource Representation

```json
{
    "winner": "Totoro",
    "loser": "Luna",
    "_contest": "http://arena.battlepets.com/contests/1",
    "_self": "http://arena.battlepets.com/contest_results/1"
}
```


### _[v2]_ Arenas

**Attributes**

* `dimensions`: 3-d array of arena space
* `features`: An arena may have zero to many features, which impact possible movement of battling pets

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


## Future Improvements

* Have timed contests and enqueue `ContestResult` objects for `TimedContestEvaluation` 
* Use arenas to initiate contests
* Seed arenas as part of launch
* Cache pets in a battle (but they probably get updated too often on the pet management side)
* A battle of wit could include a q&a request response cycle
