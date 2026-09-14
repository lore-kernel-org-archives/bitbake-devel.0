Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C665C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:29:53 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4558.1789410130080039753
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:22:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=nEJgMCem;
 spf=pass (domain: est.tech, ip: 52.101.83.16, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQc0YxMPgt08ZnE4Vmv4hFDIdHWWVMGdXOT1VsICM+wH7zhR647FM0Sqx2g2WPn4/0A7PqPBLVoXiIChwBqBLjWxl2Xm+8A0nKSNp3yr5eYl9yD0eLwBkE2bL0AKrijttnkjkU4UyCUPrITMB7/3TpkABoYtrKe/CUHgRjpiOMOyVNHQgFVX5z1lnKZrxR3L/SLh0s4MCSLnrVKqtQR9oxDCEKe/ihhhSVM/BVT8WgPSNMRv0EUm2vg7fOr56fG1p3quWQS6RASeMtkoWvkKjq141KhjaO5ZGQDL/zNFcS9oeyDDaVbIFop+YeUdvuCxM72RSmSldheJCxQ3qsLDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgLB5ro8HRkZthOj2SUtH+pvEXvrCTECi1UCRoIh9+s=;
 b=svZhknXtTe3KfbONrmGdEOWt9d2Zr/4wPpnJcboWC9rRqTd7HWWqviI+aKlx3XHIEwRMnVudK15OQ8RW9DhAsD2IKVscauoeFoUDmK5LEe+otU979wUcMAhUo5iKyBtxVkeKUGM9KVXfeXxL/PCCLBTYc/USj9+kZsnYmqTa+fgFH9PcLOlC/CxrPQGa8Dccheu3IBqpxieXMA5yLDN69nF4ogan9VFSTnL2UMBKzlZp0bVDa7TKq/367cDq7277EDkymC1bfCDCg1maPBuo138iP60+IykI1WBTfTnHfKlYrBYTSymuxuGZ3o23Wio/dKYFWCwBbgaEUTreTl8w3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgLB5ro8HRkZthOj2SUtH+pvEXvrCTECi1UCRoIh9+s=;
 b=nEJgMCemZAx3vLWF/vRSXqB1P0B+l85VUCPlm4Wf+HsR/2VG7CCil9A0BvC+QDZBWZS9z+2juIdOPGpPzYAjMa8vX2ByIlKKJ2wmRYCFZTIEoHxh+9uVkABIkVEGUuKI/b0UcPCTSSc1kfgQm1nT5/OojBsaL3AZOioZxkxQZHTibdaxU9CgSGDDjjZdMU2AN+5D/M8MsqjNd43o9boYKqmk053yEY6Asg3Hk4hIc9gvrp19sPtrTU2C+DDRpWtviWaKCQZ7n3yuz7KptBDAAq0td+tIhL5vznbgKgh8HbE6K7aElsRR8mBtWA4PvNYR5fatpCRVYPUgquwue7Iy3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by AS8P189MB1302.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:22:07 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:22:06 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:21:41 +0200
Subject: [PATCH v2 2/5] bitbake-worker: Call landlock_restrict_network for tasks without network
Message-ID: <20260914-landlock_try2-v2-2-0a1bad3579ec@est.tech>
References: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
In-Reply-To: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789410117; l=989;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=2CYKypWmovyQoJMbLVs3ifcwFkR2mPiZOicgM2mjvlk=;
 b=Y6Y9lk+OuB88cQJtu9/apOCBQ7owH6bmIq812MoNslVga+bHwzqlxvBlacLpGh/BpQl1Lq+Xu
 PsRTDqVcB+ZDDqYBOeQMcguIX0bAUoZsDHB29IbdMpxtl7D7yarvPvS
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV3P280CA0104.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::24) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|AS8P189MB1302:EE_
X-MS-Office365-Filtering-Correlation-Id: 19275f5a-ee93-4fe9-9362-08df128d155e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	kEYhz6rgWhtcVWIed7hFqHConIeHDWfKJl5n2cIg3vjR27fBmhABOEp42+35BMu7bP+sqyaFvX6MsrLc+35/HYVP1vxkHtgCLNXKtzNmvaDXyR20jzEsjdo0QVTj+rOMEws2yDvByVZnzImGctzBJ+rpSl0rwY6MuyOLWS2POOZIuxO2BZ/MvbJfg02w+SJvkWVIe+1n8f2P+mR1jkErJU0taGRAJhGDRazzWWhV81EbFovRVvue3YxA4BZlMOM1OPUYw3wrnW6oNXfKEwczCCAOmI6E24OAET7wV47MMcaEbLlrA5f0+jGScRodv/osukXUIIR6uE+NszaVv56ObFzupf7C5lzpVV5nEngj0Py6OLY2zJuxpuBRNG4sbgrw5D8BhU+YlEqU7u0zPAIlWksRKAW1F4d+cV0VCJ3XC5J+Fsb7luHV1Nbfe4EWnfQVW305srKksYwtWKIhkMa0kWR5eEOZz1FlOyy8ORr4MwBBMpFnT0ay9Uoxynxxd8Y3lmJCV0kfRCjcX6sDB1skOWCsO6ejmzNKvDXQ69vx4EyHiCS8y0yE8VJhcE1BVtEEUAfDnLuXJaHuoYL4OPbTAfmZdDqniYdPRj9ZT1IVxpa4H/PUNnaaSQkHvGLtPrD+ZHzWTh13bYJgCOuyJ8IAxPwGQF4o9j0tVpkuF7HYZY0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gbYBqMa9S5Y9qWTUEhL8jPlXh5/d4yQPy/UiYS4W9FG5wqTqcvj7MdKYpYm3?=
 =?us-ascii?Q?21UmFL74ENmNB9Kw5/fAOR1sl4Z82GFRITvGQAwD3vfIeZ6w3A+BWx62L7Zl?=
 =?us-ascii?Q?/DPAcRST2d0u8dNN0TG9vCenM0Oor194zJ7fQHFDL9hSGLV9F3aMT5a/nZJO?=
 =?us-ascii?Q?PRqC9gzyJK5Foyw4OxaD3ZaF4hwLZUQ5tXLXEmVEm+7hYcVBu39DHowL5+Iz?=
 =?us-ascii?Q?BIiz1nE+d6vrFbhQGe3eCBSEkSHE8JJLdX0/WZ9tX894R8n1B2nU82+oKcxA?=
 =?us-ascii?Q?SkKvXEHK3kmifUMPhg1o0sXGJVtn6AYDOcLgd1mfinWLKyRN+XSjBNwriR3w?=
 =?us-ascii?Q?YXakwX3S1qKWQCsiL08MhbQp3lkMmpQ91EvZy9RBNmScP2hxqpmHFtrviFWE?=
 =?us-ascii?Q?ec7M/ukifT14WAIBQWVMjoDTkpXd0PTnz92B7QgaBHdyeTvuxX6AiPBYOLW8?=
 =?us-ascii?Q?p9KylMTzQMVVtpXRzDVwtrgmsgd9BremIgrKJQ6inxy6twSPcMeV3P49/KAI?=
 =?us-ascii?Q?LtIq9TxywiuyHE+xZkC7NOxAd/+SLIdVNZOOEZWd54OrrX3tYuhF3dArDC6y?=
 =?us-ascii?Q?y4pE4kWaYLREc+Jx6YtjQT2kE2Y9Uz/xwQXlZBkdg8RqvAUf3Q9R+J28aNPF?=
 =?us-ascii?Q?KamrjO4jwZVSlztChJuz5AXxKtJ68FM+zCMhu8lKS3FmKIR8zgOlnTzVsN3d?=
 =?us-ascii?Q?RUxrn42HcJ9Vjv0u+WNP9g+mmk/+6Lnte7ZBIPdBnEseihWUdejfhNy7QJTY?=
 =?us-ascii?Q?wPr3An9GTSBC934vPnQpsg7aJ82qjl7/337dSex6O1Qos+vmrtDf9qW5rFtJ?=
 =?us-ascii?Q?qUXWcNxcNoKM7XI2LO1Tex2pM1wQspqltqMYh4KyxSkjAohru+jx6FHa4x56?=
 =?us-ascii?Q?33PxNRGXXMWQfeud/5AwQaTzw7BBcfDd9u19ZkJSxdBcagfVw3cPvpQl9OnU?=
 =?us-ascii?Q?0FIwvb+8Tb8Xt2eTECviR4dO8exaOcgZ83TJ1tlT88QNMPXd/tJj+NjSah4y?=
 =?us-ascii?Q?J/RDpi6YPL3xIO8E9abdRcTn90UbtfN5h5e2QbFMnSEc/arDAvgOy6LVLa5F?=
 =?us-ascii?Q?cNjTwQxMmVdFrfA66CgNQFv+Z+/1H+XFWynt6qAKk7oCyo9uOjsz0OKhJg7r?=
 =?us-ascii?Q?KB3cTuTNHiYt2nAUoBozYA1QWwkz+8IbYhzk7uDVGmCoYNPxxfNeD5rHJmI0?=
 =?us-ascii?Q?bHGUi7TT+DgqM6n5icBfREPRcwJ05Qj+9GIjJLFOk22o3o1TcxqhbKdXydRL?=
 =?us-ascii?Q?kBKMWcqoMsSicITJ25RT9fgOVgTSVH1sUhFsyta31srtZdtf4Isj1W4v5GCC?=
 =?us-ascii?Q?29BZiSmcfS67OmTxi2s3AWtjOY+EfBu/f2MpT27VY8Kj0D/WsuRWJVdvdmpo?=
 =?us-ascii?Q?iIeY6oopEEiDnmflLtxYN7JSPLKrvS+ukivDMbI97I84h+OWj/YnXd3VcCXP?=
 =?us-ascii?Q?93FxE+/FU2Ja5N9MAoqcQDIF6QevhzBKzwSuu87Ws/R2BhXVyuLQpYdZR20L?=
 =?us-ascii?Q?zv7uW4hyUmU8dwwVSaNc8fO0tCRis9abs0wBDk1+XiYTUR3GP8wMxGJQMzzp?=
 =?us-ascii?Q?T9DoQPeGLnEHgSEfcHe38v5nPue/TYlYkw9VxtDA5XljBT0UCc6rNeyOSwbt?=
 =?us-ascii?Q?QKkwBofgG0WEJBkzuBdswgPbbxuA73RKgoNSvGMXEqoaVyiXnDUevBId5ksw?=
 =?us-ascii?Q?Z1GoE4Z7gQ+W8oEtZY1IrRcOlhfoQqhM0GLcMhwkU0bPk5AnUFxjY+LU8xLh?=
 =?us-ascii?Q?GQNPFHW8Wed0huKf0ulpcafyjnYIk02WedqWA5MV/VMSQMmN9Dea2SecfzO7?=
X-MS-Exchange-AntiSpam-MessageData-1: vbN5fyraeTSUwV7sC5xEHJdROik7CfuZ3/4=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 19275f5a-ee93-4fe9-9362-08df128d155e
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:22:06.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peutWkNIVIhoNt9eLzQubHbkm2DLLWHsVL8GwwdBTuWlqDOhDbGQkCDBCzzxB+XdNjkmlzoW8Roqh+l+2ozCCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1302
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:29:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20202

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


