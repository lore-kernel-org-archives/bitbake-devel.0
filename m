Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A47C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:37:47 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.132])
 by mx.groups.io with SMTP id smtpd.web10.3047.1740073063593619934
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 09:37:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=Gbm2Bt2K;
 spf=pass (domain: weidmueller.com, ip: 52.101.66.132, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3GyGYVHyRuPl4y7OhEGakUhGFD8Gyaph08lqtdODyecwATBrvVexHzwCAMKI7hxPTaOhvOYReXuMR/8vbA5rCL05BrOFltvZlWpETW+P0ixLFjP5YtmQDVC4lyHxGyXQfbHWAUYJJXLX+zsoU//Ngd5++0zRoHTWh/8JvHZXxV+rXOiIDag3VcNWCxVZ4wrGGn+ZCkI0lpNDT8rjKXeEuPLTmY5x+iQCHE0aXKq2nuFjHv/68INCzN9DoNeSeUyOKLdZDzg9JNxC4InG2BkFLh+ynLuN3OOD3BsVoBXn8snS5OhCPEFV/IK4n+I7Jk4/gl2hIXXv3VAAnWOV68U2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b0I2qV2/0xXOK1VhUavR9aSuMBx5RE33+CiGtI6+U8=;
 b=ZYvWpREv0MiZA03sLmOHLg0t60N4105+zCc/rLZ8nuDngUehHryBFMzZULGgeQ5D1W3iReSE4MqZSrTo2Fn8CA7tQ4AX+SYOTqJT82qZfZ1yHYEHF7z3kurT68FdSq2kYDZuIjfEpmM+/fUwGCt76WoEcZ6gQUakdvfxEWnRX4aqFG4AoFlznjbemETLCvqyAXREkx31KgvRhUV13qMjB6Db10MYG7UPDISzZQSUlOuEEJd0xdCmFmh311vMz1mcZLWj/FJV4d2Hy8KBgpB8qCFoYM7/9ou5CxpIGVR3tb3l+w9LwybhW/ObaP637YBBaPhGPJ6lmHgeciJdMc4LCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b0I2qV2/0xXOK1VhUavR9aSuMBx5RE33+CiGtI6+U8=;
 b=Gbm2Bt2KjQawB83x3R8GhcGWc0sWzJwEXTy1a2TfKlW5V0i8DJ3BRcz+XDK3atEy5RYBI3QV+ZCjNF/4z5d6D0k0lFIouqxr4MvG3Py9cUKmzFoK9HK748sRhmBndWSBI2ImEeXbOcqtYWb0WsgEn06e32F5jRmfhp7Zaz0Ic9ksRJjsJypRrr1Ny9DdDd0mhI1XYdQxHT5KRvJIBMeXV4BxDGJh/pW7ie/7EzuCXpV9R6SIjAgLEQivz82a/YnNb7qZflycbDwYz38gxIK3lqcDwPrRu1brhiY0d+WTUxJ1HSB7JTMG9fRqNb9k2PWycjpVH+SJB4SQjoobAo5L9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by GVXPR08MB7824.eurprd08.prod.outlook.com (2603:10a6:150:1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 17:37:37 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::abe2:5846:76b8:9087]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::abe2:5846:76b8:9087%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 17:37:35 +0000
Content-Type: multipart/alternative;
 boundary="------------26lj8SDW7YQ2qTKKeSoX4dHX"
Message-ID: <07c3ebb6-8cdf-416a-bc89-ab930d85e78d@weidmueller.com>
Date: Thu, 20 Feb 2025 18:37:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement syntax
 explicit
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
 <027ed1ac-02ae-420b-a65f-d4e48bc86136@weidmueller.com>
 <d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org>
 <6d445c40-5f24-47d1-a71a-1060e9b9da16@weidmueller.com>
 <9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org>
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|GVXPR08MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: c3085178-70c8-4295-00be-08dd51d5436b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OE44TU9Gc3NmWjkwSExOMW5qYVVHYW8xNUlpZnlSRjloS0hSaDJtelZ6Z0FW?=
 =?utf-8?B?aGdwVEdPNnMrRTlRd3FscEFFUFpjVFFOcHcycmRqOUVQWDJOaGp6Kzl2M0tG?=
 =?utf-8?B?cnBVaExmMEJIa05UWGlIWHRrM3lRQkdLYnIvam1FOUhHaDFoU3RFQ0tHd2dX?=
 =?utf-8?B?V3R0RVVhZ3lmUkdYc1pObmhQMVB4UVRQSHNTSFE2SnY3KzVLZ1dZWjN1cDI0?=
 =?utf-8?B?TVNmWjR1WFQvSi9FUXJzWXFGc2ZGamZwVnBtaGU4OU54blJ4SEpUZnBQK1kz?=
 =?utf-8?B?L2ZpSDdLcThFOU12ZEVTaGpDYmlHU3krSFF4RHEyRW1mSDNSYVg4Nkl5SnFM?=
 =?utf-8?B?WnA4cUY2TGg5UmdrWkY2cVJRZTdQWjRYMTIwV3Q1VFhZa29sd0hYS2g2SlJa?=
 =?utf-8?B?SEFpdFhtZnU5STRmOGVsWEJvVVRkdWhrWkZEUlVJMTlkaCs1dDBocHorOWpF?=
 =?utf-8?B?aHZCSXh1ait6UzBuWEE1Z0VCN2paSlFJTGpOZ0tvbnhCd3dPWUNKaEhzUS9s?=
 =?utf-8?B?OVRteitEWnhBeGJGREVrbEVoMVVkNG9hY1h2VXBVTFl6UERCUFpsaWxmY3h2?=
 =?utf-8?B?T3BVVjdhWVpxbDZaSlRkU0k1d3c1aXp2cStLTVNHU0dQdVFtUHpZMEZzNXYw?=
 =?utf-8?B?WWdqUFY4czRNdDUyTUNuUlB1RE0xNGxSOHhNbjQvKzM3VS9ya3VxSDhkN2xI?=
 =?utf-8?B?MzM1ZVBzbTBBQnFKTmJXWjNDc0lsZmEyMFFTKzJzU3VTM2FYbzBDZEtZK01t?=
 =?utf-8?B?QjNoejlIQVE0aEZPZk5uaVdkTnV2VlV4MGJ2YXI4NXZwU2sycCtuWitjU1Rx?=
 =?utf-8?B?Nmd1TTJyTjVMVEJVeW1TQm51QTZ3VVMwKzIzQ3lidnpkbzdjQjMrM3RrckNK?=
 =?utf-8?B?cFp2cElmc0tGWENodmR0c212MTdCS2ZYK0xVNEIwV2dxbzV0c2JwRTRFTmtE?=
 =?utf-8?B?dENzNjhpNUUzTGtXUDRtQzRsMW9qM1FRa0FEVTNvNDA5aVpyN2l6cWFkTVZ5?=
 =?utf-8?B?RnFFU3hRdnRLZjArekd4TVVKeng0cXYvWWJNSkgrdHpvT0p2MHJNeFFEeFZs?=
 =?utf-8?B?NzR6aWsxbVlPZDVCTUtMVXlqQ29xZTZVZEJLaTlncTVxTXBHK0NWUGRobFpi?=
 =?utf-8?B?eng3cWpBRTlRTzNydC9ZempMZFN6eWVGaE9oN1Jpank3YXhkR0NwV3VjVmp6?=
 =?utf-8?B?NkxMNHlTeHZEZVlPbzRaS2FkVGNiaEM4RVpuNEtYMVZENlczVlNPOEJqSDVh?=
 =?utf-8?B?cmI2V0cxbFplekkzeUpmdUJLS1M5ZjFoeHFOTWdFUnNZcHIyTE5jdmpaaXZz?=
 =?utf-8?B?YWk1WlNvWDhhVVZnNEZIWTNENXJMZlZmUXNwd0EySzB1Ti93ZlJ0VGpHcnRX?=
 =?utf-8?B?b0pVOTVBKzZpamswbGcvUEM5bHMwNW1NQWhIZ2tBSm53TnRCN2diZW1zVnU1?=
 =?utf-8?B?NER2SnlJd0RrZDVGNmVDdGdnL2hHSzlxUjBXRFNXQkVhQTduZ0FDeXcxMzZL?=
 =?utf-8?B?VEVnb0tjZzYzUXhIZWh1K3JBN0VKK1E2RC9ITXN5SmR5aWJlMms2MDQrazVH?=
 =?utf-8?B?SktBZWhMa29obTQ2RUM2OWlRWTBOTDVZUUlaOEk5WDN6N0RBWTg3Z1pzMEpD?=
 =?utf-8?B?YWVWR09OTFd1R000N0xiOW82MmZNZkVGN1g5dHdmVGFRdmxwVG8xOUlxenhl?=
 =?utf-8?B?dTYxN3VYTFNWaGc5UGhyYjh5RTh1eEpaUFM3dFJsUTNzWk9HWVM1UXNJMk1O?=
 =?utf-8?B?UVU0d01nZjJMZlhrVlNuSVdNdkpQRy9OSCtIQnd1ZGR5MlB3K0gxR2wySHIr?=
 =?utf-8?B?Wm8rTnV0cXpoZHhrWE5Ddz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHI3YmpHdWE5QnIxNkNrY2g1SHV5RzJzcFRUbTVVVVJUSkRmcUNqSWpVaGcx?=
 =?utf-8?B?bzdqdnVGcjh4Q3g1Tzc2WTB2WFpQSGpjMEQ5R21SaGlLUHExZHpCRDVoOVZS?=
 =?utf-8?B?SjFYTzZ3ZDZzallWdGgwcGx3c21QMEpjNDltRFBxanZGalhwbURzSlhIODQw?=
 =?utf-8?B?QVpLZmt5VThSOFhWU3FhWGxCUWN0NlRxSW81WUpoQW1oTW52S0h0QXFKZW5l?=
 =?utf-8?B?VzRxZjBMcGdudDV4T3FxYTVZc0U4dlc0R0lDV2lPRHE0SkVUQ0tWV3ZEL3p6?=
 =?utf-8?B?WDBEaFQwVzBHb1pod2k0Wkl3NjlFWUF6aS9qTHpHV0d0aWRHZnR1ZHNBbzFY?=
 =?utf-8?B?b3FIRXIwMHcrZGFlVERWbjBHeUVrSlU5aFBXZWg1aWhJQThnVGNGTkxUWkdE?=
 =?utf-8?B?U2d3dUFxMFB0RXptTnNJNU1RMWNyelJzUm5nNlBORm9BcnlnYjk5WTRDUTdV?=
 =?utf-8?B?Y1I5anhUYlRjaEg4SnNhVHpiVHNqVHFLMW5NSmJvb2V4ZVRxRHpWRzFGSTBI?=
 =?utf-8?B?a0p2d25DR1BYVGo1WnlqK3VKWjRjWThGaFh6dVpzS1BaMnZUUVRac2lDV1dY?=
 =?utf-8?B?Zk4xWjlPNVNRSDN5OVFpcWducTRRczl5WmFZb2txK0V2UllTR3Zra0poRitG?=
 =?utf-8?B?a0pndEZxUGo0MldBdDNhZWI3U0djcVo5MWRBMGlTdm8wOG10UWd0OXh5cGs3?=
 =?utf-8?B?TDdVamxndWwyNU93enVrR05rQkVwUE5wUHdOckwwajRnVE5ZYmk1aS9sSVJv?=
 =?utf-8?B?Qk9id09RSWtIUEFkdXBwRkNwNGRCMmF5bmhoYVBscXF0eXVacW5SS2lSUkJk?=
 =?utf-8?B?SUVpTmtSZGJXU0Y1eTZXTHV5cEFhbnJ0U09vR3BPQVc1V2VhdEs4RUoyRDAx?=
 =?utf-8?B?UldsdzBmS1p6Mmd4bzdFMEFwdlpzcEZxOSt5cXVhMVFReGtKbTNjem1udFQw?=
 =?utf-8?B?L3FRM0NHbGR3WS9SNUgxemd1TU8vU2lKcW9SK2NoNDIvNW5QSXk5S1hvZzVQ?=
 =?utf-8?B?SFpzZTdrNjhJN2xvNjZBY2owQ2tKV0taeXV1UitGWThJQy9MSkk5eGxvbFF1?=
 =?utf-8?B?ZktxVU9XVkhLZzhQTStPZFFXbTdiR0lhR01IN21nQi9rZnArNU9aemNzMHl1?=
 =?utf-8?B?ZGFjUllKT3RhTnpkY3JzUjUzRUFYM05wbEJjSDM5TmN5NVZQSzBaMWowRjJD?=
 =?utf-8?B?TWNORlhwMGwyazMweTFWV3g0S1ZNZnZKYjRTU1NCamZpUDBmc3RHY21lbVVG?=
 =?utf-8?B?SS9tYmJ4UFNSZ3BPWnBpd09yd29UY01UcFJRNFNaZUUxVmdLL2tmUCtDbnZK?=
 =?utf-8?B?RjB6VmRrVlQ0TU9ySEU5Y3ZmMTlJMlZ3QU1yVFM0eUQ5ZFJPWmpLTkhFaVU4?=
 =?utf-8?B?YmkrcVRFSHZjaURzVHQ3Ukt2S2RkZFZWZzJ0R1FhUFRkRGpXMFZsdmlQK29X?=
 =?utf-8?B?U0dIYTBNOUlnZ3JXbnZMSzlTOFB5VWxWd05PQW81RExCaWl1Rm5EMlNLUmJF?=
 =?utf-8?B?bm42UHdEMGNrUnZQeFRhb0FyL0tzQ1JoUUU3MjNRcHBYeXdWQzVKVmRrL1RM?=
 =?utf-8?B?Qk5oclVHd243cUg1QnVHWG94blppd3ZIZHBkdmloTnZlUE5TYVRWYmMxQzJB?=
 =?utf-8?B?dGRNSENMeFZnRGE4bmFZYlhNcGdTcDRNdDZLS1pLZkJrVGdER04vTFMwSkRj?=
 =?utf-8?B?KzRSdm9xSC9FZ3FMOHlTTS9hMWR3Qytyc1ZzZEUrTjVWTWhwNTVKNElSQnZK?=
 =?utf-8?B?d1F2MU1DR1cyLzFvQm9XTENTMDc2cStXWnpzYkxvUlhnTUMvMUJTL01hbHg5?=
 =?utf-8?B?bDR4V3ZuR1pmeGpjKzJLcGVORy9QdVd1ZndLOUg1TUg5ZHpnWFI2N05sQkRP?=
 =?utf-8?B?cE8xbHRnM280c2tOSjg4ZnFqUU5VbG11UzRuVXF4OTh4enFVQzBJS2lpUGpZ?=
 =?utf-8?B?S0ZDNENvT0pMOE1YcTFxdjYxSDhlclF6WmhsK0dNNDNqZ0xCeDlwTmxVMWF5?=
 =?utf-8?B?Tm1SaGxJVWNTWGU0eDBvaUJXRnJQLzU1SkQrMXZSaUlmdnU0eVpKVjBsczh5?=
 =?utf-8?B?cGNTWVpuOGltU1BzUnVnVzRPMU1UU2p0Q1grOEJ4cTR3OTM2UEFrWUs1S3p5?=
 =?utf-8?B?cmZNZi9iUjlodksrazc5Y2dJUERGdEVrajY4VlJwOHpsaGpSZHo5UGdOQ1Ni?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3085178-70c8-4295-00be-08dd51d5436b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:37:35.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSi5MxXgaNdPdqFaGgsBwNajDFnHbdm0Pg7AESKxyHoO3oDI2O3NYMYwIF1QRRMrfRfsNIX3uZkTROOQJaUNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7824
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 17:37:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17266

--------------26lj8SDW7YQ2qTKKeSoX4dHX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.02.2025 um 13:21 schrieb Richard Purdie:
> On Thu, 2025-02-20 at 12:45 +0100, Stefan Herbrechtsmeier via 
> lists.openembedded.org wrote:
>> Am 20.02.2025 um 11:22 schrieb Richard Purdie via lists.openembedded.org:
>>> On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:
>>>>   Am 05.02.2025 um 11:34 schrieb Richard Purdie:
>>>>   On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>>>> I’m open for suggestions. Even ARCHIVE or TARBALL are hard to
>>>> understand because it is only a relative path on the download mirror.
>>>> Alternative we can mark the lines as upstream or download mirror and
>>>> give the replacement different meanings. The path could be the
>>>> original PATH for an upstream mirror or the relative path of the
>>>> downloaded file for the download mirror.
>>> I've been giving this topic some thought. One idea I wondered about was
>>> to instead markup the mirror urls with how they're expected to work
>>> with a new parameter. For example:
>>> git://.*/.*http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball
>> The ? could be problematic because it is the separator for the query. 
>> It is unlikely that the user really use this query parameter but it 
>> could complicate the code because we have to handle additional query 
>> parameters.
>> What does the "?mirrorformat=mirrortarball" mean? Will it work like a 
>> MIRRORTARBALL replacement?
>
> The mirrorformat parameter would be used by the mirroring code itself 
> to understand how to handle the url.

What is the different to a MIRRORTARBALL replacement? The code will 
replace the word with the content.

> It would be dropped from the modified url so is only therefore our 
> code's use. If there are additional parameters they would be passed 
> through as they are now.
>
>> How does a simple replacement should look like?
>>
>> http://  https://
>>
>> Because of the backward compatible this will replace the basename of 
>> the path.
>
> It would depend how the mirror is laid out. Some mirrors flatten the 
> urls like DL_DIR is laid out, some potentially don't. The standard 
> usage would likely have a mirrorformat=dldir parameter added.

How does the user specify an entry that replace the http scheme with 
https and keeps everything else like it is (upstream mirror)?

>>> The possible options would be something like:
>>> mirrortarball - mirror tarballs taken from DL_DIR
>>> flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)
>>> upstream - layout is the same as the upstream directory structure so a direct url replacement
>> Do you think we have to handle the mirror tarball explicit? The 
>> mirror tarball is required for a scheme change.
>
> If we do that, we can avoid having to guess at too many urls to test 
> to figure out a mirror format so I think it would be an improvement on 
> where we are today.

