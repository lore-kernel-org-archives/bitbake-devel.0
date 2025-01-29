Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06FC02190
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 11:24:36 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.35])
 by mx.groups.io with SMTP id smtpd.web10.10469.1738149871051466691
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 03:24:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=rM4Qz3ZP;
 spf=pass (domain: siemens.com, ip: 52.101.66.35, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4Ynswg+2ratTHKsgyljI2iBLS4Rcc+3F9IBV/p9h5/n6swiHy196jOe96NIyJKFyTizVvKQqDD4HImztGgJnIV1H7oJoHCZrAFBzwNL8A5dR0Qpr6zFomsmlEPH9V24S+NsgB+KUdxZIKcMQiqEm3Gf0fRpu9bOtFLDCl0/qSCxA5TA0BWngixuWGdxQ/jdOhVhzlZ68k5rPN11ENfl2iP4WgCFLe88HYVCoLJQCC6sICTfpq1v5znIYE1SEoP/+RaXEVCl+wKFlZlyIUF7Joe5MVazEyYWf2ukuG3Ws3UO8jkJOLE9utoM2dESj0itlhKJr5sSOeD4aNE56mgq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1Z4z5HArxnHexzJ86g2cNS47HF2Q61tRaEO2up+sFU=;
 b=SoH7Oji8FnHs/1bhKMyHj8bwZM9WuL5FyEJwtMn1uEmRHyUt05NvQCRdeWUKyzYmc1SKOrStPgFr5yPV6yZDrPkvArz4ltZNPW5kjxJ7aKTTG3ZaxRM5q4VbfMaM4RXPt7AnZsE4unPDLrF46bPNm3tYbzlamTlQpYUuE68+WwyrDmNUnHE2vhTPqolxMVzum7WPkfPIYr6xBWa9AxcnTuCwG1Q6P8RPC/MBu/S897oV6qZTyywiSyExaYDiWhWD6CGPBySgIUlLJos7+PfQkxy5wZo02w77DTrzRjnN5xuYe/wwi1uDbwTOA7c5CScx3mS7U5gcgjjWxrcpQlo5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1Z4z5HArxnHexzJ86g2cNS47HF2Q61tRaEO2up+sFU=;
 b=rM4Qz3ZPLOVxknyQiAzZYQtrRMdpmwAQfrSkk3bAfZHSCp/siOP3GseEzxa+MR/VrVDjFvxAS0IqQJu4COx6lbzwUnIDAahjFqfB+g6oTNUAki4u1tbJ/uwiY+t9+PpccrPIWeDx094rc0ia1t6Ac4Qh9yDrGfZ8zC/gikH55cDCBL8TvE+BF8Uwwzm86GYtsC/UFRujJ3BG7FFvlw04Gs4ND3E8uNEVPyS+bCfabyi/Tg27bj3Hfvugz2l7BSpCBm8GDpCiXb6VpqMaM3+hG/shz+yiTlKdKl6lw7Ma2NanODpGDHMd+FqnWeXefGcZVzOgraHT7yBK8ssz7X5HdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB9PR10MB6421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.15; Wed, 29 Jan
 2025 11:24:29 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 11:24:29 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH 2/3] fetch2/git: Add offline build support for tags
