Return-Path: <simon.chen@lmco.com>
X-Greylist: delayed 3682 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 20 Mar 2015 15:27:16 UTC
Received: from mailfo02.lmco.com (mailfo02.lmco.com [192.35.35.12])
	by mail.openembedded.org (Postfix) with ESMTP id 9A26A6013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 15:27:16 +0000 (UTC)
Received: from HVXHTPN9.us.lmco.com (hvxhtpn9.ems.lmco.com [158.186.149.27])
	by mailfo02.lmco.com (8.14.5/8.14.5) with ESMTP id t2KEPrx7003010
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 14:25:54 GMT
Received: from HVXDSP45.us.lmco.com ([fe80::e5e8:eada:5adc:d92a]) by
	HVXHTPN9.us.lmco.com ([fe80::cc0f:96a:cb16:8684%15]) with mapi id
	14.03.0174.001; Fri, 20 Mar 2015 10:25:13 -0400
From: "Chen, Simon (N-DCR SYSTEM HOUSE)" <simon.chen@lmco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Configuring Busybox's Kernel Commands
Thread-Index: AdBjFhGYZdeBUP+1R7C/oZmMB/5c6A==
Date: Fri, 20 Mar 2015 14:25:13 +0000
Message-ID: <D3EFC6D8DB6B2D48A91E6F02D0DB338FA68306@HVXDSP45.us.lmco.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [158.186.156.90]
MIME-Version: 1.0
X-LM-Outbound: External 158.186.149.27 cntry=us
	g=6197f242fc6a2674800aea5bea095fdc q=t2KEPrx7003010 m=3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.13.68, 1.0.33,
	0.0.0000
	definitions=2015-03-20_05:2015-03-20, 2015-03-20,
	1970-01-01 signatures=0
Subject: Configuring Busybox's Kernel Commands
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
X-List-Received-Date: Fri, 20 Mar 2015 15:27:16 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D3EFC6D8DB6B2D48A91E6F02D0DB338FA68306HVXDSP45uslmcocom_"

--_000_D3EFC6D8DB6B2D48A91E6F02D0DB338FA68306HVXDSP45uslmcocom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am pretty new to the Yocto Project, and I am not sure if this mailing lis=
t fits my particular project goals. But since I am still waiting for subscr=
iption permission from other mailing lists, I'd thought I'd give this a sho=
t.

I am using Yocto's Poky to build an OS for a custom board. On this embedded=
 OS, I am trying to run an AMD GPU driver installer for the E8860 series ca=
rd in which I am trying to integrate on my board. (This installer can be fo=
und here : http://support.amd.com/en-us/download/desktop?os=3DLinux+x86). A=
s expected, the installer is not fully configured for Yocto. The installer =
(.run file) generates two errors from calling the commands "tar" and "gzip"=
, outputting an "invalid magic" error. I did some homework, and realized th=
at Yocto's linux commands are not from GNU at all, and are GNU-like command=
s built by Busybox. So I've tried to reconfigure these commands from the pr=
e-bitbake stage by editing the "defconfig" file at the meta/recipes-core/bu=
sybox/busybox directory. In defconfig, I've tried turning on a couple of pa=
rameters that were previously off (ie. CONFIG_FEATURE_TAR_OLDSUN_COMPATIBIL=
ITY=3Dy, or CONFIG_FEATURE_TAR_LONG_OPTIONS=3Dy). This did not work, after =
I bitbaked core-image-sato, booted the Yocto image on my board, and ran the=
 installer. Perhaps I'm missing a step in configuring the GNU commands? Per=
haps I'm turning on the wrong parameters? Is there a way to remove Busybox =
completely and replace it with the real GNU?

I'd appreciate any input. Thanks.

-Simon Chen

--_000_D3EFC6D8DB6B2D48A91E6F02D0DB338FA68306HVXDSP45uslmcocom_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am pretty new to the Yocto Project, and I am not s=
ure if this mailing list fits my particular project goals. But since I am s=
till waiting for subscription permission from other mailing lists, I&#8217;=
d thought I&#8217;d give this a shot.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am using Yocto&#8217;s Poky to build an OS for a c=
ustom board. On this embedded OS, I am trying to run an AMD GPU driver inst=
aller for the E8860 series card in which I am trying to integrate on my boa=
rd. (This installer can be found here :
<a href=3D"http://support.amd.com/en-us/download/desktop?os=3DLinux&#43;x86=
">http://support.amd.com/en-us/download/desktop?os=3DLinux&#43;x86</a>). As=
 expected, the installer is not fully configured for Yocto. The installer (=
.run file) generates two errors from calling the
 commands &#8220;tar&#8221; and &#8220;gzip&#8221;, outputting an &#8220;in=
valid magic&#8221; error. I did some homework, and realized that Yocto&#821=
7;s linux commands are not from GNU at all, and are GNU-like commands built=
 by Busybox. So I&#8217;ve tried to reconfigure these commands from the pre=
-bitbake
 stage by editing the &#8220;defconfig&#8221; file at the meta/recipes-core=
/busybox/busybox directory. In defconfig, I&#8217;ve tried turning on a cou=
ple of parameters that were previously off (ie. CONFIG_FEATURE_TAR_OLDSUN_C=
OMPATIBILITY=3Dy, or CONFIG_FEATURE_TAR_LONG_OPTIONS=3Dy).
 This did not work, after I bitbaked core-image-sato, booted the Yocto imag=
e on my board, and ran the installer. Perhaps I&#8217;m missing a step in c=
onfiguring the GNU commands? Perhaps I&#8217;m turning on the wrong paramet=
ers? Is there a way to remove Busybox completely
 and replace it with the real GNU?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;d appreciate any input. Thanks.<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Simon Chen<o:p></o:p></p>
</div>
</body>
</html>

--_000_D3EFC6D8DB6B2D48A91E6F02D0DB338FA68306HVXDSP45uslmcocom_--
