Return-Path: <jhofstee@victronenergy.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61498E7718B
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 08:02:42 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.90])
 by mx.groups.io with SMTP id smtpd.web11.9829.1734940955460301369
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Dec 2024 00:02:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@victronenergy.com header.s=selector2 header.b=qsA/ZSh6;
 spf=pass (domain: victronenergy.com, ip: 40.107.249.90, mailfrom: jhofstee@victronenergy.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRlXI3YW60b/XBnGP8ixXiqNQzgcMc5GV5S/Bzlpqmy+6aSzvGN1+iVHJd7dBTB2/9wg1sAN3zKeuJh9rqkhEUkUb9Vrl8W3kkAEEHP8tar6Ju/RktLcb0pHEm1F5LRjAJKokfexkSUJkHtduDSHZ3BghzNUvObr79NlME35XHtfldL5eLOnyJdwItCk0ycUguyKjjZ+uwPBv5aLWWZrbBCBiPt8QmQkS5sJQ7A+etPGYCQYlpjI/nrOkNLttTNJZzAumYyUvFJcWFsWdlg9vXnFTNrAtgoaVpjnbk+EnejUTuneX6ei/jRHGy5yV4XSOkIALP//RQxIbCaYKx8aYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIz1fPqiNsOZYNiQ8b65VEsHAT1o/J5dsplw+Wt2Dns=;
 b=kok0c7InTt2x5cAx0t88gFqrxTucK1lh3Ve0fS8uLMct84h4SsnpOfRGuxtdO7p41KUSgYERfmOXPeKiqsJbvPnqUt2SEeaB8zcjdAV4NlnkUsmdre/+0bqGys2W7jRSyZ7eNmUeiVuY+JCPQfHnIdrQQMP1E+MAzbYp+NwPqRf+MgDcJEK4kILOwysfZHD+2Y0EBgkZO8g9zl2s66eZ+P8uxXdn79iYa4ayqdJGtVugXlYOvNYfoTBQUzkOBE6MrX6W51cyEdeTvVKwgGJyzSQD4hElJdEb8lOQ1U8qURZJrfEUddq6xopm0+O6n6Mv5YxDCo2+nmzieB5eNuNLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIz1fPqiNsOZYNiQ8b65VEsHAT1o/J5dsplw+Wt2Dns=;
 b=qsA/ZSh6cWOGVw9knVbfJRFezUXUyVIQCzNdqQeaSOZvcP1xKuNWq0ZugqDBw4e6vMpi795vf9twZj8xZnngd9rcKgTJ/hh+9YHOzOnHprv4zQ/JGHvkr6aSslnxLcX+wyg7gZo7h9S2B7uDYqmU5GgDtVI+1fY3xEfM7do/CuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by PA4PR07MB7342.eurprd07.prod.outlook.com (2603:10a6:102:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 08:02:28 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::5b79:28d3:a16b:4fd6]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::5b79:28d3:a16b:4fd6%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 08:02:27 +0000
Message-ID: <3a71aa13-9b15-4d81-908e-73905deb2d1b@victronenergy.com>
Date: Mon, 23 Dec 2024 09:02:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake][scarthgap][2.8][PATCH 1/3] runqueue: Fix performance of
 multiconfigs with large overlap
To: Steve Sakoman <steve@sakoman.com>, bitbake-devel@lists.openembedded.org
References: <cover.1733344286.git.steve@sakoman.com>
 <db083cfe9e33c9fd7ffeead7b8c6023a5d581976.1733344286.git.steve@sakoman.com>
