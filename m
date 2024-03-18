Return-Path: <sjakovljev@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3174FC54E5D
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 13:52:25 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.92.75.61])
 by mx.groups.io with SMTP id smtpd.web10.44862.1710769941328988479
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 06:52:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=fVtB9Cpv;
 spf=pass (domain: outlook.com, ip: 40.92.75.61, mailfrom: sjakovljev@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMiSpZIHcr2/fgLMvvjJEMgTiCw19NFDbeory74ApquyZFADwz3OKPfl4acipcRrMCHVOSevw+KIkmX2Bpb+NVZNdnihXJm2EAFgaIWlcPfTVId1AglHoOSV9tIo1PFqepXiTBpT2sc8SzK8+Ya17B/twLlO8IcGnaRsC8KmjmtTD4x0IipHjBIkI2svsdpdT7M9Uquv37HFDzwW/9Pv7Mks9PE84aYyqdGQw+81tCg3ptuJR4kmNCpx37qhoUhx7PTf2DnX2xRibRESn2PgO48RJ3h9P+ghGOnVIwM42XQuvQEXoE/f9vwZ5xY2GPst7So2KFp0or3KYAOuEw7YbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxD58qZsw1Vggti509+ssDKyA2nS0tuk39GoiMEqvs4=;
 b=QPWg+6m8hTQGeKzmVa2hJkzCJnn3ULQXbO60XAJhiyCaLtJaXQBeEdxwkpGcLwdPfd4dnJJUWRPORLBueclzhIcs54VOl2bn4MkK/cMVUJlpV8WCJjRkrGGeDJi00IUpE3MfdAmEbh8ksHVcEasUnHnLC8crC2sqzXgPYAZrXaGx12nVL8T0Oqb9f7p/iXMXQISZ13xHuQ3CQKH9+U9nMLwR9LoB91tuYcMEw1JbjgQoZJ8wLEVw59AUBZZf/02O37mWmSRjlVRekWU8FEC0dCm9Gv5DH1P32vRme1RwnS+hzPiB+EoXDFSJabK4OZlNelxhLy/GyEvrwz7kVaVTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxD58qZsw1Vggti509+ssDKyA2nS0tuk39GoiMEqvs4=;
 b=fVtB9CpvUUkGnNjV14Iu3hw6CDnHehuGC7asF4KUuF1ieKzOgDnuaEE3Ae5ARahq/dAZfIKqp3Wg+woPaPEfys+CxU4r4SGlyG7jnS4YTSWq05brH6qHFtZ8SG/nasVjh7FelvPuJA07ak5cBa8Vk+3pl7pf1xk3ru5m4F0pojJbWiIL5DXvBts9KWpzdy7D3mNQ0j37NK60WD3DnzUjRjChI+ffnB/RshFM4s3NNFD8TY53e5T7yZgKcDrvY5e5mNJ9mKI7AsO731K+QCXQjo3IQpu54/RIi3om3Ee3XBGonufEla1A9EwSZq3cPSDOhJQ/Mn42cD5+zQ7Y+NScJQ==
Received: from PAWP192MB2128.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:33c::16)
 by AS4P192MB1885.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:51c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 13:52:18 +0000
Received: from PAWP192MB2128.EURP192.PROD.OUTLOOK.COM
 ([fe80::194:da06:d72a:175a]) by PAWP192MB2128.EURP192.PROD.OUTLOOK.COM
 ([fe80::194:da06:d72a:175a%5]) with mapi id 15.20.7362.035; Mon, 18 Mar 2024
 13:52:18 +0000
From: Sava Jakovljev <sjakovljev@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Sava Jakovljev <sjakovljev@outlook.com>
Subject: [PATCH] bitbake-worker: Fix bug where umask 0 was not being applied to a task
Date: Mon, 18 Mar 2024 14:52:06 +0100
Message-ID: <PAWP192MB212823FC83A54439A12DB4BEC32D2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN: [lmbzX0XvNnPEZ76r0i56HIYn2ZkE21vtsfBpIZxL7M/dw+EeasCcw2/AGgTcXOvb]
X-ClientProxiedBy: PH3PEPF000040A1.namprd05.prod.outlook.com
 (2603:10b6:518:1::52) To PAWP192MB2128.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:33c::16)
