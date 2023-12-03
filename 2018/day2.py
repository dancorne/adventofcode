import sys

def count_repeats(inputdata, count=2):
    return len({x for x in inputdata for letter in x if x.count(letter) == count})

def challenge1(inputdata):
    return count_repeats(inputdata, 2) * count_repeats(inputdata, 3)

def similar(word1, word2):
    return any(word1[0:index] + word1[index + 1:] ==  word2[0:index] + word2[index + 1:] for index in range(0, max(len(word1), len(word2))))

def similar2(word1, word2):
    '''More readable function stolen from SO'''
    if word1 == word2:
        return False

    found = False
    for character1, character2 in zip(word1, word2):
        if character1 != character2:
            if found:
                return False
            else:
                found = True
    return True

def challenge2(inputdata):
    return [(word1, word2) for word1 in inputdata for word2 in inputdata if similar(word1, word2) and word1 != word2]

def challenge2_again(inputdata):
    words = set()
    for i in inputdata:
        for index in range(len(i)):
            word = i[0:index] + i[index + 1:]
            if word in words:
                return word
            words.add(word)

if __name__ == '__main__':
    with open('input/%s' % sys.argv[0][:-3], 'r') as file:
        inputdata = [line.strip() for line in file.readlines()]
    print(challenge1(inputdata))
    print(challenge2_again(inputdata))
