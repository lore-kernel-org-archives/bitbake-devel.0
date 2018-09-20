Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 35BF779601
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Sep 2018 07:59:53 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1g2tsP-0005Oc-79 from Awais_Belal@mentor.com ;
	Thu, 20 Sep 2018 00:59:53 -0700
Received: from SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) by
	SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Thu, 20 Sep 2018 08:59:49 +0100
Received: from SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17]) by
	SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17%22]) with
	mapi id 15.00.1320.000; Thu, 20 Sep 2018 08:59:49 +0100
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: "Reyna, David" <david.reyna@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller:
	fix bitbake path resolution
Thread-Index: AQHUS0UdM8G0xVWi7EeQqAsalTR7hKTvXz/wgAl59yo=
Date: Thu, 20 Sep 2018 07:59:49 +0000
Message-ID: <1537430385445.98207@mentor.com>
References: <1536831336527.93802@mentor.com>,
	<5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>
In-Reply-To: <5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>
Accept-Language: en-US, en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.94.31.225]
MIME-Version: 1.0
Subject: Re: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
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
X-List-Received-Date: Thu, 20 Sep 2018 07:59:53 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_153743038544598207mentorcom_"

--_000_153743038544598207mentorcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

ping!


BR,
Awais
________________________________
From: Reyna, David <david.reyna@windriver.com>
Sent: Friday, September 14, 2018 12:18 PM
To: Belal, Awais; bitbake-devel@lists.openembedded.org
Cc: akuster (akuster@mvista.com)
Subject: RE: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller: =
fix bitbake path resolution

Hi all,

I recommend this for both Sumo and for master as well, so that they stay in=
 sync.

The cherry-pick should be clean between the two branches.

- David

From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Belal, Awais
Sent: Thursday, September 13, 2018 2:36 AM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller: fix =
bitbake path resolution


From b736703a9d3f3c33e2e83ecd5e61dbddd5793cc8 Mon Sep 17 00:00:00 2001
From: Awais Belal <awais_belal@mentor.com>
Date: Thu, 13 Sep 2018 14:12:18 +0500
Subject: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path res=
olution



15340edce23e63b060c75114d508e1f76757239c introduced a way which
allowed bitbake to be found from the PATH variable when directory
structures different from poky are used. This just drops a leftover
which made the earlier implementation meaningless by reassigning
the path relative to oe-core/meta.



Signed-off-by: Awais Belal <awais_belal@mentor.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)



diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/=
bldcontrol/localhostbecontroller.py
index 3850334..63b4187 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -360,12 +360,12 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
             for path in os.environ["PATH"].split(os.pathsep):
                 if os.path.exists(os.path.join(path, 'bitbake')):
                     bitbake =3D os.path.join(path, 'bitbake')
