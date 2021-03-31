/*
説明
Sキーを押すとレーンが回転し始めます。
以下のキーを押し続けると対応するレーンが止まります。
Qキー:左レーン
Wキー:真ん中レーン
Eキー:右レーン
押し続けていないと止まりません。*改良の余地あり
Sキーを押すと全てのレーンが再び周り始めます。
真ん中の横ラインの柄が揃うと点が得られます。
*/
import ddf.minim.*;
Minim minim;
AudioPlayer bgm,touch,start;

int an_y1=100,an_y2=200,an_y3=100;
int ka_y1=300,ka_y2=600,ka_y3=300;
int mi_y1=500,mi_y2=400,mi_y3=500;
int pi_y1=700,pi_y2=0,pi_y3=700;
int speed1=0,speed2=0,speed3=0;
int score=0;

void setup(){
    size(800,600);
    minim=new Minim(this);
    //音源定義
    bgm=minim.loadFile("bgm.mp3");
    touch=minim.loadFile("stop.mp3");
    start=minim.loadFile("continue.mp3");
    //bgm再生
    bgm.loop();
}

void draw(){
    display();
    play();    
    stopping();
    restart();    
}

//アンパンマン描画関数
void anpanman(int an_x,int an_y){
    //アンパンマン描画
    noStroke();
    fill(255,160,122);
    ellipse(an_x,an_y,160,160);//輪郭
    fill(255,0,0);
    ellipse(an_x,an_y,50,50);//真ん中鼻
    fill(255,69,0);
    ellipse(an_x-50,an_y,50,50);//両端鼻
    ellipse(an_x+50,an_y,50,50);
    fill(0,0,0);
    ellipse(an_x-25,an_y-30,10,20);//両目
    ellipse(an_x+25,an_y-30,10,20);
    fill(255,255,255);
    rect(an_x-50,an_y,7,7);//白鼻
    rect(an_x,an_y,7,7);
    rect(an_x+50,an_y,7,7);
    stroke(0);
    noFill();
    arc(an_x,an_y+5,90,70,PI*1/6,PI*5/6);//口
}
//カービィ描写関数
void kavi(int ka_x,int ka_y){
    noStroke();
    fill(255,0,0);
    ellipse(ka_x-40,ka_y+60,60,35);//足
    ellipse(ka_x+40,ka_y+60,60,35);
    fill(255,182,193);
    ellipse(ka_x-60,ka_y,50,30);//手
    ellipse(ka_x+60,ka_y,50,30);
    ellipse(ka_x,ka_y,160,160);//顔
    fill(0,0,0);
    ellipse(ka_x-18,ka_y-20,12,35);//黒目
    ellipse(ka_x+18,ka_y-20,12,35);
    fill(255,255,255);
    ellipse(ka_x-18,ka_y-28,10,20);//白目
    ellipse(ka_x+18,ka_y-28,10,20);
    fill(255,20,147);
    ellipse(ka_x+40,ka_y,20,10);
    ellipse(ka_x-40,ka_y,20,10);//頬
    stroke(0);
    noFill();
    arc(ka_x,ka_y,30,30,PI*1/6,PI*5/6);//口
}
//マイク描写関数
void mike(int mi_x,int mi_y){
    noStroke();
    fill(240,230,140);
    ellipse(mi_x-40,mi_y-65,10,25);//角
    ellipse(mi_x+40,mi_y-65,10,25);
    fill(173,255,47);
    ellipse(mi_x,mi_y,160,160);//顔
    fill(255,255,255);  
    ellipse(mi_x,mi_y-20,80,80);//白目
    fill(32,178,170);
    ellipse(mi_x-10,mi_y-20,40,40);//青目
    fill(0,0,0);
    ellipse(mi_x-10,mi_y-20,25,25);//黒目
    fill(255,255,255);
    ellipse(mi_x,mi_y-25,10,10);//虹彩
    stroke(0);
    noFill();
    arc(mi_x,mi_y-5,100,100,PI*1/3,PI*5/6);//口
}
//ピカチュウ描写関数
void pickachu(int pi_x,int pi_y){
    noStroke();
    fill(255,230,0);
    ellipse(pi_x,pi_y,160,160);//顔
    fill(0,0,0);
    ellipse(pi_x,pi_y,5,5);//鼻
    ellipse(pi_x-30,pi_y-20,25,25);//黒目
    ellipse(pi_x+30,pi_y-20,25,25);
    fill(255,255,255);
    ellipse(pi_x-25,pi_y-25,10,10);//白目
    ellipse(pi_x+25,pi_y-25,10,10);
    fill(255,0,0);
    ellipse(pi_x-50,pi_y+13,34,34);//頬
    ellipse(pi_x+50,pi_y+13,34,34);
    stroke(0);
    noFill();
    arc(pi_x-10,pi_y+10,25,15,PI*1/6,PI*5/6);//口
    arc(pi_x+10,pi_y+10,25,15,PI*1/6,PI*5/6);
}
//プレイ関数
void play(){
    //アンパンマン描画
    anpanman(100,an_y1);
    anpanman(300,an_y2);
    anpanman(500,an_y3);
    //カービィ描画
    kavi(100,ka_y1);
    kavi(300,ka_y2);
    kavi(500,ka_y3);
    //マイク描写
    mike(100,mi_y1);
    mike(300,mi_y2);
    mike(500,mi_y3);
    //ピカチュウ描写
    pickachu(100,pi_y1);
    pickachu(300,pi_y2);
    pickachu(500,pi_y3);
    //アンパンマン回転
    an_y1+=speed1;//回転スピード
    an_y2+=speed2;
    an_y3+=speed3;
    //カービィ回転
    ka_y1+=speed1;
    ka_y2+=speed2;
    ka_y3+=speed3;
    //マイク回転
    mi_y1+=speed1;
    mi_y2+=speed2;
    mi_y3+=speed3;
    //ピカチュウ回転
    pi_y1+=speed1;
    pi_y2+=speed2;
    pi_y3+=speed3;
    //上に戻る
    //アンパンマン
    if(an_y1>=720){
        an_y1=-80;
    }
    if(an_y2>=720){
        an_y2=-80;
    }
    if(an_y3>=720){
        an_y3=-80;
    }
    //カービィ
    if(ka_y1>=720){
        ka_y1=-80;
    }
    if(ka_y2>=720){
        ka_y2=-80;
    }
    if(ka_y3>=720){
        ka_y3=-80;
    }
    //マイク
    if(mi_y1>=720){
        mi_y1=-80;
    }
    if(mi_y2>=720){
        mi_y2=-80;
    }
    if(mi_y3>=720){
        mi_y3=-80;
    }
    //ピカチュウ
    if(pi_y1>=720){
        pi_y1=-80;
    }
    if(pi_y2>=720){
        pi_y2=-80;
    }
    if(pi_y3>=720){
        pi_y3=-80;
    }
}
//止める関数
void stopping(){
    //キーボードを押し続けると止まる
    if ((keyPressed== true) && (key == 'q')){
        speed1=1;//回転スピードを１にする
        if(an_y1==100||an_y1==300||an_y1==500||an_y1==700){
            speed1=0;//止める
        }
    }
    if ((keyPressed == true) && (key == 'w')){
        speed2=1;
        if(an_y2==100||an_y2==300||an_y2==500||an_y2==700){
            speed2=0;
        }
    }
    if ((keyPressed == true) && (key == 'e')){
        speed3=1;
        if(an_y3==100||an_y3==300||an_y3==500||an_y3==700){
            speed3=0;
        }
    }
}
//止めた時の効果音
void keyReleased() {
    if (key == 'q'||key == 'w'||key == 'e'){
        touch.rewind();//巻き戻し
        touch.play();//再生
    }
}
//もう一度回転
void restart(){
    if(keyPressed==true&&key=='s'){
        start.rewind();
        start.play();
        speed1=20;
        speed2=20;
        speed3=20;
        score();
    }
}
//スコア計算
void score(){
    if(an_y1==300&&an_y2==300&&an_y3==300){
        score+=10;//アンパンマンが揃うと10p
    }
    else if(mi_y1==300&&mi_y2==300&&mi_y3==300){
        score+=30;//マイクが揃うと30p
    }
    else if(ka_y1==300&&ka_y2==300&&ka_y3==300){
        score+=20;//カービィがそろうと20p
    }
    else if(pi_y1==300&&pi_y2==300&&pi_y3==300){
        score+=50;//ピカチュウが揃うと50p
    }
}
//スコア判定
void judge(){
    if(speed1==0&&speed2==0&&speed3==0){
        if(an_y1==300&&an_y2==300&&an_y3==300){
            fill(255,160,122);
            text("アンパンマン！！    +10P",630,440);
        }
        else if(mi_y1==300&&mi_y2==300&&mi_y3==300){
            fill(173,255,47);
            text("マイク！！    +30P",640,440);
        }
        else if(ka_y1==300&&ka_y2==300&&ka_y3==300){
            fill(255,182,193);
            text("カービィ！！    +20P",640,440);
        }
        else if(pi_y1==300&&pi_y2==300&&pi_y3==300){
            fill(255,230,0);
            text("ピカチュウ！！    +50P",640,440);
        }
        else{
            fill(198,198,198);
            text("ハズレ！！",675,440);
        }
    }
}

