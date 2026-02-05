Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7209EEC1EBE
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 14:01:01 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21290.1770300052583443602
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 06:00:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=A/LOwNlJ;
 spf=pass (domain: cherry.de, ip: 40.107.159.6, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWxWngsAPPvWbJs+xAmIP4WVcGXARJ2z7IQTorvMHR+hGGeEXs+7BsWxowlgavLJeZ3UNnhIgBI66mF95IXZjC/H/odt0m64LdMfrpPl4V4M08Bs/HYRAxPnknOawtczyEQZVPLZQIfi5Ve81TvfbNfmVSVEwR1Y3iBWjn7zA/XStO83a0nUQi1Ye7BIr7Ir4VrkIPA1siOLqsnroDr3Wttyt3pr+SaW/yTz7vWBCD4uYNwWFw/zHBbpPPHx/XX2RVRLjTdtIqE7oBUYDUvSy+5m+beZBpUQcWaGUSgbXQANlfzxaTnCXxszCzMZFduLMnWiYYtoIXH6XtvMOaZ3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f02Sw5xkTXA81JZ1/9dUgdvQ1qZK3RmxHSvaJWCzwNc=;
 b=RekrhFKA/Jlagv8hc5ds7gsKVumv7fcYkAVOF6mOcJRsv1imRgCukmrwS/P/TPMDp3UWGcf5STtCqkV9aSmVa63I5IyibbWD+2wtHwCvXeqAWFhDLT4ngUel2cLe1H04fdnjaWa4xemfD+9WC6ICdGHB4oxKmc/Bwmr+JplSgPg5zufQ/yIr7wAGLYqEc2vOq1aROExPki2BHOGHza5PPCaCn7uanIPDZ5GAndxWq/stePJMw4RCWDnxActbC0n+62Vadpgswz5PwOpGh1IYJ0O6j3nHezTs2EdaGGryPnWhkNnnQiuk5X+hQhOPEhQXpwLFt0dvsCrg5tUz1sVajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f02Sw5xkTXA81JZ1/9dUgdvQ1qZK3RmxHSvaJWCzwNc=;
 b=A/LOwNlJkgl5knMbS3nAMYw92rIFwDu1Q45dRJFElbVcEsNd25+oz/GeSJyDrN0u3hh1zoybX8I5d4lmRC91MdnbbW/Wgj9zvuVBH9AgbaBoXavPtYfkqzaiqxU1dqZYY6bBDAKSYrC1rCmNwFlNXPxNZjXB2cYLmJkCvYvu9Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:00:48 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:00:48 +0000
Message-ID: <2d8f6ca6-591e-4ee8-bfc7-f7f83d10ff38@cherry.de>
Date: Thu, 5 Feb 2026 15:00:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH v2] doc: fix the switchers menu
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
 <f9a1db09-bf8d-4f29-b2a7-567f97ce0532@cherry.de>
 <DG6ZW1HMRGQY.2QNTJC8SOYOCP@bootlin.com>
 <a6c85602-e566-419b-8a76-0dec0085b92b@cherry.de>
 <DG72K1JSFLI9.935906R7H60Z@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DG72K1JSFLI9.935906R7H60Z@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: DU2PR04CA0262.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::27) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d8d04d-ca5b-44fd-f7e1-08de64bef6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aENTa3o5QndPNkltN3E0Ry9uT0hXbHFoR0tydE1ITkl5U3ZLZ3RyMzVzdzIr?=
 =?utf-8?B?SWl5RERBMGh0eTZSbC8zUmkzaTNnaHFhVGR5QkpQd3ZPOU9WREpUbkIyMCtZ?=
 =?utf-8?B?ckY4MVFrdFAvUDN2aXVMbVZ3S0xjMTlVMnJ2WVllQlpteFRDbU1kRTdycVZj?=
 =?utf-8?B?RGtNZHlHc2FPWXpycHRBYVU4NzNnWFVzVlZYdk1mQWRLWE9EajVGQ2NXYndQ?=
 =?utf-8?B?M1dsU251K2dXSDJuSUl0MVJ3TmRpM1d6MjZkejdrZWtOaHFTdjl2Y2V0Wk9M?=
 =?utf-8?B?bVZReTB5UzZMVHpaRUUrL25oSCtCZkxVVXVrbkxKTVc3ZGU2QUZCNWxnWjQ3?=
 =?utf-8?B?TG92dzUyci91cnJGUzJXTDRsbUtmQXBhQ0NVVW5XaU0ybXVIa2h2cXFTVzJ1?=
 =?utf-8?B?anR6OUpMeDlnNmdVaHNwaVVlUVhJRkJId3VaL0tDT1pPZTZqczlta01uT1dC?=
 =?utf-8?B?YWppeEdwcWM1VWM1OVZyWXpFWG5HQngxVTBOb1VxaU5BdGRub0xLLzJEbml4?=
 =?utf-8?B?T2trZnV3N2l2MUdOODVlR1VNT2NNRXlySjJmdWlQOW5VV25jeGIwa2VObUt2?=
 =?utf-8?B?a0VRa3pCbnkyRVB4bTV2Q1RXSlJ2UG9jcVlqWlB3d3hpZSs0cVdvSDZnQ2VX?=
 =?utf-8?B?V2RBMlI1UmpDS2xJanhQWTNqeVgzVUZxNWVhR1R0Mk5aZUZsSmhaUWd2c2FH?=
 =?utf-8?B?Y0xJWlhmUC96UnprOG1IaXU3enVWNnZiWFJCODYyZi8zbFhZYlFHMzg4QUdO?=
 =?utf-8?B?UXRIWUJuaTIwanJMZXVoeFBESWQ5aGhsVUd0bmJ4QlppZjdJZVY4dldhZCtw?=
 =?utf-8?B?aXRPUTNNUldKa0Jra0ZLbTRrNk1la2hKd1o4cUlZcHlYNXVIOUg2VmdDMXFz?=
 =?utf-8?B?c1B1V2lqcmwzams0YWlMUW10UDQwMVV2QzViRGN4WWM4MFIzTHA1NUFuV05k?=
 =?utf-8?B?SFJ4eS9OZUZLVnZLL1dzb1dSUnA0RW9wZ1NIZDJQR0ZrRHpzeG5qTEJWeHVv?=
 =?utf-8?B?MmpoSzR6V3p3TjhoZk5jTVpEMk1URno1azEvZkRVKzVueUVUVCtjdUtmS3R4?=
 =?utf-8?B?VU9sR1MzaGlKZnZSdTlJNEtrekE0a3JFdjcwYkxJUVE5UVp1VGFmMk9VSzFX?=
 =?utf-8?B?RmZsemFodTROUXlxdnJOK2pIeFpxeWNQK2VqR1RiZGZldTl6elNqQmpFV3Vt?=
 =?utf-8?B?bUYyWkp2cUg2eUVXNW5vbXl2OHcvaTlPL29PSitZeGhPMElmM0NIRkxINGxL?=
 =?utf-8?B?QXp5WEFBN1l0SWVaSktJQUhlL3YvMnlMcUprbDVvTnFQck5BOGw4aEY1SFpa?=
 =?utf-8?B?WjRsRVFvVk1vSjdVWXB4RHBGbmxVOEYzcWdxTmRPd05vUGNBb2E2K3hHQS93?=
 =?utf-8?B?TG1qK0ErMis3TkRKQnVCNHRITDJ2b0xMS1F1cnFSL2xUQ3VNWlVreFgrODVI?=
 =?utf-8?B?TTJaZGhmeTdSWTVTNnZUd0w5ZEdLeXZNaWFURUVJYmJVbUxKRE1PdnNNNkJU?=
 =?utf-8?B?bm5HMXlPMHBmMUkyQ2psNk52Ykg2TWQwSzVjcVRxb2JqWVV2ZkdIZFc1UnRI?=
 =?utf-8?B?czBHMW5qWHlucEplREZGVVltdlZGVUNyR1JtcnV3U0txWlNLbVVNMXV2YkJT?=
 =?utf-8?B?WHc3dStpdmVtUHE1Q1NzRVArMDgyWktKTkhVNDN1andEMm5DeW1zZG5Nampz?=
 =?utf-8?B?Tm42bFVXWlFBeGVwdjdDK2xwUkNUTEJ6WlpPNlk2RFJVdzdJazExclg1d0lp?=
 =?utf-8?B?dzU3Ui91NkZEUFJZUlh0YndZK0lETVRIanNsUy9kVFh5SWxCSHJuYVRJQUcz?=
 =?utf-8?B?RXQxN2lMbThDUmdpWGNOb3dJbTdOb0FTYTVZajVRNjYwcERkTVkxSG1KT0gx?=
 =?utf-8?B?dDg4S2FSaitvekNSQW9ucWl4MnVERGh0TDVDT2hhbHdtcEVlTlBmR3FXK1Vq?=
 =?utf-8?B?QWU1dTFETG95UVNPUEZGVDhjWkI5N3k3emxYNUZLZUgza2NzMVpVUFlteHNn?=
 =?utf-8?B?YjZVME1GRXhPekpWU0xZTVdrN01La0d0V1BSVkFGYUlIelMwU3Z4NE9oSEtN?=
 =?utf-8?Q?/qjAXb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGVjOVE2NHZVRmJ0aVE4aXh1WFdORXYxZ2NhK1pXUHRmQUtWbHlJRXMySE1F?=
 =?utf-8?B?OGV3ekZ2QlI5T05wUEl1dmZFK1pyMG9WOTNORmlKc3V4bENCRVFpazQrTlJX?=
 =?utf-8?B?aGpqRUYrQUJCNUc5QSs1d2NJZGllbTEzeHZ1TE5Ud1ptRVA1NURWc1g3NzRI?=
 =?utf-8?B?YUpONHhZTUxwYmZKb1FLcE5wMnUwenFMcjBOSFR2VFltZmptb056SUpiRlQr?=
 =?utf-8?B?a054MkZsS1c2M0o1N3VSNyszemo4alFmUVlZNERPNitVUUxlLzhNQk5vNHJB?=
 =?utf-8?B?bmlRM0wwK2VlQnNXU2NEWFdTaDZMNnNoeUlKdzFNMm5xSFQ0Rm4ybUR2bUEz?=
 =?utf-8?B?RWt3SHBFM0JhNWFCNC9RbGUrVFY3cTBYRzNLcjJhS1A1ZExDbXFFczhhMHgx?=
 =?utf-8?B?dTlHRGQ4QWdxODZKdVNDQjlTZGhwcFZXOW1ETUNzSWNoNXgzNW9hKzZvWGtr?=
 =?utf-8?B?VUxyMVBnTklWVU0zU3QyY3VBY1JNcUliM00zSU1WdEVNMTQ2RHFiamdvZTBp?=
 =?utf-8?B?UzFxN01BUWlJa092SlJLVURxdGdjK3JPOG14c3packh4N3JoZXlBajJnYnZs?=
 =?utf-8?B?bFhTZng0VnVaN3U3Q1F6b1BvNWFtWnNCRDNIZDFUZExFekJxL2dXK1VJRy9F?=
 =?utf-8?B?Y1hPblFJNE5WdkFtb1lIU2ZDSDZJNE53L0x5MW5YMFc5WEpBUkdERkpNeHEv?=
 =?utf-8?B?cWxremZQMzZPY3FSVytENTBqbEtaV041THMzU0d4MG9JNGkzcXQ2TXptcVlp?=
 =?utf-8?B?QitFdGxId01MQzh1WjlJZTZzb0N0aEJvT2puQUlJR0RoSXI1bHg1bFNTVEJl?=
 =?utf-8?B?VVhVWnBQY0hvczhyblhQTVpmZWlRR1lIeXd5STFZc05ZbGFLQ09vMTd4MTJs?=
 =?utf-8?B?anV6ZVVRaEtOVC9nU0RxUkNMRklGTTVnQU5OMnNDYXZuRGI3YzhnaEw2S3pG?=
 =?utf-8?B?dHJSYWovSWZhUmxzMEdhM1Bhd1FRM3l4and2aHZqbnZ0ZlZGR0hYaDZaVmFv?=
 =?utf-8?B?bmRtUHcxQkU4QUV3cklva3N4WDhnOEhwTDBKRy9UaHBuaVJFbDVsdWloQ1ZC?=
 =?utf-8?B?OW5Ob1Q2R011Ukh2SEFpSGpIL2ZVUXZoYUEwUXhGWWhsdkJjSHB6dXZxU3RU?=
 =?utf-8?B?cnMxZ0VBYnBydUwxays0WEFmd0RLZDByRnJMWmVza1dNQjFLSERIb0dCcGZ0?=
 =?utf-8?B?anR2UjVzKzAxZXh1S3JiZ0cwR2FiQmlnbjY3R0FvYXFwZ2d6NDFwTDZDMnpO?=
 =?utf-8?B?NE55Q1l5QTRmQTNVT0JRRDVyUjI3RlZOblovY0YzN0FNZmdGV1U1L1dxbEtQ?=
 =?utf-8?B?ZVV6R0gyYlI4NXZnTmo1WFhKTEo4TzFNa0NQRnVuUlRuMUFBV2Vqa1UrYzFX?=
 =?utf-8?B?OWlDeFQwQVlocFJQRStubUxVZyswbGl2WGg0ZjZXY21PYWt2b1U3UVZOdk1V?=
 =?utf-8?B?akY3Tjk1ZWxVeDFPbGJGQkt2SUdnZ1RYZEhrWFJDNXM2QVd1Yytoc3VXVGJ5?=
 =?utf-8?B?NjdKZmxJTDB5VEU4OWJpQjd5UTRsN1NhUWFKUWFQVmovdFlwb0lybEZoL3Vl?=
 =?utf-8?B?SUFLa3kyVlJBY3VlMEpTTVVsaGtHUWttU2dRREwyck56ek9FVHR5Q3ZSekZK?=
 =?utf-8?B?VC85NzNSV2FXNDFJVHl6TGVZQnlHMVVzQVh1dGhYSVZBQzRieUM1U3I2MkZG?=
 =?utf-8?B?RXJkOGRKU2NhMklaTlVWSC9GTjF6dFE3SlFmSTVIbk9OWCsrRHJ5N01Na2tr?=
 =?utf-8?B?ZldwWXdPV3dsc1lwSGIvSDgyK05Xem5pREMzYlZJYXJwQkZpWDNvdUhWQUp1?=
 =?utf-8?B?N21TT0RCVkFQK3ZqVDJQc1BteURrNnVyV1MvaGt3SkY2cDFBNVFHZDl6bERB?=
 =?utf-8?B?MjM0R3l0T0RFT0Rrcy9wRjBnbURUYlBPTDNRbUtQVEhONy9FY0hOY3ZOd2l2?=
 =?utf-8?B?QmlvRU9sSVJkZWNJUXNWNnRWQ09WSG9kSmNuQStxeWNQUmxqMHRzMnhhT1Av?=
 =?utf-8?B?ZnJsSisyS2RUc2ZpY1ZJV0c3ZUxjc0xHUmhkZ2ZZbFN4WlZqeGhPU3BBMEoy?=
 =?utf-8?B?WkxkdzBORmpvZkpCNjNSckZoN2VJbHk3aTBMa2xhWk9DV2lZUzEzUG5FdlVG?=
 =?utf-8?B?OER5Y1J2TTExTnJEeXkzZHdtc0lIZHF5bWlPcmJPWnljY094L2dHK3ZBQjVY?=
 =?utf-8?B?Y0lCdEExQXZmdjdiY2NPU2NyRUdwSmMvcXRGWXZ0UjhoVVNlMnNGQVdSVHRW?=
 =?utf-8?B?dk9ab1VYa2JHL2NhWC9PelE3WW81b2trSlhXTG9nUVNmNFdaOExoRU4xQ0xv?=
 =?utf-8?B?Z3dYbjUySFkraUpBSml6WktxTFdjY0hXL0RSYi9hNTNyN005Y1JKQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d8d04d-ca5b-44fd-f7e1-08de64bef6d2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:00:48.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i6gI8+elutJjthMNe7ROnCdn/lu+iiixb8P6Fm1KHufGraVnVDzJ3o2ph5FxaEyemYVGG3bDDNHxK0Mg7JJiBT3GvqHVhUqoTINy891V28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 14:01:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18969

