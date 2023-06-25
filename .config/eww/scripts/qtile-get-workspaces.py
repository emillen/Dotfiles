#!/usr/bin/env python3
import json
from libqtile.command.client import CommandClient

command_client = CommandClient()

items = []


class SetEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, set):
            return list(obj)
        return json.JSONEncoder.default(self, obj)


for name, item in command_client.call("groups").items():
    if item["screen"] is None:
        item["screen"] = -1
    if item["screen"] >= 0 or item["focus"] is not None:
        items.append(item)

print(json.dumps(items, cls=SetEncoder))
