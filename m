Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA7CA100E
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=bfQf3ZFq;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLGp1or2QXBY5jP72qbhSAINKt9N2D+y3j022esemknh5HiFScf9y8Xew0n9T86E96jOGbpd7HXcQkQaXhmPbHQ0dXRQYkQU4eAhuBgaHdiilVEAFENWPj+NAxdaeEHqibdiepJRgFdhQy5lBpdgN3N1pX64ecXeHAIXiKK0kQB6cS2zsP9N69VNXb6bw8byMQEJSlgsDEJoGaqAgwKA/SAOjMB85FW2QF1z1myYBN06qiYs1yWPhPDOLWcusGFBAN3WeOKKz11r5/OBrG2usZ4IiaqKqa1s+Il2yJ4jZJf+jdRfy0oOgMFMuqWQtFZLzX5Pdxk3xUeRg5BxMV7s0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkxXRUUiBYQdXsuinZvEWs0ZbTcYMnCaOoZb06cDguQ=;
 b=Th+HcybygJDlQH8bx6OE9SvvmMLHhyBM5dZPnZlOtPV3uMhRmAB8VgIZqGVHazXynn7R52kAmT6BY9i7+MifMFNR6gSOau2LL/yREbmfxj47pux/rwCPYbXZYdXup7b22f9+/jgGA7f/7RK0/0MV4+uTMzCAzNfaluANoZTRO+ytFXj6ewVlMZCC3sOP8L+XM4wRmch9U5p+XPvQp/5K7NHiwH7wNQiaqSAZgYBkiz938jNmi1vFPGd4IQqVeijlmaqvLRFl8+4AgsG8+9dDpFwfC3Xy4BsYtktRKoxDEiQS7Zo3S0nkHJesZu+VjfIldFGp6kAhHrkDrMWIZUkVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkxXRUUiBYQdXsuinZvEWs0ZbTcYMnCaOoZb06cDguQ=;
 b=bfQf3ZFq7OGIL/aZvEhfbKHkR7ueaHWxbZHutDVot9IUQE2ozp/8AKrUTXfB8jY8E4VBvZPF7lPFKMW+G+t8fYyk0dWca4Z5jGwONiKCsuq09silWqLHIUhbHoyOADrK55kjtuxuUl5QTaIWYM7HdJmZwojPBDHGC+lJb4tj0pGDu1JjVJmDUwwL9EY90ZOb2kS5A0wZDh35RJ32WZzmrEbHN777Re++JExZfCv5fpv5leiuzLy82uJCSLCrHO48QdesGyJXNN1ve6kquVvnDsDePWIkQMTUJUenKRKWyzdHts3noNNX0ogq2lxwB1cdGjRF8l7uhMVnS7nC54bg6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:47 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:47 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 13/15] fetch2: gitsm: remove useless need_update check
