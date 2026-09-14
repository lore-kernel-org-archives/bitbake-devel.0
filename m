Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA03C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:23 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4863.1789411376476842971
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:42:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=tsj9kmM/;
 spf=pass (domain: est.tech, ip: 52.101.83.25, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neG4r4kfebJKe6Q3BiPjdl2mznzXfdmdNY9XCKuEsBmhPxSlOeFoQFpKyKIHlDPECiUAvUjIIBNPfDeaLMOwGGfc9Wgt1kavn2vjxJT/bQVD2l0F8SZ1Pbtgs3hjEKHnh7qZpyXdzzIHya4XGqNCthboMj6DvKan1Hgyi3m/b5+7yXkb9/eFulzL1wAHLorAR/jXgJ1igNEt6i9hHDBXCS+r24DtEmbq46QrdnRtuTceU3AtT2DvP9WpfEADApy6YRgI9KfUTDLZ/OrVE5g6GUSwMDMCi64dLB0dqJuh6brzbV/8aW0YZrSjmAUJRhHNWULUL50QYAK/phkSe8SLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0i+oTIbEu9eJhhggN0PNveTxd1KhWiplrD+vzPIDLs=;
 b=HxXr8FbglP6wK/yd1JpgSQwvB7w2g4wsOB6L7VRF4B91I7qW3Ghr/cQDecUjrWNsl/T1/HzUtHv4hu1jyr/cLkpCotehMe+6+LjUnTbsAX7c7nhmZoPROpPQK6phzXi+uYSN4tCkLLlzLmSt8DXiMOhr4v4rNAVW/jP1hbr+H/b354gExnUEI55jW5rXN4U0WnXonNnWBwneDBBG5hqoXq8gEI3wR+T75gOd8HzEyu5VcDXFzDlZFsD5lcRN0Mh+JfWv9A5KdVZkEwcXQN1mvYAYgBPjDJOmlaaKh9mWIevkaBUoiiFcCitiqrc/CWmrUWGC+ds+ppvNmTPWZFSNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0i+oTIbEu9eJhhggN0PNveTxd1KhWiplrD+vzPIDLs=;
 b=tsj9kmM/eJEoNOBIreNSsFKkaAhQTiqXKLQdsXZldFx//U0uEerAxaJVntiUWyE+UZdlrruAxX1cCn9+gzRDeo25y70fJRpxsY8qp7RTqM2qGf9Pw+xQWBO8l72DraHsRSySOdaKcNDRYlSe3V3X1KLYVcXjXKKZlwWpL0i61zU1cHiq5BRSFo+5ydqjf6nn984JHp7EfoySBOYDqaRbCevEeuTVRF3H+wtQQiyiCg1I36q8NAZYb1RB4q0E5QDrrpGJ4sTPahZFiT85alevhHRMQe/Hq97UCEhKIFqYbFWWcwpXKhnwvSOrXCEp3gwuPtd31ehSX48bsueBtz4Yng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by DB9P189MB2051.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:42:51 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:42:51 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Subject: [PATCH v3 0/5] bitbake: Add basic landlock support
Date: Mon, 14 Sep 2026 20:42:21 +0200
Message-ID: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NywrCMBQFf6XctZE0rYa66n9IkTyuJloSSWKwl
 Py7bcWNy4E5c2aIGCxGOFUzBMw2Wu8WaHYVKCPcDYnVCwOj7Ei7mpJROD169bikMDHCu1Y2nGr
 VooZl8wx4te+tdx6+HF/yjiqtkdUwNiYfpu0ws9X7tdu/dmaEEipqKXRz4B2qHmPaJ1QGhlLKB
 1epbw67AAAA
X-Change-ID: 20260910-landlock_try2-794b370dc4ed
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789411368; l=2741;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=Vne/a5bdgTTf6LxTXlBcaIRxm3UrTOj4MOFEruhX8Bo=;
 b=OT1HrsoDqyhI4Sm/xgy8eifWo1yzK/RJ1mUxCRW74KkI5MA6Ka0rwGII293M314ztIiD0kFjm
 rrCgI+BlrnJBhemwp5z6FJ6aLi1hDNzkWxf+NLax0O5mjnCV8/TZwo8
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GVZP280CA0044.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:26f::17) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|DB9P189MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: 842fd0cd-2731-4602-40f0-08df128ffaf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	2RUgF+/0d/wRONmI02Jrn787q3QKZg4LEV1jEm79LdPcYoD6kCbR4OX7S0eyfwQBn9euHzN002KKe29Gw91R+5DsnqpcDgEe4T26vKn45whXgANBpf8oAjEeKMT5X06gRADjZDJR5vw2dfyE8rzj8GNrF+kYixrCD1hhR4gTjkuI53GyQC4IulqigKIKXyIVwYkrhYXOEW8Y8gtMGC4PipQ31nnM6xxAWtkadrcYJAM4U7a+CIrziGynNS38adz9VGgMa82OH5+XRnRW3gnwOZ3b1eRSyz5x2oG048eA+IWEEU5GotVwIlvrghETfjlS+cSHg/RDVWYraqXZOKS3s4jqW1o6LAmcR5MOs9pTxP++7y1b39keejF+BaA5w/coq2RCJlK5AWRXplt2u7+C0+SyAs0GTtCOjP+gRXH3u44ZeEUS+McEipIyz7urMvbTpdWWIQ5nFBXaY+Cprvf1hP+8IHVyOQQAUEtpo3PPU7p8d1FaiSNFmhKCY1mmDonaxUmPMUd/JidEn+Unfcw+mehTrUm8684ScSHEleH1+nSDfKRAx5f6dG9WlsaLQ0Pk6wBKC/laOn9F8vY0Fv1qhsAuyTY9Z5/ABbl8x+XthL2KQgNrf5Km9ozxt3tln29w
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jGb8lwFbbKN10qOXqiiNz/N/6krsM4UHxYYKxUGCc1Qzf9mhncA3HSDrnFxf?=
 =?us-ascii?Q?Jy8llTOZYkEgtQdM99gZL6T2gShESCdANsI5InLH2qyGrMu03u6W9VK2yZBm?=
 =?us-ascii?Q?BBOr/Dmzct0YEGRV/7DPOwHQh8CTc515B5H8jGjqUBLnZkAfKYX4xaBrefvr?=
 =?us-ascii?Q?mC96WScTqSaU5/ZOwo9U/Mvus+0YQ7+P3NzqI+dRl09S8ym/4r4hEGZyl2sr?=
 =?us-ascii?Q?lryYJ/ukbMdJKMQ2BF9/ZlJjXTizsSwZmlmlxOVOc1h1CNM3jvnX6LXH0+IZ?=
 =?us-ascii?Q?LkP9E6uRa4Rwf42s8LDS4FNR6rSq/fAihOlDAuRtoM133DNt+3xcSlicyTZ5?=
 =?us-ascii?Q?xpIcBZnIc1PVKZ5LeoTIu5pHZqSXI3dsAAhu+eXG3/U2mcjyaKyYqDNFXgzO?=
 =?us-ascii?Q?AeAXtXCsWykfgLrW3z2Ax/APnTdkv/vBMpaxcMBuPr4i1I7nIh1601r6ZdNq?=
 =?us-ascii?Q?JDJhfa1svt7CCELG+MO3AtUZe6bdi5qJsLV82hDW6nEd82TROC9eODa54zZh?=
 =?us-ascii?Q?5TTGx5J7zOjqNajE4uubSn3IEcqSJc9Jv01G1c0Fuq9W8Xhx3RJ4V4TIZV+D?=
 =?us-ascii?Q?EB5hzrjKVuyMiFT8RTJbRWFlHif46fpIdNJQSuUF47gwXWuj2ccUZejtdjpA?=
 =?us-ascii?Q?sdv69Kzg2WPwN4XeGpn3XNRficO5fm+oWOKI75kz+OW/KiO6tlCqZ9GOUe4T?=
 =?us-ascii?Q?7VZCtqJf2nQcHuKjhPohhnjEybi/PEfAfzFAZTCvpQy1HRtfp7V83s+ZgvP8?=
 =?us-ascii?Q?WorCWtPeELjV4Y68+xgH8NFxLSXOPiAd0s++Eceo/Yd1/0hbQ+j0nACzGBHN?=
 =?us-ascii?Q?Bpfba7HwNVgdBne2ZsTHMY2Vyt8tw1eHR3pjnlTq9ElNeAW+jYfUO+L1JxW1?=
 =?us-ascii?Q?viU3Syd43fKi06rmTG0iZ/6UstC3QbFJ1rDM2553vBsrCC7CQgoWbMiL2BgF?=
 =?us-ascii?Q?5kXxqmW4ZlP3N8Ml4wrdnWJtcxn5Yhvz5+LSXiT36u19tmNqKvkyuamFSUd1?=
 =?us-ascii?Q?SWo+PCe4yEyhnJa2+bBRgrVNiUTO6mUuHddsJ7NuPtdBOcUS7Gd2TieBUe6c?=
 =?us-ascii?Q?EG5BG8k4Ls9aKupm6Ov6fmwVHcemBFoCW73tTiux0+U87wFyE+X5LBln3DPC?=
 =?us-ascii?Q?yGfTEpwCQgJiGhCZQvQu4zTQktsxXyMFmMu3r4/PsD4sO9tdVDTUyGncksau?=
 =?us-ascii?Q?TsXWcKcoNpafLYmu2Ite1ND3DkRIxZMNWYbcgQ3mTAWhVyOYlt0dOv7pgmux?=
 =?us-ascii?Q?vk4ps/CdcPKYoMu/1WTTqD+c0V+vS+iT6yDTa+cDstiiOdXsALmgJWkWsiBJ?=
 =?us-ascii?Q?X2rgCahVk76Mm7+O6ciLs80cT3qVzztG3/tJM3F8Z1BiZv5RSh7zwI2beQTL?=
 =?us-ascii?Q?pvvATv3h9WPYXixf4stKUV1bzB20izMXI/iwCbIAWxNJvJ0HV7XmaycIsDqh?=
 =?us-ascii?Q?wEorUA7N+K3AP3TRoVPdXtDrbxBG9CWzBiTJvi/5gQrLxAgfUiY/1jKELUtc?=
 =?us-ascii?Q?bfKBJa0jYxzLUIuXJ6IQO7LOyVhERPrHnEoCzxJDBfPftm4nYV1V4vVRZzDm?=
 =?us-ascii?Q?6SkVngwbgNQitiF7coAQZ5KEtLh2uGj1H7a3cU08jwMqqDhGi2YvzKccT73S?=
 =?us-ascii?Q?+4yX3AJUAy1GpmsjULRicyls6SDKnUPiPMNvdW0+u7A4vFsQt/2xYM6eGeFW?=
 =?us-ascii?Q?8klfwMdatw73Q3CeQHFz2b5bM5O9XlEW+FVd1E21oRjxVbRMPBGevBN7hRja?=
 =?us-ascii?Q?C+UxT/WOSV3kLsXEtwnqwO0//g1/jqXunpXZVdCthH/aNe5x5AwF+F7vW0yv?=