Content-Language: en-US
From: Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <db083cfe9e33c9fd7ffeead7b8c6023a5d581976.1733344286.git.steve@sakoman.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::36) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR07MB8679:EE_|PA4PR07MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5ed21e-0e64-4c11-d5b7-08dd2328249b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WlZRRlhVNW9aSFFBSmxvWVF1RDcxcWVLMGE3eHlraGZQTTRNMGtadXNkVkkr?=
 =?utf-8?B?aXV4U0V4Nmt4Y1Jjc1J5aXF2b21ESm00ZTFuVFdrVUpSZUQydHNReWdTbmt3?=
 =?utf-8?B?eWhBMHkwN01rbkdXWWx2N3BkTWZYd1FEWWo3UktsYXJ0ZUYyZXpnMlVScHlO?=
 =?utf-8?B?aW1nSUUwTHpOd2owSGoyQUNTUWhNUjdpaGF5NVJvb2pydG1PRnRIMkN2ZWp5?=
 =?utf-8?B?NnpKaGxheE5BZmF4cnlUd0RDL2l4Q2o4TldCMGppYXkzaGpRNTgrbU5mWUhU?=
 =?utf-8?B?YjRadlpVcXR5MStMRUVYNlIwdWFDNFBURjBzSUlSWWFaaDBmaHBUK1JLN090?=
 =?utf-8?B?UWcxVlJrRmx0cC9RVUFCMzZaM01sZ1lXSkZPdkNlK2U4TSs2V1NGak1wWFNR?=
 =?utf-8?B?RFF0MldyZGlNL0RlWWxUUjc4QTlUUWl2dGZUcEVvNjIrUDhNbk5ZYUkzVDJI?=
 =?utf-8?B?RnAxR3Nka3orY2tWUWNmWkhFa0pCUHZvSjVyZ3hFSkdMeVRyVis2bEVBaXV6?=
 =?utf-8?B?WmpIZXNBLzlvNjZqdVAxaCtuWlQzN1FTUUwyb05teER6RVpxWElaRklLWmhk?=
 =?utf-8?B?VWYrdDErUGRFK3JqTUlSWFIvWml1R21GWExxYkgzbS9lZTRUeVRtWGhWeTZY?=
 =?utf-8?B?dERNWCs5WW1kTnRwNlpQdnEwNmQ5K2tSMVUyTThaek42V0VlbWNNY2k4RjhE?=
 =?utf-8?B?V09UMWRXOE45T1hBU2RTMkFxa0xOT3JvV3FXcjJOWU1tU0pCdkZZZ0I2L0hL?=
 =?utf-8?B?dVN0ZVEyM0pTQTVMR0VlMjgwZXJidzZJR3lBMXlqbUwzWlJyZTIwVTVKQlcx?=
 =?utf-8?B?bmpsQ2RBUTVzYlB5MmVoSUhLOElMYUVSdEI3NmxmNlVVWjMwQ3E5b2R6Nm1z?=
 =?utf-8?B?L1ZXVlF1Q2xUK3h5YzBZQ3RMYk9uRDJNei9hN2EyMlhRS01nYTcwc2JIMXRX?=
 =?utf-8?B?UzZoelp1VldiZm9FcjcxMDFkaG4zYzc4QWk3T0JvdGdJeHRxY2ZYL1lNalNH?=
 =?utf-8?B?OUdJUzFGekcxSkYyQkdjbzc4dmd6bVd6WWZoeExnL1pJb29jTHJiR2I1dkRU?=
 =?utf-8?B?cnliVU9XMmw3clI4dkFHMjMzTHYwYjJxSVJRMm1qS3JLK3YvKzk2MDJuVUxo?=
 =?utf-8?B?Q3hPZGNhaTByTXVLdUJvK05wMy82bExDdk9wRnBTRWMwWXdjVUFZamwvcGVU?=
 =?utf-8?B?eER6T3padXBHNEE5ZERUR2F1SDV5U2tWZUtHL0xINlFSY1JjQXNyMU5hbjRa?=
 =?utf-8?B?TlprdEQ4bk9tdExYUWFreldrTmI5cUJWQXBQUFZpYnVNcmg2SzF0NHhldC9o?=
 =?utf-8?B?RnBES0FBL3l0ZlNYdHpWSThGdUhiY1Bva2N6dWRMdXhFbW5aTm9paXBxd1Y3?=
 =?utf-8?B?akpNT3BDdFlSYjNjS3k4WUVjcnd0UWdjRDFDWXR0UWhNbmpFdnNFUFNOakRq?=
 =?utf-8?B?M0lUTGhPM0c5b1VQbDJHNW1kR2hXTm80UDdCNnpvelZmUko3bVVieEdpNGpC?=
 =?utf-8?B?RmZ6VjFpUW5Nb1hUQXUzMm1hT3lNYk9IeUN0eHJJQmxDUVd6UWR5NDBWSEQr?=
 =?utf-8?B?SmphT3kvUkJDTmJxREpjbGdkRnNidWNFTzc4WmhkSUkreklIUFNReUw1Q3Rx?=
 =?utf-8?B?QTN4WWZDZ3lTNmFJQTJmWG1IY3k0aldDa3NjUUd6dnZvU0tGOGRMTzduNFZ3?=
 =?utf-8?B?UXZFbzRtMkhrOW9ZRFlxTEtHNFZ4dy9kZWhVODY2Y3lUS2hxYmJ4NW5RSWZT?=
 =?utf-8?B?UjB1UUhyUGQ3YzIyYm1memtlWTZvbzZ3c1lGYzhNa2lXQ2Yvclc1ODBockFU?=
 =?utf-8?B?NUl3a05iTTYwVG4vbFZuZHI2V0lETkxXbVVlRlZjSURQSytQaklSRW5wdTBP?=
 =?utf-8?Q?kB4YeaWXQApUM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnE3a3dVVmozT0FSM05YRFBaanhqeTRQcmhuWWZFV1dPRDNvdWZrVDlyeU8z?=
 =?utf-8?B?Y2t2bXAzU3BwYzRYOXZmVkM2VTlhTlExTVFEK1VVU2xsSzNURXJOS2ptTjZp?=
 =?utf-8?B?Vk16djNVNXFZbkNDR3Rlc29iTHJjWmNFNFhZWWRWbjEzcHlURDNjUWUvRHlL?=
 =?utf-8?B?by9rOTRUUDZEVk1BZ09DZ3lwQWdkcVJYMStGdzlyeFE5Mkx6ak5WdEd1dWo4?=
 =?utf-8?B?WkdZYnFyWGZ2MnZ2MndqUmN4YjcwaWdLSW1ybXBTYkFKMHl3V3RHUHVWMW45?=
 =?utf-8?B?Y00xTXNZdUkrY2d1YU90dHAxSW93OXJuU25ORi9VS2tVcDVGU2hWc1Zsc3d1?=
 =?utf-8?B?dnh2SisvMithM2N4NjRuUG1oU0RBNmRUOGtlbXFPVG9SaTg4bXcreTBtbTZ5?=
 =?utf-8?B?NmpHSkxiWEF6Z3NXTzVZRzZ5NkFTVVBoYUlOQmdYMHNVRVY5QVk1UTQ0d2Mv?=
 =?utf-8?B?cnY0UE91Z3g2V0lWMks0YlRnQVc5VG5iS0ljNlUwa00zMTF4cm5GcTBwUzRR?=
 =?utf-8?B?N1hFRlpvd0w1VHdKMXp2UXBPOGxCSzRndzErTkZlblJhcjk3aW5DZEx2WTgy?=
 =?utf-8?B?NUZybnRGMWdJZ0Fpemx0d1YzZ0x6cVFtUDBaS3M4bDRlZ2s3QWc2WG9YVWRr?=
 =?utf-8?B?NkJFR0NCY0ZCWXhOQ0J1R0lMSzlGY2QvWVYwV2dQNW94Zk1ySXJWVGRjd21J?=
 =?utf-8?B?UkFEVS83ejV0eVpaQUNzQ2hxSnhEN3NiYlJyR3lMMk4zY1dtdnI4V2RCWW8y?=
 =?utf-8?B?OHVvY0ZRTzBKSm5UZkIyRjU0cFNGQTJ5cUpPM3RXMUdOakJUZEFnVVAyU3RM?=
 =?utf-8?B?OWhvamhJMWRnalpCMnlLUTdCK1NLOVgxcHpUT1BZd2kxbWxsWHU5UnlGV1Ns?=
 =?utf-8?B?VjlNNHVNMllyRGhyY2QwMVJRUktVYng0V2o0S09nUkZQRks4bWlpK085SVNy?=
 =?utf-8?B?eGVDUkcxSnVkQlFDLzE1c0ptQ0pwbmJhYkZzV0JHUjBRZFlxbEs1M0hpOWdM?=
 =?utf-8?B?MkxwMldHUVJ0ckhLSE9Ea0N0MDdYNzR1b1o3MzlPZmhXb0RtVGYwVXVKQkE5?=
 =?utf-8?B?MEVGSERuZzJvWlQza0FGNURVWDYyMXp3di8yU0ZvWktUSkNTOEYyeEVzTTBL?=
 =?utf-8?B?QmtMNVFVTExEM3J6SVdxZU5QQnBYMVVxQk8zMEtvNk1rNTZRdjQ2QXJFb3ZK?=
 =?utf-8?B?VzVWdytlMFMvbE1YOUFQL1FPSlVhdS9WSHRXbWdGQVhTSTN0NlovVmhlYk1v?=
 =?utf-8?B?NlhlbTJCT1VlRkI2ODhFMHhiN2k2NEc4YXFrTkdQZnZ0VnNPdFg4NHJJbVpq?=
 =?utf-8?B?eDNkVGdoWEFyVE1naFQwakZHdVNDWHF1TzE5MURSaE05Y2k4MVFlaElta28z?=
 =?utf-8?B?bU5sem1Hd1Rkdyt3bTNiQlgzUEpudndiN2JYUDRzd0FuUE9WWFRBczg3UGlV?=
 =?utf-8?B?MFRkeWxiTlBwcFBULzZxVjJyQmEzZ0RxMVRhR0ZkMVhsUDNVOTFQZ1M2Z2R3?=
 =?utf-8?B?RURJV0FEOSs1L0M5TnA3RHo1MWVhNU1pNkttSHF5VEVFMkVRRFI4ZkExajlX?=
 =?utf-8?B?cHBaci81V3FoSUxEYUpxdTFmTFRleVd5TWYycVowZmt0M3FKNVpkT05qdE5U?=
 =?utf-8?B?dlZIcXNaT1dwQWIyUCtYSm11WUxuSGJtOTUvaURab3UzeDVmby95cDBONUNS?=
 =?utf-8?B?S3MvUVZvMnk0UmVobkErTFVaanZFcTZxMjBwQ3d3MER6VWdhZ2ZrZGFLUm1v?=
 =?utf-8?B?RUhpSUZUWDRBWHF1aWVjSXRPWW5DeXFaRE51SkxyNmdVemFyZi9xM3JiaExr?=
 =?utf-8?B?dk5EUENKZS9UTUxBcWRkS00wcmwzek1MOGZrdnIwUWN4S3pWMUs5cjBjWlpR?=
 =?utf-8?B?Y2FMSFB6RHh1RkdZMWRmOFA5ZDBneGZKU1QrbWl6bXBVUjlZdUJhUWpxUlFq?=
 =?utf-8?B?aVhPUkhwSHpWMmxZdlNZbmYzWExNWVFJUlZEWFVJNW1MRlYrdUhqRytXSEFS?=
 =?utf-8?B?ekkrd1FsUGIzR3pqTmxRZ0xrakJSVHNPeU4vdzRtNXl4VkR3RmN2Q2Z3UUNT?=
 =?utf-8?B?RU1CbjJ6QTN0QmRPbmFoMWI1YlBrR01COEhxZ3hMWEZscFZLcjYxRkNGMGF5?=
 =?utf-8?B?blBQR3lFMWE1UmFqY2crbTkrcWprZ1NwWFcwZ0NpM0doZFEzZTB3YnpwV2J4?=
 =?utf-8?B?bjhpeVJ5ZElZUDlkd0pyVkpkNmcxY2pvSHdmdiswVFJ4N3l2dzIzS1UrZkZi?=
 =?utf-8?B?UTFmc0s2UlRkbDgrMXZTZFpqdzd3PT0=?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5ed21e-0e64-4c11-d5b7-08dd2328249b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 08:02:27.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73FyKHeoBszZ38b4syxYBcZvJciyqJUJeHfBvKKsQQOHHkM6lerorVqhY8aaQ57r0/Fs7WBLFnBSvj7Eat6h7R0qR1i2o4aCuFRFdnHV8Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7342
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 08:02:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16942

