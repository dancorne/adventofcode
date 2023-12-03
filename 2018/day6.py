
def manhattan_distance(coord1, coord2):
    return abs(coord1[0] - coord2[0]) + abs(coord1[1] - coord2[1])

def find_corners(coords):
    topleft = (min(x[0] for x in coords), min(y[1] for y in coords))
    topright = (max(x[0] for x in coords), min(y[1] for y in coords))
    bottomleft = (min(x[0] for x in coords), max(y[1] for y in coords))
    bottomright = (max(x[0] for x in coords), max(y[1] for y in coords))
    corners = [topleft, topright, bottomleft, bottomright]
    return topleft, topright, bottomleft, bottomright

def challenge1(coords):
    topleft, topright, bottomleft, bottomright = find_corners(coords)
    square = {(x, y) for x in range(topleft[0], topright[0] + 1) for y in range(topleft[1], bottomleft[1] +1)}
    nearest = {coord: set() for coord in coords}
    for point in square:
        dists = {manhattan_distance(coord, point): coord  for coord in coords}
        sort = sorted(dists.keys())
        if sort[0] == sort[1]:
            continue
        else:
            nearest[dists[sort[0]]].add(point)

    return max(len(value) for value in nearest.values())

if __name__ == '__main__':
    inputdata = open('input/day6', 'r').read().splitlines()
    lines = [tuple(x.strip().split(', ')) for x in inputdata]
    coords = [(int(point[0]),int(point[1])) for point in lines]
    print(challenge1(coords))
    #print(challenge2(coords))
