import sys
import re

claim_regex = re.compile('#(\d+) @ (\d+),(\d+): (\d+)x(\d+)')

def inches_used(claim):
    _, startx, starty, lengthx, lengthy = claim_regex.match(claim).groups()
    return [(x, y) for x in range(int(startx), int(startx) + int(lengthx)) for y in range(int(starty), int(starty) + int(lengthy))]

def find_overlapping(inputdata):
    used = set()
    overlapping = []
    for claim in inputdata:
        for square in inches_used(claim):
            if square in used:
                overlapping.append(square)
            else:
                used.add(square)
    return set(overlapping)

def challenge1(inputdata):
    return len(find_overlapping(inputdata))

def challenge2(inputdata):
    overlapping = find_overlapping(inputdata)
    for claim in inputdata:
        if all(coords not in overlapping  for coords in inches_used(claim)):
            return claim
            

if __name__ == '__main__':
    with open('input/%s' % sys.argv[0][:-3], 'r') as file:
        inputdata = [line.strip() for line in file.readlines()]
    print(challenge1(inputdata))
    print(challenge2(inputdata))
