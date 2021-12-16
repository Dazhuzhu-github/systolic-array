import numpy as np
weight = np.load('./weight.npy',encoding = "latin1")  #加载文件
activate = np.load('./inputmodel.npy',encoding = "latin1")  #加载文件
output = np.load('./outputresult.npy',encoding = "latin1")  #加载文件
# doc = open('1.txt', 'a')  #打开一个存储文件，并依次写入
# print(test, file=doc)  #将打印内容写入文件中
print(activate.shape)
print(weight.shape)
print(output.shape)
print(output[0])
