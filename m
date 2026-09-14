Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B959C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:43 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5045.1789411383523204176
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:43:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=w+tQ7I2Z;
 spf=pass (domain: est.tech, ip: 40.107.130.25, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9rwivahet04qmSYe5oDELkiFdaC3LZntuYmWsGfwRHuOA22E3/jN+pHUET5NHUzAZwdKcyWZ2gWhRewVyl/V8/zfzKDmVveI2wj3du1JSnAOqw37G2illptlgPpn5lBxwgCaAhYNSV8fuGB8hhUPLQOOd2SDdXZx2dcscQPbZYJ9rPSYEVs/ZGg+TU0/6drDKmw7nRPt59UdZ0chtqdYPAcMliCWAfY++1A4T9t5o7x6vUYgSDroyNXKhCHwMHyDabSoEKRJxinNmyHU9Fr+NhrFvSinIETcZcoKbSog8Y2z2cxdoc2otyrVkWbLlhCuAd6eqxXDsok5EvUI7cU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUTKWTQrKqJudG9FPrNtsFVCCyReg8PWcTFlm2az8Dg=;
 b=nYaTCZZQ5R/uRDZUmBIr7iOhPHq8o6Vkgzcwgfz5Vy1V9gniuRsrZW+XSWV/vhqhD/Sm7c4eXSnTmvEpKM2hpK/v91MfU+VI7kCfHu6fbTAzTcaq9rzZpBPIBY8yTDr+CcEwkQE18oflZRutVli8FTVEtETH9uucXoP8jFMbhhZQ1UtJkBBcOec4fmfdKciW+Gmvkc1Pc9ZxRSkz+40Y/1NSjAnGutNarAevTXU3h1XwRqC+ix5QrTOXX4M8kp8z3r5hiopr7UPEn2HnTWl8b/tmxVCXKdP/p8fPE3X8E8S3bzWBQKRqST7veRR2TylT5s+yxMfB6gl1WQqk2fN5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUTKWTQrKqJudG9FPrNtsFVCCyReg8PWcTFlm2az8Dg=;
 b=w+tQ7I2ZjsaTW9TCV+yc6r2lOIZSgRM2L/mzZlSErlsqrdcZ5+vTTN0HDgS9wgo+VOhDJlBftNcJjBQKKSl4OOe0gxvZnHRcBuHtVKOcd8dW8BvVeDOBRs6gMYvRiiKdb75uA0J4xMS566H40Hdj3igkXdIr8gvvWoco4OgUKYMKZnECfW9Q1l2f5vmtzlF9NYZ0BdwEXRVZ1/5XHkd1NXxvUqlllo0eSs4654us33lTgKN7IF8VvncRk0WasniSSfBOb58fNynBdIY1B9+eWwTQ6XDt3kq1kTKLGj84/vZHOJ1ZyQg0hrF7CAoLuWir5hR3YR0TqWHmNu9uPY7aPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by DB9P189MB2051.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:43:01 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:43:01 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:42:24 +0200
Subject: [PATCH v3 3/5] doc: bitbake-user-manual-metadata: Doc change in default behaviour
Message-ID: <20260914-landlock_try2-v3-3-4ea504789675@est.tech>
References: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
In-Reply-To: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789411368; l=1138;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=ecGizml/kW69/bAUhokv+n8CRnnEWaRnvb5Yn/RCpnU=;
 b=0w3LY/jS1Qpb0REZtVZRKPv+jkWLB22A7da6ky6jbr0rOY+tu4kUMn5aXeaM+iNRd5zjOuCUx
 DfE1Mai8KHEDu+2ZjVt7cj7tvjgMbkOKbawUpExC+q2GqPnz9JzbBAk
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GVZP280CA0039.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:26f::7) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|DB9P189MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dd4528-b7ae-4f1e-7e00-08df129000c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	jlfsOQM3P4UZZHWYbFHr4VAOyf/Ta8Ss3UG1QW099zAb3LlfXt/hUWmLmri/p2XSD3dVT7WraNCC4CgeJgEKcfFkUavq0+T41OgKkOBtRL0QdmJNnlxexZ8C/HAwsiVGDTesrd60lzNnE5LvGHM0l8tOI0NZdHnlx8+bJfM070XvtQqUn93FcqBQ6FdoSEITAp2kUmEJ8lYbdL+25uYrNag+lkq5kFxJfUZ2oxGyf2cuJ6f6k3XJjY/iRXUvzYGjOITbWyD+yKsL+vBgO+pvxnyAtOn6e3GYk2l1nYHFQNCi4CAkeREikbCKD8dii++OikFVgcfQ5VpkjClrKlqC9xOyWSsk7FCTbBsCfx3/0Hk1hQk6HevzEdSz/2x4yP0aHeItXw6t/a8oPIs7vT/AXhGwbALKpo7L89R89a9c2/cuhlQVtgY7mifbXkbZQ4J5ICtGnHIRl85VEgLdxTMY19P9cAbrmDsnvpOtmSJYWaopJ68nAOJWQsljqOpvto1WPYbps8KEeaW4Yc2gLlUVXclPi+QX0p6TPKs2BeS9S9JjzDy1MXBV69SRBg4TZm5vZPnw2u+h0msXCZmSA41QK7Qqpe4c19lk2cWs9XR0SgCYefcizifNxAKRCZKuaDLeoPST6dKqstkk4BeCWKdjVY1PG84MX/BUFtHNUbsD6fY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lkSRHr/n6iVbobIvGMMWSxm34rih040mWty8aIzE0dkyWlSppXfKrDlxWOuw?=
 =?us-ascii?Q?SxprKCTq/DR8A1G3XWBulklW7o/9ejeG4T+372U+pYRjwcPFiDmd5Wx+Ft7H?=
 =?us-ascii?Q?PVj/ZT0v8DEnjAy8jAnt0BbYisYa7tNWA6x3Ddmux3zv4WQakgqnlgg5QbT4?=
 =?us-ascii?Q?JcYGaaweoPcCzxdfW9cl6vEQySXrmGMqrHdR5HmAonclchZuPFSuD2ZyQRtA?=
 =?us-ascii?Q?QN/skFN/QXqbib6OYpzZwP7pdyqVfe+X+m6ANb7vW2EkOnh0YEx3c4hM34qN?=
 =?us-ascii?Q?YoPPNwGFANgn30milxql8gJfU+v1Ct/YkuNalt6rnM4Qzm8E76cf9bykt3PQ?=
 =?us-ascii?Q?JB0dtgBjq/jqjSp+d6hAnDN2Rrg3EwPXUzokah73L6JiFt03EcF5A6dkKZRX?=
 =?us-ascii?Q?xpu2VcdNTsFetSzZTk5xX+gv/kGqHVqjLhC+ZRGheYIqzbohTi790pXaNt6R?=
 =?us-ascii?Q?FCPRCjUvs+rmDRui+v9eXpKYFzboWGZmsf2ur/6KyDyY4tMXloV2idwZBgCR?=
 =?us-ascii?Q?VQLzaaNyiP2bnuQx7xRc7/XxLzD5WrLnCWnZ4DvPy9F+iSB5kryi9T5zOvim?=
 =?us-ascii?Q?5dVYebdoQ3SmN8n7bwJL/gYti4SnqMQ9MujG9U/0ISAVlASySvlhvAU6rY8I?=
 =?us-ascii?Q?YIbXtLgrjgSzqRiZXAublIFpw2YNyQLyFuGU0JZQWIhHE2WN6yTzpDhMygE0?=
 =?us-ascii?Q?TNzNS8Vfz42tsIZcKd8kj0fVDpo4GKf5FQwclglrrdSRi61nFvVbeXsl1glO?=
 =?us-ascii?Q?9FN118R9FqpojDRttTKO8fabtg+g+qO+LNuY0Ge0NQutrQi8dxJwBgVmcaBx?=
 =?us-ascii?Q?NCPx1SP2F1YwOtYvvRuFOqcRe8C+mb6Zs9ueXuxm+1p3EtqsqEF3t4Xf/ELt?=
 =?us-ascii?Q?gSl4o6lWrmdJ8WwQPlA05LTwuSSUaSxo129fW8NTNmVu4+pIPmFvxyZUJzOY?=
 =?us-ascii?Q?SQVL2uM2MYjv/O0etEkDotoNHJDVIMzY4Fl+f3p+JKansZ7EDGOs0l9j67af?=
 =?us-ascii?Q?AknzaraDLi0AbWZtpOdGj2VgV4GbhznWukvHqA1GLhtNJfqiNBHlsxIQKUOg?=
 =?us-ascii?Q?sNfNif4YkAWHALBTeVHP+W9iHLXxCta0i78xTBzlfAbXPGfDpLXNlt839LAZ?=
 =?us-ascii?Q?VNWlc+c4hMErOBFeVeD7yCBQH+sjJZQu9lIBfBWwbhx2X3SA/5uKPT6djOE9?=
 =?us-ascii?Q?EV5GCVGiBWAwYTLIXRmfBGmpwvcNrszqSmCUKAKcPx2qjb/vFA91mX1DD+aP?=
 =?us-ascii?Q?gZ3153J2oSUpXAozn+nSOw2epLA0RALJ1qHUqe8XsZKJOe+luiZKboCQ1EMY?=
 =?us-ascii?Q?ptx4YN7A6qwaVnFSvesj3MZlZZEDrVbfqVw22+Xk0O4EVXWevmWhTZPMIRMp?=
 =?us-ascii?Q?/j84Hp52GBl44DK8zN6d0lSWZGLM+lVss5Ve+l8NNpuGUvivFyqHe5t6+39B?=
 =?us-ascii?Q?muTJ0SPJaIWzHDwIH0+zJM8SCyjCbHV5dwEFWciNFMQGig8GVjtz8x1d1A51?=
 =?us-ascii?Q?MXxMoWiHOTSbCpvPxCRekTA56z5k7zmmIHgSgwZPolJn+u/mhkGd0tWqnL+U?=
 =?us-ascii?Q?pjSMdNA95C33aJlFA4O9r4Gw68sgF/AVVuGpFZ7iISnYjo6+mjplPNT459BY?=
 =?us-ascii?Q?qnRcku+4PJFAOdwf8JcZx9QVD42fYb7rYoICbsT/Og5Xs/x7T399cuuYE6mO?=
 =?us-ascii?Q?cWyBuUCljjhVGU4o8FRFHvBxwh4YaV2f3EKMsj7mU9aOh//l8TfuLBU3zA0t?=
 =?us-ascii?Q?0Y2E0uoCm3kiRIk+WPyuYRSd+R3BMYtHihq4BtItGbeUB9NuyexBVytzTCgo?=
X-MS-Exchange-AntiSpam-MessageData-1: foqb16pTNeCmVKDvb8weD3EASXlBox6usyc=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dd4528-b7ae-4f1e-7e00-08df129000c5
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:43:00.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEmjfLeb1E4OzaDWp3jElyWI7FD6V+WleYZ+WpX7VwflLLcIqwBJL15J7hKqoYMgA6ADeEyzG4X7eRzyWBNHhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2051
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:30:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20209

Document the change in default tasks behaviour. The "network"
tag is now needed for usage of setcap:ed binaries.

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 9cac793d3..621aab253 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1791,6 +1791,9 @@ functionality of the task:
    shouldn't access the network outside of ``do_fetch`` as it usually
    undermines fetcher source mirroring, image and licence manifests, softw=
are
    auditing and supply chain security.
+   Tasks without the network flag will run with PR_SET_NO_NEW_PRIVS,
+   which prevents executables from gaining privileges through
+   file capabilities.
=20
 -  ``[noexec]``: When set to "1", marks the task as being empty, with
    no execution required. You can use the ``[noexec]`` flag to set up

--=20
2.53.0


