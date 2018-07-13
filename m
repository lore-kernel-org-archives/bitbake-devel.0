Return-Path: <developer_agl@xtev.cn>
X-Greylist: delayed 56184 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 13 Jul 2018 01:45:43 UTC
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	by mail.openembedded.org (Postfix) with ESMTP id 18D98787BE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jul 2018 01:45:43 +0000 (UTC)
X-QQ-mid: bizesmtp5t1531446340tacj7chjb
Received: from albertPC (unknown [106.39.114.134])
	by esmtp4.qq.com (ESMTP) with 
	id ; Fri, 13 Jul 2018 09:45:39 +0800 (CST)
X-QQ-SSF: 00400000002000505330B00A0000000
X-QQ-FEAT: VDkIMK7a1QcjFYhULRN/m9sIu9DKzBQRty1vRIvGKxYEkXxeZ6rwo9uZH+o/4
	fhwCXpQzp5o2XA9Z7U6XYXdK84wHbutooaybTcTGG3jpCweSKOZG5Do6R2Vqa/eYKyFEUeT
	1THv9edEsIj3s/yEjULtLPh5DSUyXDRkWmbz2cF40ZkWw6/uKamO/gDQnHO0vfUXY4WNuC0
	qzUWE20TUPMGfwcxwBYrynOf+KuiPTF23OPE9DW4jN23clwhPmtcDR4FqoIeHMBieAHUyxD
	LZ+WZVf2tgmvyT6jQlmdYLUHJjPepSm7SZNTPJoYyWnNmGIzPsVu9TPF0m47AJhnOho3dNL
	rUtGe1K
X-QQ-GoodBg: 2
From: <developer_agl@xtev.cn>
To: "'Paul Eggleton'" <paul.eggleton@linux.intel.com>
References: <008601d419c8$61a20a30$24e61e90$@xtev.cn>
	<009001d419c9$35c39cc0$a14ad640$@xtev.cn>
	<1993940.Xc2Spn7Ep9@localhost.localdomain>
In-Reply-To: <1993940.Xc2Spn7Ep9@localhost.localdomain>
Date: Fri, 13 Jul 2018 09:45:40 +0800
Message-ID: <002001d41a4b$34b67870$9e236950$@xtev.cn>+5FEE11071B3CE115
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLp/S1Vsas8lI6q9hxxrD6LprX2tgGek55UAQNCaJ6iS4a38A==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:xtev.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Cc: bitbake-devel@lists.openembedded.org
Subject: =?UTF-8?B?562U5aSNOiDovazlj5E6IEFib3V0IGJpdGJha2UgdGFza3M=?=
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
X-List-Received-Date: Fri, 13 Jul 2018 01:45:44 -0000
X-Groupsio-MsgNum: 9394
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0021_01D41A8E.42DE7360"
Content-Language: zh-cn

------=_NextPart_000_0021_01D41A8E.42DE7360
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0022_01D41A8E.42DE7360"

------=_NextPart_001_0022_01D41A8E.42DE7360
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,=20

         So, bitbake will parse base.bbclass first and then execute the =
code line by line until parse "inherit some_guys", does it? And if I =
modify the content of the .bb recipe like this:

=20

## start=20

=20

require xxxxx.inc

=20

DESCRIPTION =3D "xxx"

=20

PACKAGES =3D "xxx"

=20

inherit others-1 others-2

=20

PACKAGES +=3D "yyy"

=20

inherit others-3 others-4

=20

## end

=20

So, I think the flow is=20

=20



=20

=20

=20

And, am I right?

=20

Thanks.

=20

=20

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Paul Eggleton =
<paul.eggleton@linux.intel.com>=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=B47=E6=9C=8812=E6=97=A5 =
18:51
=E6=94=B6=E4=BB=B6=E4=BA=BA: developer_agl@xtev.cn
=E6=8A=84=E9=80=81: bitbake-devel@lists.openembedded.org
=E4=B8=BB=E9=A2=98: Re: [bitbake-devel] =E8=BD=AC=E5=8F=91: About =
bitbake tasks

