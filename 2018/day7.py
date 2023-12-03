from collections import defaultdict
from string import ascii_uppercase
#Step L must be finished before step X can begin.

def parse_input(inputdata):
    #dependencies = defaultdict(list)
    dependencies = {x: [] for x in ascii_uppercase}
    for line in inputdata:
        before = line[5]
        after = line[36]
        dependencies[after].append(before)

    steps = set(list(dependencies.keys()) + [item for value in dependencies.values() for item in value])

    return steps, dependencies

def take_next_step(steps, done, dependencies):
        available_steps = [x for x in steps if not dependencies[x] and x not in done]
        step_taken = sorted(available_steps)[0]
        done.append(step_taken)
        new_dependencies = defaultdict(list)
        for step in [x for x in steps if x not in done]:
            new_dependencies[step] = [x for x in dependencies[step] if x not in done]
        return steps, done, new_dependencies


def challenge1(inputdata):
    done = []
    steps, dependencies = parse_input(inputdata)
    while len(steps) != len(done):
        steps, done, dependencies = take_next_step(steps, done, dependencies)
    return "".join(done)    


def challenge2(inputdata):
    time = 0
    done = []
    workers = {x: ('', 0) for x in ascii_uppercase[0:5]}
    steps, dependencies = parse_input(inputdata)
    new_dependencies = dependencies
    while len(steps) != len(done):
    #while time  < 65:
        for worker, work in workers.items():
            if work[1] == 0:
                if work[0] != '' and work[0] not in done:
                    done.append(work[0])
                dependencies = {after: [x for x in dependencies[after] if x not in done] for after, _ in dependencies.items()}
                available_steps = sorted([x for x in steps if not dependencies[x] and x not in done and x not in [y[0] for y in workers.values()]])
                try:
                    step_taken = available_steps.pop(0)
                    workers[worker]= (step_taken, ord(step_taken) - 4)
                except IndexError as e:
                    continue
#        for step in [x for x in steps if x not in done]:
#            dependencies[step] = [x for x in dependencies[step] if x not in done]

        print(time, workers)
        workers = {worker: (work[0], 0) if work[1] == 0 else (work[0], work[1]-1) for worker, work in workers.items()}
        time += 1

    return time - 2 , done, len(set(done))


if __name__ == '__main__':
    inputdata = open('input/day7', 'r').read().splitlines()
    print(challenge1(inputdata))
    print(challenge2(inputdata))
