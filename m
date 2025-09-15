Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C4CAC59A
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 13:25:02 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.10])
 by mx.groups.io with SMTP id smtpd.web10.33250.1757942698231948823
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 06:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=WlIrnG7E;
 spf=pass (domain: cherry.de, ip: 52.101.70.10, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyP+rIjLITOY5Gpu78qvx1MH7dCYYHzT4kxMyfweQId9pmQzJ2QOxOaj8JJu6LauRlOd7bNVzjmfnPY7pqnGQpU+/HrCSNcjwqv6ftIp5C1LTfaRg6NBA0zRpplfdBtTk5aC+aCrZOV4S+mC1K6G5eTvUF3EqYHz5Z/g75FapxH0pB85Z/JDQeJGbtUPAMco0+yNk5KgRg/sbX46EPz8nYs3f4+beblDxjsqnCy+atcfqprtWjzQKzhTUOVX12uccxUXdfNkD756OUFsII37d6VoARckrcXtC9U+GBfCp3UH2z55frw/pM7mKP4cydf2ZEEqlB7/T2Ku7LFtsBSH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX+Gy7wuC06ENo8a2IR7FAtjOtWiv/a9wO3HUX5lLqE=;
 b=wyg0r9v6p2N77iwRLCjtfqMKcItRjGjZz6bml76LT37TdJX/sgTf7ijKoC2UljbC2r8uTDiJiaqV6vy9gr0xeCClHWmM46YoM8aVeWr0MgLu9SSGN5+U+gnkZig2XFnHn2neBiRXb7V0iCTjIqgnGuI+K5unVjwn884yuuKBHJP2Ted/vdOJiN2e/d4QQfzS00U0U2r5tTD0oKDsEaQt3iOb4RIrNohY3TR10m0BiUJxfcfprd5OjID0Ao9OeUoW7x2ZWQlO+Q7DVStfGX2TS1dVg4v2Q8f89vKq+/ajE9EAPc1EY/p1pyquAEoAMeW0piLnOUGXNEBL+Bs0dyqZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX+Gy7wuC06ENo8a2IR7FAtjOtWiv/a9wO3HUX5lLqE=;
 b=WlIrnG7Ey7K9RdW97Ttt7nSxSgER6h4xVhfXlEYTVsZyNmp+kUIauayvmA7r6dcQyyFrWO0NQMUMJ7/h/UVOK1CwSx97S7EcasXV0iCToZOQ7wuQsHP7Pcvy9vyJ7oErUUWs0FrGiDUEMs3tWTXcgXeUiDGglkD00mVWEweE/GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10400.eurprd04.prod.outlook.com (2603:10a6:102:44b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 13:24:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:24:54 +0000
Message-ID: <049595e6-2dc2-437e-b0ab-322f6b943b7f@cherry.de>
Date: Mon, 15 Sep 2025 15:24:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH 2/2] doc/conf.py: get current version from env
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com>
 <20250915-fix-switchers-js-v1-2-523ef53fe802@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250915-fix-switchers-js-v1-2-523ef53fe802@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10400:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb1d3e6-b205-4008-059e-08ddf45b41ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RkZJcFFOaU93NUdOY0RkMWMyejdKYmZUSFRtWUhIN0djeWdYV1lQSWNJYnJq?=
 =?utf-8?B?d3dNYk1kb29TZjV6SXpRODFack1ha3hNUE1tT1ErZnl4VDBTVVQyVmNXdnlB?=
 =?utf-8?B?bFBZTHlrYTA2cCtMY1ppU0Rid3dNNkh6aVdDOXlTN2FBQjkvL2s2Tm1ZNGk2?=
 =?utf-8?B?L0V1STkzQ204dWM0NE9YdEN2aDAzdk1RTVN4cW1henZaUFNCbytZSGlQNDEw?=
 =?utf-8?B?UXBKUmtid2prTkswTDBpUWVneG5TNytqNkpyQjF3TDQ5NXNxSHMwa1BqYTNU?=
 =?utf-8?B?a1EvRVYyVHdHZDVtT3JsMFJ5cGIveXd4SnNuSVE5dmkzSjdRM2pTQXN4WEo2?=
 =?utf-8?B?ekdvT0wxSmlvZVdtSmFpeUt3MXF1ZEZ3aHVPRDJjcEpNdHRsZmluRkpIb01x?=
 =?utf-8?B?RFJyMy9uUjZLMG80TFpIOWk1aGd3anNyd0VjbjhyUWZoWVpHVklIb0dxcm45?=
 =?utf-8?B?NWJSbXFsS2habXNLOFQ0Ylc0Z0xKUDZ0Q0JwZi91REgvNnFoMnp3dVUyTVpL?=
 =?utf-8?B?Y0tHOUhtL1dGUVlPU2cvQy9wTDVJLzNKV1FLWWFLMmNLNlBVYXhoRitsS1pu?=
 =?utf-8?B?RzhDNDVMT0ptdGw2YlRZZU4rTVdudENpL0pIRk5qeFk3Wmc5TGNSejdSc3lK?=
 =?utf-8?B?ZDN6WHdCK1liY01EemxEMjlBeTJHSjJyd2V5QzVzd0JkN3pKbGo5VUkzbU5n?=
 =?utf-8?B?S3BXWTBQZGI0NjMva1NKRGp6d3lpdmR5T2FWQWw1T1Y3VFZDOURDR2cxODR6?=
 =?utf-8?B?K2VyOFdMNnBnL2xweGF0RU15QjV2N0E1K2V6RFNrMno1cm1qaHlON1FZdENu?=
 =?utf-8?B?Mi93K3g2VWQ1ZWt6ajgwbFIrSHVySEhRdmx3Ukp0a2hYalZBM051V2Z5YkxW?=
 =?utf-8?B?STl4VzQycXZzNkdSWUM1VGI5Z2ovVm83SVZtMlk4amJ4dmhNUUpRbThDZERh?=
 =?utf-8?B?SFA1cVNLZVorRmJuY3ZyaTB0VFh6MFhCYTNtODFZRExwQndPWk9jT2phc0xK?=
 =?utf-8?B?Si8zMmpkQlpmdlZnSW9kY1FoNkxhU0d1Y29GZEJiN3lENUQ4YjhWa3p5YVZp?=
 =?utf-8?B?WW5xQzd5VVVuem1IdDc2L1hlSEM5cHhRblltY3MyV1FReVYrWGJjWWgvTkUy?=
 =?utf-8?B?R2wxYklwZm1OMmRTWEdXSnZsSEtsN3BxaG9URzlwbmR0WXZpRzIydFlJMzJH?=
 =?utf-8?B?aEY0YTd3ajIvZUtUOHpubHYwQ2lhMEY4K2JxN3RSYVhvUytUOTZEcDJueXQy?=
 =?utf-8?B?QnZmYzQ5aFpQTFBxcDJKbEdyRkFBVEZzejYxRk9xVUZTSVpGb1lUUk5zVVAw?=
 =?utf-8?B?Q3JwTXRkanN6ZEhHTUR3SWsrSGZJNDZJTStEVmlSd3dJS0lzbERoL1BqUStk?=
 =?utf-8?B?QjlDMFV0N2JBRnVqZ2k2eHlZWGF3allCQWtjTmRtLzFWTC8yTTdhRGg2dkFP?=
 =?utf-8?B?VG9LdDVaZ0RyZFJOUnBZRU1vbnBxZkFOZHFQSjc3WUowOXR5WnI1TnZoUGhY?=
 =?utf-8?B?S2w2cE5Td29ad2ttbHNMZ3J1YWg5aTQyUzl0NDdESG03QVhDVUZTNWFnWXR4?=
 =?utf-8?B?aSs4aFhIczcrM20zSjA2RE9sbm11dUJGVXE1M2RBajkwdXA1b2h0QVdVYW9H?=
 =?utf-8?B?WnV4VmpWaXduYzFUMEk2eEZXMFJJanFqV0toaVJnUjRENlBSd0RtYzIrZ1hq?=
 =?utf-8?B?VUZZQzdaVk1ETUhuNmRCV0RLMHJJQUZIbkJLc0F4ZDVGNklIdXBIdnFNTjJ2?=
 =?utf-8?B?QWdjNUw1dVlhQ3BiSkRoai9ndnpyK3FOL2tRc1FlUnNWTXdseWhvMXZ3RXh5?=
 =?utf-8?B?YjV0YzRzNHRqVXVZOGViaVVJSldOVnp0WXNadEg4STNPbklweWRHSk1qWE0x?=
 =?utf-8?B?TXVGQzRFOGZqVkRZcWRqeFVsckZoYzNYYndCa29PcXJIWTk2SzNlMnptR0pH?=
 =?utf-8?Q?kF8UOXU2BVc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZHhXYUZBNzg2ZG9CK1pDTWlucTRaSE5mQ0dRTUgxYWRZaEVOU1RXUVhiY1J3?=
 =?utf-8?B?UG1rRnAvVUU2ZVNKRThPWHJ0ZWJTUVhTWjh6V3F1U3J3WWI4cjFlOURReWxl?=
 =?utf-8?B?dC8vY0doMlJGaDFCTzJ4TkcxS3J4NCtUZWNUdjNLbmVKcHdLdXc5L1VncHpE?=
 =?utf-8?B?RERiRWQ5NnBKL2htVzJDZFU3Ukl5TU1XaXQ0VHNBRjEwSmx2clBVeFFoSDRZ?=
 =?utf-8?B?Rmt4VnlqblNQUVRCMi9QVmxEMXJlcFBMRjc4WFcrUlIyMWxqUHJVd1RMcXc1?=
 =?utf-8?B?WFFFOXgxWi93UVdlSVFTR0dLbmJ2akxTRy9kQXM5UEplSnhadUErMnRUMDVn?=
 =?utf-8?B?Qmw5ODRtbnpHcUQ3bTBlRzB1VGRsYnBSTmRsMm9yeFBXZGNZaWpjSHJMOEZZ?=
 =?utf-8?B?TnphTTFodmZqUVllaE4yU0lVazN0Z0pFa2FwZTYwSXZXUTlqbHpjSmk5aXgx?=
 =?utf-8?B?VkF5aG1qV0JGWGo2S1NrMUVVM0l2VWswN3FxRTJkYUZoakxaR083ZjNQS3dQ?=
 =?utf-8?B?WlNUeFNNdmd3VnlSLy9odUwza1AzQjBiNWFSTXFkcWVONjM0WjAyQWZSTmVI?=
 =?utf-8?B?ZGw0ZU5pUGc0VUtydjhNQ3VpWTFGQUpGQ3ZwMjh3cU5ZeURrV2NWVlk3L2lW?=
 =?utf-8?B?QWRubWRpcWFlZDlKSmZxdjNwNDFMeXdwZTFiSndwbmtielpvTExpUnpLYVg1?=
 =?utf-8?B?cnFOenlHUHFoQVhJVExSbVV2ZHo0ZnE3dWlSUWNuR0dRbGJ3NTFNNGZnNWdx?=
 =?utf-8?B?RVhMTi9Pc0F6NWRuQlU0eGhrZDFNTm53alVSb3gxbTRTSU94emZYMlM4N29Y?=
 =?utf-8?B?T3lrZWtiRkQ0WXoxc1FWWWlETi9EOXZnemlpWmUrL04yYTBQbEdjTG5jREtE?=
 =?utf-8?B?dXNjRHV0Y293WExaRDMxSy9xdlVSMzQrVVR6RTRqRHgrSC85Q3dnVGlHNzZx?=
 =?utf-8?B?cXY1aE54YXdKSzZPb2tablpVMllRZlRhdXRxWVJVdndQUHJVWU9WeXdLRk9T?=
 =?utf-8?B?UGQra3U0MVNiZ2c2cXhwWk1DMXRFejNwazM0elA5YTl6Ui9SVDZFZTltdnhO?=
 =?utf-8?B?ZzJYUkZKNVMrTGVlZXJXdG1DTWxMampPcXg2YUJaSENvektCS1R4SGs4WGJF?=
 =?utf-8?B?c2FhMzV6cU5WcFhDalF2SVh3MDFyemlwTXRZQnJsSW5keUdLY3A1TGVTTmZq?=
 =?utf-8?B?cDB5UTlmMWMvNlEydWc5YjYrSktrb0RKdFpBMm8yZWE1dHllYThyVm9IVzhX?=
 =?utf-8?B?V1FIKzZCTHQ3UXg2L00rOGRaY1FsZ3F6RzZheEJSUVhqZnVTY3ViM3gvYTV3?=
 =?utf-8?B?dW9TRWRjck5kV0ozSXQwQzNXcmNUenNOMmNoakFrb05qRlFPdHQ0SmhPS0t0?=
 =?utf-8?B?OVgxQytXWkgydTlhSUJMdHZlc2tSNllubmZ4OGp4ZVFwcGl0Wm5VNkt6OU1r?=
 =?utf-8?B?VDAwWWxPci9NQlBmMWJqSllJTjV5U3BaU3lObGZhVnR6enR4cDNmbmQ1RkVx?=
 =?utf-8?B?U3V0ZktEM3ZhQ1c4WDFTQVFpSlVVWXNnM0J5TVRvQm9MUlNmamRpT2ZJSFow?=
 =?utf-8?B?ZVFqcU9VT2FWMmYwM2VoQWJ3Mk9WaERyT3ZJcmVJRWdpNHRQV21WM082aVVN?=
 =?utf-8?B?ZTh5VDU3MHFUbUxjalpJK1RKZ1NFQnhlWUhjc3lQVjlZUWVLVDVZV2VHdENj?=
 =?utf-8?B?NDVkSTNrUkZRRGkxVVBMN1VTbHl6NUNQRHhmcG5PYkozMnhrc0kvdFRKUzJv?=
 =?utf-8?B?VXJ4WmJrZVNoVUc1dE05eDNJbVJhNVZQQWNIVG12Rk9sVDZQY2xFVk9VcVlK?=
 =?utf-8?B?aElDSUZXNlZINVZVMzNyUnAwSXZWY3pibHRjUm5IUVQ0VWRiRjRIUFg1MU1v?=
 =?utf-8?B?OTVYZmdYdzNLMjBKaGdUWTJUcFFxVHVEbmdNRVI5bkFvWTRjNEdXd00yOE93?=
 =?utf-8?B?Q3dRUUpPUDNSMzhJR2czTkZ2Nk9weFN6YUMvU3pLWnUvUjJGQ09EM1Q2T1dN?=
 =?utf-8?B?SFpxNURhTFRmVmYwQTlXS1NySlNBKzI3bjNOU0RVbTlSRWlzajNsdlcvL0xF?=
 =?utf-8?B?V1pMZVNkZ3VZTkFidFBaU0lvRXRWSlM4ZDc3Z0tUVllxajJaRE9rSThmYkxT?=
 =?utf-8?B?RnJOL3YvSzVybFhUTVM3ZDlaNG1rTUNXcWU3bFMzUkJjZXZLbWVOWHQ1Um9t?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb1d3e6-b205-4008-059e-08ddf45b41ed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:24:54.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxssKoOkVFGxap/WH6Ca+PglrVF6Moyio6Q3ji5m3uQQGdeSOi758+JL5oDcQ22p2S6Upi7FzXFsDdzQR4N3hgZoZwPueG/HlCNroCTirAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10400
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 13:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18027

Hi Antonin,

On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
> The Autobuilder can also give this information from the run-docs-build
> script. Fallback on "dev" if we can't find the information, so we can
> still build.
> 

How about following the exact same mechanism as on yocto-docs?

Read this info from poky.yaml file which is automatically generated by 
set_versions.py?

Cheers,
Quentin

