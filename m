Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBFFC369CB
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 16:49:37 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.25])
 by mx.groups.io with SMTP id smtpd.web11.45213.1745340572416462809
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Apr 2025 09:49:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=egvz6ga+;
 spf=pass (domain: cherry.de, ip: 40.107.130.25, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA1p9AKhspOU7HGNFe8ZkAKG2b9kxuE1a+YugvsCMWdcl8Zb/FnYCO9vLUqZXszLTdDWB4LyPz3KlKVw+wbHlT3vorQNVwCyies7Cay+/2C9lZUDPCHXcdgJzQtwXXFyP5Q3xlcCQb2iXj4FWZPiEzt6xr7gll28lU3FyHSKgmpqQuv4U7RJ6Te/TwbxsYspcIxBlBr2M/02YXQoAxaWYWnpv4g7TMbTLAemx6JE8ki38R+Aqsfkz5a940k1YVuBktgCqGEAAauaM53yKk531pvd4MSvIn0EZu8kHm/SmKteogVAwqerxLBEmIKY72P+iRPecmsTDKLpWPGZQv9Gow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o2QFQ69nJHJJ6sX6cgEt3yAbLFqbtE0GCMjUFrkV9o=;
 b=f4Gi2hBpTeJfb3e/LVL9Fey4i2+Pp0CJygQUaTVF+uaq13NyCfp7Zxr5+MSn0MY+V87XKj4C/4ZtN5Senw1sVnpsMkAt7+2rKiHUUJVkpBjbsp248GNTyCqPUHZyfJ5vz7EYpvURdvwJdL5KDvjltuSzvITDe6u1HybZW8JdjbkITA77AFhPwSfJEBFJ/6FzkIyLIE5kLdHFBotGvCVMfE/4J4CsfB1dSz1jz4vYgdWh4crpRGYD/qs6uKm5VOFUjrzJOxRrMpAUDgguAy02k0gY3rSLSvXC6Qt0xjsuYcRvitEraJZrTPnS57VtiAEV9NLwfFwabQQGI9jMevEYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o2QFQ69nJHJJ6sX6cgEt3yAbLFqbtE0GCMjUFrkV9o=;
 b=egvz6ga+Fi7kKRXVO+jXdkifbGvUxB+vBTU70xySOXv6PjVlrN0uGZwSJVaLKtjVPmjAr78Hb7WjSY+sMd9jKPrjI21hts9+KS5BedTlUXsS8fRqz73VnUBZ1WxdE/fjvZU3fRPRlSUBqH/MQBeg7jmi5v9JocU/ljDw+RXjK6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 16:49:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 16:49:28 +0000
Message-ID: <9ffac255-a12b-48d5-8727-e40d5a8ac0e0@cherry.de>
Date: Tue, 22 Apr 2025 18:49:25 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [bitbake-devel] [PATCH 2/4] lib/bb: format and improve logging
 docstrings
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
 <20250418-library-functions-v1-2-3bbb836149d7@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250418-library-functions-v1-2-3bbb836149d7@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 419e427d-9b08-4485-9c0f-08dd81bda551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RXRMT2pUQ0RpZjdMdStSYVFjaDNJaCs1THR3UXd1TXgrU0dBUmUwbVA1QzdF?=
 =?utf-8?B?ckRFRVdUNlVxWTAyQjU5MUs2TUVzMlR6V0VXdFphMGpjRHhkQ2dEZDlWbjBy?=
 =?utf-8?B?MG1UbThYa2d4NjZpK0FmOHFFTExPNFNiMU5QdTRVZ1dFMjNnbllENkxmRmto?=
 =?utf-8?B?bnJTMU1MNFQvVDJjNS9rOWJpWW5UdnBObXpocWFoYk9UVkRGRnFuZXFuVy9m?=
 =?utf-8?B?UjBDWW83bklPbHNrR3podHp3cHhRd2g3RWswYjhiSTNkUGMxWGVjWGZBMExn?=
 =?utf-8?B?QkIxN2F6OU9GaXlGcjJzVzZ4NHUyejMyOEhCUGtzamtrdHBFdEcvekM1YTcy?=
 =?utf-8?B?My9Zc3BQVEZ1VlNUNkxNN2RwRWI4RHAwMHE2elh5TDBDaHdNcWQyV3VGaFBF?=
 =?utf-8?B?QkRUWnhySUNxWXdnSmQ1MUhibkl5VWc1WDMvejRqTDJIMlRLZzdDbmtYUHpa?=
 =?utf-8?B?emlNWDB4Sk9uVEtkK0V2dVdIU29BcjQzVXRMTFdQMHpXR1U1Z2x0d0lBNTVq?=
 =?utf-8?B?Nmw4YUsxVnpXSC9NcnhUQkdkNURBT0pVQ1JYT0o2LzhJSHhsSGpnNHhTbEJh?=
 =?utf-8?B?ZEE2NEhveHRTc1hsdE5KVFhmZVhEYmhGbGN6bk1jR2JncDNkOHR0dXZSNjM0?=
 =?utf-8?B?QTZkZ3lFNWZFMXgyU1lYaVJjdXhzVXEvd2tPZGNnRUczMEhteXBNSXhJSFAy?=
 =?utf-8?B?VFZwNnVJUzdpeDFxa2J1VVZrQlh2WTVIMmRVaWR5amI5bWVzR212UDZ0RDNx?=
 =?utf-8?B?dlo1OG5Ub0c1WjFpenlCODUzNk0yN21BYVUwcVlnZXpXUU4vZnBaQVN6SU1p?=
 =?utf-8?B?QTZpSHppZkJJaFJ1eCtwMlY2MFRHTHJZODVOaThMTFJyZWNaTTljZFN3MlRF?=
 =?utf-8?B?RkpLVitmQW1mUEpVNGx3SUswUE83enNmR096WXowRFZPN3Q5cU9CN2syNDQr?=
 =?utf-8?B?ZFFCK0tPZVlSZnh5L3BqM3FBMDluWWhYejVoQUdzSDFhS2xEK05KRmRMYTJn?=
 =?utf-8?B?UG1VVEtYbjZKSWJ0clppSTdqRk1xdHJPWTFpUHZaMUhsM1A0OWhzcW1RN1o5?=
 =?utf-8?B?elFNOUt1Z2RVbTh3TkpaR3A5NjU5VklLUFo1MjVERDRlcTNTWWlKK3l3WERu?=
 =?utf-8?B?UjlGcE8vYW5Jc3FUUFJ6OXpvSnBxRlJzcHMvU1o5V0tEejVlTGJ3eCtZT20x?=
 =?utf-8?B?WDRPV20wTmhVZmlsell1VEsrZmRiOXVhZENaQmlsUGs5dDZvOHVsYmN6bkdI?=
 =?utf-8?B?Ukw0SUMwdUp2L3haRng0b1ljc0V4Qk1XNlNwRi9QS0VjR0R2VUovSzNzdXI3?=
 =?utf-8?B?L0xWeHRTTlJWM1dJSHNwRXh4dzBRQm11YXdWL2ZZMiszK05YdURER0szMW1x?=
 =?utf-8?B?OVZORVFlRGlES0ZuVXQ1cmo2bWV2a1d6UFpoZjlvS3g1Z3J0T3BmMC8wdXVV?=
 =?utf-8?B?MWRiTmd3NDJnajlmaGdoQ3hNRzNzekFpZkFUVnczb3M3bXVVY0Y5SHJ4UjdN?=
 =?utf-8?B?Y2Vtd3F0NUlTVkJPZTV0Ti95QXg1U3JWOGh6bzB6SjN0Mk5lTWtWeUtRZVcr?=
 =?utf-8?B?R2pCWXRVVWRXNjBGdCszUUo5OEhNM2t4ZTRIcTdVTURzWTZtTVE1NmRjNXNT?=
 =?utf-8?B?SXQxS1Fzb0hMeUN2eGs2enFpdXQ0NEZLVXpNaWxmcmZCZUpUdnA3aklLNFR5?=
 =?utf-8?B?dnRIdHZPeGhNUERBYWdWRjRxL2QyTXlNM1dVMkFCNlpOVnhjYXlaK1I0cmd4?=
 =?utf-8?B?OG4yeHRlOHRncVFyb2MvMzBOV2poTDRmQ1F0T3lrZzlqNGRoa0NQdlk4MjlD?=
 =?utf-8?B?TWtWNDh2d2VDSi9VeHhteE00Y3FmbzNDSHJJcHlwTm9MRjJZcmFmZHp6Qk8x?=
 =?utf-8?B?WWFtOGM2Y0ZBa3FacktqRTRSUE03LzhlNC92cmxJeFNhSkFxWUtOd3NtUkFM?=
 =?utf-8?Q?gW1Y04gXOak=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MDRlb2tSZlVOZFg3MnFFRlBaSlpTdm5XYmowOGUrR09QMG15Ky82Y1Y1akNy?=
 =?utf-8?B?cnMxaC9lL1lvOXgva0ZQeE1OQkRIU0JLNmI4MkFoS2tNS052VTBqRmRvNWVn?=
 =?utf-8?B?OWpoOVBwN3hzT3FlL1RiMnVkU0pGdlY0NGtHdmRZSlFiYXYvL3hTMnRGTU5n?=
 =?utf-8?B?eTBaQnFvTHdOL0k1dFlEZ3c1Zmwra0tuRmgzNGpwOExJcTZUY05qalBxYTlM?=
 =?utf-8?B?QXF0NndhU1U2c0haSkJ6bThsSGVBbDhhVlhSY1lvTlRWRUdpd01UM0x3NWpV?=
 =?utf-8?B?R3pRYXBLT0ZWalZjYVVjSXo4VEc1SDUrN25RWmF3RzJITnVhSmJEY1hCaWVO?=
 =?utf-8?B?QmV1aEQydUU4QVJCRDkxUk56a2ZvMUZERktwcnZjNWR6R1ZuaGdOV00xZHQw?=
 =?utf-8?B?TjhCYVJ1c1MvUHlWV2pKSE9uTTJlWURpUHR3dlFHTnRpQzFSR0c5L2R0ZFJp?=
 =?utf-8?B?a0JoUEtnRFQvbGFBUUJnRU9FSlNvTTRpRmhlS0Jnand5Rm55b3BTZ1R0a2Ry?=
 =?utf-8?B?bHVNQkUvWmxaQXgveEY2N1U4a2MrVE1vTVpabVo0WmIwem5HQWdZSUZMdEpL?=
 =?utf-8?B?UmdDbTcrNjVzL21BYUpsdXFyM0w0bnRkRzJWUS8vdm1BWkdqeWdWdEVyeExD?=
 =?utf-8?B?UkExdGZsU3ZGbFJ0QnhNaUNNU0ZQQ2pERWp2cEpRdGduZU9aNGgxV3RyeDFR?=
 =?utf-8?B?OGNjbFovSW5yNEtzckZzU0gvZlRJSzMzSFdKYk1URWFDVkJnMkpqcWxnTnE2?=
 =?utf-8?B?NmRUNTlwTVJnUUdQTVcyT2hZUGZweVQ0YmhkZ0cvZExscUxQZ2RzeUJ0VVRD?=
 =?utf-8?B?UldZYzFyYjhxalJCZ3FtWEs5QUR4bU4wYyszUGVMM0xWVUlldzRzU3lCOS96?=
 =?utf-8?B?ajZhZU5lcDNzWlZZZ2pzdHgxcTc3N1VQYlJwc2o0WWJYeGlPWDM1MnFtbzZD?=
 =?utf-8?B?bEd6OTIyZHhNbUtxV2tRd1JUbEVyL2Mrd3ZKQldYMFNhNUJ5QmdvS1MvM0V5?=
 =?utf-8?B?aUU0U0wxbHZJd1psN1o1eDF2ZC9udGgxTmNGSG16WjkrQzZvay95cUlPN3dj?=
 =?utf-8?B?UDR1cEo4R1NITmU2VEsyajB3UU4yQ3dYRG4wNmowZXlFSmRVMDhqRTVjZEx4?=
 =?utf-8?B?Y2oxRXhJTWliYTRNbjFFNjlRNGJLb0xGVUhqTmt4TTNMcG1hcGpZVGxCTlpR?=
 =?utf-8?B?OUJlaE42ZUNiU1k4WGlka21icnNXdlRQa0M4elJhdzVPY3MydEFsb2MwOXl3?=
 =?utf-8?B?eXI1bjRTbXJURm9VeVI0RTJCcFhCYWxLTWNTVlhPYjhjSEd1c3NYZWFScDVw?=
 =?utf-8?B?blFEaTdRVzdDNkxyNWhDNVFrcFV2VWd3QmwyaXFCd2ZjaFpSL3c5YmdhSTVG?=
 =?utf-8?B?RXV2UEFsTjU2NUdHS25ZNHFiTnFxbUNLZ3RPbkNaUlQxT1A3clY1c3I5YkpT?=
 =?utf-8?B?bU80bm9vT3BGQlVZenB5dnd6aUxKeUhvZ0Fpa01ISThBRDJOTmdOa25xOVBj?=
 =?utf-8?B?SDFZaHhSeDJldTUzQW52K3IwV2o2bVgyMlBRZUFyK0txeGZzbEF6N05aakQz?=
 =?utf-8?B?WGNmYlhvSGJ6eHp0WXhRbVhmTVlkOGVaZG9CNU5QVGI3Zkk1MDZQc3Y1dEN4?=
 =?utf-8?B?bXlrZ1VieG9oNFFFTFkzclZNVUY3K3B1SDJMZTQzc1VLNmtnbEhQblZ1VnZy?=
 =?utf-8?B?YzJRcVRxOWFVWGVmV2FyelFXRmtKczU4QjhTTE1WSGloWFhTVThCTmdLN0t0?=
 =?utf-8?B?TDE1ZlNEVmVtNHBOV0EyVy9zd0VOejJzczBsblNRVWlSS0pPMkdwTXpvUzJk?=
 =?utf-8?B?eDRaNnhYb3pCaWhHZEg3anhsTDQ2dDhHb0lxcklYLzhPSWQ5WlYwSkt6ZHcy?=
 =?utf-8?B?L1k3eWRmTzFQRjBVd2VMRVU5OUdjU1JkbWVqQ3FVeGFuc0tlbjAybDFYOWZ1?=
 =?utf-8?B?Zy85bGJzaHltdjBpeW1OYjg0WEZzSm1zWVdXSGt6QVpzYnlmZ1J2a2FPd1hB?=
 =?utf-8?B?djM3VVo1WFl0UEpkQ1RZVHhYVm4xUkNNS25Kc0VjbFJ2bG1GNTNGbXMvYnFz?=
 =?utf-8?B?QzhKZzdwK1BwVHNMMkkweVd4R3ozQ1dERmZwN200bVBDWDc5VEtNNUlnNkhi?=
 =?utf-8?B?Y1FYblVJSTZtNFl5c3pWazVrUDdlL1FsWW9hQm5YVTZvSEUxNzh6bXdWMEpI?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 419e427d-9b08-4485-9c0f-08dd81bda551
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:49:28.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWDb3uIRJKCdUfiJ+LDbr+0sr6HdlIAty55QE28AWWP1BskCzR/z90RVXsfANgteUuRh9+BpH2+1wfe4pz7AEoNhbwOdZmdfk9FWEkSipe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Apr 2025 16:49:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17540

Hi Antonin,

On 4/18/25 5:15 PM, Antonin Godard via lists.openembedded.org wrote:
> Format the docstrings of the utils modules to be automatically
> documented with the autodoc Sphinx extensions.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   lib/bb/__init__.py | 76 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 70 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> index 566835573..c95c91a4c 100644
> --- a/lib/bb/__init__.py
> +++ b/lib/bb/__init__.py
> @@ -129,9 +129,25 @@ sys.modules['bb.fetch'] = sys.modules['bb.fetch2']
>   
>   # Messaging convenience functions
>   def plain(*args):
> +    """
> +    Prints a message at "plain" level (higher level than a ``bb.note()``).
> +
> +    Arguments:
> +
> +    -  ``args``: one or more strings to print.

Maybe specify that no space is added between strings?

Same remark for all other log functions.

> +    """
>       mainlogger.plain(''.join(args))
>   
>   def debug(lvl, *args):
> +    """
> +    Prints a debug message.
> +

You nicely have specified in plain() that it is lower than note() but 
you don't say something similar than debug, what is the closest but 
higher loglevel?

Same remark for all other log functions.

> +    Arguments:
> +
> +    -  ``lvl``: debug level. Higher value increases the debug level
> +       (determined by ``bitbake -D``).

It is an integer though.

What's the allowed values for the lvl? I see debug2 and debug3 so I 
assume 0 to 3 maybe?

Cheers,
Quentin

