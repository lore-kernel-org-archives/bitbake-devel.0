Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B12ACD98C7
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 07:40:26 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15043.1781077222723920171
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 00:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=HIrhZSTH;
 spf=pass (domain: est.tech, ip: 52.101.84.23, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPPIGUsMi3lz2mLDJpXDoUAnCkmMKSBD4WNyCRtGkANF4xAb+ZcSLTm2Nqx+LnH5IC9ytWEvLWJx7ytLogcFH7+lQ98JNf3G30DAKlXJegPrEj3hNX2JTcE33nc43JA+qhNH2ieie9z7kY/BkmO1ut0mCUS2iVnxf5HeaOWT+OiNhBl1Y557OIc2QyuE+7Aa1cGz7tsq2x986rfoo9MyUmk9wB38nKvRClTq/oZ9whePkc/4Fp51TLgbLMQbkRrmZq7cgzCw+7ZnX0YILiZdHcjEXa31wJ0BM3m8ExcIe+MQDPJNnpdqWrlyPazCcUhVF+dP5cYHJXUYz1uatxiXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z10euQWohJiHFT2+eVU0B487gBPn4rQebtZH8PIY5rc=;
 b=lhN9ag8s/GiYwI/WCcr8uh9YX/7piqazkwLT8M2cURNqpAzHOk2FUbpm3zdlxj0QhXUEupqKXQdViCdcxYsJs6uKGgt4X351sH+QB55lMY2pe8iTThmaJBK74MuY0uENi3pPrPwTyDx5R7VOYBHd/xhSW5K1x9bVVKxHI6KCmdYVBVb0iX8oSnjits6VR2lRxKJ7wNdnvx8evAEFdW9bHdA3SBGQ9CejnwU35TdkePS0QUfE2ptfIGA1bHGvcXlmeH56V6K+U+e/Vy+tmBd+FJRGtlc4KZecBRR+0sxKtWR9QJU8YyOBs2e4VlmqzKbfCAkJjUr1SYESWpj3fPhcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z10euQWohJiHFT2+eVU0B487gBPn4rQebtZH8PIY5rc=;
 b=HIrhZSTHKHiflutUW8xiSWHWK4IJXYbJc/H+8+Nf1csr6PZq+OdKEa5/5h64hmttLUZm0Y6zKWAc9MxqW6MeMEb8xJmXWMHvyS7uS42s6O6cZz7NXchCZSIubTwg0pmRije3Jmhm4QJNm6LRo3mL6c6WVlbq94auPETF8sUfVuYR2sgvgfqLv8IC77gRs8r/+Oo0a7Dii+sqP2ZcHoxDkeodFZSr2ftEpgbPbtPHVrsAvZ5dD4p0R8mIhIv5kX1QrHcRPoIQqFLptgTstRgvKap6Kflk7VpY2VFlXgfR84DMBav7L67moYf9po7XSW+GP1UyoEsk4Ht3ZaFOy1eLEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 DBBP189MB1290.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Wed, 10 Jun 2026 07:40:19 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:40:19 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 0/2] fetch2/wget: limit auth headers on checkstatus redirects
