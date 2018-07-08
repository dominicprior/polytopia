# polytopia

Predicts the combat results, using the formula here: http://polytopia.wikia.com/wiki/Combat

For example, to see the result of a warrior attacking an archer, you type `w a`, and it replies with `6.0  1.5`, meaning the attacker causes 6 damage and the defender causes 2 (because 1.5 rounds up).

## Installing and running

- Clone this repo
- `stack build`
- `stack exec polytopia`

Then it simply waits for lines like `w a`.

## Examples

- `w8 r` - a warrior of health 8 attacking a fully healthy rider.
- `g sf` - a fully healthy giant attacking a swordsman who is standing in a forest or a town (i.e. with a x1.5 defence bonus).
- `c3 kff7` - a catapult of health 3 attacking a knight of health 7 in a fortified town (i.e. with a x4 defence bonus).
- `av12 m` - a veteran archer of health 12 attacking a fully healthy mind bender.
- `d s` - a defender attacking a swordsman.

The format is attacker, single space, defender.
An attacker or defender is a single letter, an optional v, an optional f or ff, and an optional health count.

Here is a demonstration that four catapults can defeat a giant.
```
c g
9.0  9.0
c g31
10.1  7.9
c g21
11.8  6.2
c g9
14.7  3.3
```

Here is a demonstration that a knight with health one can easily defeat a catapult in a fortified town.
```
k1 cff
15.8  0.0
```
