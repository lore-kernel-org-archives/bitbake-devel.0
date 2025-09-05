Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65343CA101C
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=LwAV1Ige;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuAsfwSicwGChG3RuZdJlzHDbro9xRcuJPxOhsnRzRGsrVTmVwqfFFpS5f7QVN4V6niah1P1T7LC94fw6AREe93OXAWLtI+VyXQPfrT1Y8jfxJ7S+FLleedTWljafYg8M8Z7sLqWp06D/R1oNjg+gNDrhfKh8ZK4eRXX+6zHdH3xGmuH26lVPFH1OKUhwuH/By9L7ux6DhYEruaOXxmseKrTDLW3xUNIKe4TJzxwoHbVmKRDMdQk4ZBc8ffQghN5Bdhdt/Zey8Xv0Av00a/rYS0hwGEAT/+CU85ylQ/h5v5IIfFfUE+qqaAbotsPfQG+L72Brpcyb3Llv3FXlCMcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLs7gS948dWFxyBWKyNJAmtLoDdOQeBs2LjoOGSX5vE=;
 b=Gvn6T+rG2y6SPWj2DEAwpfwJdZgvHq/y76VM3R/BsY0sN/o1TdXqWj/Ew8kfX2DkxHLHxu1YR9cd7XoRSgANv8BPc76rFHcCEORTJtoeJOkAK7V1os8st/+NM+OFuQqusZ02ARXI+sEYmPDgXZwATNPra3xkkNEUd5fFWyg/FSB0pPGnb7bJzyQ+M3EHfr9bv7V2WZ8sdcO7pQbv79umS52kCuCGUC297HGrPm1VpP+o3LfoAcxwWGf8il8M93vsclsBIvkbbfP1eqDyzTMkl7gMDoWoAb17u+gm6qpqOSaVJL/+Pv/vADF6jjvX6PUUp6wsWgW9ayiEYG2nwH4m4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLs7gS948dWFxyBWKyNJAmtLoDdOQeBs2LjoOGSX5vE=;
 b=LwAV1IgeYQs92rKCSrkVhhZmSfk21LCS2+tCjpPeYWlEUDUGyBm7mRUSh104/TovENskMQVrv+7AV97MxhIBWBWinhyjegMWsLApm/KUlXI5vY+6JfBzgF7ylbOAgidPEBldWMMPDJ0x9iwc7DJah3/5DQHk5cj3RhoT6ddwqUvEHtQmt6CMN2c7a1SpZmXtmiIHsY5IBPvfm42tz5J5Ku5lIIqWXnxXuuHCoJdireVOjfXo+eWnL6Fh5y/8kuRgscpF0PuZhm61gyYR5VHqDB/sR9F5Dbv+KuZdfJVjE+YMdc1NdysS7Pn/ApqykAV+898gKKP4qOUhGi7kWVuHLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:14 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:14 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 09/15] fetch2: gitsm: use subdir parameter for submodule