//枠線やスコア表示など
void display(){
    background(192,192,192);
    fill(255,255,255);
    strokeWeight(0);
    rect(0,200,600,200);
    rect(600,0,200,600);
    fill(0,0,0);
    rect(600,400,800,50);
    //スロットの枠線
    strokeWeight(1);
    line(0,200,600,200);
    line(0,400,600,400);
    strokeWeight(10);
    line(200,0,200,600);
    line(400,0,400,600);
    line(600,0,600,600);
    strokeWeight(3);
    //説明テキスト
    text("Sキーを押すとレーンが回転し始めます。\n以下のキーを押し続けると対応するレーンが止まります。\nQキー:左レーン\nWキー:真ん中レーン\nEキー:右レーン\n\nSキーを押すと全てのレーンが再び周り始めます。\n真ん中の横ラインの柄が揃うと得点が得られます。",607,0,150,200);
    //miniアンパンマン
    noStroke();
    fill(255,160,122);
    ellipse(635,200,40,40);//輪郭
    fill(255,0,0);
    ellipse(635,200,10,10);//真ん中鼻
    fill(255,69,0);
    ellipse(625,200,10,10);//両端鼻
    ellipse(645,200,10,10);
    fill(0,0,0);
    ellipse(630,193,3,6);//両目
    ellipse(640,193,3,6);
    stroke(0);
    strokeWeight(1);
    noFill();
    arc(635,202,20,15,PI*1/6,PI*5/6);//口
    //スコア説明
    text("= 10P",670,205);
    text("= 20P",670,248);
    text("= 30P",670,291);
    text("= 50p",670,334);
    //スコア表示
    fill(255,255,255);
    text("SCORE:"+score,620,410);
    //miniカービィ
    noStroke();
    fill(255,0,0);
    ellipse(625,262,15,8);//足
    ellipse(645,262,15,8);
    fill(255,182,193);
    ellipse(615,245,10,5);//手
    ellipse(655,245,10,5);
    ellipse(635,245,40,40);//顔
    fill(0,0,0);
    ellipse(630,240,5,10);//黒目
    ellipse(640,240,5,10);
    fill(255,255,255);
    ellipse(630,237,3,5);//白目
    ellipse(640,237,3,5);
    stroke(0);
    strokeWeight(1);
    noFill();
    arc(635,245,8,12,PI*1/6,PI*5/6);//口
    //miniマイク
    noStroke();
    fill(240,230,140);
    ellipse(627,273,3,10);//角
    ellipse(643,273,3,10);
    fill(173,255,47);
    ellipse(635,290,40,40);//顔
    fill(255,255,255);  
    ellipse(635,285,20,20);//白目
    fill(32,178,170);
    ellipse(632,286,12,12);//青目
    fill(0,0,0);
    ellipse(632,286,7,7);//黒目
    fill(255,255,255);
    ellipse(634,284,2,2);//虹彩
    stroke(0);
    strokeWeight(1);
    noFill();
    arc(635,291,20,20,PI*1/3,PI*5/6);//口
    //miniピカチュウ
    noStroke();
    fill(255,230,0);
    ellipse(635,335,40,40);//顔
    fill(0,0,0);
    ellipse(635,335,2,2);//鼻
    ellipse(627,328,7,7);//黒目
    ellipse(643,328,7,7);
    fill(255,255,255);
    ellipse(628,327,3,3);//白目
    ellipse(642,327,3,3);
    fill(255,0,0);
    ellipse(623,336,8,8);//頬
    ellipse(647,336,8,8);
    stroke(0);
    strokeWeight(1);
    noFill();
    arc(632,337,6,4,PI*1/6,PI*5/6);//口
    arc(638,337,6,4,PI*1/6,PI*5/6);
    //スコア表示
    judge();
}

void stop(){
    touch.close();
    start.close();
    minim.stop();
    super.stop();
}
