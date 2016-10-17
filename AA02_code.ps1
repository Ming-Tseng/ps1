<#

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA02_code.ps1
C:\Users\User\OneDrive\download\PS1\AA02_code.ps1

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\AA02_code.ps1

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





#  28 OnClickListener    OnLongClickListener  按 &長按   ;getId  shen  4-1 & 4-2  
#   153   OnTouchListener  觸控  shen  #--------------------------------------------------------------------------------
#  28 OnClickListener    OnLongClickListener  按 &長按  shen  4-1 & 4-2
#--------------------------------------------------------------------------------
{<#
#D:\work\Ch04_EzCounter\app\src\main\java\tw\com\flag\ch04_ezcounter
package tw.com.flag.ch04_ezcounter;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity
        implements View.OnClickListener { // 實作 OnClickListener 介面
    TextView txv;		// 用來參照 textView1 元件的變數
    Button btn;			// 用來參照 button1 元件的變數
    int counter = 0;	// 用來儲存計數的值, 初值為 0

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        txv = (TextView) findViewById(R.id.textView); // 找出要參照的物件
        btn = (Button) findViewById(R.id.button); // 找出要參照的物件

        btn.setOnClickListener(this); // 登錄監聽物件, this 表示活動物件本身
    }

    @Override
    public void onClick(View v) { // 實作監聽器介面中定義的 onClick 方法
        txv.setText(String.valueOf(++counter)); // 將計數值加 1, 然後轉成字串顯示出來
    }
}


#D:\work\Ch04_EzCounter2\app\src\main\java\tw\com\flag\ch04_ezcounter
package tw.com.flag.ch04_ezcounter;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends ActionBarActivity
        implements View.OnClickListener, View.OnLongClickListener { // 實作 2 個介面
    TextView txv;       // 用來參照 textView1 元件的變數
    Button btn;         // 用來參照 button1 元件的變數
    int counter = 0;     // 用來儲存計數的值, 初值為 0

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        txv = (TextView) findViewById(R.id.textView);   // 找出要參照的物件
        btn = (Button) findViewById(R.id.button);       // 找出要參照的物件

        btn.setOnClickListener(this);       // 登錄監聽物件, this 表示活動物件本身
        btn.setOnLongClickListener(this);   //  將活動物件登錄為按鈕的長按監聽器
    }

    @Override
    public void onClick(View v) { // 實作監聽器介面中定義的 onClick 方法
        txv.setText(String.valueOf(++counter)); // 將計數值加 1, 然後轉成字串顯示出來
    }

    @Override
    public boolean onLongClick(View v) {
        counter = 0;
        txv.setText("0");
        return true;
    }
}

#D:\work\Ch04_EzCounter3\app\src\main\java\tw\com\flag\ch04_ezcounter

package tw.com.flag.ch04_ezcounter;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends ActionBarActivity
        implements View.OnClickListener, View.OnLongClickListener { // 實作 2 個介面
    TextView txv;       // 用來參照 textView1 元件的變數
    Button btn;         // 用來參照 button1 元件的變數
    int counter = 0;     // 用來儲存計數的值, 初值為 0

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        txv = (TextView) findViewById(R.id.textView);   // 找出要參照的物件
        btn = (Button) findViewById(R.id.button);       // 找出要參照的物件

        btn.setOnClickListener(this);       // 登錄監聽物件, this 表示活動物件本身
        btn.setOnLongClickListener(this);   //  將活動物件登錄為按鈕的長按監聽器
        txv.setOnLongClickListener(this);   // 將活動物件登錄為文字標籤的長按監聽器
    }
    @Override
    public void onClick(View v) { // 實作監聽器介面中定義的 onClick 方法
        txv.setText(String.valueOf(++counter)); // 將計數值加 1, 然後轉成字串顯示出來
    }

    @Override
    public boolean onLongClick(View v) {
        if(v.getId() == R.id.textView) { // 判斷來源物件是否為顯示計數值的 txv, 若是就將計數歸零
            counter = 0;
            txv.setText("0");
        }
        else { // 來源物件為按鈕, 將計數值加 2
            counter += 2;
            txv.setText(String.valueOf(counter));
        }
        return true;
    }
}

#>}#--------------------------------------------------------------------------------
#   153   OnTouchListener  觸控  shen  
#--------------------------------------------------------------------------------
{<#
#D:\MyDataII\施威銘\Ch04\Ch04_Massager

package tw.com.flag.ch04_massager;

import android.content.Context;
import android.os.Bundle;
import android.os.Vibrator;
import android.support.v7.app.AppCompatActivity;
import android.view.MotionEvent;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity implements View.OnTouchListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        TextView txv = (TextView) findViewById(R.id.txv);
        txv.setOnTouchListener(this);   // 登錄觸控監聽物件
    }

    @Override
    public boolean onTouch(View v, MotionEvent e) {
        Vibrator vb =
            (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
        if(e.getAction() == MotionEvent.ACTION_DOWN) { // 按住螢幕中間的文字
            vb.vibrate(5000); // 震動 5 秒
        }
        else if(e.getAction() == MotionEvent.ACTION_UP) { // 放開手指
            vb.cancel(); // 停止震動
        }
        return true;
    }
}

