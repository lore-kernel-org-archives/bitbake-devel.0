Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78FC02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 15:51:20 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.23])
 by mx.groups.io with SMTP id smtpd.web11.24156.1739548268282327099
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 07:51:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yUAd1BV6;
 spf=pass (domain: siemens.com, ip: 52.101.70.23, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KM+lVIJB66LSGAV2CCYOnSuKxtjK8k0j2Ef1l/dsGINFGZjaiOYm/pkCMROt2pweobygCKFpbtbd8ld0/S2bWjM/Ne/izrG/CbTAwfyMgixOZGkwxZVPrK86TOgRfrsU3EE2dCc+6R8zV2oA20+hEe4jsdgZ0tWeVFACBG6+bsKLXVx4juEBs1N3K+dQDUEV1pbUr+CBIeOoD0O5avI8x4dI5lZUDALY1Glvqcjt/m4891jRESDUZO26JmwA31fwvI7vgG+uxUdTTw4JXA+uJP5drF+d92cWIIunM8vqtMEEY0O2E3/Ki2jQdX/deihcs4FmeKPQt1fy4YxBUEruwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMHZEUs9RjSe0xLnP5YSeRYDmEwtQzadq/I9IQzHi+8=;
 b=YTDFsmUCVgiPtsmTzHT5qzRvPm0Wt1asiXN1wlu1x5Zlt08zI/E34DeYRNQQJH8svkqYH81v0ZWjjnLchLO0NLKxO6ADYe+uc8LLje9oIrd+iDmJ2ruj7YbkBs46cyDzq5djlsll+vLSlgD4dJrZxAX4cXk3lSVLF5DHUyjoz7GlKtUdrTKqheGUgogOy06dn3pGLCZPwBY7tylnJXkaHWHZMo1AMdjV7lga4AVXJ/NLuCy2BGg3DtPrNr+jahEwAOkUKl4dWoFlr64hWG9nbnWeunLLLYxVb4UEJ6I/X1iCyA7AG98YPO11Mkrqj2NMUi1jBG7xu6m5uhImFWyk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMHZEUs9RjSe0xLnP5YSeRYDmEwtQzadq/I9IQzHi+8=;
 b=yUAd1BV6WwOoaaSwNg/VNCLgXjm6T1zkAEFqiGY9fK1D6987scHlZBGL82BpQNjpeXiZzPVWP6kNrbiZhiwolkkA6cO16ZAOf150InKVED5BHICGKajhJM83A3AQsbYeTQY1Y2zEVh6s0x25nk2li1d1ugnIfGSKhppx4//kfPc+dyAh4pfiN/bcXiILqVJJHERjXu/i+QF+msvyR/5g70dxPInA8hZq+l/nBDZ4SseqDCC4MAvsV1StcKRQ5WQZ85uSsmpxYMQyGQ7+8ZYsdlZLiivRR9yFiuiqq8LUBElMKN6kgmf+r5LHqQH1kKrf3Q4CVBj7KiK2pS07PjSx1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AM8PR10MB4081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.5; Fri, 14 Feb
 2025 15:51:01 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.009; Fri, 14 Feb 2025
 15:51:01 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com
Subject: [PATCH v2 2/4] bitbake-user-manual: Add documentation for BB_GIT_SHALLOW_FAST
Date: Fri, 14 Feb 2025 16:50:55 +0100
Message-ID: <20250214155057.1748020-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214155057.1748020-1-stefan-koch@siemens.com>
References: <20250214155057.1748020-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|AM8PR10MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9424f15c-0543-4e44-d60a-08dd4d0f61d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?anWh+9DrwwmOry4jhTg3eLZjmmFeESnd749vL9pFYDwNv3Sxy06kgOadDQvI?=
 =?us-ascii?Q?wvOPpVrpf+QY8P9uoo+lH+BYprAAZFGvI/KmmX+m2GmLhTOZvpiJ9SgIkK7B?=
 =?us-ascii?Q?4ZXdZuqMFpdmJ5doMy5GfzzffSHjr3GAjWJM7jsY6Xayw1QPY10vJRupgUCV?=
 =?us-ascii?Q?u0VmZAurFwE8c0i0FohuiMtE6UMTdG9V/ZUqgpZypd7eQabgupKdO1FvHvBs?=
 =?us-ascii?Q?MDMTtVKM89Auiicme+ViDHpneXMpkILKD8azJWPT+dOGhiN8D6xhTdjlU+/E?=
 =?us-ascii?Q?kelAjKWAyBmtWYSiHhgDOkL9kVEJECofdNFFnbDkhVe7HeSvGyEAAkdSsSy0?=
 =?us-ascii?Q?2GNoGyKPp31EbMqZ4hMfTHTLuT6aN2hQZzY1wFIdqUNf7hjpOGABrTXWlP9m?=
 =?us-ascii?Q?w2DX9XIPS1+Eao3M2/NS7oiHOMkle/irhJ94Vz8X4mCizmS36azj/aRZo9Sx?=
 =?us-ascii?Q?t6t2A2bMhVCbCcHPT/kS2BhYh9Yk/7akfMVL7mC7ETTzpA2zfdHRVcPgd3+5?=
 =?us-ascii?Q?ITxr3dmOIWurI+zKcBHyGQ9V7iVwpGjsm5HUcQY+yXMrKJ2LEK8nRs8O2q2E?=
 =?us-ascii?Q?AFrXe/BKQAA1Nq0LoT/3cC7Ts68MVeJBR0J845xsM793vJa1rLHLkmle8Onm?=
 =?us-ascii?Q?4jR38ai/Sp2eSg8P7O+OR5PPVZEm4jTh88lhrXqMykfd4Vw653vxmGE90Y9P?=
 =?us-ascii?Q?JwQdbjfocWvlAXZCFYcg5wPkm519PWhWZDj+H7gi12Gab+Ggocy2vhIUcm5i?=
 =?us-ascii?Q?lT8tplynTYBbM9gObCRMcFp1uH1tx0jKtkEJlNagzmnSXUZC7FiPUQSWNlT2?=
 =?us-ascii?Q?Sv+r2LsZEp89NJNLbHGeJho2ToK0KqRYTfic6kxosAgtPf64/accdnbYE2i+?=
 =?us-ascii?Q?uwPyFkR2KAhgqSI5cOMQV2/VB0ewSRRku15w18QaTopQqc55/z7OYvv5XyVC?=
 =?us-ascii?Q?reGBhWLJztvTEyHaGXRn5DjfZw//zfsutXdOqK2VVS80ZxYJPJwhZop91xSk?=
 =?us-ascii?Q?+GIVUDc+Qxb8GRQQ8SJJRoNX4Dmxn+0hh6KYOw9SIeaac0I3L9TDbZF6RUZ+?=
 =?us-ascii?Q?rtJC90nZ/U5ARyStz9OnE7KF1+XRPGRjZQQOngVb7rntAxpTIWtQ4IBNrKQd?=
 =?us-ascii?Q?+RJHM9vcuDjABoCLJF76qR+RqBxBi7cWH/hovpo9lXVQrPywBqQW+C1KCu2X?=
 =?us-ascii?Q?gIG74Ld6O9x24tKwIoJfNEU39HYa2FGNS3HNKHYrKHY/CUlJ5ejqcmajbhjY?=
 =?us-ascii?Q?GznKBW19yKsFh+Y66AAjTDR8CriTGkfN3YSB44RQ2ux7eY0extPJVVj84mHw?=
 =?us-ascii?Q?qSwQ2M4qhdwn4Z14jtEBkUBf2Wv2BgLJbKIG6U61rRF71oVq91MAMy7sLiUP?=
 =?us-ascii?Q?AVbsyx2QZe+mA5WeHiC82D5yf9/Y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IZcM0ljx+MENBOJSwxx04TV/B32bemOQQv6ptY0OSos+PFBpQy6CC1/uLrBR?=
 =?us-ascii?Q?k9p0hBcd26CQ5UAMsbrb1g15l/qb+k6FE/LZeiq6wZW2sHSlgpAzoBwqMlFP?=
 =?us-ascii?Q?GBvkjei+qWOmomIHqc/ZevDPQC9e9NTMTyC0Sd5LPDk+39IjqHcsOa+8dOAm?=
 =?us-ascii?Q?gn5+ECXgtgxmJBYn+8IFtc5zTLyoTZPC68oJvmj8MICxd0VnqOXCI7nAPmhE?=
 =?us-ascii?Q?gnbhAHiwMY3LU4/bH9nwV+H1qMr5G5pRw2Za/P3DZ4AiDmGpORo/SSW/yrlO?=
 =?us-ascii?Q?bX68UJWQbbyEOEPF/K4gxGXI0CD+ntOIyUnaPulIUmGPlcDHT/oXPKCQDh00?=
 =?us-ascii?Q?e+vPn4cjZlSmQ8gvL1z28P5yBpDpdDsFntdi0NoYT5HijNCVdDsrQYd9ZIvq?=
 =?us-ascii?Q?nlK9Uv6hrHPHJ+otyo7UMzIcDupHAv02k9M03+mc0cu7L7elanRzvkILObkU?=
 =?us-ascii?Q?rL4+GeD7ytnphr6Tjbh7CDXDZY0OGo1J/OczkG3s/OSeWs+GhpqP0hmjELKI?=
 =?us-ascii?Q?nRoIBPKHIPoUKF/dDrk0zrQyOxO4wn1PD3N7OOQB8ZsEmCrCdJP0BXnPeJcj?=
 =?us-ascii?Q?0YGxxAPd5QQtxo41WMXFHVcXtHf8qsIhfm1j7DhGyx5WPWSFvbjTZpthXEJN?=
 =?us-ascii?Q?zZ6Rh5Ns6tR07IcEdL6NiCfBcdceiKJjAJ7kYAcnmw4osjEs8vW9Qs8eCTBq?=
 =?us-ascii?Q?lZTaUol+mBycvf356S6Pe6UP7oO34L4PdSMq7OSquLHvdAOVykNsiHMjE9r7?=
 =?us-ascii?Q?vfNWcoGNXqDhso61i2Vovbohe3W+bP9xa0kbYJCN3OKl7aDFmGbJrB9PGbvJ?=
 =?us-ascii?Q?i3IigYuvxAzcW8l7Z6+gx7g0jc0kAdp0pBg5Tmng0ipDd0ISYpMZkmXTLdxQ?=
 =?us-ascii?Q?EpX/K6CvaWaMaDPvNc3ZtK4B/5sBQaC09qT2un7SXF1AgZqdImnJnokgrLqv?=
 =?us-ascii?Q?VzLzMuLokbbXvjYK0Eqy6J0qLSiMlpUHikPI7f8RTmkOfO+2fykLTpAkxo92?=
 =?us-ascii?Q?sW8GW+ifsAYvNafZa7HDSCKvSPpcte89p9I0pN6Jd3IZL278oy6FKjHFTVpz?=
 =?us-ascii?Q?uR9LqAr2GklAbxpeYGEr40n+uO5MKArZm8l1XAPPQjrEaD8g8eZj4wZ9TLAT?=
 =?us-ascii?Q?KKLIX5ZbOjvQI/OSyUTarLDgZGO5EX3RPZjKF0KTZ1xrqce/bgtnSmQz55C2?=
 =?us-ascii?Q?miJobvByfEGOPBSikwxCj8VKTHsJ/m41ovF45ra1S6HM1GTwWQpDAVI5HXBs?=
 =?us-ascii?Q?F+YOyI0Rv50XtTODwRJy9e1z1huWkDcxgAM/DLS3hw9Oj3y2K8zWM0ismB6M?=
 =?us-ascii?Q?qZa6RvMO/6tNEOLUqsDJgFfsL0b7/Eeg8HwH1k7w3yxJSMwYoxfIZJgCNWM5?=
 =?us-ascii?Q?4AGT/65gjJAWjp2y+JY0mz4QkD8msLu+0sbBePO4qYFcx7OvsAwa5cutfXau?=
 =?us-ascii?Q?gQdIofuZr/iyWHeoP/WS8HGYGOono3f2Orj7kudopuwCSYfdhtnS9Zye4222?=
 =?us-ascii?Q?jkXzBnBOjABPOmEo0uqMNnCwNPx6q9hEMAC2RbzVw5tT9mb9Sfe4gNUDe6Md?=
 =?us-ascii?Q?tsWVNenmg8UQdAmdlnv6Ncal7NAv9BRoAIOrLSIXZnelV8i+jtpSeEYw5b4+?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9424f15c-0543-4e44-d60a-08dd4d0f61d5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:51:01.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS477Uw19jNpeVAWw5s3vfPxx1dKKcDgUTLnCvBuw2yZ06r18x4duZaiyz6h3DK/kfx8PuR7ySZG1ofe83KyoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4081
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 15:51:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17226

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../bitbake-user-manual-ref-variables.rst       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index ad219b531..bba6cbcd9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -347,6 +347,23 @@ overview of their function and contents.
=20
       For example usage, see :term:`BB_GIT_SHALLOW`.
=20
+   :term:`BB_GIT_SHALLOW_FAST`
+      Set to "1" for a fast initial shallow fetch.
+      This setting prefers an initial shallow clone
+      over an initial full bare clone.
+      The amount of data transferred during the initial clone will be redu=
ced.
+      `BB_GIT_SHALLOW` does not need to be set additionally,
+      as `BB_GIT_SHALLOW_FAST` takes precedence over it.
+
+      However, for updates, the data transfer may be significantly
+      higher due to fully new shallow clones.
+      Over time, numerous shallow clones may cumulatively
+      transfer the same amount of data as the initial full bare clone.
+      This is especially the case with very large repositories.
+
+      Existing initial full bare clones, created without this fast option,
+      will always be utilized.
+
    :term:`BB_GLOBAL_PYMODULES`
       Specifies the list of Python modules to place in the global namespac=
e.
       It is intended that only the core layer should set this and it is me=
ant
--=20
2.39.5


