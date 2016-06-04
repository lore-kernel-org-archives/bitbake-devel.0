Return-Path: <Sandeep_Nair2@cable.comcast.com>
X-Greylist: delayed 901 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 04 Jun 2016 18:24:52 UTC
Received: from vaadcmhout01.cable.comcast.com (vaadcmhout01.cable.comcast.com
	[96.114.28.75])
	by mail.openembedded.org (Postfix) with ESMTP id 51E7877234
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jun 2016 18:24:52 +0000 (UTC)
X-AuditID: 60721c4b-32fff70000009513-e6-5753196cf4fb
Received: from VAADCEX06.cable.comcast.com (vaadcmhoutvip.cable.comcast.com
	[96.115.73.56]) (using TLS with cipher AES256-SHA256 (256/256 bits))
	(Client did not present a certificate)
	by  (SMTP Gateway) with SMTP id 9D.23.38163.C6913575;
	Sat,  4 Jun 2016 14:09:51 -0400 (EDT)
Received: from VAADCEX01.cable.comcast.com (147.191.102.68) by
	VAADCEX06.cable.comcast.com (147.191.102.73) with Microsoft SMTP Server
	(TLS) id 15.0.1130.7; Sat, 4 Jun 2016 14:09:48 -0400
Received: from VAADCEX01.cable.comcast.com ([fe80::3aea:a7ff:fe12:e288]) by
	VAADCEX01.cable.comcast.com ([fe80::3aea:a7ff:fe12:e288%19]) with mapi
	id 15.00.1130.005; Sat, 4 Jun 2016 14:09:48 -0400
From: "Nair, Sandeep (Contractor)" <Sandeep_Nair2@cable.comcast.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Random Bitbake build failures 
Thread-Index: AdG+jCyps5ciWIr6TWCsDuMFJqpzLA==
Date: Sat, 4 Jun 2016 18:09:48 +0000
Message-ID: <9547b470c88646879f86e63f4371ad71@VAADCEX01.cable.comcast.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [68.87.29.8]
MIME-Version: 1.0
X-CFilter-Loop: Forward
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWSUOxpoVsgGRxusLaVzeL60VAHRo9zG1cw
	BjBGcdmkpOZklqUW6dslcGVMPjGHteCBdcWan/tZGhjnmXQxcnJICJhIXF7cx9jFyMUhJDCT
	SWLtwi/sEM5+RomVG5ZDZU4wSsy5uYAVpIVNwEVi96pGdhBbRCBYYt2qHiYQW1hAXWLx90ss
	XYwcQHEdibkreCFMPYnmtTYgFSwCKhIf2p4wg9i8Al4Sfy5fBpvCKCAm8f3UGrApzALiEree
	zGeCOE5AYsme88wQtqjEy8f/WCFsA4mtS/exQNhyEj07WhkhevMlLqyfBDVfUOLkzCdQNeIS
	h4/sYJ3AKDILyYpZSFpmIWmBiOtILNj9iQ3C1pZYtvA1M4x95sBjJmTxBYzsqxjlyhITU5Jz
	M/JLSwwM9ZITk3JS9ZLzc5MTi0tA9CZGUEwVyXjvYFz30/0QowAHoxIP7w3B4HAh1sSy4src
	Q4wSHMxKIrw1rEAh3pTEyqrUovz4otKc1OJDjNIcLErivL0/bMOFBNITS1KzU1MLUotgskwc
	nFINjFqW6WHz0ia8mRUS6jVpiu7sqp/7JjXc57RM+WtsERfgzS7xRU3+E0vqfz+GvMknfu/p
	K5NKknv3Pzy1OvC44g2P6PT/dpFxOVcKna+Wuez7eWquiccsp/guF/9jNnIFYhmr/l17PS1j
	qb1zeGinThrX9Zu3/17dE3z44/KFG774HmB++WfPUiWW4oxEQy3mouJEAHIL8IilAgAA
X-Mailman-Approved-At: Sat, 04 Jun 2016 21:36:43 +0000
Subject: Random Bitbake build failures
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
X-List-Received-Date: Sat, 04 Jun 2016 18:24:53 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_9547b470c88646879f86e63f4371ad71VAADCEX01cablecomcastco_"

--_000_9547b470c88646879f86e63f4371ad71VAADCEX01cablecomcastco_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Bitbake version : 1.22.0

We are facing random failures with Bitbake builds. Bitbake is returning an =
error even when the operation succeeded on the successful retry.