Date: Fri,  5 Sep 2025 08:20:52 +0200
Message-ID: <20250905062058.2563806-10-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c810ee-ca10-45c7-bd78-08ddec4469c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ttsW6FPpneH6lgUn8rirjYuWgDuQHP4DUoKnk/wAQ8B5bFH2O0dIsO2y8EAJ?=
 =?us-ascii?Q?51mf8JPsyKDz6zjuPq2vEs3ZTPeZkQIisdk9J2qsU+07VTsH0vnp6WHcbStx?=
 =?us-ascii?Q?qdCER82K8ERA/zj+0kqKgPhdLHANlBeVfhrn4+NGAopBRYdpLB5qQYV6LGSj?=
 =?us-ascii?Q?g73uqufD2by2T6IIGFie45bAQ+/MNHXuMmMMPW7clxN/BUJnReNx8RPP5w9k?=
 =?us-ascii?Q?petrMw9y+7bBlA/pGMHdRnCshpHVM04JW+wh2FDjTYpBMtWiBtnQy2kiqxSn?=
 =?us-ascii?Q?D/Uy6D1yCdsHJ+LWNAuNmBKd5v2g4Gcp3tS4NIXWx0BYagqjQXILD8bBWUFM?=
 =?us-ascii?Q?f/7iDG56PORS76ZlO02RwY4Crxtspa2kF5U9ARLGIIhzXQU5sSsUviEysBJS?=
 =?us-ascii?Q?IAGKdscN0EdsWFcszMCt2ulLeF0Ra6BKLvdSiLRX3A24Sh4uNHNpAUHe0eGF?=
 =?us-ascii?Q?vTi5jVXrslsAltiGg8TyEnU/Gtbn42SZ7zx7tIBhOXPnwFdwm+Jx7vMl/NUY?=
 =?us-ascii?Q?5msA4Zg2Unp/nHZX+ooTsDuQbpI6yG5XqGcSBewBwbpWQi2iGOqXnvctAWYw?=
 =?us-ascii?Q?hdfxKMIctJqk4gYgTC+9XtDdHKROWJ5zlOxcGyldRniz/641beUCX9A3TGUN?=
 =?us-ascii?Q?EHNPkyDPov3DaWhNdxDigdCxlP0lxBkwaoUQZipnYRrFlegoUP0wzxqsHIUV?=
 =?us-ascii?Q?KyzKyzaeIUMGQp4SBAi0giFFeAA67ELyTjJf2w7Wi1X6dXatUL/zRq4T25o3?=
 =?us-ascii?Q?vajYpaKabJGO9Lv5Fr8u6hdBmk6bn9Zu1S0R/gGucNSa8lD6Bo5X68sG+EBF?=
 =?us-ascii?Q?gk7m3iw9w/voCCHmxvb9m8DDo2KS73YWAZgFrozg7+0qGPx/PIv0b8fHiA2D?=
 =?us-ascii?Q?Wm4fRlTEumZJ4xjtf5C1rxsXrf3c5EczchRsmzEIGdPZEgcOWlWzlOT2zIUO?=
 =?us-ascii?Q?YdLkaQQu+AHqXS532hOh5rLTzNaqX4eQ7rkOljZcuIqklVZEdpnxEZTCOeIF?=
 =?us-ascii?Q?/vVthJ8UbIW7vgGhAopnC0p61yrsADxgJUVWnAo0e8nb3Og+K8gtzDhxCEEF?=
 =?us-ascii?Q?rv0D2YhX9WvfNSng6wG5u8MCP7kyDxhbFt/+sDSIv22WLc+1bCBIdMcqVPPU?=
 =?us-ascii?Q?u4SMLawAcCQxV99eNcNt1RDN2yJT917mcleR/d1HYqfTD4rbykTlQFFTaG5H?=
 =?us-ascii?Q?jpHfU4HX3u102e0VaQL7nD8cw1RN67ZtcACaPtiVvtuFVraVkuvX30vMW64U?=
 =?us-ascii?Q?aGKH35+wHLXL9hc+5fTSy1BYZtadiJX0rT3lZCZKa0pPaCHbA+nRVf0P+bJn?=
 =?us-ascii?Q?7xoPBgBtha9/Abes+Y29utDyU3qKkpVJb+KuxR2yBY8Kp6gzV+4FEiUKlLhp?=
 =?us-ascii?Q?djHCrV7YXhoVJ0wWQLT1H2O6uatZ7uEph6aqoc07yJmwLE83EQxCZHfSPmLt?=
 =?us-ascii?Q?St0Lgk3NufXU1rUqTCT97c9q7EaBRzfWt4ojnv7sWGUAwV2pviEqcQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k/+PSE01de62fXpMHzxlj6wgi0rVkYaI0bSImI6Iv8U368aFC6fBO7zOmdBI?=
 =?us-ascii?Q?7lRhFO69TuJMr+Rm5z6lQ/x/FINyLUQCN6xkAzX68Txuhj08BZyc/MOKWUtA?=
 =?us-ascii?Q?/dbR/p6YE3D95BMv3+5SD1cp/+HuZrb5cJD1YP4wCgVYu/ZEDqHchA0AL3by?=
 =?us-ascii?Q?zqSlQV7Q1vxu5WKo8kqg+kCKWMSUUD906rywTI0lGrw9IfcujqoE6AaLhhtX?=
 =?us-ascii?Q?Y3wkS7xN7IXZqW4acQdZTL6AOOUWQtwsrj2srbOcwtU7xvq2zXjbl9qxQ2bD?=
 =?us-ascii?Q?It6Q35/GnzdT1WJvAUGiPSwQzgy2RVxzLbtahgh+BIO7UnMvXZjI0lucLFmZ?=
 =?us-ascii?Q?rFQoFz2bzfJYgt8TAahZwNcJGbmlNV85pyWeXK1hrXI7e8ixXElyd86c/K+v?=
 =?us-ascii?Q?YDNHZTx2rp03S83WXFDXqxEq2O6j7We+AJRssQsi6xmnGQTWAYYiEh6DfR19?=
 =?us-ascii?Q?7NM80Pa5Ioe+UsBqd11AmNemx9qrWuKqo5e7kylIPKoUEgb8zeq2dpEKoV1y?=
 =?us-ascii?Q?oW/4V2zI+ZtHNfO58PxCFdWf4FAkn14eNujA+Wev+c90D1B8AxrsBfoimtTs?=
 =?us-ascii?Q?ys4Flxf9bSCUXBZhjWXqFj3tPkfdI6+8gao5AurrHBr910NCBpPXjRJ5uHIU?=
 =?us-ascii?Q?/uiNTBr9Gy/g3glwYG+AapSEHQ+BlK2Zs91lf62o9ReWZiJv7os9UJLyiiAZ?=
 =?us-ascii?Q?PAy3VAo1uc9B0RZ9N217n/uE63HEcZjCqoNWRgHv7lZoGslA9RSAq85H2jir?=
 =?us-ascii?Q?mzGWV8qKc6z1gYbXG0qL7WOsCiFzYgE4+92q73SnTZ7IjqxpBjPdNdC3JcPj?=
 =?us-ascii?Q?cQ6DT0B5JILbl7VIO+dsiWDt3yl7Xg3+FJE+/52GzfjGdAF8juU2gN/fvB5B?=
 =?us-ascii?Q?hwkGfzRSa6q6igcGaclLHrxXc78g0I03BTRu/3ZyFXL0HQYc1zxa4JV+6NfK?=
 =?us-ascii?Q?GKId1RiMkEOarKbzPxMwgKfnWXPd/qxhhUTsp05b2EcoFvv5sIwZ8H65Jwvw?=
 =?us-ascii?Q?RnrWgJJHR8zbQsKP0Dh/NPJBFgZunyTAWFmINXu64C5iStQCnjUk31CM+nkp?=
 =?us-ascii?Q?Qa51ZZcawrD/nnbxiZUeqQwoPf+Jb8djCKcHDlXgVBQDpBdXveOUOBNIrwcw?=
 =?us-ascii?Q?i4Q4ChJFTFT16i6qDaen/Gsz9YuHm3VhDkWFW7iEjhis3ycS9wqhzdCBmLEg?=
 =?us-ascii?Q?8N56M65Pn5CBTVL57SYggzzi2n2ZBUfhunuwJHa6b9Utk0cNjzL8bxVCZy0V?=
 =?us-ascii?Q?nXH/LuQHtAXdgZEay9br5lAUmzKUuc4MHUOpRCO9EPyIkv9moPUf0gyZ8lRK?=
 =?us-ascii?Q?+QaZycZZIpTDCy9PuP8KgkjUJzukSYyA0deSL5aNhULH54kwkTol4dvVeo6l?=
 =?us-ascii?Q?oBQXFqGzqVWsWWwiGfJp/Tscgsok3NdIBnRK/ad4jAUvW9DwWI39Iug7PQS4?=
 =?us-ascii?Q?Ppfxx3ZGX5S0jJEb19nL+VmbvfjQUFBoNOeZj6ijoFwXpemkB21lGukXFFKe?=
 =?us-ascii?Q?+VSzj60IkR8WdyTzXm06QxLWGue3PlNBn1sRTyA+4823lz0fFk1NIwyP9+J4?=
 =?us-ascii?Q?FPVbPRZH0vvmaHEN5S5CRo1gOprpUe75tx9YqU0KZ3ciiLc0yHhzE7hQn2mJ?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c810ee-ca10-45c7-bd78-08ddec4469c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:13.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJhYo/pQY3f+/KmxCY2RGc5qnIlQdkP3VN8wRc3wkWexbpns17EBFAJc00D4Jcit17+OGeAQoHnBEhb7NCjpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17965

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use the subdir parameter to pass the destination directory to the unpack
function.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 953a1ca39..d013a09d6 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -125,6 +125,12 @@ class GitSM(Git):
             url +=3D ";lfs=3D%s" % ("1" if self._need_lfs(ud) else "0")
             url +=3D ";rev=3D%s" % subrevision[module]
             url +=3D ";bareclone=3D1"