Date: Wed, 29 Jan 2025 12:24:05 +0100
Message-ID: <20250129112406.1660522-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129112406.1660522-1-stefan-koch@siemens.com>
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DB9PR10MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 502c8ffa-4152-4d8d-e492-08dd40577eba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?94sooAawIrWvXACFqPKcnipb7csk+wB/7JRHoduO+eJbpEIFnVOdSyGxmVtL?=
 =?us-ascii?Q?zeLDAug7MtkqZ1wsRapjIOBA5AI3yvoGoOrrKNV8VpgTFiKgm7qLRf23NvLh?=
 =?us-ascii?Q?umbRiPkmzv/EQpcShVPVjuV16X/+THUAnWkPALegRHMKKsksW8MmIjTEPyyU?=
 =?us-ascii?Q?pkUCTnJBUA/LadRYyO+g1LkgXbntC5I8keOmdrNbqDjXajQbZB/Crf33nhDv?=
 =?us-ascii?Q?I3iljhjo146ZsPDoxBWn8bdYp1vCV3ZECWzjfA0ykEh+noxA7A2+jZyWuuFQ?=
 =?us-ascii?Q?qjUgYEggZk56gWs8N/2J3oHdbcFiJwn7G2svBNTKKmqpXklEcGGIQzGoyHlb?=
 =?us-ascii?Q?rQrXjFBQ32uZx00iP1sEqh/zB+HFX/DNzWLfmdhTpcAH0k7caNeL/gTLca4h?=
 =?us-ascii?Q?GOf8zwBNRKK+TvHdMJaR/UMpGhzNfxvY7tBkrECRTXhESGmQSlTTlmIhhbm2?=
 =?us-ascii?Q?7XGbT51WMn0WJ04kh2mU3RT5E+Th+BrW/XfRXwgfadgm/mAYrwM1LHE8JcKx?=
 =?us-ascii?Q?+4Tg9+IMFOq1DYwLdqaQ1kP6PeBAtj95Ije1LYk3r/LV/I6B8PmMPhOYf08I?=
 =?us-ascii?Q?xXE2pVVRIsD3kInQOzuIlY0WsGlMukba1vQqkXLWbfihCmGdMJ1NXf/M/ZYv?=
 =?us-ascii?Q?D+AscHtKk1n/dKjRmr5r6rraZNcUJ9PKG6IIDkNqIKwMJuhIbbwqDR1OJjD9?=
 =?us-ascii?Q?gIL4/hNO+1C3UjdIPyjzhSNIbMPygVEfNkjEJ3B/mDA+MenTkiLXNDD6B99r?=
 =?us-ascii?Q?Bg8cMKRTavqEa4GRAt57pPXfTcIjsPoTSdEC+Ae1fTAkUGccBTTOxw5xuWZR?=
 =?us-ascii?Q?m41LuNrurKQEN5C29LiX6AovJDl+m4JJlKBiyn1Mc4q6ErRRJA8uRaz4equf?=
 =?us-ascii?Q?Rl2xtMabT0xLA57W4lZ+YtAoD/xb5jurjuIA3JyJgzmMZttnovDvzVLWNQHD?=
 =?us-ascii?Q?Sj1of4EtuZmgFJZb4vvkLF+LjVIAyQq2VXdfKGYs/q01FkFVru2f1omODsQy?=
 =?us-ascii?Q?T8hnUuh4nuL+k71cfkxapqk2HVsVH4tBhqOMVDPsjb98ARiP7UfvDeIqGjU7?=
 =?us-ascii?Q?mwvLk3onxmesG4fy6KmwenVNvMhH2QygySc3rPtz6s36a6bOYN38JSpfkv89?=
 =?us-ascii?Q?S+PjqHYht0NlGDLG+gXu+/nwlFZdTb3jsfKLY3St+kIKbIaT6VU9qCIRcIJ+?=
 =?us-ascii?Q?vpTudSdL9LKbtq6l9Y3ras0lBW27AhPmwbqb2y4lQaiBPH/pUhbNj2BhqMOk?=
 =?us-ascii?Q?Wrm4FCLaKJM97vNXPGaTJd8RyJugGyBr9oIZarP+1P03TAmNah7ASYbbOzSf?=
 =?us-ascii?Q?Thpajcpf+W4RbimwateiwZFkvaW3KI77aY7+VPnewtJ3KBBqnAMmToEq9DQs?=
 =?us-ascii?Q?QY6SHV4RwO1BdvuPAG1qoq/zhU/6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e4nGITHBIBMnVXy4qif1kFaJDk2t8HG8LF0DOPzA5ulWptwTRi6l3Q10mUA6?=
 =?us-ascii?Q?QMf9hu5IA0ikgGV0uudNG5jQUcc5XkN2O/NBbx6jlWl5a/lfuKPECRo6Wwfd?=
 =?us-ascii?Q?Bn8p0U0CyxlZQAEl8hmVNTJF1AmbQ+6SREjqZ6nDRU2zi2IUp5RyNV5Q5Llt?=
 =?us-ascii?Q?G3D4KVtHTpSO5u2BT1gb6so+ZUm6iOvtggvFz9+bX+JpnwiiYU3AUqj6QqaK?=
 =?us-ascii?Q?mHNDTFaYjlP5zvcAVoJKjty9Uu6T41LsbgR3TkPIpW9PN8GvKgdP13PM1s0c?=
 =?us-ascii?Q?b+Kb27R0LLSS5RfQl603+Ic0MFnbjXh8aXO/fNU5hlZyPusnSVRKrO3UY/Wd?=
 =?us-ascii?Q?Hx4yTkBpHUlWMon79y7SPxIpx1qhaVrcHuyI5r8ZwzfZkLf1r2b5bK219kzc?=
 =?us-ascii?Q?wBIq74986scfyJXJSiyaM3gGHy8TnguRgNcwXhdFzjllnaYfWaBWi4eeQV4t?=
 =?us-ascii?Q?rtbyTo9763cX3WbInh9eeSiLghF97J2wOv+2VchcN8hmip3Ag/SFEv2y9FKn?=
 =?us-ascii?Q?OQJ7zn8QbARdi2JAq9gKt+e2SHaXWxwndr4qlCiNroEyM/c9VsspwmohO82c?=
 =?us-ascii?Q?/DljziE3Bil+JBE3JAhMHe4RjdxuFYiIQB5eyQ27yTarXpFDqHsiEgz/kFJl?=
 =?us-ascii?Q?0oQqLdp9jcflV17L0+jHPfUbF5b95sNwbQj4MfZM5KgtDAsl1aJRVuYXEBOg?=
 =?us-ascii?Q?+XgGyaGr3Z5AEWnfc9QNTSv8nV/e15xA7Wc9lyLaw9cMafHxnU91YIgFSGlp?=
 =?us-ascii?Q?9iTt5TpBvcm3I3BNAZNXsZqonnBzxm/hxBFUbSAfmiBJOhgLDSOTylbHMyvI?=
 =?us-ascii?Q?r6mRW2lJMk7EY7w/HyofSXDlAStLiE+EWcYgHo4tCst9BZC0t0FakNoAoApK?=
 =?us-ascii?Q?K9jgjmKwVsP+rqjL1OmMCYcOPYHS3hDcCT2woA60oyVTvDeuD2x2UTPMxn3C?=
 =?us-ascii?Q?YTUq1taYjhH/P7alOvZC1ppaeGkEcbKmF0hj2DrQZlX9//cUZEmkcG/I+DiZ?=
 =?us-ascii?Q?n8HNcThJ+3bwZy4A8imOJQVP/ji/fCvtZ2laUoLemZUL3e4r0EvRk80pFRfv?=
 =?us-ascii?Q?dsTev8EpRqfHRsUObPexKJ7JCRpnhoWfw9HtJ0WxIXT9gFgNKNhQPBHYAquO?=
 =?us-ascii?Q?B8f49n0fSHMmFqM4Dkc7mZjGh4QkkoAkIRMs3tZlW+wUrQxu9b9rmsfP766M?=
 =?us-ascii?Q?UTkgyxMvetK47zbACxtKr4aJar0cpR6+SL9Oa0511Amp8pUEO2gCHPDC269t?=
 =?us-ascii?Q?HKUGteUPghCDBIuh7R5n/9+ZURtSSOWUJdbFVoFP7Io0tE28/whCFoeTGJLk?=
 =?us-ascii?Q?P6cf6kRO6j5jD2Giu0H9RsddD6LvK7gvF3Y9qxa7TQTCvi3NB+6I7jUGYx6c?=
 =?us-ascii?Q?GftHC4XVDIcgEaAJDBWdc6qAdECaVgME6EJr381Zswpkcab6O2mI/RFZSiAU?=
 =?us-ascii?Q?jjFgB3nxVlEaaE+SSdMMeIwMoekFIdHIsmmNkSUxVt0QCFm+FmlEI7IxDXEb?=
 =?us-ascii?Q?u0kKGvW95tE5+Dh7Z0njPKSRE/H70DCN04190T2+KytNin4of4AxW8eHfhNF?=
 =?us-ascii?Q?JBH50cbDLDgXL42wiM1X7V8ND3Cb1GdSxOY8he6gMgNul54wozQVOEaWXA6z?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502c8ffa-4152-4d8d-e492-08dd40577eba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:24:29.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqgNSvfglSAK77dxHX7lusHMuZwCRWnW3aISoDdMeZHedIWPiKXrV/SZaIOFPi4cQ23o7y1pnfUzydFVqrkEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6421
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 11:24:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17110