Date: Tue,  2 Sep 2025 08:45:12 +0200
Message-ID: <20250902064515.30879-14-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 89898a95-6c9d-43cd-911a-08dde9ec5606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+iuzziCF7v3KllAIfhq+oe5PyQexHjMug9uWT+bcfTyiaQK/witB4zfsqn5e?=
 =?us-ascii?Q?YJG4XSAbUnEMDvkV2aIQpW+ZpHJ+GWVNTG3ldMx1Q4q+Ob9wWEZSrghiYzWi?=
 =?us-ascii?Q?SlzyGuN5P1Ju7AGEGY10Qr7y1pFBmQvzi3ICy0YxH3IBRxgleEQ3nDxgd9i8?=
 =?us-ascii?Q?YgN4BUanJTzv/EtxO6uCni59QdwNL0hFNxn11AHMgOxZuWWb1/JjR8pGbM6u?=
 =?us-ascii?Q?cXHuJGaiuW2kJYpv6UerD+qMsGdUol8BBiqqGTHXX1932+HEK+NksrTveoAK?=
 =?us-ascii?Q?nOyphbqKTtUvdJgwuWSZFa1DgZavXGQdD5shvfqvCG07ikEeTXzUgNwhj1Nk?=
 =?us-ascii?Q?HQvLbnQWPsPrRkRx/sPqISlp3rUALUTBsxmgaNO17Cg/XMduXXvg7eyYfyJn?=
 =?us-ascii?Q?3g4y1ee3EOmHfQwsdDy5vYwVcdbL8+z2G/h6lutayXIyjJMPfsCyCikk/y1B?=
 =?us-ascii?Q?wHXXw1b+Pr3Yj9fpienA19EvC1TRNXha05iglHC9U0hzgtIqXeerdk/K92vF?=
 =?us-ascii?Q?Jo1gW+lG6ugGTfF3u0vbOPB4gbIu0P+0PekF9aR1H4gRHFGoQMqHB7zQ/5ts?=
 =?us-ascii?Q?eSn0Sjq/BAu03sibqiu+vdCy0VeS95xeJ77WKKIFbcZzrKIOw6bA3sS6Pih9?=
 =?us-ascii?Q?x4ZpHRvecRIeaEH+KwZyn2cgCzfifhT9SluXAn+RoZotNy7w4oaX1TttMIlj?=
 =?us-ascii?Q?2rNckdlt+myN5eKRejwLszEw/xeUXceb7f2N7AJ+dYnyaFKX8vtf/GfzjSZy?=
 =?us-ascii?Q?tW5BpkmT/UK+Lw/ysf8p3NDkvKVKu3xJDp9wO9Tif4VZ7GDjE4MnkJFg9JWi?=
 =?us-ascii?Q?OSG50EYS/DHHpOT4zcUj332goYfHCN4+XDin5L7Lm1ql1yJ+tnsn1ZGLkRyN?=
 =?us-ascii?Q?2ZpvHK8V89uRakpZwbfYBMI+xLfFzgCrv5FEOiqCXc44xLYYWRK2eq9WdbMC?=
 =?us-ascii?Q?RJsTBnnUEDcOfxgQ8CRoJ6+FDAlWNmGtRHIz32V4JOuHkU7iDo2KYx0MFxxK?=
 =?us-ascii?Q?RSJirxwkYgCdXVGBvhAKRG7XVDFEq7+IwErBoVjNLhu1tfMdGRNeH93ZIjea?=
 =?us-ascii?Q?GTPBonZ7/J/3z3vC4u0DwowxPKYF2GQnn7Rg5JebImZvKJyW1QaYdTbEd8/I?=
 =?us-ascii?Q?BAbyUcZnJht/nEWgQRqpyR4eaaGaJCOx+C0lkVeQcvTkSeAeDpAxgK+DIES+?=
 =?us-ascii?Q?Xq1EJAPX31QrgxGZX7s+yYvibnnfJRA6yKZh54GbrTtYs32tPPHAp21Zo9b4?=
 =?us-ascii?Q?OioZFITfRCnnkF1vJluvk/4UhM9Yuj7tAs6h5mESxW5wMn1hG/2zy87FdAqB?=
 =?us-ascii?Q?A77iCkbIUv4UP0eSIWwcS8FbHNngD/Jn7+BpofdF23f2IdSWaHf1DzI5lb6a?=
 =?us-ascii?Q?jbnTqo/9Waotx4SKg0WiZxD7co+GmLj9dvvhrLK2LT9EtbeELNXD0J6GIR/P?=
 =?us-ascii?Q?llDkc27PvuP8c714WjIEuFEwtRn4HYGTq16DUdxyOYcUIrEUrm5zMQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EHwS7YCC79hlhhfWkfi87NZOBsP/+z/tC0MDBrDxX6a/MLsWggGdNke5Jh3y?=
 =?us-ascii?Q?8ahCRKkcWJ4OnFuxggxGH82rhUFWKg6agxYbFKXhXsDgblpfojAGDw/TnOMW?=
 =?us-ascii?Q?Wmp6uThspvff+BdSbKzkR+wV8s4qrq6iwjZlL/Q9XdTj7xyzvztwK3SFWWuN?=
 =?us-ascii?Q?GEoMC1TdjdwicbrwkN69GTqjImx9HNU7Yg/hezxu4HDjSRZtR4X9wAo6t3jH?=
 =?us-ascii?Q?SgEb/Kz/OUiiIuLCo6no+GyH8VGBHjPYVNR4ydGfBd8OYla6IGjdEBr7WAD4?=
 =?us-ascii?Q?dO9RhmfOd86N6KD3iuP5k9ixxgU0t6ZGJHciImUgWbQUv2Ir7tdmJKV0YVSg?=
 =?us-ascii?Q?tj1uDVxbhlHyYFQZWEiFY+YhTfm1mBBpimIiLOP28wnCrrg3fUP7Ksc2rb4y?=
 =?us-ascii?Q?TqTPLOAfSxq9plSIDOkp44hhq45TE8HUIuztXgrSwIj2BrihZ/3gWLnHD2km?=
 =?us-ascii?Q?cFt743X22bh1LsnTaQgn4jkEagmAeN6cEg3faq5icxQy4e89zeOafHzESKFc?=
 =?us-ascii?Q?lsXmY0BOsLat7rUdtHM0WcSF/aBdRg9iFyMIrD/l+frh9+Ahwpz+ypsvQb7z?=
 =?us-ascii?Q?80nBrWfVGUrXAgjcpiq1OgcuEkKKluUR3aKh6Rut23aJCQacEabfKVTQpMD8?=
 =?us-ascii?Q?JaebMbQkZ8bo5+qRAUPP+mdQLg/lZtJSqeE4NOt8XNLNSwgbSen+qpNAqujg?=
 =?us-ascii?Q?kV3y08HN5+d4/VDcalhmNuFYz3nKZYZqDTqxMfwTzfuNb38qO0hc5d8Erg29?=
 =?us-ascii?Q?YkMdBFsGGXjVgaHow9E6ZUL+JcorDJbjIEQnlIV/PuOl0khyPbrOjl7LI0fl?=
 =?us-ascii?Q?6j2hAbm7okHK11VwW5SqXTvuoJZC2CQSpBGn4+Tg+JBACp9tVqXzSR/MBYB3?=
 =?us-ascii?Q?/UZufGpuxRTZcZQgsDgQb7m+/AcXLNrdSW1UgCpMUGL47dfyT9+GVkwnzBsh?=
 =?us-ascii?Q?cluS8D4LmStoxCDMBxCzO+Ht1EA9T5dUPn1hvpIqgESvhLeKiPof8O4zCWKt?=
 =?us-ascii?Q?4bg8w5/3Dk1Q2VqXLfga8cHrAHmcouBQx/It/1VNtMD/8ZmtGJertolf1QpO?=
 =?us-ascii?Q?Hky8MKl2sOuwXG3MEVgYImO1SqDUM51ZwXgU2ykKY1u/5XJ1xDk33TyVHaO6?=
 =?us-ascii?Q?Nv3d5pRbBc6MqNLdnwufpy8yUZNtLN0vBDGtAJ+9E3nvItCR+Nw035RHcqCY?=
 =?us-ascii?Q?6VI8MjLSauueFroheqV0nII99pMdKedY/CpmlPI6XesbwWZ9JxhWVresLouW?=
 =?us-ascii?Q?ifbekpyReDtO3Jkdkif2iLFjzMNps4P4T05W6+eBQ0cMinv8UWHQA/Tlmpxm?=
 =?us-ascii?Q?JBTZYgWE5pv1VkRtTR2q3DeJWtD9pk1fIa+ztJ5pDjskU+SUJutm0rcuXcFo?=
 =?us-ascii?Q?GdC0NeyVEGAyExpogz0TXD/mNCJINZXjvxpHhT6isQ+PqL6+Uiv56F/kkVXu?=
 =?us-ascii?Q?7vIVszeH/JM42R7DGnaMoaCMf9m+fW53ZmUFhUZY8a4Jgku6w1c3v0+sN9aM?=
 =?us-ascii?Q?6aBtiNzarQqjJ2KNjentz7L2LbnXeDFHKh0g7jhfWGR6rkC0SjNnYGe2pO0w?=
 =?us-ascii?Q?jH+vDTrWU+c7U7ZyqNAdxt9/IFFrwiw9iSzvuYzec70cIpgG7SkXN37uZAFn?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89898a95-6c9d-43cd-911a-08dde9ec5606
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:42.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRKb/HSuhd0k9NEnEsH9BfHsrqd7KuYf6utaZj2zzjQFFF1LzsFHkRv38yLEARSWfUnLrpHUdtFugdfMOb6x9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17933

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The need_update check is useless to decide if the clone directory or
temporary directory should be used to parse the submodules. If the git
repository needs an update, it does not help to unpack the git archive
and use it instead of the clone directory. Furthermore, it is useless
to call the function of the class itself because it bypasses the check
itself.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 9afdc8370..31460b19e 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -143,13 +143,14 @@ class GitSM(Git):
=20
         return submodules !=3D []
