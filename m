Received: from mailout2.ltindia.com ([125.18.18.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Girija.B@lnties.com>) id 1SaKAx-000328-N0
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jun 2012 07:13:28 +0200
Received: from unknown (HELO POCITMSEXHUB03.LntUniverse.com) ([10.2.1.60])
	by mailout2.ltindia.com with ESMTP; 01 Jun 2012 10:31:58 +0530
Received: from POCITMSEXMB03.LntUniverse.com ([fe80::f495:7e6e:4c34:a3a9]) by
	POCITMSEXHUB03.LntUniverse.com ([::1]) with mapi id 14.02.0247.003;
	Fri, 1 Jun 2012 10:31:56 +0530
From: Girija B <Girija.B@lnties.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Error when Setting up Open Embedded Environment 
Thread-Index: Ac0/s3VzJ6xqgAztRJSoVcnWGVohaw==
Date: Fri, 1 Jun 2012 05:01:56 +0000
Message-ID: <098684E1B7B2F54491C5DA349D2EF443098C4837@POCITMSEXMB03.LntUniverse.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.240.181]
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 06 Jun 2012 18:33:24 +0200
Subject: Error when Setting up Open Embedded Environment
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 01 Jun 2012 05:13:28 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_098684E1B7B2F54491C5DA349D2EF443098C4837POCITMSEXMB03Ln_"

--_000_098684E1B7B2F54491C5DA349D2EF443098C4837POCITMSEXMB03Ln_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I had installed Bitbake and open embedded as described in the OE User Manua=
l , when I tried to Build using : bitbake build command , am getting the fo=
llowing Error ,
Please help in solving this .

solar@ubuntu:~/Downloads/test/build$ bitbake build
Traceback (most recent call last):
  File "/usr/local/bin/bitbake", line 143, in <module>
    main()
  File "/usr/local/bin/bitbake", line 123, in main
    cooker.parseConfiguration()
  File "/usr/local/lib/python2.6/dist-packages/bb/cooker.py", line 68, in p=
arseConfiguration
    self.parseConfigurationFile( os.path.join( "conf", "bitbake.conf" ) )
  File "/usr/local/lib/python2.6/dist-packages/bb/cooker.py", line 404, in =
parseConfigurationFile
    bb.event.fire(bb.event.ConfigParsed(self.configuration.data))
  File "/usr/local/lib/python2.6/dist-packages/bb/event.py", line 67, in fi=
re
    if tmpHandler(event) =3D=3D Handled:
  File "tmpHandler(e)", line 3, in tmpHandler
  File "<bb>", line 14, in oe_import
ImportError: No module named oe.data


Thanks,
Girija. B


Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the inten=
ded recipient (s). If you are not the intended recipient, please do not use=
 or disseminate the information, notify the sender and delete it from your =
system.

 Earth Day. Every Day.

--_000_098684E1B7B2F54491C5DA349D2EF443098C4837POCITMSEXMB03Ln_
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
	{margin:0in;
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
	{margin:1.0in 1.0in 1.0in 1.0in}
div.WordSection1
	{}
-->
</style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">I had installed Bitbake and open embedded as describ=
ed in the OE User Manual , when I tried to Build using : bitbake build comm=
and , am getting the following Error ,</p>
<p class=3D"MsoNormal">Please help in solving this .</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">solar@ubuntu:~/Downloads/test/build$ bitbake build</=
p>
<p class=3D"MsoNormal">Traceback (most recent call last):</p>
<p class=3D"MsoNormal">&nbsp; File &quot;/usr/local/bin/bitbake&quot;, line=
 143, in &lt;module&gt;</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; main()</p>
<p class=3D"MsoNormal">&nbsp; File &quot;/usr/local/bin/bitbake&quot;, line=
 123, in main</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; cooker.parseConfiguration()</p>
<p class=3D"MsoNormal">&nbsp; File &quot;/usr/local/lib/python2.6/dist-pack=
ages/bb/cooker.py&quot;, line 68, in parseConfiguration</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; self.parseConfigurationFile( os.p=
ath.join( &quot;conf&quot;, &quot;bitbake.conf&quot; ) )</p>
<p class=3D"MsoNormal">&nbsp; File &quot;/usr/local/lib/python2.6/dist-pack=
ages/bb/cooker.py&quot;, line 404, in parseConfigurationFile</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; bb.event.fire(bb.event.ConfigPars=
ed(self.configuration.data))</p>
<p class=3D"MsoNormal">&nbsp; File &quot;/usr/local/lib/python2.6/dist-pack=
ages/bb/event.py&quot;, line 67, in fire</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; if tmpHandler(event) =3D=3D Handl=
ed:</p>
<p class=3D"MsoNormal">&nbsp; File &quot;tmpHandler(e)&quot;, line 3, in tm=
pHandler</p>
<p class=3D"MsoNormal">&nbsp; File &quot;&lt;bb&gt;&quot;, line 14, in oe_i=
mport</p>
<p class=3D"MsoNormal">ImportError: No module named oe.data</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Thanks,</p>
<p class=3D"MsoNormal">Girija. B</p>
<p class=3D"MsoNormal">&nbsp;</p>
</div>
<p><span style=3D"color:#008000"><strong>Larsen &amp; Toubro Limited </stro=
ng></span><br>
<br>
<strong><a href=3D"www.larsentoubro.com" target=3D"_blank">www.larsentoubro=
.com</a></strong></p>
<p><span style=3D"color:#008000">This Email may contain confidential or pri=
vileged information for the intended recipient (s). If you are not the inte=
nded recipient, please do not use or disseminate the information, notify th=
e sender and delete it from your system.</span></p>
<p><strong><span style=3D"color:#008000">&nbsp;Earth Day. Every Day.</span>=
</strong></p>
</body>
</html>

--_000_098684E1B7B2F54491C5DA349D2EF443098C4837POCITMSEXMB03Ln_--
