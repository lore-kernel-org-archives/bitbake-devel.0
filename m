Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3555AC624D7
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:58:13 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9218.1788343082701461412
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 02:58:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=PPCM2W2Q;
 spf=pass (domain: ericsson.com, ip: 40.107.162.64, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpBzMRc9NrF3UpWUDGFkJd2O2s5hY9f9b0OCfuacMYM37m0sK+RISWgRbPD8x1ebC+2iFdoabmY8Ede4XfyBS11wqBZ4PpVkArgFhdVWE6JTEyuIyWz4SJJCoRMfM/Ftn8smxJ+2/ogdNCxm4vgiN4hPRDrwnXMtngvBq6rz4Qjiw4bdmyh/XUf8zRlqyZcyLBI5PYdBsogInkPayShDqAMiZNP1qVkdfAfYs4nDBs7ECHNXBZV6zkcgfC4IgJ0LFBCDSaAaQvyUUSOVm1Eee7wsnZBqegoFX6eacgRVRKesRVNEnWn7wE5GEgVQckBguTXZZh7xuqUMElLogTQgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdIndbGZH7EkciV3sZyME1h7TPjx6C9tO2bqnpMlbak=;
 b=ZH/cWhnik5MUF1Cbi4ZN3MqxDdHsc5gWUht0QzPFuDHw3Xlq6Vi/ljMe5NS/VgB53ef1Am9ZMYj0NuDsxaIYJcM0as6P3orMsIXCmz7YB/5lxvPA4rWYN7NmMjAaSLfhYEMq8xxwfooKO8lskzGdZ6MhoYc6j5kTkwxB8qXGEw/txVKubAi5JETFm8EwRcta2x95T9qaRmemsIJyscn79B0BoaOcCFvxxTAxwkiTopYW8aKmVeIuoj81aatxn6DLZOeHdXf24aEamiWpN4YGr3FeQ0ZCluTtpNN9QJzgvjqwFXUh0ntNF+ceSnflTImnDa6B50yFl9Gp/qJtJwnFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdIndbGZH7EkciV3sZyME1h7TPjx6C9tO2bqnpMlbak=;
 b=PPCM2W2QS4C1aJ81Pi1DF/pjg0N/n51ODGEdUN3DzkhZkH1OfXIVngzLS4tO10kPAUgiHAAPzKJjunKyptKeK6vj7tpnl39MYIVsqoo34gi3KDXatw0TdB99mnVg/lTDkBaoVCfR3iA2EEZcAm0nNjsprDAsCw/yJLs9fppYOE8Y+FYy7V0dzgKQLLFRteJuUrqVLtif1rTjYONhmEc08iC2sGEyGTY8ful06AcaACC22rAEy4/paVRtqORJlTcr1k3Vy131BOpnnmuooZjAmV50776C0/T44Kxs/yprLUyPwjMhxd4h5D8Q1Ab5Zt12qZUd55j/o2ykImDNq+NmTQ==
Received: from AM0PR02CA0133.eurprd02.prod.outlook.com (2603:10a6:20b:28c::30)
 by PA4PR07MB7069.eurprd07.prod.outlook.com (2603:10a6:102:f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:57:57 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::76) by AM0PR02CA0133.outlook.office365.com
 (2603:10a6:20b:28c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 09:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:57:57 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 2 Sep 2026 11:57:57 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 7C6384020B41;
	Wed,  2 Sep 2026 11:57:56 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 59601700CF25; Wed,  2 Sep 2026 11:57:56 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chen Qi <Qi.Chen@windriver.com>, Mathieu Dubois-Briand
	<mathieu.dubois-briand@bootlin.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, Daniel Turull
	<daniel.turull@ericsson.com>
Subject: [2.18][PATCH 5/5] bb/tests/fetch.py: add case for filter_regex parameter in latest_versionstring
Date: Wed, 2 Sep 2026 11:57:38 +0200
Message-ID: <20260902095738.2840120-6-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902095738.2840120-1-daniel.turull@ericsson.com>
References: <20260902095738.2840120-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|PA4PR07MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0e59da-3f39-43e4-ee7f-08df08d8aa71
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	j7znjHfF3zFZoLLiL1QbCCRZDPZfJeymKS1xGOIk1NjAJLtQgy6bqYqqeU+3VXT8Npz7n3jp/dkJOzZS3f2ykzeVyC6F1TX9rsJ+OByQOeO7AsWErw+lphJx8fJ8Zf3JmYpkpi6JJGZygBLVPndLJ1lzbeR8k7bwMC4Y2Lvx2yeXOlUrHUPeIJG4RqSYpQHCdg69gbRV2nC2L1mUDoq2icwDGa8vzIamfDZHi2jT6K8v6Qs66MfPH8/Auj972EhV2FOQPjjvMsHsP9Ko2ze8QuBHPXN5x/ALH4XF0NrGOqzyCW6YePGH8GeSMWUcQRYzjz9C5mGbD/4wUDauugiAPCRtNEtqpdQvMTNQkYHCMqycGcKMyTnSgP4BlJMey3GqqjNed0ai4ccbfq01c9aDz1HYwxBX+aE9yx9FT9as1w5Ktn77HycsR/LaAAlTmDdrUhCeUTVZXBG/SxpnhbFhiziu4oA2Gu0CVWTSsMvxI3H2kAg6GlewR1J2XdS9QciMz2euTZpiz8DZPp8qcB22UtQNbdZkzGZm4YhQ+ldeCKRf1HGEHerbZFxF/NMAy+7y79zhOPZzcjpGbKCORlPjfZOKGRfHRW5gGFZn0iI2VpaDaMmiVXcMn1mnD18dm1Hf4lPoh+svxxJox7GtgF9nM/sA1WkpYUTEJSusXy9WaB4=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	I4Vfig/6WZt1z5zoTdjlw6j+1LplpvOdsATOSItK/0WOAnztnubSlv6dob+d/PwMazHgmTZVQ4JiDcnGvLPP5fZgwhD2U9MIQO8EYTkYWQZTRs/fUPAu/dR2JjfFSJUIRg31nYFa4yJuaoLzKKN3Nwn39vfhZhB3Y6gnOevOM25WFZfpeuv0VL8cxMUEyqOip3ZIsWAVxgyiUBB/cv+xN4jtAXYvyiXhLu/j0p1UIOcghHRQqbazPq5qqhebeFjSaqhte0iwB5qeN5Z5+r1QhFW4amwebZT2HGxYlxDHvezUT8s5tEUnxSBB4nXEXIlHa9PflgjxUWR3RccBMOkHUBiQ02GUm36XBHsx66G3GR9zOadE98DTdJciTnU3wcA0LfATTm8dhrELh+vL/QPP5u+nKfYFhixpahMvkgWO1N0yTL/9to2vUEcEtGr1+ijt
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:57:57.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0e59da-3f39-43e4-ee7f-08df08d8aa71
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7069
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 09:58:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20152

From: Chen Qi <Qi.Chen@windriver.com>

Add bitbake selftest case for fitler_regex parameter in
latest_versionstring to ensure no regression.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 63a51b543e17d44c26a82e6ca911ed23e517fc33)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 lib/bb/tests/fetch.py | 78 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c071401e6..2ebfd6680 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1577,7 +1577,24 @@ class FetchLatestVersionTest(FetcherTest):
         # basic example; version pattern "A.B.C+cargo-D.E.F"
         ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69")
             : "0.9.29"
-   }
+    }
+
+    test_git_stable_uris =3D {
+        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=3D=
master;protocol=3Dhttps", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", r=
"^1\.4\.\d+$")
+            : ("1.4.0", "1.5.0"),
+        ("systemd", "git://github.com/systemd/systemd.git;protocol=3Dhttps=
;branch=3Dstable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", =
"", r"^259\.\d+$")
+            : ("259.5", "260")
+    }
+
+    test_wget_stable_uris =3D {
+        ("openssh", "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/=
openssh-10.2p1.tar.gz", "10.2p1", "", "", r"^10\.2p\d+$")
+            : ("10.2p1", "10.3")
+    }
+
+    test_crate_stable_uris =3D {
+        ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69", r"^0\.9=
\.\d+")
+            : ("0.9.29", "0.10.0")
+    }
=20
     @skipIfNoNetwork()
     def test_git_latest_versionstring(self):
@@ -1634,6 +1651,65 @@ class FetchLatestVersionTest(FetcherTest):
                 r =3D bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package =
%s, version: %s <=3D %s" % (k[0], v, verstring))
=20
+    @skipIfNoNetwork()
+    def test_git_latest_versionstring_stable(self):
+        for k, v in self.test_git_stable_uris.items():
+            with self.subTest(pn=3Dk[0]):
+                self.d.setVar("PN", k[0])
+                self.d.setVar("SRCREV", k[2])
+                self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
+                filter_regex =3D k[4]
+                ud =3D bb.fetch2.FetchData(k[1], self.d)
+                pupver=3D ud.method.latest_versionstring(ud, self.d, filte=
r_regex=3Dfilter_regex)
+                verstring =3D pupver[0]
+                self.assertTrue(verstring, msg=3D"Could not find upstream =
version for %s" % k[0])
+                v_less_or_equal =3D v[0]
+                v_larger =3D v[1]
+                r =3D bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package =
%s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r =3D bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r =3D=3D -1, msg=3D"Package %s, version: %=
s <=3D %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_wget_latest_versionstring_stable(self):
+        for k, v in self.test_wget_stable_uris.items():
+            with self.subTest(pn=3Dk[0]):
+                self.d.setVar("PN", k[0])
+                url =3D k[1]
+                self.d.setVar("PV", k[2])
+                if k[3]:
+                    self.d.setVar("UPSTREAM_CHECK_URI", k[3])
+                if k[4]:
+                    self.d.setVar("UPSTREAM_CHECK_REGEX", k[4])
+                filter_regex =3D k[5]
+                ud =3D bb.fetch2.FetchData(url, self.d)
+                pupver=3D ud.method.latest_versionstring(ud, self.d, filte=
r_regex=3Dfilter_regex)
+                verstring =3D pupver[0]
+                self.assertTrue(verstring, msg=3D"Could not find upstream =
version for %s" % k[0])
+                v_less_or_equal =3D v[0]
+                v_larger =3D v[1]
+                r =3D bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package =
%s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r =3D bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r =3D=3D -1, msg=3D"Package %s, version: %=
s <=3D %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_crate_latest_versionstring_stable(self):
+        for k, v in self.test_crate_stable_uris.items():
+            with self.subTest(pn=3Dk[0]):
+                self.d.setVar("PN", k[0])
+                ud =3D bb.fetch2.FetchData(k[1], self.d)
+                filter_regex =3D k[2]
+                pupver =3D ud.method.latest_versionstring(ud, self.d, filt=
er_regex=3Dfilter_regex)
+                verstring =3D pupver[0]
+                self.assertTrue(verstring, msg=3D"Could not find upstream =
version for %s" % k[0])
+                v_less_or_equal =3D v[0]
+                v_larger =3D v[1]
+                r =3D bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package =
%s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r =3D bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r =3D=3D -1, msg=3D"Package %s, version: %=
s <=3D %s" % (k[0], v_larger, verstring))
+
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris =3D ["https://downloads.yoctoproject.org/releases/sato/=
sato-engine-0.1.tar.gz",
                       "https://downloads.yoctoproject.org/releases/sato/sa=
to-engine-0.2.tar.gz",