=20

On Thursday, 12 July 2018 12:15:07 PM CEST  =
<mailto:developer_agl@xtev.cn> developer_agl@xtev.cn wrote:

> I=E2=80=99m new to bitbake. And I have some questions about bitbake =
tasks=20

> mechanism and inherit mechanism. If a xxx.bb recipe content like this =
:

>=20

> ##start

>=20

> DESCRIPTION =3D =E2=80=9Dxxxxxxxxx=E2=80=9D

>=20

> XXX_XXXX =3D =E2=80=9C${XXXXXXXX}=E2=80=9D

>=20

> inherit some_guys

>=20

> ##end

>=20

> And Bitbake User Manual said that =E2=80=98The minimally required =
class for=20

> BitBake is the classes/base.bbclass file. The base class is implicitly =


> inherited by every recipe.=E2=80=99 So which .bbclass should be parsed =
first,=20

> some_guys.bbclass or base.bbclass? I=E2=80=99m really confused about =
that.

=20

Effectively, base.bbclass will be parsed first, then the lines in the =
recipe up to inherit some_guys, then some_guys.bbclass, and then the =
lines in the recipe that follow (in this case just a comment).

=20

Cheers,

Paul

=20

--=20

=20

Paul Eggleton

Intel Open Source Technology Centre

=20

=20