+
+            parentdir =3D self.destdir(ud, '', d)
+            gitdir =3D '' if ud.bareclone else '.git'
+            subdir =3D os.path.join(parentdir, gitdir, 'modules', module)
+            url +=3D ";subdir=3D%s" % subdir
+
             # Note that adding "user=3D" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git:=
//
             # URL a password is not supported, one have to use one of the
@@ -194,15 +200,11 @@ class GitSM(Git):
         subdestdir =3D self.destdir(ud, destdir, d)
=20
         def unpack_submodules(ud, url, module, modpath, workdir, d):
-            # Figure out where we clone over the bare submodules...
-            if ud.bareclone:
-                repo_conf =3D ''
-            else:
-                repo_conf =3D '.git'
-
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
-                newfetch.unpack(root=3Dos.path.dirname(os.path.join(subdes=
tdir, repo_conf, 'modules', module)))
+                new_ud =3D newfetch.ud[url]
+                fulldestdir =3D self.destdir(new_ud, destdir, d)
+                newfetch.unpack(root=3Ddestdir)
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (ty=
pe(e).__name__, str(e)))
                 raise
@@ -217,9 +219,9 @@ class GitSM(Git):
=20
             # Ensure the submodule repository is NOT set to bare, since we=
're checking it out...
             try:
-                runfetchcmd("%s config core.bare false" % (ud.basecmd), d,=
 quiet=3DTrue, workdir=3Dos.path.join(subdestdir, repo_conf, 'modules', mod=
ule))
+                runfetchcmd("%s config core.bare false" % (ud.basecmd), d,=
 quiet=3DTrue, workdir=3Dfulldestdir)
             except:
-                logger.error("Unable to set git config core.bare to false =
for %s" % os.path.join(subdestdir, repo_conf, 'modules', module))
+                logger.error("Unable to set git config core.bare to false =
for %s" % fulldestdir)
                 raise
=20
         Git.unpack(self, ud, destdir, d)
--=20
2.39.5


