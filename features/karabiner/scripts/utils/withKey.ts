import {
  ifVar,
  map,
  withCondition,
  toUnsetVar,
  type FromKeyParam,
} from "karabiner.ts";
import { nanoid } from "nanoid";

type WithConditionArgs = Parameters<ReturnType<typeof withCondition>>[0];

export const withKey = (key: FromKeyParam, args: WithConditionArgs) => {
  const varName = `${key}_is_down_${nanoid()}`;
  return [
    map(key).toVar(varName).toAfterKeyUp(toUnsetVar(varName)),
    withCondition(ifVar(varName))(args),
  ];
};
