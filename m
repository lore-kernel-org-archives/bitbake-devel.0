Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31541CF45A8
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:38:25 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37298.1768235903330975921
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:38:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EkuNEvUU;
 spf=pass (domain: cherry.de, ip: 52.101.84.55, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSQRISXgAEnygK5c0ZcovezWP0axneUuV59fGXN2+SUl7rc8MEgZV1TIP59wyzJWHM1O2ob2nnsBQ7g7KWblJCrgNRi/m+Nzd5UaD66Zwg7ItEHO3Wy0NfHibTWQyEjYLvAI1oUU3XqP9czsTtBGFrvxs1K2kdDGgSb8QdR8Xy/JTgk8LWWMINt048GN1FgS0TMZ/6SQF/bAS61jOqypaR0PH4rkzsYLi1IYv20kA4AtQPKLn4uPehKyLrQKpB/O3con3DBUuURD8YfWTXj3n8VzyhndZlOxQ/AcMyOC/g8jDLxZqPpMdk/g0Z4pmmL0IIZ7KuzWO9nd6WsGrRHvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9ZU4hhBrpWfh7RT1c7YrepcG3YKmpv1cm5PNOfa7s8=;
 b=g7x9mcP8veRZDdhgpvWQgx7mZZ2ysmFzvsxgM95C0wFnQTe715kojVQUsf6HhD2/LQIre5LMg/hTDbgRobT8sumlgAo5CORumVsdNL5+q++VEGUJRMKduMjnMVcboQ+56cfQxDV7MrTsjo6fRJBssavMwDYygsHZRh4eaM6sXLChTZEPf6dNpLsnovwTVt6VqrCzIjdw9JswDZ7EKJNYjYNxqu8NdMept57seoS2dvcndku/VLOxWwvLSMsmZYMIZxCNRMc/j7dFN9FQIr5ImjicBxLInK979qXN1kIliC/pvTJ0IqP6BYttHQX4+nY/d5E8qMmXFi+f9WXa6zZKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9ZU4hhBrpWfh7RT1c7YrepcG3YKmpv1cm5PNOfa7s8=;
 b=EkuNEvUU0XQ05tbYMXyChGtAgSxsG2mlYzD902LSWNDEuCYcm7+bJcefNkrvTZWE76yCdDD/0LzCVTQWvVQOhzxkTxYlR/fhRXd4oHHNdQl/0i9ja6uqCDgDhX9uY3JEcXJCDXpzpHSYEyh01HootRfp4o71wveBDLVTwVmdkIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB7728.eurprd04.prod.outlook.com (2603:10a6:102:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:38:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:38:19 +0000
Message-ID: <eeec9ff6-d7a0-4f0b-a771-2cc02dbd1cc3@cherry.de>
Date: Mon, 12 Jan 2026 17:38:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] doc: extend classes and include/require
 documentation
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250918-classes-order-v1-1-3b8b75e9cf10@bootlin.com>
 <d8437f3b-effb-4aef-973d-0f01edece738@cherry.de>
 <DEPGLUKGZXSZ.1CSSAYH72Y1IB@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DEPGLUKGZXSZ.1CSSAYH72Y1IB@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: ef81a0a2-673d-4b90-9764-08de51f8fe6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y01GNndMWWZyT2hma09CK2V2Z1BlWHd0bGFsbmVGS0h0TXFzdWU1dGpRZExM?=
 =?utf-8?B?YS9Ya3hCY1orZzJaa2FzUFNtcWsxQ2x5N1BMaTlDZHd6Y2laVC9HZno0bUJ5?=
 =?utf-8?B?K0Z1UDN1T1FoNFJLUjB0TTZmQWV2QUVDcm1iYTBaanE2SFNTWVBleTh0dXo3?=
 =?utf-8?B?dTRocWRiVThTVzgzWEJBYW9pU2RrZFFUUUg0VHFBcUQxTU12R3RZei85T3ZV?=
 =?utf-8?B?TmE0QzlFSG9wWnVZNTRTNFRqdzRNMWdXWG9hczREdWszbGVnbGlHb0NVL1gr?=
 =?utf-8?B?N3NSK1J4eUJkalBjTDFNZkNodGU3MVF6UGZFblhXSWJkZFB2Z1dFNVoyR29p?=
 =?utf-8?B?QlhWeFh1cWw4a0dQV25kajlGaWZzR3Y4YzMvL3p1RFZMajFTaEFnTDFrUlZx?=
 =?utf-8?B?b2JjV1pxL2RLTXVaSzF3Vm5FM2hDa2o2TmMxMmtteFdSQnNEZHI2MmM2Q01O?=
 =?utf-8?B?bkRnbHl5R1ZsQ0NkSGZ6UVBZWjBGcVpFa2h6enR1SmhRRXduSjFGenYzVk1k?=
 =?utf-8?B?cjFTWkVhSkVIaUU0N1NMeGlQb0NIZHJtbmhGY3FNUmJSaDlHTUxoS1NJNWZZ?=
 =?utf-8?B?YjFxQjNHd2kxUXB0blRjdkY2U0ZhekFLam5xREs4dEtOU09UREhPdXd3ZUYy?=
 =?utf-8?B?Q0VYK3RRU1E0c2xybEl6NGNobTFBZUdoSWZqbWxxVURxUzhVR1ZDUFNUSGhO?=
 =?utf-8?B?NVo2OE5SbzFKV1dNUWxaK09GT1BtMkNENG0rRVRHSkVweEkwMDZGQ2h2RVYr?=
 =?utf-8?B?QmhPUGNNSVdQZ2tSNnVTdmpQbjFFVW1FNjJvYlhjN0hTakVPNDJFdy9sb083?=
 =?utf-8?B?bzBQV3lDdk9hYWRSMG95Ly9TWnBabFZNS29kWjd5Qk4xOEd4K0M2aUlxZ2NT?=
 =?utf-8?B?QmsrTm9UcWpZYlVicWZsckt5R0N3MkpjQmFWNmRWUFBVMTZQTVNaUXhrWG1S?=
 =?utf-8?B?SjNOYm81UUNZeTJoMTBvNWZ6L0tvQXBLRHNVSlhkMWZUZ1JESzFuc1lqVGM1?=
 =?utf-8?B?UzExdzM3U3lZRmRTVXAyTjdjTjQyZkNLNWViaVVSeXI0M2pHZE15VWFodDlo?=
 =?utf-8?B?eFdqbCtGc3F0UEE2ZnBZRjhIbGZPczJNUTNtdmQrMmp6aHNaYUxSc2FFSkJw?=
 =?utf-8?B?cW4rTEtmZ0ViZ3I4WUhHTUNKT1dzdGUreVkxVkNhMkhxanNldy9FUE9yclpw?=
 =?utf-8?B?OW5wZjVqUjR6ZjlWMGV2MVptU0hSMVJ5TXpwWWtya1JYSGIydy9uOVJEUy9M?=
 =?utf-8?B?U24zL0tTS1NvWFFhWnVvTjZtdFlnWWNUUEdRQmpJYWhoYkFFMUFJNHd5NzI4?=
 =?utf-8?B?ODEwYTgxbDlWZlJ4Q1U3ZUgveWpMaDd5VlhBUHlvcHFSd3hPaXNwYjJCTDNM?=
 =?utf-8?B?K212Tnd1NUFhN0VKUDlyQWsyb1NZQ0dxRUpwK0xGdnhKd2NSK2dTRTZGdklB?=
 =?utf-8?B?N05ETkFsZElSb1hqMnA0UkM5RzFQT21QdDY3c3hmdk1kd1BpT2pKL1V5UXRS?=
 =?utf-8?B?RVluVWFiTzdUQnl5V2xhVyt6d1NDWXo5SmxiTFRaYi9KS3ltcEZrWTF2anVR?=
 =?utf-8?B?TFExTXNZUjZXcXo0VFdyb1V0aml2bXpMVE92RVNQSTFGVSs0cksrZXRsT0ZH?=
 =?utf-8?B?R3pZZnQyQlpPam15YWNzTVZnZEVaR2dXS0hyRzRGVG90b3hnZmtRU2FRMFpL?=
 =?utf-8?B?UVh3eWo5YzhXa213Sjl5Y05HSmRWTFBuZEw0RmNFcTU2YTg1Sm52RnhFVEhS?=
 =?utf-8?B?SUF6N0c4b0pRbWRZRWRnTnhNNjU2b0xFcTRxalE1dDl6ZlVMWWN2Zmp5Vkor?=
 =?utf-8?B?OTVzRFdEdzFrZHdsZWpudU5RVkhRZXc1M1kweUoxSVhGRWQ0TjRWTFJTb0la?=
 =?utf-8?B?RVNkZ0g3clNqdUtvcTUwWXk0WHF0cm1lYkhhQzZqZ0FFdE9uejNtWEVvM1FX?=
 =?utf-8?B?TWJlOFlRWjVQY2hsN28zODZFVU5zVVZmNTgzbnB0UU5UZ0VxTStwMiswbzJW?=
 =?utf-8?B?V0NmZWVqa1BRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?clp2K05SSW8yM05yYVMreThaNm51RGNhY2JPZ0xkdVFJc3pHRHFXZkVVU3dm?=
 =?utf-8?B?SVBFMUpTTE5KaVEzUFBQbUgzWFhNb2JSU3dML2k3SjRyekh1QWNsVk9UOExV?=
 =?utf-8?B?ajkrektHQWhEK2tjNDFRRzJSeHUyWkNST2lsUDFLdGtZY2tGRDA4cEg0Zlk2?=
 =?utf-8?B?Nm1OOVFYTng4R0NlSTNONHdTbEtKSUhBYWJBUGV2MUNxRmN2alA3aHBrNkY0?=
 =?utf-8?B?eVRjNmQyL3Q3cDBnQ0RsMkdQSkFMQnYrclhqOVcwRmJISWRtRHEzbVFCTlp0?=
 =?utf-8?B?L0Vua0tYejViUkRvcUxvaTBuZG1xcGxJUklGQ0NlSWljeHRKUHYrNzFsNXZp?=
 =?utf-8?B?SDBVWDc1MVEyamFaeVBNSSttTHBmSzY3SWFTN1RVRTJHYk92ekY1SEQvcmxX?=
 =?utf-8?B?cTVmWENpeEJZZTJHZ0VDMDBCV2dQTlp6QmpDY2RtbEpqWUZLU1JwVFA5bGFD?=
 =?utf-8?B?NG56a3pKa2REclREZEtJOWtldE1JVk9lWGt0TW5qa203NVlLRVAvaXdmaXVI?=
 =?utf-8?B?MEkzendRSkJ2S2h2RldwTHFrZ1ZOL0VnS29kUm5JeEdMbk15N2ZzVitIbXd1?=
 =?utf-8?B?c09Rc0VDbWNxaEpDbzIvWCtIUEdxei92blVTR3JaL1U5THV6M0FVNXpTUmg3?=
 =?utf-8?B?eERHZjB6QkV2YWlZUmhIRzFPRFJzRUZMUTFrOTU0ck9oVHBRY0FuTkJ3N3Rx?=
 =?utf-8?B?YTVJMmRKc2ErYkV5OVNaS0RQMUtlcDUwNWRHZzUyVTBxS01ocmhESWtvamRI?=
 =?utf-8?B?MlJZNmVSblRLZFdBNEJnbHRsQnNtMXNSR2F6a1AxRlIwWkJRcjdnVjJlb3Jz?=
 =?utf-8?B?YTg3MSt1VldUNmc4WnAvcWZnbGtHL3dhY3U4WHRTL0ZwNzFNRzhaSzNtU1FS?=
 =?utf-8?B?RHhjakhyQ3IydHk5aFpsWkpWL3YrWkNpbU83aE5mT3NleWNsVEVMcDQvbk9O?=
 =?utf-8?B?UEtuMXZNTUNRanNvSThvbG1lRnd2M0NIWlliWVZ6clNnQkg3eG5mMG9qUlFO?=
 =?utf-8?B?YXVhcmJMNFRldXRYSjZvK3NoTGpJS3FwL1ZCVWpMWjh0RkUzc1I3M1NGbnlK?=
 =?utf-8?B?QXNrNlJ4Q0srUGlPd2c2eVZFejNLZjZQQ1B5TzhHamhHbGZqK2NoM1VSM3FM?=
 =?utf-8?B?eDhtZzN0R21uMEpDNHUrTHIyWTJLRnVHekhsejNtLzhwd3A0LzdDbEVCS1FQ?=
 =?utf-8?B?UCs4UFhEbjZPZ2xTTGdrenp0KzI2RWxTSGRFQncxK1FpWnVMUjQ0Zk1lMVlY?=
 =?utf-8?B?VHphY3lTdEk0RTR5cy9PT3BSSDludCt5V3JVRkFXcEFzYVowOVV0b3BFanQw?=
 =?utf-8?B?NVovd2thdHEzTjRCeXFPNGlvcmVwNGZDNSs4a29GcnJRb2JhVXRWZ1BzbUJx?=
 =?utf-8?B?cktwcVNSdVJ4c0hnbXVockhsbHltaGxIOVRtYi9meEJxNGdKY1F4amZ0Vzdo?=
 =?utf-8?B?WVp6NVdMTzZ1TUR2QlU4WTVQRWZBK0RXTnJPQ1phU01VSVlhY3BuTktZckkv?=
 =?utf-8?B?akw0bUoyaDc3bTZPcjFDcENsT1phcysrUERlUEQ1VGdaZUVyQXR0SUE5NStj?=
 =?utf-8?B?NG4yTCtPZDdpa0MxcW1WZlpHNEZsYi9vMlVxZ1JGUmVCWUZhMTVkTGlBczk5?=
 =?utf-8?B?am1MaVFTUzFxSG4vSTBCQ0s2QVpTejc5Q3dZcHdQekpjL3NXYmRGY3pWSVk0?=
 =?utf-8?B?SVFCYkF6VVQxbGFyZnlrUTFWYlN1ZGpveUJ2a3g2d1ZkWW9yNlBTSU82T0xz?=
 =?utf-8?B?K1kyOFd3S24wdFp2dXYyNjhyQ2Q1eS80Y3BOOGtvanF4c2E2akpncUJHL3dI?=
 =?utf-8?B?Q29ObVVCM0Q5TlBUT3NKTVgzUDNsSFFncEZCL2wwd1RoNDE1YkduSWxhU2Zx?=
 =?utf-8?B?YlZ2M1ByM2FkZ0xSUmE1dnBSbDJSTDNhL1pzUExiOE1VUG84MFBrVkk0eHcx?=
 =?utf-8?B?c2Z4Q2hjRWZYYmZOcVQzTTdSN2tlSXF3bVF4dWRGOWJyOTh4NjVMRmNBaC9l?=
 =?utf-8?B?RzRtN08xQ2o1MG5ScFYzT3NqWFdlMkRObFVEK2ltNWE3ZFl2WU5UeStZZEky?=
 =?utf-8?B?TUU1TUswSnpDcko4UmdpMm5BL0lTY1p0NWgwWVVjcURYNWkwQ05YQXFpRmpn?=
 =?utf-8?B?NExXZFZjMDBKVnZ6VEkxNjRWRlA4NUQzbzNEZTM0dVdpQzFjUGZiWW1XWFZH?=
 =?utf-8?B?aGdwU1l0YUFQRzlWVU1oNXBhcndhb1p3OEt2OWtlL3hiV213L0JUL2hCaWt5?=
 =?utf-8?B?Z3p4QkRmRHAxNVJ3R1cyUW1VUG1ub3ROeEc0Z0xuRUFCa09iTk5zL3BDQVF4?=
 =?utf-8?B?ZjlyVkNRbkxENTEyV3VyeHhhWXhkVHA5UXdJWStHdktCOEdmVyt6QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef81a0a2-673d-4b90-9764-08de51f8fe6a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 16:38:19.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRors3CCw/f6Fjsrx8D7nPWwXihgP2RJk8zSsxYcrn73uNyXad0pIwolzu/cIeoWdiTuR7eU7dvdnurbIsf8BH97if8yoYMbyQNcVzTQnWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7728
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 16:38:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18743

Hi Antonin,

On 12/4/25 2:16 PM, Antonin Godard wrote:
> Hi,
> 
> On Wed Dec 3, 2025 at 5:55 PM CET, Quentin Schulz via lists.yoctoproject.org wrote:
> [...]
>> I think we should provide an example for include_all directive as well?
>> After reading the code, I believe include_all does NOT search the local
>> path first, it only searches paths in BBPATH so I think it's worth
>> providing an example and maybe notes on how it differs from the other
>> directives.
>>
>> What do you think?
> 
> That's a good point I forgot here, yes, we should explain it to be complete.
> Can you send a patch of file a bug?
> 

Finally took the time to write a patch, see

https://lore.kernel.org/yocto-docs/20260112-doc-directives-v1-8-b23923cfce89@cherry.de/

Cheers,
Quentin

