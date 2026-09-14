Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B988C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:33 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5040.1789411380447216858
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:43:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=xXVssvRq;
 spf=pass (domain: est.tech, ip: 40.107.130.39, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APvAOh7eJpUtTrFnNMLVX3aCavC9o6CbQsW2xBL9JWLAStNwObv0vEhRxVXNqDiT10/Kk0uYSestdIPslSBnZ/TonX/jpKlmdfPoIcdFcFwSOP2TwnJF3gKw/9nSbnp5J3iYl5/Kv5lzBlpkR6jOOhVnrvtsUvV3MbAA2ttzXVosOP88r4MLlo/fqQlOGzgfNYQe7XCNBhrO2phNwyp2Sdhuru9z2eQOeY5ipJHzxaqr3WvGhJ/tURqm8/GNcSgiPkTD9vMu/0Zbp8dIVe1tRjtR22GYXucSHQvMioNvZ0PJvYmfxZP+jsvEyhtOSUxp15DTPhOGFrEpvbcYn51DQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgLB5ro8HRkZthOj2SUtH+pvEXvrCTECi1UCRoIh9+s=;
 b=uBTKDRhNEQsbeJ1rkTNUmA8N/ccCU/P1RtULohVjD8eRXyye5m2l+7wQ8lWKiyogtKjrhGxN0h+V914iZxWFZv1PrFp0p2GsmPgNC9bPOAUrkGQ8WHbzNc2y5xgADWtLtCEQ03Esz3wKBbuMymA6MYvqbFNCeLk8UztmjzvMt3JQViTblZbAiJvUE2hlTTQjg5ZbPUP/PxP2VHJ/Q0YArwPArf5v6LqRKbS+IzbMeC5giZ8zUytA+HBxrrXlkfyIRMX/wOrpPO5nJZunkmSUyELMU9B+DeZ2QSHzrFCpsCBXqsUUBRDnu6JSbNrRDP3FuvGG7EDMEQSojsC+K+wWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgLB5ro8HRkZthOj2SUtH+pvEXvrCTECi1UCRoIh9+s=;
 b=xXVssvRquHt7XY5JAk64L6qqwPavXlPtxJ4Ndk5ituAD0nE3G/0AA4fVtDSNef7uFjO3IVbL2x45jfcDWvz/rJrlo0h+A9Nm0o6Jw1bX7C6IaiCd5/sB9u/oIPYiXpXyJDb7fx9q4fnpO1ivTWEYbcH67dLzAvnZFX5wUlqQm3Y2P+//soxUF34Bs3lPBkfXFkpAiIBiU7TaJpu771J0F1qPVzQGDlYiNT31klpQJlYsGSFARvKWHgS/P32ZUE6tYtyYuADfSAKWfEU2bWhMvLVmV8whusMLdMpunU4JX1rRpdmJUZ/MnsskpH2o6KRC2JExuqDbBlSudwCfK7pe0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by DB9P189MB2051.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:42:57 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:42:57 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:42:23 +0200
Subject: [PATCH v3 2/5] bitbake-worker: Call landlock_restrict_network for tasks without network
Message-ID: <20260914-landlock_try2-v3-2-4ea504789675@est.tech>
References: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
In-Reply-To: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789411368; l=989;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=2CYKypWmovyQoJMbLVs3ifcwFkR2mPiZOicgM2mjvlk=;
 b=UWRQ+X1feNtWbIZAL+k1rFeBtDuUyR/QCPkMg4NpfTMV/9DdD2dkuiL4Lvw9eOPkv4g6IbUZ9
 XxBNF9R1x+KDYvpOksspCGh7Y84SlMrVjI3HaM+mbCXnPm0EIF5COAF
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV3PEPF0001DC3F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2e6) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|DB9P189MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f1d80e-60c1-4022-6b5f-08df128ffedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	fHnE7BQDXIbs+e7pe9HBqsak960XCSQ/IsZavVz0L4j7PrzS7Jt5tPVcS+DybNToksNa944yXzqwzb1KFQd/KnrBDfOTZlB7QYc3XtF42r/4iRK1m1CdRAcvBEMNl5o+1yZxtCdgZqq+m5L9OT0bw9jcFpSP1kJhBOx3YK0bNy9jf9k6nAxTDbTEZnqzwNTb7U1uPrMEgTfg9RT6g1e4r3BHQ08CA6yxHEbTBS9S62DRsC29S5OkuJC7m4ZxWKZBNgdhndPyM3jGidJnldE52BguDKH/GoOCUngVkVc3QlHj/pdOg82l3NF/4WXc53tuUkPotQ1RAU8wVRCaVUeTHcxjW8eyZdzkLqPJoFy7Gn4TMQV44GFoWaLd0c3sqPhZvFN8euh6rfePu85VOn6dEcgZcyejqA71fSOKvt5TcxaK9WabPIPz0wPGGa3wBJfDiq6Zr9/bC9NOoQlBLruLC9FabVPF1C088LiLV64jWnK8+cD+dyMQkpkFAkXdG8Yu5v0j5WnMNvgpV5vm1tW8HwzAMDI2YwlLhaGz2okchMJOvenZ64fOTKK5zp8PAGbl5kP8A8Sm1mQ6IiNPHHfnrzMoTU4VOm1JiDra9/HuruKv1nHFC6JRm3+H4tmZTF3/AF3+YsohbsR/PFRc8nt/RF76gPxdvcXKn7W1zgVHhPA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cWkqWI036gX3tqlp1eR/eZXg0aYCFIME5UjWMFnFcaviVCNudsu6J2RjKC4d?=
 =?us-ascii?Q?TIDmxIQBPyHDE8Cm9Udw0yG8pbHJC5IJpImhoezRuRWalO4KZC1KC1Onui3s?=
 =?us-ascii?Q?fikL9wgfatMPxn4NOLHjOpattWAqz7pDihAvWWXHb0i23SDBzob9JTgfwG4J?=
 =?us-ascii?Q?70xErFGWEmbchHkA5MWMG4x4GgTfJiy7Wb/lGbRAYYi8lYLWnWdQ18FvqP5u?=
 =?us-ascii?Q?jVL0qWozji8ISY7X0ycuAJhSRr9aJmXDpD7OI0khi+7QZEn0UcBHEirNCK1i?=
 =?us-ascii?Q?bFOC/0mPPV+28gQUyJfe2Vro01TPP0S3wBzs2C8PGoGv8e/CswkgKHPl1Rk6?=
 =?us-ascii?Q?rzgTnsag53sB1MVPJQ2DR6J6knbMQLDH6UPmHVBex9oV+KSBXdSqroaSU8ZD?=
 =?us-ascii?Q?3WL1bl2hX/lKad6tF80m08GuQvMiqadjbhgAB6IcmA4XhiXLlS25mHraJOPL?=
 =?us-ascii?Q?VEGZptHMGyUMp1Vbs31UpWOvnaHBO+mPzIW7scuuI8qIrkFPM4qRhGctgLzn?=
 =?us-ascii?Q?G+uVHsGyQG75fme1BgHcx540MMabEyD1LOEgfRV7e3fnxGlW6YpzXQ7cjx4/?=
 =?us-ascii?Q?LGRlUgbVrOUNXnwaj6FE8vx3JVt1/Kivfq7z8FLA3+q5K91V9ypLkal+lvcA?=
 =?us-ascii?Q?MfX5lx+OPkHLquxBlxUKpZmIIWWPQX9+IriYrvYs1UVJpH3cdfnRSydPwlxz?=
 =?us-ascii?Q?1nhFu8Ikh+JsC22u1q0tKJsxc3OGUDhELma6V4Jldg8tvzJz+Br+PUun+hcl?=
 =?us-ascii?Q?MvW4qJQXQrENen5yH4mSlsbCRHvRApw4jGJgi2ZnrISTFr8Vd9uekERYQL8r?=
 =?us-ascii?Q?vCvooF7wFVH55GUuerORA6YyTLL+RyRJm7MvowIR7p+Y9wLTGDGsqfsm0op+?=
 =?us-ascii?Q?546jv5Bt9mG6Le8eOdE0knU5MfiPwBr3oVlUJT+qub8lrOXM+LrjGbj4rzRk?=
 =?us-ascii?Q?9BaWmez9y2TUCfc0osgvSRaPHfjzBPfJUM/IpH0tfHeW6jbO3VRkgPKTMHWI?=
 =?us-ascii?Q?eH20X4buIXCgDKTeE5wulZQNmU+70c6YPCY79uJKIKibLqNSJjh454R55p01?=
 =?us-ascii?Q?Wyj2qNgRZpivhgOljWUlpnuQKrC5AAJ+WzBp+O5Te1jsGen2E7wnJgg0SInJ?=
 =?us-ascii?Q?D6XXIQKZ9FLzBF/YlvsjIXCjsRbAqbpdKALORdQmXNoPa2BF8gM881hmyXb0?=
 =?us-ascii?Q?xC2J27VgpLb8WYYy34R4nEGdvMtxWiVn747ydCLnymUxJhThYZqOtJONFIIw?=
 =?us-ascii?Q?pdcWd0b2XX7AbzqR0r+ODEtiVnKiLJdUBJzUMYWkVID4znjz4EU6RR/qHan3?=
 =?us-ascii?Q?DVKvwNT20kFihz+z5aFesSA1taSVVqPNp3d4M7rifz4cGl+GGB3wQTTx0a17?=
 =?us-ascii?Q?9uIwaNePO+4BJSvXuIJv+RJg5Er/fJJ5aRLdexXjTgb/g6eawxbOPZx+lnxu?=
 =?us-ascii?Q?yT6GXyLPOxQj5La1wY9dVmgVxPXRibe60jGwGxT87//oPfdBht5xb9twqNK9?=
 =?us-ascii?Q?dgDS5UnCXvE3/qu3SDAeTq3G4E7DQEAzMMWZsscHWX0zuUKeq8wbFr8dESuh?=
 =?us-ascii?Q?eTGKr7W6QOY8FUfNvgHFJ/24ZNVYv3ppxJzm2DGQ5/H35Dxhv0wbVahiKQOI?=
 =?us-ascii?Q?f0VCDMaencSiKwtRZxmJ51yVLcsIBsaBghQev+yL01Ha002dQ+6vpgffh9Ud?=
 =?us-ascii?Q?7GntuGWJCCspzxjQhoBlgqxS5Gz59Ht8Eypt48W9ee5oyGPrU3n9xKNjet0f?=
 =?us-ascii?Q?Y3vFlR0h6BN0KbOpe7PmSWZHTmJfPh02wNyElCZR0CkmegQib861n+ygrDen?=
X-MS-Exchange-AntiSpam-MessageData-1: CnRpA5YQhJbvBBGpgYe6dp1FUL/4I2/iSpY=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f1d80e-60c1-4022-6b5f-08df128ffedd
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:42:57.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FWDpCmFYb9cdec+YB136LTFkwE6OPdmhYtE1zUtOFOk1Oj4lvSzuUmHPlOh1id6niaYmmt/twroeW4XswxcCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2051
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:30:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20208

Call bb.utils.landlock_restrict_network() for tasks without the 'network'
varflag. This to support basic network restrictions in unprivileged
docker containers.

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
 bin/bitbake-worker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 208f512fd..50380201c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -293,6 +293,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, e=
xtraconfigdata, runtask):
                         bb.utils.disable_network(uid, gid)
                     else:
                         logger.debug("Skipping disable network for %s sinc=
e %s is not a local uid." % (taskname, uid))
+                    bb.utils.landlock_restrict_network()
=20
                 # exported_vars() expands each value, so it must be called=
 before
                 # empty_environment() below: an expansion that shells out =
needs the

--=20
2.53.0


