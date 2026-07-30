Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22765C54FD2
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 09:47:22 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8012.1785404835226751539
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 02:47:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=SEDyZhPQ;
 spf=pass (domain: cherry.de, ip: 52.101.65.0, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHeTw4iqHWuNJAViN76v2cfCqySsAPeGiyaA+8DN8X9qJuW6+Jh5ZGQc2R5RMKHPnQuKTStrWBY26bfRE5ofVrUWtpLU9nWWCZ7V/2OF7g9rs3DRl6PJpRuvbLXKkfCVIcGKBHo/5yXNiZFH3X293EaaGLGWnfoBHYkYI95y6P7yYY104DVMEeOeoRg+d+Vz89Z7N74hqQoLGIVHX6Rf6o6lx9N4r3dH5yztlhsdIJn6inehHey5z0XL9mRApxEy3/+TjU7TOzPKbFOTWMflb07ruHI4UjjWaEp/pvjbbd+6UjQJOiKerQRBY56fcJpfH1x9cNho/ETp5Tnc26wmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL8yzI0IRbZmtdcCHP3OyMfBPIBQjUpV7pq5jL8H+4M=;
 b=fbgntqpDCtpD/f6+xNfqWC309Zf1Zo+TQwHL7TUOK0JML6UABzIydnJYMwVPi5Yz6PSlzCUQsViEhyViON4Mvp1uVSJ/Kguskq7Lvk96TO1OsRtgrLCH+4hLvPolMCQ2fXI3vbLCqec3hdOXa99Xj5bj2Kly8Z+JjJhX45igAMan66zTDA4BRYdUbZsGtZXNA22ICIZghv/YgGj1a3Gbw8BnCbmPNrrrI0V8t/Ni7WsI9jO1IsRyjzriI77HR+r/Si0irFf1SPKMqNR37GT27iV/w4jkXXaVNP+S+uPuYKnglWWng5OsYeAC110SsOsIFPW+mBeuZZbsN76VQ0fh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL8yzI0IRbZmtdcCHP3OyMfBPIBQjUpV7pq5jL8H+4M=;
 b=SEDyZhPQJruenpnXW04bSxzZFmRc0hp7W7wCj7ee8K2DUnnl8If3mRVyu2ow1Qa389xPGeEFEs4zmU2FYTv0f+gzzj0Ka7tancCA/108OZ1zx5a2h34r3oQwgGv/0e2vdXEIAirXZbODxOWPOI92ySNRlsJQ3o/CjKbtc2J60UY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM7PR04MB6824.eurprd04.prod.outlook.com (2603:10a6:20b:10e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 09:47:10 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 09:47:10 +0000
Message-ID: <6e3d8439-3ee9-46a7-a8af-3b4cc9ce426d@cherry.de>
Date: Thu, 30 Jul 2026 11:47:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual-metadata.rst:
 fix append example
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20260728-fix-append-example-v1-1-b590f9e91d38@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260728-fix-append-example-v1-1-b590f9e91d38@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5b::33) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM7PR04MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: eaed809c-b8f1-4db0-09ef-08deee1f8693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|11063799006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: 
	/SOELNSrVG+YCzFgUEIIHFSvFCsQVoBLIgV50GtqoA3fhra6pemqUVPJS4P38u+aLjdQJMBlFKMZIETrSIWqXcylSOaCP/M8FEKByPoisHZI0xDa+jjx/FVeP6LclCi3n7va03zvJYRQ0eUBkeBBD/39WyqdA6wFGGFGkQ9EPqrzmQi5U5a0YVG8PWp3lMtMeEDO2q4NeoI4n5q9fEM439ttNSaSmqCyAEn9Xc8rRrSklqvAhQSWLK0LBoKhQd/UUv5KWHynScOndU9+2DoMycTzSh25EHgTRtWdYtygA4fNcQf0/JMCUgld2irmjtmpFG+gmif0gVTVgogimRT1laJjZ5Db30VLhFGyH69gsyU2BQQHNuPoGbxLF1ul+OoVRFC66R5Uk7MLm8WUA5BOurcXanR8uK3yiFteJeuHCcZR59DL+zO9sBbS4ES/Gybu8xfANN8S9ye/9ayqJLgBHCmdPiT67mmy8MckijPmaXhZ2+2ckzNAH2ecmBK7qe4uGQ6cLbMGLsleiq/b4k+G+qo/Tz2HvNF+UXyJmYA79kZ9s+oy4SYkiMhuVfdle4GhxTBaYh53yZQEdK5C8GkySy6C2wUulwx4fkIv52E4qryI+BmXjQWQ45W6tzDXH3QXa7tdfIMSPt3ln9KN6cYAPLoEp9iuLocLjYQ/fXZSf/8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlNXT29TMXlmVUNTUGlDbE43K3h3eW5wdXcxUDh6YkQ3Q2pPT1dpYUlTTXlD?=
 =?utf-8?B?L0g1K2g2UU1rbXVYOHcyU01xN3J1bmRkTElDTnFGWncrT3ZVUms2ODk2M3JG?=
 =?utf-8?B?Nk9tMGZPc0ZoOHFRZHhNaWoyNzdDYUxzdEVwZDEwa2ZHQVR3ZWN2cVg3eUZQ?=
 =?utf-8?B?WDlhR3d6RWh3N0ZIZk5iU01zc1E0UnF5MWExbTJPU3FBUjhFRXp4cjdOczE4?=
 =?utf-8?B?TGRpZE9Hd1RmT3QybFUvMGtJNFZxZ2cyT2FFRHl3ZW1LQlM0TGFhUFdaU0FI?=
 =?utf-8?B?Wk5GVldHWjJBSEIwTFlmWkVYZjFFellHeE1Vd1QrNnp5TGRTMHoxTm4yUTRV?=
 =?utf-8?B?dEhWZDhBV2hoSTdLakoySWRmZ1BTd3BOTjArYThqRGUxeVRpZjh3enBoV09x?=
 =?utf-8?B?Ly80YnV3M3owOHNMTjl5NC9OU0VWQkNvaitzcE4xYlJhS0V0eDdXaEsvRWpp?=
 =?utf-8?B?Vk55cFFvZmNESXJqMzJ6bmRkN0ZSaWtFZ0dsVEp2eVFDZjFUSGpaUnNBNGE0?=
 =?utf-8?B?OXJMQWYxc084REFJd2dsWXJpM0NORTRpZmwyOE96QW1hYlcyczNHbkNmWmpz?=
 =?utf-8?B?SFJEcU00VEMwTUJHUm0yY0p0OERoN3lnRzkyWW11Z2JoRTlCTGxpNFQzSFpp?=
 =?utf-8?B?d3Iwb05oRkU4RzZWajN6a0NiYitIQXhOR2V3aHNwOXo1Wm1UOFNWMEpxRDVL?=
 =?utf-8?B?cS90SkczdGRmNDlNNTVZYkkyM3JmSEI4bUZjUmduZjk1K3JFUkNvU3dpYVRW?=
 =?utf-8?B?ZU9JRzVKV0pOUVl6S0lKV2JYOG1ndlNJVWxSKzk2a0FtTU5hemprQlljbzZi?=
 =?utf-8?B?bDFwT3NnQitWY3VsZDVmVUhXaVlTUDVoeUI0THU2SStqRDZSS3JkQmpwRVl5?=
 =?utf-8?B?amhjWHZ0NzhPMFNKSk1SeDZmQTFESUJ0cWdYdFI0SC9YUjlmcGYrQ2cvSmFJ?=
 =?utf-8?B?UHIzZzFNV2FkUXVLMXd5OE9Zdkhxb2FSejdiaTVISlUrRU9wWjRCRVJGMDla?=
 =?utf-8?B?TnZTb2dSRG5pdndDWUdNM0dYQVpXWVB1V3dHRkcwUk81UHFhK2FMZXZuT3ZK?=
 =?utf-8?B?cDg5M3JRQ0RJaWl5Wk5sS1E3NGFRNVZ1TlRWRTBIY0QrWWZtVzJ0MXI4bWFF?=
 =?utf-8?B?LzZJVFRjeVdPWElVV1MrMmlPRXprMTY3TFgzS0R2YmJWUUZNVlBKSWlrUlRM?=
 =?utf-8?B?cjI1ZnhneWR1NTRoaGJVUFByN2ExUkNWM3dDc3J0RzZiSmw5d2tXTVd2NmZh?=
 =?utf-8?B?b1JtWFluSStHNWd4S3BTY1MwOVJmallmY204Smk3TnlINC9pN0xXSzRrTkhk?=
 =?utf-8?B?MFVFRHorV2d0MGFyT1cwMktGNzZySS8rdk1tNG84cHZORVdkY2x4NnRoZnhF?=
 =?utf-8?B?T2RQUDhzSDFaWGNmdjZDU3k5Q0tReEM2MFRHVFJ0L2dJUVNzdUx2MXJYNkZR?=
 =?utf-8?B?VFZvUTVFNXZLTU1ncGVqaHlDZlovdytraEhiWnN5STZMbGR3VVU1SnJQbHRo?=
 =?utf-8?B?d0dMb0hTWWU0QTFQWndobmVhbEtZa0FYRis0WmFmZllZWmd0SzBvRVNUb1Z4?=
 =?utf-8?B?WENKLzFSMnpZWkpJM29hVWlFaVhXOFpHWDJxZXNCVjV0Z21ZNFZFMUVVTkZ2?=
 =?utf-8?B?LzViSjY2K3Q0c1kvSlFBZVRudlZtdStRMk9rUnh2Z2tDTjRiLzAwMzdYRHZJ?=
 =?utf-8?B?MlZGaGEvVEJKcmp6V0ZkaWxaMlRLZ3BBYXgzcC9qTXhpQkNEYTJuMndidFBQ?=
 =?utf-8?B?L0QweFlJNERYaVYwREQveXNOaTlXQUx6K0xCNk1wZGxXTFVqc3N0b0NlekVx?=
 =?utf-8?B?bjhZYnJZSjdHZkk3UTZ3aE9rdkVTYjYwSi9DOGR3TXU3OGU0dEsrd1RqYVoy?=
 =?utf-8?B?Qi8wQ0RVNm14UGlJRFg1U1hybWE1Tmk5VnFodGNIalpIWUdwNEZDSmdFek4y?=
 =?utf-8?B?czRmMk5KUElZVFRBcnR0VWZvbE1oVGl1SFEzMEw3YmpyWlNRVU91azVaT0xN?=
 =?utf-8?B?UWtTejVObzBneG4wbytjMEg2MnBQU2xOeE1SMTBpOUJveWtiaVRzTE42QnZo?=
 =?utf-8?B?WExFZXovS1c3ZEM4eFRJdWU0dGFsMUY5MFhPeCtsSUZmcDZPZ29nWkJmNllv?=
 =?utf-8?B?SXJZTkVzRnlzNkFNc2tTQ0RRNE9GNSs2NlJwOTJIdlEwd3Eyb3MzQXovZ1By?=
 =?utf-8?B?R3JRWmNXNWt2Zm9RNWpQSjF5aE9qczlSempzMlRNb0tKc1BQQ3lEaEhNNjhw?=
 =?utf-8?B?K25MakVCaXJTNG5pUDdFTWF4bzZaSVFxWmRrWTczT0h5S0dhdTZnVU5IdDIz?=
 =?utf-8?B?bitNV2pNbU5HSTVKWHpCS3RmdnlJVXJmdGFFM05NdnNacURDQklpQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eaed809c-b8f1-4db0-09ef-08deee1f8693
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:47:10.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm1Ct94GovSUlFOmKJIREcsPF/wVgL47VJSZyGBWPaX4biyoLcU460Sc7JBvLtJgtFmtmS3e0Wzb/eK8IUgQFoC4JPoAnxpx+3vAxw1/flo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6824
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 09:47:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19874

Hi Antonin,

On 7/28/26 9:19 AM, Antonin Godard via lists.openembedded.org wrote:
> Add the missing whitespace in the combined override example, so it
> matches the evaluation we give afterwards.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

