Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EAAC4167D
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 16:01:53 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.39913.1702483313011149095
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Dec 2023 08:01:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Id7MDWyN;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1C3009C2CAF;
	Wed, 13 Dec 2023 11:01:52 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id WzBrg9TiPKAw; Wed, 13 Dec 2023 11:01:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7F0319C2C84;
	Wed, 13 Dec 2023 11:01:48 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7F0319C2C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702483308; bh=qMGOedxShzm9JyJv8SPVdCje3Ch09cWwuMG6n+TZ5Eo=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Id7MDWyN2UPLLnYmvQqQue8gq2f2TWwtRlK2Sbsx+f5/Cc9YppRx5rqL2YxVmFkVx
	 gVNTViCFCJC1BwP4nX92xIZEmbAAajrKpnWRBs069dB3syYCrvIgRv9Zz8gOWjSJIO
	 Vn8OHa8DfBjJb0hMFZ4Jrm3e7Ep2BPCkHRpcDFhEhTA0x8hHMmTZuZPtStyTDJJpgW
	 kL9cF+oVvuI/f/Oe29WlxcTp6advgGFPALFN9H04EvF+Zw2zQYDFBxXmUNeO3mZYcF
	 zTux38VUNO/7U8gEjJi+Cd1sxuSujjQ9oL5+gy2VKCa1obn+ebWmNdp0Ewk8ozPZTu
	 6bwjQ0vEyV86w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vha1-7WANhST; Wed, 13 Dec 2023 11:01:48 -0500 (EST)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 45DC19C2CAF;
	Wed, 13 Dec 2023 11:01:48 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [toaster][PATCHv2 1/1] toaster: Added dataTables library to include sorting and pagination for table element
Date: Wed, 13 Dec 2023 11:01:41 -0500
Message-Id: <20231213160141.249276-2-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213160141.249276-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: <20231213160141.249276-1-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Dec 2023 16:01:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15665

Added jquery.dataTables to customize table rendering in section "Import e=
ventlogs".
This library includes the following: sorting, pagination, search and CSS =
styles.

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 .../static/css/jquery.dataTables-1.13.8.min.css | Bin 0 -> 22711 bytes
 .../static/js/jquery.dataTables-1.13.8.min.js   | Bin 0 -> 87276 bytes
 .../templates/command_line_builds.html          |   9 ++++++++-
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 lib/toaster/toastergui/static/css/jquery.dataTables-1=
.13.8.min.css
 create mode 100644 lib/toaster/toastergui/static/js/jquery.dataTables-1.=
13.8.min.js

