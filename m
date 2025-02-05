Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F65C0219A
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.110])
 by mx.groups.io with SMTP id smtpd.web11.6855.1738739758488645702
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:16:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=SjcTvKfH;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuJ6oW+dT8NwVfP63gy5ttHaUBSpGQ/G7RpOYw6bzcnv7iivon29znM0+YVrFq8iiORH37h5Gue2Ye2rUBiKiOYWM6gSUh9FT7DoeGpdXC34nuCcuWX+N/UBT7K+YQgXA96rkgA75o4J9TMKgGclCnm8XClg/EaT9568lo1TBeJDosD6jlUHIpvsKNuL/GM+cs6pQ/Yzq/M99NwiIdaT1b4ThYzauDvD/nizfklN/RDs7+xSR5oLcTC3EQzITyl1mAVkE7UGy6GeWt49dQEr0XsUC0MeQEsbtPDglENfDf9qkbflNH01oOSdOOw0U7n9W+tsoaTYwrjT1DfuqHXYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRoROFcW22BiY5Z5y3K11ndyq/j0i9/mGo/xWVCRMpE=;
 b=Lub5ubqylFqXULPp6ogDTsrUHTUEfZhX9Lc7Az3MZrLHAJBYtJiX0Yhyohlf6/3PckpGPILs6aH9mt9PegCBcd/Cjskm9Wmeog6+aiMh8jkkXeKbi7K3dTvZenRBBuWlOfbhvZZUGVii776t3Pyy32Q253LH7mJFGvcU/tZtYEsd7YShDXIYoJDKoeN0NmBsFD3YvzC6n3aOOaegwfECIOaiaCEKfQfpMf9p0XaewOian4vqSTr5Y2iD0XyAQKiuaqxnPdkKXQCbz6MrcdBxQDaFk/hDli3rOZqJ1/PSIG9907TCQynI0TluPFJRyjRejap7FubOq2ptuww09NgqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRoROFcW22BiY5Z5y3K11ndyq/j0i9/mGo/xWVCRMpE=;
 b=SjcTvKfHg3iOzzqs9X6sIQkeRsqqpATfWobtsPrKGuyKNyt8MiHojYDyJ5jK8NmZddhN8Zm+kb8wZqO2J1uhGw+zLMD6LVSeWJduJC+ZmglsOpso2FnXDt98aV4z570jdOobCYpd5CsDaV2Mur0fVJcVq6xXb7VLUy+zjZrKV0tar+GMHiYTX37ScGrSjSfynSqobVyvPebbRk/RVBYuEPeG4j/MBWYwki5daCKBfzlpAmqL0qVW/DBj6SUr+IjGa7l5xhbArO1EKWdFWMOUXyScBugOIwJaRsB0lZXYi3QB8Vt/7DK7tVbChkvDEaLBWHlAozSCrKadDupD9lmFPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:54 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:54 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 10/15] tests: fetch: unify style of replaceuris in MirrorUriTest