X-Microsoft-Original-Message-ID: <20240318135206.578532-1-sjakovljev@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP192MB2128:EE_|AS4P192MB1885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e753f76-321b-47b8-f53a-08dc4752a03c
X-MS-Exchange-SLBlob-MailProps: 
	02NmSoc12DcCz9P2aKCrCKj+2349Maa6wwbYDQ11oiRMC5zA4i603I++eWthZHxGwJwWfodb1ALEnkH2M5caiPPxX06cbxXY2r8rgRfYBGUTirPrH++Kj+pkqAQDOSmBYWX/lrbhGuNLBEAjtA1ubi2sjvEKWnfxd61+16CZiA2wHsreExCcprQiKakN2T7Hl0lZJoOm4+cySYJqWHpP2cOP8FrdYqlL9tJjm3ACO+b4s7OgH/ljwWr5wdj88Hh3YJpKEliy0nigELWKc10RmPZn2+fBLZp8FPLsl2xD4PVXAT7A3Rm6vSeMAtlHJn1GgNWdkI5geqjwF+mZujPCV7CZnX9Et/fWhHJWr0d9VTIJrRs8o9p1FikavW6M91HiC0KmgP6OoNQUJUX+S6lPEw/ewS7Mwo1eeJ99b/1SNeK9+WGA77PI/vQS37gCHylLPdS38VcIw+I0t+uaAwLEhrH8B6+iK5Dby/aKtAO0FNELTPzl5RT1gFPmhoUIKWbb7A97QED6wfu/xpno1izRzo0/Xeuu+SHgl68QWUmILXA126FgS3ROjos2wxdAsWicLMJbu1uecAzN0/XSFVJ6XJYgjbJXHjhRyzETT/55RzyoHbNKVwppyYy9WZAV+pzBv0fDgiwEFB9o8xM7EA7JvLLu5nm13WX8FjsZnRJUl2oXJq545IE0Pu7xkauJmylgL20mROtwExI2GWIH93BZVmSpf16jOHFAIorpVyZszZY2NFzleMT/Ss7k2cup4Dqs
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OSvnngxF/om70xIC0nOW+LJkk1Tdwtxrf8KyoEC0o1P6nCIPSjlqDRderxhhgtbkphpG9ZMB3UD5c2VIIShBdXbvyFo7DmGA0xImgZZzncEWOGAJQEMS1q1lFyp5/BO2dsO+/WHYdjI7wS8l+V5lBtgNf37NCYxbFqayL4sAhei0VPbXXPWc2KZ+jLqesSQLeEi2e8w6qmlLjCbcwYlV9/hD83CHHcYrWCtjR0dEJWIzen5PGc2rdkgGxYXX/X66CmrKuaIdmAKS/Sh56mLVNaGzovgJk8ZdhKTMvJupPdM+NnOj+qAJGMJ0nu0cYTmcP6Pb0VFcyqHl9S8SXbyE/CLzeIbT0vBkjRUW2iCsk9eshyzw+K6CoTbl7cj8ZthL2cVFDGtf8a9zUiWzsc73AlgO1F+Se0yHr3xrsrZxEtOdhz3PWsg7E1/tu2HoHxgrWfq8MNJyQLrJV5K3nnCjPmfIPZs5lVbKDpOFFzrFTJbl8+QBPY26E1esUdIJH+FvtRsIAHjMOy5i34Cq/oSOnErHEjDKhd3svCm1y0YAk2anEL7F+syGkRonS4OotX6vemlPfrdPyzU4a2Fbso1Rd9e+TYlMGQcdG659jLWOeVJqbLFgfSbwQCaxu6eNBZHt
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fwLzRUyFlT/NXaNEPxKeCa06REGRZ3X8uBl3wNwGlIsFvpuhUNb7ko8Fi5qI?=
 =?us-ascii?Q?ob1DNpF3o81QtI5JrB0/H7qRGFj898h8v2l88vyOngqVe0Fkzna+iA9lTl59?=
 =?us-ascii?Q?DC1emY4s1sJ/CRKahs0nymqPL3SNqaZDuX22AIPcKL3ykCeLgU+m0PtMgHFS?=
 =?us-ascii?Q?O60mCOYvBVW20nrm4+GTfISEPDDoMaeF8vK+j1uO0o/HwZUCTPBSbwA9pEOs?=
 =?us-ascii?Q?+GdDROzktrF9rq0LartEqci3syUCGzSwEA+BFGr9nVdVYsechTrrM/p0yJo4?=
 =?us-ascii?Q?EE1fjBgAvuBrlWTFduHI1JNA3aV4TtH5WOT3qsw/hHSIaJs8N5kpUwAv3rzi?=
 =?us-ascii?Q?1Eh76PgcgpcVAUTamqIOKzzUNEfIId5VDh763ffByUsnupd7fZgkJ7lZtuvS?=
 =?us-ascii?Q?dgeKX81SQdGJzLmK7ci8D8PH+FsI4pZsljLxIBJI+b4seuwv2Of38KPNhEdh?=
 =?us-ascii?Q?zIgkfYJJFtI+TRCW58Ell1242N9uckzm72nL5p/srU1PpiBh6Qf+Cq/xBle9?=
 =?us-ascii?Q?M4ggZaRBaFsZXp7Qpc7i0z9t6Lj4HQVBGyL2D+rch0EXDEHO7upCVjeuxr2c?=
 =?us-ascii?Q?66AkzWnD8P3686aNtPQcvUPGISdYzD5wytV75S0q2OFQQCnmt7C7eFDrK7LN?=
 =?us-ascii?Q?3WaRhIk8poQoY/Bw0i35O8lbNbpXmySEGzCdBEK86/TcFI2vKC/v1oSfmpVp?=
 =?us-ascii?Q?5gP8cdXGUtttGAtAiuEqMc4qW9YAbUdfMq1S3bKg2Q2CGrjly182pbrPm4l7?=
 =?us-ascii?Q?UPuG6M35rLRLqMMwyQOA/mSu4ETpZ3Am1lOq7mxMSLT7YMObd9XWL2XlUEqb?=
 =?us-ascii?Q?qdqj6lr1MqYGp/UgKmoOlCUWhsIY1tknmUGEovDvUQQvdLg81i2pQM+Eoh99?=
 =?us-ascii?Q?Ari9kTA+X7hxO1n9juZvuLBv+fF6cWrSRI90qN6w3w6JaDzjnyD4SnYBVcx7?=
 =?us-ascii?Q?FvUxpAj5FIS7XXLLxU95R6ldqXE4GmMWUSHUXhdyQ+77fZmDIDboXcu82/m8?=
 =?us-ascii?Q?vSYmrjse4xXEWgVYeH43YtNZEhbrZoJMGbCOIeH2AGVPMUTPPFDcAzcvQQA/?=
 =?us-ascii?Q?sRISW0lhyt5HuMxxsDGoWkRnAdqzUMwS8EUAooIgEtmqBYeIva7IQ/YixWxn?=
 =?us-ascii?Q?gOHYuWFkhoO0DDMyucpzsbUlxfen3Y/9pLmwczrDZYJAFB+1+lLZ/Y19PqGQ?=
 =?us-ascii?Q?y6TipGGEoovPoirjrlgpStBUhnoQEIseEfF3xrwAFwpNJ/8vA5C4eXK8TpZ5?=
 =?us-ascii?Q?6Rrl/CEYFINS9VLrSpN+CXTZPi1WlpL6v6b/2rDCJUT0Qfp6THwjaqAghcSV?=
 =?us-ascii?Q?Kw4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e753f76-321b-47b8-f53a-08dc4752a03c
X-MS-Exchange-CrossTenant-AuthSource: PAWP192MB2128.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 13:52:18.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1885
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 13:52:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16000

* In the current implementation, "umask" variable is initially set to
  None and overwritten with user-specified value. However, in the worker
  implementation, a faulty if clause would only check whether the
  variable contains a value that evaluates to True, and not whether
  the variable is defined, so the value of 0 would lead to umask not
  being changed.
  This bug makes it impossible to have a task set its umask to value 0,
  for any possible reason it may want to.
  Fix this bug by extending the condition checked in the worker
  implementation.

Signed-off-by: Sava Jakovljev <sjakovljev@outlook.com>
---
 bin/bitbake-worker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index eba9c562..04d75701 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -241,7 +241,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, e=
xtraconfigdata, runtask):
             newsi =3D os.open(os.devnull, os.O_RDWR)
             os.dup2(newsi, sys.stdin.fileno())
=20
-            if umask:
+            if umask is not None:
                 os.umask(umask)
=20
             try:
--=20
2.44.0