Hi Antonin,

On 2/5/26 2:40 PM, Antonin Godard wrote:
> Hi,
> 
> On Thu Feb 5, 2026 at 2:08 PM CET, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Antonin,
>>
>> On 2/5/26 12:34 PM, Antonin Godard wrote:
>>> Hi,
>>>
>>> On Wed Feb 4, 2026 at 4:01 PM CET, Quentin Schulz via lists.yoctoproject.org wrote:
>>> [...]
>>>>> +with open("sphinx-static/switchers.js.in", "r") as r, \
>>>>> +     open("sphinx-static/switchers.js", "w") as w:
>>>>> +    lines = r.readlines()
>>>>> +    for line in lines:
>>>>> +        if "VERSIONS_PLACEHOLDER" in line:
>>>>> +            if ourversion != "dev":
>>>>> +                w.write(f"    'dev': 'Unstable (dev)',\n")
>>>>> +            for series in activereleases:
>>>>> +                w.write(f"    '{series}': '{series} ({yocto_mapping[series]})',\n")
>>>>
>>>> Why is this different from yp-docs? We don't handle showing the current
>>>> series (ourseries)/version (ourversion) if it's outdated anymore?
>>>
>>> We do, but from switchers.js, where in build_version_select we push the current
>>> version of the document last:
>>>
>>>       buf.push(
>>>         '<option value="' +
>>>           current_version +
>>>           '" selected="selected">' +
>>>           current_title +
>>>           "</option>",
>>>       );
>>>
>>> So the version from our branch gets displayed.
>>>
>>> (trust me, I've had a hard time locating and understanding how all of this
>>> worked :))
>>>
>>
>> Yeah set_versions.py and the switchers aren't the nicest things to dig
>> into :/
>>
>> Is the above mechanism something we could migrate yp-docs switcher to to
>> simplify it a bit?
> 
> Yes, I think I'd like to port these simplifications to yocto-docs soon after,
> while memory is still fresh
> 
>>> However, you made me realize that due to our branch the abbrev hash, it would
>>> always appear as outdated. I fixed that for v2.
>>>
>>>> To answer Richard on the other thread, we use YAML because JSON doesn't
>>>> allow comments. Also, because we used to want multiline variables (see
>>>> https://yaml-multiline.info/) which aren't supported in JSON, but those
>>>> are gone since 8d993022c2ae ("docs: use literalinclude for system
>>>> requirements"). Not sure we can get rid of it for yp-docs as we only
>>>> override *some* variables in this file by set_versions.py so the
>>>> autobuilder won't replace poky.yaml.in, and the YAML is consumed by
>>>> sphinx/yocto-vars.py.
>>>>
>>>> If we don't plan on having comments in this file *ever*, then the YAML
>>>> dependency isn't necessary.
>>>>
>>>> Another option is INI and use configparser, c.f.
>>>> https://docs.python.org/3/library/configparser.html
>>>>
>>>> It seems that INI supports the ':' as key-value delimiter as well as
>>>> multiline strings (but not the way we used it for YAML!), so it could be
>>>> a drop-in replacement. We could even simply write to the file with
>>>> configparser.write() (though that will drop the in-file comments).
>>>
>>> If we directly write the ini file with configparser.write(), maybe we can just
>>> maintain the list of variable as Python instead, instead of a separate ".in"
>>> file?
>>>
>>
>> The benefit of having a .in file is that it's explicit what the user can
>> use in the docs (if we have yocto-vars.py! which we don't (yet?) in
>> BitBake).
>>
>> What's the usecase for DOCCONF_VERSION BTW? We only use it for setting
>> the current version (always "dev") but we never override it? Either in
>> release branches, in the autobuilder, only from set_versions.py do we
>> read it and override it. But then it's nowhere to be found in the docs
>> either so we don't use. Do we actually need this for BitBake?
> 
> We use it in doc/conf.py:
> 
> current_version = 'dev'
> 
> with open("bitbake.yaml") as data:
>      buff = data.read()
>      subst_vars = yaml.safe_load(buff)
>      current_version = subst_vars["DOCCONF_VERSION"]
> 
> So basically we just need a way to pass this information from set_versions.py to
> the sphinx-build command.
> 

DOCCONF_VERSION is always "dev". current_version defaults to "dev" too. 
So what is this *actually* used for?

>> We could push this even further if we wanted to and have a bitbake.py
>> instead? In some internal Sphinx project, we provide a skeleton with
>> options to provide (Python) variables through another file we then include:
>>
>> exec(open('variables.py').read())
>>
>> is what we use. This would support f-strings (can easily reference a
>> variable from another one), multiline strings, etc. No need to parse
>> anything, it just needs to be valid Python variable assignment.
> 
> So basically, you'd write a variables.py file from set_versions.py and read it
> from conf.py?
> 
> I'm starting to wonder if it just wouldn't be better do move all of this logic
> into doc/conf.py, actually.
> 

Is DOCCONF_VERSION supposed to be used from the docs? Is DOCCONF_VERSION 
supposed to be set externally such that it makes it to conf.py which 
does something with it? If no is the answer to both, then there's no 
reason for this mechanism to exist in the first place.

Cheers,
Quentin

