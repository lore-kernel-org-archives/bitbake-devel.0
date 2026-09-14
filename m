Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B571C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:53 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4870.1789411391881819084
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:43:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=e907gEC0;
 spf=pass (domain: est.tech, ip: 52.101.65.9, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDyp3dimzXz+OCfl7eKsHVNdC2pwyO5HAnjZ9jKepfj79ZizOy9kE0Pd12Ag7a8yDMEjHT7DDbX0zcE04jQ6k0AlzvZu+y71PmdAViX6iuaY4GT+RnKYESz/muId+fxOzomHGVjaX/SHNwwvpn96GOONa7ktnw91llnaspGJZf1TeB80jknejXjBcEcpnIx+e9OUP5gL8PBKT8gci0iue36xBI2GYkhlWvcqiPwH3mOQq/2WM3vzBdoa9B+G/wxLFz45diwSiB19MwlETwtavBeIUX6X43hsNL4RTQLQX3EoGgC0oi4rtzkXfwxeV3UUoz4bJbZrPjj/ekQbWAZnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOFt5qVNzDyQVv0bTdkeSGNhglBECCcYaF/XTBndhW0=;
 b=F5VGmzCUsSrPLrJ0q1bZkLkO8L4JKzqzpja6uhzP8w5ToTcHKC4Z2H1ZlgV537DybPc5K8v8ZzLd7XVpiYWvcFRii7ACvGD6prJ7XItGIVjVMOQCH7lAD2r8bUKzdXpbT3YtiKGZ7jSs552FW7hrUoFnmDaTWTu6QFRRWWs1ncioGE+votDYbYPO1cWiAI0zvq2QnveEI9NmbVY8+FlMFr6yLfEoMLMBmPJwPQ3DMQil6xz33F5x9XIm29EvqM5yk0idsEFVyOLhD4Rf3cojMLcRkUNkQ9E/Z6RI8DcbXlDj3fLjLnDdhnlLQgWtnpEty4rEZQuBiYborMji4+TcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOFt5qVNzDyQVv0bTdkeSGNhglBECCcYaF/XTBndhW0=;
 b=e907gEC0ijpD1n6FWQbQU2uhPDgm0UTS1aNprhBRxIpeKHYev+dqRYc/cR+OMtZx8cV5W6TpNhV5rChnXLu6jiu7NXOY7jyPAPl58SwwOipKHoUndpJVrzvsMvQLxsdsJoL4iB6QgA4Tw7t+mvujtvI155MjbKPqsBHn1bp4eTKPl/gB1JPJ5gDueI7uZk9ojDvbJa1ytaXY4OvAwBUVrYLLiBLFYGMnx5izPoCZ/lV1PxDeGowDmx3iD4FSriUuaJm7zjhb1cH5u4QEw8iyoBBqQiCkR8Juwe+S7kkX735dEc939b4n5Mdzp0uQEpt/O3H1kzq1i5QGlSfNg9V5Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by DB9P189MB2051.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:43:08 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:43:07 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:42:26 +0200
Subject: [PATCH v3 5/5] doc: Document the landlock-disable task varflag
Message-ID: <20260914-landlock_try2-v3-5-4ea504789675@est.tech>
References: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
In-Reply-To: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789411368; l=2046;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=Ndyd8qgH60SzNJgM3/dBAaTiZSou2kqH/eBmEva2+sg=;
 b=LEYhsjIieDWdKX5C7H7nhHX4OGC56qt8jaOSjOqDw5eJLbBQA0ryxZTiFeLueLFsT+ODvxcsV
 /1quzFQZUxcADmlQM/Ac3SuBF3wLdeeHQ3CPLb4hcarNRTVa2djNtQ8
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV3PEPF0001DBB8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6f0) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|DB9P189MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3c5db3-7258-4848-e417-08df1290049c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	7S4PszyRTJRX8QL0P5CsqWFtgqB8mpMQm8tohxvS7Cz9MlGDB6CXYI/AEVi+sX0ENg5PG7/9R+3SK1LqgRXxIv+/k0FFCWmqK6rPj++LVg9pQUfdtpE/hG2Gq5wGzn/kGCLpjzClK7K7wTyrCCwtnxjkLuVwwRT/Z/hKfYSPqfVYmfEJB4s4Q6XyWOcc+t64EY454eaIm86Sh2BBidfyH/H99M2vVmigk7KnyVS1PmHczNfR2VhLQKRK9EIeBW7JcaG2h2LT8HhCDfgA3QPDkd5PUhP+HuHlV8WTzwsppds1bRw3eVoMKE7msozHPp6Pr26lAoHPqt5PXA0IM6GlfLB3OiKE+ZWYTdsl+QwWo7/qFPwtBwlYYSrDV/wh1x5COTV6TVsv/2TT9WeJsQ0T2QrtCcmz5B9OERBJ81G+RSlFs/UPDrBEVZe0+4+5S7seCnJGwRhdk16YD/LIPdWqi1ZLl5GWQqljWMs2M2zBkxfBWIh0xE3K7sjAQmw+Bda3h5F0Pjugj7ZQ5AmNplRxGvqzawuYClcTcAMBh2B2B1yJByth/IEESvBpCg9w6uk0gCD0f+yspJy9Mc70xAu/XZBShoF9clE6j76S6UsNIXVZ4yrooeICL0+SWyxWaZSLcODnG0yJ/gl2CTp9ya8gxpOhXYSxwJahORs1TQRnWxY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?T5RPK/LoUJwLAyUGTG9gHNXeO3cA4rCJ41ePGZJlaJnfTY0vRGBDIMMEgviC?=
 =?us-ascii?Q?xpKP6zoO+VD6Z2A+QkJeBsJUS/LkApyEVY1pELVcc6Yv/JSd+V/uv5RD5/7O?=
 =?us-ascii?Q?cicufQI8/18FVQuWtmmbzi0xt8umBdEgvxirfW0x0yyKFUjtA4yM8vDQ6OiW?=
 =?us-ascii?Q?nxL9r1+FHOSlZIOhTGJAenQAPL5EotfuzDOKxhw0Z4gUuRg+XMIwtIMLVeFp?=
 =?us-ascii?Q?QhHxgtDP0njM7am+6KJRuPo3VO/XLiuQGzF+VLtajEUTVvDop0Z2iFveozKS?=
 =?us-ascii?Q?pITELD/W43JwVkaLV12KKmWTSwmZlgNtr7cuh/Y1AOgEjFBKKMuMdMTstXd5?=
 =?us-ascii?Q?CZBWcLSmn7WKboFVmkynI7AnC0z64x9/4WXiIztYWxbNn/DpRbskAB88RJAX?=
 =?us-ascii?Q?4TtA+BQk+Dvz+Ol6XmWTUw7av5NQ2N/bgRXcwsDz7oKTxUDgBFr3NQFs2rA3?=
 =?us-ascii?Q?d+SLoEVgHtHMywEHc7y+3RfNwoiquP0Z+OdwdE+LQg5S5+QJRP+uUDSas9Fc?=
 =?us-ascii?Q?KmKKKvLOMeR6xO4UaVJzetu8cNfhdW/az9RwND6Y2PGSI5cT8wDnmJ0LjEwq?=
 =?us-ascii?Q?tUv5TCMq09RAaXQTYmyw8Crb1Yb6jNVxHDwzhcMT/ag5LJymHJB0uv020p19?=
 =?us-ascii?Q?ZnflJovgR2UtrUba6KDVRnP8V1UvmOxdA/MWUySqQYxoBIc3GHwPbbBDZ/lf?=
 =?us-ascii?Q?vGuTGptioIRCpBDUIBUJp4yvWLA+KDaJctTLf/KA9GaGKz+A0nbRwYom+G9T?=
 =?us-ascii?Q?MaJ2j+++6YdrtqjyYJ9DCW0tdpoLhCfvcJ65Pj9T0ykz7vo5kh932WId+Em4?=
 =?us-ascii?Q?SMTdqYGPTt1igRb1fZpbFY32h3QhyLF713G6gwxfql/SZ1GnjIskxIXqJVU6?=
 =?us-ascii?Q?XRE7esJI1vz3TKYG30w5Jw6oUx6DtTPi0znm9uBx2DdlD+hI9q/pHALR96ON?=
 =?us-ascii?Q?l1VgOiDNXkPqhHICVs6m8GTTIgA8JsmawfYYPHObBWZ1RPPyJAirgagvbl9d?=
 =?us-ascii?Q?c5LNuCxlbN7sDHWACQh2l2NhnqTpFgiw1pTwobzyV6VmTj9GgYqrhw7QOZx7?=
 =?us-ascii?Q?Idi8taefrMkhDsFIC2Cd39tRQrZBDO2L8n/hA0mbXMxpjx23tCIgFT/Y+vzu?=
 =?us-ascii?Q?fkAfQh0cUILoHaDu1MzccWhJFqDXe14NT017XWr13Dl47/h6h5kAp8DpYxWT?=
 =?us-ascii?Q?0Z+fhzhcOexJAVLobrTvW4FgPyF4D14pNFzsc2rYwFRYdYklfbogwhyo25Ko?=
 =?us-ascii?Q?nE1kanP5nkhqHEy/LyMIXi+/Lnk+UM51xBtlbmCL0lEA4pvxJZrOuG/G4PJw?=
 =?us-ascii?Q?qdfP12nAszYkNL+zmsS8yXLUMI0CaPqMp2goGrdRHIy4hOGLiGwN1eJHxYDF?=
 =?us-ascii?Q?jQ2JCX80rBMpbwfWghOxaJJrUNV6Wm+YyjlGNZGG9AxWH0TVKhBOw0o/+z6n?=
 =?us-ascii?Q?MCsUw72fiLf0hjjFlmY7Sjzoq3coK+m+Tg9uyGCB9T8BMN4z3yEJibuN148S?=
 =?us-ascii?Q?fj0C8P/OXi/1dSk3f1kuCgQbXtiQsbR7e6mRu5oBPVK+yiWxHoSVwPBf1CbT?=
 =?us-ascii?Q?ZBEwK+TZYVxmShFvhYHqOWR6MB2MZKtLP9Fgv5zUPUqlShpX3YT9jKuTJVBH?=
 =?us-ascii?Q?QggdxJkFGBw/C+wG/r/tx81AUKh9qem9w2NG0tPiuo+XH0sN+M8Ode0HWyl3?=
 =?us-ascii?Q?pVg8b+RQWEsj+2AlfDc2KHq6ohdSgYFsIptBACm4G6/ryM+6Tn1978tvzsLd?=
 =?us-ascii?Q?GQ04hsnScEgBgn2cQJQ1U69uog+8HQtsDM4+VDhsSfqwcdGdmf0rET+IW5LY?=