Do you mean we will test if the URL have a mirrortarball and if not skip 
the entry?

>
>>> If using a mirrortarball mirror url, we'd know to use the values from
>>> urldata.mirrortarballs. We could add parameters to the fetcher to have
>>> two parameters, one will be the DL_DIR path and the other would be the
>>> upstream url path.
>> I don't understand where this is needed, because the mirror tarball 
>> and downloadfilename are used by different fetchers.
>
> Please keep in mind that downloadfilename is pretty much a misfeature. 
> It was added as we couldn't control collisions inside dl_dir but it 
> creates all kind of other problems. I think we do need to handle that 
> problem case but it does then mean we have to indicate whether any 
> given mirror uses "dldir" or "upstream" names and paths.

I don't understand the problem. The download mirror will use the 
downloadfilename or its default the basename of the localpath. The 
upstream mirror will use the path. The mirrortarball will use the 
mirrortarball. Why the fetcher need two parameters?

>>> One key question I have is how we might need to
>>> shorted the url path for some mirror urls to add/remove a path prefix
>>> in the mirroring.
>> What do you mean by this? The downloadfilename could contain a path 
>> without any problem after my change.
>
> See above, downloadfilename is not something I'm keen to promote and 
> is creating several of the problems we have by badly trying to hack 
> extra functionality onto the fetcher without thinking through all the 
> issues like mirroring.

