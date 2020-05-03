def print_all(df,nrow=None,ncol=None):
    df_N,df_M = df.shape
    with pd.option_context('display.max_rows', min(df_N,nrow) if nrow else df_N, 'display.max_columns', min(df_M,ncol) if ncol else df_M):
        print (df)
