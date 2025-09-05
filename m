Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B059CA0FED
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:44:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.128])
 by mx.groups.io with SMTP id smtpd.web10.15210.1757054683279460090
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:44:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=UJbwgXmJ;
 spf=pass (domain: weidmueller.com, ip: 52.101.84.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9EIigSbw8vBmMYJ07aT7iIYre2vTAh/BNFs9dOKU6AYDMVWsf7WNthVdOO8KcpLMpvGGnoOj0qhpVaFWcBMllVX3gUQZ+2tqaMh1nKrjsgYzcdjQgi9KkL01cg1IVnW/krCg/Tz9/dKJGAJTIKvJO6B90Lz/ElBU++VsxArL2vgrQmynkJ8CF1mqak8xot7X1VwNZAcMCOpd3EqjdJP9G14t2MiExILuLi20Tr9bfR4WeFu+Rlwct9txgdF09Uqak48OxHOcPHIVQS6NnWjltFp0FRS/B+7eU9fWCQui3Gf5zp5fB3F1WikPcz0Hlmtf5ofc3RJ76aM3h8VHEH/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVlBTp4MzhBKPvGJEY2xKsihXciryfiPeij69616WvY=;
 b=RvTvxWgtdQAYZJltqZr4hqxLZGXJ8L1h0OdFkn5j1PDW/hmtvLJ/iOXR7SQ62l1FEw/kXdpn4TDZ0EbPfH1bfENF7SwNFxI/yFTBAX6KzP8m85QrzyLWkg2HCAZelDXfgbc1/wuAVMdVdT9YCxvramoPCHdzPMGagPtykd1J5/4w3M9VHrI9O1DXdnd3tDQ3R3SGtkeR13b6MozM46gpUTFk9Up/3vQxIs08g71n+8j7KN33sEb8IbblxURX0jU7pNj23wbqTr9JQrHjnRUFYPzL1nKUHxfU4J2KFqZcRUbdu2qwOGLZ1Ugrdyi5BQvTvGFFUrwICNCSWiwNvlXczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVlBTp4MzhBKPvGJEY2xKsihXciryfiPeij69616WvY=;
 b=UJbwgXmJG0E6rLnfEA73TZeaYDJdYbRVevYTmwZiXX1Z/6W0tpKpLHvVIbMXIcItruUSAruu4+Y8UgPC1aKUlLFkPUxKYsN+LwXObDY7HjoKzop+H2fj/976QLkAFnENgwMDmllZYeinVs8USV81zReNbUcwZVTDyGFYXFR10/U2yGi9a1G13mB7mh1YhfG0ah5YGEdTSTZoXQfChlhoGTIIzSSyrUJdQEp9njvN/x+HLmngvhXmWnwCoDi5zMeM1zW9XXMvd2wS2VcDUgn2CpcScFrezM++p4qpFjEa5GYYZApUk24613okHWxdthw10nU/GROGAO7EkYbPQSQbNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAWPR08MB9688.eurprd08.prod.outlook.com (2603:10a6:102:2ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 06:44:40 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 06:44:40 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH v2 7/7] fetch2: gitsm: use implicit urls feature
Date: Fri,  5 Sep 2025 08:44:19 +0200
Message-ID: <20250905064419.2589111-8-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAWPR08MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 758c6093-1540-4634-e0ed-08ddec47af31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sQMINel4rhx9m2xqWT1FQPkI1jD3RvRCHuYs8/wgxYhxzFGEDSOonXz3mu8L?=
 =?us-ascii?Q?K3zzOhh+J2tYy0eqnL7Bq5MI++J2of/dsl+f56LO/sQmhqh5F7mwbU+qGBdZ?=
 =?us-ascii?Q?DgiOU8I0027CVXMRvZSHRliv56vj9gyjGCvGqDLpK5owbkTtegOmWPSJOyFL?=
 =?us-ascii?Q?92Ql3N1DTz+eX/XoyBe7qjn6QPNdw2XMRjW/EcwMQT3j0ngLftIyHSv/dlPm?=
 =?us-ascii?Q?LiNvfYlMpd9RlfhC57nPlxt6cCYvJkd3kFFVysmGb1gAd/EwFmAKUgRbeBbi?=
 =?us-ascii?Q?iRLYB1SneAvhiQjXKwotJKzBC7L+p/xhrIso4weesD/v2TbT1hJ3vXnoqrz5?=
 =?us-ascii?Q?79d+6ys9RSnDp5MC8Dlk6RY6SXBEI98NZvReEVr9pmxsWD79zrV8un1AhYZY?=
 =?us-ascii?Q?EHVILMpz2XD8IbkM4Llg/1gbPJ8ZpG1WRls5oU8u8wORczsDlar8qFqcxPJZ?=
 =?us-ascii?Q?erQ+3Ix69DmAcS6jdh5Lu+yzNfeFyZCkFexSx5+YrJv3W6G/7wz9gDkOCMVr?=
 =?us-ascii?Q?IkRBANgCIqSey+tygJodCFcOQ3v7nhyCpnrNTShMEyshIIRCjRpFwEMcrSOx?=
 =?us-ascii?Q?RPXQG9nCXBLdesxxxivUiEA5SqNACgaODdDFvSz/JFCtZP39KOjOdYTO8TcO?=
 =?us-ascii?Q?u7meKYI/r2VLpL+PVclq8sct1YucmqZC6obcn30yciXzA1hgvhVs0PhSvkZC?=
 =?us-ascii?Q?Wx7fvPKvuGUsTVEX/OuLsFmpAeTlLhdchSMZJGmSO76Jd5Kb/QaAZIDzaIpR?=
 =?us-ascii?Q?huTCjtp9Pm9wdrGjKX4uGfDf0rGVGHsPFiugMuyYGMMpeKeuy+f7TGBT5iVY?=
 =?us-ascii?Q?8wTkRnI7BasgBI2sSIRZ3csFKhN/g1XJssRQ367cYcjuQZFZy/QE6DGIMe0c?=
 =?us-ascii?Q?CrYZVfzr6DW0ioAirAPYaVn0/MOqJf/CpoQQcJkNtpmCQv/ji3SUS/stED0Z?=
 =?us-ascii?Q?fIr47HE6qBlzw/l/8SuQmtK/dfladPaGWuTOy9O7VT9sJBU3b0aNDnCiqEzW?=
 =?us-ascii?Q?v2UIKi94SyOTPgEzYVKkkgy4yiNIO+2vlcsHF6u50bkp/T3P2nBVGSNOmitJ?=
 =?us-ascii?Q?Tr32QQxsQjQQQ+z3BN1Si35DQ++iCGycsftfJK+fjqWCxB6YULv35tSxs7I8?=
 =?us-ascii?Q?7ni+4QYnUeVC3eyq4oE6lVD/VzjMbjKdKtE31ItfhzfhszP9N0XielLiVwgX?=
 =?us-ascii?Q?s4+LSKfvUZFeS0+MIXzeVooV8MOOvGvRI1XEVzhmh9hlTvDN9cExyT+eWtmr?=
 =?us-ascii?Q?q6Oq7RhEgqKh86XqAiPyYi9loYa6opokrteEuM9bxobTnMQPZakQPJN7fejb?=
 =?us-ascii?Q?L2/m4cfa+LxvKRYeuTwwK9R0Qb9WXr8PmL6ScHm61rK9cei7ZbL4kvXSrsgm?=
 =?us-ascii?Q?jvt1rLo5xasQPZcDP/JXnb+9af48wK7W9GM9qfw/F2u5RLe7cuQSEpUuuRlc?=
 =?us-ascii?Q?SNqcBKl93M61wZoCVx6d8zLmv69IeRz1dv87LhqaxGTwsRxxKhGq4A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a+spreyhtTM+OM2kP37WF6+96rlc8XlU2Br1v/H6VAnO79h4U+xpGCW6ABsW?=
 =?us-ascii?Q?LK48AX4iLLs/Brw7VPNUq7dxIeOqOMad7pSJX7jYvRiFwvT1fm2KwWxVnaqm?=
 =?us-ascii?Q?XhxxWTLtt8s94Ty2FO8oRvHrxVb93HzNa70aSssQ9Seb4E2HbutSPdipYXPI?=
 =?us-ascii?Q?I1nLxm2SdodBYGuGHSEY+z1uovLZAeFhVeE+Jrmq4cpu4hukn2yysUx4L962?=
 =?us-ascii?Q?fLqbdVexDDZZ0uz97YKbkp1P4irkCeX0kEyQMHPtKkUz2Hp50PnSFwdZ0qwa?=
 =?us-ascii?Q?FDn/IMCApO/Jz956xNSbbw45ASpnjSeHCtvhc0hdY98IJuAzn2i+M4H5e3ca?=
 =?us-ascii?Q?y58L6cWIprmVBUu/6Kf5OIPANQ2xI+iWfhHH893pl0MOwbzNo90IH9SHlHKJ?=
 =?us-ascii?Q?o/bEBZVsU72rZd6Zg53cRwbCU80CVa099qryy1jDXtsGxyeSv4ZtVmayl5d3?=
 =?us-ascii?Q?rV6el/x8YNKY3f/Cad5bNEatUR/rccEjHRMJy2qoMRjJuJzqSif6RP+3ihry?=
 =?us-ascii?Q?gfQILKGTOxmMUA89iNCiHFiSDbQzmvNpfDH3NmoFZZQkqBQLggr3g7whpvCq?=
 =?us-ascii?Q?IznqX+wiEwuiv2sHAKRmyBFVBnd6XLY/hNMdz9J9Ao52lWKyb5e5BuB8MMK1?=
 =?us-ascii?Q?pXRJdzSKx1Gy4Bib9sRJE00FKivZ1p1IT5LOt8Akpv7+0E7Q6Ybry093zX49?=
 =?us-ascii?Q?NM//Izqq5jl9OrTmrjJhND20VWqsSflmKipGboG9t4PnjIlgWdD878Ol+fxj?=
 =?us-ascii?Q?57v8tDq7g0YDu1D8nIxbIwDrK5G+NNb7EHNoL1XuBtMHm/dT+lomquCwtl9L?=
 =?us-ascii?Q?UEXWIQ38ML6YqvnYE/JTPakmLPWUiaWEdCCrFMJWQTJ13QHEeUBpZ9jhnWOu?=
 =?us-ascii?Q?37QGHVy6eblwISMO5Be7DDZj46SVqnIAf81/dQESUjmPlWcQxR3kvAh3V90h?=
 =?us-ascii?Q?iDb2KmQ7c0VqyBZAKni8YCmtvVpBA5USaJ3i4XEjqC7NN7CS60+E0hYSygpN?=
 =?us-ascii?Q?dWRzEZLWlyMjeFCmI0AOPh9S55cyIR5FAox8nXKcwjJHmu5OIAxMd1q/weYS?=
 =?us-ascii?Q?oSZ5hJlaO3T1WxpzTNb8hXQLvQqR6gRGO+cfu89s6gjfwz9ZGZdGOX/88X6R?=
 =?us-ascii?Q?tGiO4tSUXtV+TtsdZcUX++0QCHnkrMpfceamIdrbTGyd4d2ym8dih3UI1xWe?=
 =?us-ascii?Q?mvozakTyLwtVD2En0/7AQ2/6qEMPxpn3JVL9RpGADcd9Ye261lN5bnpsr8fl?=
 =?us-ascii?Q?ygziDj+M86q4LJFwtEd0Fdja8lmUljFbBQ17pKPXQeGxO8swYgCSmN1ILFa/?=
 =?us-ascii?Q?Jt6QKMF59PjfmZTXgtRZuNnVm6yqluQIjEDF59LAW1Z04nCumXiJ+iC6Xez9?=
 =?us-ascii?Q?xV2TD5cVraQ1/ex9KL4u4B93RU4uLfURLWIkpRDawz16i+UKKolKx72snMTB?=
 =?us-ascii?Q?hTmW3YgNVR1982s7XX3LaByJ8z+b5v5q0ffgsdzPRbpww2/a4JZBKqazY9uH?=
 =?us-ascii?Q?hIKcdGe1uGE671AX/bCW3zVc7d8zL0vh7y09Ab1z940ORnJJ4r/sd45Gr2kk?=
 =?us-ascii?Q?WD2wIUZ/BRYGFvoEa/2xKqRrEcmzK4zD60KWQJeq1ovxi9x+sHZxV2E4OPjg?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758c6093-1540-4634-e0ed-08ddec47af31
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:44:38.4347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmc/R+7ODnkKwZPIoSFuNNuZms8zGjqda+GCBzHiqv52ZCU6HNU8UK7N81/4a2xkiLeHkkL1dxWqjricgd7Usw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:44:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17980

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Return the submodule URLs via implicit_urls function and remove the
manual handling of the submodule urls.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 46 +++++-------------------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 5ddc81f86..90fe92f74 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -24,7 +24,6 @@ import tempfile
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
-from   bb.fetch2 import Fetch
=20
 class GitSM(Git):
     def supports(self, ud, d):
@@ -141,9 +140,9 @@ class GitSM(Git):
=20
             urls.append(url)
=20
-        return Fetch(urls, d, cache=3DFalse) if urls else None
+        return urls
=20
-    def call_process_submodules(self, ud, d):
+    def implicit_urls(self, ud, d):
         # If we're using a shallow mirror tarball it needs to be
         # unpacked temporarily so that we can examine the .gitmodules file
         # Unpack even when ud.clonedir is not available,
@@ -157,27 +156,6 @@ class GitSM(Git):
         else:
             raise bb.fetch2.FetchError("Submodule source not available.")
=20
-    def need_update(self, ud, d):
-        if Git.need_update(self, ud, d):
-            return True
-
-        need_update =3D False
-        fetch =3D self.call_process_submodules(ud, d)
-        if fetch:
-            for url in fetch.urls:
-                urldata =3D fetch.ud[url]
-                if urldata.method.need_update(urldata, d):
-                    need_update =3D True
-
-        return need_update
-
-    def download(self, ud, d):
-        Git.download(self, ud, d)
-
-        fetch =3D self.call_process_submodules(ud, d)
-        if fetch:
-            fetch.download()
-
     def unpack(self, ud, destdir, d):
         fulldestdir =3D self.destdir(ud, destdir, d)
=20
@@ -204,25 +182,11 @@ class GitSM(Git):
                 logger.error("Unable to set git config core.bare to false =
for %s" % fulldestdir)
                 raise
=20
-        fetch =3D self.process_submodules(ud, fulldestdir, d)
-        if fetch:
-            fetch.unpack(destdir)
-
-        if not ud.bareclone and fetch:
+    def postunpack(self, ud, destdir, d):
+        fulldestdir =3D self.destdir(ud, destdir, d)
+        if not ud.bareclone:
             cmdprefix =3D ""
             # Avoid LFS smudging (replacing the LFS pointers with the actu=
al content) when LFS shouldn't be used but git-lfs is installed.
             if not self._need_lfs(ud):
                 cmdprefix =3D "GIT_LFS_SKIP_SMUDGE=3D1 "
             runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dfulldestdir)
-    def clean(self, ud, d):
-        fetch =3D self.call_process_submodules(ud, d)
-        if fetch:
-            fetch.clean()
-        Git.clean(self, ud, d)
-
-    def implicit_urldata(self, ud, d):
-        fetch =3D self.call_process_submodules(ud, d)
-        if fetch:
-            return fetch.expanded_urldata()
-
-        return []
--=20
2.39.5