What is the desired way to avoid name clashes? The package manager 
fetcher need an generic way to override the basename.

> This is about the fact that you could have:
>
> htttps://some.server/some/deep/multi/level/path/
>
> and a mirror of things there at:
>
> htttps://some.server/shortpath/path/
>
> so the mirror urls need to be able to map
>
> htttps://some.server/some/deep/multi/level/path/a/b/c.tgz

This could be solved if we use my proposed code.

> to
>
> htttps://some.server/shortpath/path/a/b/c.tgz

htttps://some.server/some/deep/multi/level/path/ 
htttps://some.server/shortpath/path/

> but also:
>
> htttps://some.server/shortpath/path/c.tgz

htttps://some.server/some/deep/multi/level/path/.* 
htttps://some.server/shortpath/path/DOWNLOADFILENAME

> or possibly
>
> htttps://some.server/shortpath/path.d.tgz

> if downloadfilename is in action.

Because the fallback for the downloadfilename is the basename the same 
entry works.

htttps://some.server/some/deep/multi/level/path/.* 
htttps://some.server/shortpath/DOWNLOADFILENAME

>>> I think that would cover most of our scenarios and make the mirror urls
>>> much more useful/explicit.
>>> It also would give us a migration path as the code can simply error if
>>> it sees a mirror url without a mirrorformat parameter. This may mean we
>>> could have a clean slate for the mirror urls and switch to one clear
>>> format. I think we can make a case for such a breaking architecture
>>> change.
>> Does this means we doesn't need a backward compatibility?
>
> If we can come up with sufficient justification to break things and 
> can detect and error correctly for old usage and get this signed off 
> by the TSC/community, potentially, yes.

