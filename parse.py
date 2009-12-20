import sys, os, re

labels = {}

def parse_file(filename):
    global labels

    srcfile = open(filename, 'rt')
    lines = srcfile.readlines()
    srcfile.close()
    last_addr = '100'
    skip_comment = False

    for line in lines:
        line = line.strip()
        if (len(line) == 0):
            print
            continue
        if (line[0:3] == '###'):
            skip_comment = not skip_comment
        if (skip_comment):
            continue
        if (len(labels) > 0 and line[0:2] == '+.'):
            # special label
            continue
        if (line[0] == '#'):
            line = line[1:]
            line = line.split(' ')
            if line[0] == 'include':
                parse_file(line[1])
            continue
        if (len(labels) > 0):
            for (lbl, adr) in labels.iteritems():
                line = line.replace('{' + lbl + '}', adr)
        else:
            line = re.sub(r'^jmp\s*ne(ar)?.*$', r'db ea ff ff', line)
            line = re.sub(r'^jmp\s*far.*$', r'db ea ff ff ff ff', line)
            line = re.sub(r'^(jmp|j[zelgb]|jge|jle|jnz|jcxz).*$', r'db eb ff', line)
            line = re.sub(r'^call\s*ne(ar)?.*$', r'db 9a ff ff', line)
            line = re.sub(r'^call\s*far.*$', r'db 9a ff ff ff ff', line)
            line = re.sub(r'^call.*$', r'db e8 ff ff', line)
            line = re.sub(r'^loop.*$', r'db e2 ff', line)
            line = re.sub(r'{\..+}', last_addr, line)
        print line

# Gathering labels, etc.
def parse_debug_info(filename):
    global labels
    srcfile = open(filename, 'rt')
    lines = srcfile.readlines()
    srcfile.close()

    for line in lines:
        line = line.strip()
        if (len(line) == 0):
            continue

        line = line.split(' ', 1)
        # label
        if (len(line) == 2 and line[1][0:2] == '+.'):
            labels[line[1][1:]] = line[0].split(':')[1]

if (len(sys.argv) > 2):
    # two-pass mode
    parse_debug_info(sys.argv[2])

parse_file(sys.argv[1])