+                    logger.info("Found Bitbake at: %s" % path)
                     break
             else:
                 logger.error("Looks like Bitbake is not available, please =
fix your environment")

         # run bitbake server from the clone
-        bitbake =3D os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitb=
ake')
         toasterlayers =3D os.path.join(builddir,"conf/toaster-bblayers.con=
f")
         self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI=3D"knotty" %=
s --read %s --read %s '
                        '--server-only -B 0.0.0.0:0\"' % (env_clean, oe_ini=
t,
--
2.7.4


BR,
Awais

--_000_153743038544598207mentorcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} @font-face=0A=
	{font-family:Calibri}=0A=
@font-face=0A=
	{font-family:Tahoma}=0A=
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=
	{margin:0in;=0A=
	margin-bottom:.0001pt;=0A=
	font-size:12.0pt;=0A=
	font-family:"Times New Roman","serif"}=0A=
a:link, span.MsoHyperlink=0A=
	{color:blue;=0A=
	text-decoration:underline}=0A=
a:visited, span.MsoHyperlinkFollowed=0A=
	{color:purple;=0A=
	text-decoration:underline}=0A=
span.EmailStyle18=0A=
	{font-family:"Calibri","sans-serif";=0A=
	color:#1F497D}=0A=
.MsoChpDefault=0A=
	{font-size:10.0pt}=0A=
@page WordSection1=0A=
	{margin:1.0in 1.0in 1.0in 1.0in}=0A=
div.WordSection1=0A=
	{}--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:10pt;color:#000000;background-color:#F=
FFFFF;font-family:Tahoma,Geneva,sans-serif;">
<p>ping!<br>
</p>
<p><br>
</p>
<div id=3D"Signature">
<div style=3D"font-family:Tahoma; font-size:13px"><font face=3D"Tahoma"></f=
ont>
<div style=3D"font-size:13px">
<div><font size=3D"2" face=3D"Tahoma"><span lang=3D"en-US">
<div style=3D"margin:0">BR,</div>
<div style=3D"margin:0"><i>Awais</i></div>
</span></font></div>
</div>
<font face=3D"Tahoma"></font></div>
</div>
<div style=3D"color: rgb(33, 33, 33);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Reyna, David &lt;da=
vid.reyna@windriver.com&gt;<br>
<b>Sent:</b> Friday, September 14, 2018 12:18 PM<br>
<b>To:</b> Belal, Awais; bitbake-devel@lists.openembedded.org<br>
<b>Cc:</b> akuster (akuster@mvista.com)<br>
<b>Subject:</b> RE: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontr=
oller: fix bitbake path resolution</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">Hi all,
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">I recommend this for bo=
th Sumo and for master as well, so that they stay in sync.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">The cherry-pick should =
be clean between the two branches.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">- David</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #B5C4DF 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt; font-family:&quo=
t;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-=
size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> bitbak=
e-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bounces@lists.=
openembedded.org]
<b>On Behalf Of </b>Belal, Awais<br>
<b>Sent:</b> Thursday, September 13, 2018 2:36 AM<br>
<b>To:</b> bitbake-devel@lists.openembedded.org<br>
<b>Subject:</b> [bitbake-devel] [sumo][PATCH] toaster: localhostbecontrolle=
r: fix bitbake path resolution</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<p><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;; color:black">From b736703a9d3f3c33e2e83ecd5e61dbddd5793cc8 =
Mon Sep 17 00:00:00 2001<br>
From: Awais Belal &lt;awais_belal@mentor.com&gt;<br>
Date: Thu, 13 Sep 2018 14:12:18 &#43;0500<br>
Subject: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path res=
olution</span></p>
<p><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;; color:black">&nbsp;</span></p>
<p><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;; color:black">15340edce23e63b060c75114d508e1f76757239c intro=
duced a way which<br>
allowed bitbake to be found from the PATH variable when directory<br>
structures different from poky are used. This just drops a leftover<br>
which made the earlier implementation meaningless by reassigning<br>
the path relative to oe-core/meta.</span></p>
<p><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;; color:black">&nbsp;</span></p>
<p><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;; color:black">Signed-off-by: Awais Belal &lt;awais_belal@men=
tor.com&gt;<br>
---<br>
&nbsp;lib/toaster/bldcontrol/localhostbecontroller.py | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)</span></p>
<p><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;; color:black">&nbsp;</span></p>
<p style=3D"margin-bottom:12.0pt"><span style=3D"font-size:10.0pt; font-fam=
ily:&quot;Tahoma&quot;,&quot;sans-serif&quot;; color:black">diff --git a/li=
b/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/loca=
lhostbecontroller.py<br>
index 3850334..63b4187 100644<br>
--- a/lib/toaster/bldcontrol/localhostbecontroller.py<br>
&#43;&#43;&#43; b/lib/toaster/bldcontrol/localhostbecontroller.py<br>
@@ -360,12 &#43;360,12 @@ class LocalhostBEController(BuildEnvironmentContr=
oller):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fo=
r path in os.environ[&quot;PATH&quot;].split(os.pathsep):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if os.path.exists(os.path.join(path, 'bitbake')):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitbake =3D os.path.join(path=
, 'bitbake')<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logger.info(&quot;Found Bitbak=
e at: %s&quot; % path)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; el=
se:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; logger.error(&quot;Looks like Bitbake is not availabl=
e, please fix your environment&quot;)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # run bitbake server from =
the clone<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitbake =3D os.path.join(self.p=
okydirname, 'bitbake', 'bin', 'bitbake')<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toasterlayers =3D os.path.=
join(builddir,&quot;conf/toaster-bblayers.conf&quot;)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self._shellcmd('%s bash -c=
 \&quot;source %s %s; BITBAKE_UI=3D&quot;knotty&quot; %s --read %s --read %=
s '<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '--server-o=
nly -B 0.0.0.0:0\&quot;' % (env_clean, oe_init,<br>
--<br>
2.7.4</span></p>
<p><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;; color:black">&nbsp;</span></p>
<div id=3D"Signature">
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt; font-family:&quot;T=
ahoma&quot;,&quot;sans-serif&quot;; color:black">BR,</span></p>
</div>
<div>
<p class=3D"MsoNormal"><i><span style=3D"font-size:10.0pt; font-family:&quo=
t;Tahoma&quot;,&quot;sans-serif&quot;; color:black">Awais</span></i><span s=
tyle=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sans-serif&q=
uot;; color:black"></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_153743038544598207mentorcom_--
