import { FromKeyParam, map, rule, ToKeyParam } from "karabiner.ts";

// Colemak-DHk, assuming Swedish ISO layout.

/*
Final layout:
+---+---+---+---+---+---+---+---+---+---+---+
| Q | W | F | P | B | J | L | U | Y | Ö | Å |
+---+---+---+---+---+---+---+---+---+---+---+
  +---+---+---+---+---+---+---+---+---+---+---+
  | A | R | S |_T_| G | K |_N_| E | I | O | Ä |
  +---+---+---+---+---+---+---+---+---+---+---+
    +---+---+---+---+---+---+---+
    | Z | X | C | D | V | M | H |
    +---+---+---+---+---+---+---+
*/

export const colemak = new Map<FromKeyParam, ToKeyParam>([
  // top row
  ["q", "q"],
  ["w", "w"],
  ["e", "f"],
  ["r", "p"],
  ["t", "b"],
  ["y", "j"],
  ["u", "l"],
  ["i", "u"],
  ["o", "y"],
  ["p", ";"],
  ["open_bracket", "open_bracket"],

  // home row
  ["s", "r"],
  ["d", "s"],
  ["f", "t"],
  ["h", "k"],
  ["j", "n"],
  ["k", "e"],
  ["l", "i"],
  [";", "o"],

  // bottom row
  ["z", "z"],
  ["x", "x"],
  ["c", "c"],
  ["v", "d"],
  ["b", "v"],
  ["n", "m"],
  ["m", "h"],
]);

const colemakMappings = Array.from(colemak, ([fromKey, toKey]) =>
  map(fromKey).to(toKey),
);
const colemakMappingsWithShift = Array.from(colemak, ([fromKey, toKey]) =>
  map(fromKey, "shift").to(toKey, ["shift"]),
);
export const qwertyToColemak = [
  rule("qwerty to colemak").manipulators(colemakMappings),
  rule("qwerty to colemak with shift").manipulators(colemakMappingsWithShift),
];
