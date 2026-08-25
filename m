Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7E9C61DB9
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 16:13:20 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26205.1787674394302843427
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 09:13:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=cvaY5qP/;
 spf=pass (domain: est.tech, ip: 52.101.84.47, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYpNG0kPZSfQPfUg8AOTRb4Xg5FNY2+SAET3xZo8kybrdg1zLotBotq+/izSMHPmEoWlXS6WuUKkSGBSsJ0PO1vQjbW87+f1lXXwt6HssUDhiXaEWOoVFc9V9kZ2jgo47gKQdSUeaAmacHJldVsQUfqz0rShl/x+TojrYxfyNQglZzRNsWCIgM6ssHppkE0qQDaxjp3S8lso+D2M+ee6aNz30IrD2YUaKcD1u9HVUdB+E2+1YQJtgix6q+Z4JujPgfDJZJn+5QbqYB8tAK18Q42Dh7la3qbv8VUe0Kd4mb7OR6Or26abkOFmAmcltaO2TA8dviAvdL8IEOGKF/ulng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsU0/LaZN9mur+7rpxYQILMz21VoZzSQ/PU1E1cMRzk=;
 b=oPUkBXCz6PzMZ8tY/BY0xmvV0tyNZROrRtPTxLrt1/AcnooxLlH0Omm0zpzHI7p47Y3Nwaz6uwvXisRBHKjuvjsoK9zMGfQs6oKAtBdRUk3NYdAtA5WIaho27ZDnXiK5HiqTtXzhKoDcrKq3jqnjnRfs3D6rwNRiUD3Ou9Jo/Adr5yP292AjEI4XAWZUuMWYirNYmTbu0zYHIlJv2eKc+KvWCIFZ5pBzAZ117QNH1MPfuyYUk6pS079ZRnP+2i5ioTNRDkyi9N/oacZkleWupki+IH5rbjNX22m47zEUbohS7uSk/yAPKE7BtijFebBE73KiCPwozLR1FuLu8C+6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsU0/LaZN9mur+7rpxYQILMz21VoZzSQ/PU1E1cMRzk=;
 b=cvaY5qP/PW9jcbmk17zkWRygzUsMCpr/a+MyUaSxK8EIHdpfMhLKm4AE8rJ+8nAKnIPAD3O9KVbl3AY2P8rmDXpBlyspCtw/4759YkOcI+Z0wCDdLCx5J+762g/fWwIuIn8HJBfcfw7h3DQL5rTv8X6B/4XRnWDyoJrydbzwznu/etQN0JvP0fVmbWOPkCedRw5GK5JQ1RcJ9XKn1LlsmQZ+UfL8GYtvc27aTDeCI2R1GIN6NKGydVh9CeI400Mm889nY+DbW5Rmh5WFvvqtHAFoMs7vBLZdYQXON3ZDj6S9HSGdgArLnNl4xc4hR+8uWn2RicsOUOowcmwUGKzwJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by PA1P189MB3391.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 16:13:10 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85%7]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 16:13:10 +0000
Message-ID: <1ae38588-e613-4165-9157-7963796a0eb0@est.tech>
Date: Tue, 25 Aug 2026 18:13:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] parse: warn on trailing whitespace in
 parsed lines
To: bitbake-devel@lists.openembedded.org, mathieu.dubois-briand@bootlin.com
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
 <20260806112435.25128-1-jaipaul.cheernam@est.tech>
 <DKNWRTWPZT8T.1ZLGV8S99L5N9@bootlin.com>
 <DU7PPF66507B2D7DF3AD4504715A950243CF3DB2@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
 <1880129.1787221871218113438@lists.openembedded.org>
 <DKW68O7ETQ3B.PGWHY4WGZ75T@bootlin.com>