X-MS-Exchange-AntiSpam-MessageData-1: /HLiVQl4mVbg6l35c9e6yXyqg+7u+OszfhI=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3c5db3-7258-4848-e417-08df1290049c
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:43:07.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbOUGPB6YQ4wigVqWcqjop5mphZBT4k8GhyOR++0UflPTJJt86q8Z8NJ6rbDlEt0M5Bj+g579QplT7NXiQjSYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2051
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:30:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20211

Document how tasks can opt out of Landlock restrictions
and clarify the resulting exception to PR_SET_NO_NEW_PRIVS
behavior.
Also, needed by users of enable_loopback_networking

AI-Generated: gpt-5.6-sol
Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 621aab253..b67320f47 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1780,6 +1780,11 @@ functionality of the task:
    "exists" True or False value after the path allows this to be
    handled.
=20
+-  ``[landlock-disable]``: When set to "1", disables Landlock
+   restrictions for the task. This can be used for tasks that need feature=
s
+   incompatible with Landlock, such as gaining privileges through file
+   capabilities.
+
 -  ``[lockfiles]``: Specifies one or more lockfiles to lock while the
    task executes. Only one task may hold a lockfile, and any task that
    attempts to lock an already locked file will block until the lock is
@@ -1791,9 +1796,9 @@ functionality of the task:
    shouldn't access the network outside of ``do_fetch`` as it usually
    undermines fetcher source mirroring, image and licence manifests, softw=
are
    auditing and supply chain security.
-   Tasks without the network flag will run with PR_SET_NO_NEW_PRIVS,
-   which prevents executables from gaining privileges through
-   file capabilities.
+   Unless the ``landlock-disable`` flag is set, tasks without the network
+   flag run with PR_SET_NO_NEW_PRIVS, which prevents executables from gain=
ing
+   privileges through file capabilities.
=20
 -  ``[noexec]``: When set to "1", marks the task as being empty, with
    no execution required. You can use the ``[noexec]`` flag to set up

--=20
2.53.0


