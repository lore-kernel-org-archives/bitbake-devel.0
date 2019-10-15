Return-Path: <oobitots@cisco.com>
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	by mail.openembedded.org (Postfix) with ESMTP id E0BF47C85D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Oct 2019 09:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=cisco.com; i=@cisco.com; l=8612; q=dns/txt; s=iport;
	t=1571130086; x=1572339686;
	h=from:to:subject:date:message-id:references:in-reply-to:
	mime-version; bh=DbzLsN1+/ro5hIXit2epx8brCx/DmQvsvwxPwgQpciA=;
	b=VvyiGrSsg4o/ws3NKVytr8QoZFNGgOwLMZgDpJd3caZUqRQpw2SmBR8p
	LZVQUb28ynxeZs1/+jM3T/vBvvqk8HWymsKi8C5ru1UjjI3O+zxZjTbxy
	nEY97CwWMIlSJQHIJcJnvr4KlL0WP7yTx9nPCCO8+Ew7RQJZ6BWSuMiQh 8=;
X-Files: ATT00001.txt : 182
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CeBACEiqVd/4MNJK1mHAEBAQEBBwE?=
	=?us-ascii?q?BEQEEBAEBgXuBHAGBA2yBBioKknyCD4R5jiSICgIHAQEBDAEBGAEKDAEBg3t?=
	=?us-ascii?q?FAoJmJDgTAgMJAQEEAQEBAgEFBG2FLQELhUsBAQEBAwEBJUcbAgEZBAEBCiU?=
	=?us-ascii?q?CDRgBCh0CBgIEEw4NgwiCdw+tZ4F0M4VNhGgQgTSMDhiBf4dCAQSBPgEBhgo?=
	=?us-ascii?q?EjGOGGYIqgQQOlxIKHYIFg0SCMIEWiGqFJxuDLJYVjjGII5EYAhEVgTI3Iiq?=
	=?us-ascii?q?BLnAVO4JsCUcQFIFaGIhkhT9DMY8EgSKBIwEB?=
X-IronPort-AV: E=Sophos;i="5.67,298,1566864000"; 
	d="txt'?scan'208,217";a="559320085"
Received: from alln-core-1.cisco.com ([173.36.13.131])
	by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
	15 Oct 2019 09:01:25 +0000
Received: from XCH-RTP-004.cisco.com (xch-rtp-004.cisco.com [64.101.220.144])
	by alln-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id
	x9F91OFP014005
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Oct 2019 09:01:25 GMT
Received: from xch-rtp-004.cisco.com (64.101.220.144) by XCH-RTP-004.cisco.com
	(64.101.220.144) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Tue, 15 Oct 2019 05:01:24 -0400
Received: from xch-rtp-004.cisco.com ([64.101.220.144]) by
	XCH-RTP-004.cisco.com ([64.101.220.144]) with mapi id 15.00.1473.003;
	Tue, 15 Oct 2019 05:01:24 -0400
From: "Oleksiy Obitotskyi -X (oobitots - GLOBALLOGIC INC@Cisco)" <oobitots@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: nativesdk dependencies on shared packages
Thread-Index: AQHVeEK7FV2xM6uL60KN9SR+VGk6v6dbfPWs
Date: Tue, 15 Oct 2019 09:01:24 +0000
Message-ID: <1571130084095.4900@cisco.com>
References: <1569929018481.70045@cisco.com>
In-Reply-To: <1569929018481.70045@cisco.com>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.63.114.240]
MIME-Version: 1.0
X-Outbound-SMTP-Client: 64.101.220.144, xch-rtp-004.cisco.com
X-Outbound-Node: alln-core-1.cisco.com
Subject: nativesdk dependencies on shared packages
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
X-List-Received-Date: Tue, 15 Oct 2019 09:01:25 -0000
X-Groupsio-MsgNum: 10619
Content-Language: en-US
Content-Type: multipart/mixed; boundary="_004_15711300840954900ciscocom_"

--_004_15711300840954900ciscocom_
Content-Type: multipart/alternative;
	boundary="_000_15711300840954900ciscocom_"

--_000_15711300840954900ciscocom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


In case previous mail was omitted.


Regards,

Oleksiy