Eg:

ERROR: Error executing a python function in /mnt/jenkins/workspace/PACEXI3V=
2-Yocto-Build/meta-rdk-comcast/recipes-extended/netzyn/netzyn_git.bb:
Exception: IOError: [Errno 116] Stale file handle

WARNING: Logfile for failed setscene task is /mnt/jenkins/workspace/PACEXI3=
V2-Yocto-Build/build-pacexi3v2/tmp/work/mips32el-rdk-linux/netzyn/1.99+gitA=
UTOINC+c3752ca038_c7068967a1-r0/temp/log.do_package_setscene.8946
WARNING: Setscene task 1277 (/mnt/jenkins/workspace/PACEXI3V2-Yocto-Build/m=
eta-rdk-comcast/recipes-extended/netzyn/netzyn_git.bb, do_package_setscene)=
 failed with exit code '1' - real task will be run instead

"Setscene" is a bb attempt to use sstate cache.

It says about real task will run instead. Does that mean it tried build loc=
ally (it should)?

In all stale cases it fails in this code:

File: '..../openembedded-core/bitbake/lib/bb/utils.py', lineno: 467, functi=
on: md5_file
     0463:        import md5
     0464:        m =3D md5.new()
     0465:
     0466:    with open(filename, "rb") as f:
*** 0467:        for line in f:
     0468:            m.update(line)
     0469:    return m.hexdigest()
     0470:

As can be seen it tries use handle it was given but the file is not valid o=
n remote side already. So system lib returns stale handle.

How does Bitbake handle the unsuccessful set scene ? will it just go with r=
egular local build or just fail immediately.


This causes us random failures in our builds. Could you please provide insi=
ght on whether there is a patch available to address this issue or is this =
issue is addressed in latest Bitbake versions

Thanks,
Sandeep

--_000_9547b470c88646879f86e63f4371ad71VAADCEX01cablecomcastco_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
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
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Bitbake version : 1.22.0<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are facing random failures with Bitbake builds. B=
itbake is returning an error even when the operation succeeded on the succe=
ssful retry.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Eg: <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ERROR: Error executing a python function in /mnt/jen=
kins/workspace/PACEXI3V2-Yocto-Build/meta-rdk-comcast/recipes-extended/netz=
yn/netzyn_git.bb:<o:p></o:p></p>
<p class=3D"MsoNormal">Exception: IOError: [Errno 116] Stale file handle<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">WARNING: Logfile for failed setscene task is /mnt/je=
nkins/workspace/PACEXI3V2-Yocto-Build/build-pacexi3v2/tmp/work/mips32el-rdk=
-linux/netzyn/1.99&#43;gitAUTOINC&#43;c3752ca038_c7068967a1-r0/temp/log.do_=
package_setscene.8946<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING: Setscene task 1277 (/mnt/jenkins/workspace/=
PACEXI3V2-Yocto-Build/meta-rdk-comcast/recipes-extended/netzyn/netzyn_git.b=
b, do_package_setscene) failed with exit code '1' - real task will be run i=
nstead<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#8220;Setscene&#8221; is a bb attempt to use sstate=
 cache.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It says about real task will run instead. Does that =
mean it tried build locally (it should)?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In all stale cases it fails in this code: <o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">File: &#8216;&#8230;./openembedded-core/bitbake/lib/=
bb/utils.py', lineno: 467, function: md5_file<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; 0463:&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; import md5<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; 0464:&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; m =3D md5.new()<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; 0465:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; 0466:&nbsp;&nbsp;&nbsp; wit=
h open(filename, &quot;rb&quot;) as f:<o:p></o:p></p>
<p class=3D"MsoNormal">*** 0467:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
for line in f:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; 0468:&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;m.update(line)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; 0469:&nbsp;&nbsp;&nbsp; ret=
urn m.hexdigest()<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; 0470:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As can be seen it tries use handle it was given but =
the file is not valid on remote side already. So system lib returns stale h=
andle.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">How does Bitbake handle the unsuccessful set scene ?=
 will it just go with regular local build or just fail immediately.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This causes us random failures in our builds. Could =
you please provide insight on whether there is a patch available to address=
 this issue or is this issue is addressed in latest Bitbake versions
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Sandeep<o:p></o:p></p>
</div>
</body>
</html>

--_000_9547b470c88646879f86e63f4371ad71VAADCEX01cablecomcastco_--