diff --git a/lib/toaster/toastergui/static/css/jquery.dataTables-1.13.8.m=
in.css b/lib/toaster/toastergui/static/css/jquery.dataTables-1.13.8.min.c=
ss
new file mode 100644
index 0000000000000000000000000000000000000000..c0a442ce07d26697b28b56da7=
ef13d0e2397452d
GIT binary patch
literal 22711
zcmcf}S#smJ^*^Uz+SOI|#8k9ca+|7hO-+7sfc(2C5we(;NEJ!7-Ochfa*%xFt51`Y
z<UIfcK`bOdsWYCLvdOnESRNi26?tCOVVG25k-vo{Igo8dk|>xh?t|HEdLPV}i?#MX
ztjK#6!Mh~_u>TpL4r%r^3Z8%x5Sq;-h^k0WBnsd${@cFT=3Dif-7Jm2Pr^DztaA|XYZ
zy((|_)$tH+;_cVhB0py!`P)9N$VY^VO_I3yT2tvYu;O)dy8tB@kN3gD?CztAHwOX;
zRs0Y9EvS+S7-gGhRgoWR)HjR|>1!5kNmh|!y*(FYUPPxn#XtMeqYc^R1*wy?JRRci
zQJR5eNVqxV+plX-59ok6@hvw8SY)!igBL(KtD;Z;{nvj!=3D?n^#Zy%R`+oy-5D{jM2
zqVV(62bzFdB<R((MHX^3F6Pcg>H4TSN!CkT6L3%B<hd%ItNjG5UO^b#JHWie<<<!<
zA&!7R@CCex5t2AlcELy-^b#-wdbMx^dbNO#dbJ2hS?E=3DFlVN?z%d|@KEGoz$uF`L0
zeTtI=3DoE8@8>%NNStJAw4(7KO#D7qLrig%EPE|6$E55g4OojBUXhdPCKColWShfN31
zon6PvKK#0fLkvY&4YO!Lor$_RTo870cnj_3a0T8=3Dc9CWt)<Gp&Ja=3D|ozp-hnC#kw>
zDGX~d48)rf=3DJ1NFn+cH3eEBKfrq%aoGMg{gY-E^CPw#6wIqnG^DxTo)9ZZB_nf@Tr
z<O?}odEju14l(V#xcR$<?>J)6pe^25Pk08254fA^ZA|#7-r|{5uQz#B<;Q3_{VXqx
z{{5-@*Iz#wR!WA6Whf(BKY$V*a|<<*7jY$NdXlY`scWDicEYfOdI-odW1zDb*BP5A
zySmCxYDoO-gv8HJjv+B>9PrZFJJpzqVw7CDjC^!_8WU63Nmeg|v|=3Djzqb$!zpR!TB
z#Z_fbt|T0!&d(K2ClMu?q~F>dUingPVQY8zBTv3RE1L<}XNV0)<F;|g%phZMlS>$b
z{<t0%J5H1Ory}2yvV>*1VWw^p>p*rD&9JvLsrJ!)iWBrPE?(0tr0>F+{0PxPT;8ws
z9W&npM00riBTTb|yhpR?hhm#ns%Ll;9pVyp;kd<Zg%rCACes%bi7yvsOCeq~BgY^<
zSGh9>WY}^Mix$*rx@Np)3yBy0zM*A_u!xiNTv9_xwFs;+$c2=3D<wes>?T-<8KmAkuj
zoTW$DIOSPbrAOR1?amp5JnX2p=3DS{i|H{?f33al5*=3D)coDFD0X_+B2ix&hBdJ#xJ0Y
z;2L2Wgr-Cp9`YFKF5xVgtjZwGc4>y?6<4QGAGX})j@;%~;kMx178r4T%3X)u1829y
z@b6=3D{=3DxX=3D-SMq&V#79yF2D{hO&vjMASqT-SV^nVA1GxovL)Pifp^Wv>OKoAI23SUF
zz@?wsyi1Kr3HyDJ4=3DPw1(f0NH;q*=3D+)G>aN<!?oN3aY(2w2L=3DMP3wDM33~?|)e&AL
z1Nc}Q!?;%I@H!d3l52YSw}lET_gU!lyle`I<qJ8Us_!y4hGpSL_dynR^qowJKClq_
z=3DeexX-FFKq{#GW&A6dvTQ(LI9mu{|siPhj>ctl?qs%kr^<Qg&9i$vDJ;z-7m7EIw+
zOJr~X2B5e!PEfRjjASWCe>rX8rAlgpQ)TUkYo%pyvb^kxAv6@rTB27K*aD`?+Y8o;
zOTlDm>4RZmtr?<<YXwvV9sq1b=3D76%${L!%3woFu|w!x`F_rtX^dnEY=3D*3^6y#$PQ7
z$Dk+!0VP|+oXje1TTrXi-Gf@?U<pH&fomA5<gG!YGVlo+m5I&CDi3ET*L*<?>kz&l
zh^BP8z1|*3TtrZ>**B|WIO00Qr;<b^ImHF65SkY_i^K9Znp&e?pKy5i*0d`4#;Syy
z{E(<5<UO29MS2JO3U)RDdy#fM&#O(d(|Z7=3D%QOkp^SOm~VkptvTQ;Z?h<SsmZ9`F6
zcJ8ICAl`LVfWuah8rGonm&Ve#iSf}Us90nab-QJO(@;FMqYF9kBb-gDHWyfv<|O&~
zw|bMmhvhy_@;5m6EJ+ni>CY4V142^6%9|uS{d|I*(lC~J_r&qVvFdH-^b(I%`O)L8
z5uYAy-)Y{}H4EapB_+<dhw0;?xShVX@@*KmPKK=3D-b**ar37+7y{pd6Go;h&LVA{HC
z!fW-tq;!}B+>HnIVSm8Q-~?F-c9UGuE-jk<KO~Qu1H&l8Y7MbaRqVod)HRi@Od^Wp
z_)ArY-=3DC{tSp~3yDA}Cn=3D*@J#nv<Po<1INrw*>W2uVc+{9c}HS2{;$hmqr1d6MF_8
zQyiFi?`6Ylfndf-WSquGxT?5<L^5epXqqJI;&iNOjGdCU$p}YH@+5iwP19YCPzDC-
z4i39gzsYpI7%}Ej`R;JUMSLyV4DyQ*c2q=3DychN|jNJgo}yP&9IPbS4^o09NL#Qq%i
zOathmiR_yNO{hV4cIGoG6LSrqYp&^PAgtU-I2>fn1m9o`=3DyWqpR%Dk1e@>4lXyA#n
zYV8o99gP}}pw#S6BBbfYh8~!lp>2#gDS+0YrorZArYSdoF!x1RXb7Dg9gxNjs|#X>
zT?{xxUC>Tvo{KJKU(uGwLJf$xxkE&pw_gmHx?PMOHDC^V%7CN?km?2lk}jhIl9Lm)
zG0)eNa_1)-^Gt5+hzm<gI?XsH)x<CpNRIan)#ZcVTxASZAfkn8zmB>K<uL2laqg?*
z!{Zfn1R|a~>Ivblqf@kY=3DCx}KISa#(WAdXRC-p=3DgQr1Mo#j{$D`i8KcqptC55ZOPF
zO+-fN?Hks*-mWoi5ZOPtO+-fN4N<zjV8H_=3D5vMpO-$*76tlB!HH@+2Q7d_=3D{zIfWf
zCCKn_)s@mSloe!e6=3DxTEaXQnl8fcZ4NmokGs8x`CRh*952g)0!DNu0pq9M6FM`YC1
zM8!pEZAiX2exID<*C6wVKsHesr}?E}{p1|h2AN01w~5Lq%`cAjr=3DDnUO1A~yBfBn^
z>E7Iq?4qbVE`OQ(4_Z?70MKpeY?W~!nEMs<UMfF&ZU=3DBpAt?yx-U<%HY`=3Dou>*UpC
z9t3np1r2#MFd~~YHBoU1T5Uug6S-2A2o_E5!D|qDL=3D>B-j8c6}Om|gx4{L+aBjVdc
zWt8e;qP?rSDd4j_!~;|4iRDKVBaV0{+x!S8*4T~2`d+m4wF00Y=3D?DORjBTgD0D36!
zBYrytezq?TxS{P%9S4kkRd_G~#pd(}9?kPRq;P2T{vkI{W8>WktSK(}h_2lB{NIES
z$V3h#d#(2M4w_7>h_-vkZ#fGCM!@{dT`8UB+{AIbZqA-qPcC-pHb?x}9o%=3DG%@2pu
zY!6qBD}jcF8xm}n9x%9=3DD)iWEEww<?2aYtL%l34xezk6L4>y=3D-P&R1&&Fj{+>(*zD
zndp)4<Z-!#J6c25I>pdH4viqa_UaOz`_K(04TqP_87>ZGa!88-;9Xou>)gnOj_Z(j
zw@iR(BSwUO1khF9>3_%GV#(30%ZNQm$To*=3D7i`<c<2~ufLb*NO4Lcc*i7ExS)O?}D
zISSIocBf0j)f<}CCUCJA`#kP1rofiKykmmrSFfV#`2=3DoD#Vvn+%B{jo@tjNmMd2IS
zd`+wH6}$66i(9-25*POYjx+%@DDdCdOmH92c8;)w7q`>T_pCEzzJR54`#(77T;4&A
zTmr@3X$~x}x&h2643nXiiHboLX}QqfD67Ci8yY~SpS$#r`H%3|5r>Na)Of!@@cfsN
z)<q5)Uyro7^T4L364a#GX9LFPQbU3z(*;Q>2(gP)&Hep^?BesG;=3D|F+YPIT3(au=3DZ
zrd{W8+k`+n97gNj89(S1fL_sVX7IU@b|`4NV!BT+9UyL&U+~8?93X#>{O6Qtwj-)f
zdb{9SveyCClAObsJ-KH_9-msKyM6}ePq+9Zy|~!_^9}wO{m+>Bga9MPLV#g=3DMS&Z-
zEfAcrZL#2j+!qdZ{C4zcJ4a!$8eooi#0xaNrKd72>t-J?#bw+e0k%6C9A??de-I28
z(1Sqj?Z;uzW(iH#BG6h(_bh`-u}iPgO5PD8P_F#7muKr{orT|Sf^7kOMv7jn#oc3-
zpSSyqIk4-wQup+J&^k;6yU-fR<Z2{w+s#{Vho(DMDFw--1{+r?+ydlZqdKNZav;CJ
z!gzC27N3;^u4W`Gpim<vznGCQ-Twc@$f8lruP9H~O`b%1a30Cp>l0FQTsu;=3D4^3W%
zi;=3Dvp)hUxm*(r9r^!pk1u3b2_ll{$$FA{w<AZU{Rofg8n-%c|H$q=3D1C#4UVY_<({F
z71*|H<QLq(rDeKF5BM1wZcX0%5j9^|;~!CjuR^r<QW{r${C*@!8V6u5Lb4#vlHm3j
zzw_OH@VI(Bz2DUavviE@HnKOvH7lH;T6*2U<be*Wrm9i%@(p&`V_5=3Dj>h@}~dVotI
z!<u-_c)WHqQWIV;)ASHusbk;m6K6H{uMP5V33je|urCTKeP0R*`zP!=3DGmQ{P{cN5D
zC0e;nMdjNsa69A)F6uwQL6ZwLaec@I*nE+w2UA=3Dd+TXiC3Dq#vI-`f1UZx8W*e`G8
zZAM6X5O~Ime(ZkoI&_bUtB3nw1z(7Kg!}AX5{uIi<*J5<8a5Km00|Ch_O;Xb@-bQV
zNNBo^&~GL)hMTEGWs-ivs~a?K7BzG4-T|@u!;I~C8|2n3;m{<&#xqvCmz+F=3D#ztK0
zc?K&}$)8!p%NBSXEb1*h21Khonnn5`svNgN!ZfpsUc74Rz^%<Mro}5dT7?@_mPZyz
zQ}&V6&Nz?Oz&k|OkgF+*d3eumu!a~f)m>A*rrg2yeM*(?8kXqu%o0AC%l?yN5Iu7%
Vy}F7Nyf)cJdUUgh@#o`D{{!8rxE=3Dri

literal 0
HcmV?d00001

diff --git a/lib/toaster/toastergui/static/js/jquery.dataTables-1.13.8.mi=
n.js b/lib/toaster/toastergui/static/js/jquery.dataTables-1.13.8.min.js
new file mode 100644
index 0000000000000000000000000000000000000000..b6d9aa8c7971a3e12f09cac3e=
04bffa94c020b4b
GIT binary patch
literal 87276
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
P
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
a
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
l
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

literal 0
HcmV?d00001

diff --git a/lib/toaster/toastergui/templates/command_line_builds.html b/=
lib/toaster/toastergui/templates/command_line_builds.html
index d6ff685c..fcbe80d8 100644
--- a/lib/toaster/toastergui/templates/command_line_builds.html
+++ b/lib/toaster/toastergui/templates/command_line_builds.html
@@ -1,6 +1,7 @@
 {% extends "base.html" %}
 {% load projecttags %}
 {% load humanize %}
+{% load static %}
=20
 {% block title %} Import Builds from eventlogs - Toaster {% endblock %}
=20
@@ -68,7 +69,7 @@
                     </h4>
                     {% if files %}
                     <div class=3D"table-responsive">
-                        <table class=3D"table col-md-6 table-bordered ta=
ble-hover">
+                        <table class=3D"table col-md-6 table-bordered ta=
ble-hover" id=3D"eventlog-table" style=3D"border-collapse: collapse;">
                             <thead>
                             <tr class=3D"row">
                                 <th scope=3D"col">Name</th>
@@ -112,6 +113,8 @@
     </div>
 </div>
=20
+<link rel=3D"stylesheet" href=3D"{% static 'css/jquery.dataTables-1.13.8=
.min.css' %}" type=3D'text/css'/>
+<script src=3D"{% static 'js/jquery.dataTables-1.13.8.min.js' %}"> </scr=
ipt>
 <script>
=20
 function _ajax_update(file, all, dir){
@@ -193,6 +196,10 @@ $( "#form_file").on( "submit", function( event ) {
         }, 10000)
 });
=20
+$(document).ready( function () {
+    $('#eventlog-table').DataTable({order: [[0, 'desc']], "pageLength": =
50});
+});
+
 </script>
=20
 {% endblock %}
--=20
2.34.1