#>}
#--------------------------------------------------------------------------------
#   197   RadioGroup  getCheckedRadioButtonId  
#--------------------------------------------------------------------------------
{<#
shen \Ch05_BuyTicket\app\src\main\java\tw\com\flag\ch05_buyticket ;D:\work\Ch05_FoodImgMenu\app\src\main\java\tw\com\flag\ch05_foodmenu

public void show(View v){
        TextView txv=(TextView)findViewById(R.id.txv);
        RadioGroup ticketType =
                (RadioGroup) findViewById(R.id.ticketType);

        // 依選取項目顯示不同訊息
        switch(ticketType.getCheckedRadioButtonId()){
            case R.id.adult:	// 選全票
                txv.setText("買全票");
                break;
            case R.id.child:	// 選半票
                txv.setText("買半票");
                break;
            case R.id.senior:	// 選敬老票
                txv.setText("買敬老票");
                break;
        }
    }
#2
public void show(View v) {
        TextView txv = (TextView) findViewById(R.id.txv);
        RadioGroup ticketType   = (RadioGroup) findViewById(R.id.ticketType);
        RadioGroup ticketNumber = (RadioGroup) findViewById(R.id.ticketNumber);

        int id;
        id=ticketType.getCheckedRadioButtonId();
        RadioButton type = (RadioButton) findViewById(id);

        id=ticketNumber.getCheckedRadioButtonId();
        RadioButton number = (RadioButton) findViewById(id);

        txv.setText(" buy" + type.getText() + number.getText());
    }
#>}
#--------------------------------------------------------------------------------
#   241  RadioButton   shen05
#--------------------------------------------------------------------------------
{<#  
shen \Ch05_BuyTicket\app\src\main\java\tw\com\flag\ch05_buyticket
D:\work\Ch05_TempConversion\app\src\main\java\tw\com\flag\Ch05_TempConversion
D:\work\Ch05_TempConversion\app\src\main\res\layout

package tw.com.flag.ch05_tempconversion;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity
    implements RadioGroup.OnCheckedChangeListener, TextWatcher {

    RadioGroup unit;
    EditText value;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        unit  = (RadioGroup)findViewById(R.id.unit);  // 取得『單位』單選鈕群組
        unit.setOnCheckedChangeListener(this);        // 設定 this 為監聽器

        value = (EditText)  findViewById(R.id.value); // 取得輸入欄位
        value.addTextChangedListener(this);           // 設定 this 為監聽器
    }

    @Override
    public void onCheckedChanged(RadioGroup group, int checkedId) {
        calc();
    }

    @Override
    public void beforeTextChanged(CharSequence s, int start, int count, int after) {

    }

    @Override
    public void onTextChanged(CharSequence s, int start, int before, int count) {

    }

    @Override
    public void afterTextChanged(Editable s) {
        calc();
    }
    protected void calc() {
        // 取得文字方塊
        TextView degF = (TextView) findViewById(R.id.degF);
        TextView degC = (TextView) findViewById(R.id.degC);

        double f, c;  // 儲存溫度值換算結果

        // 若選擇輸入華氏溫度
        if(unit.getCheckedRadioButtonId()==R.id.unitF){
            f = Double.parseDouble(
                    value.getText().toString());
            c = (f-32)*5/9;  // 華氏 => 攝氏

        } else{   // 若選擇輸入攝氏溫度
            c = Double.parseDouble(
                    value.getText().toString());
            f = c*9/5+32;    // 攝氏 => 華氏
        }
        degC.setText(String.format("%.1f",c)+getResources().getString(R.string.charC)); // 自專案資源載入字串
        degF.setText(String.format("%.1f",f)+getResources().getString(R.string.charF));
    }
}

#>}

#--------------------------------------------------------------------------------
#    322   CheckBox  shen05 
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch05_FoodMenu\app\src\main\java\tw\com\flag\Ch05_FoodMenu
ii D:\work\Ch05_FoodMenu\app\src\main\res\layout
package tw.com.flag.ch05_foodmenu;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.CheckBox;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void takeOrder(View v) {
        CheckBox chk;
        String msg="";
        // 用陣列存放所有 CheckBox 元件的 ID
        int[] id={R.id.chk1, R.id.chk2, R.id.chk3, R.id.chk4};

        for(int i:id){    // 以迴圈逐一檢視各 CheckBox 是否被選取
            chk = (CheckBox) findViewById(i);
            if(chk.isChecked())            // 若有被選取
                msg+="\n"+chk.getText();   // 將換行字元及選項文字
        }                                  // 附加到 msg 字串後面

        if(msg.length()>0) // 有點餐
            msg ="你點購的餐點是："+msg;
        else
            msg ="請點餐!";

        // 在文字方塊中顯示點購的項目
        ((TextView) findViewById(R.id.showOrder)).setText(msg);
    }
  }

ii D:\work\Ch05_FoodMenuEvent\app\src\main\java\tw\com\flag\Ch05_FoodMenuEvent   #-----------------------------
   D:\work\Ch05_FoodMenuEvent\app\src\main\java\tw\com\flag\ch05_foodmenu
ii D:\work\Ch05_FoodMenuEvent\app\src\main\res\layout
  Ch05_FoodMenuEvent

package tw.com.flag.ch05_foodmenu;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;

import java.util.ArrayList;


public class MainActivity extends AppCompatActivity
    implements CompoundButton.OnCheckedChangeListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 所有核取方塊 ID 的陣列
        int[] chk_id={R.id.chk1,R.id.chk2,R.id.chk3,R.id.chk4,
                R.id.chk5,R.id.chk6,R.id.chk7,R.id.chk8};

        
        for(int id:chk_id){                              // 用迴圈替所有核取方塊加上監聽物件
            CheckBox chk=(CheckBox) findViewById(id);
            chk.setOnCheckedChangeListener(this);
        }


    }

    // 用來儲存已選取項目的 ID 集合物件
    ArrayList<CompoundButton> selected=new ArrayList<>();

    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

        if (isChecked)   				// 若項目被選取
            selected.add(buttonView);   	// 加到集合之中
        else              					// 若項目被取消
            selected.remove(buttonView);	// 自集合中移除
    }

    public void takeOrder(View v) {
        String msg="";  // 儲存訊息的字串

        for(CompoundButton i:selected)   // 以迴圈逐一將換行字元及
            msg+="\n"+i.getText();   // 選項文字附加到 msg 字串後面

        if(msg.length()>0) // 有點餐
            msg ="你點購的餐點是："+msg;
        else
            msg ="請點餐!";

        // 在文字方塊中顯示點購的項目
        ((TextView) findViewById(R.id.showOrder)).setText(msg);
    }

}




