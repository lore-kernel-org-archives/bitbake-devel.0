Return-Path: <falital@hotmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C49C369A7
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 07:43:45 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.55])
 by mx.groups.io with SMTP id smtpd.web10.10027.1727250217892818642
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Sep 2024 00:43:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hotmail.com header.s=selector1 header.b=BdDMeegd;
 spf=pass (domain: hotmail.com, ip: 40.92.89.55, mailfrom: falital@hotmail.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUYkiW3X+/e6/VXRcwmLvz9qcJv5G4+51LuANtVD6hYUtUqvna8ZPIicKyRnqv5JxjUHzSHX9GncPjGVMYfdMJ6PfT6yj+Km+XMAyXGMeDnQGR872TD6CtvdBXvRFriYV0bGEwBR3tv+oJJdl4e4L4gpzFnEeOdOmRXzNMPIit5mSbJVtkruGRAvCU7kiCJCisCFjSzOZMZi15cixy5h0JTmJq/VFEk2q/lngzBGHYFS6qewQu1tdnc5A6Mi/mbv1QeX7YdlrMh4TcTLnl8txxWA2P2R3oLKTBlR6+9BzFOnB2crLkGSL6CojQ9ynWlwYm363j7uJVe5vivIGUxjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66DpD3fgA5zKnt5LAwLcT8kwozf/YKTlEjulLTl8VX0=;
 b=ATd9xuQWTO0+FENIzOKvYAbT/aqTAP9W2nsaiZTIcGZJZRxNVSTSGSdytJya65XpwT+DYzEkcef0g38URS34hAhiTR+juW5ikiX1rSiSWjcs9+1QJnAxE0waiGOzUX3A8WcREtQ6TEEYYwxFtCciJb6W2m2r7yTF/kF/40s6y93dQzO2qPmRl1rIc7geM7wsftVR6wlJiW5bNCN5oV737UzjIHUs+5uB60uAApsbRDh1PQ3iAzVeBAJTH1mTHoMl4p/OKVKI2bqqYElof0ij7eHYW20lBSIbOHUf/wxt/swA/5r47hN1EScJ4XPIY6Ui8XBDGLQsS4M3Y1faegXetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66DpD3fgA5zKnt5LAwLcT8kwozf/YKTlEjulLTl8VX0=;
 b=BdDMeegdV85ZdcSamdoEeTjvR54EVZQiCWYFTXzpsZkHm70XY9di0i5D4OkECzF/40/aFcZh7GKDMIau8RM986j5xPAFD1UB/zVQtypfWhAccAvyQuTZwsftalxxgDJ6ZLh4kjoU3AiKX1CK2/7j/G6PTpmNFe2TtDdIuXSzlU5nkK7NLh0MbrhtKhjkbpL21oaBeSZXBwuURtk1nQ38dhcM/9R5C0bwmIG4i8S5FF9tXXToKPSCmUga3KfGMqLnx8ex2xFv+UIEA1d3j4/24AKCTHCtj/oh/NnjFwgDJI5fTtAiyKytvX2/xGRjlADZMZNT3cyMDzO5Wu5dBWI6lA==
Received: from PRAP195MB1601.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:298::17)
 by AM8P195MB1089.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 07:43:35 +0000
