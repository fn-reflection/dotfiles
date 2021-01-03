np.set_printoptions(edgeitems=30, linewidth=100000,
                    formatter=dict(float=lambda x: "%.7g" % x))
try:
    lenv.ipython.register_event(10)
NameError:
    pass
try:
    lactivemodel.PG_10_10_10_4_M.bind(lactivemodel.MODELS)
NameError:
    pass
