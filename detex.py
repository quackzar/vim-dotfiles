#!/usr/bin/env python3

import re
import sys


def swallow(match):
    return ' ' * len(match.group(0))


def swallow_command(match):
    return ' ' * (len(match.group(1)) + 1) + ' ' + match.group(2) + ' '


def main():

    text = sys.stdin.read()
    text_len = len(text)

    # \hyp
    text = re.subn(r'(\w+)\\hyp\{\}(\w+)', r'   \1-\2  ', text)[0]
    text = re.subn(r'(\w+)\\fshyp\{\}(\w+)', r'    \1-\2   ', text)[0]

    # glossary entries
    def replace_glossary(match):
        text = match.group(2).replace('-', ' ')
        if match.group(1).endswith('pl'):
            text += 's'
        if match.group(1)[0].isupper():
            text = text[0].upper() + text[1:]
        text = ' ' * len(match.group(1)) + '  ' + text + ' '
        if match.group(1).endswith('pl'):
            text = text[1:]
        return text
    text = re.subn(r'\\((?:newdef)?[gG]ls(?:pl)?){((?:\w+-?)+?)}',
                   replace_glossary, text)[0]

    # acronyms
    def replace_acronym(match):
        return ' ' * len(match.group(1)) + '  ' + match.group(2) + ' '
    text = re.subn(r'\\([aA]cr.*?){(.+?)}',
                   replace_acronym, text)[0]

    # remove keypoints
    text = re.subn(r'\\keypoint\{.*?\}', swallow, text)[0]

    # remove autocites
    text = re.subn(r'~?\\[aA]utocite(?:\[.+?\])?\{.*?\}', swallow, text)[0]

    # Remove textcites
    def replace_textcite(match):
        template = 'Foo and Bar'
        return template + ' ' * (len(match.group(0)) - len(template))
    text = re.subn(r'\\[tT]extcite\{(.*?)\}', replace_textcite, text)[0]

    # citesoftware
    text = re.subn(r'\\(citesoftware)\{(.*?)\}', swallow_command, text)[0]

    # Remove common surrounding markup
    text = re.subn(r'\\(emph|texttt|textit|texttt|texthtt)\{(.*?)\}',
                   swallow_command, text)[0]

    # Remove abbreviations
    text = re.subn(r'\\eg\b', 'eg.', text)[0]
    text = re.subn(r'\\cf\b', 'cf.', text)[0]
    text = re.subn(r'\\ie\b', 'ie.', text)[0]

    # references
    text = re.subn(r'\\([vV]?ref)\{(.*?)\}', swallow_command, text)[0]

    # remove comments at line end
    text = re.subn(r'([^\\])%.*', '\\1', text)[0]

    # do not move things around too much
    print(text)

    assert len(text) == text_len


if __name__ == '__main__':
    main()
