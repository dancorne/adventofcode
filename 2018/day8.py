
def get_nodes(chars):
    nodes = []
    for char in chars:
        children = chars.pop(0)
        metadata_count = chars.pop(0)
        metadata = chars[-1 - metadata_count: -1]
        del chars[-1 - metadata_count: -1]
        nodes.append((children, metadata_count, metadata))
    return

def challenge1(chars):
    for char in chars:
        pass


    return get_nodes(chars)

def challenge2(chars):
    return


if __name__ == '__main__':
    inputdata = open('input/day8', 'r').read().strip()
    chars = [int(x) for x in inputdata.split()]
    print(challenge1(chars))
    print(challenge2(chars))
