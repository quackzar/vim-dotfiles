#!/usr/bin/env python3

import os
import subprocess
import sys

dir_path = os.path.dirname(os.path.realpath(__file__))

subprocess.call('cat ' + sys.argv[-1] + ' | '
                + os.path.join(dir_path, 'detex.py') + ' | '
                + 'languagetool ' + ' '.join(sys.argv[1:-1]),
                shell=True)