Return-Path: <jameel.kareem@murata.com>
X-Greylist: delayed 1963 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 10 Nov 2017 18:50:29 UTC
Received: from APC01-HK2-obe.outbound.protection.outlook.com
	(mail-hk2apc01on0128.outbound.protection.outlook.com
	[104.47.124.128])
	by mail.openembedded.org (Postfix) with ESMTP id A3F0A782A4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Nov 2017 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=murataglobal.onmicrosoft.com; s=selector1-murata-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=LIgOxdlukb3FZWIO+0dGbzql2+44bNXTKRgm6qxv1QY=;
	b=eYPjxYsNjp6UJL09/3SUUTqCzi4+3t7T95Lb9bZaWCCqMg/2CHPPoenHHqHRis+9JEXS+NaQ5eA0oJ9nNMxiU9N7wxxVLUgPPdAR8Dfw07z1lCTTgQ2f8PpW6keV07qNG5tHtcM8ue6yEVY1eMbuYVpJqEruhzk8xp+05ikpljA=
Received: from KL1PR03MB1576.apcprd03.prod.outlook.com (10.169.27.150) by
	KL1PR03MB1574.apcprd03.prod.outlook.com (10.169.27.148) with Microsoft
	SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
	15.20.239.4; Fri, 10 Nov 2017 18:17:45 +0000
Received: from KL1PR03MB1576.apcprd03.prod.outlook.com
	([fe80::98b2:a73:e47f:9472]) by KL1PR03MB1576.apcprd03.prod.outlook.com
	([fe80::98b2:a73:e47f:9472%14]) with mapi id 15.20.0239.004;
	Fri, 10 Nov 2017 18:17:45 +0000
From: Jameel Valai Kareem <jameel.kareem@murata.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Integration of FMAC(Orga) Driver into Yocto Environment -
	regarding
Thread-Index: AdNaUCgT5gUUG+dRSXSmXXnk2Tps3g==
Date: Fri, 10 Nov 2017 18:17:45 +0000
Message-ID: <KL1PR03MB1576391AC952EEB3FFCAE3939A540@KL1PR03MB1576.apcprd03.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=jameel.kareem@murata.com; 
x-originating-ip: [172.87.167.34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1PR03MB1574;
	6:YW6EahcZgx/xPiCA9hUw7PpY4iYhsxUOsNjMStmpWwHv4gZjSUH3EPv702qrZFOeiEBZn43/bSvW0PPF6Ik/Mzf2MvjlA6OhJlPSebSa3F7oDuKZWL3tb+HyZUdrq0SJTgkxLWzbMeSmtQ/06X042FOPY18eURaJTKJnuREZ10X9evTPpiBm7a2rVIjIvVMeJoidyD3fMSRbOKtsfVbnLVE/JyZVjT4Aigh5aXHJoegaJTyzH1YuV1wR8BWNYktLUwZLrxIXWPF7KdTM5XnYVpij4ked2n2S0ssrD04CwBdPWXjUusQd7u5fpDVvvFjBkY38PpcgSXKRMEq5y732IOcQvyOtrMOXIt4m2a/T/Zc=;
	5:1W16RGElIlV77SiCQpcRJ4Oy5TwRmuwC7Kg3S1bIRMdaKvscY8W0KnNO8IKhxC/GtXWI01WV/v7w5eDAIK2oAHeZ8N+hKyIkzupJsmSaLpAlen2GFZ0M4UmQjqE7G0NaTsxi5PcC/3XxIoJtP177NCN+0xArezkVjWPsN5xQ7sY=;
	24:72TZa9pbrHGr3U43WDXWo1oTLuX+mZQqlORByR/VsoH5r+5TC0rG8ag9cphxFGvq+qmni0MmGrMCunz3EWkzy5rWjmeL/Gg6UFFwVDVrNrg=;
	7:bnukDT/yEbB6eniKpwpjX10NJsO+BGpksIEHblCgMHnB/9P9UjyrzN9IRbodmt797FuMXBgv3ixeay2ATFfELeu/GviqpRLFxqoC9H18nNHX5vGMVmYn/lFF3wwuzR9OLqpuOWl37jjhYZT+FF/JuB0ga8q+OYmZE79i5RHlkVnqnHXexlzfTwYfreReLxo8zM5X1Tr3ohVwpH2jJR8nDgiK19do7ewjifxmLIid8MxnVxQPaOJ9THzVubIkEMkm
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 76571aa3-aaf1-4426-125c-08d528675781
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603199);
	SRVR:KL1PR03MB1574; 