Received: from PRAP195MB1601.EURP195.PROD.OUTLOOK.COM
 ([fe80::601b:ed61:5240:df8e]) by PRAP195MB1601.EURP195.PROD.OUTLOOK.COM
 ([fe80::601b:ed61:5240:df8e%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 07:43:35 +0000
From: Sawas Etairidis <falital@hotmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] tests/parse: Add ParseTest.test_unclosed_functions #bitbake
Thread-Topic: [PATCH] tests/parse: Add ParseTest.test_unclosed_functions
 #bitbake
Thread-Index: AQHbDx6gdZ7ospmGvki3nHbRZRjHYg==
Date: Wed, 25 Sep 2024 07:43:34 +0000
Message-ID: 
 <PRAP195MB16015093E4FAA49D9BE40358B4692@PRAP195MB1601.EURP195.PROD.OUTLOOK.COM>
References: 
 <PRAP195MB16012BE6C2B895ABBA59A96BB4682@PRAP195MB1601.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: 
 <PRAP195MB16012BE6C2B895ABBA59A96BB4682@PRAP195MB1601.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP195MB1601:EE_|AM8P195MB1089:EE_
x-ms-office365-filtering-correlation-id: 74f9862f-0b18-41fe-839f-08dcdd35c2bc
x-microsoft-antispam: 
 BCL:0;ARA:14566002|8060799006|461199028|7092599003|12050799009|8062599003|15080799006|19110799003|9400799024|15030799003|10035399004|3412199025|4302099013|440099028|1602099012|102099032;
x-microsoft-antispam-message-info: 
	=?iso-8859-1?Q?Pgb+XU/PxD+nZVgRZB1JhOb0qjGoDoyP6+hrvAxscFswUfzoc+qvR+Bjkz?=
 =?iso-8859-1?Q?PAbDBT6jBS82abXApU3a+ROVBAc0hUiPPmrTkWjDNmRuEURYcfJD2x+7iP?=
 =?iso-8859-1?Q?/VGrV630g/1UX2GP+YOYlg6mHVDSpPEO3nx5JoJl8pXwe7cTic1Wt0flNq?=
 =?iso-8859-1?Q?jvUCibxuA2KpJJvfhbvuZNcldMipTHkUdomzTWEgOvP3uQbhrLb61j05aM?=
 =?iso-8859-1?Q?ULB0HHVjGaYBPjXUZnz+Txwyo84ubRVJmFOmhPXDlBNTW5whxufshx7sa7?=
 =?iso-8859-1?Q?bt7KtHgkprWDmflaUSm9F+w6vwnm+mRAwLY/nAM3khSx6H6yoDsbOYkC4+?=
 =?iso-8859-1?Q?7/dO9OBdhuRNAN1wpOCaKQF3x2/+T5fFd7dIxPcyw2mKEHsYWTzh/9pTxH?=
 =?iso-8859-1?Q?7ZceOO0AuVePTmT2i4q9++lkHimhIHVNeh1CYewivV/fCa64vTbwNY2fYO?=
 =?iso-8859-1?Q?afT3KInYqC9pArrrrpiSJ8kaKH8ZgvC79XDtjNxOXUFeZlBRXpwr9hmXWN?=
 =?iso-8859-1?Q?fY1vCQmB8l5ZneMPaHTSZJ/FsDNC/YGKYFBCXH+A493nGEUFP8JhX+9wdw?=
 =?iso-8859-1?Q?+8VENfEuq1rtuQfGxv4dIcF1wjPEOcnLzEI+7UagZHcpfJdHg8Y4CnjCZq?=
 =?iso-8859-1?Q?nOfctDGbpwCo6KvwKA4ToyaINSZG8mmaO6hA3CVRzhGBycaBj5dU3qid5m?=
 =?iso-8859-1?Q?09+JWFzpbCKZ9ZY4UVFxqqiHclrfsqSR+L/IveYvfSB8UMOPA20S5mmXpA?=
 =?iso-8859-1?Q?TVM/rwURH1kdn83tbI7lI7iXEcin04jTjcCmmPkZ4yvDdQ4IvsoBuum0vX?=
 =?iso-8859-1?Q?6+PW27n7J849ViFmK6a3kJfvGbVmVbst99+eu4gXlLOGQatD7cZF3853vr?=
 =?iso-8859-1?Q?7hQbSiroBdUyBrGCGRen8S7ViJAEGyEvR28lw+6cdHAcpasi4H423cA/zs?=
 =?iso-8859-1?Q?9BT0B9u959uGjUnpXu87pXfw7ZmKwctUMCoJ4W1xd2mR1y4dy16OJw=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?hPvLNoPC6Mhau0gw9ohOgIR+ejyMZBj0OHoPkGiKslyJRW79CkRvBjbwhm?=
 =?iso-8859-1?Q?YKgQKBIfHgLr5TFZqAgvu/jebqw9s0omnFXEBnoNjlV83kIXAD6GF7MRiK?=
 =?iso-8859-1?Q?+KDJEDc3GjUM4yp7wnyLjhg63IPCWFuSaPmVTiAE+kfFOmQaUAr5q1fimy?=
 =?iso-8859-1?Q?DqI7Oc3Cs6670tUKD3lPzxIZ7fLtviCX+HZFTLSENW511hvHH/B5zu/eVy?=
 =?iso-8859-1?Q?Daty0QoQPvDLR1j9XCL92eNszglUR+n/ek3F4Yzl349y+AiKmWWAYN3LzV?=
 =?iso-8859-1?Q?DkXSHHGp7wFFg2dHPS+qbiSaoTX6fc/ZDX3g2wf8K/ozYit8KjKG4CjuUg?=
 =?iso-8859-1?Q?kYSHAJyTLQr1tijUazjlYtZccZi3hhrvc+zFctv/LkMTutxHigQ2r25ZXq?=
 =?iso-8859-1?Q?r5RGmMoNTX9kJJYVfI7u2iqzPO22dzJS9l+r0I8XqA9D6yl3xXu63LiYU1?=
 =?iso-8859-1?Q?kXeMGOsKio9oxShH6lnuKYPNVEAfiEnLlSn5e9N6CBdwemdjQvytrAbnbQ?=
 =?iso-8859-1?Q?wzwG6fCiRuSOsLXRCNSnnDthC6Fm9C/X95fB/y3sXcDP2SdnFDlpgXP6fl?=
 =?iso-8859-1?Q?CDuCgHAf+wPoSHtcS1k/19OFz01LRREepFCNCAlpFEOZinFqmcPNwe6pzs?=
 =?iso-8859-1?Q?BFn2FtMJE5LqV0LVtPFX1y6dAbfMjQFnHS+2mI22F+paAk3e/Rhm+7r7De?=
 =?iso-8859-1?Q?ytBqWoVcXO1OTXNJ8hyib3WAQEqMaG7SjmamS8DLDy5xM6vBy22X/4vgQI?=
 =?iso-8859-1?Q?nTEaaGMHsyeDKzWKrIlmblFryfQerYUsJTbRCwb5bEkrBJadALIajeA6OM?=
 =?iso-8859-1?Q?0fNyaRncKQNv8qNq+sdLNoQzikveqWMrTbJUo3013452MT8Z8szO+Vtgq2?=
 =?iso-8859-1?Q?AVVm48e2TPeJuv+axN8oxV5T5cd0hAH3LTsEJaNsAVvOscTtdo06GDscjH?=
 =?iso-8859-1?Q?OxOrVmwJIBS7ge36AL3x+ziBKkVE7opsnwpuw+GEt+Q4ZkdtnM/q+OKT37?=
 =?iso-8859-1?Q?1wyUhdUTAgJqxLeM2lFkyKUrAuqo4mp5NcQnZLxE/JET1vMQd/klV53ZgS?=
 =?iso-8859-1?Q?QF6c5TY9a2I1fJ77/95jzmc7c89o8VWd6//RiQ3OfAkK7UAtP1OV/R4hO4?=
 =?iso-8859-1?Q?JE7Lhl3YKp2KfeLIqBtUMzneZslRlGmnggQor6MVk0u9WbCjdAgTRxYCVd?=
 =?iso-8859-1?Q?MXKgt3sopg/49fH1nooBvSo5sgs8jJeovrBzjJ/7JRA/7ltFpejowVyUdU?=
 =?iso-8859-1?Q?7lxbPOVINO2srl1tB5OcxFv4fZ4A0RnTm7XSfA6tI=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PRAP195MB16015093E4FAA49D9BE40358B4692PRAP195MB1601EURP_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-1ed92.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP195MB1601.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f9862f-0b18-41fe-839f-08dcdd35c2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 07:43:34.9813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB1089
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Sep 2024 07:43:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16599

--_000_PRAP195MB16015093E4FAA49D9BE40358B4692PRAP195MB1601EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This test covers the handling of unclosed functions.
It tests that both whitespace and tabs generate the
correct exception if added before a closing bracket.
Additionally that a residue blocks generates a error
is tested as well.

[YOCTO #15470]

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15470

Signed-off-by: Savvas Etairidis <falital@hotmail.com>
---
 lib/bb/tests/parse.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 410679d5a..148355944 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -348,3 +348,45 @@ EXPORT_FUNCTIONS do_compile do_compilepython
             self.assertIn("else", d.getVar("do_compilepython"))
             check_function_flags(d)

+    export_function_unclosed_tab =3D """
+do_compile () {
+       bb.note("Something")
+\t}
+"""
+    export_function_unclosed_space =3D """
+do_compile () {
+       bb.note("Something")
+ }
+"""
+    export_function_residue =3D """
+do_compile () {
+       bb.note("Something")
+}
+
+include \\
+"""
+
+    def test_unclosed_functions(self):
+        def test_helper(content, expected_error):
+            with tempfile.TemporaryDirectory() as tempdir:
+                recipename =3D tempdir + "/recipe_unclosed.bb"
+                with open(recipename, "w") as f:
+                    f.write(content)
+                    f.flush()
+                os.chdir(tempdir)
+                with self.assertRaises(bb.parse.ParseError) as error:
+                    bb.parse.handle(recipename, bb.data.createCopy(self.d)=
)
+                self.assertIn(expected_error, str(error.exception))
+
+        with tempfile.TemporaryDirectory() as tempdir:
+            test_helper(self.export_function_unclosed_tab, "Unparsed lines=
 from unclosed function")
+            test_helper(self.export_function_unclosed_space, "Unparsed lin=
es from unclosed function")
+            test_helper(self.export_function_residue, "Unparsed lines")
+
+            recipename_closed =3D tempdir + "/recipe_closed.bb"
+            with open(recipename_closed, "w") as in_file:
+                lines =3D self.export_function_unclosed_tab.split("\n")
+                lines[3] =3D "}"
+                in_file.write("\n".join(lines))
+                in_file.flush()
+            bb.parse.handle(recipename_closed, bb.data.createCopy(self.d))
--
2.34.1


--_000_PRAP195MB16015093E4FAA49D9BE40358B4692PRAP195MB1601EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
This test covers the handling of unclosed functions.</div>
<div style=3D"font-size: 11pt;">It tests that both whitespace and tabs gene=
rate the<br>
correct exception if added before a closing bracket.<br>
Additionally that a residue blocks generates a error<br>
is tested as well.<br>
<br>
[YOCTO #15470]<br>
<br>
[1] <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15470" i=
d=3D"OWAff7fbea2-ef76-e5df-c587-c171ce9d255c" class=3D"OWAAutoLink" data-au=
th=3D"NotApplicable">
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15470</a><br>
<br>
Signed-off-by: Savvas Etairidis &lt;falital@hotmail.com&gt;<br>
---<br>
&nbsp;lib/bb/tests/parse.py | 42 ++++++++++++++++++++++++++++++++++++++++++=
<br>
&nbsp;1 file changed, 42 insertions(+)<br>
<br>
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py<br>
index 410679d5a..148355944 100644<br>
--- a/lib/bb/tests/parse.py<br>
+++ b/lib/bb/tests/parse.py<br>
@@ -348,3 +348,45 @@ EXPORT_FUNCTIONS do_compile do_compilepython<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se=
lf.assertIn(&quot;else&quot;, d.getVar(&quot;do_compilepython&quot;))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch=
eck_function_flags(d)<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; export_function_unclosed_tab =3D &quot;&quot;&quot;<br>
+do_compile () {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.note(&quot;Something&quot;)<br>
+\t}<br>
+&quot;&quot;&quot;<br>
+&nbsp;&nbsp;&nbsp; export_function_unclosed_space =3D &quot;&quot;&quot;<b=
r>
+do_compile () {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.note(&quot;Something&quot;)<br>
+ }<br>
+&quot;&quot;&quot;<br>
+&nbsp;&nbsp;&nbsp; export_function_residue =3D &quot;&quot;&quot;<br>
+do_compile () {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.note(&quot;Something&quot;)<br>
+}<br>
+<br>
+include \\<br>
+&quot;&quot;&quot;<br>
+<br>
+&nbsp;&nbsp;&nbsp; def test_unclosed_functions(self):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def test_helper(content, expect=
ed_error):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with te=
mpfile.TemporaryDirectory() as tempdir:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; recipename =3D tempdir + &quot;/recipe_unclosed.bb&quot;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; with open(recipename, &quot;w&quot;) as f:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f.write(content)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f.flush()<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; os.chdir(tempdir)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; with self.assertRaises(bb.parse.ParseError) as error:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.parse.handle(recipename, bb.dat=
a.createCopy(self.d))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; self.assertIn(expected_error, str(error.exception))<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with tempfile.TemporaryDirector=
y() as tempdir:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_he=
lper(self.export_function_unclosed_tab, &quot;Unparsed lines from unclosed =
function&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_he=
lper(self.export_function_unclosed_space, &quot;Unparsed lines from unclose=
d function&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_he=
lper(self.export_function_residue, &quot;Unparsed lines&quot;)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recipen=
ame_closed =3D tempdir + &quot;/recipe_closed.bb&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with op=
en(recipename_closed, &quot;w&quot;) as in_file:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; lines =3D self.export_function_unclosed_tab.split(&quot;\n=
&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; lines[3] =3D &quot;}&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; in_file.write(&quot;\n&quot;.join(lines))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; in_file.flush()<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.pars=
e.handle(recipename_closed, bb.data.createCopy(self.d))<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_PRAP195MB16015093E4FAA49D9BE40358B4692PRAP195MB1601EURP_--

