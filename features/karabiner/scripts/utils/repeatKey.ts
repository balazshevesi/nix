import { toKey, type ToKeyParam } from "karabiner.ts";

export const repeatKey = (key: ToKeyParam, count: number) =>
  Array.from({ length: count }, () => toKey(key));