________________________________
From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-bounces@l=
ists.openembedded.org> on behalf of Oleksiy Obitotskyi -X (oobitots - GLOBA=
LLOGIC INC at Cisco) via bitbake-devel <bitbake-devel@lists.openembedded.or=
g>
Sent: Tuesday, October 1, 2019 14:23
To: bitbake-devel@lists.openembedded.org
Cc: Taras Kondratiuk (takondra); Ruslan Bilovol -X (rbilovol - GLOBALLOGIC =
INC at Cisco)
Subject: [bitbake-devel] nativesdk dependencies on shared packages


Hi,


We have situation when MACHINE value change affect nativesdk packages (thud=
 but the same situation was on krogoth).

MACHINE=3D"x86" bitbake nativesdk-<package> -> build package and dependenci=
es x86
MACHINE=3D"x86-64" bitbake nativesdk-<package> -> build package and depende=
ncies for x86-64
and finally
MACHINE=3D"x86" bitbake nativesdk-<cpackage> -> a lot of setscene functons =
executed for nativesdk packages

MACHINE value affects BASELIB. For x86-64 we override BASELIB =3D lib64.
For x86 BASELIB =3D lib. baselib for cross/natviesdk ramains unchanged (lib=
).

# $BASELIB
#   set <>/openembedded-core/meta/conf/bitbake.conf:12
#     "lib"
# pre-expansion value:
#   "lib"
BASELIB=3D"lib"

# $BASELIB [2 operations]
#   set <>/openembedded-core/meta/conf/bitbake.conf:12
#     "lib"
#   set <>/x86-64-platforms.inc:22
#     "lib64"
# pre-expansion value:
#   "lib64"
BASELIB=3D"lib64"

Tracking dependencies shows that nativesdk-<package> depends on gcc-crosssd=
k which depend on
shared gcc-source package. And gcc-source tasks hash values (starting from =
from gcc-source.do_patch) are different for
x86 and x86-64 (due to baselib), so nativesdk-<package> task stamp signatur=
e deps part depends on gcc-source tasks hash

and also become different if we change MACHINE.


Technically  it can be fixed with tweaking sstate_rundepfilter - but it's n=
ot generic solution.

Is there any way to avoid rebuilding nativesdk packages that depend on shar=
ed packages (e.g. gcc-source)?


Regards,

Oleksiy

--_000_15711300840954900ciscocom_
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
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi,</p>
<p><br>
</p>
<p>In case previous mail was omitted.<br>
</p>
<p><br>
</p>
<p>Regards,</p>
<p>Oleksiy<br>
</p>
<div dir=3D"ltr" style=3D"font-size:12pt; color:#000000; background-color:#=
FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> bitbake-devel-bounc=
es@lists.openembedded.org &lt;bitbake-devel-bounces@lists.openembedded.org&=
gt; on behalf of Oleksiy Obitotskyi -X (oobitots -
 GLOBALLOGIC INC at Cisco) via bitbake-devel &lt;bitbake-devel@lists.openem=
bedded.org&gt;<br>
<b>Sent:</b> Tuesday, October 1, 2019 14:23<br>
<b>To:</b> bitbake-devel@lists.openembedded.org<br>
<b>Cc:</b> Taras Kondratiuk (takondra); Ruslan Bilovol -X (rbilovol - GLOBA=
LLOGIC INC at Cisco)<br>
<b>Subject:</b> [bitbake-devel] nativesdk dependencies on shared packages</=
font>
<div>&nbsp;</div>
</div>
<div>
<p>Hi,</p>
<p><br>
</p>
<p>We have situation when MACHINE value change affect nativesdk packages (t=
hud but the same situation was on krogoth).<br>
<br>
MACHINE=3D&quot;x86&quot; bitbake nativesdk-&lt;package&gt; -&gt; build pac=
kage and dependencies x86<br>
MACHINE=3D&quot;x86-64&quot; bitbake nativesdk-&lt;package&gt; -&gt; build =
package and dependencies for x86-64<br>
and finally<br>
MACHINE=3D&quot;x86&quot; bitbake nativesdk-&lt;cpackage&gt; -&gt; a lot of=
 setscene functons executed for nativesdk packages<br>
