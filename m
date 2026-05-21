Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2312CD5BAC
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 14:36:51 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37972.1779374205403716172
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 May 2026 07:36:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=wpg3m7Bk;
 spf=pass (domain: est.tech, ip: 40.107.130.1, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAVe1e5Avk9dXzzzLm4YqgtO6/yLzl2wSNiew37J0EdeDRxEEJzJJWnIR+55GsbAPFqUmfOlm5LPQ2rHMOTuym+kR9yfb+LKXa3g8Y7VQdLNZ9gm+jnDOxUtLZlPLssXwEGzHYYnJXUDLglrAa/ZpwRYpFi9QoKrUo5KUifr5qGE4BP7anZ37h79jjgFqrmLkvAIBMocbR5ATfyYzRWkpMgOaGPgNqGtu4ChW/Z5uoyxjfMW0xR+nxkzi3ErJ5Mf33hhBrgRhBvMBm1wxujcb0maX7uXmIt6ZcK5cyrvNd1uzexvEOvqnyCW8r5/aSgdLPR1uJ1RawVrbercAFbU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3jY6wpY9dKCl9K9XA2Em0JRnRlK+L0hEeVkWNPQqfA=;
 b=TkW0HqM5a22SJ/ANQo2ZJghGLsWw2dC04vnVLYZaFIGrqa5FuZ5YqpTHEUMaM7zhXFjtuYxmA+7syndOR0ZzsxNPObRfL3/3aeEu7/CQswLduREyZ7vDmy5z3bxBg4EArTktKiuW2ztfHGomsH36kTPdcjNBzhKzskEHT8/taA+iNS3D8hjT53vgX9YsKFEHChB1p/Bmf83lmRo0fCNnwvXHzuge9T06jCIYFtLnxg/MtPyd45ONShy8LqFhx8WQ3xk6H/J8frM7BvD+jO3QMR04A1wMMLPHltE2hPly7HXP31XXK7IkWOzH6uQYfVC7GopaTkJEmyztjflAN1AVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3jY6wpY9dKCl9K9XA2Em0JRnRlK+L0hEeVkWNPQqfA=;
 b=wpg3m7BkSrqwvQf6597G2wMEB5GR2r9Yx0ZMJW8qMdVePZF5CKdO/W7ZktVqVXRn47U/S5BmWnkDGEkOyh6k0/ar5X/0CQbI7xvZdfu0gTI72HbiHTSO1ShvwU9TFtm/CbPLW6XuX/1NrbMKPII3rohiBa6afsUNDUpgr6vhcuc/Tm0EN1uQXJcQ0Wt06ykDfWR5YrEhPsp4yXN+yHnsgDCAETdbNRXE/cy/aSaF8fHJvREp3XKEqFeXKc51ERDOvw0hQ18dbibuhZTmu2m6stWLi5Wp3RDJlwxC9sxxWYc/k28/BwU/hge6viyLNlA7hEscqsVrDZTorrAn/8OUsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 GVXP189MB3402.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2ac::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 14:36:39 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 14:36:39 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH] fetch2/git: quote shallow extra ref arguments
