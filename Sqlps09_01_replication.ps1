C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps09_01_DGPA.ps1<#  Sqlps09_01_replication auther : ming_tseng    a0921887912@gmail.com createData : Mar.06.2014 history :  object :  #>

CREATE DATABASE [DB13NTPC3832]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB13NTPC3832', FILENAME = N'H:\SQLDB\DB13NTPC3832.mdf' , SIZE = 5120KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB13NTPC3832_log', FILENAME = N'H:\SQLDB\DB13NTPC3832_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO