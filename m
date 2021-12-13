Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87CEC433EF
	for <webhook@archiver.kernel.org>; Mon, 13 Dec 2021 11:14:34 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.51])
 by mx.groups.io with SMTP id smtpd.web12.9975.1639394067412531688
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Dec 2021 03:14:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=1t3O1Pqg;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.51,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcGmuozeAo7TbQqfGYX4ZBfOi9AAGx+CgN8Xzu0crT51eKWy/IMAkRjmH31Ps4vAUAADyfptC11emeGlaV/x7rm/RGqk2jYQewlO91xVeNcyFrdnZKJW6J0G+AUygJsSXFT6iihhUOqZED3Pv6szRmbU4cwhpoD6vnEScuOhQtgRwKOGbbfZ71pnXcsG+1UzWejpRYymONLVsiZCgNPdWw0KQmJlWnDvvyQ5M7RvidCtEdVLkXiPpkBWNNrX3fD5Zhryx5NZY/xzHXG1ysZ1tq1cUxAT16u06TvpkI3TDpUJCmBZBhlhukF5dU5aZgXNx3GBcao/X+rr1JNvMOC5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSX+3tXNOJjxVYnSLuHqt5/IGiH67rnzTgy6KujSNNs=;
 b=DlnIKp/I133YqjyuUTW2vqAbaCuJwGusmdmEju8PCYC7Az9mZcZgdRI46goSRD2xMN+pERVEC8ZQATjEJDypS21s4+1qOWP3HPre8vuA9c84Cd+k5/Le01ixbir8oPfdznQSWrn6Q48z75dsC+8GnYkKUf5KLtAw/tFXc086KD1cqYd+vbMOoahfLuJUq8510egB0y7FieYsihaUf4zGkYZFNuGM79kJ2QDag+8DYm6s/UUKRjFmlq8JYYXmDaIbsXWaPHonOeHnlRQOX1BDlk0khdplNdS9mHJy1ZSTJVb1lkPshOUfq5pDcLv2PKT/rDquGfWnroCBxErN2FZH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSX+3tXNOJjxVYnSLuHqt5/IGiH67rnzTgy6KujSNNs=;
 b=1t3O1PqgSs9jOZFhHhVGR9gA2bcwxWrEmapQxdLYbVydS8zcUu7MTeAoBM+RrH2S4QVQUJgesmdEBWWlYftSeHCojjr8l4dz0BCwjAhI3FUokpbW7kgpKz/Rb1hGBI136U1ztRx5/4X/Nr7j4Skpq8aaMi3PEAgAUyWNwdD7Xm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB6926.eurprd08.prod.outlook.com (2603:10a6:102:138::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 11:14:25 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010%8]) with mapi id 15.20.4734.032; Mon, 13 Dec 2021
 11:14:25 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 2/2] fetch: npm: Use temporary file for empty user config
Date: Mon, 13 Dec 2021 12:13:53 +0100
Message-ID: 
 <20211213111353.28402-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: 
 <20211213111353.28402-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
 <20211213111353.28402-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0084.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::25) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (89.247.126.92) by
 AM6P194CA0084.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 13 Dec 2021 11:14:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ba55740-81f9-41c2-e450-08d9be29b8fc
X-MS-TrafficTypeDiagnostic: PAXPR08MB6926:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB69266F8BAFCDF8277D43B053D7749@PAXPR08MB6926.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2kTlB+EONIyAgy2YL3wOph0wHWlrsGN4r6sKaGWdRMOCBumnGhOubpWGB5XbjGa7GevsIXJ0RymKX7YB/ypjuFLer3s2HbbuQrEg9xroSA1KYf87+d6UIlCXWNn6dbznm7UdDqaJeRZtAvAfo0vc8NXxuZFj9cH10e7LNSuZe0JXg/HlxZnQkkV0v3LoVd2nrCH/x5oEh6cuCbc4+sLJYeIcaHRQYAjuuNK71oatNNZgZnTTonuCjq76hu3She2s/OwA6HZ+yEdwyd5GKj1rj9lYIYjWCoKZM5PBaweh0N8rBH4oOJtJiLSqJinrMeNQf7LuO10JfM1BNfPze5zfn0ARHb/EqJw1bJwmzya1In0dU/OVLFSDoPFMIWBS6JmMFFb/z39s6xXpoiB/O2dRDve9mjCyIjF4+sg3hBNnIVCYsaM1Ecv4mxsAkEjCuamF1uZ4gQ8oB9clF8+ArgUcLFA84GAFyU7zJIQUUxMCO40zzBFTJUkmmHqeiUBL+8cYHdgUIIc70+Tl6rbEnPm2rFImyUlEDZ+xOP/XQUP2J3BbEyvyPvihV4aWrPWyS1mLRB44VErCZrOWuFprhWxreRYUAXX76LMlrEbUc2aKqZl5zuQ7MWVkoCy+pdGXhF+PfH6UoHGWNSuZ1Vv++zaK+B4Uz7IX3nL1f9gB/ajuxmvESr4rexphvMOPlLzBwh1UUadrfm8cMiKnP/ATZwNzGA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(5660300002)(6486002)(508600001)(4326008)(2906002)(6666004)(8936002)(83380400001)(66556008)(38100700002)(26005)(66946007)(36756003)(38350700002)(66476007)(316002)(7696005)(8676002)(6916009)(186003)(956004)(52116002)(86362001)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CrAk2k4P1pVQWJOvu5qNGz3N05NsF+cgQ5sCd8EPv8vIa0GAaA+2RiUmAwXv?=
 =?us-ascii?Q?uBCLw9xMBG9IE4BdXOUGH46VMfgHVMWtWduDuTXQ4ZUUY36xpyHwvK3SM4ww?=
 =?us-ascii?Q?sTl5KtkYRN0hWmc897Y0nNcsmKEk8inzOp6YGKLlrl9hFqjM3tL5ZzVHXgSV?=
 =?us-ascii?Q?hXjLuj9RLZLNfv6mixRWX6zfY8nFC8DPQ6l2IvswEBC9vx35X6fLCEtXEhPq?=
 =?us-ascii?Q?9b2r32D1OzZIzv3GB/YIy/r3/KyB9CTcS+2nAOrC5gTLuLViVruATTj1LUR0?=
 =?us-ascii?Q?lDU+xcrGhgWsPJ84qDEsAclDj89GJfUqPdTUliNNEYKQin6rsnDPE2xMTS3H?=
 =?us-ascii?Q?wDzN/QgF/UJY2hyvJCJL9dqqaHogD4E4HbGv1k2wUk9gxZDA/q5ryFUqrULz?=
 =?us-ascii?Q?Z2rdlZ3AGUzShI5AhiDjXdpC5fFvtqeOcHvWooshPNNuI2GOaN/Dc9WyO7e1?=
 =?us-ascii?Q?OqaFTEm+jx0ihalwSWbSB5hq+QRB/eRxOulPxgmHMBdlO1hdbFvlnno0A7GB?=
 =?us-ascii?Q?r3SIh1TVSlvVKwHiFGOKl2y7h868bVJqpUKosNT2sWN3HpdHpx+2iF5FfssP?=
 =?us-ascii?Q?468Oi7EEci+rLefYPE+1/1I0eRFYlHkWtJ0aT5x6Y40pm8BvWo6HlCpMhAl0?=
 =?us-ascii?Q?nTU0JOOPcWuk9KyPtaSgCT1qZWlzHEinHdfe1nGRuswxuhGEjF2gmVCK+8yO?=
 =?us-ascii?Q?hIcVfuegu+HDILVMSLuU1BAwxu5SlDmn8k/8SPFBftCmOwk8esyrQuyFBvvh?=
 =?us-ascii?Q?/SQYUDLAoNwHYieMc0JYCBb8Hl0w3KMV40ky/flW7oM8f4Yc/TW30EG4pX6M?=
 =?us-ascii?Q?lZVCS3hNKou5Hv/pQWJkodg2DPnw8ey+G+fYEusQzytPx/i4z47oaBmd0rie?=
 =?us-ascii?Q?9+93YvqiGInIRWRHiBiSwpcTHsgD0JSuYH6w3ArrofBi9i570xX3NVh/TP0y?=
 =?us-ascii?Q?SV1dZV9aNtOhuFqtddsvGhmqvRwokgnG3sWT6hr0sFVnQUAre88u6L2DvTbz?=
 =?us-ascii?Q?WAySoLQfzsMtbhNA5q93tFXtfnw1DmlO7dAqujLbkLa8yPv+f9XSuoftBhST?=
 =?us-ascii?Q?CuedgFNiNC3Bttpkb3D14twJBqqhiXFoKvMb6B3CWn6ZaldJZufbaxIWJMjU?=
 =?us-ascii?Q?Wd5zMZgTQ+BmpuD9K/wzzyQt1kqpxeACR1m7k1asra9uXUrgOgujCczxorv8?=
 =?us-ascii?Q?4ve99Xq4riq6oyD6C26DDKDjGQ1eGNpJZlMjCTr0Laa+EvWJtgKBbJt39k4b?=
 =?us-ascii?Q?PJThKUMTVKVR+TGYR66BlcZgvjiEJ81msTeos/ZulYYFactR3VlKY9qoFOy7?=
 =?us-ascii?Q?RvHeTdYKHhQKh2lE5R9UbuVLPRHfMM4yC7C5gyrgxaLZtL2A63PaWSjHM+1O?=
 =?us-ascii?Q?4Cd853MaA4S+gW0rqRfXjcuTEe+6biHF6qjmMMw7mi//VIfLQVF+uiNLshXu?=
 =?us-ascii?Q?HjX8Gq9dW0Z871JJgzr5OxPBWGHP6latIyGOp/0zJi6NvY7wbFaHP7ldSMCK?=
 =?us-ascii?Q?NEbeM5DIIkAAfZJuLtLl/iydt7xqfqXRZe6D4EZgntGEA2gvijBIR4Rol27N?=
 =?us-ascii?Q?4ZIfx+UL0Fgl5iI2AX/Pase1P/o0cnRu0hlwl+75YAMflYh2t5Enfzy4ldqi?=
 =?us-ascii?Q?8QmraZCiC9W0rTu4XeAadqw=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6ba55740-81f9-41c2-e450-08d9be29b8fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 11:14:25.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 K3h6NElENzZMXAp9+WzWDIzE9N74mmUVmPpd39fltN4Nda8ThzhqNH8TOnJUO54zupUI0VmEqyd4KYW5cgFEWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6926
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Dec 2021 11:14:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13149

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Always use a temporary file for the user config 'NPM_CONFIG_USERCONFIG'
because npm overwise failed if configs and npmrc isn't set:

double-loading config "/dev/null" as "global", previously loaded as "user"

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/fetch2/npm.py | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index d9daec20..b3a3a444 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -79,16 +79,12 @@ class NpmEnvironment(object):
     Using a npm config file seems more reliable than using cli arguments.
     This class allows to create a controlled environment for npm commands.
     """
-    def __init__(self, d, configs=3DNone, npmrc=3DNone):
+    def __init__(self, d, configs=3D[], npmrc=3DNone):
         self.d =3D d
=20
-        if configs:
-            self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", b=
uffering=3D1)
-            self.user_config_name =3D self.user_config.name
-            for key, value in configs:
-                self.user_config.write("%s=3D%s\n" % (key, value))
-        else:
-            self.user_config_name =3D "/dev/null"
+        self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", buffe=
ring=3D1)
+        for key, value in configs:
+            self.user_config.write("%s=3D%s\n" % (key, value))
=20
         if npmrc:
             self.global_config_name =3D npmrc
@@ -109,7 +105,7 @@ class NpmEnvironment(object):
                 workdir =3D tmpdir
=20
             def _run(cmd):
-                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " % (self.user_config_=
name) + cmd
+                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " % (self.user_config.=
name) + cmd
                 cmd =3D "NPM_CONFIG_GLOBALCONFIG=3D%s " % (self.global_con=
fig_name) + cmd
                 return runfetchcmd(cmd, d, workdir=3Dworkdir)
=20
--=20
2.30.2