Date: Wed,  5 Feb 2025 08:15:33 +0100
Message-ID: <20250205071538.2681-10-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: e5630852-8d73-4016-936d-08dd45b4ed9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y6eG8dAmBLsshbu8cJ8L57U1JTBTueH82xGE+Dck7fmIyNUkDVPmcIJzwEGq?=
 =?us-ascii?Q?85mJlzWTYRcDlm7cg9mVxHlrAwoJ3pzMxVrcYr4wgropfv6Sn1gZGAiriKoG?=
 =?us-ascii?Q?ZahAeR4vMKyWZ3e0RVx36eyKhEV4e+durxSS+rkQmIixTPV714tp99PAZKYw?=
 =?us-ascii?Q?EYpwiYNaqE7Z6U20JlrrwFYwCA14kSX5mp3FLRoYD6/KROFwA2BXKGY9urCy?=
 =?us-ascii?Q?+/f1K+XSvneDFh4X2TpZF/Psug0+qOzcBfq3yw0W/SQD5Uz+7FDwASXaa5R7?=
 =?us-ascii?Q?rzQfqVW6ldWqNxc5jFLD0uh8Ty6nrA4mW8/l/xU7dCNqB2bDcusUSW4jUxMq?=
 =?us-ascii?Q?NddI3F4WJO++ppyozxBcWyiYzOFEb5n8m/lRY7WalY6BEJM6AA8NrAI57M2o?=
 =?us-ascii?Q?lGAF+16jLjtt91fNEwq0UUOmaFoZ/O+laByj5qgokjQ3qhy5xqK/iCGTgYIi?=
 =?us-ascii?Q?YqaKAPsgZB3Y9s3fxbouP+ME6A1BySoqmkzuVQ8jQ1VuCXTp9netOFp4kW7k?=
 =?us-ascii?Q?jML34zsZfQVAxRQXYaRy85sG212f4TbZLuKHI6BqJEsrnSfZCv5GBZ2fZXaR?=
 =?us-ascii?Q?apOwHalOMTuzfZtA3Qh2ullaPX1wcMt+mtd3sWum78QMi4OrQr2hSIEqHppS?=
 =?us-ascii?Q?vv3Wks+kzvESTyhAGqGvfw9XcR2J9TfCW5X2ydQGV61aXk49iZBjcVk9K4ys?=
 =?us-ascii?Q?0xqU9QmVAeNFdA6bx9G4sBJCDl9NL4e4qyLcWcR0LV5Ji4X7IMLWSaqMA7Tc?=
 =?us-ascii?Q?1mog+tBwscsiVkLGodH1LTRGCqSTZqAODHwT4BNxikVgozx17/cVCDMwp6Fc?=
 =?us-ascii?Q?//3h3xYSTx2GNuMMPQwMUnKPnH8sjPXJ+/bKywOuRC0rgsKVsYLYOMwdBxDa?=
 =?us-ascii?Q?uH2cGau1Hp8+2bFz2ciwL9pMRyJkdiYJUgiTU4tRWLp5vHtCRLSanN1XGO2H?=
 =?us-ascii?Q?aOXx20PqvuGQR4pKnzfWEaDkA5reRXTj9qUMVtgrMlWZ8qnLjgShaCS/M5pe?=
 =?us-ascii?Q?GbAdG/2Pub2kofxzLGJGSVQR+CYrKy0BVojmLIFb1APBqqLJxZ0/N/M354ez?=
 =?us-ascii?Q?awHmVv99xIS3XQ+sG7XrJknam2zlccxU9iooY0bXWfLwJS3GKVk6MxWGo7RE?=
 =?us-ascii?Q?nmm8KaJbs+LOXouBUx2OF6ucZk47eOj1NvlQhfd+21nciMkSjKZ73Y1YuAp8?=
 =?us-ascii?Q?yYmtlD1Py06rUMpKK4V4/Mq1aBYSqyV2VTdconskq8XP3RF3uivZn4olaSk1?=
 =?us-ascii?Q?99Lc3dP1CAi7JQwe+BXtMvP44rz0bj8pr+bVZG3vHkKT4dLRyAlB8bhPUORs?=
 =?us-ascii?Q?MSbgd0UlYZJh4KHtclaWySY6pWRF2xLwXl4MOZov+2JDunGJ1PNq+g4bzcik?=
 =?us-ascii?Q?a/l5NrgQIJrgMNXCKsBvOH1PJ25k4dqqaDxuQs2ec2gvozZKdg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J3OH/207XSnQTI2hFV8vXlXmgI/tHo8Y0HkNPeGLK9AuUgJe2xMJg3mIi+k5?=
 =?us-ascii?Q?v1Fk18YFHBdlhPnYbhzA66KUaFkTtO26PrX/VObyul3sWwE20oSdKVmUy1or?=
 =?us-ascii?Q?02WbnvKgmTlbi88TmiCL2AFUSWR50Rbs33PETlgFsQP3IHBFTt6BKxJ74kkN?=
 =?us-ascii?Q?Pzj+OgeJxfwzyEtMbS1S3XFgxTydJP/xMoP46BeirDExPFkqX8/r6RU5zxRt?=
 =?us-ascii?Q?WdOrwcCifqbFxC2KqfVaZpknIJA/5ZzqHVbVDDzikhddls/XRZaL1iUnzcZr?=
 =?us-ascii?Q?e2cckC5POywIO5ufpO+NtByHObNgVWLaVIC88vaspGo+wJ5PuVBtd3E6XjWC?=
 =?us-ascii?Q?DVNhJ0WJkYxuQ3G+aVY+cseIzMEOR3t9+x93hAeJdVD9wezG1mE027vw24pZ?=
 =?us-ascii?Q?5EEii4SFwrR1mghNwJSM4A2WGbDBkDW/Evsp3RgSkT3Lul1OsvyFPxEgvEYV?=
 =?us-ascii?Q?IuU3DVylqG6ivFO8LYIsW0mglyiLRYmnF8tg2zJ4QKN+ihQtwxxCgJ3jXg+j?=
 =?us-ascii?Q?fhBY5VVFRz7cn/MhA6icyXkLB+UQnLbIpMduhjfFm+P9fgT7uK/Bsyu9QoU2?=
 =?us-ascii?Q?EDFdemezdprBGXthScTbci7XAFG39ykMHeIoMAb4covNDCpKgfr3IyYbPdIo?=
 =?us-ascii?Q?/C+W7n04cQaxQaw+fH2RzQhH5FiFZY+Xi/zbacxAzTUguXVljFnTxpXOPtdc?=
 =?us-ascii?Q?1YjSw2YmSeKoGGZUDlHq6R4Nt270guqy/N9PEP2k2lZ+sZFrr3nTZJJwsiag?=
 =?us-ascii?Q?pHDt7JTZI6BvFIGJkwWPbrO05xQzB8JkB+JX3pngIW3zUkRfkN7nhfJlFt6p?=
 =?us-ascii?Q?HnEc2/Zh7sLT02bYZwqDItLwOPfleUWeT0pDL/0s+FzEYjyIpjwxLZEZv+9O?=
 =?us-ascii?Q?4zM7I6AdgUwXMErx2o49rGz/DDsmIjGidEW3MJaQ5ATQhwTCZ9ecQyqypPDO?=
 =?us-ascii?Q?j+ClIsMo15uxdm2GwN71B8q5Lt4mYOCP2HImkXN+bIjvuYxtOgRuvsc9VYSD?=
 =?us-ascii?Q?5y4A7QqWzrj5BpXZNm578Ln2089PKYnwIdVkgFSudZGBH+7zRJ4vB0Toa1hS?=
 =?us-ascii?Q?zQSmmbrtF+yedNa6bQfZD6TRx+hxi/sOMKCdu6cPbG97x/H/ZEPyBbogKghR?=
 =?us-ascii?Q?xhKuuhq2IpkDu56j9RufJp0B0j/EgQO05vyX57j8X33CzL7NHZndf+vrUOmu?=
 =?us-ascii?Q?fvV8ibCEIn7XRiboQ+vtrJdCDoKUvEshmfvAGVG0fMO4par2gozzvp80WwJK?=
 =?us-ascii?Q?pickrZhB8Ym1/G8Q2bRASM2C1pjAcv/oraixYCbi+uSQyhyXCZCn1uVkhBt5?=
 =?us-ascii?Q?dQvLmI67G5G/bq1cLE/SIFaQtZUKzFDutFlOZDX+4Xm0TEwJ6JKIBmt3VC/3?=
 =?us-ascii?Q?tG4UaFMRflTGiPKxHDW3gHOM2FRGok4bno0RUMRQqzu8bMnu3i9KWwRyTYgU?=
 =?us-ascii?Q?bhucq6t84etwusYguQenEYQPPit5q7gpG6FOJ6q3PL4CbwFNLsa0cSP9Y03Y?=
 =?us-ascii?Q?MVqyM3N26e2krrv552mezgohcCaOU4yVZuZenArNKgiHAtgT+Qkadl0DVV4j?=
 =?us-ascii?Q?v05FC3r3PJWMMlYHSHzQ7nysgl8kHW8HK9GGrznEA7hPzTEyzZOS8lY77hRJ?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5630852-8d73-4016-936d-08dd45b4ed9c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:54.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebTNR8qFBdzU1pLu1gdmTE9za8YlOvIWM4TKH3W4hdoNLcN6+/ZC5BY3rQwgyYJnQyeAC/EIthL8Cq/oQrHedA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17145

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d64717011..dbb787a7d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -497,15 +497,18 @@ class MirrorUriTest(FetcherTest):
             : "git://user2@git.openembedded.org/bitbake;tag=3D123456789012=