Okay

>> Alternative we could make some replacement mandatory if a wildcard is 
>> used to detect obsolete entries.
>
> I don't understand that.

If we have a wildcard .* in the path we need to know how to replace it. 
This could be the PATH, BASENAME, DOWNLOADFILENAME, MIRRORARCHIVE or re 
group. But in case of the re group this could still be an old entry.

Do support all cases we need a fix prefix or delimiter:

r:http https

http#https
http|https

http?://.*/.*|http://downloads.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE
git://.*/.*|http://downloads.yoctoproject.org/mirror/sources/MIRRORARCHIVE

> I do think we have too many problems in the existing mirroring url 
> mapping and we probably need to rework this rather than try and pile 
> more patches into it and complicate it further.
I have already rework it. If I can remove the backward compatibility and 
replace it with an error this would simplify the code. I only need a 
better name for the DOWNLOADFILENAME (DOWNLOADARCHIVE) and add the 
MIRRORARCHIV.

> The question is whether the proposal fixes the issues it needs to and 
> has enough simplification and benefit to justify making the change.
My patches support folders in the downloadfilename, upstream mirrors and 
renames. I have to rework the MIRROR strings but therefore the commented 
out tests work.

--------------26lj8SDW7YQ2qTKKeSoX4dHX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 20.02.2025 um 13:21 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      
      <style>pre,code,address {
  margin: 0px;
}h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}</style>
      <div>On Thu, 2025-02-20 at 12:45 +0100, Stefan Herbrechtsmeier via
        lists.openembedded.org wrote:</div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <div> </div>
        <div class="moz-cite-prefix">Am 20.02.2025 um 11:22 schrieb
          Richard Purdie via lists.openembedded.org:<br>
        </div>
        <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <pre>On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:</pre>
          <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
            <pre>&nbsp;Am 05.02.2025 um 11:34 schrieb Richard Purdie:</pre>
            <pre>&nbsp;On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:</pre>
            <div>I’m open for suggestions. Even ARCHIVE or TARBALL are
              hard to</div>
            <pre>understand because it is only a relative path on the download mirror.</pre>
            <pre>Alternative we can mark the lines as upstream or download mirror and</pre>
            <pre>give the replacement different meanings. The path could be the</pre>
            <pre>original PATH for an upstream mirror or the relative path of the</pre>
            <pre>downloaded file for the download mirror.</pre>
            <div> </div>
          </blockquote>
          <div> </div>
          <pre>I've been giving this topic some thought. One idea I wondered about was</pre>
          <pre>to instead markup the mirror urls with how they're expected to work</pre>
          <pre>with a new parameter. For example:</pre>
          <pre>