#>}
#--------------------------------------------------------------------------------
#   437  ImageView  shen05 
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch05_ImageView\app\src\main\java\tw\com\flag\ch03_linearlayout   #-----------------------------
ii D:\work\Ch05_ImageView\app\src\main\res\layout


ii D:\work\Ch05_FoodImgMenu\app\src\main\java\tw\com\flag\ch05_foodmenu

package tw.com.flag.ch05_foodmenu;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity
    implements CompoundButton.OnCheckedChangeListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        int[] chk_id={R.id.chk1,R.id.chk2,R.id.chk3,R.id.chk4};
        for (int id:chk_id)
            ((CheckBox)findViewById(id)).setOnCheckedChangeListener(this);
    }

    int items=0;   // 記錄目前選取餐點的數量

    @Override
    public void onCheckedChanged(CompoundButton chk, boolean isChecked) {
        int visible;
        if(isChecked){  // 被選取時
            items++;    // 數量加 1
            visible=View.VISIBLE; // 將圖片設為可見
        }
        else{                     // 被取消時
            items--;              // 數量減 1
            visible=View.GONE;    // 將圖片設為不可見
        }

        switch (chk.getId()){  // 依項目 ID, 決定要更改的 ImageView ID
            case R.id.chk1:
                findViewById(R.id.output1).setVisibility(visible);
                break;
            case R.id.chk2:
                findViewById(R.id.output2).setVisibility(visible);
                break;
            case R.id.chk3:
                findViewById(R.id.output3).setVisibility(visible);
                break;
            case R.id.chk4:
                findViewById(R.id.output4).setVisibility(visible);
                break;
        }

        String msg;
        if(items>0) // 選取項目大於 0, 顯示有點餐的訊息
            msg= "你點的餐點如下";
        else        // 否則顯示請點餐的訊息
            msg= "請點餐!";
        ((TextView)findViewById(R.id.showOrder)).setText(msg);
    }
}

ii 
ii D:\work\Ch05_FoodImgMenu\app\src\main\java\tw\com\flag\ch05_foodmenu     #-----------------------------
ii D:\work\Ch05_FoodImgMenu\app\src\main\res\layout

https://onedrive.live.com/edit.aspx/%e6%96%87%e4%bb%b6/MingTseng?cid=2135d796bd51c0fa&id=documents&wd=target%28Android.one%7C5DA0733B-406B-4A7E-9CE1-79BEC7E5135A%2FImageView%20%20%20Shen%205%7CAD5CB8FA-CF56-473A-AB8F-64FAB3418E84%2F%29
onenote:https://d.docs.live.net/2135d796bd51c0fa/文件/MingTseng/Android.one#ImageView%20%20%20Shen%205&section-id={5DA0733B-406B-4A7E-9CE1-79BEC7E5135A}&page-id={AD5CB8FA-CF56-473A-AB8F-64FAB3418E84}&end


package tw.com.flag.ch05_foodmenu;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity
    implements CompoundButton.OnCheckedChangeListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        int[] chk_id={R.id.chk1,R.id.chk2,R.id.chk3,R.id.chk4};
        for (int id:chk_id)
            ((CheckBox)findViewById(id)).setOnCheckedChangeListener(this);
    }

    int items=0;   // 記錄目前選取餐點的數量
    @Override
    public void onCheckedChanged(CompoundButton chk, boolean isChecked) {
        int visible;
        if(isChecked){  // 被選取時
            items++;    // 數量加 1
            visible=View.VISIBLE; // 將圖片設為可見
        }
        else{                     // 被取消時
            items--;              // 數量減 1
            visible=View.GONE;    // 將圖片設為不可見
        }

        switch (chk.getId()){  // 依項目 ID, 決定要更改的 ImageView ID
            case R.id.chk1:
                findViewById(R.id.output1).setVisibility(visible);
                break;
            case R.id.chk2:
                findViewById(R.id.output2).setVisibility(visible);
                break;
            case R.id.chk3:
                findViewById(R.id.output3).setVisibility(visible);
                break;
            case R.id.chk4:
                findViewById(R.id.output4).setVisibility(visible);
                break;
        }

        String msg;
        if(items>0) // 選取項目大於 0, 顯示有點餐的訊息
            msg= "你點的餐點如下";
        else        // 否則顯示請點餐的訊息
            msg= "請點餐!";
        ((TextView)findViewById(R.id.showOrder)).setText(msg);
    }
}





#>}

#--------------------------------------------------------------------------------
#   582   spinner Shen06   Aug242016
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch06_TicketSpinner\app\src\main\java\tw\com\flag\Ch06_TicketSpinner   #-----------------------------
ii D:\work\Ch06_TicketSpinner\app\src\main\res\layout
package tw.org.tseng.mingpracties;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity
{

    TextView txv;
    Spinner cinema,time;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ex61);
        txv = (TextView) findViewById(R.id.txv);
        cinema = (Spinner) findViewById(R.id.cinema);
        time   = (Spinner) findViewById(R.id.time);
    }

    public void order(View v) {
        String[] cinemas = getResources().getStringArray(R.array.cinemas);
        String[] times = getResources().getStringArray(R.array.times);

        int index=cinema.getSelectedItemPosition();
        int index2=time.getSelectedItemPosition();

        txv.setText("take"+cinemas[index]+"   "+ times[index2]+"ticket");
    }
}