3456789012345678901234567890;branch=3Dmaster;protocol=3Dhttp",
         ("git://someserver.org/bitbake;tag=3D12345678901234567890123456789=
01234567890;protocol=3Dgit;branch=3Dmaster", "git://someserver.org/bitbake"=
, "git://someotherserver.org/bitbake;protocol=3Dhttps")
             : "git://someotherserver.org/bitbake;tag=3D1234567890123456789=
012345678901234567890;protocol=3Dhttps;branch=3Dmaster",
-        ("gitsm://git.qemu.org/git/seabios.git/;protocol=3Dhttps;name=3Dro=
ms/seabios;subpath=3Droms/seabios;bareclone=3D1;nobranch=3D1;rev=3D12345678=
90123456789012345678901234567890", "gitsm://.*/.*", "http://petalinux.xilin=
x.com/sswreleases/rel-v${XILINX_VER_MAIN}/downloads") : "http://petalinux.x=
ilinx.com/sswreleases/rel-v%24%7BXILINX_VER_MAIN%7D/downloads/git2_git.qemu=
.org.git.seabios.git..tar.gz",
+        ("gitsm://git.qemu.org/git/seabios.git/;protocol=3Dhttps;name=3Dro=
ms/seabios;subpath=3Droms/seabios;bareclone=3D1;nobranch=3D1;rev=3D12345678=
90123456789012345678901234567890", "gitsm://.*/.*", "http://petalinux.xilin=
x.com/sswreleases/rel-v${XILINX_VER_MAIN}/downloads")
+            : "http://petalinux.xilinx.com/sswreleases/rel-v%24%7BXILINX_V=
ER_MAIN%7D/downloads/git2_git.qemu.org.git.seabios.git..tar.gz",
         ("https://somewhere.org/example/1.0.0/example;downloadfilename=3Ds=
ome-example-1.0.0.tgz", "https://.*/.*", "file:///mirror/PATH")
             : "file:///mirror/example/1.0.0/some-example-1.0.0.tgz;downloa=
dfilename=3Dsome-example-1.0.0.tgz",
         ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsome-=
example-1.0.0.tgz", "https://.*/.*", "file:///mirror/some-example-1.0.0.tgz=
")
             : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=3Dso=
me-example-1.0.0.tgz",
=20
         #Renaming files doesn't work
-        #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://s=
omewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedi=
r3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4=
.tar.gz"
-        #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/1234=
/sstate-cache") : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
+        #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://s=
omewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedi=
r3/somefile_2.3.4.tar.gz")
+        #    : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
+        #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/1234=
/sstate-cache")
+        #    : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
     }
=20
     mirrorvar =3D "http://.*/.* file:///somepath/downloads/ " \
--=20
2.39.5


