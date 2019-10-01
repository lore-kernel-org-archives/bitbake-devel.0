Return-Path: <oobitots@cisco.com>
X-Greylist: delayed 425 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 01 Oct 2019 11:30:42 UTC
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	by mail.openembedded.org (Postfix) with ESMTP id DC6637F26A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Oct 2019 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=cisco.com; i=@cisco.com; l=6244; q=dns/txt; s=iport;
	t=1569929444; x=1571139044;
	h=from:to:cc:subject:date:message-id:mime-version;
	bh=CnY/R7OqgQBGD5unou23Ni9WgMo8UXMx/UzViU/WVqE=;
	b=HvLgRchqQf7reYuMzrnfGXuu394Pp3OYr2PnXUrko00HGxFG2d4r/U1H
	1CEmTNLL17cnNCiEoHUUiZEbZcmSgOn44UJJK70RJIokZMgdzS11m30sK
	kbl6LexuFLDgDEFYEGtF1nO7rpsISzIy0hbuhkUCtQa0GnnxcQvmpuoqW w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B7AAAbNpNd/4sNJK1mGwEBAQEDAQE?=
	=?us-ascii?q?BDAMBAQGBVgMBAQELAYEbgQKBcjSaEQEBjiCICQkBAQEMAQEvAQGEQIIwIzc?=
	=?us-ascii?q?GDgIDCQEBBAEBAQIBBQRthS4LhXlSEgEpNCMfCAQOIIQlba4AgXQzikGBNAG?=
	=?us-ascii?q?MDRiBf48KBIxahhOCJYEDlxAKHYIFlREbmTmOI5kpAhEVgTI2IyqBLnAVgyh?=
	=?us-ascii?q?PEBSBWhiOI0OQe4EjAQE?=
X-IronPort-AV: E=Sophos;i="5.64,571,1559520000"; 
	d="scan'208,217";a="640053530"
Received: from alln-core-6.cisco.com ([173.36.13.139])
	by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
	01 Oct 2019 11:23:37 +0000
Received: from XCH-RTP-004.cisco.com (xch-rtp-004.cisco.com [64.101.220.144])
	by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id
	x91BNbnw005031
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Tue, 1 Oct 2019 11:23:37 GMT
Received: from xch-rtp-004.cisco.com (64.101.220.144) by XCH-RTP-004.cisco.com
	(64.101.220.144) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Tue, 1 Oct 2019 07:23:36 -0400
Received: from xch-rtp-004.cisco.com ([64.101.220.144]) by
	XCH-RTP-004.cisco.com ([64.101.220.144]) with mapi id 15.00.1473.003;
	Tue, 1 Oct 2019 07:23:36 -0400
From: "Oleksiy Obitotskyi -X (oobitots - GLOBALLOGIC INC@Cisco)" <oobitots@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: nativesdk dependencies on shared packages
Thread-Index: AQHVeEK7FV2xM6uL60KN9SR+VGk6vw==
Date: Tue, 1 Oct 2019 11:23:36 +0000
Message-ID: <1569929018481.70045@cisco.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.63.15.140]
MIME-Version: 1.0
X-Outbound-SMTP-Client: 64.101.220.144, xch-rtp-004.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Cc: "Taras Kondratiuk \(takondra\)" <takondra@cisco.com>,
	"Ruslan Bilovol -X \(rbilovol - GLOBALLOGIC INC at Cisco\)"
	<rbilovol@cisco.com>
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
X-List-Received-Date: Tue, 01 Oct 2019 11:30:43 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_156992901848170045ciscocom_"

--_000_156992901848170045ciscocom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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

--_000_156992901848170045ciscocom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} P{margin-top:0;margin-bottom:0;}--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
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
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"># $BASELIB=
</span><br style=3D"font-family: &quot;Courier New&quot;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">#&nbsp;&nb=
sp; set &lt;&gt;/openembedded-core/meta/conf/bitbake.conf:12</span><br styl=
e=3D"font-family: &quot;Courier New&quot;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">#&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;lib&quot;</span><br style=3D"font-family: &quot;Couri=
er New&quot;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"># pre-expa=
nsion value:</span><br style=3D"font-family: &quot;Courier New&quot;, monos=
pace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">#&nbsp;&nb=
sp; &quot;lib&quot;</span><br style=3D"font-family: &quot;Courier New&quot;=
, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">BASELIB=3D=
&quot;lib&quot;</span><br style=3D"font-family: &quot;Courier New&quot;, mo=
nospace;">
<br style=3D"font-family: &quot;Courier New&quot;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"># $BASELIB=
 [2 operations]</span><br style=3D"font-family: &quot;Courier New&quot;, mo=
nospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">#&nbsp;&nb=
sp; set &lt;&gt;/openembedded-core/meta/conf/bitbake.conf:12</span><br styl=
e=3D"font-family: &quot;Courier New&quot;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">#&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;lib&quot;</span><br style=3D"font-family: &quot;Couri=
er New&quot;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">#&nbsp;&nb=
sp; set &lt;&gt;/x86-64-platforms.inc:22</span><br style=3D"font-family: &q=
uot;Courier New&quot;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">#&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;lib64&quot;</span><br style=3D"font-family: &quot;Cou=
rier New&quot;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"># pre-expa=
nsion value:</span><br style=3D"font-family: &quot;Courier New&quot;, monos=
pace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">#&nbsp;&nb=
sp; &quot;lib64&quot;</span><br style=3D"font-family: &quot;Courier New&quo=
t;, monospace;">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">BASELIB=3D=
&quot;lib64&quot;</span><br>
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
</body>
</html>

--_000_156992901848170045ciscocom_--
