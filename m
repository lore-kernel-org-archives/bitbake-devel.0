Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1F2D15DAC
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:54:58 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.30])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18656.1764777290097970487
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 07:54:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=lguOtI0p;
 spf=pass (domain: cherry.de, ip: 52.101.70.30, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI6zJjlSo7BZu6EsgZreoiaMan1LQDkTAoTFQV5GwGPGM0tFLwUdq1MOJZD+ndcBr+Q041F34gFkK3ylfV6sZ+HxjILf6tLqfkOcsjXHCJG1hMy39Nv9pKarlFntCUYjBq+A0NfNH63jEa2EoGQoq2OPKJCpXZVuxEdu9iZqiQ7i31rHRSyw292pZ7fSrQcgCsNyf9O2mY/GZZWUFeeq+HGbe8BSjrsawi3SXDbVZ1oAS3F6B+gk9xdAb2yB48bdb6boTds0rpmUmBxxg4OedauO0YBNSzhTwKn6TGgAMh8g/PrmvwlKo3DYc6wh8s38PEL8azy0OlxPAczPHl8gQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY6gnbW1SV/9L/1BJTUXjTereAmJKyyVkGflzLj0w9c=;
 b=bbOpP/FGAD+kMXVKYExoB4k+ALsMrgJClVjXBPIYaSjk1E3gnzQ+eVRMgYj0AtRRuoRovl7hGJjjBa71dXz+HKJrX8kOfrDWhMIiAaV/iBLuc7DaLjhTeZKEbH0xLeqiZpw52jpivafppV5L36zUzvVCJQUu+a7jyIO7OGJznrOqNUwjbyqBC/u2/rjD7wLFePAulnj22scVq4lN9gwpPkMLU7FsCHQf2/rXdbZ/rO9Wgk41nnvyvWBJKjf1xgz7Z3tED92BFMO4FEQAoTNSgaVvqelnHp8ppaHOfnFU1XSCA41iapvqMCUffrC58wKxnhXVVe+Udmc9p+rH0RtcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY6gnbW1SV/9L/1BJTUXjTereAmJKyyVkGflzLj0w9c=;
 b=lguOtI0pDjmjORgCqatJJe/2eGJ+bqSnzdaX/0bKOcasIgaiEbKREd4R7S+g9PLAHbXdlvYwayZOtPMMUmnMJMk9n+slpW8E1IEAE2FFHfrOOIBIn7mxZ8dLZPH8J7Xs7rjZUCf8v7l/kCJQtttf2K7GexTxhbYh+UpgAmrWa2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 15:54:46 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 15:54:46 +0000
Message-ID: <7ed18cfc-1f69-4e6f-a321-940f1b3765f4@cherry.de>
Date: Wed, 3 Dec 2025 16:54:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v4] bitbake-user-manual: Documenting
 BB_CMDLINE
