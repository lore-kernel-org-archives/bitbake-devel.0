Return-Path: <developer_agl@xtev.cn>
X-Greylist: delayed 344 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Jul 2018 10:15:11 UTC
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by mail.openembedded.org (Postfix) with ESMTP id BD02475534
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 10:15:11 +0000 (UTC)
X-QQ-mid: bizesmtp3t1531390507ti3rx46z4
Received: from albertPC (unknown [106.39.114.134])
	by esmtp4.qq.com (ESMTP) with SMTP id 0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 18:15:06 +0800 (CST)
X-QQ-SSF: 00400000000000504330B00A0000000
X-QQ-FEAT: E57Mx3KGKS+fvP4GvXHg36gmTSVZgPqoD3grWffeAzztSKOt/vQV7kZSbQjBj
	2u1MRW5zPs3vWvdx68+LhqSDKJGtromux+6DszmjZIAA2Ti5vSRrN2CjeqGgCYdzcfrZ6oc
	B6+hGDt3348D+flIMJToMgdH2vdvqkZFhlma5hZRzEu/42q5hYTxZ6mRHafgbfYIqN3pT7F
	2s4FljcGluNB/QwcB8NYnVfLmi94smRuXVDQ2O4kEPTm0Q9us4UabtAcynb7Jcyt6pmplmP
	cDRRacDk02U6jasaDLfxLpuTA1pROmq46gPzs1QmAK1fQ2cgjZPZ5sveM=
X-QQ-GoodBg: 2
From: <developer_agl@xtev.cn>
To: <bitbake-devel@lists.openembedded.org>
References: <008601d419c8$61a20a30$24e61e90$@xtev.cn>
In-Reply-To: <008601d419c8$61a20a30$24e61e90$@xtev.cn>
Date: Thu, 12 Jul 2018 18:15:07 +0800
Message-ID: <009001d419c9$35c39cc0$a14ad640$@xtev.cn>+CC3FAEBDBB834EF7
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLp/S1Vsas8lI6q9hxxrD6LprX2tqJfl8ug
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:xtev.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Subject: =?UTF-8?B?6L2s5Y+ROiBBYm91dCBiaXRiYWtlIHRhc2tz?=
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
X-List-Received-Date: Thu, 12 Jul 2018 10:15:12 -0000
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0091_01D41A0C.43E9C2F0"
Content-Language: zh-cn

------=_NextPart_000_0091_01D41A0C.43E9C2F0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

Sorry, my fault, it=A1=AFs=20

=20

inherit some_guys

=20

=20

=20

=20

=20

=20

Thanks.

=20

=B7=A2=BC=FE=C8=CB: developer_agl@xtev.cn <developer_agl@xtev.cn>=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2018=C4=EA7=D4=C212=C8=D5 18:09
=CA=D5=BC=FE=C8=CB: bitbake-devel@lists.openembedded.org
=D6=F7=CC=E2: About bitbake tasks

=20

Hi,

=20

I=A1=AFm new to bitbake. And I have some questions about bitbake tasks =
mechanism
and inherit mechanism. If a xxx.bb recipe content like this :

=20

##start

DESCRIPTION =3D =A1=B1xxxxxxxxx=A1=B1

=20

XXX_XXXX =3D =A1=B0${XXXXXXXX}=A1=B1

=20

require some_guys=20

##end

=20

And Bitbake User Manual said that =A1=AEThe minimally required class for =
BitBake
is the classes/base.bbclass file. The base class is implicitly inherited =
by
every recipe.=A1=AF So which .bbclass should be parsed first, =
some_guys.bbclass
or base.bbclass? I=A1=AFm really confused about that.

=20

=20

=20

=20

=20

=20

Thanks.

=20


------=_NextPart_000_0091_01D41A0C.43E9C2F0
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312"><meta =
name=3DGenerator content=3D"Microsoft Word 15 (filtered =
medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
class=3DMsoNormal><span lang=3DEN-US>Hi,<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>Sorry, my fault, it=A1=AFs =
<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>inherit some_guys<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>Thanks.<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><div><div =
style=3D'border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm'><p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left'><b><span =
style=3D'font-size:11.0pt'>=B7=A2=BC=FE=C8=CB<span =
lang=3DEN-US>:</span></span></b><span lang=3DEN-US =
style=3D'font-size:11.0pt'> developer_agl@xtev.cn =
&lt;developer_agl@xtev.cn&gt; <br></span><b><span =
style=3D'font-size:11.0pt'>=B7=A2=CB=CD=CA=B1=BC=E4<span =
lang=3DEN-US>:</span></span></b><span lang=3DEN-US =
style=3D'font-size:11.0pt'> 2018</span><span =
style=3D'font-size:11.0pt'>=C4=EA<span lang=3DEN-US>7</span>=D4=C2<span =
lang=3DEN-US>12</span>=C8=D5<span lang=3DEN-US> =
18:09<br></span><b>=CA=D5=BC=FE=C8=CB<span =
lang=3DEN-US>:</span></b><span lang=3DEN-US> =
bitbake-devel@lists.openembedded.org<br></span><b>=D6=F7=CC=E2<span =
lang=3DEN-US>:</span></b><span lang=3DEN-US> About bitbake =
tasks<o:p></o:p></span></span></p></div></div><p class=3DMsoNormal =
align=3Dleft style=3D'text-align:left'><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Hi,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>I</span>=A1=AF<span lang=3DEN-US>m new to bitbake. And I =
have some questions about bitbake tasks mechanism and inherit mechanism. =
If a xxx.bb recipe content like this :<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>##start<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>DESCRIPTION =3D </span>=A1=B1<span =
lang=3DEN-US>xxxxxxxxx</span>=A1=B1<span =
lang=3DEN-US><o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>XXX_XXXX =3D </span>=A1=B0<span =
lang=3DEN-US>${XXXXXXXX}</span>=A1=B1<span =
lang=3DEN-US><o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>require some_guys <o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>##end<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>And Bitbake User Manual said that =
</span>=A1=AE<span lang=3DEN-US style=3D'color:red'>The minimally =
required class for BitBake is the classes/base.bbclass file. The base =
class is implicitly inherited by every recipe.</span>=A1=AF<span =
lang=3DEN-US> So which .bbclass should be parsed first, =
some_guys.bbclass or base.bbclass? I</span>=A1=AF<span lang=3DEN-US>m =
really confused about that.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>Thanks.<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>

------=_NextPart_000_0091_01D41A0C.43E9C2F0--
