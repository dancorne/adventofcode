def challenge1(numbers):
    return sum(numbers)

def challenge2(numbers, frequency=0, frequencies={0}):
    for number in numbers:
        frequency = frequency + number
        if frequency in frequencies:
            return frequency
        frequencies.add(frequency)
    return challenge2(numbers, frequency, frequencies)


if __name__ == '__main__':
    with open('input/day1', 'r') as file:
        numbers = [int(line.strip()) for line in file.readlines()]
    print(challenge1(numbers))
    print(challenge2(numbers))


# from itertools import accumulate, cycle
# seen = set()
# print(next(f for f in accumulate(cycle(numbers)) if f in seen or seen.add(f)))