X-MS-Exchange-AntiSpam-MessageData-1: WOMdLt2TwFgmkX3a5DtEKxXkikgaXGjdHIE=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 842fd0cd-2731-4602-40f0-08df128ffaf1
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:42:51.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmnvFTU11ICJF8tgfIMM4FKnYmtt4v/VRDrOsUeB1I9XitADDcU6ncNeT4cL/4uZd+vfDSWY3JA3cUF2s9bzWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2051
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:30:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20206

When current implementation runs in an unprivileged docker container,
basic networking will be allowed by default in all steps, ignoring the
network varflags intention.
Introduce support for landlock blocking of bind and connect, providing
basic support for blocking TCP.
UDP is corrently beeing worked on upstream, but not yet supported.

Landlock requires PR_SET_NO_NEW_PRIVS for unpriv usage,=20
which is also attempted. devshell and related are already tagged=20
with network varflag and can sudo at will.

This changes the default task behaviour to set no_new_privs, and=20
the 'network' varflag to exclude no_new_privs, which is needed
in a few places, like do_testimage.

syscall ABI is asm-generic, 6.7+ for all archs except alpha.
On alpha, we leak 2 fd:s in the childs context before graceful exit,
which is cleaned up at child termination.
x32, MIPS(except LoongSoon) will fail gracefully.
Don't have an alpha target, so this is not tested, evaluated via=20
static analysis only.

