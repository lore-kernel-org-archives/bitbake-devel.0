Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2623EB490E
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 11:39:13 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43497.1770896346376598174
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Feb 2026 03:39:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=X0AcaiNf;
 spf=pass (domain: cherry.de, ip: 52.101.65.21, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM29cJUL2m0uNb66H/dsd2xeV5JHnPQ6TJUoNXgr5vSGLUfSNlU7DSZXUW0Ep/c4YzaF8uM5B70RWulYZ5V1uKhJN+GlyCqj1rV1bzDgCutfIN6kOj7Dnx8uIgwbHPW18kAF/OlZuLCxp2DLExoRUc5H3GzQnotQWWV0zDxJYIH3gWDa+hs5gQZUAVTtEdGW4+jsY+nnXMPAhS7u4K9N1eQSXUFZBwJOdoB9H6pna4xRaKUU2Q9e82/An37uB9dv9VW6XBgAfMWGHlZhOjt0PZ+F2jVQfI14Ghmyobs+Hs41+K5FtgSN9w41319ir4HjNZ6JeqEuTT70g1DKuBLzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/vI6r42rB+s7rU0h8d1DSUQujgcIqlGShjfDyEh1HQ=;
 b=xxcB4qO/u2gtf2bK07zocsSjM5ypoDBdS5Ze1THFxHubYQutTzgBcIOUdC8D95wZycQfv22NpK50qZhVH+0T21yAVGZW3cmVnFfZ3QpRxghCgn4bu5bOx68T9KKOWLGRLjPtuoJFZPSKywebwJVDjyRSJvTUt1UlyEcmTH/3mFBjHRX708AhMqlxN2+eJ7hhK0zedqBiD8252PK9EA5IXh1yAluuukrrkXZHHeQsRFEwjhxn1rJLBfsFFgB2K+m8Vf9b8na0ABdTOczMBBKZWMQk2Uj+8oYzzD3be1FBe8Ck9k7Llau17eh5wcNZnijRARskOii6K5Tz4hg2cfo0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/vI6r42rB+s7rU0h8d1DSUQujgcIqlGShjfDyEh1HQ=;
 b=X0AcaiNfUVhCcpQFjY3Yoe2c98F5TX2w+TuYj9CSfnnDdJDfAc6ICySg+DOTThIkOHrp38BiQYQDWjd6jW01VyPzfIlAET/ME8cdqcvDnF4RBBhJdsjhWH7nNpX8LAli107YRVZqeIjfdPmzxoRe71+ctXE8SdH6cXmfVTtiPQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 11:39:00 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 11:39:00 +0000
Message-ID: <f97528ec-917d-44d8-be42-ab0c48a1b2cc@cherry.de>
Date: Thu, 12 Feb 2026 12:38:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH 3/4] doc: bitbake-user-manual-ref-variables:
 clarify BBMASK matching patterns
