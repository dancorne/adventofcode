import sys
import datetime
import re
from collections import defaultdict, Counter

def parse_data(data):
    sleep_totals = defaultdict(datetime.timedelta)
    sleeps = defaultdict(list)
    data.sort()
    regex = re.compile('^\[(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})\] (wakes up|falls asleep|Guard #\d+ begins shift)$')
    for line in data:
        year, month, day, hour, minute, message = regex.match(line).groups()
        if message == 'falls asleep':
            asleep = datetime.datetime(int(year), int(month), int(day), int(hour), int(minute))
        elif message == 'wakes up':
            awake = datetime.datetime(int(year), int(month), int(day), int(hour), int(minute))
            sleep_totals[guard] += awake - asleep
            while asleep < awake:
                sleeps[guard].append(asleep.strftime('%H%M'))
                asleep = asleep + datetime.timedelta(minutes=1)
        elif "Guard" in message:
            guard = message[7:-13]
    return sleep_totals, sleeps

def challenge1(sleep_totals, sleeps):
    dopey = max(sleep_totals, key=(lambda k: sleep_totals[k]))
    min = Counter(sleeps[dopey]).most_common(1)[0][0]
    return int(dopey) * int(min)

def challenge2(sleeps):
    counts = {guard: Counter(sleep).most_common(1)[0] for guard, sleep in sleeps.items()}
    guard_maxmin = max(counts, key=(lambda k: counts[k][1]))
    guard_num = int(guard_maxmin)
    maxmin = int(counts[guard_maxmin][0])
    return guard_num * maxmin

if __name__ == '__main__':
    inputdata = open('input/%s' % sys.argv[0][:-3], 'r').read().splitlines()
    sleep_totals, sleeps = parse_data(inputdata)
    print(challenge1(sleep_totals, sleeps))
    print(challenge2(sleeps))


# Could probably have added the Guard number into the regex and put groups()
# into a single variable and then `if matches[6]: guard = matches[6]`.
# Could then get the timestamps with datetime(*matches)?
# defaultdict(Counter) could've been simpler
