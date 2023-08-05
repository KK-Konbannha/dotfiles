import toml


def pick_up_list(obj: dict, result: list = []):
    for key in obj.keys():
        if type(obj[key]) == dict:
            result = pick_up_list(obj[key], result)

        elif type(obj[key]) == list:
            result.extend(obj[key])

    return result


with open("./arch.toml") as f:
    obj = toml.load(f)
    data = toml.dumps(obj)
    print(data)
    result = pick_up_list(obj)
    print(result)
