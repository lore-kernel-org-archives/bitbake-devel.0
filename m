Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3046BFF8868
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 17:35:18 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1659.1777311316529674038
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2026 10:35:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=L1ILewT4;
 spf=pass (domain: cherry.de, ip: 40.107.130.67, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZb8YdUrB6cLGEgo6+NNo9T0Xgude81Gh7G4tRgEBg1IAYHhzIXd36P+79wckm5Lt44Fl+T6BU67GXiXu2kqYW7e5nddE+NUs+6BFBIYh3XlHO/J5piEHIFc6FaPqDiJRoRmgeCCCG5R0LL+Q0CtrI4VcldwvNYA7mN9I6a/jdm27IGQbQo6BnuJbo6kcAix8yb006YKFgR8/kgJbhAV/EBgv+IDUbJMYzWbt23t+wmDc0n0G8QKUB3HN8KSR9A4XFVizXC19IKrdnTVLRhL30hms7umtPaJsQzdPnTOwesoyAOzQ5MbwDS2KrpzYInUZR+Dcy7tdtptzB9e78Zfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f1Tg0a69q9kFLVBErZ/mETQwo1CR9QqGNetgTcM7iA=;
 b=HzhnKOLIWYDsCa2WemWKRdh56QKZMlencVtONufUvCBANttny+gJVZG1fq3ALIrAl9/GQR+r4/uBAU4GdBKzH7D0T4AJZ3W5bmeeFi9NjFy7IekUMYsXMyWDyfR1yoRPFN+bbbGpl7N7f6aCTz7GlXrYT341bK3xrczoVM4VLHZGKSnzWbI8HEtuOF3WSQkuAdqMJCaJGMY2O6+A8rmPDFsHk3sSyuKh2QghZcVD2oRGBDkPOWdsgJaeq15PUYv4KSoLgT8HDdjohzCJS2dAnlnQSP3IRq1LkEZNzW92OJZlguXdqDe80AKYk9MAgG3Ri8bK90XcUQHYR25D4Ct6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f1Tg0a69q9kFLVBErZ/mETQwo1CR9QqGNetgTcM7iA=;
 b=L1ILewT4BHLYSkOdszsVjciAnjzOSGqch78zPE1v5IIyCtQwHpNhtnUgApgW7MQrFpahwtum7D9xIudH+QrJ9fKHN2MHaTANn4PH0HBtvtkDWupQshAfZoeZ2DbAtL8DxmLWYVt4jxVJNEQk5YlCpXuLOJD0AjjcjnjypQr5LC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 17:35:12 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 17:35:12 +0000
Message-ID: <9abe98c8-4f08-4d34-9e16-52e21e874066@cherry.de>
Date: Mon, 27 Apr 2026 19:35:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 0/1] crates.io data access policy
To: johan.anderholm@axis.com, bitbake-devel@lists.openembedded.org
References: <20260427135122.1504143-1-johanam@axis.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260427135122.1504143-1-johanam@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM9PR04MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f94e51-68d2-480b-020b-08dea48355e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	7dLfhOhO5SKgZek/limKFc15l44tMl7ruZN3Ct2b43rBdrIovHao3oOes3j+PcVhO1a9RI1TzPTnW7UffYRKgeyQTrTzflIcr0V/AvYAK/pAttjOGBa0ga3ePLn6M4dKXGfwSYgXa4rW4HmGWhbwoTzog8hWxCwcsvtWEZKTz7nMClMtmgmK/Vq2BBEV+ktMaGj0IjUF5/h3Hxp/eUu6WMwNkmfeLguiTwPc7hHJ0GCUQHnUJPlvbSyvoq+yhouvMMBoHypzkH8+J68okiR6aP1UWE3MWw1DUAcsha/bU4rjGgBgR3YD1Ke1bt9s/6dQLY9IYHRUE77Yf614poDuuJ/dSep3PLQm1FL4b7nDSwb/BUvNb1gTWyPZjQprE9/K47G0/jFF05I0g6VeJCShQrhCySYIrSZgiKUbAPSyK1xqHO2BAHTlpBWMYpReMmyYhpmkjo/ac4UcEP1jlutkJuFDbI/MI9cpR1JEsXav1unK0Cc16JMSjvqjgp8B7U8/dWX5ZcQwmOZZXpxRK0N8shkFVv3tmwF0bS7FD9YEn1v73i55h8k4/p8HVFLBM3Ir8qgA5po++2MQMbsAB+eDdpbkl0VH3xmP46/eUHaydZh1BjaaAiXibLMSnxv8ioSIYQpE21mcsGRyvWlMaSiqJF88lMuQvj/F73JyA5UB3Bp3gH+z/z8SZpqXtJxZTWuZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXVQaEVkSkFNVFZ4OS9kaDAxMnV0QlZwRjFmemltVUtHZkRFWGVKNjlNY0Ir?=
 =?utf-8?B?U2wvRHk5dmljWE9vaTdtMVZINVk3NGxLRks5NStQenc4NUtzZjF1V1NUcHNz?=
 =?utf-8?B?L3dSRVp3SjVJenBKZVIzQVYxTlN2dHRWVzJMYndOOFkzU3J2K3NhaVBZNjR4?=
 =?utf-8?B?S1FDcTl5T2U5NTVrQzBBcGdmRlBLUklGbnZkMlNZOVZLWXNScXpRWWp4RE1I?=
 =?utf-8?B?MlYzNnpoV2xUSWluSmNEYzJPOHlEQnhoNS9DZHlESi93cDc1SFI5RXBiMXd0?=
 =?utf-8?B?ckZmRUQ5NE5EejE5a1FjM0R0YWd2bjRnRnJmM2lrWU9MZ3psdExPbUVvTmRP?=
 =?utf-8?B?djRmV0xOelZRaFZtb1VTSTJHYUNyVGd0empuYnR6RExxR2RRSG5tRkRwRjBE?=
 =?utf-8?B?bXJFZFFaNU9sY3JuNUdGbWhZbnJHRzhzYVNqWnBiaHdEdGR4NGtyRjVqdUtm?=
 =?utf-8?B?eXQ0WVlxaExFMDY3N3lxYkFEU2lBQzZ2SXB3UkJhYXdOcFZNd0tuWWN6RnND?=
 =?utf-8?B?NmJPNmlQYUtTbERoakloV0F1UWFYeHNQODVES2hNblo2bDVYTU0xb2tjdTYz?=
 =?utf-8?B?N2h5Q1dtU0lZRHNiMnVtdmJ2eHFTajJrU3hHVFZQZVMvVVkzQWI3Vms3eVlq?=
 =?utf-8?B?WmQwTmVaNFZPcytkTzB5NTB2aTVnYnhBTXpTdFZvMnZUV1Z3UXE0MzdWcTRu?=
 =?utf-8?B?WlErWW5xQUZWeHNHeXNnWVZvN3hpV3ExeEE5WlZlcHRaMXJ0bCtYOUhVbnZU?=
 =?utf-8?B?TVU0dmpUY29aMFdsRnJjaGxLQTExYmJ0akNWKzFqdjkyUWd3QlJXRTVOTWNV?=
 =?utf-8?B?UjRpNDh6M0MxTDIwMElZV2tJdERkUkFLci9TSFVQMkFRZ1NLL3FEQWhNUVQz?=
 =?utf-8?B?Wkl0aDg0MUdkbVBoVlZmQm9UKzJNcHkrbDBBTlhkbGpZNXdKR3BHckpSQjA0?=
 =?utf-8?B?b3h6b2tPOEdlUHlHRHZPQWh4TTdSMU9DYyt5WFB6RUVZRFF1eTlwK2h4Y21V?=
 =?utf-8?B?azhDM25CWmpOTmtWN0VMWkV3T1F4MUZteDIxR1BOK1FMdzViZVl0eVI3cGJx?=
 =?utf-8?B?UWo2endZdDlCbVl1azU0TUY2SVIyYWROMUM0eWVhZ085dXY2R1ViNEE3QnIr?=
 =?utf-8?B?MnR3c1BvOVNZYkxtV2M2a0NtOUVOM0wvaWNBY2V4UXNTb3c3aEgxMW84bmZi?=
 =?utf-8?B?L1NaVzFERlpWOEYwS3F2M1hwZ0lsQS95WklPTytZOWlldERyUmo0d1FuYnlj?=
 =?utf-8?B?YUkvME1pckprNURJQ2tZSWdRWHBqa213UldhVG1uOThXcFJ6eUU0ZDhPQ3ha?=
 =?utf-8?B?OVd4ZDNQRVpKSU9LdlJkWGZmWGdiWVg2RDNScDMwSS85c0N1NEFjN0ZwYUFL?=
 =?utf-8?B?MldMeGd0cldnWmUvbnRKRVNGQU5uWWw4N2hUc20xZmJpdHZpS0RkKzdhZktI?=
 =?utf-8?B?cCtZMjdMWHhudEZCcWNPaGk3dlAyRHVnTVU4NG9lTkdLeXI0VDhpSGk2N1B3?=
 =?utf-8?B?WTZnbHBtalZncWFZeXBvYy94QlprNjB3Rm9oUVl4dXk4SCtIN1FyMnhUbXZE?=
 =?utf-8?B?WHZYK2xsT1FTUEQ3c3NZcGFDSm5ObGlKUXR6akY1L0Z1RmkvQ1pYRDBvMzRy?=
 =?utf-8?B?bGxNVldqU2tYbUYxU3JFbTlhbEpwaVprWFIxQnR2ZHJzSXl2VTduNVo4NkNT?=
 =?utf-8?B?cndOMnE0aHZnaVhKdDNxWE5ITVN5cVNTbHArOTlsaWU4N0graXYvSFh0NXpa?=
 =?utf-8?B?M0pXei9TMGdPQ1dYWXJmMngyWXBEZ0MzajNvQm5aLzNKZWR5bGJhbHhHSGpG?=
 =?utf-8?B?ejVWTDNVdkU5d0NFWm01Q2JweTFGVnRmbXVPS1gzdFV6bEE0ZkNCM3pTOUx6?=
 =?utf-8?B?RS9zT0cvMm9JZGJwN2xGQ0Q1OWFzUFNFeDdQWnVnZU9jdWlLZTJYMFF5dHBV?=
 =?utf-8?B?NGNKUHh3Q3F1L2tVQlE0ZEkzQU9wemhVSHBsM1VsUWExTmRFRDFhVElFbW9Q?=
 =?utf-8?B?RUYyUEJydHhOQXp3Q1htTk80WnpSd1ZPV3pFU1pVVmgzR2NQY2w4T3RJQU40?=
 =?utf-8?B?Q0lSRk1ubEorUjBCQ1FDL2owaWdIWmN3Uk9wL3hjazRtOHgwTDhIVTlYU0NN?=
 =?utf-8?B?c0pyWGhkYjZGVnlYcnAvVDRobnk2d0hPNlpuZUxWV2lRUnphbUhwZnNyeFBT?=
 =?utf-8?B?alFrWlFwVFoyZk9vTk0vZ09rYm5IRExpbE8zZDNSWnJ2UUF5ZWprWWc0SlVj?=
 =?utf-8?B?aE1aZFhNeXVNaUVWK1hQNEMrY04yaUNCNEl5ZGdGdUhJZ2xka09tWVdEY2JK?=
 =?utf-8?B?R2ljSVVEdkFTYnF5aHlFeHlmZ1pUVU1BZC9tQ1psTWFnTkRtRFl6VVpxWTdG?=
 =?utf-8?Q?35hin6PZF2nPNzarfzT33D5GlDe+7vpRsz7bU?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f94e51-68d2-480b-020b-08dea48355e6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:35:12.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edeCMwGR0mPkORkPW8ltefIlv8SDcmpgtMhe4BVWmHbNkSyOd7VIy6UoIgcXoBPJaLMHmKjU6fzm9Sf3UOR9bL5/SVnKtlJ2d+o5Off7qCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 17:35:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19397

Hi Johan,

On 4/27/26 3:51 PM, Johan Anderholm via lists.openembedded.org wrote:
> [You don't often get email from johan.anderholm=axis.com@lists.openembedded.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> It appears that the crate fetcher does not adhere to the data access policy
> of crates.io as is described here:
> 
> https://crates.io/data-access#api
> 
> Namely the part about adding a user-agent identifying the application and
> information on how to reach the project in case of issues.
> 
> Also users are requested to use the CDN instead of the download API, as that
> does not have a 1 request per second limit:
> 
> https://github.com/rust-lang/crates.io/issues/13482#issuecomment-4304855751
> 
> This patch addresses the request to use a CDN and seems to fix a recent
> breakage of the crate fetcher. It does not address the part about a user-agent
> since I do not know how to do that, and I do not know what to put in it anyway.
> 

The crate fetcher is derived from the wget fetch method which does seem 
to implement a UA reporting bitbake and its version, see 234f9e810494 
("fetch2/wget: set User-Agent to 'bitbake/version' in checkstatus()"). 
The best thing would be to try yourself (I'm assuming having a webserver 
you control and change the fetcher to use your local webserver (or 
possibly even setting up a PREMIRRORS for crates)).

Cheers,
Quentin