ii D:\work\Ch06_EnergyCalculator\app\src\main\java\tw\com\flag\Ch06_EnergyCalculator   #-----------------------------
ii D:\work\Ch06_EnergyCalculator\app\src\main\res\layout


package tw.org.tseng.mingpracties;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity
        implements AdapterView.OnItemSelectedListener{

    // 字串陣列中各項運動的能量消耗率:『仟卡/公斤/小時』
    double[] energyRate = {3.1, 4.4, 13.2, 9.7, 5.1, 3.7};

    EditText weight,time;   // 體重及運動時間欄位
    TextView total,txvRate; // 顯示能量消耗率, 計算結果的 TextView
    Spinner sports;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ex61);

        weight = (EditText)findViewById(R.id.weight);
        time   = (EditText)findViewById(R.id.timeSpan);
        total  = (TextView)findViewById(R.id.total);
        txvRate= (TextView)findViewById(R.id.txvRate);
        sports = (Spinner)findViewById(R.id.sports);
        sports.setOnItemSelectedListener(this); // 註冊監聽器

    }


    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int position, long id) {
        // 顯示選取的運動項目, 其基本的能量消耗率
        txvRate.setText(String.valueOf(energyRate[position]));
        calc(view); //只要在onItemSelected中呼叫 calc 會立即計算

    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {
        // 不會用到, 但仍需保留
    }

    public void calc(View v) {

        if (weight.getText().length() == 0 || time.getText().length() == 0 ) {
            return;
        }
        // 取得使用者輸入的體重
        double w = Double.parseDouble(weight.getText().toString());
        // 取得使用者輸入的運動時間長度
        double t=Double.parseDouble(time.getText().toString());

        int selected=sports.getSelectedItemPosition(); // 取得目前選取項目的索引

        // 計算消耗能量=能量消耗率*體重*運動時間長度
        long consumedEnergy=Math.round(energyRate[selected]*w*t);

        total.setText(		// 顯示計算結果
                String.format("消耗能量\n  %d仟卡", consumedEnergy));
    }
}




#>}

#--------------------------------------------------------------------------------
#   720  ListView Shen06  Aug.25.2016  
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch06_ListMenu\app\src\main\java\tw\com\flag\Ch06_ListMenu   #-----------------------------
ii D:\work\Ch06_ListMenu\app\src\main\res\layout
package tw.org.tseng.mingpracties;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity
        implements AdapterView.OnItemClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ex62);

        ListView lv = (ListView) findViewById(R.id.lv);
        lv.setOnItemClickListener(this);
    }
    // 儲存目前選取的項目 (餐點) 名稱字串
    ArrayList<String> selected = new ArrayList<>();

    @Override

    public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
        TextView txv = (TextView) view;  // 將被按下的 View 物件轉成 TextView
        String item = txv.getText().toString();
        if(selected.contains(item)) // 若 ArrayList 已有同名項目
            selected.remove(item);  // 就將它移除
        else                        // 若 ArrayList 沒有同名項目
            selected.add(item);     // 就將它加到 ArrayList (當成選取的項目)
        String msg;

        if(selected.size()>0){   // 若 ArrayList 中的項目數大於 0
            msg="你點了:";
            for(String str:selected)
                msg+=" "+str;    // 每個項目 (餐點) 名稱前空一格
        }                        // 並附加到訊息字串後面
        else                     // 若 ArrayList 中的項目數等於 0
            msg="請點餐!";

        TextView msgTxv =(TextView) findViewById(R.id.msgTxv);
        msgTxv.setText(msg);  // 顯示訊息字串

    }
}






#>}

#--------------------------------------------------------------------------------
#   797  Toast    shen07  aug.25
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch07_BrainTeaser\app\src\main\java\tw\com\flag\Ch07_BrainTeaser   #-----------------------------
ii D:\work\Ch07_BrainTeaser\app\src\main\res\layout


package tw.org.tseng.mingpracties;

import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.appindexing.Action;
import com.google.android.gms.appindexing.AppIndex;
import com.google.android.gms.common.api.GoogleApiClient;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity
        implements AdapterView.OnItemClickListener{

    // 建立問題陣列
    String[] queArr = {"什麼門遠永關不上", "什麼東西沒人愛吃？", "什麼瓜不能吃？", "什麼布切不斷？", "什麼鼠最愛乾淨？", "偷什麼不犯法？"};
    // 建立答案陣列
    String[] ansArr = {"球門", "虧", "傻瓜", "瀑布", " 環保署", "偷笑"};


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ex71);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item, // 使用內建的佈局資源
                
                queArr); // 以 queArr 陣列當資料來源
        ListView lv = (ListView)findViewById(R.id.lv);  //取得  ListView
        lv.setAdapter(adapter);			 //設定 ListView 使用的 Adapter
        lv.setOnItemClickListener(this); //設定 ListView 項目被按時的事件監聽器
    }


    @Override
    public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
        Toast.makeText(this,  "答案︰" + ansArr[position], Toast.LENGTH_SHORT).show();
    }
}

ii D:\work\Ch07_BrainTeaser2\app\src\main\java\tw\com\flag\Ch07_BrainTeaser   #-----------------------------
ii D:\work\Ch07_BrainTeaser2\app\src\main\res\layout

