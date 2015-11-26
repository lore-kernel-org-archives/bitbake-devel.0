Return-Path: <atimof@mera.ru>
X-Greylist: delayed 1053 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 26 Nov 2015 13:02:57 UTC
Received: from mail.mera.ru (mail.mera.ru [195.98.57.161])
	by mail.openembedded.org (Postfix) with ESMTP id 378F56012A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 13:02:57 +0000 (UTC)
Received: from [192.168.50.122] (helo=cmail.merann.ru)
	by mail.mera.ru with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.71 (FreeBSD)) (envelope-from <atimof@mera.ru>)
	id 1a1vtS-0003p0-C4 for bitbake-devel@lists.openembedded.org;
	Thu, 26 Nov 2015 15:43:22 +0300
Received: from mbx03.merann.ru ([192.168.49.73]) by cmail.merann.ru ([::1])
	with mapi id 14.03.0266.001; Thu, 26 Nov 2015 15:45:20 +0300
From: "Timofeev, Andrey" <atimof@mera.ru>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: bitbake functions
Thread-Index: AdEoRgJ92tEfr2GhQ6OLF7ZVJ/glQA==
Date: Thu, 26 Nov 2015 12:45:20 +0000
Message-ID: <41E0F44D2CEBB148A7200081BAACCFCF97676766@mbx03.merann.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.220.24]
x-inside-org: True
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 02 Dec 2015 10:50:19 +0000
Cc: "Fevralskikh, Sergey" <sfevral@mera.ru>
Subject: bitbake functions
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
X-List-Received-Date: Thu, 26 Nov 2015 13:03:03 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_41E0F44D2CEBB148A7200081BAACCFCF97676766mbx03merannru_"

--_000_41E0F44D2CEBB148A7200081BAACCFCF97676766mbx03merannru_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello, guys,

We are using bitbake for our project, but we have faced with an issue.

We have a large amount of files and modules and we have a problem with larg=
e amount of bb files and we would like to reduce it.

I try to explain our issue:

Imagine that you have more than 10 target load modules that include more th=
an 100 code modules.
And this target load modules have the same code modules.

I try to show it in example:


1)      We have 2 .bb files (tests.bb and product.bb)

2)      They include the same dependencies:
DEPENDS +=3D a
DEPENDS +=3D b
DEPENDS +=3D c

But for product we want that a,b,c use TEST flag for building when we are b=
uilding tests.bb and TARGET when building product.bb

So, we want that a,b,c to be able to inherit FLAGS from target bitbake (pro=
duce or tests).
I mean we want that all bitbakes which are participants in building know wh=
at is main bitbake.

Now, we are using *.inc files to decide this issue but it requires many bit=
bake files.

If you do not understand what I mean, please send me letter. I will try to =
explain in details.

Thank you!

Best regards,
Andrey Timofeev




--_000_41E0F44D2CEBB148A7200081BAACCFCF97676766mbx03merannru_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:2.0cm 42.5pt 2.0cm 3.0cm;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1180117514;
	mso-list-type:hybrid;
	mso-list-template-ids:-35885456 68747281 68747289 68747291 68747279 687472=
89 68747291 68747279 68747289 68747291;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"RU" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello, guys,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We are using bitbake for our pr=
oject, but we have faced with an issue.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We have a large amount of files=
 and modules and we have a problem with large amount of bb files and we wou=
ld like to reduce it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I try to explain our issue:<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Imagine that you have more than=
 10 target load modules that include more than 100 code modules.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">And this target load modules ha=
ve the same code modules.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I try to show it in example:<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:=
Ignore">1)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">We have 2 .bb files (te=
sts.bb and product.bb)<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:=
Ignore">2)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">They include the same d=
ependencies:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt"><span lang=3D"EN-US">DE=
PENDS &#43;=3D a<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt"><span lang=3D"EN-US">DE=
PENDS &#43;=3D b<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt"><span lang=3D"EN-US">DE=
PENDS &#43;=3D c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">But for product we want that a,=
b,c use TEST flag for building when we are building tests.bb and TARGET whe=
n building product.bb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">So, we want that a,b,c to be ab=
le to inherit FLAGS from target bitbake (produce or tests).<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I mean we want that all bitbake=
s which are participants in building know what is main bitbake.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Now, we are using *.inc files t=
o decide this issue but it requires many bitbake files.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">If you do not understand what I=
 mean, please send me letter. I will try to explain in details.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thank you!<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:R=
U">Best regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:R=
U">Andrey Timofeev<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt"><span lang=3D"EN-US"><o=
:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_41E0F44D2CEBB148A7200081BAACCFCF97676766mbx03merannru_--