Date: Wed, 10 Jun 2026 09:40:11 +0200
Message-ID: <20260610074013.558709-1-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DB9PR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::16) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|DBBP189MB1290:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cc1244-26a9-4f52-010c-08dec6c38535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	nsCJ4H+u3W/IzaXW2r0UI0sPYcTpuXPSvYT4ZX2V9Do+xLp47TfPPLfSPStvSWsy797W95l7tSxUACgDIoOvlo3bab5idt1W1D0n8YoKEvss+9S8SWaqA4ZS+IPJ4yJMUE7dVw4tWTaXGZXpBwi2Ij7X+sM6Hi+DHpz+fwdQddZrE5Iys5eimqiEbR3OJEEYQ9I0lKYAViOwYoo/aPwPHcMU4cNvI4+VbWHQfA6Ac3Qnn+4dTzhP8xB8xtpWeyDAIb43RMruPfe75OGliSxrEMz9x74LpEhLcXTKiH65TXquWGYISorbiPppuaIQeMJFpdgD+Ip49sc+tgPsEpbh7Rr9DwmJ+g8pPQot/5/2ZrnrNPJXinidjPLIMAdcSE6oGcLPr/Xxr/e+gJd8IcQx5Ew1kWSiPPy+Xdk22QYluO2hNm09CCRpcT8WjprxwJqDUp+f6UwWFHdQyKDphI0FBVSGeNLclkR6gHhazW8kemWa87U0QYNi1AGMhYMSDoEJ8oJtWWdBYC8QOgNfeGIGRLgMqxPqPAPqnqyOI3scF/Tye5FjuV9U2n+hz6UGjNNN+KBNYKeeO1s3+upXxWXWh/at9TI7ZIahaxcgxEX9OmBXWWsR0oYyoSVgi0nQxdk6PaAmDlqf5kLNRUIDrqGeN5T1nuoqQZkFbOaNELk5QBKkcnzGV7ym4prbsuLbADmV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EH1X0/lwXVBMycA4MPBU4NWGUaivEHnt6iPaGPLpBoXzKEDvzJJ0hda4jHYs?=
 =?us-ascii?Q?6r2QUZsKVcHMTu+7DsDN8/ZSIHtg+wbjoFPOJZ0kgdktuImJXM2CIIc2KuuA?=
 =?us-ascii?Q?KONmgPpgDmBe68nQYB4/A+YdL+WKXsJcQ2fJkDmq8gOC0t4+dn9IKeoTluo3?=
 =?us-ascii?Q?THkkru/zzF2PqcNk2vsHtNFfENS1uCPCUKqWdonx+A7DEBhj2sUaEfQVLimm?=
 =?us-ascii?Q?uYrw4g+6TpZWHV2kKHSVz+7uh8LtL4wCPM90vlsvuNjZGkX2hwhO25w9uDob?=
 =?us-ascii?Q?TIkNmxEo4qcvdPxFM2fuqjMVsrxa/d6eFLalzY6ke6PMvMb5FPNCmwu1fVRI?=
 =?us-ascii?Q?OpkqigwX3HW7Qp1O4Hmbu4AiTbKDijA+NeG8lwiRNhZc1XqAa0HGhBVx9O+P?=
 =?us-ascii?Q?wAwvWKXy8MGI32FoJ99OKVTkmMDJjCGJQZJLb5Cqi8ffhG79RF/eVcmUknqQ?=
 =?us-ascii?Q?0CKNcXEg/ny918Z164Tf5B9qbJOsEWPd3+wQBKyMs7iIr3s/DS9+wBD18tLF?=
 =?us-ascii?Q?FB+TpIcNUkrA1RL8FtRK9+haw3lnjLthmVh1tCbnphie0Ii5RzhtCFU0CjOq?=
 =?us-ascii?Q?eC1C20B1R8y0GeVoQPhQX4jqzklEj3vXJzO5i5SDjseQJmAjNL5WvVbtwQ9D?=
 =?us-ascii?Q?ajr6UmTbjr2uCSKInXOXaqNP3Cwf3hQW+JMBg0+neQtbTGTTCQ+kcOLSMWjr?=
 =?us-ascii?Q?kA7HUmoCfKctcl5cotzOQXTMMXNza9HoS3CARR6/1p/Ew/tWeJGClD+Jvhrs?=
 =?us-ascii?Q?XKCS3T0m0y68IpVkXDs3CjQyc4/ZnCy/b/C/M4EqXuGNdfMVnmTKYdZw08QZ?=
 =?us-ascii?Q?WQneZq3qCK2ISZdZW03ntnLzL8OyL54J2V9ej9CuyBq5E3p21eWYOmX76yJt?=
 =?us-ascii?Q?n5aZxupGgxLvJUWjkbjH3igyAYsQOorn61p+ZLflNdCoTBDOgWnBoB7KWOyj?=
 =?us-ascii?Q?57guWJuSoOGPaJ2UrfQFeK5VgVOIdROGTDIMGr77vJkUUFgQ5zn69pCUiRQh?=
 =?us-ascii?Q?YzpvvOrNssoLG5/d/N5eGPmRvkEOt2UtjQF9bez9B5Z3CPrDKX5dTzP6r3b0?=
 =?us-ascii?Q?AFIolmlkCH5CDM+zL5qQbKjgGK98aG5csVflH6tvIodTaLyzWCY0lpswdDhP?=
 =?us-ascii?Q?tKlPfA1KAXldpcs8bN2mKznfQvzgNWtmq+1++od49Hbjg2NMC0A7lu0so9/D?=
 =?us-ascii?Q?hhZcDjyCDCFNFTyJDeidrkCOT8WZ9cI3IRpdB0f31zBf2neNLju+OoinSgAM?=
 =?us-ascii?Q?c14vfulyZgM06L2PUQfOiUe2E93NUQiMCcTBYBLZuHHeDf9XQ/OfgBpEkTGm?=
 =?us-ascii?Q?Ey9s5q8f1hh/3UDN9IZp7mXLVlcPUHWeniehw7XbVh663r/sefF2GO8JNvZg?=
 =?us-ascii?Q?rxe3BDBNsRASVeb7QSbbXMJIPI/Fi6ZUNv2hwwUS2VpHfMmlzWr+UUbJ+d8D?=
 =?us-ascii?Q?3CaVGcFde9YHKZtdMLormo8fRNmwimBTlmOdFLtcLaxlZfB3KfozHWjT7LEL?=
 =?us-ascii?Q?bgUihIShVFZGft7ceUckD1B6Utq2tROnPyfClesea8MCJo1MYt0ySYqmOVwa?=
 =?us-ascii?Q?isN90YGA/qdNr4/sSeoJ/Yjb5f5YVVQNR4TwBrKS2KO7Y+vEqftX6fuyz7+I?=
 =?us-ascii?Q?CyFbwD0hG6bLcVZvn7UecHlunMVSt4fbrhis5qZzojRt+HJzTBTXvDCgBXUH?=
 =?us-ascii?Q?foBuYV+zva9cKUaPK06SkhhL5n0KiRzyVPh8lANAIi1+udOR2P4R9eftBK8u?=
 =?us-ascii?Q?XdlKfAZntA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cc1244-26a9-4f52-010c-08dec6c38535
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:40:19.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5gMzMWk6i5uT/mLYZJi5GxNLysQvXH7ca7Igpzday7h+5bwsQ1qWN6g0GVcPxc635Uizxfs3q3Zc28pt4EXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1290
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 07:40:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19636

FixedHTTPRedirectHandler currently copies request headers when following
redirects. The first patch drops Authorization and Cookie when the
redirect target has a different origin.

The second patch adds local HTTP server tests covering both same-origin
and different-origin redirects.

Anders Heimer (2):
  fetch2/wget: limit auth on checkstatus redirects
  tests/fetch: cover checkstatus redirect auth handling

 lib/bb/fetch2/wget.py | 27 +++++++++++++++++--
 lib/bb/tests/fetch.py | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 2 deletions(-)


