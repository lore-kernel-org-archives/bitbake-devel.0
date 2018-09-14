Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id B671474E47
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Sep 2018 07:18:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8E7ICwL004664
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 14 Sep 2018 00:18:12 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.79]) by
	ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0415.000;
	Fri, 14 Sep 2018 00:18:11 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: "Belal, Awais" <Awais_Belal@mentor.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller:
	fix bitbake path resolution
Thread-Index: AQHUS0UdM8G0xVWi7EeQqAsalTR7hKTvXz/w
Date: Fri, 14 Sep 2018 07:18:10 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>
References: <1536831336527.93802@mentor.com>
In-Reply-To: <1536831336527.93802@mentor.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.117.84]
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
X-List-Received-Date: Fri, 14 Sep 2018 07:18:11 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6ALAMBDcorpadwrs_"

--_000_5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6ALAMBDcorpadwrs_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6ALAMBDcorpadwrs_
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
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Hi all,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">I recommend this for both=
 Sumo and for master as well, so that they stay in sync.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">The cherry-pick should be=
 clean between the two branches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">- David<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> bitbake-=
devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bounces@lists.op=
enembedded.org]
<b>On Behalf Of </b>Belal, Awais<br>
<b>Sent:</b> Thursday, September 13, 2018 2:36 AM<br>
<b>To:</b> bitbake-devel@lists.openembedded.org<br>
<b>Subject:</b> [bitbake-devel] [sumo][PATCH] toaster: localhostbecontrolle=
r: fix bitbake path resolution<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;;color:black">From b736703a9d3f3c33e2e83ecd5e61dbddd5793cc8 Mo=
n Sep 17 00:00:00 2001<br>
From: Awais Belal &lt;awais_belal@mentor.com&gt;<br>
Date: Thu, 13 Sep 2018 14:12:18 &#43;0500<br>
Subject: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path res=
olution<o:p></o:p></span></p>
<p><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;;color:black">15340edce23e63b060c75114d508e1f76757239c introdu=
ced a way which<br>
allowed bitbake to be found from the PATH variable when directory<br>
structures different from poky are used. This just drops a leftover<br>
which made the earlier implementation meaningless by reassigning<br>
the path relative to oe-core/meta.<o:p></o:p></span></p>
<p><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;;color:black">Signed-off-by: Awais Belal &lt;awais_belal@mento=
r.com&gt;<br>
---<br>
&nbsp;lib/toaster/bldcontrol/localhostbecontroller.py | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<o:p></o:p></span></=
p>
<p><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"margin-bottom:12.0pt"><span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:black">diff --git a/lib/=
toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localh=
ostbecontroller.py<br>
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
2.7.4<o:p></o:p></span></p>
<p><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<div id=3D"Signature">
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;;color:black">BR,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><i><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;;color:black">Awais</span></i><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot=
;;color:black"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6ALAMBDcorpadwrs_--