立即重新顯示

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;


public class MainActivity extends AppCompatActivity
        implements AdapterView.OnItemClickListener {
 
    // 建立問題陣列
    String[] queArr = {"什麼門遠永關不上", "什麼東西沒人愛吃？", "什麼瓜不能吃？", "什麼布切不斷？", "什麼鼠最愛乾淨？", "偷什麼不犯法？"};
    // 建立答案陣列
    String[] ansArr = {"球門", "虧", "傻瓜", "瀑布", " 環保署", "偷笑"};

    Toast tos; // 宣告 Toast 物件

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 建立供 ListView 使用的 ArrayAdapter 物件
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this,android.R.layout.simple_list_item_1,queArr);		

        ListView lv = (ListView)findViewById(R.id.lv);  //取得  ListView
        lv.setAdapter(adapter);			 //設定 ListView 使用的 Adapter
        lv.setOnItemClickListener(this); //設定 ListView 項目被按時的事件監聽器
        tos = Toast.makeText(this, "", Toast.LENGTH_SHORT); //建立 Toast 物件
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        tos.setText("答案︰"+ansArr[position]);  // 變更 Toast 物件的文字內容
        tos.show();                   // 立即重新顯示
    }
}


#>}
#--------------------------------------------------------------------------------
#   909    AlertDialog   shen07-2
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch07_DialogAsk\app\src\main\java\tw\com\flag\Ch07_DialogAsk   #-----------------------------
ii D:\work\Ch07_DialogAsk\app\src\main\res\layout
package tw.com.flag.ch07_dialogask;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity
        implements DialogInterface.OnClickListener {

    TextView txv; // 記錄預設的 TextView 元件

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        txv = (TextView) findViewById(R.id.answer); // 找出預設的 TextView 元件
        new AlertDialog.Builder(this) // 建立 Builder 物件
                .setMessage("你喜歡 Android 手機嗎？") // 設定顯示訊息
                .setCancelable(false) // 禁用返回鍵關閉交談窗
                .setIcon(android.R.drawable.ic_menu_edit) // 採用內建的圖示
                .setTitle("Android 問卷調查") // 設定交談窗的標題
                .setPositiveButton("喜歡", this)  // 加入否定按鈕
                .setNegativeButton("討厭", this)    // 加入肯定按鈕
                .setNeutralButton("沒意見", null) // 不監聽按鈕事件
                .show(); // 顯示交談窗
    }

    @Override
    public void onClick(DialogInterface dialog, int which) {
        if(which == DialogInterface.BUTTON_POSITIVE) { // 如果按下肯定的『喜歡』
            txv.setText("你喜歡 Android 手機");
        }
        else if(which == DialogInterface.BUTTON_NEGATIVE) { // 如果按下否定的『討厭』
            txv.setText("你討厭 Android 手機");
        }
    }
}

DialogInterface.BUTTON_NEGATIVE //按了代表"否"的按鈕
DialogInterface.BUTTON_NEUTRAL  //按了代表"中性"的按鈕
DialogInterface.BUTTON_POSITIVE //按了代表"是"的按鈕


ii D:\work\Ch07_DialogShow\app\src\main\java\tw\com\flag\Ch07_DialogShow   #-----------------------------
ii D:\work\Ch07_DialogShow\app\src\main\res\layout
package tw.com.flag.ch07_dialogshow;

import android.app.AlertDialog;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        AlertDialog.Builder bdr = new AlertDialog.Builder(this);
        bdr.setMessage("交談窗示範教學！\n" // 加入文字訊息
                + "請按返回鍵關閉交談窗");
        bdr.setTitle("歡迎");        // 加入標題
        bdr.setIcon(android.R.drawable.btn_star_big_on); // 加入圖示
        bdr.setCancelable(true);   // 允許按返回鍵關閉交談窗
        bdr.show();
    }
}


#>}

#--------------------------------------------------------------------------------
#   991  DatePickerDialog 與 TimePickerDialog  shen07-3
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch07_DateTimePicker\app\src\main\java\tw\com\flag\Ch07_DateTimePicker   #-----------------------------
ii D:\work\Ch07_DateTimePicker\app\src\main\res\layout

package tw.com.flag.ch07_datetimepicker;

import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.DatePicker;
import android.widget.TextView;
import android.widget.TimePicker;

import java.util.Calendar;


public class MainActivity extends AppCompatActivity
        implements View.OnClickListener,
        DatePickerDialog.OnDateSetListener,     // 實作監聽日期交談窗事件的介面
        TimePickerDialog.OnTimeSetListener {    // 實作監聽時間交談窗事件的介面

    Calendar c = Calendar.getInstance();  //建立日曆物件
    TextView txDate;                 // 記錄日期文字的元件
    TextView txTime;                 // 記錄時間文字的元件

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        txDate = (TextView)findViewById(R.id.textView1);
        txTime = (TextView)findViewById(R.id.textView2);

        txDate.setOnClickListener(this); //設定按下日期文字時的監聽物件
        txTime.setOnClickListener(this); //設定按下時間文字時的監聽物件
    }

    @Override
    public void onClick(View v) {
        if(v == txDate) { // 按的是日期文字
            //建立日期選擇交談窗, 並傳入設定完成時的監聽物件
            new DatePickerDialog(this, this,    // 由活動物件監聽事件
                    c.get(Calendar.YEAR),   //由Calendar物件取得目前的西元年
                    c.get(Calendar.MONTH),  //取得目前月 (由 0 算起)
                    c.get(Calendar.DAY_OF_MONTH)) //取得目前日
                    .show();  //顯示出來
        }
        else if(v == txTime) { // 按的是時間文字
            //建立時間選擇交談窗, 並傳入設定完成時的監聽物件
            new TimePickerDialog(this, this, // 由活動物件監聽事件
                    c.get(Calendar.HOUR_OF_DAY), //取得目前的時 (24小時制)
                    c.get(Calendar.MINUTE),      //取得目前的分
                    true)                        //使用24小時制
                    .show();   //顯示出來
        }
    }

    @Override
    public void onDateSet(DatePicker v, int y, int m, int d) {
        txDate.setText("日期：" + y + "/" + (m+1) + "/" + d);  // 將選定日期顯示在螢幕上
    }

    @Override
    public void onTimeSet(TimePicker v, int h, int m) {
        txTime.setText("時間：" + h + ":" + m);    // 將選定的時間顯示在螢幕上
    }
}



