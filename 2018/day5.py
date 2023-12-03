from collections import defaultdict

def challenge1(chars):
    ''' Took 29 seconds '''
    while True:
        for idx, char in enumerate(chars):
            try:
                if char.swapcase() == chars[idx + 1]:
                    del chars[idx:idx + 2]
                    if chars[idx].swapcase() == chars[idx +1]:
                        break
            except IndexError:
                return len(chars)

def challenge1_again(chars):
    ''' Took 0.044 seconds '''
    newline = [chars[0]]
    for letter in chars[1:]:
        try:
            if letter.swapcase() == newline[-1]:
                newline.pop()
            else:
                newline.append(letter)
        except IndexError:
            newline.append(letter)
    return(len(newline))

def challenge2(chars):
    ''' Took 24 minutes with challenge1, 0.7 seconds with challenge1_again '''
    results = defaultdict(int)
    for letter in set([x.lower() for x in chars]):
        removed = [x for x in chars if x not in [letter, letter.upper()]]
        results[letter] = challenge1(removed)
    return results




if __name__ == '__main__':
    inputdata = open('input/day5', 'r').read().strip()
    chars = list(inputdata)
    print(challenge1_again(chars))
    print(challenge2(chars))