------=_NextPart_001_0022_01D41A8E.42DE7360
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta =
name=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><!--[if =
!mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:=E5=AE=8B=E4=BD=93;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:=E7=AD=89=E7=BA=BF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=E7=AD=89=E7=BA=BF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=E5=AE=8B=E4=BD=93";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=E7=AD=89=E7=BA=BF;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"=E7=BA=AF=E6=96=87=E6=9C=AC =E5=AD=97=E7=AC=A6";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
span.a
	{mso-style-name:"=E7=BA=AF=E6=96=87=E6=9C=AC =E5=AD=97=E7=AC=A6";
	mso-style-priority:99;
	mso-style-link:=E7=BA=AF=E6=96=87=E6=9C=AC;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:=E7=AD=89=E7=BA=BF;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN =
link=3D"#0563C1" vlink=3D"#954F72" =
style=3D'text-justify-trim:punctuation'><div class=3DWordSection1><p =
class=3DMsoPlainText><span lang=3DEN-US>Hi Paul, =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 So, =
bitbake will parse base.bbclass first and then execute the code line by =
line until parse &quot;inherit some_guys&quot;, does it? And if I modify =
the content of the .bb recipe like this:<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>## start =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>require xxxxx.inc<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>DESCRIPTION =3D =
&quot;xxx&quot;<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>PACKAGES =3D &quot;xxx&quot;<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>inherit others-1 =
others-2<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>PACKAGES +=3D &quot;yyy&quot;<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>inherit others-3 =
others-4<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>## end<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>So, I think the flow is <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal align=3Dleft style=3D'text-align:left'><span =
lang=3DEN-US =
style=3D'font-size:12.0pt;font-family:=E5=AE=8B=E4=BD=93'><img =
width=3D684 height=3D490 style=3D'width:7.125in;height:5.1041in' =
id=3D"=E5=9B=BE=E7=89=87_x0020_1" =
src=3D"cid:image002.jpg@01D41A8E.423A4420"></span><span lang=3DEN-US =
style=3D'font-size:12.0pt;font-family:=E5=AE=8B=E4=BD=93'><o:p></o:p></sp=
an></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>And, am I right?<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Thanks.<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>-----</span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=
=B6</span><span lang=3DEN-US>-----<br></span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E5=8F=91=E4=BB=B6=E4=BA=BA</spa=
n><span lang=3DEN-US>: Paul Eggleton =
&lt;paul.eggleton@linux.intel.com&gt; <br></span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=
=B4</span><span lang=3DEN-US>: 2018</span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E5=B9=B4</span><span =
lang=3DEN-US>7</span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E6=9C=88</span><span =
lang=3DEN-US>12</span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E6=97=A5</span><span =
lang=3DEN-US> 18:51<br></span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E6=94=B6=E4=BB=B6=E4=BA=BA</spa=
n><span lang=3DEN-US>: developer_agl@xtev.cn<br></span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E6=8A=84=E9=80=81</span><span =
lang=3DEN-US>: bitbake-devel@lists.openembedded.org<br></span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E4=B8=BB=E9=A2=98</span><span =
lang=3DEN-US>: Re: [bitbake-devel] </span><span =
style=3D'font-family:=E7=AD=89=E7=BA=BF'>=E8=BD=AC=E5=8F=91</span><span =
lang=3DEN-US>: About bitbake tasks</span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>On Thursday, 12 July 2018 =
12:15:07 PM CEST <a href=3D"mailto:developer_agl@xtev.cn"><span =
style=3D'color:windowtext;text-decoration:none'>developer_agl@xtev.cn</sp=
an></a> wrote:<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; I</span><span lang=3DEN-US =
style=3D'font-family:"Courier New"'>=E2=80=99</span><span lang=3DEN-US>m =
new to bitbake. And I have some questions about bitbake tasks =
<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>&gt; =
mechanism and inherit mechanism. If a xxx.bb recipe content like this =
:<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>&gt; =
<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>&gt; =
##start<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; DESCRIPTION =3D </span><span lang=3DEN-US =
style=3D'font-family:"Courier New"'>=E2=80=9D</span><span =
lang=3DEN-US>xxxxxxxxx</span><span lang=3DEN-US =
style=3D'font-family:"Courier New"'>=E2=80=9D</span><span =
lang=3DEN-US><o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; XXX_XXXX =3D </span><span lang=3DEN-US =
style=3D'font-family:"Courier New"'>=E2=80=9C</span><span =
lang=3DEN-US>${XXXXXXXX}</span><span lang=3DEN-US =
style=3D'font-family:"Courier New"'>=E2=80=9D</span><span =
lang=3DEN-US><o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; inherit some_guys<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; =
##end<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt; And Bitbake User Manual said that </span><span =
lang=3DEN-US style=3D'font-family:"Courier New"'>=E2=80=98</span><span =
lang=3DEN-US>The minimally required class for <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; BitBake is the =
classes/base.bbclass file. The base class is implicitly =
<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>&gt; =
inherited by every recipe.</span><span lang=3DEN-US =
style=3D'font-family:"Courier New"'>=E2=80=99</span><span lang=3DEN-US> =
So which .bbclass should be parsed first, <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; some_guys.bbclass or =
base.bbclass? I</span><span lang=3DEN-US style=3D'font-family:"Courier =
New"'>=E2=80=99</span><span lang=3DEN-US>m really confused about =
that.<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Effectively, base.bbclass will be parsed first, then the =
lines in the recipe up to inherit some_guys, then some_guys.bbclass, and =
then the lines in the recipe that follow (in this case just a =
comment).<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Cheers,<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Paul<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>-- <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Paul Eggleton<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Intel Open Source Technology =
Centre<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>

------=_NextPart_001_0022_01D41A8E.42DE7360--

------=_NextPart_000_0021_01D41A8E.42DE7360
Content-Type: image/jpeg;
	name="image002.jpg"
Content-Transfer-Encoding: base64
Content-ID: <image002.jpg@01D41A8E.423A4420>

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwkHBgoJCAkLCwoMDxkQDw4ODx4WFxIZJCAmJSMg
IyIoLTkwKCo2KyIjMkQyNjs9QEBAJjBGS0U+Sjk/QD3/2wBDAQsLCw8NDx0QEB09KSMpPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT3/wAARCAHqAqwDASIA
AhEBAxEB/8QAGwABAAIDAQEAAAAAAAAAAAAAAAQFAQIDBgf/xABOEAABAwIDAwcJBAcHAwMEAwAB
AAIDBBEFEiETFTEUQVFUk9HSIlJTVWFxgZGUBjKSoSM1dKOxsuE0QmRyc7PBMzZiBxYkJUPCw4Ki
8P/EABcBAQEBAQAAAAAAAAAAAAAAAAABAgP/xAAnEQEBAAICAwACAgEFAQAAAAAAAQIRElEhMUED
ImHwgRMyobHBkf/aAAwDAQACEQMRAD8A+zIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIi
ICIiAiIgIiICIiDChVOIw0s7YXNlklc0vDYoy85QbXNvepqrHf8Ac7P2N384Vnn2lrpvVnVq36d3
cm9WdWrfp3dynom50eUDerOrVv07u5N6s6tW/Tu7lPRNzo8oG9WdWrfp3dyb1Z1at+nd3KeibnR5
QN6s6tWfTu7k3qzq1Z9O7uXeWrhiidI54LWuyHLqc17W9+qkXCvjpPPaBvVnVqz6d3csb1Z1as+n
d3KwXCepjpow+UkAuDQALkkmwCTV+HmfUberOrVn07u5N6s6tWfTu7lLqKiOmgfNK7KxguSt2uDm
g2IuOdPHvR57Qt6s6tW/Tu7k3qzq1b9O7uU9FNzpfKv3qzq1b9O7uTerOrVv07u5WC5wzMniEkRz
NPA2sm50ee0TerOrVv07u5N6s6tW/Tu7lPRNzo8oNPiUM9QIMk7JHNL2iWJzcwFgbX94+anKun/7
hov2ef8AmjVilk8EZREUUREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQER
EBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQYVY7/udn7G7+cKzVNU1MNN9pGOqJ
o4mmkcAZHBoJzjpVx8s5LhUZbVVVK4OFS2tc42PlMZFrzHgQB77qx3vh3XqXtm96wcVw5wINdS2O
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
WNZ82eFN2y+saz5s8KkT1MdMwOkv5RDWgC5cTzALhvJrDKySKRj44tqQ7Lq33g2Um6vhjdsvrKs+
bPCm7ZfWNZ82eFa4dJNNT8pqs0ZeMwYSMrW8R+XSocGI1NUGSwSh+0l0jDBZkd+LjzG2q1q+f4Tl
NbTt2y+sqz5s8Kbtl9Y1nzZ4VFkxZ0tbTinki5M6bZOPFzzY8OgAjipTKmSsklEDhHDG4sMlrlzh
xtzWHSpZlPZvGm7ZfWNZ82eFN2y+saz5s8KjVOIyUtfT0oeZXuBLvJAzk/dbfgOc/BdZKuSjjbyi
SN9TKbRxjyWjp142HOU1l4/k3i6btl9Y1nzZ4U3bL6xrPmzwqPSYnKcOidJlmqZJXRNyaNcQTr7B
YXXcTOZVMikq7SuGbZiKzSBxsf6pZYksrO7ZfWNZ82eFN2y+sqz5s8K4UNVLWl8olkYwvJjYItCw
cPKI5+PHnWaCukrJDtJjFMw3fTGOxaPjqfeNEssNx23bL6yrPmzwpu2X1lWfNnhWlfVytrKanpw8
ucTJJlAvkHNrwubBZbjEBYLhzZHPcwMdYG7ePPa3tumrra7x3ptuyX1jWfNnhTdkvrGs+bPCsR4t
DLGCxsheXlgjsC4kcbWNre29l0NcGlrDFJtnAkRixNum97AfFT9j9Wm7ZfWNZ82eFN2y+saz5s8K
1OLRhoOyl2hm2OzABdm4nnta2t1q7GY2RzPdTTgQPySaN0OnDXXiOCusjeLpu2X1lWfNnhTdsvrG
s+bPCtZ8YggEvGTY/wDUykeT7NSLn3KfmLo8zNSRcX0Uu55qzVQt2y+sqz5s8Kbtl9ZVnzZ4VyZV
zULWDEpWuMriGvY2zW2F7HnudV0dikcTmCeOWPaNJZmbxtzWGtzfgrq/E3j9Z3bL6xrPmzwpu2X1
jWfNnhR2KRxyCOWKVkjmZ2sIBLtbWFjx711nrBTwNlljeLua3KLEgk26fap5P1ct2S+saz5s8Kbs
l9Y1nzZ4Vl+JxRztiDXuBkERe0DKHHmRuJxOqWQta8h7ixrwBlJAuVf2P1Y3bL6yrfmzwpu2X1jW
fNnhWX1E1XTPNAWtdms2SQeSRzkdPQpUIe2FolcHSADM4C1yp5i+KgUJlixSrppKiWZjIontMmW4
Li8HgB5oVoq2n/X9b+zwfzSKyUyMfQiIo0IiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIi
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
kkwtrpg8NEUdQ03bb71yBz8ytVlW5S3emZjZNbVEmMS08ML5cKri6QEuZE1shZY2sbH46Lq7GYI6
1tM+KpEjiAHcneWXI84CyskTc6XWXarh+0GGzySRMqmh8TXOeHNLcobxOo4LtDi1BUROlhrKd7Gk
AubILAnhdTC0EWIBCjyYdRyxujkpYXMcQXNLAQSOCfr/ACfs7skZI0OY5rmngQbgrZVs32ewueGO
J9FDs4iSxrRly342ssPwOkdUxzg1DHxhoAZO8Ns3gCL2TWPf/Bu9LRFVx4Q6OqknbiFcc+b9G+UO
Y0noBGluZax4diEVPKxuLPkkdbJJLAw5OnQWvdNTs3elqiqjBjUdKxsVTRyzhxzPlhc1pHNYB2i2
llxiN8QZTUczS0bQmZzCDz2GU3Cceqcu4tEVa2trxXOidhruTgm04mabgDTyeOq5x4zI6KZ0uGV8
OyaHWLGuL9bWbYm5TjTlFsiqj9oKRlIKiZlTCwv2dpKZ4INr8LcPbwWzvtDhcbYTLWwxiZmePaOy
5m3tfVOGXRyx7WaKMK6ldUGAVMJmBsYxIMwPu4ru17X/AHXA+4rOqu43RYXKaoip4880jGNuBmcb
C54Irqij1FbTUuUVFRDEXfdzvDb+665b5w7r1L2re9JKm4mooW+cO6/S9q3vTfOHdfpe1b3q6pyi
aihb5w7r9L2re9N84d1+l7VvemqcomooW+cO6/S9q3vTfOHdfpe1b3pq9HKJqKFvnDuv0vat703z
h3X6XtW96avRyiaihb5w7r9L2re9N84d1+l7VvemqcomooW+cO6/S9q3vTfOHdfpe1b3pq9HKJqK
FvnDuv0vat703zh3X6XtW96apyiaihb5w7r9L2re9N84d1+l7VvemqcomooW+cO6/S9q3vTfOHdf
pe1b3pqnKJqKFvnDuv0vat703zh3X6XtW96apyiaihb5w7r9L2re9N84d1+l7VvemqcomooW+cOH
Gvpe1b3qY0hwBBBB1BCmrDcrZERFEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAR
EQEREBERAREQEREBERAREQEREBERAREQEREBERBhaPiZILPY1w/8hddEQRHYfSOqBOaaEzA3EhjG
YHpvxUVn2fwyJswho4otswsk2d2XadSNFaIrMrPVZ4y/FSPs/SspXQU8tXCxzw+8dQ8OBAta9729
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
ERAREQEREBERAREQEREH/9k=

------=_NextPart_000_0021_01D41A8E.42DE7360--