#>}
#--------------------------------------------------------------------------------
#   1067  New Activity   Application Name shen08-1
#--------------------------------------------------------------------------------
{<#
當我們在建立新專案時 , 需 輸 入 應 用 程 式 名 稱 (Application Name), 此名稱會同時做為應用程式的名稱 及 MainActivity 的 標題 。 
而當我們新増活動時 , 則只需輸入活動的標題 (Title) 即可 。 您可開啟 Strings.xml 檔來檢視或修改這2 個名稱 : 

#>}
#--------------------------------------------------------------------------------
#   1077  explicit intent   shen08-2
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch08_Memo\app\src\main\java\tw\com\flag\Ch08_Memo   #-----------------------------
ii D:\work\Ch08_Memo\app\src\main\res\layout

#-----MainActivity.java 
package tw.org.tseng.vanessaremember;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.Date;

public class MainActivity extends AppCompatActivity
        implements AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener {
    String[] aMemo = {   // 預設的備忘內容
            "1. 小乖.按一下可以編輯備忘",
            "2. 長按可以清除備忘" ,
            "3. 生命三要素",
            "4. 爸爸電話 0921-887912",
            "5. 小果子 22301341",
            "6. 白雲班 2230-1232 ext 81 or 16"
    };
    ListView lv;  // 顯示備忘錄的 ListView
    ArrayAdapter<String> aa; // ListView 與備忘資料的橋樑

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.content_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        lv = (ListView) findViewById(R.id.listView);
        aa = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, aMemo);
        lv.setAdapter(aa);    //設定 listView1 的內容
        //設定 listView1 被按一下的監聽器
        lv.setOnItemClickListener(this);
        //設定 listView1 被長按的監聽器
        lv.setOnItemLongClickListener(this);
    }

    @Override
    public void onItemClick(AdapterView<?> adapterView, View v, int pos, long id) {
        Intent it = new Intent(this, Edit.class);
        it.putExtra("編號",pos+1 );//附加編號
        it.putExtra("nowDate", new Date().toString());
        it.putExtra("備忘", aMemo[pos]); //附加備忘項目的內容
        startActivity(it);             	 //啟動 Edit 活動

    }

    @Override
    public boolean onItemLongClick(AdapterView<?> adapterView, View v, int pos ,long id) {
        aMemo[pos] = (pos+1) + "."; //將內容清除 (只剩編號)
        aa.notifyDataSetChanged();  //通知 Adapter 要更新陣列內容
        return true;     			//傳回 true 表示此事件已處理
    }
}


#-----Edit.java
package tw.org.tseng.vanessaremember;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class Edit extends AppCompatActivity {
    TextView txv;
    EditText edt;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.content_edit);


        Intent it = getIntent(); //取得傳入的 Intent 物件
        int no = it.getIntExtra("編號", 0); //讀出名為 "編號" 的 Int 資料, 若沒有則傳回 0
        String s = it.getStringExtra("備忘");  //讀出名為 "備忘" 的 String 資料
        String ndt = it.getStringExtra("nowDate");

        txv = (TextView) findViewById(R.id.textView);
        edt = (EditText) findViewById(R.id.editText);


        txv.setText(no + ".");//在畫面左上角顯示編號
        if (s.length() > 3) {
            edt.setText(s.substring(3)+"\n" +ndt);
        }//將傳來的備忘資料去除前3個字, 然後填入編輯元件中

    }
    public void onCancel(View v) {  //按取消鈕時
        finish();    //結束活動
    }

    public void onSave(View v) {    //按儲存鈕時
        finish();    //結束活動
    }

}

#要求  新 Activity 傳回資料 
ii D:\work\Ch08_Memo2\app\src\main\java\tw\com\flag\Ch08_Memo   #-----------------------------
ii D:\work\Ch08_Memo2\app\src\main\res\layout
#-----MainActivity.java 
package tw.org.tseng.vanessaremember;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.Date;

