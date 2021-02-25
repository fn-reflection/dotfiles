# pylint:disable=unused-import
# python standard modules
import ast
import collections
import csv
from datetime import datetime
import glob
import io
import itertools
import json
import math
import os
from pathlib import Path
import pdb
import pickle
import sys
import re
import threading
import time
import traceback
from typing import List, Dict, Tuple, Deque, Callable

# third-party libraries
try:
    import stringcase
except ModuleNotFoundError:
    pass

try:
    import dill
except ModuleNotFoundError:
    pass

try:
    from IPython.lib.backgroundjobs import BackgroundJobManager
except ModuleNotFoundError:
    pass

try:
    import matplotlib.pyplot as plt
except ModuleNotFoundError:
    pass

try:
    import numba
    import numba.cuda
except ModuleNotFoundError:
    pass

try:
    import numpy as np
except ModuleNotFoundError:
    pass

try:
    import pandas as pd
    from pandas import Series, DataFrame, read_csv, read_pickle
except ModuleNotFoundError:
    pass

try:
    import plotly
    from plotly.subplots import make_subplots
except ModuleNotFoundError:
    pass

try:
    import psycopg2
except ModuleNotFoundError:
    pass

try:
    from sortedcontainers import SortedDict
except ModuleNotFoundError:
    pass

try:
    import vaex
except ModuleNotFoundError:
    pass

# my public libraries
try:
    import fn_reflection
    from fn_reflection.typed_dict import *
except ModuleNotFoundError:
    pass

# my private libraries
try:
    import lactivemodel
except ModuleNotFoundError:
    pass

try:
    import lbf
except ModuleNotFoundError:
    pass

try:
    import lconn
except ModuleNotFoundError:
    pass

try:
    import lcred
except ModuleNotFoundError:
    pass

try:
    import lenv
except ModuleNotFoundError:
    pass

try:
    import liberate
    import liberate.search as lsearch
    import liberate.signal as lsignal
except ModuleNotFoundError:
    pass

try:
    import lpandas
    import lpandas.pyutil as lpy
    import lpandas.nputil as lnp
    import lpandas.dfutil as ldf
except ModuleNotFoundError:
    pass

try:
    import ltrade
except ModuleNotFoundError:
    pass

# notebookファイルの上にプロジェクトディレクトリがあると想定しておりそれをjupyterでreloadできるようにしたい。
# あまりよくない書き方だが使えはする
if Path.cwd().name == 'notebook':
    sys.path.append("../")