Hi,

Op 04-12-2024 om 21:33 schreef Steve Sakoman:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> There have been complaints about the performance of large multiconfig builds
> for a while. The key missing data point was that the builds needed to have large
> overlaps in sstate objects. This can be simulated by building the same things with
> just different TMPDIRs. In runqueue/bitbake terms this equates to large numbers of
> deferred tasks.
>
[..]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 9c6c506757f2b3e28c8b20513b45da6b4659c95f)
> Signed-off-by: Steve Sakoman <steve@sakoman.com>

Our CI build uses a multiconfig setup to build for 10 machines with 3
different archs. On scarthgap with bitbake 2.8, that resulted in a
really slow build:

NOTE: Executing Tasks
Bitbake still alive (no events for 600s). Active tasks:
Bitbake still alive (no events for 1200s). Active tasks:
Bitbake still alive (no events for 1800s). Active tasks:
Bitbake still alive (no events for 2400s). Active tasks:
Bitbake still alive (no events for 3000s). Active tasks:
Bitbake still alive (no events for 3600s). Active tasks:
Bitbake still alive (no events for 4200s). Active tasks:
NOTE: Running task 1 of 79788 ...
[...]

After almost 14 hours it was at 'Running task 8881 of 79788', and I
canceled the job. The cooker was running at 100% cpu, but there were
hardly any bakers running.

With this patch cherry-picked it builds successfully in 3h and 20min.
(I did add INHERIT:remove = "create-spdx", since it triggers an sstate
error causing the build to fail)

So this makes a huge difference, at least for a setup like ours.

Regards,
Jeroen