public class MainActivity extends AppCompatActivity
        implements AdapterView.OnItemClickListener, AdapterView.OnItemLongClickListener {
    String[] aMemo = {   // 預設的備忘內容
            "1. 小乖.按一下可以編輯備忘",
            "2. 長按可以清除備忘" ,
            "3. 生命三要素  :  爸爸,爸爸,爸爸",
            "4. 爸爸電話 0921-887912 ; 媽媽電話 0912-267291",
            "5. 小果子 2239-1341",
            "6. 白雲班 2230-1232 ext 81 or 16"
    };
    ListView lv;  // 顯示備忘錄的 ListView
    ArrayAdapter<String> aa; // ListView 與備忘資料的橋樑

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.content_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        lv = (ListView) findViewById(R.id.listView);
        aa = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, aMemo);
        lv.setAdapter(aa);    //設定 listView1 的內容
        //設定 listView1 被按一下的監聽器
        lv.setOnItemClickListener(this);
        //設定 listView1 被長按的監聽器
        lv.setOnItemLongClickListener(this);
    }

    @Override
    public void onItemClick(AdapterView<?> adapterView, View v, int pos, long id) {
        Intent it = new Intent(this, Edit.class);
        it.putExtra("編號",pos+1 );//附加編號
        it.putExtra("nowDate", new Date().toString());
        it.putExtra("備忘", aMemo[pos]); //附加備忘項目的內容
        //startActivity(it);             	 //啟動 Edit 活動
        startActivityForResult(it, pos); //啟動 Edit 並以項目位置為識別碼

    }

    @Override
    public boolean onItemLongClick(AdapterView<?> adapterView, View v, int pos ,long id) {
        aMemo[pos] = (pos+1) + "."; //將內容清除 (只剩編號)
        aa.notifyDataSetChanged();  //通知 Adapter 要更新陣列內容
        return true;     			//傳回 true 表示此事件已處理
    }

    protected void onActivityResult(int requestCode, int resultCode, Intent it) {
        if(resultCode == RESULT_OK) {
            aMemo[requestCode] = it.getStringExtra("備忘"); // 使用傳回的資料更新陣列內容
            aa.notifyDataSetChanged(); // 通知 Adapter 陣列內容有更新
        }
    }
}

#-----Edit.java

package tw.org.tseng.vanessaremember;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class Edit extends AppCompatActivity {
    TextView txv;
    EditText edt;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.content_edit);


        Intent it = getIntent(); //取得傳入的 Intent 物件
        int no = it.getIntExtra("編號", 0); //讀出名為 "編號" 的 Int 資料, 若沒有則傳回 0
        String s = it.getStringExtra("備忘");  //讀出名為 "備忘" 的 String 資料
        String ndt = it.getStringExtra("nowDate");

        txv = (TextView) findViewById(R.id.textView);
        edt = (EditText) findViewById(R.id.editText);


        txv.setText(no + ".");//在畫面左上角顯示編號
        if (s.length() > 3) {
            edt.setText(s.substring(3)+"\n" +ndt);
        }//將傳來的備忘資料去除前3個字, 然後填入編輯元件中

    }
    public void onCancel(View v) {  //按取消鈕時
        setResult(RESULT_CANCELED); // 傳回代表取消的結果碼
        finish();    //結束活動
    }

    public void onSave(View v) {    //按儲存鈕時
        Intent it2 = new Intent();
        it2.putExtra("備忘", txv.getText() + " " + edt.getText()); // 附加項目編號與修改後的內容
        setResult(RESULT_OK, it2);                                 // 傳回代表成功的結果碼, 以及修改的資料
        finish();    //結束活動
    }

}


#>}
#--------------------------------------------------------------------------------
#   1323  implicit intent  shen09
#--------------------------------------------------------------------------------
{<#

<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="tw.org.tseng.callvanessa">

    <uses-permission android:name="android.permission.CALL_PHONE" />
    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">
        
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>

282 萬芳社區 To  榮民服務處 call28219663
282 榮民服務處 回 萬芳社區  call28219703

15  南昌公園  TO 萬芳社區   call01543194
15  臺北車站  TO 萬芳社區   call01543188
15  六張犁站  TO 萬芳社區   call01543205
棕6 萬芳國小  TO 市政府     callbr617577
棕6 萬芳社區  TO 市政府	    callbr617595
棕6 市政府    TO 萬芳社區    callbr617607
棕6 興雅國中  TO 萬芳社區    callbr617613


package tw.org.tseng.callvanessa;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void call28219663(View view) {
        Intent it = new Intent();
    it.setAction(Intent.ACTION_CALL);
    it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#19663")));
    startActivity(it);
}

    public void call28219703(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#19703")));
        startActivity(it);
    }

    public void call01543194(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#43194")));
        startActivity(it);
    }
    public void call01543188(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#4318")));
        startActivity(it);
    }
    public void call01543205(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#43205")));
        startActivity(it);
    }

    public void callbr617577(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#17577")));
        startActivity(it);
    }

    public void callbr617595(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#17595")));
        startActivity(it);
    }

    public void callbr617613(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#17613")));
        startActivity(it);
    }

    public void callbr617607(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#17607")));
        startActivity(it);
    }
    public void call60643487(View view) {
        Intent it = new Intent();
        it.setAction(Intent.ACTION_CALL);
        it.setData(Uri.parse("tel:" + Uri.encode("0800005284,#43487")));
        startActivity(it);
    }

}


ii D:\work\Ch09_IntentStarter\app\src\main\java\tw\com\flag\Ch09_IntentStarter   #-----------------------------
ii D:\work\Ch08_Memo\app\src\main\res\layout

package tw.com.flag.ch09_intentstarter;

import android.app.SearchManager;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onClick(View v) {
        Intent it = new Intent(Intent.ACTION_VIEW); //建立意圖並指定預設動作

        switch(v.getId()) {//讀取按鈕的 Id 來做相關處理
            case R.id.buttonEmail:   //指定 E-mail 地址
                it.setData(Uri.parse("mailto:service@flag.com.tw"));
                it.putExtra(Intent.EXTRA_CC,                      //設定副本收件人
                        new String[] {"test@flag.com.tw"});
                it.putExtra(Intent.EXTRA_SUBJECT, "您好");        //設定主旨
                it.putExtra(Intent.EXTRA_TEXT, "謝謝！");//設定內容
                break;
            case R.id.buttonSms:  //指定簡訊的傳送對象及內容
                it.setData(Uri.parse("sms:0999-123456?body=您好！"));
                break;
            case R.id.buttonWeb:  //指定網址
                it.setData(Uri.parse("http://www.flag.com.tw"));
                break;
            case R.id.buttonGps:  //指定 GPS 座標：台北火車站
                it.setData(Uri.parse("geo:25.047095,121.517308"));
                break;
            case R.id.buttonWebSearch:  //搜尋 Web 資料
                it.setAction(Intent.ACTION_WEB_SEARCH);  //將動作改為搜尋
                it.putExtra(SearchManager.QUERY, "旗標出版");
                break;
        }
        startActivity(it);  //啟動適合意圖的程式
    }
}