=20
-    def call_process_submodules(self, ud, d, extra_check, subfunc):
+    def call_process_submodules(self, ud, d, subfunc):
         # If we're using a shallow mirror tarball it needs to be
         # unpacked temporarily so that we can examine the .gitmodules file
         # Unpack even when ud.clonedir is not available,
         # which may occur during a fast shallow clone
-        unpack =3D extra_check or not os.path.exists(ud.clonedir)
-        if ud.shallow and os.path.exists(ud.fullshallow) and unpack:
+        if os.path.exists(ud.clonedir):
+            self.process_submodules(ud, ud.clonedir, subfunc, d)
+        elif ud.shallow and os.path.exists(ud.fullshallow):
             tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar("DL_DIR"))
             try:
                 runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=3Dt=
mpdir)
@@ -157,7 +158,7 @@ class GitSM(Git):
             finally:
                 shutil.rmtree(tmpdir)
         else:
-            self.process_submodules(ud, ud.clonedir, subfunc, d)
+            raise bb.fetch2.FetchError("Submodule source not available.")
=20
     def need_update(self, ud, d):
         if Git.need_update(self, ud, d):
@@ -174,7 +175,7 @@ class GitSM(Git):
                 logger.error('gitsm: submodule update check failed: %s %s'=
 % (type(e).__name__, str(e)))
                 need_update_result =3D True