To: swami310@gmail.com, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com
References: <20251203113900.31314-1-swami310@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251203113900.31314-1-swami310@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::12) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|PAXPR04MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 658cbe39-3181-484e-bad8-08de3284481e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VU9FUFdvSTdndWF6VzVBNVhndjZvRjhGb2pmT3M1Kyt2blZ3OE1CMCs0U0F1?=
 =?utf-8?B?c1RxcVE5eCsrcUNLNXZ3UDFlRXgyYTVhSkdXaGd5RWJhZTFMK2cwRmdIZGxP?=
 =?utf-8?B?TWNoMU9CUExPRHJmME5NTFhzVDk2NFhVWUhpMzV1eW5WbFgzb3hpV2NTNnZo?=
 =?utf-8?B?RlNyVjlTQWJCb0hiTi9PajlKcVJzYU9SYUh4L1NuY2R6OEhqa3l0TTNadkN3?=
 =?utf-8?B?dUhDNzFQWElIbGlua0NkQ1JNWk01aHExOU9ybjBDZE1zK1lOTk4rNlhQVW43?=
 =?utf-8?B?UEhxM0hTblpmTVJEU000QnpwWjc2dU1Sbi92eEk2c1FvU1BwSnJtY3JhRU1v?=
 =?utf-8?B?YnV6MHVaU0Nmc0l2VGJiOXhua05ZOEZCNVNhODFCbDFnaEtXeWNKYkdMMCtJ?=
 =?utf-8?B?SjRMMXM3bE5PeUxGTUY3bnpVcWZDS1laU3RHZExyOE83alhjWStVL0JTU3lC?=
 =?utf-8?B?SVpXcWZ6Z0NodE51UDU5WlkxeG5ZRHRxUEJkYkZHVzJZU0N1SUJNdFU5M3Q3?=
 =?utf-8?B?MW5OU2tsY1M0bGhqdytyNEdsL3BjQzBKZDdUZ0x5dWVmYitxM3B6ajhVbnQz?=
 =?utf-8?B?K012REgyenZXaG1lVmN1MGhxb2pwSjVjYThHbXhOR3pYaDlIK2xPVE9PaS90?=
 =?utf-8?B?RjFaa1daZnVVbFdqZlRQdE9pVEFyU3lhSFd2N0E4RmVVZzNxQWdBV2ZjMUN0?=
 =?utf-8?B?aGRkSWl4UWtGV0c4RnovZHMwQ3dDcFdRbEUyOFZwaURZZnpnYnBoWjdpRklt?=
 =?utf-8?B?b3BGR2tnTWE3RnAwQ2VGRzhPNDkrR0d3cTFqZDJKRlhTcW45Nks3US9iOFd4?=
 =?utf-8?B?dVhYUzdlS2k0S1hFSndNcVZTYWdRMXFKVGZnRUZYSFYvL2JVcmhPV2hSUkJl?=
 =?utf-8?B?TDZMRm9WSEdYek11bFlTSUxGSGNjaVUyMDlnTE5NL2FOZnMwR0JaSXhWSGxE?=
 =?utf-8?B?ZjZnMjVETUgxcElRSWQrWERYbHF6RW8ySVBqcVpwOG9Oa3lHUnVUQW1NMkZV?=
 =?utf-8?B?RnExT0Ird2liQ25uUUw0dnhYVHUvS2N3QTlXRkpnbkZleEZvSGV5OHRyaGsw?=
 =?utf-8?B?bGtGUVZDSjZBVGdPRnR5UVdVRm5zN0twT0dpN0RHWFh1ekdXWWdtTStjR1V3?=
 =?utf-8?B?dkY5K0duY0g5TytJTm53TU9kekMyQnZQb0dYeVk1cWJvL3QxMnRCbldMbS9r?=
 =?utf-8?B?SlhYZzB2ckw4Z0NvQ1ByNDkvVFlXRWd2d2k5NFNHWTBVVE0rV3NobTJpbC9a?=
 =?utf-8?B?a1NJbmFzWVJReTkrTHIrQkhNUWhneWN6d1MvQnNDVXNOL0tYaXQyNjJVbSs5?=
 =?utf-8?B?aWVSZ3V0U2FPQm1ydlRqTk44anVsQ1ErQUYxZVRRVVNzWjhxbDFqcVp2VFZ4?=
 =?utf-8?B?M096MzQ0TnBpSVpFd1RGMUxISERPdU5mRUJTMzJTMDcwNzZud2oza0JmUTUx?=
 =?utf-8?B?MUVhSWhDdHpMQ0R6R3BKOTN1ZzljRDZtU2dHRFFiZG9yV3dVa09xRnRqcXRa?=
 =?utf-8?B?ZjFkWUFneXdqamtvWWlvZmU4TEgwK1hzZmZKTjhsTEpBUno0bm1xV3hIdlIx?=
 =?utf-8?B?SzZ2R01SbUM5MStRR0Q5blh6R0xRSFhON0tPd1lxd2xHTERKYVJXM05iRkZq?=
 =?utf-8?B?Nk5WK256MkVyWDFCVDV0L1dhT2Y0UEEzWjFHUnhJSmhMbHgvUXprdE93eG1l?=
 =?utf-8?B?YXdJM0R6RHEvMEVSckcwTDR1OHZ6ajJydjJ1blhnTzlBQUtUR1hKMkozUDR3?=
 =?utf-8?B?ZWFNSzJ5ZkZLblRHUUo3YkYzSDJXNVFJUTVOMk8vRkZaSitKK1AxS2Jzd1Ev?=
 =?utf-8?B?aUE3Umsxc3FENEo0dlBJKzUvME5WNWMrb3kzcWo0dkNuelh4Wm53dmJuM3Mr?=
 =?utf-8?B?RmtXcS8za09IVWVwdXhXUGJ3OXRpVFFWN0UwdUlybmxUWmVFb3FqZmlhcndF?=
 =?utf-8?Q?VJSE3tQKwDRaEqlo9vQ49PfrWVcydGYj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB12026.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1FZT3MvNXowYnVCeFdrN2xuSXp4cWhlQ3ExRi9tSGJidDZNbWhla0VxODFl?=
 =?utf-8?B?dlBKTDMzRlFhMDBVS0QxVXhFSTZnTFh0ejl1cnBsUjVqSkxBR0JXRVFkZG1l?=
 =?utf-8?B?U1Fsay9FR0N1WlZ1TG5GMkpaWHdma0lIdklZZk9qWU9rWEZrT3ZDV1RsWlJl?=
 =?utf-8?B?UGp0R1VYMSt0U1NIN0xXUDNMdWtWQjY3cTFBVXBYUk5jcnpGbVBiMm9JcEtI?=
 =?utf-8?B?VjNyOTBxZ1JsNWpiTDZPcXdicW9SQXNKUWZFSlgvVysweEpERUoxa0NDUUpU?=
 =?utf-8?B?enhuVlZOLytaVXcwa2wweUV6clAwVmh6ZDMvMTJGQXVkTVVDQ0ErOXdlL0NH?=
 =?utf-8?B?MmZhUGlhdnh0UmtUQlQ5ODUwZCtibXQ0ekMzWVR0ZlpGeHdmcTdKc3JtQUw5?=
 =?utf-8?B?czIxMXBCYmpneGFFRzNZS010NHVMQ2lWZzNWQWtMQ0dXT0hDbWtzYzk4aGhM?=
 =?utf-8?B?OURKL1lNMEx0aWo2dTM4bCtzS2J5UlVNbFI3RndUMkFpK2xZaXhLUElQcWl0?=
 =?utf-8?B?T3MxUDZQZFJOa3AwK3JTTjhyTDVuL0FaT3JnZHptNWoxT2RSZHYzQW9XaUdo?=
 =?utf-8?B?S3VvMWZuaENEK3Awc0pJUmZJTGZGcE9Qbm1xUm1UY3BycWIwSlc4SUtVMDZy?=
 =?utf-8?B?ZjdoZWdYcHNNM3RtdlFTcm1Ycjl5Wjk2TFpTSERvWXVLMjJ1Q1hrVmk3SzNj?=
 =?utf-8?B?RnpmN0ttYXBpeFZtbXpESXJ5TXZqQlhVQ01vVmRCTTZJdDlHMnBnU0JJeXBa?=
 =?utf-8?B?SUM2bFkycHo4eCtpYXlXR2hpM2tRUmQ4MFRHL2VFd1VFeDlCTlIrNm9SdGF0?=
 =?utf-8?B?VXB2VW5TMnU0UXZqVGNpSmNkTlFIVUFrdnN6YklwVThLeHVFc2xaL1grY3Zw?=
 =?utf-8?B?VWJHcjdKeTFKTmtOVHUzRGU1MUdQNjEwWC9wWVI5V0dGN1RsSnZjaVpyc3Qw?=
 =?utf-8?B?b1owQjBaSVJ6eDlHR2pDdmhVNTB6aUdqOEExa2JSdS9aanFqK3VPTjBjK2hI?=
 =?utf-8?B?MVZBK2NoODdoUTJFTGtncngrb0RNcXJGZXNLa29Hb3VCT2lxTjNzNkQwckdT?=
 =?utf-8?B?cUY4Y2ZXV0V4WHRYVXAwV2cwTGc5aXVLS0xhVXpwaWw3bFpKS040Ymt4VmJu?=
 =?utf-8?B?WkJLVzB2dk5sQTZ2ZW9BaEZpNGZrblJ3cmcyZ3dIN1lPb1hZRTJwakp6UVlM?=
 =?utf-8?B?M3U0eGFIcXJYZmZNOHcwYm1xQW53N3NzK2dmUHR6UXN2YUF4ZURsbTdNZnRB?=
 =?utf-8?B?RmU1YzRUQ1Fja1BRbGZBaC9TVURzbTQxWWJHSzRMWHdCb09FK0g4SkUrWTgz?=
 =?utf-8?B?UDNOSG15c1FSZ0Q2cHM1dUErQnRqUTJkV2wyelF1R3FHTVE4N0lMamlWM2k4?=
 =?utf-8?B?Qk1NUGp3aEYzaVRqQlRONkhrbXczVXpPVXNhQ1lVR3lzeTBqRTNMbmUxWnls?=
 =?utf-8?B?RW5HSGRjdzl5ZVZMMTdsMTBKTC9qSy9TWTJXNlNKMjVVVTFDYUorNGhlVExh?=
 =?utf-8?B?dTQwV0VVS1Q2eW9EMlRVTEpVL1UyZjQ5V3B1TG02VDZsMWtBYkRMRlAwVUN0?=
 =?utf-8?B?ekxVZTlkbmxaT0cxMnl0ZVM1NXNmL0FndUNrcldnYWNBY0pCRDZnK3Bya2h4?=
 =?utf-8?B?bFpZUFN5SU04M0tBdkF1ZjRGMXlNaCtFOEVmSGU5bGtVcFRPQTV3ZUlkcVh1?=
 =?utf-8?B?ZW44aVN5UFpUbU54bmV1WjY0ZWNJNGRFbW01V0s4WGx5ZkROUVhwNml4SzFa?=
 =?utf-8?B?bmowUzZGbUt4QjU3T3NxWTRDZXhSL1EzbU1RcEhVSmhOWUQ5aGlIZXM0bDZN?=
 =?utf-8?B?RzgzanNCd2tlYzlFWXcyT0l4YTNZVGplVnlHaitONVpKbFVZODcwMTFWMGhG?=
 =?utf-8?B?eDI5c0NoZnEzREFteFlaejZKMERoTWp5TWpTYk1xU3NoOFYxRGx6VHF3UkRa?=
 =?utf-8?B?dnRlN0pLYUU2TitrUWo2bW5RNmVuOGMvS05hUkRIRkdNdFdzYmZyM3JyVFdD?=
 =?utf-8?B?ZnVkQXJRaWZmOTYvSWw2ZWgzRm9yWmdKankyZTZOZkRPNENscldxNkxnUk52?=
 =?utf-8?B?MFF6MFBVVitpQXQ5eE1RT1dwRFp1VmNLUTNuYVBzdWZzRTJaQ0lHdXltWFJr?=
 =?utf-8?B?WHBBeEpra3YxRW9BMEllaGc3aVloU3VsQ1lnaE9xZFVna244VmRyOUhEdHlR?=
 =?utf-8?Q?P9Zs3GEdZCDHkq/Ut6u4HMA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 658cbe39-3181-484e-bad8-08de3284481e
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:54:46.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUp+cZMwbRaYx540OEtCvVtGXXOUhLV8qgUQFWsdzuSS+2YsHvJxd/n7uiZvDJVLl+MGIK0uX7VF8ptjmPw27XcRETKv1AogiC3U+Su8PUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 15:54:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18530

Hi Swami,

On 12/3/25 12:39 PM, Swami via lists.openembedded.org wrote:
> [You don't often get email from swami310=gmail.com@lists.openembedded.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add documentation for the internal read-only variable :term:`BB_CMDLINE`.
> Fixes [YOCTO #15746]
> Signed-off-by: Swaminathan K <swami310@gmail.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..f49ce0f9f 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>         Specifies if SSL certificates should be checked when fetching. The default
>         value is ``1`` and certificates are not checked if the value is set to ``0``.
> 
> +   :term:`BB_CMDLINE`
> +        :term:`BB_CMDLINE` is an internal variable and is read-only. It captures the exact
> +        command line used for the current invocation of BitBake.
> +

This is inconsistent with the indentation on the rest of the file, we 
align with three whitespaces. So here the second and third line you're 
adding should have six whitespaces to start with and not eight like in 
this patch. Would be best to have it fixed, but the generated file isn't 
impacted by this, so not a blocker IMO.

The content makes sense to me after reading the code, so

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