Date: Thu, 21 May 2026 16:36:30 +0200
Message-ID: <20260521143630.2108749-1-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0204.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::11) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|GVXP189MB3402:EE_
X-MS-Office365-Filtering-Correlation-Id: 7771661f-2b29-4d8c-bb0f-08deb7465e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	Ip1NNmgvxypuhYPHS8j/ouxk0gPv+INdys4vZwKJwiNVbi85zAEWUOTcTdGse9C6WMBsx/xEmkg/vaR8wVs6v+YPgGBqJRw84w//KUZ7fHE0Ud2mpfJbnPiYUtUEJxjRMONLFy2CvuDsE2WSqGb5K3/ZmwriN/eokrbQwpNswEHxc5zzz1a7dKd01YcGP1u6nFDAeLXNPz/Gm5d2fXhjd0dem9rJ0pd1/8nxxxD37vC2rtgQH6fkcKPkiE/PzE3oltHGKxfEDl5jPPlqYl+2mz7zL9Ifp4aQ0jxN4OnNjpMYV/dcalpjWUzffGFjVZQqZ7+JpHQMHF/0855vFMUXsxv5mS7lKWldPChLVQk+ReC4orwTWdXtLLwqjSbft4QxKSALdKzItc8hdSqAUdVPg+DLx5xNvyYOYbmkrPzs9748181WxtLIreCQIRv2NDfcj8Yk/c4M/dj7M88ceq4DTZzECY0CsLpE1qoEYPyfudBcSxv/5gdXpKnNv47yYC+QfnevuIdw8Wgw1dX16DP6NVpBPMF7ebYZ9ZBV03smqHvQ6ADHS0mtX/XvMivjYigcJoUijAhmLqi6hV21mPszNql2yOreVIGffLEy5VzuhSWB6F9ujJTUR5WOAk26UgyJRKIA5U8OnMT3lA5hNQmfXfEHcNWNucIl21jIqiOJmuK8zA+8DNV+ar0fcg7xKkrw
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rPCUYF3q9l7mobFUERF8S6Ls9xT3wqmzq+ECNuSchuO2eLaPG+CR2oLgxf0M?=
 =?us-ascii?Q?EyNpjkrNDR/mDf21X5W9OqL81b/Sf5UXfcoZRnsOCJmhd/V/JOQvFAb69zAS?=
 =?us-ascii?Q?o5T8u6Belp1Uwhv8nX9iCMhOvnPjqem8uby973N0teVxCOiu3GWKzYMkmaGg?=
 =?us-ascii?Q?1H0Qk0x+/q1wH2jPI7sC1Zd8Q2OKqz/MCWpvicqi9nvJiLkaD6wiiBn7vPno?=
 =?us-ascii?Q?StVh7Ibo0cOcDi8wrIUrnv4OWWATOncqxQ8LvKc6Fo/t31LQhvCWYFV4cNOM?=
 =?us-ascii?Q?dUVVHPWHu0xMzsFqu1FgCQqFhWaDnsZI3x54mNWzdFGLSMsldL4QGYkspC63?=
 =?us-ascii?Q?IZdWX6qTMk6k/Zdf6TRHvmzKL8fnQx32rhL3eBH+p+VTX3RZWmoyIZ0cxOuZ?=
 =?us-ascii?Q?6H5gm6yjEak9dtnB/YrdZE53fhpFjE6d2HdpyuW+II8Pb68zAGRKR0HmZ7Cd?=
 =?us-ascii?Q?YJNh6iElndYrNjS1q9lQyoNixM+MZJhyZZZWp11HtwbgbJWyAZSZfSd1vlgM?=
 =?us-ascii?Q?M3FOpInh2kd8YYdlJ83ASM+gMGhQSI65/3meRwJzDF1DH90aVhTQnDiC1Ibh?=
 =?us-ascii?Q?DhRb7G8esqjBvDpPlhPXxnLxcHOozyUrH/+n6kEEAZOh9Ar2lNuOBquz3xe5?=
 =?us-ascii?Q?8TxnyqZkbSxVTfYlJErUS9gmDzgAR7Cn98rtamxa/xXL8/j/CDK2VrYZaK6E?=
 =?us-ascii?Q?ilD5FgC3J3NiVPuFtBnBzUTrwFuH7oTDtK55uqo0u0bzMLN5G0lUzDl3wGHG?=
 =?us-ascii?Q?JqZeQb6Kb4o6FtrhhoVGkhJvbL6ATKPXifBPGNecXFM686oCRgpM/l2FlXvK?=
 =?us-ascii?Q?Ar209Kdd2t9y48kK36snOR9bJkPQ05NljeErPRoEfabrw8FPatmqmRZuQnko?=
 =?us-ascii?Q?Wh9fsdVfjz1WD4GkHSKgjh3fUjT7o4L6VTkRUVaDVau1h8e8nShtJt/Zi7jw?=
 =?us-ascii?Q?GJDjfUiQaY19UoOC9XUiEftm1I5OSneZZMU+DSEiSNsReCz6hdHs7HV6+ol3?=
 =?us-ascii?Q?sI1iNDZgzNFjNyhvk4GCpFBM7oUUHBiIy2bWuJQPFBEcvwNHwmQmT7GxW1fo?=
 =?us-ascii?Q?CJPj19eTkAavPL4oe9DrgUK2OwuNdMmiePxniwgqgpcZq951hIwV2Sflp9ZP?=
 =?us-ascii?Q?h44CwfKKpkUmwSWObhFhqVZbdazZiieC3ZLX5YU0KRo+SomQC0HlQhosoGT0?=
 =?us-ascii?Q?6FfNkuRdg9cC8Cyznti6u/FbyJhkxIW87xq9sTbQ6xJ1F42+fKvZIpYiP0Yl?=
 =?us-ascii?Q?6vtmbkws0gGmA+Yj0G1jL2BGk8PXDsmudAysodyYEFlHuESxPXICXFXGjAqX?=
 =?us-ascii?Q?yEcod/yiCWf6S6MU+MTO3hI+qLtBjiaaKLdlD284G3UXpYjzPr5qJzIfqAh3?=
 =?us-ascii?Q?ogEykhdrcDLOhZ59uGQA6bO3egy0+r8bFgW4oXG2RJdSNtAx+kiybnVUFxcq?=
 =?us-ascii?Q?ooh+EvdPQl61HwitfWcU3qx5CmKML0nywqqmej/jqNkHMW0F6E2WgrZaSVKa?=
 =?us-ascii?Q?YlJGNwP6WGrK46veaz+sEZ65/QevqGry2o+Isy5SZic1nXcDWlGb9WydRFnH?=
 =?us-ascii?Q?VJd6zjuxBLibiC39rATGZx/6t4CO9PDvVcqigp+4YeBGCDhPs9M/bDX0uYe8?=
 =?us-ascii?Q?e3ktQpmXwsjWrH/1870BHwJ1JdhMTtBGK24qc5Q0i2Z+oVDZEH43CEURJLSn?=
 =?us-ascii?Q?/t7xxvGuZQHR+DML3bYJOYDNhn8Ot27JzndBkWZo1O5UIhX2+2GfL+WGwmLC?=
 =?us-ascii?Q?0s9LZEeafA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 7771661f-2b29-4d8c-bb0f-08deb7465e53
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:36:39.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXLreJLvPRf169ah4aYW7FkV3jIPOL1uNf/LoUdPFWhMkyt4Lcxxy99UnS77aWsAWZN78Itoxu8T5hYYxDfOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB3402
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 May 2026 14:36:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19547