</pre>
          <pre>git://.*/.*  <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball" moz-do-not-send="true">http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball</a></pre>
          <div> </div>
        </blockquote>
        <div> The ? could be problematic because it is the separator for
          the query. It is unlikely that the user really use this query
          parameter but it could complicate the code because we have to
          handle additional query parameters.<br>
          What does the &quot;?mirrorformat=mirrortarball&quot; mean? Will it work
          like a MIRRORTARBALL replacement?</div>
      </blockquote>
      <div><br>
      </div>
      <div>The mirrorformat parameter would be used by the mirroring
        code itself to understand how to handle the url.<br>
      </div>
    </blockquote>
    <p>What is the different to a MIRRORTARBALL replacement? The code
      will replace the word with the content.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div> It would be dropped from the modified url so is only
        therefore our code's use. If there are additional parameters
        they would be passed through as they are now.</div>
      <div><br>
      </div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <div>How does a simple replacement should look like?<br>
          <br>
          http://&nbsp; https://<br>
          <br>
          Because of the backward compatible this will replace the
          basename of the path.</div>
      </blockquote>
      <div><br>
      </div>
      <div>It would depend how the mirror is laid out. Some mirrors
        flatten the urls like DL_DIR is laid out, some potentially
        don't. The standard usage would likely have a mirrorformat=dldir
        parameter added.<br>
      </div>
    </blockquote>
    <p>How does the user specify an entry that replace the http scheme
      with https and keeps everything else like it is (upstream mirror)?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <pre>The possible options would be something like:</pre>
          <pre>