<br>
MACHINE value affects BASELIB. For x86-64 we override BASELIB =3D lib64.<br=
>
For x86 BASELIB =3D lib. baselib for cross/natviesdk ramains unchanged (lib=
).<br>
<br>
<span style=3D"font-family:&quot;Courier New&quot;,monospace"># $BASELIB</s=
pan><br style=3D"font-family:&quot;Courier New&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">#&nbsp;&nbsp;=
 set &lt;&gt;/openembedded-core/meta/conf/bitbake.conf:12</span><br style=
=3D"font-family:&quot;Courier New&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">#&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;lib&quot;</span><br style=3D"font-family:&quot;Courier N=
ew&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace"># pre-expansi=
on value:</span><br style=3D"font-family:&quot;Courier New&quot;,monospace"=
>
<span style=3D"font-family:&quot;Courier New&quot;,monospace">#&nbsp;&nbsp;=
 &quot;lib&quot;</span><br style=3D"font-family:&quot;Courier New&quot;,mon=
ospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">BASELIB=3D&qu=
ot;lib&quot;</span><br style=3D"font-family:&quot;Courier New&quot;,monospa=
ce">
<br style=3D"font-family:&quot;Courier New&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace"># $BASELIB [2=
 operations]</span><br style=3D"font-family:&quot;Courier New&quot;,monospa=
ce">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">#&nbsp;&nbsp;=
 set &lt;&gt;/openembedded-core/meta/conf/bitbake.conf:12</span><br style=
=3D"font-family:&quot;Courier New&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">#&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;lib&quot;</span><br style=3D"font-family:&quot;Courier N=
ew&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">#&nbsp;&nbsp;=
 set &lt;&gt;/x86-64-platforms.inc:22</span><br style=3D"font-family:&quot;=
Courier New&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">#&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;lib64&quot;</span><br style=3D"font-family:&quot;Courier=
 New&quot;,monospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace"># pre-expansi=
on value:</span><br style=3D"font-family:&quot;Courier New&quot;,monospace"=
>
<span style=3D"font-family:&quot;Courier New&quot;,monospace">#&nbsp;&nbsp;=
 &quot;lib64&quot;</span><br style=3D"font-family:&quot;Courier New&quot;,m=
onospace">
<span style=3D"font-family:&quot;Courier New&quot;,monospace">BASELIB=3D&qu=
ot;lib64&quot;</span><br>
<br>
Tracking dependencies shows that nativesdk-&lt;package&gt; depends on gcc-c=
rosssdk which depend on<br>
shared gcc-source package. And gcc-source tasks hash values (starting from =
from gcc-source.do_patch) are different for<br>
x86 and x86-64 (due to baselib), so nativesdk-&lt;package&gt; task stamp si=
gnature deps part depends on gcc-source tasks hash
</p>
<p>and also become different if we change MACHINE.<br>
</p>
<p><br>
</p>
<p>Technically&nbsp; it can be fixed with tweaking sstate_rundepfilter - bu=
t it's not generic solution.<br>
</p>
<p><br>
Is there any way to avoid rebuilding nativesdk packages that depend on shar=
ed packages (e.g. gcc-source)?</p>
<p><br>
</p>
<p>Regards,</p>
<p>Oleksiy<br>
</p>
</div>
</div>
</body>
</html>

--_000_15711300840954900ciscocom_--

--_004_15711300840954900ciscocom_
Content-Type: text/plain; name="ATT00001.txt"
Content-Description: ATT00001.txt
Content-Disposition: attachment; filename="ATT00001.txt"; size=182;
	creation-date="Tue, 01 Oct 2019 11:30:59 GMT";
	modification-date="Tue, 01 Oct 2019 11:30:59 GMT"
Content-ID: <7DA3C241215D9E49B5112AA7532E2E93@emea.cisco.com>
Content-Transfer-Encoding: base64

LS0gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYml0
YmFrZS1kZXZlbCBtYWlsaW5nIGxpc3QNCmJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVk
Lm9yZw0KaHR0cDovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvbWFpbG1hbi9saXN0aW5mby9iaXRi
YWtlLWRldmVsDQo=

--_004_15711300840954900ciscocom_--
