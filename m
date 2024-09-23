Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC7CCF9C5B
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 09:32:02 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web10.32717.1727083920607910365
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 02:32:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=mqM0vHNB;
 spf=pass (domain: cherry.de, ip: 40.107.20.56, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGCS/yWuCOrqaxuJKZTsVa+vPztHECF+n7d29zm9fJSybWNDHDOdgwvI2SAXakGt6j7ATXciJIIqm+Yq0kL1waDNBQUjmATnA7hNtyuUQU42ksGnwonJYPp4T2C7cr8N0Fupl/gWeO4DaX3IhpNWNU3re979ifiz8OsaMhJNZ59iyRK2cJaU5Y7UA41Cyhcm/0kX78P4P4lkQrvrrGEl1EMGYLG7+GcpXUL+dpDPwwUbrE67Bs9inKX0lgo+VUa1ITOTvtcVVd1OFnH6sOcWrkjeurzgKnuxc2FkRNIEP/AY2CsD6VmDql/i1MZeAvjv77eIzIfWb0ycQVmpfei5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9s1vHw3AsAjtdwYtGfAe3oADiZS+tmszz4K1j9NdMg=;
 b=JHkMqj0+LuEeAVJy1JgjWi9V2MPffXK/20KfL8DitM8/HE07qwSeoMpRe6vjdGl3s7Qyv1HGhZ2zD8FUeCaQ+08inLyoClO1Da0GOL+apmddWoroH7rN7F7l+4d3S7fhzJf614VbAMstoR93xuvE9CGfpfpyxWHpz64mw3K75+N1qFxGVEhzkBZNLC+PzJb3plMZYMflF55Ies2v1NrutT0njLKqVJL4hthLaeY5uP9MrQOMMNUo+sdKNB/3vGPPNJkGtdDYSnoneC6JYNWblZqk0MzDpTAvNNTDvpGjN39OOxn7t8O8ZIkl5khQWPYk/q+qn8e/wAajs8nJ8KAD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9s1vHw3AsAjtdwYtGfAe3oADiZS+tmszz4K1j9NdMg=;
 b=mqM0vHNBmmFj3qWEVwvUT/sLI0NGnUBDqye6IKpn7c2++gKylY+H6BCrwxJmbTU8yEbXp0A52Uf2nD81kOXzGYut6gv4DOmxp76Ip+sMXL8C/epx5IuA9NlbrsmFnVyMPQQk7ZV6Gcq92RAuz7z2o/yuW2LM2T/WAKG9vnmoXEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GVXPR04MB10518.eurprd04.prod.outlook.com (2603:10a6:150:1eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 09:31:51 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 09:31:50 +0000
Message-ID: <5eb7e737-37e9-4d6b-811e-4fc121dd6567@cherry.de>
Date: Mon, 23 Sep 2024 11:31:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH 1/1] bitbake: doc: suffix for BBFILE_PRIORITY
To: simon.eu@gmail.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20240920124020.2894006-1-simon.eu@gmail.com>
 <20240920124020.2894006-2-simon.eu@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240920124020.2894006-2-simon.eu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GVXPR04MB10518:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc50d5d-0ae7-49d3-9fe7-08dcdbb28da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S1VsSWlQSzhsTG9nY0FHVmd0Um5RdzZZd3U5UU9VT1FHTk9vbDJxUHFDS1dK?=
 =?utf-8?B?WG1XR2FxaXV0cTVuZjR2cVJxcXVLc1ZURUJma3czUE8xc2Z4U0RFOTM3WWRK?=
 =?utf-8?B?YXVocE5Oc21PL0VBbFB5L2JITXlheURLeXByVGxuOXc3Z3BqaXJsK2o2a2U0?=
 =?utf-8?B?NG5Id2NJVXNtTklEZEJqU2JkaXBuRWZzWFZ0UnhlajVtTUh4Mkl6MGZzS2RU?=
 =?utf-8?B?YWFodnBac1BkVCt1VzFqWTRyOGZOMHZySG5qeWp2OUd1djhpMmxLRmh5SGI0?=
 =?utf-8?B?a0hBWWRIbFFTVnZVYjBXY0dlK3RMaHdPQ3RWWW9CbHhGbEhwMXF5cCtZWHI0?=
 =?utf-8?B?WFdndkJZQ08veDlvZUJ2bDFMSGIxRnc2RTJTM1NEeG16aDBnQnBBRlBIZ1pu?=
 =?utf-8?B?dWY2b2RmaHpNaUJZREJUM2RPSzZ4dHdEc3NUS1IvSGV1NlF2Mm44dDJmQU9S?=
 =?utf-8?B?Qy9VTUhUNWk1OXdhQklTZk91NkduTXQwVXJGaWoxOHBGTlB1dzNDcmlZOENy?=
 =?utf-8?B?TVNhMkd1UTA5eEFITFNpekMzUlhQNUpSL2RFQlA2UzlFallza2VqcDJpSUZa?=
 =?utf-8?B?V2h1WE4xL1RleDR6TDlJL0dCV2FjWkNiOVNVODJ4QWl1SVpBUDdYbnhXUUNR?=
 =?utf-8?B?aFBqODMveHdYQ0svQktTalIwK1JIMkdPSVZBUVFibVBLOFplSnlPazl1b0Zl?=
 =?utf-8?B?U0g5U09QY041UDdmNFhVUVNDeXYxd3FlcUNlbUJsa3VSRTZZdWg3SzZvM2p6?=
 =?utf-8?B?OEF3T0R5MG45V04vbEhQN1lOSW5OeTJCemJsdW41c0JuYVZWUjhIUjZKVXRp?=
 =?utf-8?B?NDhuYXB2MW5FK3U1aXVZOThOU2FmSmc5L2FDdVE5NmNqM291aFpxUTB3UUx2?=
 =?utf-8?B?ZEd0c3EyRm9UUENJcUxrb0J4cVNNbWhMVFNCMzNNSGJwa0dFVC90YXFaYW1y?=
 =?utf-8?B?aW1vYjc4S0VEeTh3TVlsQ0ZsakVmUXhpNHJRV1d2SFM2OFlFZ1ZuK0g5dThl?=
 =?utf-8?B?VmtlckpJek1nOE1BaGY4aWs1TkNOOEx3R29ERytLNkdpdUwrN1o5OGxZaDZH?=
 =?utf-8?B?REF6QWVsc0hrSGN3Y1BJTVVQd2FjK0xZc2RjcFVuenlYVzh2UEFkMW5oUjBY?=
 =?utf-8?B?TFIzRDdVNHUzNVZSemRwTXdkeGt5T1k3MnlYdzBZdy91dFFJYVNXRVpNOHRC?=
 =?utf-8?B?UitQcHJYUDEwNXkvazRkUW4zSTNhdnRaeloxOHBGL3BHazNOMGV2L2lGUDdN?=
 =?utf-8?B?bnZnUWlkOHR4aUIyd3BFb2puVUMzS01rZHNEQWgvOWdEeWNsU1NEVytBajN6?=
 =?utf-8?B?STQ5THlKQ0E0WDFONWQvUVJua1pQdHBiNUduRC9uOEhjNWpVRmJGWUlLeWRE?=
 =?utf-8?B?NFlPR24zSW1UMEFmb1NPT045aVdtZk83dWNjYWY5R0NiYm5udzhUL3QvSE5M?=
 =?utf-8?B?RHI0T2o5ekhtQ0tlL0I3K0E2RVBpWWZtRGlYSHcrajZITkREaUJKUVVNT2dM?=
 =?utf-8?B?Mk01SVRsMG0yVThOd2tqbEJZRG4vd0lxOWFiN08vR2ZOdkZXMjlSMGh3UUND?=
 =?utf-8?B?R3BpcEJsejNlMzVkYkZrY3ZIWEJIVXhzZ0lRZDNwRkNsNHlBSFZzRnpTZ0RQ?=
 =?utf-8?B?MWg0MVlzcW9sSmRjZXJ4N2xrLzZQQStNM2swajlxL0pZd2ZEdDlOUDF3d0pw?=
 =?utf-8?B?anhHNW9lQk1mMkhmQ2hkWEhhSmtEeEN4SmpwakVsRWRueXpHK09FbXBCTXU2?=
 =?utf-8?B?SW5sNy9FN29xbmw4THNkYlFlMkoyYUxEY2NXd0RYOUxiRjI1M1lhM1hYd0Np?=
 =?utf-8?B?Tit3Znl2eEtMdXIxcmNPQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlozTGRzWVlOVXI2cG5Tejh2d3NwWWZzY05mQ3hGNFJVZmZXakpKQ3MzV2VF?=
 =?utf-8?B?LzNOeEVxak82MXl5dlJ1cUQ1Y1dGeXkvY2p5UkpOdytiTVF1KzJiL1J2ODgr?=
 =?utf-8?B?QnhQS2dnRUNpVlBDc1FJUXNOb1BEcnB0QU1keXJKT0c0QXNEMENBOFk0dUM0?=
 =?utf-8?B?RE9IaUpMVFg4NjI0YUE4akJXUXlWRGNBa3NZdm5wakJyVlU0ZzQzSW5GZjRl?=
 =?utf-8?B?TUR2RWcwdlVrbXR5dDZFRlBtQ0NLT01CUEptZUVROUxkME5UTUw2TWtMbGpS?=
 =?utf-8?B?c2hrUlg5UFQ1ZnM1N0RqQ3B0UTgraThDdHhablJZS1VzTm1OdHJjbTdKQkZo?=
 =?utf-8?B?ekJHeGxGZGtyL1BtT2YxM3VpODlpNis4NWU1U24zRmQ2c0F1T1JRSzlLVzRq?=
 =?utf-8?B?NnBFdURWNXlDVUZITGdoaFZaYVU0TXJZdjBKSklqeHRDZ3JRWHFyT1Y2NHVG?=
 =?utf-8?B?ZjRRSkZXMDJHZ2pEbVdHTXR4bXdRcHpHZ1d6bDVmQnNaRnVmQjhaL0g1bUNv?=
 =?utf-8?B?djU4TWZNL09CY3RieGoxUWVtaFJKc0o4NVE1bDBDRTZ1QmozTzhYbVZuZTZQ?=
 =?utf-8?B?M3BkVVVlOUJ1cFV3eEVDWlFYU1lFWmhLUE9YaDZ2UWpsS0x4Q1ZMa0xBRVpw?=
 =?utf-8?B?dmg5VytJcW8xRXhqazdqcG1aUk5aSlZpeDI1TXFyT0ZWM1BJQU5XL0gySUhU?=
 =?utf-8?B?dHl2d1FWVUU2b3l5M1ZnMjhjdGVFK3NwWmdMb3dJSWVpeGc3TWRJSmY2MXFx?=
 =?utf-8?B?a0hvbFhzYnd0TFNtRnFiZ2NrdjZUSTFFMnNKR2lJeUNodk1rRlpCblJObGpU?=
 =?utf-8?B?TkI4MEp0VXJtOG9HRVcvcFdoZEgyUHdGTXl4eTk4NGZQSHhrQjQvTlNIS3cr?=
 =?utf-8?B?ZlVKWTBTT2hMRVQ3bER0dnBGYkxZSEM0RWN6OHJSRllvd1IweEVjREkxRzdp?=
 =?utf-8?B?UDZZZEdJU3VlcVRXS1kxZGdpZDJ0SWg4OXRsNHFGUFBFbEJySUxXTUpPT2x4?=
 =?utf-8?B?YW1qVXA2b2tPWHB6cHBvZHhrUUxHYjJzK05vUHNWKzFmdnN0VzBNUVhMQVY5?=
 =?utf-8?B?ZU15QmFkUWwyL0I2TTB4RnI0azBlaWNPNncyK1ROMVB5UUhQbWZoZVNobHNM?=
 =?utf-8?B?Y3RGQzlqTW81YXVGM25mL2dJZWhPcUgvYjAzcEVGSW1ZQ2RnTk5DcU1LUGJh?=
 =?utf-8?B?aThQWkZCck85bExVZzAxV3BTNXptMDIzbzBtU3RJQ21OQjVLcFR0NFBCSHp0?=
 =?utf-8?B?Nms3Sk9pNDZzaU9NREdxRzNlZUJLSloyZnpzOEhJYTNWczVPaDhtS0Z6WmNv?=
 =?utf-8?B?L1VWUEhjc2hqZDc1dlB4cDM4Q3hGeTlQb2RnVlZZOUxzcmRFVW1icTNNNDg1?=
 =?utf-8?B?RC9rVkE4Tkp0VzlTSkhqaVhJb2lRUkFRb05VM1ZFOHVoOXNBMXpTQ3l0REJE?=
 =?utf-8?B?bkY5WFB3YlZrazd3S09JNWxjQlY1eVFnKy85OE5FUDNkajFDbzExZlpEazlD?=
 =?utf-8?B?TE1KR1lCWDVHZmQyOTBib25PM3gzVU9IZW9LQ1h1YkFVcU1tcTlkY1R1by95?=
 =?utf-8?B?Qk9DbnpsL2R0YnB4bWRVUmFBZis4Y0YrbUcyT2d3eVFTRlVleTNkbEtvNDhL?=
 =?utf-8?B?TEpJd0NxZ2RxM2dQUzQ0azBOL3lmd1dHMVIzcWtpbmkzMGhJM3drd0lBa1Z1?=
 =?utf-8?B?Rk5kbXB4Um81YzdmcEt0QUVIR3A0cGV3eTNXbzVVQWJyNVVnNmo5SUtIZkNO?=
 =?utf-8?B?SlYzNCtjQVVrcnUrSk9FSVdmZTdGZGV3SjROY0ZCOGNnenR4RHV1WEJUMGRs?=
 =?utf-8?B?Rk1tZGVENnNPVlo1N09kNVhRR3ZQZlZ1WHdsRGMzV3ZTT3k3V2V3ZU83N3RT?=
 =?utf-8?B?TC9DbFc3cGV5SEcwSEpERzZOeTNmMm1yWTEwWUZhUWo0TzBvZExjRkZKeUpm?=
 =?utf-8?B?M0JSNy9hOWJrNXIyRDZYLzYzdnFiM1VYYXBCR3ltR2pRTDBWOUZzR1lOK2J1?=
 =?utf-8?B?MDFDVStKamVIZWx0UzJTZE0wNzhjbmh1NWl6YjkzZU1VRTNwVnVXUXJvRm5t?=
 =?utf-8?B?eVJGQzl0dUE1TzQybGFPaXBGODAzWlI0d0hZR0l2bWZOenR6NG5JU29DN0FI?=
 =?utf-8?B?SHQxSkQ4dFlPTlNCMVdSODBzMVZva3F6SUhBblRTM3Y3dFF5OWdnd2tocjJr?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc50d5d-0ae7-49d3-9fe7-08dcdbb28da7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 09:31:50.8902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CHP6GnP4wczQ72+rCmaxjyBQ1tvKo/UFnaVSBLs75Cq9S8PCFHWPjwyk0577YfOwRCCEB6oEBd6AG3XnnF0eialdoQ2tGfDUZXwmm9RB0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10518
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Sep 2024 09:32:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16588

Hi Simon,

On 9/20/24 2:40 PM, Simon A. Eugster via lists.yoctoproject.org wrote:
> [You don't often get email from simon.eu=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 

Please try to always have some commit log to explain what's going on in 
the commit. It is useful if one does `git log` without `-p`/`--patch` or 
if additional "metadata"/context to the code is important. E.g. here, 
you could have said that you were confused by the use of the underscore 
instead of the colon so you are now making this explicit.

I don't think it's warranted to send a v2 just for that, just think 
about it for your next contribution!

> Signed-off-by: Simon A. Eugster <simon.eu@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

