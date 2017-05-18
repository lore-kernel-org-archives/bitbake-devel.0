Return-Path: <prvs=0311042b42=alan.levy@plextek.com>
X-Greylist: delayed 360 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 18 May 2017 14:28:59 UTC
Received: from mailgate.plextek.co.uk (mailgate.plextek.co.uk [62.254.222.163])
	by mail.openembedded.org (Postfix) with ESMTP id 24ACD77CCC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 May 2017 14:28:59 +0000 (UTC)
Received: from plextek-exch1.plextek.lan ([10.10.0.152]:16488)
	by mailgate.plextek.co.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.82_1-5b7a7c0-XX) (envelope-from <alan.levy@plextek.com>)
	id 1dBMKQ-0008A0-04 for bitbake-devel@lists.openembedded.org;
	Thu, 18 May 2017 15:22:58 +0100
Received: from PLEXTEK-EXCH1.plextek.lan (10.10.0.152) by
	PLEXTEK-EXCH1.plextek.lan (10.10.0.152) with Microsoft SMTP Server
	(TLS) id 15.0.847.32; Thu, 18 May 2017 15:22:57 +0100
Received: from PLEXTEK-EXCH1.plextek.lan ([fe80::f852:2da9:3543:6c2f]) by
	PLEXTEK-EXCH1.plextek.lan ([fe80::f852:2da9:3543:6c2f%18]) with mapi id
	15.00.0847.030; Thu, 18 May 2017 15:22:57 +0100
From: Alan Levy <alan.levy@plextek.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Problem using Subversion in Pyro
Thread-Index: AdLP4VEXB/+GGF2XTGCDVOUoQEsY6Q==
Date: Thu, 18 May 2017 14:22:56 +0000
Message-ID: <76e10e401a174bdca9f6a65acafbff5e@PLEXTEK-EXCH1.plextek.lan>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.12.154]
MIME-Version: 1.0
Subject: Problem using Subversion in Pyro
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 18 May 2017 14:29:01 -0000
X-Groupsio-MsgNum: 8626
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_005_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_";
	type="multipart/alternative"

--_005_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_
Content-Type: multipart/alternative;
	boundary="_000_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_"

--_000_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If I run the following script under Pyro:


DESCRIPTION =3D "Recipe to test SVN"

PACKAGE_ARCH =3D "${MACHINE_ARCH}"

LICENSE =3D "CLOSED"

PV =3D "${SRCPV}"

SRCREV =3D "${AUTOREV}"

SRC_URI =3D "svn://server/path;module=3Dmy_module"

I get the following error message (names have been changed...)


ERROR: ExpansionError during parsing <path>/my-recipe.bb                   =
    | ETA:  0:00:01

Traceback (most recent call last):

bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression =
was ${@bb.fetch2.get_srcrev(d)}<mailto:$%7b@bb.fetch2.get_srcrev(d)%7d> whi=
ch triggered exception FetchError: Fetcher failure: Fetch command export DB=
US_SESSION_BUS_ADDRESS=3D"unix:abstract=3D/tmp/dbus-ykmscGFFM1"; export SSH=
_AUTH_SOCK=3D"/run/user/1000/keyring/ssh"; export PATH=3D"/home/user/projec=
t/yocto/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/home/user/projec=
t/yocto/poky/scripts:/home/user/project/yocto/build/tmp/work/picozed_zynq7-=
poky-linux-gnueabi/my-recipe/fetcheravoidrecurse-r0/recipe-sysroot-native/u=
sr/bin/arm-poky-linux-gnueabi:/home/user/project/yocto/build/tmp/work/picoz=
ed_zynq7-poky-linux-gnueabi/my-recipe/fetcheravoidrecurse-r0/recipe-sysroot=
/usr/bin/crossscripts:/home/user/project/yocto/build/tmp/work/picozed_zynq7=
-poky-linux-gnueabi/my-recipe/fetcheravoidrecurse-r0/recipe-sysroot-native/=
usr/sbin:/home/user/project/yocto/build/tmp/work/picozed_zynq7-poky-linux-g=
nueabi/my-recipe/fetcheravoidrecurse-r0/recipe-sysroot-native/usr/bin:/home=
/user/project/yocto/build/tmp/work/picozed_zynq7-poky-linux-gnueabi/my-reci=
pe/fetcheravoidrecurse-r0/recipe-sysroot-native/sbin:/home/user/project/yoc=
to/build/tmp/work/picozed_zynq7-poky-linux-gnueabi/my-recipe/fetcheravoidre=
curse-r0/recipe-sysroot-native/bin:/home/user/project/yocto/poky/bitbake/bi=
n:/home/user/project/yocto/build/tmp/hosttools"; export HOME=3D"/home/user"=
; LANG=3DC LC_ALL=3DC /usr/bin/env svn --non-interactive --trust-server-cer=
t log --limit 1 --no-auth-cache ! http://server/path/my_module/ failed with=
 exit code 127, output:

/usr/bin/env: 'svn': No such file or directory

If I comment out the line containing SRCPV, all is well. Digging into the c=
ode it appears that svn is missing from ${HOSTTOOLS} in bitbake.conf.
ALAN LEVY
Lead Consultant, Embedded Systems

Tel > +44 (0) 1799 533200
Email > alan.levy@plextek.com

[http://www.plextek.com/wp-content/uploads/Footer-AlanLevy.jpg]<http://www.=
plextek.com/technicalpaper/an-introduction-to-yocto/>
[http://www.plextek.com/wp-content/uploads/2016/04/Plextek-LOGO-for-email.j=
pg]<http://www.plextek.com/>

www.plextek.com<http://www.plextek.com/>
The Plextek Building, London Road, Great Chesterford, Saffron Walden, CB10 =
1NY, UK

Plextek is the trading name of Plextek Services Ltd. Registered in England =
and Wales, no. 09826669



--_000_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Microsoft Sans Serif";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">If I run the following script under Pyro:<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">DESCRIPTION =3D &quot;Recipe to test SVN&quot;<o:=
p></o:p></p>
<p class=3D"MsoPlainText">PACKAGE_ARCH =3D &quot;${MACHINE_ARCH}&quot;<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">LICENSE =3D &quot;CLOSED&quot;<o:p></o:p></p>
<p class=3D"MsoPlainText">PV =3D &quot;${SRCPV}&quot;<o:p></o:p></p>
<p class=3D"MsoPlainText">SRCREV =3D &quot;${AUTOREV}&quot;<o:p></o:p></p>
<p class=3D"MsoPlainText">SRC_URI =3D &quot;svn://server/path;module=3Dmy_m=
odule&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I get the following error message (names have been c=
hanged&#8230;)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">ERROR: ExpansionError during parsing &lt;path&gt;=
/my-recipe.bb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | ET=
A:&nbsp; 0:00:01<o:p></o:p></p>
<p class=3D"MsoPlainText">Traceback (most recent call last):<o:p></o:p></p>
<p class=3D"MsoPlainText">bb.data_smart.ExpansionError: Failure expanding v=
ariable SRCPV, expression was
<a href=3D"mailto:$%7b@bb.fetch2.get_srcrev(d)%7d">${@bb.fetch2.get_srcrev(=
d)}</a> which triggered exception FetchError: Fetcher failure: Fetch comman=
d export DBUS_SESSION_BUS_ADDRESS=3D&quot;unix:abstract=3D/tmp/dbus-ykmscGF=
FM1&quot;; export SSH_AUTH_SOCK=3D&quot;/run/user/1000/keyring/ssh&quot;;
 export PATH=3D&quot;/home/user/project/yocto/build/tmp/sysroots-uninative/=
x86_64-linux/usr/bin:/home/user/project/yocto/poky/scripts:/home/user/proje=
ct/yocto/build/tmp/work/picozed_zynq7-poky-linux-gnueabi/my-recipe/fetchera=
voidrecurse-r0/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi:/home/u=
ser/project/yocto/build/tmp/work/picozed_zynq7-poky-linux-gnueabi/my-recipe=
/fetcheravoidrecurse-r0/recipe-sysroot/usr/bin/crossscripts:/home/user/proj=
ect/yocto/build/tmp/work/picozed_zynq7-poky-linux-gnueabi/my-recipe/fetcher=
avoidrecurse-r0/recipe-sysroot-native/usr/sbin:/home/user/project/yocto/bui=
ld/tmp/work/picozed_zynq7-poky-linux-gnueabi/my-recipe/fetcheravoidrecurse-=
r0/recipe-sysroot-native/usr/bin:/home/user/project/yocto/build/tmp/work/pi=
cozed_zynq7-poky-linux-gnueabi/my-recipe/fetcheravoidrecurse-r0/recipe-sysr=
oot-native/sbin:/home/user/project/yocto/build/tmp/work/picozed_zynq7-poky-=
linux-gnueabi/my-recipe/fetcheravoidrecurse-r0/recipe-sysroot-native/bin:/h=
ome/user/project/yocto/poky/bitbake/bin:/home/user/project/yocto/build/tmp/=
hosttools&quot;;
 export HOME=3D&quot;/home/user&quot;; LANG=3DC LC_ALL=3DC /usr/bin/env svn=
 --non-interactive --trust-server-cert log --limit 1 --no-auth-cache !
<a href=3D"http://server/path/my_module/">http://server/path/my_module/</a>=
 failed with exit code 127, output:<o:p></o:p></p>
<p class=3D"MsoPlainText">/usr/bin/env: 'svn': No such file or directory<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If I comment out the line containing SRCPV, all is w=
ell. Digging into the code it appears that svn is missing from ${HOSTTOOLS}=
 in bitbake.conf.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:10.0pt;font-family:&quot;Microsoft Sans S=
erif&quot;,&quot;sans-serif&quot;;color:#4E4E4E;mso-fareast-language:EN-GB"=
>ALAN LEVY</span><span style=3D"font-size:12.0pt;font-family:&quot;Times Ne=
w Roman&quot;,&quot;serif&quot;;mso-fareast-language:EN-GB"><br>
</span><span style=3D"font-size:10.0pt;font-family:&quot;Microsoft Sans Ser=
if&quot;,&quot;sans-serif&quot;;color:#4E4E4E;mso-fareast-language:EN-GB">L=
ead Consultant, Embedded Systems<br>
<br>
</span><span style=3D"font-size:10.0pt;font-family:&quot;Microsoft Sans Ser=
if&quot;,&quot;sans-serif&quot;;color:#E36C0A;mso-fareast-language:EN-GB">T=
el &gt;</span><span style=3D"font-size:10.0pt;font-family:&quot;Microsoft S=
ans Serif&quot;,&quot;sans-serif&quot;;color:#4E4E4E;mso-fareast-language:E=
N-GB">
 &#43;44 (0) 1799 533200<br>
</span><span style=3D"font-size:10.0pt;font-family:&quot;Microsoft Sans Ser=
if&quot;,&quot;sans-serif&quot;;color:#E36C0A;mso-fareast-language:EN-GB">E=
mail &gt;
</span><span style=3D"font-size:10.0pt;font-family:&quot;Microsoft Sans Ser=
if&quot;,&quot;sans-serif&quot;;color:#4E4E4E;mso-fareast-language:EN-GB">a=
lan.levy@plextek.com<br>
<br>
</span><a href=3D"http://www.plextek.com/technicalpaper/an-introduction-to-=
yocto/"><span style=3D"font-size:10.0pt;font-family:&quot;Microsoft Sans Se=
rif&quot;,&quot;sans-serif&quot;;color:blue;mso-fareast-language:EN-GB;text=
-decoration:none"><img border=3D"0" width=3D"700" height=3D"92" id=3D"_x000=
0_i1026" src=3D"cid:image001.jpg@01D2CFEA.A0219CE0" alt=3D"http://www.plext=
ek.com/wp-content/uploads/Footer-AlanLevy.jpg"></span></a><span style=3D"fo=
nt-size:12.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;ms=
o-fareast-language:EN-GB"><o:p></o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellpadding=3D"0" width=3D"700=
" style=3D"width:525.0pt">
<tbody>
<tr style=3D"height:45.0pt">
<td width=3D"183" style=3D"width:137.25pt;padding:0cm 0cm 0cm 0cm;height:45=
.0pt">
<p class=3D"MsoNormal" style=3D"line-height:12.75pt"><a href=3D"http://www.=
plextek.com/"><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,=
&quot;sans-serif&quot;;color:blue;mso-fareast-language:EN-GB;text-decoratio=
n:none"><img border=3D"0" width=3D"180" height=3D"56" id=3D"_x0000_i1025" s=
rc=3D"cid:image002.jpg@01D2CFEA.A0219CE0" alt=3D"http://www.plextek.com/wp-=
content/uploads/2016/04/Plextek-LOGO-for-email.jpg"></span></a><span style=
=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;co=
lor:#636564;mso-fareast-language:EN-GB"><o:p></o:p></span></p>
</td>
<td style=3D"padding:0cm 0cm 0cm 7.5pt;height:45.0pt">
<p class=3D"MsoNormal" style=3D"line-height:12.75pt"><span style=3D"font-si=
ze:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#636564=
;mso-fareast-language:EN-GB"><a href=3D"http://www.plextek.com/"><span styl=
e=3D"color:#169AC0;text-decoration:none">www.plextek.com</span></a><br>
The Plextek Building, London Road, Great Chesterford, Saffron Walden, CB10 =
1NY, UK<o:p></o:p></span></p>
</td>
</tr>
<tr>
<td colspan=3D"2" style=3D"padding:0cm 0cm 0cm 0cm">
<p class=3D"MsoNormal" style=3D"line-height:12.75pt"><span style=3D"font-si=
ze:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#636564=
;mso-fareast-language:EN-GB">Plextek is the trading name of Plextek Service=
s Ltd. Registered in England and Wales, no. 09826669
</span><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;s=
ans-serif&quot;;color:#636564;mso-fareast-language:EN-GB"><o:p></o:p></span=
></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_--

--_005_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_
Content-Type: image/jpeg; name="image001.jpg"
Content-Description: image001.jpg
Content-Disposition: inline; filename="image001.jpg"; size=28068;
	creation-date="Thu, 18 May 2017 14:22:56 GMT";
	modification-date="Thu, 18 May 2017 14:22:56 GMT"
Content-ID: <image001.jpg@01D2CFEA.A0219CE0>
Content-Transfer-Encoding: base64

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
zZmui54zaBLA6mJD3Vhd7ZjVgJJPKGNUsbmtQqRujssTKFTSjVnFjUo0xpQE3YKvhkbWxV0b0Lqr
eIXG5bEo8/SKUyuXyFOwTp7jEiliJdIJY9rVj4ateYZGDzFC89SpDlnLAUcAvJgBgfKuqq/XQ6dw
BXG0x8Ps7319+2QSlwwRIfvFAtKmntJ4FmDk3t4HFdgz2cwr1ftGfU+q9AfQBB5rrVVdiyNzkkyB
ZDxl7G3ifIp9+V4t9XPhTahStpaF7p1rsUmJvDSeiRpwLkallNSOXdEJxJUjGYIYFos8Mj7DIpfK
mwhwLep0pZlklOUvr84olB7A0J2Fry2szi5HIo8WFsTEhNA3J0gFJmBKVITlIxnCAlXAHAHAHAHA
HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA
HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA
HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA
HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA
HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAP5Xrh2n2QZ7btJoa
rvstva2qxpu2tqBJLHUlKiQIZM5pUaRMSBRjBSctOUWAAcYxgIQYxj+nM+CnccxjWKxq4Ce7uK6/
F1s//nq0vODv1HF5O5C2Azwp9EH4utn/APPVpecHfqOLydyDAZ4U+iD8XWz/APnq0vODv1HF5O5B
gM8KfRB+LrZ//PVpecHfqOLydyDAZ4U+iD8XWz/+erS84O/UcXk7kGAzwp9EH4utn/8APVpecHfq
OLydyDAZ4U+iD8XWz/8Anq0vODv1HF5O5BgM8KfRB+LrZ/8Az1aXnB36ji8ncgwGeFPog/F1s/8A
56tLzg79RxeTuQYDPCn0Qfi62f8A89Wl5wd+o4vJ3IMBnhT6IPxdbP8A+erS84O/UcXk7kGAzwp9
EH4utn/89Wl5wd+o4vJ3IMBnhT6IPxdbP/56tLzg79RxeTuQYDPCn0Qfi62f/wA9Wl5wd+o4vJ3I
MBnhT6IPxdbP/wCerS84O/UcXk7kGAzwp9EH4utn/wDPVpecHfqOLydyDAZ4U+iD8XWz/wDnq0vO
Dv1HF5O5BgM8KfRB+LrZ/wDz1aXnB36ji8ncgwGeFPog/F1s/wD56tLzg79RxeTuQYDPCn0Qfi62
f/z1aXnB36ji8ncgwGeFPohxm7c7P4KNzi+rTxnuDzjOJg7+nGcBznGcf8T/AEz6fR//ABzNKsY6
agNcxHNV8O+i+5UV6IqL8rx86mV5GiaUiwv4cWDLx3McnY5rmwnK1UVL3aioip8ygvxs7dfMfcPn
l86vnt/ESpnpiS3eHYfz9dYG7f8AurTv3GY4x+Nnbr5j7h88vnV8YiVM9MSW7w7B1gbt/wC6tO/c
ZjjH42duvmPuHzy+dXxiJUz0xJbvDsHWBu3/ALq079xmOMfjZ26+Y+4fPL51fGIlTPTElu8OwdYG
7f8AurTv3GY4x+Nnbr5j7h88vnV8YiVM9MSW7w7B1gbt/wC6tO/cZjjH42duvmPuHzy+dXxiJUz0
xJbvDsHWBu3/ALq079xmOMfjZ26+Y+4fPL51fGIlTPTElu8OwdYG7f8AurTv3GY4x+Nnbr5j7h88
vnV8YiVM9MSW7w7B1gbt/wC6tO/cZjjH42duvmPuHzy+dXxiJUz0xJbvDsHWBu3/ALq079xmOMfj
Z26+Y+4fPL51fGIlTPTElu8OwdYG7f8AurTv3GY4x+Nnbr5j7h88vnV8YiVM9MSW7w7B1gbt/wC6
tO/cZjjH42duvmPuHzy+dXxiJUz0xJbvDsHWBu3/ALq079xmOMfjZ26+Y+4fPL51fGIlTPTElu8O
wdYG7f8AurTv3GY4x+Nnbr5j7h88vnV8YiVM9MSW7w7B1gbt/wC6tO/cZjjH42duvmPuHzy+dXxi
JUz0xJbvDsHWBu3/ALq079xmOMfjZ26+Y+4fPL51fGIlTPTElu8OwdYG7f8AurTv3GY4x+Nnbr5j
7h88vnV8YiVM9MSW7w7B1gbt/wC6tO/cZjjH42duvmPuHzy+dXxiJUz0xJbvDsHWBu3/ALq079xm
OMfjZ26+Y+4fPL51fGIlTPTElu8OwdYG7f8AurTv3GY4x+Nnbr5j7h88vnV8YiVM9MSW7w7B1gbt
/wC6tO/cZjjH42duvmPuHzy+dXxiJUz0xJbvDsHWBu3/ALq079xmOMqy7t7tzGOoLJeGfZy6W10b
Ye/LG9wRz1+IVo1RCI0ZKhOeBXgRRwRhxnAsZ9OM4/pzhUhUap8ORmnsq3JseyG5UVIEO+ionYqL
g+82Dcku43YaXun1Doyk7pdMz9HUhSspBjwYs/HfCiwnRmo5j2OerXNciqjkVLyoaSvitdpT88mz
f1blv8jzXuLVXvJJXZNsP1v6WpPT4uu60fFa7Sn55Nm/q3Lf5HjFqr3kkrsm2Dpak9Pi67rR8Vrt
Kfnk2b+rct/keMWqveSSuybYOlqT0+LrutHxWu0p+eTZv6ty3+R4xaq95JK7Jtg6WpPT4uu60fFa
7Sn55Nm/q3Lf5HjFqr3kkrsm2Dpak9Pi67rR8VrtKfnk2b+rct/keMWqveSSuybYOlqT0+LrutHx
Wu0p+eTZv6ty3+R4xaq95JK7Jtg6WpPT4uu60fFa7Sn55Nm/q3Lf5HjFqr3kkrsm2Dpak9Pi67rR
8VrtKfnk2b+rct/keMWqveSSuybYOlqT0+LrutHxWu0p+eTZv6ty3+R4xaq95JK7Jtg6WpPT4uu6
0fFa7Sn55Nm/q3Lf5HjFqr3kkrsm2Dpak9Pi67rR8VrtKfnk2b+rct/keMWqveSSuybYOlqT0+Lr
utHxWu0p+eTZv6ty3+R4xaq95JK7Jtg6WpPT4uu60fFa7Sn55Nm/q3Lf5HjFqr3kkrsm2Dpak9Pi
67rR8VrtKfnk2b+rct/keMWqveSSuybYOlqT0+LrutHxWu0p+eTZv6ty3+R4xaq95JK7Jtg6WpPT
4uu60fFa7Sn55Nm/q3Lf5HjFqr3kkrsm2Dpak9Pi67rR8VrtKfnk2b+rct/keMWqveSSuybYOlqT
0+LrutHxWu0p+eTZv6ty3+R4xaq95JK7Jtg6WpPT4uu60fFa7Sn55Nm/q3Lf5HjFqr3kkrsm2Dpa
k9Pi67rR8VrtKfnk2b+rct/keMWqveSSuybYOlqT0+LrutJjX3ando84S5nSrt3NlVaU7271qc+2
JWYSZ3GxaaDvAE4egXoMAAWP/mDGedpqbU2qk5WSjJebq9KTMvG5bCY+CxzVvQIrkvoqXux15U+a
J3HX60U9TUrQU9HlqTjwIzOTwXNiORyfxmIt5UW/2pfRe9FUya+JRv8AfOHsJ9TZN13N75MLnfou
jd1hcJp/Hat3qOc277R8Sjf75w9hPqbJuu4yYXO/RdG7rC4RjtW71HObd9o+JRv984ewn1Nk3XcZ
MLnfoujd1hcIx2rd6jnNu+0fEo3++cPYT6mybruMmFzv0XRu6wuEY7Vu9Rzm3faPiUb/AHzh7CfU
2Tddxkwud+i6N3WFwjHat3qOc277R8Sjf75w9hPqbJuu4yYXO/RdG7rC4RjtW71HObd9o+JRv984
ewn1Nk3XcZMLnfoujd1hcIx2rd6jnNu+0fEo3++cPYT6mybruMmFzv0XRu6wuEY7Vu9Rzm3faPiU
b/fOHsJ9TZN13GTC536Lo3dYXCMdq3eo5zbvtHxKN/vnD2E+psm67jJhc79F0busLhGO1bvUc5t3
2j4lG/3zh7CfU2Tddxkwud+i6N3WFwjHat3qOc277R8Sjf75w9hPqbJuu4yYXO/RdG7rC4RjtW71
HObd9o+JRv8AfOHsJ9TZN13GTC536Lo3dYXCMdq3eo5zbvtHxKN/vnD2E+psm67jJhc79F0busLh
GO1bvUc5t32j4lG/3zh7CfU2Tddxkwud+i6N3WFwjHat3qOc277R8Sjf75w9hPqbJuu4yYXO/RdG
7rC4RjtW71HObd9o+JRv984ewn1Nk3XcZMLnfoujd1hcIx2rd6jnNu+0fEo3++cPYT6mybruMmFz
v0XRu6wuEY7Vu9Rzm3faPiUb/fOHsJ9TZN13GTC536Lo3dYXCMdq3eo5zbvtHxKN/vnD2E+psm67
jJhc79F0busLhGO1bvUc5t32j4lG/wB84ewn1Nk3XcZMLnfoujd1hcIx2rd6jnNu+0fEo3++cPYT
6mybruMmFzv0XRu6wuEY7Vu9Rzm3faf/2Q==

--_005_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_
Content-Type: image/jpeg; name="image002.jpg"
Content-Description: image002.jpg
Content-Disposition: inline; filename="image002.jpg"; size=8152;
	creation-date="Thu, 18 May 2017 14:22:56 GMT";
	modification-date="Thu, 18 May 2017 14:22:56 GMT"
Content-ID: <image002.jpg@01D2CFEA.A0219CE0>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQICAQECAQEBAgICAgICAgICAQICAgICAgICAgL/2wBDAQEBAQEBAQEBAQECAQEBAgICAgIC
AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgL/wAARCAA4ALQDAREA
AhEBAxEB/8QAHgAAAQQCAwEAAAAAAAAAAAAAAAcICQoFBgECBAP/xAA1EAAABgIBAwMCBQIFBQAA
AAABAgMEBQYHCAAJERITFCEVIgoWIzEyJEEYJjM6QlFhcXi3/8QAHQEBAAEFAQEBAAAAAAAAAAAA
AAECAwYHCAQFCf/EADkRAAEEAQQABAUBBgMJAAAAAAIAAQMEBQYHERITISIxCBQyQVEjM0JDUnHw
FWKBJCY0U3ORobHR/9oADAMBAAIRAxEAPwC/xwiOEWGfz0HFKJISk1ExiqyZ1UUZCSZs1VUim8BO
mm5WAyhAMPiJgDsA/Hfvy5FWsTclDXOYRfh3ECLj/sy8djIUKpBHbuw1TNuWaSUAcm/LMRM7svCF
xqJhKUtrrZjGOQiZSzcYYxzmMBCkKAOfuOYxigAB+4j2Dl56N1m5enLx/wBM/wD4rDZnDu7M2Vrc
k/H7eP3f2/f/AL+y2fnlX00cIjhEcIjhEcIjhEcIjhEcIjhEcIjhEcIjhEcIjhEcIjhEcImD797O
33XnA6N2wQ0qt5yXKZOoOP4OqPGMhb1pd1bZZdkpGRddrEs3eyU8p7dQrdJI4m8iHMZI4EN22Ntp
pDG6n1GWP1Gc2PxENSzZlmEmhYBhAS7nLMBgEQ88mRNx7eploffnczO6A0MOZ0LHUzWpbeRp0K9Y
wO280lgpW8GKvXmjllsGQdI4wdzIuWEDLhlBXunWMg5anMV5C6kmTMZa0W4tBmGmPcW4nxPecv5N
m6wpOtn8hJWSNZWc8HVnRH7psgT1Z03iAHIdt7ginOjtv7mLwkGZxe1GIt6upfMg9m5evVqNSKTw
urDEbwtZmHqPYutb8Ox8EK4W3pxWpdW2NMZ34j9U43bXJlRMaGMxWIvZXITQjYIzksxjaehWPtJ1
j8S+B8eIJV+4Gmd1zDWn03OQQY722n63dW1kra9WaZ21hsVcpsxYUZ9geDj39vxzaps9daryhGaS
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

--_005_76e10e401a174bdca9f6a65acafbff5ePLEXTEKEXCH1plexteklan_--