Content-Language: en-US
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
In-Reply-To: <DKW68O7ETQ3B.PGWHY4WGZ75T@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::14) To DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::ad4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PPF66507B2D7:EE_|PA1P189MB3391:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae1b467-778b-4305-ebac-08df02c3c196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|23010399003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	naTTg6KVTjsL60DXiiDMat8OgnIJy8Pc9HJOu3U62PvHcqLjB5XGWnB92Gl1gT68JfN1aT4/WoBQCjHmi5a7WqVVYztP/bNRFkOv7kWyGG3M+xm4Fd74GKuWsMSifeMtKEgHYyj2v9sLxuHu7CVOQotXLBE9qxlQYUU7PUHGqUcBZmTiT21fvPH+9VSpVM86bfEZDgSuQtjW7Eltm4bwhDPoSHcMK82xrAxfRoIh6onFgYtH4qCe7XQULdYMs7bUffKhBp+gOWFOUmzD73M9nDjiTSl7+vzBDn9Gi1NquYJOFQMa4Ojj6pgFAK5BRDn+pizXPrgAkjFXsa7nRhiA8AfQd2CQZDJBQivFWily/OfKCC1k16JLvbuqUpY+QwowgNKIzluPFtFPYRfPBqAwMx6t2NSO5w7bPNUazyFCl3b4bVakBl1HkVFmGFdbo5Ph8eN0pAVmvbb3Vi/grfCgF7jwO7itWA5jIEhh0dJAw7HCD1RUOBTeNcUfQe0ostQNvbgqYj03ebG/VEUGSPaMdoi15KnD//+Z3QKQHXCExgelolAnkWWSVReB5qHhP2puiZWdvSBX1tHxdBfNY8KcOF2fwNSuMW364LgiLUSnrhU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUVzdHlwUnpTT1JJa3VOektTQ0lRdW94UnBBaklRQjI5NGxDTTRmSjhrY00z?=
 =?utf-8?B?YVBCSWNkWjE0aEo5RkR4MGd6cGcybjNhNFZ6cmU2RUlHRzlLaVpQM21GQlBn?=
 =?utf-8?B?RzM2aSs0SFF5dEhLSUw1NFNxeVM3N3preWV0R1c4dWp2RmozcmViY0NZWm9y?=
 =?utf-8?B?dktnYUMwSDVPRS9BZHhWdkk4cnJHMjVHdHU1cWxKVDQ5TzQzVFZ6WnlNQTVv?=
 =?utf-8?B?NGx1dzNDNyt6RzBPUVZUWVFvUFMwWkxVV0pRaVFGaXpXZWFjWkU1TVY5L3ht?=
 =?utf-8?B?bElDdmxnRy92ZGI2Vms0SkNwWGlVZVBoRlBWTXR6OU1kUllhN0xEWU45TWJC?=
 =?utf-8?B?M1JMdlFsSkF2MUV2aS9HczZlRlU0ZlJ0RjJlVlFUSUQwekx4MkZKNzdjTHJZ?=
 =?utf-8?B?eUs3RURyMFljdjBVQkQxMjcxb2JNOUdnamRybGVjaW1rYUhLQkNwNUhocTNy?=
 =?utf-8?B?MnB6bGRKaEw3ZHg3TlJnRkdMTTkwbEFGUEUzdGNpT1pEbzBobUZWZHZJazlm?=
 =?utf-8?B?aG1CeGxJUDk1blBNMlpSdkorN3JCVk9Od1VEVDhWbTJsanMvQXVSL1A3bGFE?=
 =?utf-8?B?clUxMTBJM29kR2JKelV4b243c3E1OWJvQXN4aktlVUtkVm1CMEhGeGJDOXZh?=
 =?utf-8?B?b0dBWmFiSGoyeDluWWhKaGFWYnZGQ0NESnBPWk9kbzFiRW5xNTM2RnNxeTB0?=
 =?utf-8?B?NU82eTZFcDBSMlk5R2EvNmcyOEVWOTdYTXJ3MjF6Yk5BNEFGNVhEYXM2d3hn?=
 =?utf-8?B?enBHYkN6ZWsxZWxIVlRwT1pmd01FdGt5bUVNNVR0WGFBbXdOamVKd0M4S2h2?=
 =?utf-8?B?VmFoQlk2YXNPWVhobyt3QUVHdW40YUQ0cVo1SHgxZDhnY2EwZUNtVFRIVVEx?=
 =?utf-8?B?Mlk5SXdMeFV2L1dDajcvQWc4dTd1NGpXK1Q3aUE5SXVObnZQZHlBVVNOVlZh?=
 =?utf-8?B?R0VmOG5aYWhZc1k5eDdRSWFoUDJGWnBnbjZkMmR4aGdiR21lMEFBeThzYlhO?=
 =?utf-8?B?VzhKdkhRNldRc2F0MDZPL3FES2IycVhsT1hNMHhuQUFzby9IVG5xRm5BT0lG?=
 =?utf-8?B?MUVEcGxaem8wSDIwZ0N3Mm5SMjk1UkRzMVFLSjJMbTRRdjdxeEZXU1dTbXJ5?=
 =?utf-8?B?b2EzcVZSS25zcFNnTWhRQytoR244cWVRdjZXaGkwTE9KdHREN1Vud0JRQmZ0?=
 =?utf-8?B?bmcvUHdPLzV5bzMvVzQwUWE5ZmxHMmdNSytRRzJveHo1OVlGUzZsSzVxWWdJ?=
 =?utf-8?B?Y1NZZ3FPWFcwb0p0U2RaMEphV2xTUC9EZ3VXR2EwY2dseFZudGhsY24rVG1D?=
 =?utf-8?B?OGZ0ODRLUmlzK3JWbC9JWTBrQlNkYlRMdVp2cGpRa0VFaWkwaXZvejBKMDl2?=
 =?utf-8?B?YXMzZnJxRmhIcWNaNVFOTm45RCsyQW9OTGVwRGNGYWtIVzNXeDBwZ2pYNDhq?=
 =?utf-8?B?VWluVGJRU29zaThzb3lrM2k1dnNJNTl1cjlKZFoxNEdyNXlCWUpoa1FOQkJO?=
 =?utf-8?B?RklNVUh3Tk8rakljUmRJZXpsVU1GTkx0T05waDBsekhMTUt2MEM4bmpaTTNM?=
 =?utf-8?B?L1JpaGxad1NuWG9ZNVQ3aXlLMkpBZk0valhPUy9VUjc1V2tvRFlicVcvNUxw?=
 =?utf-8?B?WlA2SmNQNlpPeFY4T3lzK0F6VUxsWnJkTGFINEpINXVMYklPQWM5alhJNHlu?=
 =?utf-8?B?RXR3MzBTSFJRc0Evb2hoSCthRElaTHZuWnhSL2ZQZVlheDkrNU83UTdFb1Rz?=
 =?utf-8?B?a3JHYWcyR2F6ZHdoNXYwZGVxdnR4bk5BcENwcDhIcDcxd0w5RzNmMmdRTits?=
 =?utf-8?B?bEt5a0dZZTZHSlFpUlhwSy9rbEF4bzNUejdNcUl2QzdGRTNzQ3VyMWZmK1Rs?=
 =?utf-8?B?K0o2NWVXTi9VbE5ZamhMT29qMlRpS2Q1K1EvS1ZUdHJFU0pEQVNuRjRtZVBi?=
 =?utf-8?B?SjlBelNZRm9UeDVKV0RJSStNMU10SGpaYkYxclN0bmdnbkh3ZGswTkVaZkc5?=
 =?utf-8?B?dm1YM3NuQUtwU0x1RFRCckFmQTJPdm9KbDc0a2QzTmlTT2xsczR6dDdGVDZB?=
 =?utf-8?B?UU9OT0dURmZtWUtsYnFkTE5tL0ZFOWR4QkpoMDZRUlpaTXpFWmxrUlhLbVo1?=
 =?utf-8?B?VTYxSzBYWEpjTFc5YlNSZE5KbjVSRVFIdEZvNkJuZWVzVkc4L3ZGYlpmK2lH?=
 =?utf-8?B?emVUcU1pZFh3bFBiUUI5K3ltemh6RFN0anhEN2xsNFkvSG4vTnU3MGNDVnpk?=
 =?utf-8?B?SmNXcnFFbHhDNW1PVHQ0cVRNalBidXRVRndtTVdVOXlzMW82WnRzK0pSZWdi?=
 =?utf-8?B?UGJQKzdJWjkwMnNqY3h5OFVuZy9jdmhVZUJXR014WW10S1BuSjhZOEpySmZV?=
 =?utf-8?Q?Pd+oJOBm0qAmPeJUy/bTOCMUt791lrNN5S4wbScZh51eo?=