To: Antonin Godard <antonin.godard@bootlin.com>, foss@0leil.net,
 bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
 <20260211-bbmask-slashes-v1-3-b72161c647ef@cherry.de>
 <DGCUY7U4ZJZE.1Y4VMQEELJUO@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DGCUY7U4ZJZE.1Y4VMQEELJUO@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU0PR04MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbf3fd8-4fad-40df-180e-08de6a2b5082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S013STRqRWFoR0RPdlNOdU1TRW5qeTh3VHpmNktNQ3ZLUHhnTHRKTUhPaGNC?=
 =?utf-8?B?NU5Lb1JnTVFQRmkvOUpqbUp4UFhCVFJENk8rRGh0WUJ2OXlUUDkyMElKSEdU?=
 =?utf-8?B?QlpJbWEyMDdMUG9QbHVPaC9KZjFBSnE2VW9vMUFYWTUxT3JFeWRvdzNzemI4?=
 =?utf-8?B?c0w5dHdHdXQ1U0l1SElNUGR2YzlORi82T3JPOC9jMkh6a29KbDVCbEpmeDZU?=
 =?utf-8?B?eUUrSjZ4Wmx0L294cXpzQTgzNHhLcno1ajZGNXAxaWNpRTFlUVdVU0l5MVJ5?=
 =?utf-8?B?bndBS0hoaVh5WmlBU1M5UnJFdDQvcTlxdzZ2bzVNVmxsa3pSTU14VnNHYVY4?=
 =?utf-8?B?ZjdTTjlzYlpuNGtqVkozS1l6eVVUWFN0UFpjZVYvdjFyeFJNbUVielBDV2pW?=
 =?utf-8?B?ODg3UERBQjVWSEZ5SFJRWnV6dnhtajVxUTh0cGoySys3Rmg5akpLeURvYXRR?=
 =?utf-8?B?S0kxS1hXelZEaGhjd0JycEhSYXdUQlFDOW14MThOL1BmbGVwYUV5UU9LRGhU?=
 =?utf-8?B?eVJKTElWYmFyVkdxeHFHTVRMTnBlQ1hmdmNnZTZSUkhEL21nMHpoaE5BVnAw?=
 =?utf-8?B?QXh3eVMwaXB3WDF6ZEo5bEdud0lpL0pNRndMMEthODlMUWs2Rk0xSzdRU3Vy?=
 =?utf-8?B?MDVRMlNadE95SnBtWmk5YUlSdFZZMGFNVzV2RGxLb255S3Yyd2FISnVhNFo0?=
 =?utf-8?B?ajNrRys0WUNrLzdTcXlDNE44QmwyZ0hocVJWbTdBWEVwMnFSVnNvQVUrbGhp?=
 =?utf-8?B?QXM4eldralNxMjI0cC9nUDJBV0FkRUh6aFhEajFyODd6aWYweGFjeDRTNm1E?=
 =?utf-8?B?R2phVjhZaElISjBHV2g5Wnl4NU43d0Z6em5PUGY5ZTd6Y0NjWThRQi9jSDYw?=
 =?utf-8?B?SmhvTnJkb1h2QVl3YVp4QWtNYlF2Q2FmV1FBK0l3Mk1PR0VzZktPWlNJaWVU?=
 =?utf-8?B?d05LR3dnY3NMSmpRcUhyekRaMVd1bkpoQXRZMGxyM1RsVE5aaEl0azhQZGUw?=
 =?utf-8?B?cXlYUGJoaEVFZk5iVG1PUi9EbENjL0xWRWdDOEJ3ZU1sRTRMdVdiRzhwR3Mx?=
 =?utf-8?B?czVzNkVjdXFXSTdxa0RxaU92bzB4b1VzSEQyclcrVWw2NDdmR01uTlBYQXh0?=
 =?utf-8?B?VDJMWHZTWkE3S01jQldibnlWS2FmWFBjYzhvdHZBdlZjcnFKdFdEM1NKKzVj?=
 =?utf-8?B?b0xSS0UzbjUwQU9tRStnWFd0RkRhQTlKVjNYYklrSGxsckkwVkVrc3JTc1JO?=
 =?utf-8?B?ZGtkNlRndjNhbHJZcDdNUU5YRDdjamVEbUw4YWtINHo4Sm5MNXFSY1JGdUI3?=
 =?utf-8?B?OFRqd2Y3c1RRV241MEVyalR4Z2N3VURNYVpBemlISlBtUGNEYjFscnprdGd4?=
 =?utf-8?B?VVdjbWFnZmdlVE1hWWhjNVN0aDRHRXNxM0dkcW95ZGpBVVNpZ3pVcVRCbHVz?=
 =?utf-8?B?d1N0SFVBSkhzTjYzU1BvOVVLZVE2ekswQmVRMXU0OFFpOWdnTlcycUoxbDFs?=
 =?utf-8?B?RUtWUG1WSWNZSFN1dlBsby9OVnNCRzE2ajcrUEI3U3owbDk4b1QvOVg1YmdZ?=
 =?utf-8?B?VXErT2hoV08xVy9lOTlIL1ZQQjJqcHNSOUFFemxHMldIczhESkpDcW9iTGlI?=
 =?utf-8?B?VmdXQ2oxRGNvNldSQ3VSbmxZVWNDV2NHK2NtT2lrZEd5Y3UvWWE5d2JGNnIy?=
 =?utf-8?B?Vko4cnczbmxUYmw0RkMwQ0NQTnRwMWtoaTZoUmIyMXJtMWEvOG5IWDJFdmlw?=
 =?utf-8?B?MTFDRmhmTzhDSnRpUlhLR1htU21BMVp0NnVwL05HV0Yycm0vcGpNc1FZbm5x?=
 =?utf-8?B?QUtvZDhkeUVUYW5MdkRVaUdaR1pSdTVHV2YxZ0tzZzFGbk0yMjNiTm5RN0I1?=
 =?utf-8?B?TUJBb2g5ZUlFMzZwTU1vaDNoeEJ0Q3RDa29VUllTYi9tK3hsbTYvUEwxUmc4?=
 =?utf-8?B?SzZONVBFR3p4NGxRNUdVeVlYRmJQK29vT1FHTFJ3blhtTkl5VzdyaUNSNVBx?=
 =?utf-8?B?NmEyTkxmek1yYkd0VUwzeEx3RGtxUUtWbGI2Y2pxUXNES0ppRlAxUjd5eS92?=
 =?utf-8?B?YTdJSC9PT09xbmRRdFlGVlhqbnlhemZGaFhkZkxKSTUxSlJ4dXI1NXEzZmlG?=
 =?utf-8?Q?+mFc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnBjaytQRTJWZi9mcDBVN2dtdFBpRnNVZldQekU3ZjBUajVxeFhJUzdoRzVw?=
 =?utf-8?B?QXBKMzhXQkwzOEt2dXNOaUFlYnNSL2Z2dnpaQjYwTlFXTERQSkdJU0FrN3kx?=
 =?utf-8?B?M2R2cFVSODdreTVJMXZzK25xaHJHVlJpb1g3eW80YllkZ3ljOHVjVkFuejNX?=
 =?utf-8?B?NGYwN2R2c1NKN2FGN3VOQTByU1kzZzhnckJNemNXQmU4SDFzdlEwZDZVV2xW?=
 =?utf-8?B?TFd6OUNWYmFtVEZaNUFvc3VldmtWbUFsWDBXWHdBeUhkSVQvRkRLSDFndlBN?=
 =?utf-8?B?MW1wNEtIT3ZZTnIraXlwSDU0NlJicTROb3FtcDlkTXJYMzJHRk5nZnJQRlg5?=
 =?utf-8?B?RHBqSzdrb3YvU2NaRHQ1WUcyOXl6amhHOS9PMnNBdVM0OENnU3NQZnpWM1ZC?=
 =?utf-8?B?SXFjT2RpdEtTVG1CZG1qbC9Ya2pGZGxPWlZ2ZDdsVWI0S0J0eXcrNmNNdEIy?=
 =?utf-8?B?STN3MUNYSXBXalNVL2J3a3M2OUNpMmt3VVVpSkZsTzZGSGs1OEpSeVZxS0VN?=
 =?utf-8?B?MGpnVHlNQVNpUm5uSUhCelVaM28xaDVVQTZUR3BTUEc0MllQTmkrYldWWXFS?=
 =?utf-8?B?TDJ4TTUwTFBQSityVnZrYUVVVDNzR0h1K096WmdnR2JNT1ZXejRzNmV3V05S?=
 =?utf-8?B?SDdKQkJDZHNYb2VTWFpSUGsvdEVud3lBRVg0V1dPUlo0VjRLQ1dXQWd2V3JL?=
 =?utf-8?B?S1MyREFWenBlNStENWpKQWxiYXZOcVM1cEc3V0pidU5pM2Q4TjB5eVVjTVh2?=
 =?utf-8?B?WUZBM0VLVlhWQmxNL0x4dHk2MHpxSFZGSjBCa2tHaW5ZTmE4YlpZNEpFOVhY?=
 =?utf-8?B?bmJKOWpaTFVFeU96c0pwV1IyUm9ka0YvRW1uWUpObkhRSnMvbDJFNEM1Y3dt?=
 =?utf-8?B?NmpSUHVjQW5zQjc4Q2lwYzlteG1CandyTkhxeVZoamp0L0paKzdwNHJrbWNF?=
 =?utf-8?B?R0pPSTBLQ0VzV29KZjVhN21ZQ0tDUXNhaHYxTnhwZE82aUhGQWFWV21yUEJs?=
 =?utf-8?B?VGtWRjhWMy9TYkRuVUVEZVhqa0pxM1lnYVJJNEhrU2VwMURrRVMwcEU1SHBS?=
 =?utf-8?B?R3E3aGMyZDBaSFVMTWhiRzZDOTRLZDRPWVRramliUDVpdWpWcTJHbWpmRXNJ?=
 =?utf-8?B?dHVpL0R2Y2Y5a1VKbDk0ZGVUR3RBK2l2anZlaWpvQkR3ejI5NVBXUE9KSmh2?=
 =?utf-8?B?V3FmTlFIdXNKWGh2UThDdjBldUpBM3l3cnhPWWg5VTk1TVQ4SDNPQkp2SEp1?=
 =?utf-8?B?bGlFZXlVVEJTT0hHbldWeExFdXgrbVhBb3ZlQ216R0QvRCs3eDg5SjY0U2dE?=
 =?utf-8?B?MnJ0NnBWSlBQTmJNUHdCMHBEdTBqNXFCZTM5WGRkUmlWRjh1SldHRldjMUdv?=
 =?utf-8?B?NHJIa0hYTCtubUhpVGFFYm1CQUh0V1BJM1RUWkdKbnl4MnE4TFBHQ3FJZzh4?=
 =?utf-8?B?NUdjMEpLUm5abWdQRjBpOWxBSHlOWjB2aDhzTGxJcms3UStXa3lvTzNCdTVF?=
 =?utf-8?B?cmhtSVFLSDV2SVErZ0d5YkE3WFZ4KzNodUltc3h6dXVCcUxJV3BMRzViWllB?=
 =?utf-8?B?RlNZUzdmTmxzTzNxczdmL2dRSXdlVFdqdWVBOXB3YjZZN2lLSVg4eXpHTFkr?=
 =?utf-8?B?SDBra1c4bFFtbVJ1RXMzMVBzWkxVMzBjK1h2OW1rYzUwb1hrd1B2NXFIYmU5?=
 =?utf-8?B?QlZxcTZqWE93NWE4cWRoK3R6MzRVaUNpK04rS1prV1lSVm9STDFPdkI4QjYv?=
 =?utf-8?B?UFhrVGtybGE4eEw1U2pvMVlzYnl2MFJYWS9KZjgvTTBwV1NGaWVvUjlMRFEy?=
 =?utf-8?B?eEdDVnNoOG8xcWFxQVpUZ0djQ0xKK3h2djdReUtzMktyaytnR1FOQ3BtVU9D?=
 =?utf-8?B?aGhXejBOTFNVOXlUbklYR2JXVkwrajNvbXNMaFNxSXJya1p1SFZyeVc0Q3R0?=
 =?utf-8?B?OWVpcE9jcWEwbEt1dWJKSitZbzlMalRhUm9YWXFrN0QzUzFRemNhZU9yVnc4?=
 =?utf-8?B?a1dFTVVwdlk3SFdWTXFvVm5YMTVZTlV6SFo4SnJHd20xcnZZcHgzU3pQQ2F1?=
 =?utf-8?B?NjNIdUtsRTgzQm1Dem56TnRkRGVqT3JtbFRRaWRUVkR2MUZMYW5BY2dPOGFW?=
 =?utf-8?B?QTNLSFlXQ1p6UXRLNytXWFdoNjF4dTV1ZG4wbk5EWXJMS3pLeEp5V3dnMVRU?=
 =?utf-8?B?aDljMWt0WVNZaWpBL0EwZW5FWmNBMkw2MGpsVWhCdFUzb1lQdSt1bWQ4THV3?=
 =?utf-8?B?TEVLNFZzQ0NvWmkrM1h3bENLcXhmbXZZMEFwYjVxamZkc3B2V0R2TDVtUGZy?=
 =?utf-8?B?NFBqaWlaaEtiL0hWSTl0eUtjQ1FtbVZNeUo5YmUxQVJKN21HT05tODZYK3BF?=
 =?utf-8?Q?sozbla5gPEMYhXx94inu6O73ftf8+8HdGeU1I?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbf3fd8-4fad-40df-180e-08de6a2b5082
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 11:39:00.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/wZ0IR2520q0y6wMjTvlZoMqWK1wJi57IcmAc9/MN8LDR9sLcUHm8PGl5GSikeKSSRX8z2M1D+lNkwolXOXkULGZBf2W0FVkjOhpHu3giY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 11:39:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19018