=20
-        self.call_process_submodules(ud, d, True, need_update_submodule)
+        self.call_process_submodules(ud, d, need_update_submodule)
=20
         if need_update_list:
             logger.debug('gitsm: Submodules requiring update: %s' % (' '.j=
oin(need_update_list)))
@@ -195,7 +196,7 @@ class GitSM(Git):
                 raise
=20
         Git.download(self, ud, d)
-        self.call_process_submodules(ud, d, self.need_update(ud, d), downl=
oad_submodule)
+        self.call_process_submodules(ud, d, download_submodule)
=20
     def unpack(self, ud, destdir, d):
         fulldestdir =3D self.destdir(ud, destdir, d)
@@ -247,7 +248,7 @@ class GitSM(Git):
             except Exception as e:
                 logger.warning('gitsm: submodule clean failed: %s %s' % (t=
ype(e).__name__, str(e)))
=20
-        self.call_process_submodules(ud, d, True, clean_submodule)
+        self.call_process_submodules(ud, d, clean_submodule)
=20
         # Clean top git dir
         Git.clean(self, ud, d)
@@ -260,6 +261,6 @@ class GitSM(Git):
             newfetch =3D Fetch([url], d, cache=3DFalse)
             urldata.extend(newfetch.expanded_urldata())
=20
-        self.call_process_submodules(ud, d, ud.method.need_update(ud, d), =
add_submodule)
+        self.call_process_submodules(ud, d, add_submodule)
=20
         return urldata
--=20
2.39.5


