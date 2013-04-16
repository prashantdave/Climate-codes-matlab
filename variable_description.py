from scipy.io import netcdf
import csv

def variables_att(file_path):
 iterator=0
 all_data = netcdf.netcdf_file(file_path)
 list_of_variables = all_data.variables.keys()
 for i in list_of_variables:
    var = all_data.variables[i]
    all_att=dir(i)
    if hasattr(var,'long_name'):
        print(i, var.long_name, var.shape, var.dimensions) 
    elif hasattr(var,'full_name'):
        print(i, var.full_name, var.shape, var.dimensions)
    elif hasattr(var,'name'):
        print(i, var.name, var.shape, var.dimensions)
    else:
        print(i, "No description available", var.shape, var.dimensions)
    iterator = iterator+1
 print iterator
