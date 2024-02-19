Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867CEC48BF6
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 00:38:26 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.80])
 by mx.groups.io with SMTP id smtpd.web10.31109.1708303099666819519
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 16:38:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=fO/4VGws;
 spf=pass (domain: axis.com, ip: 40.107.6.80, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnBS5sOHVPwQAknTQ+417R19rjpFWPPvvLOqnlhejvBv3gaZptssnsSMV7v0yMtZg6fgaW4giG3awEbInP0TTeVqkxHSHYrPI4DP4fFPmOrQpfhHEO/CNV2VI628Trrra0Zh8ayCbAldah7MDutJ20NAZUSZlZAci1Kl9nyC/TqulGIjfysuW5uJtJtbHwbPnAbVTN3mmMXBMOspFQVJSoO5tUtwr3iI4A2rIXH7CRRKbtN6MBy67UfBRuKMCa8BZ9myqDiKgQ0CvG5lfzFldYOyyPrMYWf62Q409iZnfcGlhH7sq7oOTA29oqjCC+rWXdRpPDYZMYz1Ai0pTX/W+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QzPOaYrfCdKr8ZwmBigzIxXvXPv3kM1YcJvx767B6c=;
 b=ERXFhedPh70YJkQ9qBj1qmYL0NGfZZO0PwBJuYbtljkM4s96OTb9QdWboSITS5MguEXwqZ/OYNNtfobPaSQa1P4yPf/MWwLSPzXRQmf+IRyLI+Lv6+QRHp08fPLxDNDivti31eZwg1EPmR5Nb5b1rpoej9ybj1aQ68j0TyV3BBtXMIC5Tl3qScet6cHjiRLEfSR1h71YmZNPaaUwvhTf9Uj2Nv3lD4ulzrGYtC5OYZkHOxHqqtYlzQYbKaPQXMeTgMf/KdoNRocjOHvniVinJ8kmeT2LGnV16IGA5dGLpQNVmvMZ01RtqLgYWcQZ9PqsSx5u5v69CCto7aTfnppsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QzPOaYrfCdKr8ZwmBigzIxXvXPv3kM1YcJvx767B6c=;
 b=fO/4VGws3Da1+1LXJKMPgkJ8PNdutV2V6I32LQ+5NiwT4HYrCtg+e3zquLiysS7JlYXSciY/6+m3ThqzzW81wawAOFVbE2x2418Uu6UKS28tbouZ9CMGBYX1UJ1AFYL6ribfW22b/xPdJeXYPfAU4pnB6GFZtc1MMnTfeC99FCI=
Received: from AS9PR05CA0091.eurprd05.prod.outlook.com (2603:10a6:20b:498::6)
 by VI1PR02MB6094.eurprd02.prod.outlook.com (2603:10a6:800:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 00:38:14 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:498:cafe::2c) by AS9PR05CA0091.outlook.office365.com
 (2603:10a6:20b:498::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Mon, 19 Feb 2024 00:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 00:38:14 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Feb
 2024 01:38:13 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 19 Feb 2024 01:38:13 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id A577D14940
	for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:38:13 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 41J0cDbo3024900
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:38:13 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 41J0cDUr3024899
	for bitbake-devel@lists.openembedded.org; Mon, 19 Feb 2024 01:38:13 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/3] tests/fetch: Make test_git_latest_versionstring support a max version
Date: Mon, 19 Feb 2024 01:38:03 +0100
Message-ID: <20240219003805.3024867-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|VI1PR02MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8416a950-fc6c-4481-f649-08dc30e30ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tue9qinY1J5DJqDSVIrFVNr8N8ZMXtiIE2aaLrwRTARqJX3RbT6Es+LtO6jYFuH7u5LLGnSVXv4xx9tPQ5PPMb5RKz+lmKpVHim5hSGmFRzpG2f70bfVMGSBwH0jBGVDMibUbOB7W/XUqiMr/htUVkeUDbikr/9xDEvKUkimWfQP1le+v4UAP+R0L9ZF0lAnQ7T8i+JRHXEFB8gaJ7L8kbdBGUBq0t7j77qt8LSxKJi/BDhecyM+mGDj1uD1csBZWWuBgI2op/U2O+/t0whgDJMhtewb+CfJYAHr2+tZWjJDUmUW7u1xe69SvywzSx43vC76q+wAS2g9ETcOAUX5n9Llrq123fQhSwgnSKLgtzeAqvgbNa3c2CXfnjEo2Gx2mNzOR8gg8g6KNHyE1f878VK8djeGGHAtB+jJ4raFR7psYWNh3r13/EYQ5XawgzVF7LkiH20/3JIlZ03Ar7QvBB3PzG+pnVweAzAh7txmXRsCYiBh78xteKs9X8fgH2RfOW6E028f/FouMptvN+owM3UWaYfaSp2IQqBsyiT4IdESzRXigNViJwbLzLhHOMwcHjjwwy60JruYIDXTsVPMyjNx5ZlGFVwWNz9+9KnSsBCdhi5obdfk66yEMTryIt24TYiFyqNF8SffRzhNB8yzCTAAelv5o/LudrBNoDPlT8k=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39840400004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36860700004)(46966006)(5660300002)(2906002)(2616005)(36756003)(26005)(1076003)(478600001)(81166007)(356005)(83380400001)(336012)(426003)(70206006)(8936002)(70586007)(8676002)(6916009)(41300700001)(42186006)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 00:38:14.0791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8416a950-fc6c-4481-f649-08dc30e30ea3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6094
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 00:38:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15932

