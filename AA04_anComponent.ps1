<#

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA04_anComponent.ps1


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\AA04_anComponent.ps1

foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname         =$ps1fS.name
    $ps1fFullname     =$ps1fS.FullName 
    $ps1flastwritetime=$ps1fS.LastWriteTime
    $getdagte         = get-date -format yyyyMMdd
    $ps1length        =$ps1fS.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To "a0921887912@gmail.com","abcd12@gmail.com" -from 'a0921887912@gmail.com' `
    -attachment $ps1fFullname  `
    -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length " `
    -Body "  ps1source from:me $ps1fname   " 
}


#>
#  27   TextView
#  28   RadioButton  RadioGroup  getCheckedRadioButtionId  onCheckedChanged   shen05
#  43   EditText : TextWatcher
#  52   CheckBox   isChecked()  onCheckedChanged setOnCheckedChangeListener   shen05
#  83   imageView setVisibility   shen05
#  125  spinner  getSelectedItemPosition()  onItemSelected()  onNothingSelected  shen06
#  138  ScrollView  shen 5
#  168  ListView  onItemClick()  shen 6-1
#  179  Toast  makeText() show() cancel()  setText() setDuration() setGravity()  shen7-1
#  211  AlertDialog   Builder show()  setCancelable()  shen07-2
#  264  DatePickerDialog 與 TimePickerDialog    onDateSet() onTimeSet()  shen07-3
#  294  Explicit Intent  setClass() startAtivity()  finish()  putExtra() getIntent() getIntExtra()  shen08-2
#  365  Implicit Intent   setAction()   setData()  shen 09
#  391  Intent 用法整理 http geo  tel  SMS/MMS  email shen09-2
#  608  Intent Camera Bundle   startActivityForResuIt()   onActivityResult()  shen10
#   644   Environment  class  && System.currentTimeMillis  取得系統環境資訊( 外部儲存裝置, 系統時間數值)  shen10 p.5
#   656    SimpleDataFormat  取得系統時間 以年月日 來命名    shen10 p.7
#  670  Uri 物件    //用來參照拍照存檔的 Uri 物件   shen10 p.5
#   684  BitmapFactory          Class  BitmapFactory.decodeFile   讀取 圖檔 內容    shen10 p.5
#   734  BitmapFactory.Options  Class  inJustDecodeBounds 載入圖檔資訊的選項  inSampleSize 縮小比例 shen10p8
#     760  AlertDialog.Builder() 交談窗顯示圖檔   shen10p8




function trimspace ($ss){
#$ss='圖 檔 路 徑 Uri'
$i=$ss.Length
$s=''
for ($i = 0; $i -lt $ss.Length; $i++)
{ 
   
    if ($ss[$i] -ne ' ')
    {
        $s=$s+$ss[$i]

    }
}
 $s
}
trimspace '讀 取 圖 檔 內 容 轉 換 為 Bi tmap 物 件';#--------------------------------------------------------------------------------
#  27  TextView
#--------------------------------------------------------------------------------// 在文字方塊中顯示點購的項目
 setText     String msg="";   ((TextView) findViewById(R.id.showOrder)).setText(msg);#--------------------------------------------------------------------------------
#  28  RadioButton  RadioGroup  getCheckedRadioButtionId  onCheckedChanged   shen05
#--------------------------------------------------------------------------------
#  AA02_code  197   RadioGroup  getCheckedRadioButtonId
OnCheckedChangeListener
getCheckedRadioButtionId()
    int id;
    RadioGroup ticketType =  (RadioGroup) findViewById(R.id.ticketType);
    id=ticketType.getCheckedRadioButtonId();
    RadioButton type = (RadioButton) findViewById(id);

onCheckedChanged()



#--------------------------------------------------------------------------------
#  43 EditText : TextWatcher  shen05
#--------------------------------------------------------------------------------
beforeTextChanged
onTextChanged
afterTextChanged

#--------------------------------------------------------------------------------
#   52 CheckBox   isChecked()  onCheckedChanged setOnCheckedChangeListener   shen05
#--------------------------------------------------------------------------------
#{<#
 CheckBox  chk;
 chk = (CheckBox) findViewById(i);
 chk.isChecked()


 CheckBox 要個別設定Listener    implements CompoundButton.OnCheckedChangeListener

int[] chk_id={R.id.chk1,R.id.chk2,R.id.chk3,R.id.chk4};
  for(int id:chk_id){      // 用迴圈替所有核取方塊加上監聽物件
            CheckBox chk=(CheckBox) findViewById(id);
            chk.setOnCheckedChangeListener(this);
        }