This adds support for offline builds when tags are used within `SRCREV`.
Offline building is enabled when `BB_NO_NETWORK =3D "1"` is set.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/git.py | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6d87c2f18..7ac690bbe 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -270,13 +270,6 @@ class Git(FetchMethod):
=20
         ud.setup_revisions(d)
=20
-        for name in ud.names:
-            # Ensure any revision that doesn't look like a SHA-1 is transl=
ated into one
-            if not sha1_re.match(ud.revisions[name] or ''):
-                if ud.revisions[name]:
-                    ud.unresolvedrev[name] =3D ud.revisions[name]
-                ud.revisions[name] =3D self.latest_revision(ud, d, name)
-
         gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replac=
e('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')=
', '_'))
         if gitsrcname.startswith('.'):
             gitsrcname =3D gitsrcname[1:]
@@ -294,6 +287,13 @@ class Git(FetchMethod):
         ud.clonedir =3D os.path.join(gitdir, gitsrcname)
         ud.localfile =3D ud.clonedir
=20
+        for name in ud.names:
+            # Ensure anything that doesn't look like a sha256 checksum/rev=
ision is translated into one
+            if not ud.revisions[name] or len(ud.revisions[name]) !=3D 40  =
or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
+                if ud.revisions[name]:
+                    ud.unresolvedrev[name] =3D ud.revisions[name]
+                ud.revisions[name] =3D self.latest_revision(ud, d, name)
+
         mirrortarball =3D 'git2_%s.tar.gz' % gitsrcname
         ud.fullmirror =3D os.path.join(dl_dir, mirrortarball)
         ud.mirrortarballs =3D [mirrortarball]
@@ -909,7 +909,11 @@ class Git(FetchMethod):
             repourl =3D self._get_repo_url(ud)
             cmd =3D "%s ls-remote %s %s" % \
                 (ud.basecmd, shlex.quote(repourl), search)
-            if ud.proto.lower() !=3D 'file':
+
+            if bb.utils.to_boolean(d.getVar("BB_NO_NETWORK")):
+                cmd =3D "%s ls-remote file://%s %s" % \
+                    (ud.basecmd, shlex.quote(ud.clonedir), search)
+            elif ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, cmd, repourl)
             output =3D runfetchcmd(cmd, d, True)
             if not output:
--=20
2.39.5


