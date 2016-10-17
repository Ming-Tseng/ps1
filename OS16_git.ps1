<#
OS16_gitfilelocation : C:\Users\User\OneDrive\download\PS1\OS16_git.ps1\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\OS16_git.ps1\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS09_git.ps1


#>
ebook :  
\\172.16.220.33\d$\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\MyDataII\Android\
mydateII\android\learning_android_studio.pdf  chapter 6 

版本控管
    集中式:CVS、Subversion及Perforce等，採主從式架構，開發專案所有版本的檔案集中儲存在單一臺伺服器上
    分散式:遠端儲存庫上如GitHub上，擁有專案各版本的完整程式碼之外，在每一個開發者本機端也還設計了一個本地端儲存庫（Repository），也儲存了所有變更過的檔案，以及專案各版本的歷史紀錄。

#   20   https://github.com/Ming-Tseng  GitHub建立遠端儲存庫
#   28    git config --list   看 Git 設定內容
# 193  $ git init  建立一個新的 Repository  for local 
# 212   git status  檢查目前 Git 的狀態
# 231   Clone   (複製)別人的 Repository  git clone
# 250   Git的基本功(status, add, commit, log, .gitignore)
# 309  git branch
#   400  如何將別人 github 的Project 換成自已的 github  on Android Studio AS.
#   455  GIT合併  git merge  回復合併  快轉(Fast-Forward)合併   衝突
#   611  標籤
#   629  Git Flow練習
#   654  Stash暫存