</pre>
          <pre>mirrortarball - mirror tarballs taken from DL_DIR</pre>
          <pre>flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)</pre>
          <pre>upstream - layout is the same as the upstream directory structure so a direct url replacement</pre>
          <div> </div>
        </blockquote>
        <div> Do you think we have to handle the mirror tarball
          explicit? The mirror tarball is required for a scheme change.</div>
      </blockquote>
      <div><br>
      </div>
      <div>If we do that, we can avoid having to guess at too many urls
        to test to figure out a mirror format so I think it would be an
        improvement on where we are today.<br>
      </div>
    </blockquote>
    <p>Do you mean we will test if the URL have a mirrortarball and if
      not skip the entry?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div><br>
      </div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <pre>If using a mirrortarball mirror url, we'd know to use the values from</pre>
          <pre>urldata.mirrortarballs. We could add parameters to the fetcher to have</pre>
          <pre>two parameters, one will be the DL_DIR path and the other would be the</pre>
          <pre>upstream url path.</pre>
          <div> </div>
        </blockquote>
        <div> I don't understand where this is needed, because the
          mirror tarball and downloadfilename are used by different
          fetchers.</div>
      </blockquote>
      <div><br>
      </div>
      <div>Please keep in mind that downloadfilename is pretty much a
        misfeature. It was added as we couldn't control collisions
        inside dl_dir but it creates all kind of other problems. I think
        we do need to handle that problem case but it does then mean we
        have to indicate whether any given mirror uses &quot;dldir&quot; or
        &quot;upstream&quot; names and paths.<br>
      </div>
    </blockquote>
    <p>I don't understand the problem. The download mirror will use the
      downloadfilename or its default the basename of the localpath. The
      upstream mirror will use the path. The mirrortarball will use the
      mirrortarball. Why the fetcher need two parameters?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <pre>One key question I have is how we might need to</pre>
          <pre>shorted the url path for some mirror urls to add/remove a path prefix</pre>
          <pre>in the mirroring.</pre>
          <div> </div>
        </blockquote>
        <div> What do you mean by this? The downloadfilename could
          contain a path without any problem after my change.</div>
      </blockquote>
      <div><br>
      </div>
      <div>See above, downloadfilename is not something I'm keen to
        promote and is creating several of the problems we have by badly
        trying to hack extra functionality onto the fetcher without
        thinking through all the issues like mirroring.<br>
      </div>
    </blockquote>
    <p>What is the desired way to avoid name clashes? The package
      manager fetcher need an generic way to override the basename.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div>This is about the fact that you could have:</div>
      <div><br>
      </div>
      <div>htttps://some.server/some/deep/multi/level/path/</div>
      <div><br>
      </div>
      <div>and a mirror of things there at:</div>
      <div><br>
      </div>
      <div>
        <div>htttps://some.server/shortpath/path/</div>
      </div>
      <div><br>
      </div>
      <div>so the mirror urls need to be able to map</div>
      <div><br>
      </div>
      <div>
        <div>htttps://some.server/some/deep/multi/level/path/a/b/c.tgz</div>
      </div>
    </blockquote>
    <br>
    This could be solved if we use my proposed code.<br>
    <br>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div>to</div>
      <div><br>
      </div>
      <div>
        <div>htttps://some.server/shortpath/path/a/b/c.tgz<br>
        </div>
      </div>
    </blockquote>
    <p>htttps://some.server/some/deep/multi/level/path/&nbsp;
      htttps://some.server/shortpath/path/<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div>but also:</div>
      <div><br>
      </div>
      <div>
        <div>htttps://some.server/shortpath/path/c.tgz<br>
        </div>
      </div>
    </blockquote>
    <p>htttps://some.server/some/deep/multi/level/path/.*&nbsp;
      htttps://some.server/shortpath/path/DOWNLOADFILENAME<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div>or possibly</div>
      <div><br>
      </div>
      <div>
        <div>htttps://some.server/shortpath/path.d.tgz<br>
        </div>
      </div>
    </blockquote>
    <br>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div>if downloadfilename is in action.<br>
      </div>
    </blockquote>
    <p>Because the fallback for the downloadfilename is the basename the
      same entry works.<br>
      <br>
      htttps://some.server/some/deep/multi/level/path/.*&nbsp;
      htttps://some.server/shortpath/DOWNLOADFILENAME<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <div> </div>
          <pre>I think that would cover most of our scenarios and make the mirror urls</pre>
          <pre>much more useful/explicit.</pre>
          <pre>