Adding Bruce to CC, due to fusermount usage in vrunner.
There might be fallout in other sublayers as well,=20
give me a CC and I'll try to help out.

Adding Peter and Mattias for awareness, since they seem to be=20
users of enable_loopback_networking

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
Changes in v3:
- Missing Signoff on last 2 patches.
- Link to v2: https://patch.msgid.link/20260914-landlock_try2-v2-0-0a1bad35=
79ec@est.tech

Changes in v2:
- Make no_new_privs unconditional to linux version
- Add landlock-disable varflag, and document it.
- Addressed review comments from Paul regarding constant naming.
- Link to v1: https://lore.kernel.org/r/20260612-landlock-v1-0-77891f63ed7f=
@est.tech

To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Cc: bruce.ashfield@gmail.com
Cc: mattias.jernberg@axis.com
Cc: peter.kjellerstedt@axis.com

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>

---
David Nystr=C3=B6m (5):
      utils: Add landlock_restrict_network function
      bitbake-worker: Call landlock_restrict_network for tasks without netw=
ork
      doc: bitbake-user-manual-metadata: Doc change in default behaviour
      bitbake-worker: Allow tasks to disable Landlock restrictions
      doc: Document the landlock-disable task varflag

 bin/bitbake-worker                                 |  2 ++
 .../bitbake-user-manual-metadata.rst               |  8 +++++
 lib/bb/utils.py                                    | 38 ++++++++++++++++++=
++++
 3 files changed, 48 insertions(+)
---
base-commit: 046a90b0e9b7b914b7a95aec579cdc3fc9c7617a
change-id: 20260910-landlock_try2-794b370dc4ed

Best regards,
-- =20
David Nystr=C3=B6m <david.nystrom@est.tech>


