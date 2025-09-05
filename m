Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E21CAC581
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=3Q2g7E1Y;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxDZoTAyIH5sOliHv+2BoWdBsgMPLlniJ+Wa4xe/QkwHR2vnjpa/oCWM1VHzQSJu1lHaOdA9RBMbx+EBNQMhx7NMkZCIL2jAfNjld7F9MLtHvlC9/CrA8kIxKT+lZSnPM49cCORaiAi08PvMR8UxaCKTlVyo/bEC0jaB9itU+4+0Gzc2JpLehuZG4A38z98tYsWAjwnEuaCoQXw3yND2y83C2vLdVwRzl0XcCafbMFOc2vdZAMpFeqKTQbI+SXSQvm6d/dKIYAqXKwR9sv7kHMSyKJLPlryWziYNTHifypWTgUMpyEeuxzZ5N9gVMZOy+EAPVcnLrmPAIOKRVv5Vyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQkcsUX9CPiPzNI1scA+4zaZE8DQCOBjsm9VdvvLz9M=;
 b=gS2VdI7afjplTAyiUIq+/TenjN60iOCVEpt8V22MBvaa7IHdwWuUuyQFD9RXN4l2BsIXcv/SUCME93lRI4/mp7JA4etpQidCGK4ulOqkO1Zr0hvHmB0pB/3fN8rQwEdbf86wV0f+pJGKPYHNdDC5PkRHWcFvHwCTxQ+eHU5rWti8LEjRkpz7CMc2kL5t+fRWgzBv71AIt8gvBfLWlR93AnqeDKAN74yjwtpMwJ/yigu3R5U4KTN/vCd24C9S8pA/oZit1/5nQhPG9OUNUayuNMtweGhhb3Oqn2w694LJ1Fv2gp4CsW3wPYdbG3pxwONGszWH3Ad+TWNjAfn3Jx9GYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQkcsUX9CPiPzNI1scA+4zaZE8DQCOBjsm9VdvvLz9M=;
 b=3Q2g7E1YnDto/qwCEiLxhHLc3zhNTGMWtlUwUFoY3MHTyh2IotUHNBV1jNjoVkTx9pyp1UHz+orO1Ae3qequacFy0SzAXcQY6WWBtqHXRRyH/dQFA49k+8PJVliKT3zyOcZGfKIpI75/GWFKt6/GKKkISoPXnsI6trk239AiJ9wiivwRBfKWgxloEFK7ViGxlLGKIeatT8KR1qzDYlFLadKezYK9jNND9kmp+qXvdY4Tnzt1dPYIcxT8TkH14NymWm0NnGh1AcnxYFeuhd8dj8mUC18AWIZTToBDOGlr08c5bSC4VSu7BjYtc7Ayi1kC4qReE+Yre2f2cKYuZ7lpQQ==
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
Subject: [PATCH v2 10/15] fetch2: gitsm: add parentdir parameter
Date: Fri,  5 Sep 2025 08:20:53 +0200
Message-ID: <20250905062058.2563806-11-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4176d1cb-97a1-4048-c9c5-08ddec446a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yZKOjKCudYTKD5TGMp4/a4iD30M955VMwFzjJVSFz2ipJmNLUxeRWSJNgER1?=
 =?us-ascii?Q?YTux7Dm4d7FvhzqvipLoxhm5PLEFWlWaJCR5jCVFTi+A22cE92/r8klkjrJq?=
 =?us-ascii?Q?nvWjIHG4Ha6U82MIvWNY+FZ1KDAPYvjtRokN12CSNaGq6Be4F+sRgmUMm7iR?=
 =?us-ascii?Q?3GP03fOWOvcq0otPTJIQgd+MY0I+DAjvEP4k/ltZ4DRirFNFf679A6YTiXcs?=
 =?us-ascii?Q?/7xVkwBtgM1hNrIVDdO/HCj26nOHzrSQV1uEOzgmx7CYbkAks4803cwE+38Q?=
 =?us-ascii?Q?vzGbGBYGf7Ung2XQhZNDtrukldbBuIUgKjfC446JGYeydTYFU3GMZ+OAPkdl?=
 =?us-ascii?Q?BsikyeHE9F2zko0IkFiuSpPO7ZCDQdA7BBgqtheImCd8FsXaM6t0jOV9Lctq?=
 =?us-ascii?Q?8qYXd08rT6t64MjLyfw8AN9B5x7AKGm3F/zdRkklZsYNpbAv4AxrC0ITUPvH?=
 =?us-ascii?Q?lEVzoGwBzVWjqxxFlWmkc/Ndlyf14COVolU6f8aXZ0lYyB3fC5ciemMoGcnY?=
 =?us-ascii?Q?/i5RNHBDD/x+bRX0OtX5smp402YuccVZe7R5yQ4b/ufgjlAR7KGAr73N7DUY?=
 =?us-ascii?Q?OTOX8D+5MJX+fNQLXrAdxCPLRfJBEDCoYgMM0OrtMCALyS6/M4LRDePw8HgW?=
 =?us-ascii?Q?cER7bkBcQ5atP4sS8eOigOyig6HOqMeyvMtJk6AqeCOpho0q325DL2QEH/ro?=
 =?us-ascii?Q?QUfFSkU4eTLb7Uukzvy1XrziCd1lqL/p329KpaXZq65N20lx8y0qEaNQWL8r?=
 =?us-ascii?Q?2lNkMw6eYOtGsMnribpUqJG+SR9GW1oFuVauFLeMy4SD+gmiSNUMiWFri4YS?=
 =?us-ascii?Q?SXeGbShOdxWKU59+Ohr3FnDi/9QZLy9OJ5uH1egxDABPg16Fce1oUFIj/Wup?=
 =?us-ascii?Q?9oxzIZN3EF9hzbAQ1MNdrXRoLCuHul+LK4DknWQs2zZQofhiuM1a0sQ8PVMV?=
 =?us-ascii?Q?pfeRySMPcpd0PbuyXg5KKPFJi4FjIzt5Bzs++yYuNGvD7KEW76PwC3MCGl1E?=
 =?us-ascii?Q?awti5aIX05umPjkMSlOfoi34KIuwXtBjiIPFz7T1SXzHFE9Xsw47uie7G+fP?=
 =?us-ascii?Q?2cFr1vbOJQZQjjfkVAuAuHdF9J76Rj2VdF/vImpoVlTlWl4JTbsBryZtpxqB?=
 =?us-ascii?Q?FetV6tyJzQ12geGaX0/fpsiaXVeyCb0m45U+ajexGLq/o+oVz6hmLwMMMZMD?=
 =?us-ascii?Q?mx21eWqm9R1I+9eiv6uRwDWaA3R1c2lVO8lPCtVhPVXWVaYsSuJqYwuzF8yC?=
 =?us-ascii?Q?F4ffislPxaNd7auQfLauMaOtV/OEKkPvHeZxb9vYo/5YEAzyw7//ME1wfb0Y?=
 =?us-ascii?Q?LO72lDyFU1Dw45ZW+eod1mxiZ+xSqIs2uno5xnTERkh30kOR6KU2gcaSQ8ah?=
 =?us-ascii?Q?i3H1f/RCRT+IAmxu5WSP+sIPTNljf2oV9mRGV8VfHzPgJoJlm/YUoqtAX9xg?=
 =?us-ascii?Q?hnACDrYQjdYCm5qZeSBWfG3cip1fuKOWMuyIL/Vt1R81iF9/5msAig=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zt27+o9+jBOetn4xZwnXHN0rRvhl3PJYJlzbGhZysAy2GlmPqFL6IKZGL+QM?=
 =?us-ascii?Q?XDfff2ZISQU+Kr48i8f5kxV6fHLVw6itYbhfzzedaJBDPm8fciU4pTwR35XD?=
 =?us-ascii?Q?ftTPqyPOu6Om+f85qHJHLjKW9MbR1GZ2VkAlQLbkSMbrmhcfJeBBu+h+8BuQ?=
 =?us-ascii?Q?xHw9lWZYm2kMX8xefn8OuYNkGlP3GOcZoScQytaq7Upe8cmFp3ftxp1z2qx6?=
 =?us-ascii?Q?uyvUdliP6tDNlf4G/O4dO2OWSlv/1fGcPG/rBOe62XB5YeXJ9gpNP9/5fx/A?=
 =?us-ascii?Q?juz8QnQOgruLb4RszMMJMHueSMOKl2cPeTWH1Oikqqps85gjS3ilmoQX8zpt?=
 =?us-ascii?Q?KTI9Dbxtt/Of2l4GBG+y/gfmbN6RMJNAxGRo/ZA2+2pEZIPT5NtwATi4zF1r?=
 =?us-ascii?Q?b1rQgV7DBMZhduSsu5L/nOQJOLoJIKDz9RHyS2vstsQnZQNCFxR1FwljAvuL?=
 =?us-ascii?Q?J17igDQgg5/QjkP2i+JueatOyL6K44WJGjHstoiVpLIz0p4N3qClQwrHviEu?=
 =?us-ascii?Q?i3WPFg4sv+ZOd7KPAVTDfXI2sstluCQfejpz8VLD7F71o/4hkTVL+Ii0gJ0S?=
 =?us-ascii?Q?JOnh8ageyXdRBKe4/NdkV2ydKcywaSASaL6rzmb/f4qX7gvL0ujeShAlPk9C?=
 =?us-ascii?Q?hHZi50t1DucVE9XZs7ZwWaClegms9b4OlHbfDtzuRc7Evlxwa8m+OySnxarN?=
 =?us-ascii?Q?K5OxPG2GYJKFlr9dlq9mV6pIu9gJ4I51YdSTOw2mpDDX0+7oTxJc7mVQCbo5?=
 =?us-ascii?Q?kT86G9HIsHA8e1f8M7ZzVvWt90Q2zVs4go3LdSTeCkabgeWx4QYpjipzN7st?=
 =?us-ascii?Q?WnutcQEpW0Ve8+t+2TcXmBnNx7dXXqHfXby70SHkhnTLrMiUQnihOiu2JH8c?=
 =?us-ascii?Q?7HLLQpd9hTtTUpbXvH53aAsvXmwSObKYnyc0MiQeAcAawkkErxMJxQHtV38r?=
 =?us-ascii?Q?3vM8kvhDWlTam0DoNBxgwbBVFfUd55AVVMF/IkdMLOMIqT/0FlP2Be7ivkSw?=
 =?us-ascii?Q?x1foB2WbhtfHCh5YQPJcfAMHybMzJrZ4f9zCNEA+XZ/d6Pjpb4cTNZgP0ElT?=
 =?us-ascii?Q?9SXp4s5SEaesci/AVjSJEP6ijxcIQUnVb2L1xLx6UQq/eCcfz07hzpOT0KUw?=
 =?us-ascii?Q?2/Rw6PQ5rJ4k8P/ukPip2GzqnUnhW3EzRV2tYlExalgCkgZhdyNAWWzHKJ12?=
 =?us-ascii?Q?V8qBTfsYvFe6nPjVDuuGpJLkESB4UG4hU3Bf8XaeOWcuzL5c0tll/0YLDO+n?=
 =?us-ascii?Q?rcLG2HHl2QBFJBNir0XCqNRrCCg0WvuHoNG+auZwCeFOsHkOKzj8++Ku03S4?=
 =?us-ascii?Q?tVOeU8vOvacimhuzVb/Rkfso3rvgZHdgTd2r5IEQuKS7CnVQwO98uo9GK/L/?=
 =?us-ascii?Q?pk0i6zko84yWQ2AxU9DbxpKE4aKN1eGn/EMK1d5K1P7YPrMeBJLjl3v6Gbr1?=
 =?us-ascii?Q?1QjsfjFGM49Rz84piR3yp87SXN+Sc8S7+KXWUQ6j1gsBZ0bQ0JH/uael66+O?=
 =?us-ascii?Q?cPsvO2pGkNLnMmnSNGoLYdeUBjoqrhuX1ai2pce1174kclQVtJHodvKHh2QF?=
 =?us-ascii?Q?knBtZbb5ga5MXWO44Pai+r7ayhI/yAW/z6GSpR8iwIqA6tb+jJcoq68hzjyP?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4176d1cb-97a1-4048-c9c5-08ddec446a02
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:13.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5Je5BxpgEwsoUCMAEhGxHPCWL0XI2S0aw0RXorPHQkoMP6ClhnKmEti3iPG4iFFYClubFSoEZ7U7qBCgnHz8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17967

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add a parentdir parameter to pass the destination directory of the
submodule parent to the submodule.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index d013a09d6..c3e7189a0 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -127,6 +127,7 @@ class GitSM(Git):
             url +=3D ";bareclone=3D1"
