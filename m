Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F6BC3DA6D
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 12:10:40 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.76])
 by mx.groups.io with SMTP id smtpd.web10.46581.1748002229742394656
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 May 2025 05:10:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=cEm2TM6X;
 spf=pass (domain: cherry.de, ip: 40.107.249.76, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdyi91TJqXhXIgCL6wtAx8mwpzdxALpXyX33liBpwRl537IDETRAmGdqPg31ynwOt49RTfm1xLXxAf/4YO2HEpfnsxeT1q6xxuQQjN23WAZT9tbFGMeokDLsGY44v98Po8HmmKJj23VDtTSIRrLR+Pgj+7C2K9CGWVV0VRXTHvPzr9BOzGG3SnAAoonONT8DdmDRaHD49YiGKxUkWCDOyU23KNMBUoxZ2n5Zm3lj2jJGua58WQZ1rjNJbSq3dT8YbasXbUJfkZ5eoj1p+BK/cDgrRgCjE/eawTniODMSUYz7+5vTyEnk8VTkIhMNKLqaM8BUvFr6hjJd4C8YSv9akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkWP+EoPew8z7mxqJPMMsBrCNno7EI+KhLKn8VRvy9w=;
 b=uiu9vq94Cb9VQ7xVdTBNtYoMdLbqA9XDYr9p6zpZ/6aI5Pl4TykyWbSvgzYD8qNA6bitVvgBLYfepdtQu5bCeYTv0hwjHMJ6dCJDgm2KGvSB6iIUOLkgSRDD/v6GEXkWYYmn0HWTv53GSkbm5JzjCphu5sHufjBEfGSlfVCRSsJmee6fbHu20DuQiiZVZzKgYjHRxLS7HpkfxLqMcYo8zTd9iLMAMYhCtMd9khHUHquhGT/17iDaoYkVAi4O60p1joK2SKDgFXTR/ndeRqiUUHtrnSE0CbW04FN7LL4u9zLXKHCeV65C6Chdn89atqEhr0amd0LmZksHSDYyVd4TwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkWP+EoPew8z7mxqJPMMsBrCNno7EI+KhLKn8VRvy9w=;
 b=cEm2TM6X0cu3+qM/B12dQfb1v93/u8hKJxG9bgiWNrh0vK2zgGJ9latKSfihwcjFerEppwcvbP39aPribwY9eb4A3YNkbydauHC/3qY+MnR2/HuXEwQh+CTCONuDGwxDmPQAzYBQhzQ60z6uvjcnvALMxFpM9pR3UrN6KQi4z/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6976.eurprd04.prod.outlook.com (2603:10a6:803:130::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 12:10:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 12:10:25 +0000
Message-ID: <efbaeb16-69e5-488e-8edb-422a044866ab@cherry.de>
Date: Fri, 23 May 2025 14:10:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] Add ? to mark the start of the AZ_SAS
 query parameters
To: robbinvandamme@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Robbin Van Damme <robbin.vandamme@renson.be>
References: <20250523114923.2206133-1-robbin.vandamme@renson.be>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250523114923.2206133-1-robbin.vandamme@renson.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0013.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: cb31eef9-a21a-4ef0-8b12-08dd99f2cc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WHZZQlI2V2gwY3VCNkZWZGZxaTdHZ0ZuWjNRSlBzbndScFczY1pRTldTY0Zr?=
 =?utf-8?B?VzNCaGNWNlVYWVB3ZzNtZHAyNG1TSHhOT21hUU5uUkxUYzJMYUdVSmRxLzFD?=
 =?utf-8?B?ekpwWkllZkJYdjNibVJqOVlCZkMxQ1N2UzNpUE42NnlGOWFIN3pZdi92V2w3?=
 =?utf-8?B?dWQ3K1VNc0pMakFoaWkxVXpNZWxWK2Y4bW5KLzZWRUtkb2JOU3E5RWEwWERj?=
 =?utf-8?B?NmZlVzMxM3d2UFVLMTlFR3V1NklFR3hJSW9TWGtjRHkyb2ZHQm1PaEtjUk9R?=
 =?utf-8?B?bFc4L2tYdHRvb2xIcmNObkZ0bDU3ay9WVXNEaE0vRGFhY20rR3krZUJycEZX?=
 =?utf-8?B?bDZUZkhkSjlKRHdwTTlQbGFZbGVKaHBSbE0yOVNJV1VKRlZvUHUvdFMxYnUy?=
 =?utf-8?B?RmxDam9HQlhxdG5BaDJybHdxaWNuYjcwbFUzSFhmc2N5OE54cnZtSmVralM4?=
 =?utf-8?B?ZnZxdkJsK0J2MFprZ3BmdlNabllJQWJ1bEw1K1lFZGdndEMvUkVVNW40UzVE?=
 =?utf-8?B?d0Q1a1FaR1cxTjV6M25kWm5JTDA0TndiWUVhN0xZblJqM1E5MVBCNFQrSmFB?=
 =?utf-8?B?c09RV3J6dmNZVUN4VWEwajFyMG1KWU9uQWVKeUJlNTdYVlNqQVQvUXNFQU1s?=
 =?utf-8?B?NWFQbCthVHlkYzMrLzNzbEkyMU94TDA1SVArTDFCUS9LTDU0bTZ3Sy9DRi9S?=
 =?utf-8?B?dDZGYTdKbXA0d3NkTXFmTXZTTkhRU01jS3Z6K0FISkJXRFJpNmt0VWRWL0py?=
 =?utf-8?B?RVZCU0lTdklNRTBLZ296bDJKd3RGZ2pmM3E1bmx3VG94RTB6c0k4M05iU3Rn?=
 =?utf-8?B?KyswbGJlclVKMjV0WnIvQmVIVzFVaFBEcGp6VVpvM2ZEOUtkTFZTOVE4Q2p6?=
 =?utf-8?B?MXJwTXpqbHB2UnJzZm1TSmRScnAxZE5mOFhtcXVFQXhUdktmUjZZZGNFOVpB?=
 =?utf-8?B?V1dtc2hJTFE4UExWQUpSMU00WVhVRGxPQUxZNy92bk5rWTNyVkw1Y3I2d1p6?=
 =?utf-8?B?Q3RkbG85RlptblNOWkVzZFZQeGN1OTJPYjU4WnptRVcrMnYrYVpsRm42RUhQ?=
 =?utf-8?B?SHFGMldVMXdUTjhvQ0pVN1lVMzBQaVp3TUJoVTV5OTEzd2xnRzhKR3R1K2RW?=
 =?utf-8?B?anBRY0lURDNKR0hLejJybXJEWlloQ2FYdG1tT2c5RmFPbHl3YUN4QTljNkNi?=
 =?utf-8?B?YkRiOHl3OExMeHBrWEdybkdpTm5JN2h4WEJDRlFScHV1SC9IaWxMVWJhWU5i?=
 =?utf-8?B?a3Z4MUpqRVRrUlFwTmNtSjJCWmZtOXU0NDRURjU3T3VWVkJGTTBsS21ZMVZQ?=
 =?utf-8?B?dEsrZDB2aUp5R2ZzV3UrUnhnSUtPUkVTbjRZY2ZMdHR5QVhGbU1PcFhNWk5O?=
 =?utf-8?B?NVJlOGRVMGUvakVHR2lrWmlFaDFyNi9pV1l1OWI5dncrVzNFZDQ4ZUp2UmNQ?=
 =?utf-8?B?Q0JCQmlseVdZNGc0b3JmVWR1bzBsSVpubTVaTUUyMGpKbXJJaldLa2dkUmFO?=
 =?utf-8?B?ejlhNkNqTjRLSUY3R1lYd3F5bkR3U0R3TENDV2ptZGtrQ0ZDb29aNXhzQ0kr?=
 =?utf-8?B?WXFLWlBMVi9WS2d4ZWxBZmk0eCt2NmhQWWU1WFhxd2tqRDQzNmp1cDFZaUJN?=
 =?utf-8?B?UFh4d1JlVU04OS94ekVBYWtVQ3RQalF5dGNCbU5CaTB1Z3Z3Y2VpL3B3SHhQ?=
 =?utf-8?B?R3dpdXV1UEZkTXhxOWw4RFFzWm1MOTFLbVFGQ3dNVEpBRGZ4T1lOTXdnY3Ns?=
 =?utf-8?B?aExGVnExSGZQZ3F0dW5oZTc0UkdON0doRUpUSmhMTzJCK2RWM1YrK1JkSWVO?=
 =?utf-8?Q?iUuBTdyAzDiHQuablqAibfln0woK8uwiQOB5o=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUdYb2kwenJjbVVLUS81Z2xpMmZMOGpVTWVabzhmUFJRUzNXczNmZGtmRi80?=
 =?utf-8?B?SkVYdXRxZm5Lc0RGWW9DTWlnU0Q0bmhUTVNhOERCWnluNnRBZDB5WmZlY3hv?=
 =?utf-8?B?cUZlaFNjZnBFL1VPeDhiL1RYUThJNVVpeHRXbWlyNzA3OXh1b3hmeEltMTE5?=
 =?utf-8?B?dkN4R0pNQTdETjMvbGhacDRSb1NBWnZTSGNmQ3J4SW9LdGljUVhjMTRUa2JE?=
 =?utf-8?B?bllXanU5RzduTHZUaVZKOXJGaTJRRGZZcUM4TEIzR21EVVlVT3lJWjVhbzFK?=
 =?utf-8?B?TFV4aE95MGMvQmRyaHlyRFNQNUpUQWdJWDVGUFdMOWhVdnpkV0lUVWt5QWE3?=
 =?utf-8?B?QjNGa3RqdnZzNzhyRVVyenBaZkhvbzQrMlF6R0xlSWRCUVFjb3dNeGNhRGtR?=
 =?utf-8?B?KzhkYjRJdjJWS21RaWxnYnFaUW5wQ3l6dDlSMGZhR1VnSC9XcGRDUGVScDhZ?=
 =?utf-8?B?ZjNtdXYwNTMxMHJvdm5mRXRlYk93VVZqZXNJZlhENzZIT1ZVYUVoU2NpZFU3?=
 =?utf-8?B?VmRHUXB3M252cXFuZEhaRTA3di9YMTAzUndIUDVyaVNmZkRDSGVSQStLdUV5?=
 =?utf-8?B?MmJ0Z2ZXMlIwK3RZaU00QU9xUmQzbU1veDBzLzdCKytGeWwyNTJaOU4rR3Mw?=
 =?utf-8?B?Tml0M3pZMEx1SUI0aTBIcnhBOEN1WXlQZ1JMa2s3OTVrbUVOMmVJN3JnZXBN?=
 =?utf-8?B?YjB5czlqNG5tUm9ZUjBhS2w1dUg5OFdQcTcwL21tYVlTa2YyVS9FZi80WmU1?=
 =?utf-8?B?Rk9PTGJUSTZYKzVyMkFnTzZvQy9SemxlVzU0RDRac1RtUmRWcFZCNFNYN2tU?=
 =?utf-8?B?MWlBazVjZFR0d0VHNkJpcnVSNVZ2S0F4d0FraXg5Qk44MFlteGswRmp2ZG9y?=
 =?utf-8?B?aW1COTZuY3E5dFBLam12S0xlOXliTytNcHFObDNaRXFOdUNKQXBVR0pDbkox?=
 =?utf-8?B?eWNpTE1ETHVQa01FTEFxVWpqTlU3Z3dQUXVFYkhUS0g2TUYzVDhpY2JDY3p4?=
 =?utf-8?B?Q051dUdPcmZMQmRQR1NwU05wN092QndDV3dhQVNkSnMyajBtRWxWQkUydENE?=
 =?utf-8?B?c1lUYWZRMGRnYm44M0Z3T0lqQ042TFFlSHhBYTk0b0JMN0t3N2piWXFxY0lm?=
 =?utf-8?B?MG1hY3lQb3F3Y3huUEcydmQ1YWZMNkFuY1pBY05pdldyekszb051SzNERmZx?=
 =?utf-8?B?SzRmcXFuOGFGcHNJZXhkQ3c3SnVCYXIwVXdGYitkTWo3c1EvdzlXYTUzekZJ?=
 =?utf-8?B?VDRkZ1JDV2NscWM3NzRzZVozVkVVN0RHZ3JNNk1kc2lrT3MrM2ZVL00wcmNw?=
 =?utf-8?B?bU5nZWg2eHNOR0I3TWlDTGgvVnIwdmlib1ZSaVlTQjliQlI3T253Mjg3d3Zs?=
 =?utf-8?B?T3NIaUhxTmJId3NYRnpBaERkZi9MYVp3ZGhKMjQvMElNMGcwUmR5VUNNYnNH?=
 =?utf-8?B?dWU3d25Ud1hsQW9OcHFQaW5wUjdxelgydTI4U0tRMGc2RzdKNVJzUjJ2c0Vt?=
 =?utf-8?B?amlaTzRrUmxuSEFFa2ZPazRGcDRqN0ZzZCtjU1l2R3NsdC9oaTEvTzJxZkxR?=
 =?utf-8?B?bTAxelllWkUzbWVyNmIvY3F3NjBjWXFSc3BkT0VGeitIUHBCZmsycm1wdzlV?=
 =?utf-8?B?OUIzUE1DNnl1bUNzU3NvVXZJeFh6ZHJEckVyRGFvQVdic0NWNE1DQVhicFhK?=
 =?utf-8?B?S0hIWVlXRGJIUXliUEVJSzZPZGRCSXlaWURVSHRwUjc2YmlaUHlDa05ybXlk?=
 =?utf-8?B?U3VRRytVZ0I2bGhGNzhGUHVuM2Jwa1d5ckllUzJkdVprdnYxMlZJd29TODlX?=
 =?utf-8?B?Q1NzUUMyU1FtZXU5MHVJYkliWHdqTGw4eHFzK1JDR3NXYkVPeGFXQXZTUm5p?=
 =?utf-8?B?ckZRT0IvV3VkRXZlQ2lVSlkrV1RsdkRvTnRtRVlPa1EvVEM4WUpiQmY4RVdu?=
 =?utf-8?B?ZjFqayt1YUovZVQ2cUZqd2lsZm1UN1RWQnA5cmh1akE1YWJWM1RrZllnZHMy?=
 =?utf-8?B?Q1NZNXFqd2JNNDh5QWZxb0h2ZWdxMFk1NHZxemN6VWxXN0dtYzJqdDhTZXQ4?=
 =?utf-8?B?cXhiazlnSVhWSFdYNUM4M1pUSnNPakZYVWcwU0NQYmpJblAxeks5TXhBd1A4?=
 =?utf-8?B?Z1UrNCtjaFFKUGlDRDJIWXBGVG55encwY0ZIbWpkUEJrL2NkcTh0em5US0hZ?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb31eef9-a21a-4ef0-8b12-08dd99f2cc8f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 12:10:25.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJtwbhHJVoY4wKnbtLgy+smXyJaoi40TH+8U1smI/O4wesYg+ZwIAptyB4qIuN9C04RJyNXkQoWYe7NF/TINFj6Y7DQwr7+AXQwan1+fh7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6976
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 May 2025 12:10:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17633

Hi Robbin,

Thanks for the patch.

But.. why this patch?

Please provide a commit log explaining why this is necessary or what 
kind of additional feature this provides.

Additionally, if this actually fixes a bug, a test would be most welcome 
so it doesn't get reintroduced later on. If it's a new feature, a test 
would be nice as well.

We're also missing your Signed-off-by here, c.f. 
https://docs.yoctoproject.org/contributor-guide/submit-changes.html#implement-and-commit-changes 
which signifies the submitter agrees to the Developer's Certificate of 
Origin.

Cheers,
Quentin

On 5/23/25 1:49 PM, robbin van damme via lists.openembedded.org wrote:
> ---
>   lib/bb/fetch2/az.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
> index 346124a8b..327273379 100644
> --- a/lib/bb/fetch2/az.py
> +++ b/lib/bb/fetch2/az.py
> @@ -36,7 +36,7 @@ class Az(Wget):
>   
>           az_sas = d.getVar('AZ_SAS')
>           if az_sas and az_sas not in ud.url:
> -            ud.url += az_sas
> +            ud.url += f'?{az_sas}'
>   
>           return Wget.checkstatus(self, fetch, ud, d, try_again)
>   
> @@ -62,7 +62,7 @@ class Az(Wget):
>           az_sas = d.getVar('AZ_SAS')
>   
>           if az_sas:
> -            azuri = '%s%s%s%s' % ('https://', ud.host, ud.path, az_sas)
> +            azuri = '%s%s%s?%s' % ('https://', ud.host, ud.path, az_sas)
>           else:
>               azuri = '%s%s%s' % ('https://', ud.host, ud.path)
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17632): https://lists.openembedded.org/g/bitbake-devel/message/17632
> Mute This Topic: https://lists.openembedded.org/mt/113263422/6293953
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [quentin.schulz@cherry.de]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