int[] chk_id={R.id.chk1,R.id.chk2,R.id.chk3,R.id.chk4};
   for (int id:chk_id)  
            ((CheckBox)findViewById(id)).setOnCheckedChangeListener(this);  // 用迴圈替所有核取方塊加上監聽物件
    


 onCheckedChanged(CompoundButton buttonView, boolean isChecked)   
 CompoundButton buttonView   :為CheckBox 物件    ; 被取消時. isChecked ---false ,  被選取時. isChecked --true

 public void onCheckedChanged(CompoundButton chk, boolean isChecked)
      getId()




#>}

#--------------------------------------------------------------------------------
#   83 imageView setVisibility   shen05
#--------------------------------------------------------------------------------
{<#
build Res  android-24

ii C:\Users\User\AppData\Local\Android\sdk\platforms\android-24\data\res
ii   D:\work\mingPractice\app\src\main\res\drawable  #//專案內的res\drawable
src 

color
Drawable  - phone   : android:src="@android:drawable/sym_action_call"  - 使用內建圖形資源
                      android:src="@drawable/soup" />  # 使用外部圖形資源  專案內的res\drawable此檔名
ID
Mip Map
String
Style


android:layout_width="60dp"
android:layout_height="60dp"
android:id="@+id/output3"
android:src="@drawable/softdrink"
android:visibility="gone"  不可見  (不佔空間) ; invisible  不可見(佔空間)  visible 可見

#>}

#--------------------------------------------------------------------------------
#   125 spinner  getSelectedItemPosition()  onItemSelected()  onNothingSelected  shen06
#--------------------------------------------------------------------------------
{<#

implements AdapterView.OnItemSelectedListener

in strings.xml

    <item>台北影城</item>
        <item>板橋影城</item>
        <item>台中影城</item>
        <item>台南影城</item>
        <item>高雄影城</item>
    </string-array>

in XML   存取 字串陣列   "@array/名稱陣列"   using  entries attable 
in Class 存取 字串陣列   "R.array.名稱陣列"


getSelectedItemPosition


onItemSelected()  // 當一選取項目就進行對應的動作
onItemSelected(AdapterView<?> parent, View view, int position, long id) 
    AdapterView<?> parent,  <-- spinner object
    View view  ,


public void onNothingSelected(AdapterView<?> parent) {
        // 不會用到, 但仍需保留

#>}

#--------------------------------------------------------------------------------
#   138 ScrollView  shen 5
#--------------------------------------------------------------------------------
{<#

ScrollView  Wrap  TextView 

#>}

#--------------------------------------------------------------------------------
#    168  ListView  onItemClick()  shen 6-1
#--------------------------------------------------------------------------------
{<#   AA02_code.ps1  line  #   720  ListView Shen06  Aug.25.2016  

       implements AdapterView.OnItemClickListener
       ListView lv = (ListView) findViewById(R.id.lv);
        lv.setOnItemClickListener(this);


#>}
#--------------------------------------------------------------------------------
#    179 Toast  makeText() show() cancel()  setText() setDuration() setGravity()  shen7-1
#--------------------------------------------------------------------------------
{<#
implements AdapterView.OnItemClickListener 
import  android.widget

Toast tos; // 宣告 Toast 物件

Toast.makeText(this,"DisplayText",Toast.Length_SHORT);
this  => MainActivity
"DisplayText" => 要顯示的訊息
Toast.Length_SHORT) => 訊息時間長度

Toast.makeText(this,  "答案︰" + ansArr[position], Toast.LENGTH_SHORT).show();
Toast.LENGTH_SHORT = 2 sec
Toast.LENGTH_LONG  => 3.5 sec 

cancel()

setText()

setDuration(): 改變顯示時間
if ( postition % 2 ==0 ) 
   tos.setDuration(Toast.LENGTH_SHORT);
else 
   tos.setDuration(Toast.LENGTH_LONG);

setGravity() : 改變位置
    tos.setGravity(Gravity.TOP | Gravity.Right,0, 50); //加上角且向下移50dp
#>}

#--------------------------------------------------------------------------------
#   211  AlertDialog   Builder show()  setCancelable()  shen07-2
#--------------------------------------------------------------------------------
{<#
要顯示Alert 交談窗 ,使用特 製 的 "類別 AlertDiaIog.BuiIder"  建立  "AlertDialog.Builder 物件",
然後用 此物件來 設定 交談窗 所需的 元素 及 屬性 後 , 再產生實際的AlertDialog 物件並顯示出來 。


import android.content.DialogInterface;

implements DialogInterface.OnClickListener 

AlertDialog
DatePickerDialog
TimePickerDialog

建立 Builder 物件
AlertDialog.Bulider bdr= new AlertDialog.Builder(this)
bdr.setMessage("你喜歡 Android 手機嗎？") 
bdr.setTitle("Android 問卷調查") // 設定交談窗的標題
bdr.setIcon(android.R.drawable.ic_menu_edit) // 採用內建的圖示

也可以用下列快速方法

new AlertDialog.Builder(this) // 建立 Builder 物件
                .setMessage("你喜歡 Android 手機嗎？") // 設定顯示訊息
                .setCancelable(false) // 禁用返回鍵關閉交談窗
                .setIcon(android.R.drawable.ic_menu_edit) // 採用內建的圖示
                .setTitle("Android 問卷調查")       // 設定交談窗的標題
                .setPositiveButton("喜歡", this)   // 加入否定按鈕
                .setNegativeButton("討厭", this)   // 加入肯定按鈕
                .setNeutralButton("沒意見", null)   // 不監聽按鈕事件
                .show(); // 顯示交談窗

setCancelable()
AlertDialog.Builder 還 有 一 個 setCancelabIe() 方 法 ,
設為:True    呼叫此 方 法 , 表示使用者可按手機的返回鍵 ( 或 在 交 談 窗 以外的區域 按 一 下 ) 來 關閉 交談窗 ; 
設為:False    交 談 窗 上 就 必 須 提 供 取 消 按 鈕 , 否 則 使 用 者 將 無 法 關 閉 交 談 窗 ·
 系 統 預 設 為 true 。 

在 Android 有許多功能  會像 AertDialog 一 樣設計有 "Builder 類 別" 來 助建立 物件 
為了避免混所以在程式中都會同 "AlertDialog 類別" 名稱 寫出來 , 表示是使用 AlertDialog 中 的 Builder 類別 

# 加入 按鈕
在 Alert 交 談 窗 中 最 多 可 以 加 入 3 個 按 鈕 , 分 別 代 表 
否 (Negative) 、 
中 性 (Neutral) 、 及 是 (Positive) ”
 加入的方法 則為 setXxxButton(), 其中的 xxx 
Negative 、 Neutral 或 Positive, 


#>}

#--------------------------------------------------------------------------------
#   264  DatePickerDialog 與 TimePickerDialog    onDateSet() onTimeSet()  shen07-3
#--------------------------------------------------------------------------------
{<#

implements View.OnClickListener,
        DatePickerDialog.OnDateSetListener,     // 實作監聽日期交談窗事件的介面
        TimePickerDialog.OnTimeSetListener {    // 實作監聽時間交談窗事件的介面




new DatePickerDialog(this, this,    // 由活動物件監聽事件
                    c.get(Calendar.YEAR),   //由Calendar物件取得目前的西元年
                    c.get(Calendar.MONTH),  //取得目前月 (由 0 算起)
                    c.get(Calendar.DAY_OF_MONTH)) //取得目前日

new TimePickerDialog(this, this,   // 由活動物件監聽事件
                    c.get(Calendar.HOUR_OF_DAY), //取得目前的時 (24小時制)
                    c.get(Calendar.MINUTE),      //取得目前的分
                    true)                        //使用24小時制

請 注 意 , 參數『 月 』 是由 0 開始算起 , 而 參數 使用 24 小時制 
若設為 false, 則 交談窗中 會多出 上午 / 下午 的選擇 ” 

onDateSet()  onDateSet(DatePicker v, int y, int m, int d)

onTimeSet()  txTime.setText("時間：" + h + ":" + m);    // 將選定的時間顯示在螢幕上

#>}
#--------------------------------------------------------------------------------
#   294  Explicit Intent  setClass() startAtivity()  finish()  putExtra() getIntent() getIntExtra()  shen08-2
#--------------------------------------------------------------------------------
{<#
明示 Intent (Explicit Intent) : 就是 直接 以 『 類別名稱 』 來 指 定 要 啟 動 哪 一 個 Activity, 通常是用來 啟動 我們自己程式中 的 Activity , 
暗示 Intent (Implicit Intent) : 所謂 暗示 , 就是只 在 Intent 中 "指出 "想要進行 的 
	(1)動作 ( 例如 撥號 、 顯示 、 編輯 、 搜尋等 ) 及 
    (2)資料 ( 例如 電話 號碼 、 E-mail 地址 、 網址 等 ) , 讓"系統"幫 我們 找出 適合的 Activity 來"執行"相關操作。 

        Intent it = new Intent();
        it.setClass(this, SecondActivity.class);
        startAtivity(it);
setClass() 的 第 一 個 參 數 要 傳 入 目 前 所 在 的 Activity 物 件 , 
而 第二個 數則傳入要啟動的類別 ( 在類別名稱 之後加 .class 即代表類別本身) 。 

        Intent it = new Intent(this, SecondActivity.class);
        startAtivity(it);

        startAtivity(new Intent(this, SecondActivity.class));

putExtra()  
使 用 Intent 的 putExtra( 資料名稱, 資料 ) 方法將資料 "附加" 到 Intent 中 且 參 數 說 明 如 下 : 
第 1 個參數 要傳入 字 串 型 別 的 資 料 名 稱 ( 或 稱 為 鍵 值 ) , 以 便 稍 後 以 此 名 稱 來 讀 出 資 料 。 
第 2 個參數 為要 實際附加 的 資 料 , 其 型別 可以 是 byte 、char 、int 、short 、long 、float 、double 、boolean 、String 等 常用型別 , 或 是 這 些 型 別 的 陣 列 。 
        putExtra("編號", pos+1)

getIntent() 
getXXXExtra()取出資料

        Intent it = getIntent();               //取得傳入的 Intent 物件
        int no = it.getIntExtra("編號", 0);    //讀出名為 "編號" 的 Int 資料, 若沒有則傳回 0
        String s = it.getStringExtra("備忘");  //讀出名為 "備忘" 的 String 資料


    int no=it.getIntExta("編號 ",0);           <- 讀出名為 " 編號 " 的 Int 資 料 , 若 沒 有 則 傳 回 0 
    String da =it.getStringExtra ( "説明");      <-讀出名為 " 説明 " 的 String 資 料 , 若沒有則傳 回 null 
    String a[] =it .getStringArrayExtra ( "愛吃" ) ;<-讀 出 名 為 " 愛吃 " 的 String[]資 料 , 若 沒 有 則 傳 回 null

 \\\\\\\\   A = 原Activity   call B=新Activity    , 要求 B to A  回傳 資料 
<1>如果想讓 新Activity(B) 傳回資料 , (A)則要改用 startActivityForResult(Intent it, int 識 別 碼 ) 來啟動  新Activity(B)。 
<2>在 新Activity(B) 中 要 結 束 前 , 可 使 用 setResuIt( 結 果 碼, Intent) 傳回執行的結果與資料。 
<3>在 原Activity(A)中 可撰寫 onActivityResuIt(識別碼 , 結果碼 , Intent) 來接收 新Activity(AB) 傳回的資料 ” 在此方法中應檢查識別碼是否正確 , 
然後依 "結果碼" 而 做不同的處理 , 並 在Intent 參數 中讀取傳回的資料 ” 

 
 在A activity 中 
 startActivityForResult (it, pos); //啟動 Edit 並以項目位置為 ex  pos 識別碼
 識別碼 為一個自訂的數值 , 當新 Activity 傳回 資料 時,也會一併傳回此識別碼 以供辨識 ”
  
 在B activity 中 　在 結束前 使 用 setResult() 傳 回 執 行 的 結 果 與 資 料 : 
  I　　　ntent it2 = new Intent();
        it2.putExtra("備忘", txv.getText() + " " + edt.getText()); // 附加項目編號與修改後的內容
        setResult(RESULT_OK, it2); // 傳回代表成功的結果碼, 以及修改的資料
        finish();    //結束活動

再由　A activity 中 　onActivityResult(int requestCode, int resultCode, Intent data) 

　　　onActivityResuIt (int 識別碼 , int 結果碼 , Intent it) 
    　onActivityResult(int requestCode, int resultCode, Intent it) 
     if(resultCode == RESULT_OK) {
            aMemo[requestCode] = it.getStringExtra("備忘"); // 使用傳回的資料更新陣列內容
            aa.notifyDataSetChanged(); // 通知 Adapter 陣列內容有更新
        }





#>}


#--------------------------------------------------------------------------------
#    365  Implicit Intent   setAction()   setData()  shen 09
#--------------------------------------------------------------------------------
{<#
暗示 Intent (Implicit Intent)
ACTION_VIEW     顯示資料
ACTION_EDIT     編輯資料 
ACTION_PICK     挑選資料 
ACTION_GET_CONTENT   取得資料 
ACTION_DIAL     開啟撥號程式 
ACTION_CALL     直接撥出電話
ACTION_SEND     傳送 資料 
ACTION_SENDTO   傳送到資料所指定的對象
ACTION_SEARCH   搜尋資料
ACTION_WEB_SEARCH 搜尋Web資料 
MediaStore.ACTION_IMAGE_CAPTURE  啟動相機程式 

用 setAction() 及 setData() 來要 執行 的動作 及 資料 , 然後 再用   startActivity() 啟動 適合 的桯式

 Intent it = new Intent();         //新建 Intent 物件
 it.setAction(Intent.ACTION_VIEW); //設定動作：顯示資料
 it.setData(Uri.parse("tel:800")); //設定資料：用URI指定電話號碼
 startActivity(it);                //啟動適合 Intent 的 Activity


 有多個 適合 程式 就 固 定 出 現 選 單 ( 而不論使用者是否設定  預設程式 ) , 
或 是想要自訂選單的標題 , 則可將前面程式的 startActivity(it);   改 為 : 

  startActivity(Intent.createChooser(it,"找一個"));  

#>}


#--------------------------------------------------------------------------------
#  391  Intent 用法整理 http geo  tel  SMS/MMS  email shen09-2
#--------------------------------------------------------------------------------
{<#

https://dotblogs.com.tw/hanry/archive/2012/07/05/73239.aspx
http://wenku.baidu.com/view/e300a5d3360cba1aa811da7d.html###
http://ysl-paradise.blogspot.tw/2008/12/intent.html


顯示網頁  http
Uri uri = Uri.parse("http://google.com"); 
Intent it = new Intent(Intent.ACTION_VIEW, uri); 
startActivity(it); 


##顯示地圖  geo
Uri uri = Uri.parse("geo:38.899533,-77.036476"); 
Intent it = new Intent(Intent.ACTION_VIEW, uri);  
startActivity(it);  
//其他 geo URI 範例 
//geo:latitude,longitude 
//geo:latitude,longitude?z=zoom 
//geo:0,0?q=my+street+address 
//geo:0,0?q=business+near+city 
//google.streetview:cbll=lat,lng&cbp=1,yaw,,pitch,zoom&mz=mapZoom 

##路徑規劃
Uri uri = Uri.parse("http://maps.google.com/maps?f=d&saddr=startLat%20startLng&daddr=endLat%20endLng&hl=en"); 
Intent it = new Intent(Intent.ACTION_VIEW, uri); 
startActivity(it); 
//where startLat, startLng, endLat, endLng are a long with 6 decimals like: 50.123456  

##撥打電話
//叫出撥號程式   tel
Uri uri = Uri.parse("tel:0800000123"); 
Intent it = new Intent(Intent.ACTION_DIAL, uri); 
startActivity(it); 

##//直接打電話出去 ACTION_CALL
Uri uri = Uri.parse("tel:0800000123"); 
Intent it = new Intent(Intent.ACTION_CALL, uri); 
startActivity(it); 
//用這個，要在 AndroidManifest.xml 中，加上 
//<uses-permission id="android.permission.CALL_PHONE" /> 

##傳送 SMS/MMS
//叫起簡訊程式 
Intent it = new Intent(Intent.ACTION_VIEW); 
it.putExtra("sms_body", "The SMS text");  
it.setType("vnd.android-dir/mms-sms"); 
startActivity(it); 

##//傳送簡訊  smsto
Uri uri = Uri.parse("smsto:0800000123"); 
Intent it = new Intent(Intent.ACTION_SENDTO, uri); 
it.putExtra("sms_body", "The SMS text"); 
startActivity(it); 
 
##//傳送 MMS   content    ACTION_SEND
Uri uri = Uri.parse("content://media/external/images/media/23"); 
Intent it = new Intent(Intent.ACTION_SEND);  
it.putExtra("sms_body", "some text");  
it.putExtra(Intent.EXTRA_STREAM, uri); 
it.setType("image/png");  
startActivity(it); 
 
##//如果是 HTC Sense 手機，你要用 
Intent sendIntent = new Intent("android.intent.action.SEND_MSG");   
sendIntent.putExtra("address", toText);   
sendIntent.putExtra(Intent.EXTRA_SUBJECT, "subject");  
sendIntent.putExtra("sms_body", textMessage);   
sendIntent.putExtra(Intent.EXTRA_STREAM, Uri.parse(url));  
sendIntent.setType("image/jpeg");   
startActivity(sendIntent); 
 
//底下這段更好，可在所有手機上用 
//refer to http://stackoverflow.com/questions/2165516/sending-mms-into-different-android-devices 
Intent intent = new Intent(Intent.ACTION_SENDTO, Uri.parse("mmsto:<number>");  
intent.putExtra("address", <number>);  
intent.putExtra("subject", <subject>);  
startActivity(intent);

##//傳送 Email  mailto
Uri uri = Uri.parse("mailto:xxx@abc.com"); 
Intent it = new Intent(Intent.ACTION_SENDTO, uri); 
startActivity(it); 
Intent it = new Intent(Intent.ACTION_SEND); 
it.putExtra(Intent.EXTRA_EMAIL, "me@abc.com"); 
it.putExtra(Intent.EXTRA_TEXT, "The email body text"); 
it.setType("text/plain"); 
startActivity(Intent.createChooser(it, "Choose Email Client")); 
Intent it=new Intent(Intent.ACTION_SEND);   
String[] tos={"me@abc.com"};   
String[] ccs={"you@abc.com"};   
it.putExtra(Intent.EXTRA_EMAIL, tos);   
it.putExtra(Intent.EXTRA_CC, ccs);   
it.putExtra(Intent.EXTRA_TEXT, "The email body text");   
it.putExtra(Intent.EXTRA_SUBJECT, "The email subject text");   
it.setType("message/rfc822");   
startActivity(Intent.createChooser(it, "Choose Email Client"));  


##//傳送影音附件檔 
Intent it = new Intent(Intent.ACTION_SEND); 
it.putExtra(Intent.EXTRA_SUBJECT, "The email subject text"); 
it.putExtra(Intent.EXTRA_STREAM, Uri.parse("file:///sdcard/mysong.mp3")); 
it.setType("audio/mp3"); 
startActivity(Intent.createChooser(it, "Choose Email Client")); 

##//傳送圖片附件檔 
Intent it = new Intent(Intent.ACTION_SEND); 
it.putExtra(Intent.EXTRA_SUBJECT, "The email subject text"); 
it.putExtra(Intent.EXTRA_STREAM, Uri.parse("file:///sdcard/mypic.jpg")); 
it.setType("image/jpeg"); 
startActivity(Intent.createChooser(it, "Choose Email Client")); 

##顯示聯絡人清單
Intent it = new Intent(Intent.ACTION_VIEW, People.CONTENT_URI); 
startActivity(it); 


##顯示某個朋友的詳細資料
Uri uriPerson = ContentUris.withAppendedId(People.CONTENT_URI, 5); //5 是朋友的 ID 
Intent it = new Intent(Intent.ACTION_VIEW, uriPerson); 
startActivity(it); 


##播放多媒體
Intent it = new Intent(Intent.ACTION_VIEW); 
Uri uri = Uri.parse("file:///sdcard/song.mp3"); 
it.setDataAndType(uri, "audio/mp3"); 
startActivity(it); 
Uri uri = Uri.withAppendedPath(MediaStore.Audio.Media.INTERNAL_CONTENT_URI, "1"); 
Intent it = new Intent(Intent.ACTION_VIEW, uri); 
startActivity(it); 



##從圖庫中回傳選到的圖片
Intent it = new Intent(Intent.ACTION_GET_CONTENT);   
it.addCategory(Intent.CATEGORY_OPENABLE);   
it.setType("image/*"); 
startActivityForResult(it, 0); 
//回傳的圖片可透過 it.getData() 取得圖片之 Uri 


##啟動照相機，並將相片存在指定的檔案中   #    608  Intent Camera
Intent it = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);   
//假設你要將相片存在 /sdcard/xxx.jpg 中 
File f = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/xxx.jpg"); 
it.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(f));  
startActivity(it, 0); 



##Market 相關
//尋找某個應用程式 
Uri uri = Uri.parse("market://search?q=pname:pkg_name"); 
Intent it = new Intent(Intent.ACTION_VIEW, uri); 
startActivity(it); 


//where pkg_name is the full package path for an application 
##//顯示某應用程式詳細畫面 
Uri uri = Uri.parse("market://details?id=pkg_name_or_app_id"); pkg可至google play找APP並在網址列從details複製
Intent it = new Intent(Intent.ACTION_VIEW, uri); 
startActivity(it); 
//where app_id is the application ID, find the ID  
//by clicking on your application on Market home  
//page, and notice the ID from the address bar 

## Uninstall 應用程式
Uri uri = Uri.fromParts("package", strPackageName, null);  
Intent it = new Intent(Intent.ACTION_DELETE, uri);  
startActivity(it);  

##從圖庫中回傳選到的圖片
Intent it = new Intent(Intent.ACTION_GET_CONTENT);   
it.addCategory(Intent.CATEGORY_OPENABLE);   
it.setType("image/*"); 
startActivityForResult(it, 0); 


##//回傳的圖片可透過 it.getData() 取得圖片之 Uri 
啟動照相機，並將相片存在指定的檔案中
Intent it = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);   
//假設你要將相片存在 /sdcard/xxx.jpg 中 
File f = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/xxx.jpg"); 
it.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(f));  

## 安裝 APK 檔
Uri uri = Uri.parse("url_of_apk_file"); 
Intent it = new Intent(Intent.ACTION_VIEW, uri); 
it.setData(uri); 
it.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION); 
it.setClassName("com.android.packageinstaller", 
                "com.android.packageinstaller.PackageInstallerActivity"); 
startActivity(it);  
//make sure the url_of_apk_file is readable for all users  


##搜尋 Web 資料
                Intent it = new Intent(Intent.ACTION_VIEW); //建立意圖並指定預設動作
                it.setAction(Intent.ACTION_WEB_SEARCH);  //將動作改為搜尋
                it.putExtra(SearchManager.QUERY, "旗標出版");
                startActivity(it);  //啟動適合意圖的程式
#>}


#--------------------------------------------------------------------------------
#   608  Intent Camera Bundle   startActivityForResuIt()   onActivityResult()  shen10
#--------------------------------------------------------------------------------
{<#



Intent 的 『 動作 』 要 設 為 MediaStore.ACTION_IMAGE_CAPTURE, 然後 
再用 startActivityForResuIt() 來 啟 動 Intent, 

 Intent it = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);  //建立動作為拍照的意圖
        startActivityForResult(it, 100);                   //啟動意圖並要求傳回資料

此方法的第 2 個 參 數 100 是我們自訂的識別碼 , 當 相機程式 在 拍完拍照 將 資料傳回 時, 可以做識別之用 , 例 如 : 


用 Intent啟 動 的 相 機 程 式 在 拍照 後 , 預設 會 將 相 片 的 縮 圖 打 包 [Bitmap 物件] 放在 Intent 中 <傳回> , 
從 Intent 中 <取出> 出 [Bitmap 物件] 資料 來 顯 示 。 不過 , 由 於 [Intent] 並 未提供 直接 <取出> '物件" ( 如 Bitmap) 的方法
因此要先 將 Intent  附加資料 轉成 [Bundle 物件] , 再 用 Bundle 的 get() 來 取 出 : 

   protected void onActivityResult (int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(resultCode == Activity.RESULT_OK && requestCode==100) {
            Bundle extras = data.getExtras();         //將 Intent 的附加資料<轉為> Bundle 物件
            Bitmap bmp = (Bitmap) extras.get("data"); //由 Bundle 取出名為 "data" 的 Bitmap 資料
            ImageView imv = (ImageView)findViewById(R.id.imageView);
            imv.setImageBitmap(bmp);    //將 Bitmap 資料顯示在 ImageView 中
        }
        else {
            Toast.makeText(this, "沒有拍到照片", Toast.LENGTH_LONG).show();
        }
    }
#>}


#--------------------------------------------------------------------------------
#   644   Environment  class  && System.currentTimeMillis  取得系統環境資訊( 外部儲存裝置, 系統時間數值)  shen10 p.5
#--------------------------------------------------------------------------------
{<#
  String dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).toString();  //取得系統的公用圖檔路徑
   String fname = "p" + System.currentTimeMillis() + ".jpg";  //利用目前時間組合出一個不會重複的檔名
   imgUri = Uri.parse("file://" + dir + "/" + fname);    //依前面的路徑及檔名建立 Uri 物件

System.currentTimeMillis()  :取得代表 目前時間 的 一個數值 (1970/1/1 凌晨至今的毫秒數 , long型別)


#>}

#--------------------------------------------------------------------------------
#   656    SimpleDataFormat  取得系統時間 以年月日 來命名    shen10 p.7
#--------------------------------------------------------------------------------
{<#


impcrt java.text.SimpleDateFormat; 
import java.util.Date; 
String  fname = new SimpleDateFOrmat("yyyyMMdd HHmmss").format(new Date()) + ".jgp"; 

ex:  20160912_122323.jpg

#>}
#--------------------------------------------------------------------------------
#  670  Uri 物件    //用來參照拍照存檔的 Uri 物件   shen10 p.5
#--------------------------------------------------------------------------------
{<#
    String dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).toString();  //取得系統的公用圖檔路徑
   String fname = "p" + System.currentTimeMillis() + ".jpg";  //利用目前時間組合出一個不會重複的檔名
   
   imgUri = Uri.parse("file://" + dir + "/" + fname);    //依前面的路徑及檔名建立 Uri 物件
   代 表 路 徑 檔 名 的 Uri 是 以 "file://" 開 以 上 就是在 組合 這樣 的 Uri 字串 , 並 用 Uri.parse() 將 "Uri字串" 轉 "Uri物件" 。 

   然後在第 7 行 將此 Uri 物件加到 Intent 的額外資料中 , 並以 MediaStore.EXTRA_OUTPUT 為 名 · 
#>}
#--------------------------------------------------------------------------------
#   684  BitmapFactory Class  BitmapFactory.decodeFile   讀取 圖檔 內容 設定載入圖檔選項    shen10 p.7
#--------------------------------------------------------------------------------
{<#
當相機程式拍好照並依照指定Uri存檔之後,可以用BitmapFact01Y類別來讀取圖檔內容,然後將之顯示在ImageView中。
底下假設imgUri為我們指定的圖檔路徑Uri,imv為ImageView物件:

Bitmap bmp = BitmapFactory.decodeFile(imgUri.getPath());   //讀取圖檔內容轉換為Bitmap物件
            imv.setImageBitmap(bmp);                        //將 Bitmap 物 件 顯 示 在 Imageview 中


#>}
#--------------------------------------------------------------------------------
#   734  BitmapFactory.Options  Class  inJustDecodeBounds 載入圖檔資訊的選項  inSampleSize 縮小比例 shen10p8
#--------------------------------------------------------------------------------
{<#

由於Android可以同時執行很多個程式,因此分配給每個程式的可用記憶體並不多,如果程式中載入太大的檔,很容易就會因記憶體不足而導致程式中止·
要避免這個問題並不難,只要依照螢幕中ImageView的大小來載入圖檔即可其實載入再大的圖檔也沒用,因為還是縮小後才能在ImageView中完整顯示·

在使用BitmapFactory類別我們可以用 BitmapFactory.Options類別 來控制載人圖檔的方式,例如只讀取圖檔的寬高資訊、依指定的縮小比例載人圖
檔等。厎下先來看如何讀取圖檔的寬高資訊,

  void showImg() {
        int iw, ih, vw, vh;

        BitmapFactory.Options option = new BitmapFactory.Options(); //建立選項物件
        option.inJustDecodeBounds = true;      //設定選項：只讀取圖檔資訊而不載入圖檔
        BitmapFactory.decodeFile(imgUri.getPath(), option);  //讀取圖檔資訊存入 Option 中
        iw = option.outWidth;   //由 option 中讀出圖檔寬度
        ih = option.outHeight;  //由 option 中讀出圖檔高度
        vw = imv.getWidth();    //取得 ImageView 的寬度
        vh = imv.getHeight();   //取得 ImageView 的高度

        int scaleFactor = Math.min(iw/vw, ih/vh); // 計算縮小比率

        option.inJustDecodeBounds = false;  //關閉只載入圖檔資訊的選項
        option.inSampleSize = scaleFactor;  //設定縮小比例, 例如 2 則長寬都將縮小為原來的 1/2
        Bitmap bmp = BitmapFactory.decodeFile(imgUri.getPath(), option); //載入圖檔
        imv.setImageBitmap(bmp);

#>}
#--------------------------------------------------------------------------------
#     760  AlertDialog.Builder() 交談窗顯示圖檔   shen10p8
#--------------------------------------------------------------------------------
{<#

new AlertDialog.Builder(this) 
.setTitle (" 圖 檔 資 訊 ") 
.setMessage ( " 圖 檔 路 徑 "+imgUri.getPath() +
	          "\n 原 始 尺 寸 : " + iw + "x" + ih + , 
              "\n 載 入 尺 寸 : " +bmp.getRidth() + "x" + bmp.getHeight ( ) + 
              "\n 顯 示 尺 寸 : " + vw + "x" + vh
             )
.SetNeutraIButton ( "關閉" , null)
.show ();

#>}


#--------------------------------------------------------------------------------
#   774  SharedPreferences     Tang07
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