=20
             parentdir =3D self.destdir(ud, '', d)
+            url +=3D ";parentdir=3D%s" % parentdir
             gitdir =3D '' if ud.bareclone else '.git'
             subdir =3D os.path.join(parentdir, gitdir, 'modules', module)
             url +=3D ";subdir=3D%s" % subdir
@@ -203,6 +204,9 @@ class GitSM(Git):
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
                 new_ud =3D newfetch.ud[url]
+                parentdir =3D new_ud.parm['parentdir']
+                if not os.path.isabs(parentdir):
+                    parentdir =3D os.path.join(destdir, parentdir)
                 fulldestdir =3D self.destdir(new_ud, destdir, d)
                 newfetch.unpack(root=3Ddestdir)
             except Exception as e:
@@ -212,10 +216,10 @@ class GitSM(Git):
             local_path =3D newfetch.localpath(url)
=20
             # Correct the submodule references to the local download versi=
on...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url=
)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, wor=
kdir=3Dsubdestdir)
+            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url=
)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, wor=
kdir=3Dparentdir)
=20
             if ud.shallow:
-                runfetchcmd("%(basecmd)s config submodule.%(module)s.shall=
ow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=3Dsubdestd=
ir)
+                runfetchcmd("%(basecmd)s config submodule.%(module)s.shall=
ow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=3Dparentdi=
r)
=20
             # Ensure the submodule repository is NOT set to bare, since we=
're checking it out...
             try:
--=20
2.39.5