BB_GIT_SHALLOW_EXTRA_REFS can include wildcard entries. Matching refs
advertised by the remote are later passed to git fetch and update-ref
while creating shallow tarballs.

Quote the generated command arguments and pass the fetched ref after --
so shell metacharacters and option-like ref names are not interpreted as
command syntax or git fetch options.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/git.py  |  6 ++++--
 lib/bb/tests/fetch.py | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 01bebb764..f5f0993c8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -644,9 +644,11 @@ class Git(FetchMethod):
=20
         for ref in extra_refs:
             ref_fetch =3D ref.replace('refs/heads/', '').replace('refs/rem=
otes/origin/', '').replace('refs/tags/', '')
-            runfetchcmd("%s fetch origin --depth 1 %s" % (ud.basecmd, ref_=
fetch), d, workdir=3Ddest)
+            runfetchcmd("%s fetch origin --depth 1 -- %s" %
+                        (ud.basecmd, shlex.quote(ref_fetch)), d, workdir=
=3Ddest)
             revision =3D runfetchcmd("%s rev-parse FETCH_HEAD" % ud.basecm=
d, d, workdir=3Ddest)
-            runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision=
), d, workdir=3Ddest)
+            runfetchcmd("%s update-ref %s %s" %
+                        (ud.basecmd, shlex.quote(ref), revision), d, workd=
ir=3Ddest)
=20
         # The url is local ud.clonedir, set it to upstream one
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quo=
te(repourl)), d, workdir=3Ddest)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 969e5f876..0d68856d7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2065,6 +2065,36 @@ class GitShallowTest(FetcherTest):
         self.assertRefs(['master', 'origin/master', 'v1.0'])
         self.assertRevCount(1)
=20
+    def test_shallow_extra_refs_wildcard_shell_quoted(self):
+        self.add_empty_file('a')
+        marker =3D os.path.join(self.tempdir, 'ref-command-marker')
+        ref =3D 'refs/tags/poc;touch${IFS}%s' % marker
+        self.git(['update-ref', ref, 'HEAD'], cwd=3Dself.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/tags/*')
+        self.fetch_shallow()
+
+        self.assertFalse(os.path.exists(marker))
+        self.assertRefs(['master', 'origin/master', ref])
+
+    def test_shallow_extra_refs_wildcard_fetch_options(self):
+        self.add_empty_file('a')
+        marker =3D os.path.join(self.tempdir, 'ref-option-marker')
+        helper =3D os.path.join(self.tempdir, 'upload-pack-helper')
+        with open(helper, 'w') as f:
+            f.write('#!/bin/sh\n')
+            f.write('touch "%s"\n' % marker)
+            f.write('exec git-upload-pack "$@"\n')
+        os.chmod(helper, 0o755)
+        ref =3D 'refs/tags/--upload-pack=3D%s' % helper
+        self.git(['update-ref', ref, 'HEAD'], cwd=3Dself.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/tags/*')
+        self.fetch_shallow()
+
+        self.assertFalse(os.path.exists(marker))
+        self.assertRefs(['master', 'origin/master', ref])
+
     def test_shallow_missing_extra_refs(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
--=20
2.34.1


