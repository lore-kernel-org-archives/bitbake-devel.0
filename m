Return-Path: <m.schwan@phytec.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C30CCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 08:05:34 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.107])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4626.1762329933609859761
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 00:05:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@phytec.de header.s=selector2 header.b=KYQaIFIx;
 spf=pass (domain: phytec.de, ip: 40.107.130.107, mailfrom: m.schwan@phytec.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJHIPc8nMC9+aRkAok4Q24uOkV2Unqqfx0XhE+wOo4s94trmllvutomNvow+15O0+qg5HtBdnVxsZQfmH8QARIlpS9MVQGtfWECCP+v0xuWk+WZExOBwkhgakQDRErSSAUn3FgYhbs4qqU75oKYWJ96KwtA0nLvVHKVqO2hV37Yni7m5J5aQVhGI6xR7EosQfu4rCEkPesHQz3EzqVk/tJqo+v6tdLU5XPlIfT9keT86LVNeZ747szvdYAf3qAdaagbS+8qlYZyoxRoIdtzzi8JtiKt3qrL9MqpQxsBJQIztoTchaZ43MsoBdfxzRhtg/VEEmDKh28JneJtl+3bdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAbl8HcZ1tuueMMJRQjdxFnxkybdcB+R89rRCYMdqOQ=;
 b=FmfM3tEL6eI6i3XwPyXPavtdw13ByznYgtUzGWExuY8Sa3BjNiFlvzs2uhIbfV3U/XAyfz/cbwqIWfq5xr5H3FLbFBJ2q/HjnjqFcR+LpcCAU4OL8BWdP8SZzRRxjIR1Gk3oFsTCWWj5El+XOb1SfqwEDdrhcXpHIVlBOA90/uh/EJZzoh38GClH3t8eoiLNgF3/lZkqJFycfIzSuhz4bNbmDF0PFIUWfyuEJ+pXbc/UN1ZORwSmKH+jmjU73H/nBDLOKPUhFTqkRSuXO4uFWMuYYt6E6VDf8Z+sGcQWa7FaNwRTEGmA25NKqdnpY94UpCCVD1f+M0XQKqdIzfZbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=phytec.de; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=phytec.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAbl8HcZ1tuueMMJRQjdxFnxkybdcB+R89rRCYMdqOQ=;
 b=KYQaIFIxnk1PAXXkGTgmQlGJFZ0uevNNolFdpz+UwUH2NdkXltmI4/m6ZgoXD8/7edJPZWwWNOxzL0s5mQrqmiYn311o/aYjBgPEAYhGiMhtfJ/9HD9HjyAuLdcSJMYyFPQssS3DuvTHc7HLvDoH/dFEwL+OySxzejsS6mPPWpg6lwkqRBAA9UAA5wR/kB/vtp5Vhd4OYOznzuqYjp6JERWvDI9uOw2m9YdPoFl2icxRZHFl7F6ICNG2W49Zuo0h/5XWz/l8r5NX4sO7NlV+C6+0NXMjh0IO+W4fUdqi3tJiTELXSZz2aAplDYFwrs+3r9c3xuDt2wAi9Pyy1p+JWA==
Received: from DUZPR01CA0274.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::13) by VI2P195MB3031.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2df::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 08:05:27 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::c5) by DUZPR01CA0274.outlook.office365.com
 (2603:10a6:10:4b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 08:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 08:05:26 +0000
Received: from augenblix2.phytec.de (172.25.0.51) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 5 Nov
 2025 09:05:26 +0100
From: Martin Schwan <m.schwan@phytec.de>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>
Subject: [PATCH] doc: bitbake-user-manual-ref-variables: document BB_GIT_SHALLOW_EXTRA_REFS
Date: Wed, 5 Nov 2025 09:05:15 +0100
Message-ID: <20251105080516.647480-1-m.schwan@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|VI2P195MB3031:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e382d8-a909-4398-24c9-08de1c42143f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b17nUtvlunVykU/km24B9cf59QEN6b7HQIqvTCB6eLVztTlmz3Jyph3TPeTm?=
 =?us-ascii?Q?EZAEM0r1Ik+aspBaIkCN/9Y925OB1qBQ4dzNyG6ABA3vzzOEKq+Y4WPRB+I/?=
 =?us-ascii?Q?GOlvrtvznZsP53r6wnUZacvNn1MpFTVhhMqMp7lC4Fr7JlD22AwDm7EB3bpW?=
 =?us-ascii?Q?OviyYmmc2FUk1Ah+r+Fd2jdnIZ4GFILXCJcMvsp6WXT07es4dqlAMvc+qZci?=
 =?us-ascii?Q?6sSWh+rEy9JGWuNHQyMjkXE5kfIiQ3i++35HJinYBxgffY3FJPViuUCUYVMy?=
 =?us-ascii?Q?Yk1m5sXDCYW+Gn9jl++NpSTtHCDCbjLoa6siGo05Q0vm+dmmdokjyKdjqB+7?=
 =?us-ascii?Q?PqR5cRukDtcH2iwq1KcuwHDbNA2KASYnFKtMOpu8XzzhOmbwiFOwaQf7dksm?=
 =?us-ascii?Q?4IYX+WJmUURcSV8UXtMohFa69U9J03Ta4bU9ZiUOfUFouY+DStyVj+EY4oy+?=
 =?us-ascii?Q?bFgQp3C4R3AsuGZCrzJpUIpm2yC+R6pkB5AWs/SWA4TOG3yUgDT2VALoXWeT?=
 =?us-ascii?Q?yYRlK2MlI6P6RNsqqoKbWGUKjYheetMhWPYU2mgvQDFRzrnmMsZAttJaH+T+?=
 =?us-ascii?Q?/swfgl3JBCE8bxtroMYYxsXT4IVRm1OQw3mLoV+7uYp5+0JpCPf3iGM1QRyc?=
 =?us-ascii?Q?ZP2PnAhVjkXLt621qIHfOui6wUxqSUjzyFFWXW9mu8bNdMtTpAd9vwjWJa7T?=
 =?us-ascii?Q?2/uUhFecoQMvFnAGrW8Xy+9YCIEUapQirXfBG5EcFCX/hyyAe2c4NKMjMOJ7?=
 =?us-ascii?Q?j8oC8/I2TRl894GoR83Dcf+rSmIOZ8JsCKrI7qVdD49gyEeFYE9czpMrs7aI?=
 =?us-ascii?Q?kfrVNVo79cTXz5ZinHNS9sfXEQAQ/ki8CQS5A2g3ghhTg0yIswpQC4iYvfir?=
 =?us-ascii?Q?1SWWnAX3mBDKBiTyhk0OEz3/Pib3nDFB5OggadYGNOZppJJpQ7kLetZSzaTn?=
 =?us-ascii?Q?ZhvD53/XCRjRRiLtFhBul01bVFJIMo9nrdwTURBlTc3qJ9tfT1QKl4TqjIVq?=
 =?us-ascii?Q?AkA9EXu/IKvKl/NwZ9C9jxjum9JOIt4mrFXqKEGPd4wonY3sZgH/iWLhJ6RO?=
 =?us-ascii?Q?YrstuwN3Zh3JVw/w0o795AYGbS+f1QgutfnwgJfCOd5blVfbJBBOGekkUxWy?=
 =?us-ascii?Q?lSVMkIGLctv8EK6IrXRXcyckh7k8mEhqG3kTPIeLX0cyu9/0SF1A4ySvztIy?=
 =?us-ascii?Q?LZpl2DPjJLEOpI50bwuFL2hcHxZe+DjB3eTV0WbFHbb5RRQgN/ck/a854Z6y?=
 =?us-ascii?Q?Vvi/qAXfEysQDKT05tAQOZWkv1aa5RgGYtp2iCi0neB5Ph03Dqn23qvggB6/?=
 =?us-ascii?Q?ZUk7htX2kF/MRHhGAC6Pips9MOiDVWfZZD5uEJlVbtf37bUB0iII7NrbA1G8?=
 =?us-ascii?Q?xl2HfFUfIZmyPLgy40OVDSP0/ZwvxbjDYC0oiD5NPr0dPAhqtNpnxDblCi0h?=
 =?us-ascii?Q?/REPijwVq2Ywxw+dOfehuwv7cqPoQyZDbxB/1ZfQJAkOLw+4b0ie0yHTbz0l?=
 =?us-ascii?Q?zgGh6EqfckMPJ5oIU74ini49qfvEEn2dMmgvE5E8J+YFnMhYIOaSDNacN++e?=
 =?us-ascii?Q?zy5r/f7Bpjfe2aGrWi0=3D?=
X-Forefront-Antispam-Report: 
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:05:26.5559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e382d8-a909-4398-24c9-08de1c42143f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB3031
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 08:05:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18257

Describe BB_GIT_SHALLOW_EXTRA_REFS which allows keeping additional refs
for shallow clones.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 .../bitbake-user-manual-ref-variables.rst       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a..309477071 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -399,6 +399,23 @@ overview of their function and contents.
=20
       For example usage, see :term:`BB_GIT_SHALLOW`.
=20
+   :term:`BB_GIT_SHALLOW_EXTRA_REFS`
+      With :term:`BB_GIT_SHALLOW` enabled, by default, all unused refs (br=
anches
+      and tags) are removed from the repository, as shallow processing sca=
les
+      with the number of refs it has to process.
+
+      :term:`BB_GIT_SHALLOW_EXTRA_REFS` allows to explicitly specify addit=
ional
+      refs to keep. This is particularly useful for recipes with custom ch=
eckout
+      processes, or whose Git-based versioning requires a tag be available=
 (i.e.
+      for ``git describe --tags``). The :term:`BB_GIT_SHALLOW_EXTRA_REFS`
+      variable is a space-separated list of refs, fully specified, and sup=
ports
+      wildcards.
+
+      Example usage::
+
+         BB_GIT_SHALLOW_EXTRA_REFS =3D "refs/tags/v1.0"
+         BB_GIT_SHALLOW_EXTRA_REFS +=3D "refs/heads/*"
+
    :term:`BB_GLOBAL_PYMODULES`
       Specifies the list of Python modules to place in the global namespac=
e.
       It is intended that only the core layer should set this and it is me=
ant
--=20
2.25.1


