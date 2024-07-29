#!/usr/bin/python3
"""
pyscript that Exports to-do list information
 of all employees to JSON format."""
import json
import requests

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    users = requests.get(url + "users").json()

    with open("todo_all_employees.json", "w") as jsonfile:
        json.dump({
            z.get("id"): [{
                "task": x.get("title"),
                "completed": x.get("completed"),
                "username": z.get("username")
            } for x in requests.get(url + "todos",
                                    params={"userId": z.get("id")}).json()]
            for z in users}, jsonfile)
