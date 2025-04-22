Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F6C369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 16:25:07 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.58])
 by mx.groups.io with SMTP id smtpd.web10.44505.1745339098098563985
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Apr 2025 09:24:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=lQ2fAu4F;
 spf=pass (domain: cherry.de, ip: 40.107.105.58, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2RTUNl3qOIJs00dcH1IZT56ZtOqg3gmaPnVls9LnG6MB6DO2lTaIKgaREsxOLk1/M9j25bAy1AJRU7b4O57I6XtL+e8ZVSbKfu8quShaVQnz7vmbrd0aoUw/nojplN//ZeXYk81gfI/6J+UM2L6HNMXI7s6OMguWNmIKBCA6Eo1WJ48V+GfSFO36A6hnGaQe6FCYDHR/BWVP5nhRNQzbZaT/Tzlz34/qwN4KcwnFgBB3Kabs9uUcna7mUKmYB1qoLa84Z0RGIb4j+3zHn1o9k9ktME4YRhNbR1rc85rLal9eT49i/63OHwAGYyvcavVfS/2xCnJRuLwYshHMSjZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hU2zpaMSXFNlNxCGyJQ8x+GQUuI8DjVCcxC88FEzWk=;
 b=JLhBNnk45rZd9VZHpHjczoA2U/MzOpjbxryxW2vKDXkmHFx1dd4I4d6QKjDI56aYvVNXOwHUwYIfJPNAiUTiu7OFp65nj0nqzB7krOXsGIq/K76DlZXkSK0PqDVa+UM+YibNY6hkdIBiNP4UD/uRTf0J9/FsNiJw47DzLEqK/krn+9eIP6ADsw6WyZQspzea0UCbys4C1ytIbDT4hc+mCSRJoMOqmytXwcwmXSmkccbX1HEd+LDHKFwo/ld1QkTDe9l6PkzpNdWRxA44M/NeIOB8IsVkIyMKADPWU5929BOvrU0xdooy4DFyqJioG9Jb5FCnBU+kwJTaROnmE4A0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hU2zpaMSXFNlNxCGyJQ8x+GQUuI8DjVCcxC88FEzWk=;
 b=lQ2fAu4Fyu5dOArgwqA6EaZuMieJ2q7CwhjSYAgN2A1YPtfQ3XiLHRvhm5u/vHWL3Ccvp0zG4oVabL3fia5PcrQ5oHQvdr/wL8Dbq1dvr96SXLJuz4J8+k2Eaav1jOzQr2S0rYI0zCK6qwGgylJJcnatW42JOWnlH2PXjp9cIYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8696.eurprd04.prod.outlook.com (2603:10a6:10:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 22 Apr
 2025 16:24:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 16:24:53 +0000
Message-ID: <f63dc42c-28a2-4293-8256-c19203132007@cherry.de>
Date: Tue, 22 Apr 2025 18:24:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/4] utils: format and improve docstrings
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
 <20250418-library-functions-v1-1-3bbb836149d7@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250418-library-functions-v1-1-3bbb836149d7@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 089734fb-2ade-4335-cf5d-08dd81ba35ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eW9GNjFoSnYrNnJ1RlB0OGxnZFErOEhFN2R2Q2dyRFdQM2t6b2M5d0lDalBT?=
 =?utf-8?B?Z21tWkd4SW54VXp6Vk02MVlITWFlVkNKeHhwem1CcWN3L21GODhieTd3UmJo?=
 =?utf-8?B?ZXNzb3ZZSjdFZU1FSS9mRW1uNXNrZ0l0S3VteDFkejV3cER4NjQySFpCR3hK?=
 =?utf-8?B?VVRMeXRpTC9YQUxmVVdSRUpDOTdweDR6MXpJSWZCaENmWTUwajRUeHhFcDJz?=
 =?utf-8?B?OEhuTUJpMTh4TXBFK1BOZkN6czlEQVp4QVllNU50dDdYZE80bG5LMHUyTWZW?=
 =?utf-8?B?S01XVVJBWDNXOVAzam5XNVZlWUp0ckI4VHVxTkV4c0YwZ2FoUnZXdnlFaTBH?=
 =?utf-8?B?MWVMeFA2SUt3dUpBeStJOWRqTmE1SXpmcjZOaDB0Yk55ZDVCczh3cGsxaHY1?=
 =?utf-8?B?Yzl4MTI3dWhxQm1yK25CNndHcllZTTAwOWM0cXBWNUlvdTlJV1U2YWhiOG8v?=
 =?utf-8?B?a2xqNVh1QzNsbE8reGVqZHY2T2VidnpEdlcvajNhS1B4QTBFcjM3R3RxQWM3?=
 =?utf-8?B?TnVqbFd6Wk9DWkIvSlhnY04wdkNhYnJ0MHZwRGRVMkw4Z3k4MVNLa0haT0Nm?=
 =?utf-8?B?c2gvRk5hK1VwZ3BmV09VK1N5MUhtdlV5Qmh3Sy9PY2dTb3NBa21HcHcwQkMy?=
 =?utf-8?B?SkcrcENVcERnWDBBKzBGVkgySWxvUzZraWR0Y01xeFFxNlNmMU0zUUs3SDI3?=
 =?utf-8?B?cEZjeEt1dDBSRTJJNGlhYkJUdTQvZW9SYnpuNUsxWGRoOUYvbG52eThnYzJw?=
 =?utf-8?B?cTcxcGVxUVVVVHRIMWFNMW9kWjJLcXFwY2dseW5lS3g5RjU4KzA1NkdkR1NP?=
 =?utf-8?B?eXo0UXZOeUdCVnJLQk4vSi96M0U3RlJjOVFUdW9KMEp3eVN1cWRQaUJvWW9O?=
 =?utf-8?B?Rk1DYW9xL2ZMK0pYQy9TQTVkQ2c5M1IrUTlhbk9LNWhzV0RIbDhUTm15Y0FX?=
 =?utf-8?B?UkljajFlRDJZbm90RHhJaXh2T2h3ckx2dEdhL0I5cU5sYmlWVTNJMndNM09x?=
 =?utf-8?B?YXpOWFk4UjE5S1ZBVWtKdlBxd04weDZTdXVVcTNZQlJab1N4S0pvWnVuYzdD?=
 =?utf-8?B?YjU0ZVdEVVJIYlJmc09xdkpwck56TGV6ajl3ZXdPMmErZzcxWjdTWFhSRUVZ?=
 =?utf-8?B?L3BRNndXVmlqeXJPdU5ZY0U4ZGdaa2pWYmFSRUZWOXZQU2trMmluM1BuZXRU?=
 =?utf-8?B?M0wzdUpQNTdLQ1J4c0Q4MS81V2gveXY3Y3Z1Y25NcmhwaGdQd3hxTTZXSys3?=
 =?utf-8?B?VTdVQ2VzUThOcVVCeWdmYnNYT1Zkbm5GK00zRnd0UGpJVlZ6QTBTbjFLWEdl?=
 =?utf-8?B?V2hnejZ1S2grTW9QV2xoL01mZEUzWml6Mm1vTFRVcWdTNStReDYwemFCUUoy?=
 =?utf-8?B?SzF5Q3BPa1pGcmUzcmJLVTUrbjNDMEIySnNvYUNrTUVGbTFuV0FoYkpXNXYx?=
 =?utf-8?B?VFRidnpzb3o2MGN4Vkt6bXAxbm04QzVaamVKM1ArY2htMThJbmZUOXJzUFhR?=
 =?utf-8?B?NDJjQlFub3FPVTl3VW5TTUhBcVhITW10UkQ0QXFvWGd3WmsxWElaZEdoNzZ0?=
 =?utf-8?B?QmN6eWFabFlnSm9jNEtJOWE1UFoxTWU0VFE1ZGxnRS9mU3B6dWxSZlJKT2Fs?=
 =?utf-8?B?ODFYK3JKSUdJV3F0QkxFNGkwYzQ5V3RxMEh5N1R3dFBGZVpKUkkyV280WUph?=
 =?utf-8?B?NVBoa29McjkyZ3V3SzN2U3d4RExOQ3pYMER4c1BtQnp6cW42M1NJNUVFaGp5?=
 =?utf-8?B?Q1RLVVdYTHJEelo1Njl6cmZYdDYrK1NHTFdmVk1Pa3ZmQW9JcVhCaGdoZVU4?=
 =?utf-8?Q?HJ+me9/f5kQPEHw8E3JOwlIJxqDyl32rSjbIw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OER4a0hKc2hLUlZCWFlMU3Z1TFlZSmJtcDViOC9XKzBtQkJ6L2xIUmR0TjI2?=
 =?utf-8?B?ZCt2cDczTmpYUkRRTTNkTUg0ZzFXZTAvZk5tWW9rVnBnTnpxZXFuakFsaE1B?=
 =?utf-8?B?N0JBZVJyZGh3Sk1DRWd5Q3hjeXJiNVoya2dDOERHbS9Ddml1TDNZNWhpbTEr?=
 =?utf-8?B?OG54YzBxUWtobndJaTQvOHlkRUFMQ1RDOEN0N2FGQ0QvNldlY0V2aXkrYlB0?=
 =?utf-8?B?dzJFazE2bUZ3UjREcEtYT2xSZ0Q2OXpZVzI5aGxOTy9OS0pNT0NlTGNIblBI?=
 =?utf-8?B?anV3ZHdYQVpLdTdKNkJSeEV6TE4zSmh6Y0tFVVJhbm5Ucm5NYkg4TEU2YXli?=
 =?utf-8?B?eGRwb1h0VWdKVm9YbnMySmVVTWJjQjNjVmxWTGFCc2ZNczZaSDlFdkR4T01T?=
 =?utf-8?B?eTZzYmo0TTJhbGhjdFdJS3Z3R1F2SVF3S0ViREpwUTVXcmhJN21ZcTl4VmVY?=
 =?utf-8?B?Q1F3ellSTkpqeXhha3dWVHhzczFuMnpQMmphZ1lQTnUvdWJQb2hkK0xzWStQ?=
 =?utf-8?B?VldGSXFRR0g0d20ycVo5dnlTeUorVDZ0UG45Rmp2dzFYS1VEUEtYbnZJYXQw?=
 =?utf-8?B?U0ZwNVhTbVI5eERFcTFrQ0FkZEJIQk12MEJHeHN2YXViTjhzamQzcFQ4WGZy?=
 =?utf-8?B?cXVQV25hejhLdnVyclZJSG1CbXpxb1BUTDByQ0tjQThITlFkWVo3bXJTVWRy?=
 =?utf-8?B?cGt4L2QvWGJGUUxmRVRmSXJoQ0NSdm13N0ZqWGpjeHhsaTRPejVDYk9Edklk?=
 =?utf-8?B?YXNWZkIwZEpkZ05BN0xIUlAvZkNLem9tRlZiVk82ckRqRWtjQ3JXQVA1d0dR?=
 =?utf-8?B?c2xKaTczUjJIN3MrcXg0VE9qSVFrRk9ybnFWdG5kTC91MjF6aFFwQ29TYzVO?=
 =?utf-8?B?KzdvYy9DM0E5ZWs2UWwzOG9TOUlJd1hPcFBXaytTUkIzZzM4aUg3cnJ3MEYx?=
 =?utf-8?B?UTUyK1JCVitUSHN6cXRCTDl0NEpuUDFPeHRVTWZkMkZBbHgvcVpJRjl5dTBH?=
 =?utf-8?B?czlRYWFBWW93RU9XWXNLNlJtVWxGVFpsL2Y3YzljZ3Y1ak5qWTAwSWJBOS9o?=
 =?utf-8?B?K1M1SVdRYTRIME9BYi9scWNLN1hzL0VPNlp1d1pQYWM1MjYxYTZqS3pFSmpT?=
 =?utf-8?B?cTZEVHJHM0xOY0NkSnpqVDFhYm1VcDJTKzRhMnBRZi9PV3VabGk5bHlPd3RY?=
 =?utf-8?B?U0hXMHdYYXN5NHg2OW9IZklqdzRZR3NQOW8yb1dvNWJFME9Ra0k4QlczYXVF?=
 =?utf-8?B?bmkycG5ZRGtUVGk1TGM3TW9xRUdDWm5TUlFUZ2tOSWhnQzdOajlKVzFZUVJv?=
 =?utf-8?B?dU43UEU3SWdmOU5SNlFlcU1rU1ZCYTdkQjlLUndVcjNCYjZ5K014dk9IbTlE?=
 =?utf-8?B?RGJwa242bGcyR0ZVOFBOZCs2UGQwc3RNd3E1ZnVvRFZLSkxOZWRUL0VPNFZu?=
 =?utf-8?B?YXJNNTRpbkhDSUxIRTRzKzRYQTk0Uk1GWmxLWXg0MW1aS1lHSUt5YkRVQXRk?=
 =?utf-8?B?K2k5Z3ZoOWtHTEo4VjRUdkkyNXZyUzRTNnRSblVIWmtJcjBiUG1WajFsTTRN?=
 =?utf-8?B?WkV4SzgzblAxajIzK0RtWHdZOFZHNTZrUW9HcXFJZU8vanZLVGhYZFp4YW1x?=
 =?utf-8?B?SHdNQkxTSytyVk1NQ0FVWXdTM3lWa05Oc25oWlNIUlJqaFA5emFWUzVjOUlw?=
 =?utf-8?B?cHJBNGhNQ09qOTRFc2VlUEprRlh0QXNFVjMvcGFxTjFCQklUWG45MGJJUFZM?=
 =?utf-8?B?RUtrRDE5Y3FtZExUcEtVV1lrSlBpRDNEQ200TGpqQ1l1RkZyYkViVC96SkRH?=
 =?utf-8?B?Yk53WTRkZDY1MDVXRXhlZTZHS2s5TDhKMlo1Q083YVRoVUFjYkdWRnlLOUZ2?=
 =?utf-8?B?Q1IyS25qREJaRE5hdEluaHQzVDQ0emxWaVNQSXZTUkVCdVQzdEhTTnlxVUdE?=
 =?utf-8?B?SlhHOVp1TGdGVjhTdkkvSnFqMGR0d3R3QmFVZlRQSlZ0RUNlSm1jR01iY3B4?=
 =?utf-8?B?RnUzekhXcXlmdkVWdXNDWXpCOFZ1dytxK3ZkSngvdjFIWEM3WlE5ZEhwc1gr?=
 =?utf-8?B?WENNQ3lPS1dLU0FMcGhvQ092blptT1FtSlhqTkhhTmJOMmE1anBtVDAxRHNt?=
 =?utf-8?B?dlJ6bjNTdTM2VHI2V1J2ZVkrMmNQWHZtdGJOU21vK2NRWTM1WXFYQkFFU2ZQ?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 089734fb-2ade-4335-cf5d-08dd81ba35ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:24:53.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/OrOCqM/SVbaHjrMOnNqqvf30fvBEjR5ZRFX671NLR1TUV2GnwcXCDh5pIj2iXK2S3T1hgxdlBT8/FQS3hmD/zGxIhTjiYRKsVG9Lm0hA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8696
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Apr 2025 16:25:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17539

Hi Antonin,

On 4/18/25 5:15 PM, Antonin Godard via lists.openembedded.org wrote:
> Format the docstrings of the utils modules to be automatically
> documented with the autodoc Sphinx extensions. Sphinx syntax can be used
> in those for proper formatting. Cross-referencing with :term: is not
> possible in these.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   lib/bb/utils.py | 601 ++++++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 453 insertions(+), 148 deletions(-)
> 
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 5486f9599..32de30979 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -82,7 +82,16 @@ def explode_version(s):
>       return r
>   
>   def split_version(s):
> -    """Split a version string into its constituent parts (PE, PV, PR)"""
> +    """Split a version string into its constituent parts (PE, PV, PR).
> +
> +    Arguments:
> +
> +    -  ``s``: version string. The format of the input string should be::
> +
> +          ${PE}:${PV}-${PR}
> +
> +    Returns a tuple ``(pe, pv, pr)``.

Why suddenly lowercase?

> +    """

Other docstrings modified in this patch end with """ on the last line as 
the last sentence. Should we aim for consistency from the get-go, or do 
we not really care for now?

>       s = s.strip(" <>=")
>       e = 0
>       if s.count(':'):
> @@ -134,16 +143,30 @@ def vercmp(ta, tb):
>       return r
>   
>   def vercmp_string(a, b):
> -    """ Split version strings and compare them """
> +    """ Split version strings using ``bb.utils.split_version()`` and compare
> +    them with ``bb.utils.vercmp().``
> +
> +    Arguments:
> +
> +    -  ``a``: left version string operand.
> +    -  ``b``: right version string operand.
> +
> +    Returns what ``bb.utils.vercmp()`` returns."""
>       ta = split_version(a)
>       tb = split_version(b)
>       return vercmp(ta, tb)
>   
>   def vercmp_string_op(a, b, op):
>       """
> -    Compare two versions and check if the specified comparison operator matches the result of the comparison.
> -    This function is fairly liberal about what operators it will accept since there are a variety of styles
> -    depending on the context.
> +    Takes the return value ``bb.utils.vercmp()`` and returns the operation
> +    defined by ``op`` between the return value and 0.
> +
> +    Arguments:
> +
> +    -  ``a``: left version string operand.
> +    -  ``b``: right version string operand.
> +    -  ``op``: operator string. Can be one of ``=``, ``==``, ``<=``, ``>=``,
> +       ``>``, ``>>``, ``<``, ``<<`` or ``!=``.
>       """
>       res = vercmp_string(a, b)
>       if op in ('=', '=='):
> @@ -163,9 +186,16 @@ def vercmp_string_op(a, b, op):
>   
>   def explode_deps(s):
>       """
> -    Take an RDEPENDS style string of format:
> -    "DEPEND1 (optional version) DEPEND2 (optional version) ..."
> -    and return a list of dependencies.
> +    Takes an RDEPENDS style string of format::
> +
> +      DEPEND1 (optional version) DEPEND2 (optional version) ...

Aligned to two whitespaces instead of three here I believe? (my mail 
client aligns the beginning of the code block with the k letter instead 
of with the e letter of "Takes".

> +
> +    Arguments:
> +
> +    -  ``s``: input RDEPENDS style string
> +
> +    Returns a list of dependencies.
> +
>       Version information is ignored.
>       """
>       r = []
> @@ -187,9 +217,17 @@ def explode_deps(s):
>   
>   def explode_dep_versions2(s, *, sort=True):
>       """
> -    Take an RDEPENDS style string of format:
> -    "DEPEND1 (optional version) DEPEND2 (optional version) ..."
> -    and return a dictionary of dependencies and versions.
> +    Takes an RDEPENDS style string of format::
> +
> +       DEPEND1 (optional version) DEPEND2 (optional version) ...
> +
> +    Arguments:
> +
> +    -  ``s``: input RDEPENDS style string
> +    -  ``*``: *Unused*.

This isn't actually an argument :)

It's a way to force all subsequent arguments to be passed as keyword 
arguments instead of positional args, meaning you are forced to specify 
the name of the argument you set the value of and cannot rely on the 
argument order.

e.g.

explode_dep_versions2("foo")

is possible.

explode_dep_versions2("foo", True)

isn't possible, but

explode_dep_versions2("foo", sort=True)

is.

We should probably find a way to separate those in the docstring I 
believe? At least to make clear which ones are keyword-only (since I 
don't assume we have positional-only as I don't see the benefit of it).

c.f. https://docs.python.org/3/tutorial/controlflow.html#special-parameters

> +    -  ``sort``: whether to sort the output or not.
> +
> +    Returns a dictionary of dependencies and versions.
>       """
>       r = collections.OrderedDict()
>       l = s.replace(",", "").split()
> @@ -254,10 +292,17 @@ def explode_dep_versions2(s, *, sort=True):
>   
>   def explode_dep_versions(s):
>       """
> -    Take an RDEPENDS style string of format:
> -    "DEPEND1 (optional version) DEPEND2 (optional version) ..."
> -    skip null value and items appeared in dependency string multiple times
> -    and return a dictionary of dependencies and versions.
> +    Take an RDEPENDS style string of format::
> +
> +      DEPEND1 (optional version) DEPEND2 (optional version) ...

Same "issue" with indentation as above.

> +
> +    Skips null values and items appeared in dependency string multiple times.
> +

Should it be "appearing" and not "appeared"?

> +    Arguments:
> +
> +    -  ``s``: input RDEPENDS style string
> +
> +    Returns a dictionary of dependencies and versions.
>       """
>       r = explode_dep_versions2(s)
>       for d in r:
> @@ -271,7 +316,17 @@ def explode_dep_versions(s):
>   
>   def join_deps(deps, commasep=True):
>       """
> -    Take the result from explode_dep_versions and generate a dependency string
> +    Take a result from ``bb.utils.explode_dep_versions()`` and generate a
> +    dependency string.
> +
> +    Arguments:
> +
> +    -  ``deps``: dictionary of dependencies and versions.

What exactly is the expected format of the dictionary?

> +    -  ``commasep``: makes the return value separated by commas if ``True``,
> +       separated by spaces otherwise.
> +
> +    Returns a comma-separated (space-separated if ``comma-sep`` is ``False``)
> +    string of dependencies and versions.

There seems to be a specificity around a dependency having multiple 
versions where each is listed individually. Not sure it's worth 
mentioning, but raising it either way.

>       """
>       result = []
>       for dep in deps:
> @@ -433,7 +488,11 @@ def better_eval(source, locals, extraglobals = None):
>   
>   @contextmanager
>   def fileslocked(files, *args, **kwargs):
> -    """Context manager for locking and unlocking file locks."""
> +    """Context manager for locking and unlocking file locks. Uses
> +    ``bb.utils.lockfile()`` and ``bb.utils.unlockfile()`` to lock and unlock
> +    files.
> +
> +    No return value."""
>       locks = []
>       if files:
>           for lockfile in files:
> @@ -450,14 +509,23 @@ def fileslocked(files, *args, **kwargs):
>   
>   def lockfile(name, shared=False, retry=True, block=False):
>       """
> -    Use the specified file as a lock file, return when the lock has
> -    been acquired. Returns a variable to pass to unlockfile().
> -    Parameters:
> -        retry: True to re-try locking if it fails, False otherwise
> -        block: True to block until the lock succeeds, False otherwise
> +    Use the specified file (with filename ``name``) as a lock file, return when
> +    the lock has been acquired. Returns a variable to pass to unlockfile().
> +
> +    Arguments:
> +
> +    -  ``shared``: sets the lock as a shared lock instead of an
> +       exclusive lock.
> +    -  ``retry``: ``True`` to re-try locking if it fails, ``False``
> +       otherwise.
> +    -  ``block``: ``True`` to block until the lock succeeds,
> +       ``False`` otherwise.
> +

You could have a link here to the flock(2) manpage there as well?

To explain LOCK_SH and LOCK_NB for example.

>       The retry and block parameters are kind of equivalent unless you
>       consider the possibility of sending a signal to the process to break
>       out - at which point you want block=True rather than retry=True.
> +
> +    Returns the locked file descriptor in case of success, ``None`` otherwise.
>       """
>       basename = os.path.basename(name)
>       if len(basename) > 255:
> @@ -516,7 +584,13 @@ def lockfile(name, shared=False, retry=True, block=False):
>   
>   def unlockfile(lf):
>       """
> -    Unlock a file locked using lockfile()
> +    Unlock a file locked using ``bb.utils.lockfile()``.
> +
> +    Arguments:
> +
> +    -  ``lf``: the locked file descriptor.
> +
> +    No return value.

Ah, random thought but should we also specify if and which exception(s) 
can be raised by a function/method?

>       """
>       try:
>           # If we had a shared lock, we need to promote to exclusive before
> @@ -544,7 +618,11 @@ def _hasher(method, filename):
>   
>   def md5_file(filename):
>       """
> -    Return the hex string representation of the MD5 checksum of filename.
> +    Arguments:
> +
> +    -  ``filename``: path to the input file.
> +
> +    Returns the hexadecimal string representation of the MD5 checksum of filename.
>       """

hex(16) returns 0x10.

I assume this function returns the hex string without the 0x prefix? I 
haven't checked but I assume this is so it matches the first string in 
the ouptut of md5sum?

>       import hashlib
>       try:
> @@ -556,39 +634,59 @@ def md5_file(filename):
>   
>   def sha256_file(filename):
>       """
> -    Return the hex string representation of the 256-bit SHA checksum of
> +    Returns the hexadecimal representation of the 256-bit SHA checksum of
>       filename.
> +
> +    Arguments:
> +
> +    -  ``filename``: path to the file.
>       """
>       import hashlib
>       return _hasher(hashlib.sha256(), filename)
>   
>   def sha1_file(filename):
>       """
> -    Return the hex string representation of the SHA1 checksum of the filename
> +    Returns the hexadecimal representation of the SHA1 checksum of the filename
> +
> +    Arguments:
> +
> +    -  ``filename``: path to the file.
>       """
>       import hashlib
>       return _hasher(hashlib.sha1(), filename)
>   
>   def sha384_file(filename):
>       """
> -    Return the hex string representation of the SHA384 checksum of the filename
> +    Returns the hexadecimal representation of the SHA384 checksum of the filename
> +
> +    Arguments:
> +
> +    -  ``filename``: path to the file.
>       """
>       import hashlib
>       return _hasher(hashlib.sha384(), filename)
>   
>   def sha512_file(filename):
>       """
> -    Return the hex string representation of the SHA512 checksum of the filename
> +    Returns the hexadecimal representation of the SHA512 checksum of the filename
> +
> +    Arguments:
> +
> +    -  ``filename``: path to the file.
>       """
>       import hashlib
>       return _hasher(hashlib.sha512(), filename)
>   
>   def goh1_file(filename):
>       """
> -    Return the hex string representation of the Go mod h1 checksum of the
> +    Returns the hexadecimal string representation of the Go mod h1 checksum of the
>       filename. The Go mod h1 checksum uses the Go dirhash package. The package
>       defines hashes over directory trees and is used by go mod for mod files and
>       zip archives.
> +
> +    Arguments:
> +
> +    -  ``filename``: path to the file.

Same remark for all the above.

>       """
>       import hashlib
>       import zipfile
> @@ -609,8 +707,8 @@ def goh1_file(filename):
>       return method.hexdigest()
>   
>   def preserved_envvars_exported():
> -    """Variables which are taken from the environment and placed in and exported
> -    from the metadata"""
> +    """Returns the list of variables which are taken from the environment and
> +    placed in and exported from the metadata."""
>       return [
>           'BB_TASKHASH',
>           'HOME',
> @@ -624,7 +722,8 @@ def preserved_envvars_exported():
>       ]
>   
>   def preserved_envvars():
> -    """Variables which are taken from the environment and placed in the metadata"""
> +    """Returns the list of variables which are taken from the environment and
> +    placed in the metadata."""
>       v = [
>           'BBPATH',
>           'BB_PRESERVE_ENV',
> @@ -633,7 +732,9 @@ def preserved_envvars():
>       return v + preserved_envvars_exported()
>   
>   def check_system_locale():
> -    """Make sure the required system locale are available and configured"""
> +    """Make sure the required system locale are available and configured.
> +
> +    No return value."""

Yes, but it does actually exit the program with an error message if it 
isn't the case.

>       default_locale = locale.getlocale(locale.LC_CTYPE)
>   
>       try:
> @@ -651,6 +752,12 @@ def filter_environment(good_vars):
>       """
>       Create a pristine environment for bitbake. This will remove variables that
>       are not known and may influence the build in a negative way.
> +
> +    Arguments:
> +
> +    -  ``good_vars``: list of variable to exclude from the filtering.
> +
> +    No return value.

That's not true, it'll return the vars that were excluded by the filtering.

>       """
>   
>       removed_vars = {}
> @@ -695,6 +802,8 @@ def clean_environment():
>       """
>       Clean up any spurious environment variables. This will remove any
>       variables the user hasn't chosen to preserve.
> +
> +    No return value.

That's not true, it'll return the vars that were excluded by the 
filtering if BB_PRESERVE_ENV is set in the environment, otherwise 
returns an empty dict.

>       """
>       if 'BB_PRESERVE_ENV' not in os.environ:
>           good_vars = approved_variables()
> @@ -705,6 +814,8 @@ def clean_environment():
>   def empty_environment():
>       """
>       Remove all variables from the environment.
> +
> +    No return value.
>       """
>       for s in list(os.environ.keys()):
>           os.unsetenv(s)
> @@ -713,6 +824,12 @@ def empty_environment():
>   def build_environment(d):
>       """
>       Build an environment from all exported variables.
> +
> +    Arguments:
> +
> +    -  ``d``: the data store.
> +
> +    No return value.
>       """
>       import bb.data
>       for var in bb.data.keys(d):
> @@ -737,7 +854,17 @@ def _check_unsafe_delete_path(path):
>       return False
>   
>   def remove(path, recurse=False, ionice=False):
> -    """Equivalent to rm -f or rm -rf"""
> +    """Equivalent to rm -f or rm -rf.
> +
> +    Arguments:
> +
> +    -  ``path``: path to file/directory to remove.
> +    -  ``recurse``: deletes recursively if ``True``.
> +    -  ``ionice``: prepends ``ionice -c 3`` to the ``rm`` command. See ``man
> +       ionice``.
> +

Can we provide a link to the manpage directly maybe?

> +    No return value.
> +    """
>       if not path:
>           return
>       if recurse:
> @@ -758,7 +885,17 @@ def remove(path, recurse=False, ionice=False):
>                   raise
>   
>   def prunedir(topdir, ionice=False):
> -    """ Delete everything reachable from the directory named in 'topdir'. """
> +    """
> +    Delete everything reachable from the directory named in ``topdir``.
> +
> +    Arguments:
> +
> +    -  ``topdir``: directory path.
> +    -  ``ionice``: prepends ``ionice -c 3`` to the ``rm`` command. See ``man
> +       ionice``.
> +
> +    No return value.
> +    """
>       # CAUTION:  This is dangerous!
>       if _check_unsafe_delete_path(topdir):
>           raise Exception('bb.utils.prunedir: called with dangerous path "%s", refusing to delete!' % topdir)
> @@ -770,8 +907,15 @@ def prunedir(topdir, ionice=False):
>   #
>   def prune_suffix(var, suffixes, d):
>       """
> -    See if var ends with any of the suffixes listed and
> -    remove it if found
> +    Check if ``var`` ends with any of the suffixes listed in ``suffixes`` and
> +    remove it if found.
> +
> +    Arguments:
> +
> +    -  ``var``: string to check for suffixes.
> +    -  ``suffixes``: list of strings representing suffixes to check for.
> +
> +    Returns the string ``var`` without the suffix.
>       """
>       for suffix in suffixes:
>           if suffix and var.endswith(suffix):
> @@ -780,7 +924,13 @@ def prune_suffix(var, suffixes, d):
>   
>   def mkdirhier(directory):
>       """Create a directory like 'mkdir -p', but does not complain if
> -    directory already exists like os.makedirs
> +    directory already exists like ``os.makedirs()``.
> +
> +    Arguments:
> +
> +    -  ``directory``: path to the directory.
> +
> +    No return value.

Mmmm, looking at the code, I don't understand why we simply don't set 
exist_ok=True to avoid trying to catch EEXIST? Unrelated to this patch 
though.

>       """
>       if '${' in str(directory):
>           bb.fatal("Directory name {} contains unexpanded bitbake variable. This may cause build failures and WORKDIR polution.".format(directory))
> @@ -791,10 +941,24 @@ def mkdirhier(directory):
>               raise e
>   
>   def movefile(src, dest, newmtime = None, sstat = None):
> -    """Moves a file from src to dest, preserving all permissions and
> +    """Moves a file from ``src`` to ``dest``, preserving all permissions and
>       attributes; mtime will be preserved even when moving across
> -    filesystems.  Returns true on success and false on failure. Move is
> +    filesystems.  Returns ``True`` on success and ``False`` on failure. Move is
>       atomic.
> +
> +    Arguments:
> +
> +    -  ``src`` -- Source file.
> +    -  ``dest`` -- Destination file.
> +    -  ``newmtime`` -- new mtime to be passed as float seconds since the epoch.
> +    -  ``sstat`` -- os.stat_result to use for the destination file.
> +

Why suddenly -- instead of : for separating the name of the argument and 
its description like it was done until now?

> +    Returns an ``os.stat_result`` of the destination file if the
> +    source file is a symbolic link or the ``sstat`` argument represents a
> +    symbolic link - in which case the destination file will also be created as
> +    a symbolic link.
> +
> +    Otherwise, returns ``newmtime`` on success and ``False`` on failure.
>       """
>   
>       #print "movefile(" + src + "," + dest + "," + str(newmtime) + "," + str(sstat) + ")"
> @@ -885,9 +1049,24 @@ def movefile(src, dest, newmtime = None, sstat = None):
>   
>   def copyfile(src, dest, newmtime = None, sstat = None):
>       """
> -    Copies a file from src to dest, preserving all permissions and
> +    Copies a file from ``src`` to ``dest``, preserving all permissions and
>       attributes; mtime will be preserved even when moving across
> -    filesystems.  Returns true on success and false on failure.
> +    filesystems.
> +
> +    Arguments:
> +
> +    -  ``src``: Source file.
> +    -  ``dest``: Destination file.
> +    -  ``newmtime``: new mtime to be passed as float seconds since the epoch.
> +    -  ``sstat``: os.stat_result to use for the destination file.
> +
> +    Returns an ``os.stat_result`` of the destination file if the
> +    source file is a symbolic link or the ``sstat`` argument represents a
> +    symbolic link - in which case the destination file will also be created as
> +    a symbolic link.
> +
> +    Otherwise, returns ``newmtime`` on success and ``False`` on failure.
> +
>       """
>       #print "copyfile(" + src + "," + dest + "," + str(newmtime) + "," + str(sstat) + ")"
>       try:
> @@ -965,10 +1144,16 @@ def copyfile(src, dest, newmtime = None, sstat = None):
>   
>   def break_hardlinks(src, sstat = None):
>       """
> -    Ensures src is the only hardlink to this file.  Other hardlinks,
> +    Ensures ``src`` is the only hardlink to this file.  Other hardlinks,
>       if any, are not affected (other than in their st_nlink value, of
> -    course).  Returns true on success and false on failure.
> +    course).
>   
> +    Arguments:
> +
> +    -  ``src``: source file path.
> +    -  ``sstat``: os.stat_result to use when checking if the file is a link.
> +
> +    Returns ``True`` on success and ``False`` on failure.
>       """
>       try:
>           if not sstat:
> @@ -982,11 +1167,24 @@ def break_hardlinks(src, sstat = None):
>   
>   def which(path, item, direction = 0, history = False, executable=False):
>       """
> -    Locate `item` in the list of paths `path` (colon separated string like $PATH).
> -    If `direction` is non-zero then the list is reversed.
> -    If `history` is True then the list of candidates also returned as result,history.
> -    If `executable` is True then the candidate has to be an executable file,
> -    otherwise the candidate simply has to exist.
> +    Locate ``item`` in the list of paths ``path`` (colon separated string like
> +    ``$PATH``).
> +
> +    Arguments:
> +
> +    -  ``path``: list of colon-separated paths.

to search ``item`` in

?

> +    -  ``item``: string to search for.

string containing the filename to search for.

?

> +    -  ``direction``: if non-zero then the list is reversed.
> +    -  ``history``: if ``True`` then the list of candidates also returned as
> +       ``result,history`` where ``history`` is the list of previous path
> +       checked.
> +    -  ``executable``: if ``True`` then the candidate defined by ``path`` has
> +       to be an executable file, otherwise if ``False`` the candidate simply
> +       has to exist.
> +
> +    Returns the item if found in the list of path, otherwise an empty string.

Returns the full path to the item, if found in the...

I believe?

Also:

list of paths ``path``?

> +    If ``history`` is ``True``, return the list of previous path checked in a
> +    tuple with the found (or not found) item as ``(item, history)``.

It's not item, it's the full path to item no?

>       """
>   
>       if executable:
> @@ -1017,6 +1215,8 @@ def which(path, item, direction = 0, history = False, executable=False):
>   def umask(new_mask):
>       """
>       Context manager to set the umask to a specific mask, and restore it afterwards.
> +
> +    No return value.

I don't think it makes sense to say a contextmanager doesn't return, I 
would assume it's expected it doesn't return. If it's interesting, we 
could say what it yields and do before/after yelding or when exiting the 
managed context?

>       """
>       current_mask = os.umask(new_mask)
>       try:
> @@ -1027,7 +1227,17 @@ def umask(new_mask):
>   def to_boolean(string, default=None):
>       """
>       Check input string and return boolean value True/False/None
> -    depending upon the checks
> +    depending upon the checks.
> +
> +    Arguments:
> +
> +    -  ``string``: input string.

It can also be an integer, if that's the case, then returns False if 
it's 0, otherwise returns True.

> +    -  ``default``: default return value if the input ``string`` is ``None``,
> +       ``0``, ``False`` or an empty string.
> +
> +    Returns ``True`` if the string is one of "y", "yes", "1", "true", ``False``

Please have a dot after "true" otherwise the sentence isn't easy to 
understand without context.

> +    if the string is one of "n", "no", "0", or "false". Return ``default`` if
> +    the input ``string`` is ``None``, ``0``, ``False`` or an empty string.
>       """
>       if not string:
>           return default
> @@ -1048,18 +1258,17 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
>  


I would add that to the description that it checks that all 
``checkvalues`` are in ``variable``.

I'm having a hard time to come up with a good description around the 
space-separated "limitation".

That is, ``checkvalues`` passed as an array **may** have strings with 
spaces in it but they necessarily won't match because only words are 
matched in ``variable`` and they cannot contain spaces. If checkvalues 
is a string, each word needs to exaclty match another word in 
``variable`` to return True.

>       Arguments:
>   
> -    variable -- the variable name. This will be fetched and expanded (using
> -    d.getVar(variable)) and then split into a set().
> +    -  ``variable``: the variable name. This will be fetched and expanded (using

This variable will be
?

> +       d.getVar(variable)) and then split into a set().

``d.getVar(variable)``

I don't think we care about the iplementation here, so I would remove 
"and then split into a set()".

> +    -  ``checkvalues``: if this is a string it is split on whitespace into a set(),
> +       otherwise coerced directly into a set().

/set()/Python ``set``/
?

> +    -  ``truevalue``: the value to return if checkvalues is a subset of variable.

``checkvalues``?

> +    -  ``falsevalue``: the value to return if variable is empty or if checkvalues is

``checkvalues``

> +       not a subset of variable.

``variable``

> +    -  ``d``: the data store.
>   
> -    checkvalues -- if this is a string it is split on whitespace into a set(),
> -    otherwise coerced directly into a set().
> -
> -    truevalue -- the value to return if checkvalues is a subset of variable.
> -
> -    falsevalue -- the value to return if variable is empty or if checkvalues is
> -    not a subset of variable.
> -
> -    d -- the data store.
> +    Returns ``True`` if the variable contains the values specified, ``False``
> +    otherwise.

Return ``truevalue`` if ``variable`` contains all the specified 
``checkvalues``, ``falsevalue`` otherwise.

?

>       """
>   
>       val = d.getVar(variable)
> @@ -1079,18 +1288,17 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
>   
>       Arguments:
>   
> -    variable -- the variable name. This will be fetched and expanded (using
> -    d.getVar(variable)) and then split into a set().
> -
> -    checkvalues -- if this is a string it is split on whitespace into a set(),
> -    otherwise coerced directly into a set().
> -
> -    truevalue -- the value to return if checkvalues is a subset of variable.
> +    -  ``variable``: the variable name. This will be fetched and expanded (using
> +       d.getVar(variable)) and then split into a set().
> +    -  ``checkvalues``: if this is a string it is split on whitespace into a set(),
> +       otherwise coerced directly into a set().
> +    -  ``truevalue``: the value to return if checkvalues is a subset of variable.
> +    -  ``falsevalue``: the value to return if variable is empty or if checkvalues is
> +       not a subset of variable.
> +    -  ``d``: the data store.
>   
> -    falsevalue -- the value to return if variable is empty or if checkvalues is
> -    not a subset of variable.
> -
> -    d -- the data store.
> +    Returns ``True`` if the variable contains any of the values specified,
> +    ``False`` otherwise.

All the same remarks as for contains().

>       """
>       val = d.getVar(variable)
>       if not val:
> @@ -1105,17 +1313,17 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
>       return falsevalue
>   
>   def filter(variable, checkvalues, d):
> -    """Return all words in the variable that are present in the checkvalues.
> +    """Return all words in the variable that are present in the ``checkvalues``.
>   

s/the ``checkvalues``/``checkvalues``/
?

>       Arguments:
>   
> -    variable -- the variable name. This will be fetched and expanded (using
> -    d.getVar(variable)) and then split into a set().
> -
> -    checkvalues -- if this is a string it is split on whitespace into a set(),
> -    otherwise coerced directly into a set().
> +    -  ``variable``: the variable name. This will be fetched and expanded (using
> +       d.getVar(variable)) and then split into a set().
> +    -  ``checkvalues``: if this is a string it is split on whitespace into a set(),
> +       otherwise coerced directly into a set().
> +    -  ``d``: the data store.
>   
> -    d -- the data store.
> +    Returns a list of string.

Same remarks as for contains()

>       """
>   
>       val = d.getVar(variable)
> @@ -1131,8 +1339,27 @@ def filter(variable, checkvalues, d):
>   
>   def get_referenced_vars(start_expr, d):
>       """
> -    :return: names of vars referenced in start_expr (recursively), in quasi-BFS order (variables within the same level
> -    are ordered arbitrarily)
> +    Get the names of the variables referenced in a given expression.
> +

Can you provide an example here in the description? I think the content 
of the start_expr argument description would be a good start (and then 
no need to have it in start_expr).

> +    Arguments:
> +
> +      -  ``start_expr``: the expression where to look for variables references.

s/variables/variable/

> +
> +         For example::
> +
> +            ${VAR_A} string ${VAR_B}
> +
> +         Or::
> +
> +            ${@d.getVar('VAR')}
> +
> +         If a variables makes references to other variables, the latter are also

If a referenced variable makes reference
?

> +         returned recursively.
> +
> +      -  ``d``: the data store.
> +
> +    Returns the names of vars referenced in ``start_expr`` (recursively), in
> +    quasi-BFS order (variables within the same level are ordered arbitrarily).
>       """
>   
>       seen = set()
> @@ -1212,7 +1439,9 @@ def multiprocessingpool(*args, **kwargs):
>       return multiprocessing.Pool(*args, **kwargs)
>   
>   def exec_flat_python_func(func, *args, **kwargs):
> -    """Execute a flat python function (defined with def funcname(args):...)"""
> +    """Execute a flat python function (defined with ``def funcname(args): ...``)
> +
> +    Returns the return value of the function."""
>       # Prepare a small piece of python code which calls the requested function
>       # To do this we need to prepare two things - a set of variables we can use to pass
>       # the values of arguments into the calling function, and the list of arguments for
> @@ -1238,48 +1467,57 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
>       """Edit lines from a recipe or config file and modify one or more
>       specified variable values set in the file using a specified callback
>       function. Lines are expected to have trailing newlines.
> -    Parameters:
> -        meta_lines: lines from the file; can be a list or an iterable
> -            (e.g. file pointer)
> -        variables: a list of variable names to look for. Functions
> -            may also be specified, but must be specified with '()' at
> -            the end of the name. Note that the function doesn't have
> -            any intrinsic understanding of :append, :prepend, :remove,
> -            or overrides, so these are considered as part of the name.
> -            These values go into a regular expression, so regular
> -            expression syntax is allowed.
> -        varfunc: callback function called for every variable matching
> -            one of the entries in the variables parameter. The function
> -            should take four arguments:
> -                varname: name of variable matched
> -                origvalue: current value in file
> -                op: the operator (e.g. '+=')
> -                newlines: list of lines up to this point. You can use
> -                    this to prepend lines before this variable setting
> -                    if you wish.
> -            and should return a four-element tuple:
> -                newvalue: new value to substitute in, or None to drop
> -                    the variable setting entirely. (If the removal
> -                    results in two consecutive blank lines, one of the
> -                    blank lines will also be dropped).
> -                newop: the operator to use - if you specify None here,
> -                    the original operation will be used.
> -                indent: number of spaces to indent multi-line entries,
> -                    or -1 to indent up to the level of the assignment
> -                    and opening quote, or a string to use as the indent.
> -                minbreak: True to allow the first element of a
> -                    multi-line value to continue on the same line as
> -                    the assignment, False to indent before the first
> -                    element.
> -            To clarify, if you wish not to change the value, then you
> -            would return like this: return origvalue, None, 0, True
> -        match_overrides: True to match items with _overrides on the end,
> -            False otherwise
> +
> +    Arguments:
> +
> +    -  ``meta_lines``: lines from the file; can be a list or an iterable
> +       (e.g. file pointer)
> +    -  ``variables``: a list of variable names to look for. Functions
> +       may also be specified, but must be specified with ``()`` at
> +       the end of the name. Note that the function doesn't have
> +       any intrinsic understanding of ``:append``, ``:prepend``, ``:remove``,
> +       or overrides, so these are considered as part of the name.
> +       These values go into a regular expression, so regular
> +       expression syntax is allowed.
> +    -  ``varfunc``: callback function called for every variable matching
> +       one of the entries in the variables parameter.
> +
> +       The function should take four arguments:
> +
> +       -  ``varname``: name of variable matched
> +       -  ``origvalue``: current value in file
> +       -  ``op``: the operator (e.g. ``+=``)
> +       -  ``newlines``: list of lines up to this point. You can use
> +          this to prepend lines before this variable setting
> +          if you wish.
> +
> +       And should return a four-element tuple:
> +
> +       -  ``newvalue``: new value to substitute in, or ``None`` to drop
> +          the variable setting entirely. (If the removal
> +          results in two consecutive blank lines, one of the
> +          blank lines will also be dropped).
> +       -  ``newop``: the operator to use - if you specify ``None`` here,
> +          the original operation will be used.
> +       -  ``indent``: number of spaces to indent multi-line entries,
> +          or ``-1`` to indent up to the level of the assignment
> +          and opening quote, or a string to use as the indent.
> +       -  ``minbreak``: ``True`` to allow the first element of a
> +          multi-line value to continue on the same line as
> +          the assignment, ``False`` to indent before the first
> +          element.
> +
> +       To clarify, if you wish not to change the value, then you
> +       would return like this::
> +
> +          return origvalue, None, 0, True
> +    -  ``match_overrides``: True to match items with _overrides on the end,
> +       False otherwise
> +

Uuuuuuuuuh, did we miss a migration to the new override syntax here as 
well? Shouldn't that be :overrides? And same for the regexp in the 
match_overrides if block?

Also not sure what "on the end" would mean here, I asusme we can simply 
remove it? I think this may stem from the confusion of what used to make 
an override in a variable before the : override syntax migration.

>       Returns a tuple:
> -        updated:
> -            True if changes were made, False otherwise.
> -        newlines:
> -            Lines after processing
> +
> +    -  ``updated``: ``True`` if changes were made, ``False`` otherwise.
> +    -  ``newlines``: Lines after processing.
>       """
>   
>       var_res = {}
> @@ -1423,12 +1661,13 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
>   
>   
>   def edit_metadata_file(meta_file, variables, varfunc):
> -    """Edit a recipe or config file and modify one or more specified
> +    """Edit a recipe or configuration file and modify one or more specified
>       variable values set in the file using a specified callback function.
>       The file is only written to if the value(s) actually change.
> -    This is basically the file version of edit_metadata(), see that
> +    This is basically the file version of ``bb.utils.edit_metadata()``, see that
>       function's description for parameter/usage information.
> -    Returns True if the file was written to, False otherwise.
> +
> +    Returns ``True`` if the file was written to, ``False`` otherwise.
>       """
>       with open(meta_file, 'r') as f:
>           (updated, newlines) = edit_metadata(f, variables, varfunc)
> @@ -1439,20 +1678,24 @@ def edit_metadata_file(meta_file, variables, varfunc):
>   
>   
>   def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
> -    """Edit bblayers.conf, adding and/or removing layers
> -    Parameters:
> -        bblayers_conf: path to bblayers.conf file to edit
> -        add: layer path (or list of layer paths) to add; None or empty
> -            list to add nothing
> -        remove: layer path (or list of layer paths) to remove; None or
> -            empty list to remove nothing
> -        edit_cb: optional callback function that will be called after
> -            processing adds/removes once per existing entry.
> +    """Edit ``bblayers.conf``, adding and/or removing layers.
> +
> +    Arguments:
> +
> +    -  ``bblayers_conf``: path to ``bblayers.conf`` file to edit
> +    -  ``add``: layer path (or list of layer paths) to add; ``None`` or empty
> +       list to add nothing
> +    -  ``remove``: layer path (or list of layer paths) to remove; ``None`` or
> +       empty list to remove nothing
> +    -  ``edit_cb``: optional callback function that will be called
> +       after processing adds/removes once per existing entry.

It'll only be called for existing (and kept) layers and added layers, 
not removed layers.

It would be nice to give the signature of the callback function so that 
people know which kind of function to pass and what to return.

> +
>       Returns a tuple:
> -        notadded: list of layers specified to be added but weren't
> -            (because they were already in the list)
> -        notremoved: list of layers that were specified to be removed
> -            but weren't (because they weren't in the list)
> +
> +    -  ``notadded``: list of layers specified to be added but weren't
> +       (because they were already in the list)
> +    -  ``notremoved``: list of layers that were specified to be removed
> +       but weren't (because they weren't in the list)
>       """
>   
>       def remove_trailing_sep(pth):
> @@ -1572,7 +1815,22 @@ def get_collection_res(d):
>   
>   
>   def get_file_layer(filename, d, collection_res={}):
> -    """Determine the collection (as defined by a layer's layer.conf file) containing the specified file"""
> +    """Determine the collection (or layer name, as defined by a layer's
> +    ``layer.conf`` file) containing the specified file.
> +
> +    Arguments:
> +
> +    -  ``filename``: the filename to look for.
> +    -  ``d``: the data store.
> +    -  ``collection_res``: dictionary with the layer names as keys and file
> +       patterns to match as defined with the BBFILE_COLLECTIONS and
> +       BBFILE_PATTERN variables respectively. The return value of
> +       ``bb.utils.get_collection_res()`` is the default if this variable is
> +       not specified.
> +

Missing highlights (````) for BBFILE* variables?

> +    Returns the layer name containing the file. If multiple layers contain the
> +    file, the last matching layer name from collection_res is returned.
> +    """
>       if not collection_res:
>           collection_res = get_collection_res(d)
>   
> @@ -1610,7 +1868,13 @@ class PrCtlError(Exception):
>   
>   def signal_on_parent_exit(signame):
>       """
> -    Trigger signame to be sent when the parent process dies
> +    Trigger ``signame`` to be sent when the parent process dies.
> +
> +    Arguments:
> +
> +    -  ``signame``: name of the signal. See ``man signal``.
> +

Can we have a link to the manpage directy maybe?

> +    No return value.
>       """
>       signum = getattr(signal, signame)
>       # http://linux.die.net/man/2/prctl
> @@ -1697,6 +1961,13 @@ def disable_network(uid=None, gid=None):
>       Disable networking in the current process if the kernel supports it, else
>       just return after logging to debug. To do this we need to create a new user
>       namespace, then map back to the original uid/gid.
> +
> +    Arguments:
> +
> +    -  ``uid``: original user id.
> +    -  ``gid``: original user group id.
> +
> +    No return value.
>       """
>       libc = ctypes.CDLL('libc.so.6')
>   
> @@ -1766,9 +2037,14 @@ class LogCatcher(logging.Handler):
>   
>   def is_semver(version):
>       """
> -        Is the version string following the semver semantic?
> +    Arguments:
> +
> +    -  ``version``: the version string.
>   
> -        https://semver.org/spec/v2.0.0.html
> +    Returns ``True`` if the version string follow semantic versioning, ``False``
> +    otherwise.
> +
> +    See https://semver.org/spec/v2.0.0.html.
>       """
>       regex = re.compile(
>       r"""
> @@ -1806,6 +2082,8 @@ def rename(src, dst):
>   def environment(**envvars):
>       """
>       Context manager to selectively update the environment with the specified mapping.
> +
> +    No return value.

Same remark as the other contextmanager earlier.

>       """
>       backup = dict(os.environ)
>       try:
> @@ -1822,6 +2100,13 @@ def is_local_uid(uid=''):
>       """
>       Check whether uid is a local one or not.
>       Can't use pwd module since it gets all UIDs, not local ones only.

I'm wondering if sphinx autodoc doesn't need a newline between the 
resume (first line/paragraph) and the description of the function? I'm 
travelling so cannot check myself right now.

> +
> +    Arguments:
> +
> +    -  ``uid``: user id. If not specified the user id is determined from
> +       ``os.getuid()``.
> +
> +    Returns ``True`` is the user id is local, ``False`` otherwise.
>       """
>       if not uid:
>           uid = os.getuid()
> @@ -1836,7 +2121,7 @@ def is_local_uid(uid=''):
>   
>   def mkstemp(suffix=None, prefix=None, dir=None, text=False):
>       """
> -    Generates a unique filename, independent of time.
> +    Generates a unique temporary file, independent of time.
>   
>       mkstemp() in glibc (at least) generates unique file names based on the
>       current system time. When combined with highly parallel builds, and
> @@ -1845,6 +2130,18 @@ def mkstemp(suffix=None, prefix=None, dir=None, text=False):
>   
>       This function adds additional entropy to the file name so that a collision
>       is independent of time and thus extremely unlikely.
> +
> +    Arguments:
> +
> +    -  ``suffix``: filename suffix.
> +    -  ``prefix``: filename prefix.

May be empty in which case defaults to ``tempfile.gettempprefix()``.

> +    -  ``dir``: directory where the file will be created.
> +    -  ``text``: if ``True``, the file is opened in text mode.
> +

Maybe add a link to what those means for tempfile.mkstemp so people can 
know what to provide this function with?

Cheers,
Quentin