X-MS-Exchange-AntiSpam-MessageData-1: 2y5zYKibnXrK/3HdtU5D1I3Pk2yna16lFTU=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae1b467-778b-4305-ebac-08df02c3c196
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:13:10.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwPbmrPClkPSJsHz3Ms6x3vgRDg69xXkOrK08swmLjLzsyrtpZc5cvPNXtnFxb3MCVwBz2cTaxnKwY3hMNv1TMElBQO2urbfVFNbvVYTlUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3391
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 16:13:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20038


On 2026-08-23 10:14, Mathieu Dubois-Briand via lists.openembedded.org wrote:
> Hi Jaipaul,
>
> I sent a patch to fix the last few things, but we should be good.
>
> I note we have warnings on a few other layers tested on the autobuilder.
> I can ask the maintainers to fix them once the patch is merged, but I'm
> sure they would appreciate a patch to fix these.
Thanks for testing with my patch, I have sent patches to below warnings 
in respective upstreams.
>
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/75/builds/4317/steps/16/logs/warnings
https://lists.yoctoproject.org/g/meta-arm/message/7142
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/89/builds/4284/steps/15/logs/warnings

https://lists.openembedded.org/g/openembedded-devel/message/129471

https://lists.yoctoproject.org/g/meta-virtualization/topic/120921550 --> 
This shows empty to me and dont know the reason ?

are you able to see my patch in mailing list?


> https://autobuilder.yoctoproject.org/valkyrie/#/builders/14/builds/4270/steps/13/logs/warnings

MR: https://github.com/aws4embeddedlinux/meta-aws/pull/16872


Regards,

Jaipaul