Hi Antonin,

On 2/12/26 9:58 AM, Antonin Godard wrote:
> Hi,
> 
> On Wed Feb 11, 2026 at 7:06 PM CET, Quentin Schulz via lists.yoctoproject.org wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The documentation doesn't explain the side-effect of putting a leading
>> slash, only the trailing slash.
>>
>> The leading slash is not for making the regular expression match an
>> absolute path, but to force the match on the directory or file that
>> exactly starts (and ends if there is a trailing slash) with the
>> specified string.
>>
>> Finally, this also explains that this still doesn't prevent more than
>> the intended path to be caught up, specifically because it is NOT a
>> regular expression matching an absolute path. For that though, the user
>> can use BBFILE_PATTERN set for the layer they want to mask the recipe or
>> append files to BitBake. This is typically a regex starting with
>> ^${LAYERDIR}, making it an absolute path matching.
>>
>> Let's document those limitations.
>>
>> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   .../bitbake-user-manual-ref-variables.rst          | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index f20a9012c..6612dcc03 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -1071,6 +1071,28 @@ overview of their function and contents.
>>            When specifying a directory name, use the trailing slash character
>>            to ensure you match just that directory name.
>>   
>> +      .. note::
>> +
>> +         The leading slash in a regular expression in :term:`BBMASK` does not
>> +         mean the path is absolute. It simply forces the directory to be named
>> +         exactly that. Take::
>> +
>> +            BBMASK = "meta-ti/recipes-bsp/"
>> +
>> +        If you happen to have a directory ``my-meta-ti/recipes-bsp``, it will
>> +        be matched.
>> +
>> +        Leading with a slash::
>> +
>> +           BBMASK = "/meta-ti/recipes-bsp/"
>> +
>> +        makes sure that doesn't happen. However, this doesn't prevent matching a
>> +        directory ``meta-foo/meta-ti/recipes-bsp``. For that, use the
>> +        appropriate :term:`BBFILE_PATTERN` to only match a directory from one
>> +        specific layer::
>> +
>> +           BBMASK = "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
> 
> So this looks this is actually what most users want to do, right? Wouldn't it be
> better to put this forward instead of in a note, say, at the beginning of the
> definition?
> 
> For example, replacing the first example in the variable's definition by:
> 
> -The following example uses a complete regular expression to tell
> -BitBake to ignore all recipe and recipe append files in the
> -``meta-ti/recipes-misc/`` directory::
> -
> -   BBMASK = "meta-ti/recipes-misc/"
> +The following example uses a complete regular expression to tell BitBake to
> +ignore all recipe and recipe append files in the ``recipes-misc/`` directory
> +and subdirectories of the ``meta-ti`` layer::
> +
> +   BBMASK = "${BBFILE_PATTERN_meta-ti}/recipes-bsp/"
> 

Yeah I was conflicted... not sure what's best. This does also rely on 
BBFILE_PATTERN_meta-ti starting with ^ otherwise we have another 
potential name clash and we don't actually mention that in the 
documentation of BBFILE_PATTERN (though it is set like that when 
creating a layer with bitbake-layers create-layer).

If for some reason you have:

/layers/meta-ti/recipes-bsp
/downstream/my-layer/appends/layers/meta-ti/recipes-bsp

then both would be matched (I assume, I haven't checked). That is very 
much a corner case.

I'm also pretty sure nobody actually does that. The only layer I have in 
my pool of cloned layers which uses BBMASK is meta-lts-mixins and then 
doesn't even have the layer name in the paths so /me shrugs.

> What do you think?
> 

We could start with the BBFILE_PATTERN thingy, then explain there are 
other less restrictive ways to match multiple recipes or directories 
from different locations later on. Not sure what's best.

Cheers,
Quentin

