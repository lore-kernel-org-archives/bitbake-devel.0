Return-Path: <Teemu.Keskinarkaus@Maximatecc.com>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
	[216.82.243.208])
	by mail.openembedded.org (Postfix) with ESMTP id 3202360DF0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2013 10:30:21 +0000 (UTC)
Received: from [216.82.241.196:33801] by server-16.bemta-8.messagelabs.com id
	24/18-25693-DB630C15; Tue, 18 Jun 2013 10:30:21 +0000
X-Env-Sender: Teemu.Keskinarkaus@Maximatecc.com
X-Msg-Ref: server-14.tower-46.messagelabs.com!1371551419!31176788!1
X-Originating-IP: [207.250.73.122]
X-StarScan-Received: 
X-StarScan-Version: 6.9.6; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13287 invoked from network); 18 Jun 2013 10:30:20 -0000
Received: from unknown (HELO ammail.actuant.com) (207.250.73.122)
	by server-14.tower-46.messagelabs.com with AES128-SHA encrypted SMTP;
	18 Jun 2013 10:30:20 -0000
Received: from AMDTCEX12.actuant.pri ([fe80::1ff:ff4d:9ac5:22e8]) by
	AMDTCEX11.actuant.pri ([fe80::f86b:7a40:d71b:bb92%21]) with mapi id
	14.02.0342.003; Tue, 18 Jun 2013 05:30:15 -0500
From: "Keskinarkaus, Teemu" <Teemu.Keskinarkaus@Maximatecc.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Creating library
Thread-Index: Ac5sDsv9L7yhi9ZXSBa+g+l2cgnrdw==
Date: Tue, 18 Jun 2013 10:30:15 +0000
Message-ID: <83DB4EC8FADD45428E3CC4E3664761FD015B19FC@AMDTCEX12.actuant.pri>
Accept-Language: fi-FI, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.10.100]
x-ems-proccessed: 52bwn4SPvyFdxH+yW9O0UA==
x-ems-stamp: 1Ohg9KJZRBA3QJIahk8v8Q==
MIME-Version: 1.0
Subject: Creating library
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Jun 2013 10:30:21 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_83DB4EC8FADD45428E3CC4E3664761FD015B19FCAMDTCEX12actuan_"

--_000_83DB4EC8FADD45428E3CC4E3664761FD015B19FCAMDTCEX12actuan_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Hopefully this is the correct mailing list.

I'm using Yocto/Poky to create Linux distribution and so far everything has=
 gone rather smoothly, but now I have come up to a problem that I cannot se=
em to be able to fix.

I'm adding existing old software to Yocto/Poky and they don't use autotools=
 so there is ready made Makefile that does everything.

Problem comes with the library that is compiled that way too. Makefile has =
targets all and install that does the compilation and installation. Library=
 compiles ok and installs ok too under -build directory, but when bitbake c=
reates the deb-packages it creates only library-dev.deb, library-dbg.deb an=
d library-staticdev.deb. The package library.deb does not get created and t=
hat causes build to fail. I looked the logs and bitbake says that NOTE: not=
 creating empty library.deb - package. or something like that.

I've tried anything that comes to my mind and also searched documentation a=
nd google and looked other libraries that are in yocto/poky, but just canno=
t get that work. I've also tried add FILES_${PN} to the recipe to force the=
 files in the library.deb package, but that didn't help.  Makefile installs=
 the files to DESTDIR.

For some reason, maybe because lack of autotools, I had to set S and B dir =
to point to the dir where library sources are. Would that be causing the pr=
oblems even though the library gets installed to image in build-directory?

Library.deb isn't the actual name, but just an example.

I wouldn't want to convert all the software to use autotools since there ar=
e quite many of them and they are used in other projects as well so it woul=
d be rather big task. Any idea how to get that library thing to work?

I have few kernel modules where I also had to set S and B to point the dir =
where the kernel module sources are, but in those cases there were no probl=
ems. Only the library gives me hard time.

-Teemu Keskinarkaus


________________________________

Actuant Corporation Email Notice

This message is intended only for the use of the Addressee and may contain =
information that is PRIVILEGED and/or CONFIDENTIAL.
This email is intended only for the personal and confidential use of the re=
cipient(s) named above. If the reader of this email is not an intended reci=
pient, you have received this email in error and any review, dissemination,=
 distribution or copying is strictly prohibited.
If you have received this email in error, please notify the sender immediat=
ely by return mail and permanently delete the copy you received.

Thank you.

--_000_83DB4EC8FADD45428E3CC4E3664761FD015B19FCAMDTCEX12actuan_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style>
<!--
@font-face
	{font-family:Calibri}
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif"}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
span.EmailStyle17
	{font-family:"Calibri","sans-serif";
	color:windowtext}
.MsoChpDefault
	{font-family:"Calibri","sans-serif"}
@page WordSection1
	{margin:70.85pt 2.0cm 70.85pt 2.0cm}
div.WordSection1
	{}
-->
</style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Hopefully this is the correct mailing list.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">I&#8217;m using Yocto/Poky to create Linux distribut=
ion and so far everything has gone rather smoothly, but now I have come up =
to a problem that I cannot seem to be able to fix.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">I&#8217;m adding existing old software to Yocto/Poky=
 and they don&#8217;t use autotools so there is ready made Makefile that do=
es everything.
</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Problem comes with the library that is compiled that=
 way too. Makefile has targets all and install that does the compilation an=
d installation. Library compiles ok and installs ok too under &#8211;build =
directory, but when bitbake creates the
 deb-packages it creates only library-dev.deb, library-dbg.deb and library-=
staticdev.deb. The package library.deb does not get created and that causes=
 build to fail. I looked the logs and bitbake says that NOTE: not creating =
empty library.deb &#8211; package. or
 something like that.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">I&#8217;ve tried anything that comes to my mind and =
also searched documentation and google and looked other libraries that are =
in yocto/poky, but just cannot get that work. I&#8217;ve also tried add FIL=
ES_${PN} to the recipe to force the files in the
 library.deb package, but that didn&#8217;t help. &nbsp;Makefile installs t=
he files to DESTDIR.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">For some reason, maybe because lack of autotools, I =
had to set S and B dir to point to the dir where library sources are. Would=
 that be causing the problems even though the library gets installed to ima=
ge in build-directory?</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Library.deb isn&#8217;t the actual name, but just an=
 example.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">I wouldn&#8217;t want to convert all the software to=
 use autotools since there are quite many of them and they are used in othe=
r projects as well so it would be rather big task. Any idea how to get that=
 library thing to work?</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">I have few kernel modules where I also had to set S =
and B to point the dir where the kernel module sources are, but in those ca=
ses there were no problems. Only the library gives me hard time.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">-Teemu Keskinarkaus</p>
<p class=3D"MsoNormal">&nbsp;</p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Black" size=3D"1"><br>
Actuant Corporation Email Notice<br>
<br>
This message is intended only for the use of the Addressee and may contain =
information that is PRIVILEGED and/or CONFIDENTIAL.<br>
This email is intended only for the personal and confidential use of the re=
cipient(s) named above. If the reader of this email is not an intended reci=
pient, you have received this email in error and any review, dissemination,=
 distribution or copying is strictly
 prohibited.<br>
If you have received this email in error, please notify the sender immediat=
ely by return mail and permanently delete the copy you received.<br>
<br>
Thank you.<br>
</font>
</body>
</html>

--_000_83DB4EC8FADD45428E3CC4E3664761FD015B19FCAMDTCEX12actuan_--