x-ms-traffictypediagnostic: KL1PR03MB1574:
x-exchange-antispam-report-test: UriScan:(258095267146985)(21748063052155);
x-microsoft-antispam-prvs: <KL1PR03MB157485A576CA879EEA80F3319A540@KL1PR03MB1574.apcprd03.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(93006095)(93001095)(3231021)(10201501046)(3002001)(6055026)(6041248)(20161123560025)(20161123564025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);
	SRVR:KL1PR03MB1574; BCL:0; PCL:0;
	RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);
	SRVR:KL1PR03MB1574; 
x-forefront-prvs: 0487C0DB7E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(39860400002)(17834003)(189002)(199003)(50944005)(53754006)(25786009)(33656002)(5640700003)(68736007)(6436002)(99286004)(50986999)(478600001)(6506006)(316002)(101416001)(5890100001)(2501003)(3846002)(790700001)(6116002)(102836003)(7696004)(97736004)(14454004)(8936002)(54356999)(9326002)(2900100001)(6916009)(55016002)(9686003)(6306002)(54896002)(74316002)(236005)(7736002)(86362001)(66066001)(81156014)(606006)(8676002)(5660300001)(81166006)(3660700001)(189998001)(2906002)(3280700002)(5250100002)(53936002)(106356001)(2351001)(105586002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:KL1PR03MB1574;
	H:KL1PR03MB1576.apcprd03.prod.outlook.com; FPR:; SPF:None;
	PTR:InfoNoRecords; MX:1; A:1; LANG:en; 
received-spf: None (protection.outlook.com: murata.com does not designate
	permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: murata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76571aa3-aaf1-4426-125c-08d528675781
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2017 18:17:45.6518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: afff1096-7fd8-4cdd-879a-7db50a47287a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB1574
Subject: Integration of FMAC(Orga) Driver into Yocto Environment - regarding
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
X-List-Received-Date: Fri, 10 Nov 2017 18:50:30 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_KL1PR03MB1576391AC952EEB3FFCAE3939A540KL1PR03MB1576apcp_"

--_000_KL1PR03MB1576391AC952EEB3FFCAE3939A540KL1PR03MB1576apcp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
 I am  currently working on the creation of new MACHINE type for addressing=
 the Cypress Broadcom FMAC driver release<https://community.cypress.com/doc=
s/DOC-14056> ( attached for your reference).
As part of the initial steps, I am ensuring that, we have necessary recipes=
 tested, so that, it can added to the new MACHINE type along with the new l=
ayer "meta-murata-wireless"
I was able to get the wpa-supplicant and hostapd recipe into the Yocto setu=
p.

I need your help in resolving a problem related to native make when using t=
he Backport Tools.

Backport Tools:

FMAC driver uses Backport Tool (v4.12-backports) to generate the necessary =
.ko files, namely (compat.ko, brcmfmac.ko, brcmutil.ko and cfg80211.ko)

In the Readme file, 2nd step under the Section : "Build the cypress driver/=
backports modules" is to

-        (Native) compile local tools and generate .config without sourcing=
 Yocto tool chain settings.

make KLIB=3D$MY_KERNEL KLIB_BUILD=3D$MY_KERNEL defconfig-brcmfmac

Problem Description:


I don't know how to use the native make in the do_compile( ) function in ba=
ckportcypress_1.0.bb ( attached for your reference), as Yocto uses tool cha=
in settings.
              I get the following error message, when I compile backportcyp=
ress_1.0.bb recipe.



Compiling:

| Generating local configuration database from kernel ... done.

| arm-poky-linux-gnueabi-gcc  -march=3Darmv7ve -mfpu=3Dneon  -mfloat-abi=3D=
hard -mcpu=3Dcortex-a7 --sysroot=3D/home/jameel/project/task22-yocto-6ul-ev=
k/fsl-arm-yocto-bsp/imx6ulevk/tmp/sysroots/imx6ulevk -Wall -Wmissing-protot=
ypes -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o conf.o conf.c

| arm-poky-linux-gnueabi-gcc  -march=3Darmv7ve -mfpu=3Dneon  -mfloat-abi=3D=
hard -mcpu=3Dcortex-a7 --sysroot=3D/home/jameel/project/task22-yocto-6ul-ev=
k/fsl-arm-yocto-bsp/imx6ulevk/tmp/sysroots/imx6ulevk -Wall -Wmissing-protot=
ypes -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o zconf.tab.o zconf=
.tab.c

| arm-poky-linux-gnueabi-gcc  -march=3Darmv7ve -mfpu=3Dneon  -mfloat-abi=3D=
hard -mcpu=3Dcortex-a7 --sysroot=3D/home/jameel/project/task22-yocto-6ul-ev=
k/fsl-arm-yocto-bsp/imx6ulevk/tmp/sysroots/imx6ulevk -Wl,-O1 -Wl,--hash-sty=
le=3Dgnu -Wl,--as-needed  conf.o zconf.tab.o   -o conf

| ./kconf/conf: 1: ./kconf/conf: Syntax error: word unexpected (expecting "=
)")

| Makefile.real:41: recipe for target 'defconfig-brcmfmac' failed

| make[1]: *** [defconfig-brcmfmac] Error 2

| Makefile:40: recipe for target 'defconfig-brcmfmac' failed

| make: *** [defconfig-brcmfmac] Error 2

| WARNING: exit code 2 from a shell command.



Could you please let me know how to generate the .config file by using nati=
ve make, instead of oe_runmake in Yocto setup?.


Thanks and Regards,
Jameel Basha

CONFIDENTIALITY: This message contains information which may be confidentia=
l and privileged.Unless you are the intended addressee (or authorized to re=
ceive for the intended addressee), you may not use, copy or disclose to any=
one the message or any information contained in the message. If you have re=
ceived the message in error, please advise the sender at Murata by reply em=
ail and delete the message.

--_000_KL1PR03MB1576391AC952EEB3FFCAE3939A540KL1PR03MB1576apcp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1535190347;
	mso-list-type:hybrid;
	mso-list-template-ids:-1092986980 -1415446166 67698691 67698693 67698689 6=
7698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.25in;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.2in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.7in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.2in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.7in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.2in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.7in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.2in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.7in;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Everyone,<o:p></o:p></p>
<p class=3D"MsoNormal">&shy;&shy;&shy;&shy;&shy;&shy; I am &nbsp;currently =
working on the creation of new <b>MACHINE</b> type for addressing the
<a href=3D"https://community.cypress.com/docs/DOC-14056">Cypress Broadcom F=
MAC driver release</a> ( attached for your reference).<o:p></o:p></p>
<p class=3D"MsoNormal">As part of the initial steps, I am ensuring that, we=
 have necessary recipes tested, so that, it can added to the new MACHINE ty=
pe along with the new layer &#8220;meta-murata-wireless&#8221;<o:p></o:p></=
p>
<p class=3D"MsoNormal">I was able to get the <i>wpa-supplicant</i> and <i>h=
ostapd</i> recipe into the Yocto setup.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I need your help in resolving a problem related to n=
ative <i>
<span style=3D"color:blue">make</span></i><span style=3D"color:blue"> </spa=
n>when using the Backport Tools.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><u>Backport Tools:<o:p></o:p></u></b></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in">FMAC driver uses =
Backport Tool (v4.12-backports) to generate the necessary .ko files, namely=
 (<i>compat.ko</i>,
<i>brcmfmac.ko</i>, <i>brcmutil.ko</i> and <i>cfg80211.ko)</i><o:p></o:p></=
p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in">In the Readme fil=
e, 2<sup>nd</sup> step under the Section : &#8220;<i>Build the cypress driv=
er/backports modules</i>&#8221; is to
<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.7in;text-indent:-.25in;=
mso-list:l0 level1 lfo1">
<![if !supportLists]><span style=3D"mso-list:Ignore">-<span style=3D"font:7=
.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
</span></span><![endif]><i>(Native) compile local tools and generate .confi=
g without sourcing Yocto tool chain settings</i>.<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.7in"><span style=3D"fon=
t-family:&quot;Courier New&quot;">make KLIB=3D$MY_KERNEL KLIB_BUILD=3D$MY_K=
ERNEL defconfig-brcmfmac</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><u>Problem Description:<o:p></o:p></u></b></p>
<p class=3D"MsoNormal"><b><u>&nbsp;&nbsp; <o:p></o:p></u></b></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in">I don&#8217;t kno=
w how to use the native make in the do_compile( ) function in
<i>backportcypress_1.0.bb</i> ( attached for your reference), as Yocto uses=
 tool chain settings.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; I get the following error message, when I compil=
e
<i>backportcypress_1.0.bb </i>recipe.<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><o:p>&nbsp;</o:p>=
</p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">Compiling:<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| Generating local configuration database from kernel ... do=
ne.<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| arm-poky-linux-gnueabi-gcc&nbsp; -march=3Darmv7ve -mfpu=3D=
neon&nbsp; -mfloat-abi=3Dhard -mcpu=3Dcortex-a7 --sysroot=3D/home/jameel/pr=
oject/task22-yocto-6ul-evk/fsl-arm-yocto-bsp/imx6ulevk/tmp/sysroots/imx6ule=
vk
 -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer&nb=
sp;&nbsp; -c -o conf.o conf.c<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| arm-poky-linux-gnueabi-gcc&nbsp; -march=3Darmv7ve -mfpu=3D=
neon&nbsp; -mfloat-abi=3Dhard -mcpu=3Dcortex-a7 --sysroot=3D/home/jameel/pr=
oject/task22-yocto-6ul-evk/fsl-arm-yocto-bsp/imx6ulevk/tmp/sysroots/imx6ule=
vk
 -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer&nb=
sp;&nbsp; -c -o zconf.tab.o zconf.tab.c<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| arm-poky-linux-gnueabi-gcc&nbsp; -march=3Darmv7ve -mfpu=3D=
neon&nbsp; -mfloat-abi=3Dhard -mcpu=3Dcortex-a7 --sysroot=3D/home/jameel/pr=
oject/task22-yocto-6ul-evk/fsl-arm-yocto-bsp/imx6ulevk/tmp/sysroots/imx6ule=
vk
 -Wl,-O1 -Wl,--hash-style=3Dgnu -Wl,--as-needed&nbsp; conf.o zconf.tab.o&nb=
sp;&nbsp; -o conf<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| ./kconf/conf: 1: ./kconf/conf: Syntax error: word unexpect=
ed (expecting &quot;)&quot;)<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| Makefile.real:41: recipe for target 'defconfig-brcmfmac' f=
ailed<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| make[1]: *** [defconfig-brcmfmac] Error 2<o:p></o:p></span=
></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| Makefile:40: recipe for target 'defconfig-brcmfmac' failed=
<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| make: *** [defconfig-brcmfmac] Error 2<o:p></o:p></span></=
p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><span style=3D"fo=
nt-size:8.0pt">| WARNING: exit code 2 from a shell command.<o:p></o:p></spa=
n></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in"><o:p>&nbsp;</o:p>=
</p>
<p class=3D"MsoListParagraph" style=3D"margin-left:.45in">Could you please =
let me know how to generate the .config file by using native
<i><span style=3D"color:blue">make</span></i>, instead of oe_runmake in Yoc=
to setup?.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jameel Basha<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
CONFIDENTIALITY: This message contains information which may be confidentia=
l and privileged.Unless you are the intended addressee (or authorized to re=
ceive for the intended addressee), you may not use, copy or disclose to any=
one the message or any information
 contained in the message. If you have received the message in error, pleas=
e advise the sender at Murata by reply email and delete the message.
</body>
</html>

--_000_KL1PR03MB1576391AC952EEB3FFCAE3939A540KL1PR03MB1576apcp_--
