Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F46C369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 16:49:47 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.55])
 by mx.groups.io with SMTP id smtpd.web11.45219.1745340580987494288
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Apr 2025 09:49:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=AptB2Ybx;
 spf=pass (domain: cherry.de, ip: 52.101.66.55, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr/BL7DNRA2yFH48diWsRVg0r+xw582cXaFXIdelhy2YaM91cL7BTCtni6jhb4+rFxY4n31zPQhXEZ1m4xOA9XaBMSsGMXvz+S95R2Q00fuAOatiBXeAHqobmIXwUX2BNPcR7aEiKTADn/dccWBL4Op0XpQIx3Wu7TUZ9iUssU4wPJe6QgN6972TD09ohA827wDK/LSbbpqfIbbWzrVrWI3SGeaN9WuMqWi1HS/pXNJoa+d94fhjYl46phj8I35a0QZNr7+Gb5z3K1GQB/nJ2MhO530VsqQqg+4GRRjduyt04BRBIER4HA9MGutbxy5CaAdPcr294F25ZZ1bYMyekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2t8I6vMu8cW6k+R2qHWdAWwFX/fbYpga6vFVBusqTk=;
 b=q6ductPvQ1ego7i5QU5q4YRTp5bf3MZCCj5773LOEY3HjwgNqabCIavk0LalrZ/Y9Wx4TLBJ/bAtxSoJGZtkwdw9l9KhWhXqC9+SYXiWhHK+YhRfLcG/6otkiID+VyPmbp3JlMk5M1fw8Hq7HX4zerx/ac3YPo0CxVV2Cf2n9uAG+MN9wxE2/szVTtP8ULa+2Bw/NGCnpv8u6iGGfjvw0bAtGHX6Xt7W9fzqxv8x/lUFq/0u9055+skuWAkahKoUqVKsv/14rAnb+iG6Zp/9Je+ugsmB0nDRJufG8OV9VG6ZMjjJv0IrDOba7zTk4XjlprhvgcwMeslPppO7KqAAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2t8I6vMu8cW6k+R2qHWdAWwFX/fbYpga6vFVBusqTk=;
 b=AptB2YbxhmaKejpvxkiIpGwNoqnizpGwC+04E8/nr4+zRFqlrwF+z2AF/1925enVhXMuJwFZncbvVYb6CyLxx6STqKTBF5FmyVESRW6nXownoJTSAdvMSpq8rcNYTuoc1+4Iy82NaJf5HLQJxQ+HfkEIDcsQ5ksoS2FvrcbJzvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 16:49:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 16:49:38 +0000
Message-ID: <a7d7e16c-68e3-41cb-9459-2f746fba54e1@cherry.de>
Date: Tue, 22 Apr 2025 18:49:36 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [bitbake-devel] [PATCH 3/4] doc: add a new Library Functions
 document
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
 <20250418-library-functions-v1-3-3bbb836149d7@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250418-library-functions-v1-3-3bbb836149d7@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: ad48b8c4-97c6-4d51-2b2b-08dd81bdab6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QncvbUx3VEcwNXZMVjJrM25rTVRQVEJib1V5Z3BCNDUwS2hITDNSeGJ1WE0y?=
 =?utf-8?B?VE45OFhleU5JSVdZbEM5cWdVYU5lSUZrRW55S1VSMG5zTHNoSlJ3bEkySUVL?=
 =?utf-8?B?bG9GQTMxOUFKS3R3SGR2eUt2Y3hMcWtWa0RYZ2NFdHhaTytDdGxGcjd2MmUv?=
 =?utf-8?B?aUxpQ0JBRmFSbFRteFVTTjd6ZGpVWmRpQVFWcklzQlpFY0NCczBiMFdwOWRP?=
 =?utf-8?B?cGU3QllBUW1OMFlHYjdudlcvbi85ZGFobG9ON2owUmNLbjVLYTFUWlJhdlNW?=
 =?utf-8?B?WTZvTitqU0NTN0JGRzh2S1o4UXR1azVJUnhEa1h3cTdad05aK3Rzc1JFZW5C?=
 =?utf-8?B?a0FMb3RoSUtiUzVWcVRMQkpteDMvKy9KYVcwMFFiUzVGenI3ekpEQTZUZmpZ?=
 =?utf-8?B?L2s2eDhsaVlJT0xpc1JZR2RmMGlxbGtSbEZQRkVwalhkOW4xUkVXZjhBYk1P?=
 =?utf-8?B?bFhma0NFcGdzTTRHeHdUWVowNEF2YmRnbVVXWXdRUVMrUWpWQ1J2VmdDRWpG?=
 =?utf-8?B?WjlEQ21BVFVvbzBQMDlDSzdybXZkMDZiK09Nbm5YclhDNjBqemZHL1BFRDkz?=
 =?utf-8?B?U1cxSXoveDEwS3M3cEcza0Q1WEF6RllOT2FBSlFMaXlpOUpqVWtVMDBjV0RQ?=
 =?utf-8?B?L2xWMEFvR1dRNU5iMWlIc0ZBcGR6VEk5c1lCaU9kaGVWTDVqZUNjUWhZYmJm?=
 =?utf-8?B?MDJNRlVHdmwwSFNZUHNvenF6U2VjQVZjdUNzVVoyVWhGclVJWWpnSUhBa2hs?=
 =?utf-8?B?bFdhc2ZUL0ZZemlFSjBSeTBIWU1iYnV2MXYwTkxCT3djTlJqT3EzdnI2c1Vv?=
 =?utf-8?B?SlR1QkM5TS8xNWhCdjNLeno1R2g4eDZHMUd0c1ZtQ3YwSGhwdVprREx6TjdK?=
 =?utf-8?B?Zk5xOEovOXptSTlFUmNmSW1uQmtib1B5N0ZTdE9Ra0RXdXpWS0JWa0NhYUZh?=
 =?utf-8?B?aXN0elI4VS9lSWFUNThKUW83MmRGNFRRZWJPQ2EvUlRBbGRNOHlFbkp3WUl5?=
 =?utf-8?B?ZnFybG1qbFlFMlA5ZE5vUk5qeTQyQnB5dTZJeXRDYVgzYWlDZmNjajJlTUZE?=
 =?utf-8?B?ODZlay9ZMlR1WnhWd1BmR0Q5UVpGUlpnMFBGK2lOaUJwUzBURFJaVmtZVlN1?=
 =?utf-8?B?cnpRNXg5SHFQVE5RUm0yZlFMbXE1V1N5S3NCZE9ISysxaGxab2pWZDBVMXJ4?=
 =?utf-8?B?U1MzekplaEtKQm5mSFVLS2Ztd1Roa1YzTVkyWnZEeGJabnBibjg4U2R3Q0hQ?=
 =?utf-8?B?eVBKMDFiTktmVnhpTE5wTVFHekZYb3JYZ0FXR25RTlFJSjUyeFJ5aDUwbDhY?=
 =?utf-8?B?NGlKMW94dERibkVvY1hPTTlnc0VzWnh5MnFRbzM3YXgrOS9ab0x5L2lZRmRi?=
 =?utf-8?B?N0xPaUQ0WXNLKzFCU3BHZ0NSOGlkdm5rVGw0N0FNS3I1ei9zSzNjbGc5SXl6?=
 =?utf-8?B?NXhHbVVnazB2cGtWdUFvNmhrQzdFYmJpWTJEbUlUaTFveWxNWTdISkxKZVl3?=
 =?utf-8?B?b0VPcytweXE2NFhCUlJBR01zMGd6OURQK2JJNVBkK24wc3ZncHNnUW9ZdlZB?=
 =?utf-8?B?M1MxTTRBSnBiOVhxMHQxOW9PVWY2eWlPbGRXdGJVR0pwMitQM0YyOWZVYzlr?=
 =?utf-8?B?ZkxzR0hEL0dXbVZ6clFuenRSQUk4UUp1UGdVQmQzUnc5czczNlNRNVhyWnl4?=
 =?utf-8?B?QTltc3pWNXJkS0hVajQwb1N2V1VyYm5EOW10Y3lCWmljNnZUY3JvaGFyS2J5?=
 =?utf-8?B?NS9RY0RZNXlhQ0cweHNCblFqbExTUHU1cEs1akpGUC9LQ29NTG9nK1Awc2Nz?=
 =?utf-8?B?QXZmZGF1T2FUaVJKWGtnT0VGQ05HWXJZL3NHN2pFUEZIY0R4Tlc1QVkyRlho?=
 =?utf-8?B?RFNTSEp4c1N1eXhSUHVXYlNjV0loQjJoNGJ5NHJ4cTQrMnc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkIwVU1Sc2FyY2h1ZTZNY0pJU1RrelZhd1piSjR1bzd6eVlGbTFZS29KU05M?=
 =?utf-8?B?enlDSXNXbEhvSnJCYzQ4M2s4cFlFN0xmaDhxQTJNYmFCakdWY0grWXdUYndr?=
 =?utf-8?B?Q08vLysyOHhNYVc5ekJJVzZMTTQxZkFKQWRxVSt6eFN4dTFieHBDMHFpSVBK?=
 =?utf-8?B?YWdFbFc1dVFVOFZWdTFiR3BVMm93dVg0d01PN2N0M2E5UU5oa3dJNUhnMTV6?=
 =?utf-8?B?amtnaEVnNEZBbGpwSVM2NUtYRHNVeWM1REptVU5YMEd1Z1VJY0VkcUh1aVJW?=
 =?utf-8?B?YitZMjNmeTZGSkNTTWJhTXRubFRLNVJsNG1QWHI5RG91NFJCVFdGeFhNOElp?=
 =?utf-8?B?dDdScGpvbkRMeVRyTjltZW9Dd3NqR3NxdnBqbXVEVlN0bjNlNEdHMWJsdTVN?=
 =?utf-8?B?T2Z2eWljcVZBQmpFcWo3ZDc3ZXBGM0NNUGRyRjZrTzQ0c0NvOHgyYUJrdzZ5?=
 =?utf-8?B?OXZ6aHJoS21sbGY2aHBGSURHTlhGVnNBQVV4U09sRkpLa3psMnBOMncxcmly?=
 =?utf-8?B?dEVCbGNRUHNRWFNzeHh1WjJVU0pRbFl6eTJ0bTZLT1huSm1UTkNNcHJxcm1G?=
 =?utf-8?B?eEJIYjFIaUNUeC9jMGFhY1o3aDR1SkhDdjF6UldsakYxeUpUL3lVZHNtT09o?=
 =?utf-8?B?LzAvRHdvMWh2dllIT2RYQTBsVUNtQnRySTUyTktqWHpUWDRnNlViY0ZLbTZx?=
 =?utf-8?B?bFUzWDdNRVBXbmNIOU5ab0dwckVTV2hBSzBEblB3UnRqa1cvNldkeW5BZUY2?=
 =?utf-8?B?OHRKOU5sUzJ1VmRRT1ROWjNIWmtPNHlmWkllWXErNS9wcmdqUG4rZ0tzV0Qr?=
 =?utf-8?B?WGJxa09URlBQRHcyUE82UVBrQlhPblMwRlJ1cHd2cXdFMHdEMHQzSElyODg0?=
 =?utf-8?B?dWRUZHEvUWRUVGRmMisrak5SRkNCR3QvMmc1eVZLZFlMcXQ4djhnc2JtU0gz?=
 =?utf-8?B?SitGRjN1c0ltUDMweGpWdjdHMXZxbWZ3Q25lblJjd3pIeUdtQlhKTGtQY290?=
 =?utf-8?B?REw0QzBnLzByMFpkckREZ2x6OUE2NTJaRU9KaVRvMC9RQjg4bGo1QVdpc0l0?=
 =?utf-8?B?RjFRZnJwamoyNUlwNURKekNSbXFXaUpRLzZ5YW5rQ3dYSjREd1drLzRyWnBP?=
 =?utf-8?B?UjF2d2ZMbHVNZUd4bGlTeUlZSTRiR2RaU2dZcWFKcmoyNlRTUGRuWGpUR2Zz?=
 =?utf-8?B?WEVXYllSSHFrbEV6OTlCbjdyRnN2VnI1SXcyQVlqS3RzQXVwazRJQUFHLzk3?=
 =?utf-8?B?SWtEVlhPcHcyVVRpTVJwRTRybDJEdE1lMkRrdnBwWXJRcEI4KzBuemRWN1Uy?=
 =?utf-8?B?cCt2NTJzVmdGSWJucG15YVdXdStFdzQxZXZFS3ZCZ2JyRWI5U015U0REUFdh?=
 =?utf-8?B?RldEdWdsUXRENDdCUG9FTWJlUnJMYjdKUUxxeUREY3ZQKzRBcU13VVhjZVdi?=
 =?utf-8?B?cWJiZ0E2K0xmVUdsVEFHbVZzOGEvbUR6a01ZU3FiOXhteWhUT0Nua3ZDOUs2?=
 =?utf-8?B?OC9iQWJBMWkwQ2F1Q1lTZDRySlI2YmZsd0VLZ3BRdUxSQXExeHZsUld0MnR6?=
 =?utf-8?B?ZXdpY2xMZXBBZWNhNjFaWVQyazBqaFNaUlFhdGpneFFuU1FGMGdCQmEyeTA1?=
 =?utf-8?B?KytsYjFNWWNJNC9zaiswZnBXUlplaE8vOEFjMU1Hb3BjOW9Xa1dCYXdoOFhG?=
 =?utf-8?B?TVpmS1ZPaXdDTW1uMUxyTHZuOE1HNk5ycWVkRHZaSytDLzB3RDl5dzU2UVQx?=
 =?utf-8?B?UGRPd21YWG1SYXRKSzNyMFJQZXIyRjEza2dpMU9NRXdISnc3N3NwYzA0MjZF?=
 =?utf-8?B?QUJFMFkzcXQ1RDhJa2lvN2xzS0ZEdDd5ZWlTMHE3QnlWOGhBcURKNEtIQkJ2?=
 =?utf-8?B?NE1vNFZIOXJwNVhxVGxNZWdWSnp1V2FubjFlNDNrbjNORmdIelhwc3g2SGhX?=
 =?utf-8?B?Mjh3MHY5MWJITW5scDVQZHlZTkRibEJHdDdsb242NUxCRlA4RWlwNHVUdENi?=
 =?utf-8?B?eURqNnA1NElmSGVGaFdIdStKTG5pa1pwZSs0eUg2UVZCMXNZV1hRNXZRL1Rn?=
 =?utf-8?B?Zm9uZ3FyanBZNldqdDlxa2JEcEtrK21vQi9YS29yVEJxZmJOZWc3WExBbVBa?=
 =?utf-8?B?RXhSYmxTeUdBNzBkbXA0UU5Nb1MwMDd1MDRZako5WTRTU3lQVzJtL1RzSits?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ad48b8c4-97c6-4d51-2b2b-08dd81bdab6b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:49:38.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBqnxEODjAVJPq54D7JjEQ6N7feG7AvTh4x5ndwroe7ozoxbjg6VeHxmorEztWRERCAJHASKSoBt49gEeUDjnIkUE3xd+ejUua04Z3NLfkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Apr 2025 16:49:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17541

Hi Antonin,

On 4/18/25 5:15 PM, Antonin Godard via lists.openembedded.org wrote:
> Add a new document to the BitBake user manual that automatically
> documents the library functions from their docstrings. The docstrings
> can be formatted in reStructuredText.
> 
> Here logging utilities and the bb.utils module is documented. Some
> members of the utils module were deliberately excluded as their usage is
> most likely only internal to BitBake.
> 
> Fixes [YOCTO #9612]
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   .../bitbake-user-manual-library-functions.rst      | 59 ++++++++++++++++++++++
>   doc/conf.py                                        |  7 +++
>   doc/index.rst                                      |  1 +
>   3 files changed, 67 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst b/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
> new file mode 100644
> index 000000000..09e353945
> --- /dev/null
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
> @@ -0,0 +1,59 @@
> +.. SPDX-License-Identifier: CC-BY-2.5
> +
> +=================
> +Library Functions
> +=================
> +
> +|
> +
> +This chapter lists common library functions available under the ``lib/``
> +directory in BitBake.
> +
> +These functions can be used in recipes or configuration files with
> +:ref:`inline-Python <bitbake-user-manual/bitbake-user-manual-metadata:Inline
> +Python Variable Expansion>` or :ref:`Python
> +<bitbake-user-manual/bitbake-user-manual-metadata:BitBake-Style Python
> +Functions>` functions.
> +
> +Logging utilities
> +=================
> +
> +Different logging utilities can be used from Python code in recipes or
> +configuration files.
> +
> +The strings passed below can be formatted with ``str.format()``, for example::
> +
> +   bb.warn("Houston, we have a %s", "bit of a problem")
> +
> +Formatted string can also be used directly::
> +
> +   bb.error("%s, we have a %s" % ("Houston", "big problem"))
> +
> +Python f-strings may also be used::
> +
> +   h = "Houston"
> +   bb.fatal(f"{h}, we have a critical problem")
> +

Isn't that the case for absolutely any Python function taking a string 
as input?

The whole thing is expanded as a normal "hardcoded" string before being 
passed to the function as argument no? So it feels a bit odd to specify 
that?

No clue how that works with the new string templates (t-string) in 
Python 3.13 though.

> +.. automodule:: bb
> +   :members:
> +      debug,
> +      error,
> +      erroronce,
> +      fatal,
> +      note,
> +      plain,
> +      verbnote,
> +      warn,
> +      warnonce,
> +
> +``bb.utils``
> +============
> +
> +.. automodule:: bb.utils
> +   :members:
> +   :exclude-members:
> +      LogCatcher,
> +      PrCtlError,
> +      VersionStringException,
> +      better_compile,
> +      better_exec,
> diff --git a/doc/conf.py b/doc/conf.py
> index fc2ee0811..f61241e28 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -17,6 +17,8 @@
>   import sys
>   import datetime
>   
> +from pathlib import Path
> +
>   current_version = "dev"
>   
>   # String used in sidebar
> @@ -47,6 +49,7 @@ extlinks = {
>   extensions = [
>       'sphinx.ext.autosectionlabel',
>       'sphinx.ext.extlinks',
> +    'sphinx.ext.autodoc',
>   ]
>   autosectionlabel_prefix_document = True
>   
> @@ -99,3 +102,7 @@ html_last_updated_fmt = '%b %d, %Y'
>   
>   # Remove the trailing 'dot' in section numbers
>   html_secnumber_suffix = " "
> +
> +# autoconf needs the modules available to auto-generate documentation from the
> +# code
> +sys.path.insert(0, str(Path('..', 'lib').resolve()))

I don't remember if we allow to build the bitbake docs from outside the 
bitbake git repo? It is present in poky after all? In that case, maybe 
we need to use a path relative to conf.py, does Path(.., /lib) do this?

Cheers,
Quentin