In some cases, the version found by latest_versionstring() may be higher
than the real version. Make it possible to specify a maximum version so
that this case can be detected.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 41e1d8cf10..7e7f26d003 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1370,36 +1370,36 @@ class FetchLatestVersionTest(FetcherTest):
=20
     test_git_uris =3D {
         # version pattern "X.Y.Z"
-        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=3Dmx-1.=
4;protocol=3Dhttps", "9b1db6b8060bd00b121a692f942404a24ae2960f", "")
+        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=3Dmx-1.=
4;protocol=3Dhttps", "9b1db6b8060bd00b121a692f942404a24ae2960f", "", "")
             : "1.99.4",
         # version pattern "vX.Y"
         # mirror of git.infradead.org since network issues interfered with=
 testing
-        ("mtd-utils", "git://git.yoctoproject.org/mtd-utils.git;branch=3Dm=
aster;protocol=3Dhttps", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "")
+        ("mtd-utils", "git://git.yoctoproject.org/mtd-utils.git;branch=3Dm=
aster;protocol=3Dhttps", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "", ""=
)
             : "1.5.0",
         # version pattern "pkg_name-X.Y"
         # mirror of git://anongit.freedesktop.org/git/xorg/proto/presentpr=
oto since network issues interfered with testing
-        ("presentproto", "git://git.yoctoproject.org/bbfetchtests-presentp=
roto;branch=3Dmaster;protocol=3Dhttps", "24f3a56e541b0a9e6c6ee76081f441221a=
120ef9", "")
+        ("presentproto", "git://git.yoctoproject.org/bbfetchtests-presentp=
roto;branch=3Dmaster;protocol=3Dhttps", "24f3a56e541b0a9e6c6ee76081f441221a=
120ef9", "", "")
             : "1.0",
         # version pattern "pkg_name-vX.Y.Z"
-        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=3D=
master;protocol=3Dhttps", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "")
+        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=3D=
master;protocol=3Dhttps", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", "=
")
             : "1.4.0",
         # combination version pattern
-        ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=3Dh=
ttps;branch=3Dmaster", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
+        ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=3Dh=
ttps;branch=3Dmaster", "cd44ee6644c3641507fb53b8a2a69137f2971219", "", "")
             : "1.2.0",
-        ("u-boot-mkimage", "git://git.denx.de/u-boot.git;branch=3Dmaster;p=
rotocol=3Dgit", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "")
+        ("u-boot-mkimage", "git://git.denx.de/u-boot.git;branch=3Dmaster;p=
rotocol=3Dgit", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
             : "2014.01",
         # version pattern "yyyymmdd"
-        ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/m=
obile-broadband-provider-info.git;protocol=3Dhttps;branch=3Dmaster", "4ed19=
e11c2975105b71b956440acdb25d46a347d", "")
+        ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/m=
obile-broadband-provider-info.git;protocol=3Dhttps;branch=3Dmaster", "4ed19=
e11c2975105b71b956440acdb25d46a347d", "", "")
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
                 # mirror of git://anongit.freedesktop.org/xorg/driver/xf86=
-video-omap since network issues interfered with testing
-        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-=
video-omap;branch=3Dmaster;protocol=3Dhttps", "ae0394e687f1a77e966cf72f895d=
a91840dffb8f", r"(?P<pver>(\d+\.(\d\.?)*))")
+        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-=
video-omap;branch=3Dmaster;protocol=3Dhttps", "ae0394e687f1a77e966cf72f895d=
a91840dffb8f", r"(?P<pver>(\d+\.(\d\.?)*))", "")
             : "0.4.3",
-        ("build-appliance-image", "git://git.yoctoproject.org/poky;branch=
=3Dmaster;protocol=3Dhttps", "b37dd451a52622d5b570183a81583cc34c2ff555", r"=
(?P<pver>(([0-9][\.|_]?)+[0-9]))")
+        ("build-appliance-image", "git://git.yoctoproject.org/poky;branch=
=3Dmaster;protocol=3Dhttps", "b37dd451a52622d5b570183a81583cc34c2ff555", r"=
(?P<pver>(([0-9][\.|_]?)+[0-9]))", "")
             : "11.0.0",
-        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkcon=
fig;branch=3Dsysroot;protocol=3Dhttps", "cd437ecbd8986c894442f8fce1e0061e20=
f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
+        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkcon=
fig;branch=3Dsysroot;protocol=3Dhttps", "cd437ecbd8986c894442f8fce1e0061e20=
f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))", "")
             : "1.3.59",
-        ("remake", "git://github.com/rocky/remake.git;protocol=3Dhttps;bra=
nch=3Dmaster", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\=
.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
+        ("remake", "git://github.com/rocky/remake.git;protocol=3Dhttps;bra=
nch=3Dmaster", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\=
.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))", "")
             : "3.82+dbg0.9",
     }
=20
@@ -1468,6 +1468,9 @@ class FetchLatestVersionTest(FetcherTest):
             self.assertTrue(verstring, msg=3D"Could not find upstream vers=
ion for %s" % k[0])
             r =3D bb.utils.vercmp_string(v, verstring)
             self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package %s, =
version: %s <=3D %s" % (k[0], v, verstring))
+            if k[4]:
+                r =3D bb.utils.vercmp_string(verstring, k[4])
+                self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package =
%s, version: %s <=3D %s" % (k[0], verstring, k[4]))
=20
     def test_wget_latest_versionstring(self):
         testdata =3D os.path.dirname(os.path.abspath(__file__)) + "/fetch-=
testdata"

