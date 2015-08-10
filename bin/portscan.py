#!/usr/bin/env python
from socket import *
     
tgtHost=input("what is the webaddress?: ")
tgtPorts=input("What are the ports seperated by commas?: ")
     
def connScan(tgtHost, tgtPort):
    try:
        connSkt=socket(AF_INET, SOCK_STREAM)
        connSkt.settimeout(10)    
        connSkt.connect((tgtHost, tgtPort))
        connSkt.settimeout(None)
        print('%d/tcp open' %tgtPort)      
        connSkt.close()
    except:
        print('[-]%d/tcp closed' %tgtPort)
     
def portScan(tgtHost, tgtPorts):
    try:
        tgtIP=gethostbyname(tgtHost)
    except:
        print("[-] Cannot resolve '%s': Unknown host" %tgtHost)
        return
    try:
        tgtName=gethostbyaddr(tgtIP)
        print('\n Scan results for: %s' %tgtName[0])  
    except:
        print('\n Scan results for: %s' %tgtIP)  
    tgtPorts = tgtPorts.split(',')
    for port in tgtPorts:
        print('Scanning port %s' %port)
        connScan(tgtHost, int(port))
     
def main():
    portScan(tgtHost, tgtPorts)
     
if __name__=='__main__':
    main()
