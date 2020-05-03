import ast
import os
import sys
import math
import io
import re
from pathlib import Path
import csv
import json
import pickle
import pdb
import traceback
import collections
import typing
import threading
from typing import List,Dict,Tuple,Deque,Callable
import time
import glob
from datetime import datetime
import psycopg2
import numpy as np
import pandas as pd
from pandas import Series,DataFrame,read_csv,read_pickle
import numba
import numba.cuda
import vaex
import dill
from sortedcontainers import SortedDict
from IPython.lib.backgroundjobs import BackgroundJobManager
import fn_reflection
import lenv
import lcred
import lconn
import lpandas
import lpandas.pyutil as lpy
import lpandas.nputil as lnp
import lpandas.dfutil as ldf
import liberate
import liberate.dukascopy as dukascopy
import liberate.backtest as lbt
import liberate.search as lsearch
import liberate.signal as lsignal
import yf
import lbf
import liquid
import ltrade

def print_all(df,nrow=None,ncol=None):
    df_N,df_M = df.shape
    with pd.option_context('display.max_rows', min(df_N,nrow) if nrow else df_N, 'display.max_columns', min(df_M,ncol) if ncol else df_M):
        print (df)
