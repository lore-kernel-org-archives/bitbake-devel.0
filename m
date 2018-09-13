Return-Path: <Awais_Belal@mentor.com>
X-Greylist: delayed 912 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 13 Sep 2018 09:50:51 UTC
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id B58687989F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Sep 2018 09:50:51 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=svr-ies-mbx-01.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1g0O2G-00031V-NV from Awais_Belal@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Thu, 13 Sep 2018 02:35:40 -0700
Received: from SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) by
	svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Thu, 13 Sep 2018 10:35:37 +0100
Received: from SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17]) by
	SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17%22]) with
	mapi id 15.00.1320.000; Thu, 13 Sep 2018 10:35:37 +0100
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path
	resolution
Thread-Index: AQHUS0UdM8G0xVWi7EeQqAsalTR7hA==
Date: Thu, 13 Sep 2018 09:35:37 +0000
Message-ID: <1536831336527.93802@mentor.com>
Accept-Language: en-US, en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.94.31.225]
MIME-Version: 1.0
Subject: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
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
X-List-Received-Date: Thu, 13 Sep 2018 09:50:51 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_153683133652793802mentorcom_"

--_000_153683133652793802mentorcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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

--_000_153683133652793802mentorcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:10pt;color:#000000;background-color:#F=
FFFFF;font-family:Tahoma,Geneva,sans-serif;">
<p>From b736703a9d3f3c33e2e83ecd5e61dbddd5793cc8 Mon Sep 17 00:00:00 2001<b=
r>
From: Awais Belal &lt;awais_belal@mentor.com&gt;<br>
Date: Thu, 13 Sep 2018 14:12:18 &#43;0500<br>
Subject: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path res=
olution<br>
</p>
<p><br>
</p>
<p>15340edce23e63b060c75114d508e1f76757239c introduced a way which<br>
allowed bitbake to be found from the PATH variable when directory<br>
structures different from poky are used. This just drops a leftover<br>
which made the earlier implementation meaningless by reassigning<br>
the path relative to oe-core/meta.<br>
</p>
<p><br>
</p>
<p>Signed-off-by: Awais Belal &lt;awais_belal@mentor.com&gt;<br>
---<br>
&nbsp;lib/toaster/bldcontrol/localhostbecontroller.py | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
</p>
<p><br>
</p>
<p>diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toast=
er/bldcontrol/localhostbecontroller.py<br>
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
2.7.4<br>
<br>
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
</body>
</html>

--_000_153683133652793802mentorcom_--