#>}

#--------------------------------------------------------------------------------
#   1503   Camera  啟動相機程式   shen10 
#--------------------------------------------------------------------------------
{<#
ii D:\work\Ch10_Camera\app\src\main\java\tw\com\flag\Ch10_Camera   #-----------------------------
ii D:\work\Ch10_Camera\app\src\main\res\layout

package tw.com.flag.ch10_camera;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onGet(View v) {
        Intent it = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);  //建立動作為拍照的意圖
        startActivityForResult(it, 100);   //啟動意圖並要求傳回資料
    }

    protected void onActivityResult (int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(resultCode == Activity.RESULT_OK && requestCode==100) {
            Bundle extras = data.getExtras();         //將 Intent 的附加資料轉為 Bundle 物件
            Bitmap bmp = (Bitmap) extras.get("data"); //由 Bundle 取出名為 "data" 的 Bitmap 資料
            ImageView imv = (ImageView)findViewById(R.id.imageView);
            imv.setImageBitmap(bmp);    	    	  //將 Bitmap 資料顯示在 ImageView 中
        }
        else {
            Toast.makeText(this, "沒有拍到照片", Toast.LENGTH_LONG).show();
        }
    }
}

ii D:\work\Ch10_Camera2\app\src\main\java\tw\com\flag\Ch10_Camera   #-----------------------------
ii D:\work\Ch10_Camera\app\src\main\res\layout

package tw.com.flag.ch10_camera;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;


public class MainActivity extends AppCompatActivity {
    Uri imgUri;    //用來參照拍照存檔的 Uri 物件
    ImageView imv; //用來參照 ImageView 物件

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        imv = (ImageView)findViewById(R.id.imageView);  //參照 Layout 中的 ImageView 元件
    }

    public void onGet(View v) {
        String dir = Environment.getExternalStoragePublicDirectory(  //取得系統的公用圖檔路徑
                Environment.DIRECTORY_PICTURES).toString();
        String fname = "p" + System.currentTimeMillis() + ".jpg";  //利用目前時間組合出一個不會重複的檔名
        imgUri = Uri.parse("file://" + dir + "/" + fname);    //依前面的路徑及檔名建立 Uri 物件

        Intent it = new Intent("android.media.action.IMAGE_CAPTURE");
        it.putExtra(MediaStore.EXTRA_OUTPUT, imgUri);    //將 uri 加到拍照 Intent 的額外資料中
        startActivityForResult(it, 100);
    }

    protected void onActivityResult (int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(resultCode == Activity.RESULT_OK && requestCode==100) {   
            Bitmap bmp = BitmapFactory.decodeFile(imgUri.getPath());   //讀取圖檔內容轉換為Bitmap物件
            imv.setImageBitmap(bmp);                                   //將 Bitmap 物 件 顯 示 在 Imageview 中
        }
        else {
            Toast.makeText(this, "沒有拍到照片", Toast.LENGTH_LONG).show();
        }
    }
}

ii D:\work\Ch10_Camera3\app\src\main\java\tw\com\flag\Ch10_Camera   #-----------------------------
ii D:\work\Ch10_Camera3\app\src\main\res\layout

<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools" android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity"
    android:orientation="vertical">

    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="拍照"
        android:id="@+id/button"
        android:onClick="onGet" />

    <ImageView
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:id="@+id/imageView"
        android:scaleType="centerInside" />
</LinearLayout>


package tw.com.flag.ch10_camera;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;


public class MainActivity extends AppCompatActivity {
    Uri imgUri;    //用來參照拍照存檔的 Uri 物件
    ImageView imv; //用來參照 ImageView 物件

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        imv = (ImageView)findViewById(R.id.imageView);  //參照 Layout 中的 ImageView 元件
    }

    public void onGet(View v) {
        String dir = Environment.getExternalStoragePublicDirectory(  //取得系統的公用圖檔路徑
                Environment.DIRECTORY_PICTURES).toString();
        String fname = "p" + System.currentTimeMillis() + ".jpg";  //利用目前時間組合出一個不會重複的檔名
        imgUri = Uri.parse("file://" + dir + "/" + fname);         //依前面的路徑及檔名建立 Uri 物件

        Intent it = new Intent("android.media.action.IMAGE_CAPTURE");
        it.putExtra(MediaStore.EXTRA_OUTPUT, imgUri);    //將 uri 加到拍照 Intent 的額外資料中
        startActivityForResult(it, 100);
    }

    protected void onActivityResult (int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(resultCode == Activity.RESULT_OK && requestCode==100) {
            showImg(); //
        }
        else {
            Toast.makeText(this, "沒有拍到照片", Toast.LENGTH_LONG).show();
        }
    }

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
    }
}


#>}

#--------------------------------------------------------------------------------
#   
#--------------------------------------------------------------------------------
{<#
trimspace '讀 取 圖 檔 內 容 轉 換 為 Bi tmap 物 件';

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