#--------------------------------------------------------------------------------
#   20   https://github.com/Ming-Tseng  GitHub建立遠端儲存庫
#--------------------------------------------------------------------------------
{<#

password : p@ssw0rdgithub


##----1  從頭開始－新增遠端空白儲存庫、本地空白儲存庫  : 不勾選「Initialize this repository with a README」

這樣遠端儲存庫就建立好後，再來我們要將遠端儲存庫 clone下來：  不勾選「Initialize this repository with a README」
    # 不用先建r1同名資料夾
    git clone https://github.com/[GitHub帳號]/r1.git
        clone下來後，打開r1資料夾可以看到.git，表示已建立GIT版控， 輸入git log後並未有任何提交(commit)版本，所以要在本地建版本：
    
    cd r1
    echo 1 > README.md
    git add .
    git commit -m "init"
    # 上傳至遠端
    git push origin master


    查詢目前設定的遠端位置
    # 只查詢遠端名稱
            git remote
    # 遠端詳細位置
            git remote -v

接下來就可以在本地儲存庫開始開發的程式了，開發方式就和之前本地操作一模一樣， 可以新增檔案、修改檔案、將檔案git add到暫存區、git commit到本地儲存庫… 等，做任何的修改。
但要記得，這些修改都只是在本地而已，遠端儲存庫並不曉得你已經修改了， 如果你覺得本地修改的差不多了，想要將本地版本上傳至遠端，再執行git push就可以讓遠端也更新囉！
    git push


##----2  初始commit由遠端建立  要勾選「Initialize this repository with a README」
上一個方式不同，我們要直接在遠端儲存庫先建好版本(commit)，再複製到本地(Local )
樣先點選右上角「New Repository」，接下來比較不一樣， 我要勾選「Initialize this repository with a README」， 至於要不要選取gitignore檔或license檔，就由你自己決定了。

接著一樣將遠端儲存庫clone下來本地：
    # 不用先建r2同名資料夾
    git clone https://github.com/[GitHub帳號]/r2.git
    cd r2
切換進入r2資料夾後，可以看到.git表示已建立GIT版控， 輸入git log後也可以看到有一個提交(commit)版本， 而且r2資料夾裡會多一個README.md檔：
    git log
    commit d61e8c215cbe29b63ed5d76702050ad226635101
    Author: AMANI 
    Date:   Mon Oct 20 17:12:48 2014 +0800



##----3  將遠端已存在儲存庫，拷貝至本地空白儲存庫
    在辦公室進行程式開發，並且上傳版本至GitHub，表示已經有一個遠端儲存庫。 如果回家後想要將遠端儲存庫下載後持續開發，怎麼做？
    首先在家裡電腦執行以下指令
        # 不用先建同名資料夾
        git clone https://github.com/[GitHub帳號]/[遠端repo名稱].git
        cd [遠端repo名稱]

        that's all，接下來你就可以在家裡繼續加班coding囉 > <~~
        有沒有發現，方法就和之前新建一個帶有初始commit的儲存庫是一樣的。


##----4  將本地已存在的儲存庫(已有版控)，上傳至遠端儲存庫
        假設在本地有一個已經開發一段時間的GIT儲存庫，現在要上傳至遠端，怎麼做呢？

        假設本地有一儲存庫如下：
mkdir r3
cd r3
git init
echo 1 > file1.txt
git add file1.txt
git commit -m "C1"
echo 1 > file2.txt
git add file2.txt
git commit -m "C2"
echo 1 > file3.txt
git add .
git commit -m "C3"
echo 1 > file4.txt
git add .
git commit -m "C4"
echo 1 > file5.txt
git add .
git commit -m "C5"
echo 1 > file6.txt
git add .
git commit -m "C6"

首先在GitHub網站建立一個沒有初始版本(commit)的儲存庫， 也就是不勾選「Initialize this repository with a README」

接著將本地儲存庫上傳，但首先要先將本地與遠端儲存庫建立連結， 否則本地儲存庫不知道要上傳到哪裡去？ 建立連結的方式要下git remote add指令：
        # 若是command line輸入:
            git remote add origin https://github.com/[GitHub帳號]/r3.git
        # 若是Git Shell輸入：
            git remote set-url --add origin https://github.com/[GitHub帳號]/r3.git

        建好後，你可以下git remote來查詢遠端位置：
            git remote -v
        沒問題後，就可以將本地儲存庫上傳至GitHub囉：
            git push origin master
        若您的程式有建立其他分支或是標籤，在push時，請改成以下指令
            git push --all
            git push --tags

##----5  將本地的程式專案(未建立版控)，上傳至遠端儲存庫 
        如果你這幾年手邊有很多程式專案，一直沒有做版本控制，如果想要上傳至遠端儲存庫，怎麼做呢？
            首先GitHub遠端建一空白儲存庫，不勾選「Initialize this repository with a README」：
        
        接著當然將自己的程式專案建立Git版控囉：
            cd my-project
            git init
            git add --all
            git commit -m "init"
        建好版控制後，就可以上傳遠端了：
            # 若是command line輸入:
                git remote add origin https://github.com/[GitHub帳號]/my-project.git
            # 若是Git Shell輸入：
                git remote set-url --add origin https://github.com/[GitHub帳號]/my-project.git
            
            git push origin master   
#>}


#--------------------------------------------------------------------------------
#   28    git config --list   看 Git 設定內容
#--------------------------------------------------------------------------------
User@MTNB MINGW64 /d/work/VanessaRemember (master)
$ git config --list
core.symlinks=false
core.autocrlf=true
core.fscache=true
color.diff=auto
color.status=auto
color.branch=auto
color.interactive=true
help.format=html
http.sslcainfo=C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
diff.astextplain.textconv=astextplain
rebase.autosquash=true
credential.helper=manager
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.required=true
user.name=Ming-Tseng
user.email=a0921887912@gmail.com
core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
remote.origin.url=https://github.com/Ming-Tseng/VanessaRemember.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master

User@MTNB MINGW64 /d/work/VanessaRemember (master)
$
$ git config --global user.name  "Ming-Tseng"
$ git config --global user.email "a0921887912@gmail.com"
$ git config --global color.ui true            # Git 預設輸出是沒有顏色的，我們可以讓他在輸出時加上顏色讓我們更容易閱讀：
$ git config --global alias.st status          #Git 也有提供 alias 的功能，例如你可以將 git status 縮寫為 git st，git checkout 縮寫為 git co 等
$ git config --global apply.whitespace nowarn  # 忽略空白的變化

  git config --global  remote.origin.url "https://github.com/Ming-Tseng/BMI.git"

 git remote add origin https://github.com/Ming-Tseng/test.git

#--------------------------------------------------------------------------------
# 193  $ git init  建立一個新的 Repository  for local 
#--------------------------------------------------------------------------------
{<#
使用git init指令建立一個這個專案的儲存庫（Repository ）。這個目錄可稱為是這個專案的工作目錄（Working Directory），開發專案所有的檔案都儲存在這個目錄下，而執行與專案相關的Git指令，也都是在工作目錄下執行。

.git目錄下建立一個名稱為index的索引檔案，作為記錄專案所有檔案的處理狀態，
        (1)committed  :已提交（committed）檔案
        (2)modified   :已變更但尚未提交到本機儲存庫
        (3)staged     :已修改檔案中 標記出要作為提交到下一版本用:將需要提交的檔案標記為staged檔案。然後，才執行提交指令（commit），將staged檔案儲存到儲存庫中。

        使用GitHub來和其他人共享專案，開發者則需進一步使用Push指令，將本地端儲存庫的特定版本專案，推到遠端儲存庫上整併。下一次要展開開發工作時，則可先從遠端儲存庫將新版程式碼取回本地端儲存庫（此動作稱為Pull），再從本地端儲存庫放入工作目錄中（此動作稱為Checkout），就可繼續展開下一輪開發。

 ii d:\work\powershell
 git init 
#>}


#--------------------------------------------------------------------------------
# 212   git status  檢查目前 Git 的狀態
#--------------------------------------------------------------------------------
{<#
$ git status
On branch master  #On branch master 表示你目前正在名為 master 的 branch 上

Initial commit

nothing to commit (create/copy files and use "git add" to track)





#>}


#--------------------------------------------------------------------------------
# 231   Clone   (複製)別人的 Repository  git clone
#--------------------------------------------------------------------------------
{<#

複製（Clone）指令是把專案在遠端儲存庫上的所有內容複製到本地，建立起本機儲存庫及工作目錄
而叉（Fork）則是把別人專案的"遠端"儲存庫內容複製一份到自己的"遠端"儲存庫

$ git clone https://gogojimmy@github.com/gogojimmy/Animal.git
這個 Git Repository下載到我們的資料夾， git clone 預設會將下載的 git 存成一樣檔名的資料夾，如果你要更改成別的名稱的話只需要在網址後面加上你想要更改的名稱即可，像是：

$ git clone https://gogojimmy@github.com/gogojimmy/Animal.git monkey
要更改成別的名稱的話只需要在網址後面加上你想要更改的名稱即可，像是   Repository 的名稱就會從原本的 Animal 變成 monkey 了
#>}




#--------------------------------------------------------------------------------
# 250   Git的基本功(status, add, commit, log, .gitignore)
#--------------------------------------------------------------------------------
{<#

git add -i #  使用互動模式 git add -i ，在互動模式下你可以方便的選擇你要加入的檔案，或是移除剛剛不小心加入的檔案 (revert)


#---0
copy C:\Users\User\OneDrive\download\PS1\OS16_git.ps1 to D:\work\powershell

#---1
User@MTNB MINGW64 /d/work/powershell (master)
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        OS16_git.ps1

nothing added to commit but untracked files present (use "git add" to track)

#---2
使用 git add 這個指令來把它加入追蹤：
git add OS16_git.ps1   
#---3
原本 OS16_git.ps1 還在 Untracked files 中，經過我們使用 git add OS16_git.ps1後他就變成了 Changes to commit，
通常我們稱這個狀態叫做 stage ，修改過但還沒使用 git add 的檔案稱為 unstage 。
User@MTNB MINGW64 /d/work/powershell (master)
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   OS16_git.ps1
#--4
已經在 stage 狀態的檔案的下一步就是準備提交( commit )，commit 是寫程式時一個很重要的動作，一個 commit 在 Git 中就是一個節點，這些 commit 的節點就是未來你可以回朔及追蹤的參考，你可以想像就像是電玩遊戲時的存檔，每一個 commit 就是一次存檔，讓我們未來在需要的時候都可以回到這些存檔時的狀態。因此我們將剛剛做的修改提交

$ git commit #修改提交
$ git commit -m "Add test.rb to test git function"  # -m 快速提交
$ git commit -am "Add test.rb to test git function"  # -am  將所有未被 add 的檔案一併 add 進來
$ git commit -v   #列出更動的紀錄
$ git log #  查看過去 commit 的紀錄
$ git log -p #檔案更詳細的變更內容，你可以加上 -p 的參數
#--5



#>}



#--------------------------------------------------------------------------------
#  309  git branch
#--------------------------------------------------------------------------------
{<#
$ gitk --all  &    # 最基本的 Git GUI 叫做 gitk
$ git branch       # 列出所有的 branch 並告訴你目前正在哪個 branch
$ git branch cat    # 開一支新的 branch 叫做 cat
$ git checkout cat  #切換過去  cat  branch

add cat1.txt

$ git add cat1.txt
$ git commit -m "Add cat1.txt  1 commit "


##https://kingofamani.gitbooks.io/git-teach/content/chapter_3_branch/git.html

#建立本單元的工作環境：
mkdir d:\branch1
cd d:\branch1
git init
echo 1 > file1.txt
echo 1 > file2.txt
git add file1.txt
git commit -m "C1"
git add file2.txt
git commit -m "C2"


#查看目前分支只要下branch
git branch
* master

#要在master另開分支，例如要開feature分支
git branch feature
    git checkout -b feature  #  【git checkout -b feature】 = 【git branch feature】 + 【git checkout feature】
#要切換至新的分支上，用checkout指令
git checkout feature

git branch
gitk --all #看一下分支圖，此時兩分支皆指向C2這個commit


#不同分支進行作業 ;在feature分支建一個file3.txt檔案，並且提交(commit)
echo 1 > file3.txt
git add .
git commit -m "C3"

echo 1 > file4.txt
git add .
git commit -m "C4"
分支圖，想像一下長什麼樣子呢

#  換分支做事情了，先切換到master分支，接著建立file5.txt和file6.txt，並分別提交C5、C6兩個版本
git checkout master
echo 1 > file5.txt
git add .
git commit -m "C5"
echo 1 > file6.txt
git add .
git commit -m "C6"

#  如果將分支切換到master，此時開啟資料夾，
git checkout master
    file1.txt、file2.txt、file5.txt、file6.txt
切換至feature分支的檔案如下：
git checkout  feature
    file1.txt、file2.txt、file3.txt、file4.txt

#要刪除feature分支，記得要跳出此分支
git checkout master
git branch -d feature
git branch -D feature  # GIT怕你誤刪，如果此分支尚未和別的人支合併，是無法直接刪除的，必須透過branch -D來強制刪除
    


    C3、C4不見了，疑？之前在2-1節曾說過，刪除分支並不會刪掉提交(commit)啊！怎會這樣呢？ 其實C3、C4還在，只是「隱藏」起來罷了，我們來施點魔法找出來吧！

git reflog
git checkout [C4的SHA1值]  -> git checkout b6cb892 # 切換至C4 commit 但現在沒有名稱[feature] 原來GIT會自動建立一個HEAD指標，這個指標會指向目前分支的最新版本上
git checkout -b feature   #加回名稱
            其實在GIT裡開分支只是多一個指標而已，這個指標會指向該分支的最新Commit， 這個分支名稱儲存在.git\refs\heads中，打開feature可看到一串SHA1值表示此分支。 若要刪除分支，甚至只要把.git\refs\heads\feature刪除就搞定， 要復原只要再把這個feature檔再放回來即可， 因此開分支只是多了一個檔案，非常節省檔案資源，不要再把分支想得那…麼可怕了。



#>}




#--------------------------------------------------------------------------------
#   400  如何將別人 github 的Project 換成自已的 github  on Android Studio AS.
#--------------------------------------------------------------------------------
{<#
ex: 
from:https://github.com/android66/Bmi.git
to  :https://github.com/Ming-Tseng/BMI.git

Step1: 
AS.File > New > Project from versin Control > Github
           Git Repository URL: https://github.com/android66/Bmi.git
           ParentDirectory : D:\work
           Directory Name: atm
           --> Clone 
           --> New Windows 
                 ii  D:\work\atm  , note .git  
                 Run app
Step2: remove Version control
AS.File > settings > Version Control -> Direcotory -> unregistered Roots  -> apply

Step3: delete D:\work\atm\.git
        rm D:\work\atm\.git -Recurse -Force

Step4: create new gishub 
        https://github.com/Ming-Tseng/BMI.git

Step5 :
AS.  VCS -> Enable Version Control Integration ->
      select a versin control system to associate the project Roots : Git
       you can find out .git \

Step 6: add .
AS. project explore -> right mouse -> git - Add
 
Step 7; commit      
AS. project explore -> right mouse -> git - Commit Directory
    commit Message:  initial 

Step 8; push
AS. project explore -> right mouse -> git - Repository -> push (ctrl+shit+K)
    master ->  Define remote
               Name: origin
               URL :https://github.com/Ming-Tseng/atm.git
               push

Step 9; close project
AS. project explore 


其中step 4 ~ 9 為新建project

#>}



#--------------------------------------------------------------------------------
#   455  GIT合併  git merge  回復合併  快轉(Fast-Forward)合併   衝突
#--------------------------------------------------------------------------------
{<#
https://kingofamani.gitbooks.io/git-teach/content/chapter_3_branch/chapter_3_branchmerge.html


##----1 GIT合併 

gitk --all 
mkdir d:\merge1
cd d:\merge1
git init
echo 1 > file1.txt
echo 1 > file2.txt
git add file1.txt
git commit -m "C1"
git add file2.txt
git commit -m "C2"
------------------------------
git checkout -b bug
echo 1 > file3.txt
git add .
git commit -m "C3"
echo 1 > file4.txt
git add .
git commit -m "C4"
------------------------------
git checkout master
echo 1 > file5.txt
git add .
git commit -m "C5"
echo 1 > file6.txt
git add .
git commit -m "C6"


#要將bug合併到master分支 ,將bug分支合併進來
    git checkout master
    git merge bug   #做完合併動作後，也代表bug分支的階段性任務完成，通常會將此分支刪除，執行：   git branch -d bug

首先合併後GIT會自動多了一個提交(commmit)的版本，並自動加上說明Merge branch bug。
雖然合併了，但只有master往前推進一個版本(d6789aa)，而bug分支還是繼續停留在原本的C4提交(commit)版本上。
在master分支查看資料夾檔案，一共有6個檔案：file1.txt～file6.txt
在bug分支查看資料夾檔案，一共有4個檔案：file1.txt～file4.txt


##----2 回復合併
   合併後，發現做錯了，想要反悔
git checkout master
git log --oneline
'
PS D:\merge1> git log --oneline
ca0166a Merge branch 'bug'
5ac71dd C6
28c89cf C5
c573a46 C4
46c4eb3 C3
7234b82 C2
bb0e3e0 C1
'
git reset --hard [C6的commit ID] ->  git reset --hard  5ac71dd

有更簡單的方法，可以利用ORIG_HEAD別名直接回到上一版本
git reset --hard ORIG_HEAD

先取消這次的合併
git reset --hard HEAD

##----3 快轉(Fast-Forward)合併

mkdir d:\merge2
cd d:\merge2
git init
echo 1 > file1.txt
echo 1 > file2.txt
git add file1.txt
git commit -m "C1"
git add file2.txt
git commit -m "C2"
------------------------------
git checkout -b hotfix
echo 1 > file3.txt
git add .
git commit -m "C3"
echo 1 > file4.txt
git add .
git commit -m "C4"

由於master在C2分出hotfix後，在hotfix繼續提交了C3、C4版本，因此hotfix停在C4。

而master在分出hotfix後，就沒有再作業提交，因此還停在C2。

此時，如果要將C3、C4版本做的變更合併至master裡，可下指令：
git checkout master
git merge hotfix
        
        發現，分支圖和之前(##1)有不同之處：

    並不像之前合併的樣子，有從旁分一個分支再合回來(長耳朵)
    也沒有在合併後，多一個提交(commit)
    這種情形我們稱為快轉合併(Fast-Forward)。會產生快進的情形，就是要合併進來的hotfix分支，剛好在master分支的前面，並沒有額外分叉出去，此時只要將master分支的指標往前移動，就解決合併了，因此GIT做了Fast-Forward，省得麻煩還要再建commit

想看到有長出耳朵的那種合併，怎麼做呢？

首先，我們復原剛才的合併，怎麼做還記得吧：
git reset --hard ORIG_HEAD

接著重做一次合併，但這次要加--no-ff指令

git merge --no-ff hotfix

完成後，就長出耳朵來了：


##----4   衝突 conflict
mkdir merge3
cd merge3
git init
echo 1 > file1.txt
echo 1 > file2.txt
git add file1.txt
git commit -m "C1"
git add file2.txt
git commit -m "C2"
------------------------------
git checkout -b release
echo 大家好 > file1.txt
echo 1 > file3.txt
git add  --all
git commit -m "C3"
echo 1 > file4.txt
git add .
git commit -m "C4"
------------------------------
git checkout master
echo 我愛你 > file1.txt
echo 1 > file5.txt
git add  --all
git commit -m "C5"
echo 1 > file6.txt
git add .
git commit -m "C6"


這兩個分支都改了file1.txt，release分支改成大家好，而master分支改成我愛你，接著我們將release合併到master裡，看會花生省魔術：
git checkout master
git merge release
        慘了！慘了！發生衝突(Conflict)，怎麼辦~怎麼辦~
看一下檔案狀態：
    git status
        這裡多了一個檔案狀態，稱做未合併(Unmerged paths，簡單的說就是發生衝突(Conflict)啦！而且GIT會把file1.txt這個衝突檔案放在工作目錄(WD)，讓你自己決定怎麼修改
#>}



#--------------------------------------------------------------------------------
#   611  標籤
#--------------------------------------------------------------------------------
{<#


輕量級的標籤：

git tag [標籤名稱]
含附註的標籤：

git tag -a [標籤名稱] -m "註解"

#>}




#--------------------------------------------------------------------------------
#   629  Git Flow練習
#--------------------------------------------------------------------------------
{<#
http://nvie.com/posts/a-successful-git-branching-model/
實際上開發程式時，分支到底要怎麼規畫啊？Vincent Driessen提出了一套Git Flow開發流程A successful Git branching model

際上我們只要懂得此流程，自己手動建分支也能達到同樣目的喔！以下條列出這些分支的特性及用途：

master:正式上線分支，合併(merge)最好要有專人負責。

develop:開發分支，提交(commit)、合併(merge)最好要有專人負責。

hotfix: 緊急修補分支，由master分支出來，可合併至master和develop，用途是解決正式版上線的bug。

feature:功能分支，由develop分支出來，可合併至develop，用途是開發新功能。

release：釋出版本分支，由develop分支出來，可合併至master和develop。用途是開發下一版本，也就是開發完成準備釋出時要建立。此分支只會針對該版本bug做修改及commit而已，但請不要在release繼續開子分支。

#>}





#--------------------------------------------------------------------------------
#   654  Stash暫存
#--------------------------------------------------------------------------------
{<#
https://kingofamani.gitbooks.io/git-teach/content/chapter_3_branch/stash.html

如果你正在開發一個新的功能，並在feature功能分支進行開發，忽然老闆叫你放下手邊工作， 去解決一個bug，這時怎麼辦呢？你的Work Direction和Stage Area都還留有未處理的檔案， 這時無法切換到其他分支，除非你馬上將所有檔案提交(Commit)出一個版本，但這樣的版本 內容是無意義的，有其他方法嗎？

這時救星出現了，你可以用Stash指令將你目前的Work Direction和Stage Area的檔案先 暫存起來，等到bug解決完後，再回來將暫存取出，就可以再繼續開發啦！


請先建立本單元範例：
mkdir stash1
cd stash1
git init
echo 1 > README.md
git add .
git commit -m "init"

git branch feature
echo 1 > 1.txt
git add .
git commit -m "C1"
git branch bug

git checkout feature
echo 1 > 2.txt
git add .
git commit -m "C2"

echo 1 > a.txt
echo 1 > b.txt
echo 1 > c.txt
git add c.txt

目前所在分支是feature，而且WD和Stage有開發未完成的檔案：
git status
    WD區: a.txt、b.txt
    Stage區: c.txt

將這些檔案都先暫存起來，可用git satsh指令，但這個指令只會將Stage區的c.txt暫存起來而已。 如果要將WD區和Stage區的檔案a.txt, b.txt, c.txt都暫存起來，就要執行：
    git stash -u
        如果怕自己忘記這個暫存放了啥，可加上註解，指令是git stash save -u &quot;我是註解&quot;
            下完指令後，這3個檔案都暫存起來了，看起來乾乾淨淨^__


此時我們便可以切換至bug分支，開始修正錯誤：

    git branch bug
    echo fix > 1.txt
    git add .
    git commit -m "fix bug 1.txt"
    修正完bug後，回到feature分支：

    git branch feature
我們先來查詢看暫存是否還在，指令如下：
        git stash list

看到剛才那筆暫存，接下來要把暫存再叫回來，取回暫存的指令是：
        git stash pop
        YA~檔案又回來了，又可以繼續未完成的工作囉
#>}





#--------------------------------------------------------------------------------
#   726  遠端多人合作開發－單分支
#--------------------------------------------------------------------------------
{<#
#--1  只有一個人開發 單一分支 
若你在使用GIT版本控管只是自己一個人獨力開發程式，且不會分支， 只用master分支來開發，那開發流程是如何呢？我們來看一下。

首先就像上個單元所講的，你必須先建立一個遠端儲存庫和本地儲存庫， 並且讓兩個儲存庫連結：

你可以使用自己建立的遠端儲存庫。若懶得建立，請上網將底下專案Fork至你自己的儲存庫吧：
        https://github.com/Ming-Tseng/ps1

接著clone至辦公室的電腦，記得要用你自己的GitHub帳號：
        git clone https://github.com/Ming-Tseng/ps1.git

開一下分支圖，有5個提交版本：
        除了有master分支外，多了origin/master  及  origin/HEAD  分支， 這兩個分支其實是存在於遠端GitHub儲存庫的分支。
        
        當我們把儲存庫clone下來後， 就會自動在本地建立起這些分支，藉以追蹤遠端分支， 
        
        因此我們可以將origin/master、origin/HEAD稱為本地追蹤分支； 
                   而origin/HEAD是GIT自動產生，用來指向目前分支的最新版本， 
            也就是指向origin/master，所以其實遠端只有一個origin/master分支。

origin其實就是遠端儲存庫的別名，你可以輸入git remote -v就可以看到遠端儲存庫的路徑：
    cd D:\work\BMI
    git remote -v
    '
    origin	https://github.com/Ming-Tseng/BMI.git (fetch)
    origin	https://github.com/Ming-Tseng/BMI.git (push)
    '
如果要查看所有分支，可用git branch -a指令查看，其中紅色的表示本地追蹤分支
    git branch -a
        '
          * master
            remotes/origin/master
        '
辦公室電腦已經有完整的Git版控啦。 現在要進行程式開發，假如我又提交了兩個版本

cd sample501
echo 1 > 6.txt
git add .
git commit -m "C6"
echo 1 > 7.txt
git add .
git commit -m "C7"

現在開始，本地和遠端的儲存庫版本有差異了，本地有7個版本，遠端只有5個版本：
遠端要如何取得這兩個新的版本呢？簡單，只要下push指令就可以了
    git push origin master

現在遠端也有最新版本，準備下班回家囉！
    回到家後，準備洗澡看電視，好好休息一番…但…老闆此時來電，表示案子進度不夠，明天要 看到某某功能完成，天啊！又要加班，不得已，只好又打開電腦，繼續coding… 打開電腦後，家裡電腦並沒有程式碼，怎麼辦咧？
        就克隆下來就好啦
            git clone https://github.com/[你的GitHub帳號]/sample501.git home501

接著在家裡又提了一個版本，並上傳至遠端：
    cd home501
    echo 1 > 8.txt
    git add .
    git commit -m "C8"
    git push origin master

現在家裡電腦和GitHub遠端儲存庫都同步了，開心！總算可以睡覺囉！ 隔天… 來到公司辦公室後，打開電腦，再來要做什麼呢？當然是繼續扣頂！扣頂！
好不容易又改了一個功能，也提交了一個版本：
    cd sample501
    echo 1 > 9.txt
    git add .
    git commit -m "C9"
        接著開開心心下了push指令，準備上傳吧
            git push origin master

error~怎麼了？開發的程序和之前一樣，怎麼會出錯呢？
    原來是昨天晚上在家裡做的C8版本，並沒有在辦公室的儲存庫裡， 這個時候我們只要透過git pull指令，將GitHub昨晚更新的版本下載至辦公室儲存庫即可：
        git pull origin master

**Pull後看一下分支圖，你會發現多了一個耳朵，就好像之前在做merge時一樣。 其實pull指令包含了兩個動作，第一個動作是先將origin/master遠端分支的版本抓下來(fetch)， 然後再將master與origin/maser做合併(merge)的動作，如此本地的master也就有了遠端master分支的新版本了。
    所以 pull = fetch + merge
    有些人不喜歡每次pull後，會產生一堆merge後的耳朵，因為會習慣將  master 與  origin/master  看成一同一分支， 當有新版本時，也只是在同一分支做快轉而已，那要怎麼做呢？ 
     如果下 git push --no-ff origin master可以嗎？當然不行，origin   和   origin/master  在C7時已經分叉開了， 當然也就沒有所謂的快轉合併，因此用--no-ff參數是沒有意義的。
        有一個方法可以解決，我們可以使用pull --rebase來完成任務， 指令為
                git pull --rebase origin master
                    但有一點要注意，使用--rebase後，C9版本的SHA1值被改變了， 由於我們還沒將C9版本push上遠端，因此也就不用擔心其他人版本會亂掉的問題。 
                    另外還有一個問題，若rebase時origin/master有多個commit，一旦發生衝突(conflict)時， 是會接續產生的，你必須一一處理每個commit的衝突後，才能pull

**偷地告訴做法好了，但這次我要用不一樣的方法來完成， 還記得剛才有說過  pull 其實是fetch + merge兩個指令，如果分開下指令會怎麼樣呢？

 首先下fetch指令：
    cd home501
    git fetch origin master
    
  分支圖可以看到已經將C9版本抓下來了，但還沒有合併，因為master和origin/master 是在不同版本上。 接著我們要做合併動作
    git merge origin/master

        由於master和origin/master並沒有分叉，想當然爾這是一個快轉合併囉！ 

可發現使用同一遠端儲存庫，然後在不同電腦做版控， 就只是clone、push和pull三個指令在做變化而已。 第一次用clone複製到本地， 然後本地建好版本就push上傳、若遠端有新版本就pull下來， 等本地又有新版本再push上去，遠端若又有新版本就再pull下來… 就這樣一直循環建立版本控制，不難！不難！


#--2  多人合力開發   單一分支

    其實不管是幾個人，整個團隊的開發流程是差不多的， 你只要將辦公室和家裡改成同事甲與同事乙，然後所有流程都一樣，搞定！

      流程：先要有人在遠端建好儲存庫，接著團隊的每個人clone一份完整的儲存庫到自己的電腦， 接下來若有人寫了新版本就push上遠端，其他人要這個新版本就pull下來自己電腦…一直循環， 完成版本控制。

#-- 3 遠端多人合作開發－多分支


#>}





#--------------------------------------------------------------------------------
#   
#--------------------------------------------------------------------------------
{<#


#>}





#--------------------------------------------------------------------------------
#   
#--------------------------------------------------------------------------------
{<#


#>}





#--------------------------------------------------------------------------------
#   
#--------------------------------------------------------------------------------
{<#


#>}





#--------------------------------------------------------------------------------
#   
#--------------------------------------------------------------------------------
{<#


#>}




#--------------------------------------------------------------------------------
#   
#--------------------------------------------------------------------------------
{<#


#>}
