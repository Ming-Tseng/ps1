\\10.1.21.151\filemajority

Get-ClusterQuorum

  PR Q  
  
  Cluster                    QuorumResource                            QuorumType
-------                    --------------                            ----------
SQL_B_OS                   PR Q                             NodeAndDiskMajority


get-help Set-ClusterQuorum -full 

Set-ClusterQuorum 
[-NodeMajority] 
[-NodeAndDiskMajority <string>] 
[-DiskOnly <string>] 
[-NodeAndFileShareMajority <string>] 
[-InputObject <psobject>] 
[-Cluster <string>] 

 [<CommonParameters>]
    