</pre>
          <pre>It also would give us a migration path as the code can simply error if</pre>
          <pre>it sees a mirror url without a mirrorformat parameter. This may mean we</pre>
          <pre>could have a clean slate for the mirror urls and switch to one clear</pre>
          <pre>format. I think we can make a case for such a breaking architecture</pre>
          <pre>change.</pre>
          <div> </div>
        </blockquote>
        <div> Does this means we doesn't need a backward compatibility?</div>
      </blockquote>
      <div><br>
      </div>
      <div>If we can come up with sufficient justification to break
        things and can detect and error correctly for old usage and get
        this signed off by the TSC/community, potentially, yes.<br>
      </div>
    </blockquote>
    <p>Okay<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <div>Alternative we could make some replacement mandatory if a
          wildcard is used to detect obsolete entries.</div>
      </blockquote>
      <div><br>
      </div>
      <div>I don't understand that.<br>
      </div>
    </blockquote>
    <p>If we have a wildcard .* in the path we need to know how to
      replace it. This could be the PATH, BASENAME, DOWNLOADFILENAME,
      MIRRORARCHIVE or re group. But in case of the re group this could
      still be an old entry.<br>
      <br>
      Do support all cases we need a fix prefix or delimiter:<br>
      <br>
      r:http https</p>
    <p>http#https<br>
      http|https<br>
      <br>
http?://.*/.*|<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE">http://downloads.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE</a><br>
git://.*/.*|<a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/MIRRORARCHIVE">http://downloads.yoctoproject.org/mirror/sources/MIRRORARCHIVE</a><br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div>I do think we have too many problems in the existing
        mirroring url mapping and we probably need to rework this rather
        than try and pile more patches into it and complicate it
        further.<br>
      </div>
    </blockquote>
    I have already rework it. If I can remove the backward compatibility
    and replace it with an error this would simplify the code. I only
    need a better name for the DOWNLOADFILENAME (DOWNLOADARCHIVE) and
    add the MIRRORARCHIV.<br>
    <br>
    <blockquote type="cite" cite="mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org">
      <div>The question is whether the proposal fixes the issues it
        needs to and has enough simplification and benefit to justify
        making the change.<br>
      </div>
    </blockquote>
    My patches support folders in the downloadfilename, upstream mirrors
    and renames. I have to rework the MIRROR strings but therefore the
    commented out tests work.<br>
    <br>
  </body>
</html>

--------------26lj8SDW7YQ2qTKKeSoX4dHX--

