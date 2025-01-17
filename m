Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B883C02185
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 11:43:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web11.9056.1737114212875384462
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 03:43:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=jDqdGNYA;
 spf=pass (domain: cherry.de, ip: 40.107.21.55, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SClSyuOLdpYbXtKj3eq04A5/IUdiV9KcTDkYSS3nKuc4zKNsxc0vqfcaYDVBHCCeJnjue1/g4voSPTPc2AV9rUVn9hWO3JjDYOIQY9b3HsDALX8skid55FlXJLvRrBAf2ytXWuP6d9XRk6S/R4q4wvA1Sfr3gPs6CuEs/MxvSD72aDYndlJ8qGebytb46jvn8uLDthEtdNAWaOD0FVFTXX/K/fJRG6QZy2NtiNqA/uZ0Gdz4GqZzZyW9k1mKy0hUXbv8hnw+w0iCkJ81XDfM32TuVycSGZImmM8Pfv8HXARb3R7rRB0NQQxhIu3iS40u/8pXpiZBqXb6LE+3/N/p5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKr7mXdSSEaJF/CPkp2e2I6zRaVG1VoeuYXLUcZo2vQ=;
 b=MHcHrZFHq6Hejs/gGCzbCzqbnx/YJr39CClT+XHp2m94A5UP9r4+xmCgr3hTCu5sR+k7fxbozOA7/hFVrJvQ0iyiTQP3pQ9J0WDMKgfeNpcy0GWMopTI3iYnvJ6F6Zzn/BeN8e+wJi9VqzdPfSA1hjWwhDkQFpuKNv+rnHZnYf4BZXCbh4U+PMsAeKRsgUXOPYTNFjvWmUhnaFi9SNf2uIzOfye/1GCpYXnB14tfP9Vayekhn6vJg083xkmY8gCSwX6RBhNC+bmXYlGR+flCmSQlk9iF0wORB3lOrPlrx8IiuAFHM4oTaUNjqENlBPcK+fGS9dDNgO2IJe382GT8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKr7mXdSSEaJF/CPkp2e2I6zRaVG1VoeuYXLUcZo2vQ=;
 b=jDqdGNYAwWorJXUV9sumObcZEkW4ndYr8uU+gwF84NSX8WqBUSdfDZqDoTelsaoagffyUHBYe6ULlFr3eFNwA/cpr7Kk9jxmakqbOQ2dQDN5WqvF3QNdOxzBNrrvwrwmb+5OOBQsXOF5+yIeHnl3zSqOUIuLPZ4jIBBD9VK0MTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8257.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 11:43:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Fri, 17 Jan 2025
 11:43:28 +0000
Message-ID: <48f94226-eb4b-4d7d-b007-d7b57975a59a@cherry.de>
Date: Fri, 17 Jan 2025 12:43:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] add basic support for b4 contribution
 workflow
To: Antonin Godard <antonin.godard@bootlin.com>,
 Quentin Schulz <foss@0leil.net>, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
 <D74APENZ2FY4.2W3AXB39KKQ1D@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <D74APENZ2FY4.2W3AXB39KKQ1D@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fb601c-a328-4dc6-a30e-08dd36ec2929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NmZ6cmk3VHkzSHE5bWxGckduVWtmc2RtbEV2aFQ5dkR5QnVTSE5CMjhLczhj?=
 =?utf-8?B?M0RXM05zMmpTQXZWZmQrTEFSS2NjTjQvTGFuYURuNkpXcFBzckNXTHpDU2Na?=
 =?utf-8?B?R2NJbHBUK1h5R1VOL1FFR3ZkZFowck9yT2ppd00wSmtMSDVZQTY3Qk1Idmhv?=
 =?utf-8?B?dWZmOTZRV1ZyMVloMldlTy9mc1ZORWY4RUN6bGN3dE9aRWk0bTNmdVhZSWVv?=
 =?utf-8?B?M0pzYjIzTjM3STMrYTRvcDUwc3gyeUpVZTJudWhMODFRZG40NUtHWVZLUVN0?=
 =?utf-8?B?YjROWUVOSC9WUlVML3p6MzNsWnVmbUNIWFpZeVE0MiswVVFmNjRqYW90YTA5?=
 =?utf-8?B?R3VUUFM0RWpoY3IralBhV05QV0ZuaDVnUHg5Z3ErenRoTHY1MWFwSEFXOGp6?=
 =?utf-8?B?Z3RzZUd2cGN4QlFSYWN5emUySzhyMC9IaUJ2SURuVFFwWnI5MlZxL0NxcXRa?=
 =?utf-8?B?Q3M4NWJaN0FINXhLOGFtcXFhbFIvVUdvYVE0cXR2eUh6Wm1UaXpXcHk2dVlH?=
 =?utf-8?B?NS9XckRpRkxia0F4a2IrRVF3ZHRRRHVjbWJtOGExZUx4OEtsa2t5cDduT3Jv?=
 =?utf-8?B?anJiN2hnUStFbXZKTlFrRjRzQ0dBbW0vb0dBNzdPR3ZuODBFTlRTR3NzU0dL?=
 =?utf-8?B?TEZ6TEFyNDVWVmZqS2MzRzA5RlRRTDlldjNQa1A3NnB1aStMd2d1RXdKRmxC?=
 =?utf-8?B?bUpaa2ZGMC94ak8zcUhTa1NlcEhIUllMNHVjYSthaHRObGJsTkcza2x6ekxS?=
 =?utf-8?B?enJSVHI3cWMxN2Y5WGUvNGMxUTRsaXNiV3dpQ2FBMEI0b0xWMFFVbE9CNFU4?=
 =?utf-8?B?dWlzaGpUanBNQkpGM0dtSjh1S1hPS2VDYk1tN1Y2b3FBVVlRVlFCK1IxWUUy?=
 =?utf-8?B?cTJJUEpXSWdyZXF2T3VGVllRU2xEUFA2cFVsOW1KaHVvTTROQ3RhbFVaRHhv?=
 =?utf-8?B?OG5YR3lzR0tKeWFteUNHK2RlOUFUZ3RrUGk2T3lGbXh3L1NRcG11aDRnMHMw?=
 =?utf-8?B?VmJBSTJWODVhaHNtbzRheE96eWFURVRBNUJWZ0NLSmpVNnlEa0RjWjY1eDAv?=
 =?utf-8?B?c3k2ZmlkTWZkNXJTbVNTTkNXd1VCS1czYlJYaURNWk0zVmJXZDNHWkZBNkUr?=
 =?utf-8?B?NDR6SklvVFZ5Y0J0eEE0a3FoeDNMbk9FYnRBdllGL1o3Mk1ENXRnSmErWHRY?=
 =?utf-8?B?YTNhWHhQb1pNZTBjOURtQmp0aWEwWkUrS0t3eWx5cmYzQ0hKQnhwZzV4WWdu?=
 =?utf-8?B?dlNCcGw5Z0ZmbkZQRlpGWnBzU2UvTWtiWDUwVFhTR1p5NXllK0RTYWFqSmEx?=
 =?utf-8?B?T21EOEtLR2xJNlJ2Y1ZjempzOFVNWWFsMGthalEwTG5oc2ZVUG1CSWJpSVpE?=
 =?utf-8?B?eTlsOU9na1cyUy9WOGhzcWlpTDNuZlg5M3NnYWdpUVVHSk80K2RuS3N3WDFo?=
 =?utf-8?B?eE9KNmxRblIza09qUE51czV4REVpVFFmV1JnK2E5emQ1SHJlWFZLblI5RkNO?=
 =?utf-8?B?T1AwZU8vVEJHMVhzWFRPdGUzbDFzaXZDTlFWalVkQXBpVGl4clI1cUx1ajhO?=
 =?utf-8?B?dUc2YjVsbW4wZGdoS0VNSHNIR1RJS0s4OTM5NDNMN3J1M3NubnUyMExMdkVH?=
 =?utf-8?B?TTZGTEJ1VENqZ2hWWm1iTlVyazhNWVZGaWhWWlNhMEZCaThZUjRtUHhDUjhN?=
 =?utf-8?B?Y09LSER2YXNSTUZmUExiZFRrQnpSY3VMcStCcDc1Q0xtemVvblNJdXdJckhj?=
 =?utf-8?B?WDg2cHZiaS9SZGxyMGMvZllkZmN0Y0ZZN1ZHSWZNU0kzU0FaL2p1MTU2YkdW?=
 =?utf-8?B?MHI1L0tzK1VmLytnZEFaUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEpuVE52MTRVZUZJSDJNWENVZ3ZVMjNPYVpsMXRUZENYNW52eDNvK2ZHZnFa?=
 =?utf-8?B?QzJiYzVzdDUvT3VyTjRZWnpjMTlZYVQ0WXE4SEl1YStCQTRCWG1NZERPZk1H?=
 =?utf-8?B?bkFFblQyVTZHbVdOZ3duUTBZNHJhK0NTUkZPaDVOTUhBMEpvNWQrSTVBMkgz?=
 =?utf-8?B?ZHhwd2lFdDZQcnZUM1JBUUVoTy83ZFFVQ3FBKzYxSlp6Y2pjbVZvN0U5bHhr?=
 =?utf-8?B?UEcveE5OR2pyQXdySUJ4cUQxdld5WTI5My9UM0lUOVhSMWhNc2tzWmlZTWho?=
 =?utf-8?B?OWZhU2xOcis5WnkxWURtWW5RSHM4NGx1V3U4b29EYUFLczZqTWdtSlVIMGRH?=
 =?utf-8?B?WGpJNmVtdzlpZUVsT050N0x2Q3pQYUZHV1NHSHdCdy9TZ08reDkveUswbFRK?=
 =?utf-8?B?U0pDVDloQnhIb1ZBQ2pWNzdFb24vS1NnUS93KzRHbTN2a2NBdGF2Smt5Rkhq?=
 =?utf-8?B?b3VSbGZ5YmFoVWN4VmZnRmRoV28xSlpsQU16R3RZK01KdWF5WGlFajNpWGtj?=
 =?utf-8?B?WU1OOG8wN1BGRCtQRW0yWlltVmxQQnpYZ3Uxc3FXOWEyTWtEUDYyL3ltdzBE?=
 =?utf-8?B?dDRRZHBxaEtMclA4d0JXTDNwOFBKcnBxbDd5WFNhQ2tkSUhLUVl1MVZTMTNT?=
 =?utf-8?B?N3o5QTlnaVZlT2lSbG1DRGRGUW9vYmNNMTd1cjYwWnJXVDNZd0V4aXpIa3Nx?=
 =?utf-8?B?dGtXZFlPL1VGUjBjRndOMzRSdDkzUTBrTStPTUUwYVI4emFCQTNoZnJCM1Ex?=
 =?utf-8?B?UUJRWFYzWlJwZytBaWQ2U3ljc3NzNkJ0Y3JqUHBqaXBiUXNWbnprNHhqZmxm?=
 =?utf-8?B?WXEyWkhnVlVySk1GV2ZYZWpJU2tDL2MwazdQa0RsT1krcFRKaDJFU1Nndzht?=
 =?utf-8?B?ZTFNY1dFKzlmL3didDV4cW5QaUlWUnl3VmpFaE10YVJqOEVuTkxjTi96azhi?=
 =?utf-8?B?NGtwRzNUQ2hXeXg0ZlNqbSthR3NQOE5mUEtORmhxTnpkTVNBbzNqVS9Hdm1z?=
 =?utf-8?B?QnBkRnBWcGpJeDFxeDEzc3VhWi9udnI0TDhXNUhlM1VuQkY3T3Q1dThiamVM?=
 =?utf-8?B?U1RjZEE3OWVDaDlxTW96bFVaRFVDN2pQS0hzYkc1NUZGUHVyMUdubUdrQkcy?=
 =?utf-8?B?T28wbXVMaE9EU21mSXBGYzNXNTkxd3VGQ3BScXNsSEt5NnFHVjlUZjZjT3pF?=
 =?utf-8?B?ZFErRkVvT1VnL0lXeFVqV3Q3U0xCZzk1SHJva1ZZN0lWVTRKdjlNWWpPS2NP?=
 =?utf-8?B?OWMvYWpXTlNBdEYrdHlDeU8xRU9QQXl1ZFlyNHgwYzI0MlNjRHdxRzg5eEE2?=
 =?utf-8?B?N3VpME9lcnQ5cisyVmtXSHFHTUkycEpxTHVDMlVKWTNHT3g4d2xkRC9tMW9E?=
 =?utf-8?B?bzR3ay9aNFoxMzlLVFdTQjlEQ2Z4UnV0Nzkyemo2TUhFUENDMXJtaEFyeklr?=
 =?utf-8?B?R3Fqejd0MzFjMnNZV2pPaGVDTHZqUm1Ba25Jb2xIVnZtczRrU0VxV1NVZElS?=
 =?utf-8?B?UWRrZjJwVWczOVpGaWlXU3pFcVcwL3lWWElCa1hNK3dLQ1NrVkpFbENPL2lD?=
 =?utf-8?B?QnVXY3BFQmdOVkhZUWJHTm0xR3ZCZTY4MkVaVEdzZlhCS0pkazV4MkxqOWVB?=
 =?utf-8?B?VWxJRXA1bWw5UTRtcm9Eak5RMEU0RFV1WURCTHhUVExTYjFXK2VxNnhkUWFo?=
 =?utf-8?B?bWluSU03NGx0TVBLekp1bGhhc01mc1YyUHF2MmVnZGJMZ1ZYUmN2TWt6TzRk?=
 =?utf-8?B?QThRbGNQV2IreHkwcytrSXlpcWV6RkpJL1h4SVo3MVB4c2IwNVJzKzlMSXF1?=
 =?utf-8?B?MzN6cW41RkN3TEhyZ0hFUHlGN0ROTUtSdy9ZYmx3dkxkWFp3U0RjcFJaYnFv?=
 =?utf-8?B?Zk16REZpYjhnZ1B5ZlZJSEYzTGlveHNHb0lhTUFUeEtLRUZXcVAyVTVFS2d5?=
 =?utf-8?B?aHVIMkZranMyM3JTb2NBcTFMQUpIWjJDRXlxTnpKMnN1c1FIZmk3QmhPODRG?=
 =?utf-8?B?ZytuRXk1dzNOZElpdmtXY3piQUhvSkNJUUQvYVhpQVpYcGptb0xCZ1I2WS9Y?=
 =?utf-8?B?RjkrRXk3WmVFTVpaVVJvRG9NbUxyNGY3ck9rVE9wK1JWc3R0eHV0b0NrZ2lT?=
 =?utf-8?B?MjBPTjZ4bjJvd3pjYmQxeEVRaVJ0WlhwYkF3ZWxMcWhwUFBORXpRbFRUUTRy?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fb601c-a328-4dc6-a30e-08dd36ec2929
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:43:28.8531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d09ZH8sMvaFXrlRLLBTi0JfA162YJ8HNnkYsItBcszWjpNG5BudHxBpEKUdJKkv5nvMR6/iyJh905z4CAaVNRM1rRe40h0ErlS9Dx+N74P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8257
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 11:43:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17025

Hi Antonin,

On 1/17/25 12:01 PM, Antonin Godard wrote:
> On Fri Jan 17, 2025 at 11:44 AM CET, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> b4[1] is a very nice tool for mail-based contribution. A config[2] file
>> exists to set up a few defaults. We can use it to set the Cc recipients
>> to always add, in our case the mailing list.
>>
>> This also adds a wrapper script that is called by b4 to figure out which
>> addresses to put as Cc recipients. Considering that patches to the doc/
>> directory also need to be sent to the yocto-docs mailing list, this
>> wrapper handles that. A limitation of the script (lsdiff actually) is
>> that it doesn't know how to handle empty files, but those should be
>> of rather rare occurrences.
>>
>> While the wrapper script should be enough by itself to add the bitbake
>> mailing list to the Cc recipients, one still needs to manually run b4
>> prep --auto-to-cc for that to happen. Therefore, let's add an explicit
>> send-series-cc so that at least that mailing list is always there.
>>
>> Because we currently do not have anything to check for patch validity,
>> remove requirement for b4 prep --check to be run before sending a patch
>> series, via disable-needs-checking in prep-pre-flight-checks.
>>
>> [1] https://pypi.org/project/b4/
>> [2] https://b4.docs.kernel.org/en/latest/config.html
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> This adds a basic config file for b4 to avoid to have to add the mailing
>> list by hand.
>> For documentation patches, the additional mailing list will be added
>> when running b4 prep --check, as is required for each new series managed
>> by b4.
>>
>> Note that b4 supports patchwork, c.f.
>> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings
>> though I have no clue what it does with it as I am no maintainer, but
>> maybe something worth having a look at if some maintainer of this repo
>> wants to use b4 to merge stuff?
> 
> I'll add my configuration here, maybe someone or myself can add some doc for it
> later, here or elsewhere.
> 
> configuration I use:
> 
> [b4]
>    pw-url = https://patchwork.yoctoproject.org/
>    pw-key = <redacted>
>    pw-project = docs
>    pw-review-state = under-review
>    pw-accept-state = accepted
>    pw-discard-state = rejected
> 
> For `pw-project`, it comes from the project name on patchwork, e.g.:
> 
>    https://patchwork.yoctoproject.org/project/docs/list
>                                               ^^^^
> 
> The pw-key can be obtained from the user's personal settings.
> 
> Then `b4 {am,shazam}` will automatically set the state to under-review.
> 
> `b4 ty -d` will reject the patch. Sometimes I use `b4 ty --pw-set-state
> superseded -d ...` when I know another version of the patch/series was sent.
> 
> Finally `b4 ty -a` will also set the accepted state along the generation of
> thank-you file.
> 
> And overall it's much easier than clicking buttons on patchwork :)
> 

Thanks!

How does this work if I don't have pw-key (which will be the case for 
most/all contributors)? Does b4 fail or goes on like it would if we had 
no pw-* settings?

Additionally, I'm pretty sure we do not want maintainers to mistakenly 
push their pw-key to the mailing list. So I guess this should be stored 
outside of the git repo and rather in .gitconfig, c.f. 
https://b4.docs.kernel.org/en/latest/config.html#configuration-options
Should we add some documentation on how to do that for maintainers?

Considering I cannot test this right now (i don't have patchwork set up, 
nor do I know if it makes sense to set it up if I'm not maintainer :) ), 
I think it'd make more sense to have someone able to test it to send a 
patch later to add support for that? What do you think?

>> ---
>> Changes in v2:
>> - add b4-wrapper for auto-detecting patches that are to be sent to the
>>    docs mailing list as well,
>> - disable forced b4 prep --check for each b4-managed series,
>> - Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c4334c36cc7@cherry.de
>> ---
>>   .b4-config    |  4 ++++
>>   b4-wrapper.py | 38 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/.b4-config b/.b4-config
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..0b699f204c414099f2118ffdbc9f7b24454e4a4e
>> --- /dev/null
>> +++ b/.b4-config
>> @@ -0,0 +1,4 @@
>> +[b4]
>> +  send-series-cc = bitbake-devel@lists.openembedded.org
>> +  send-auto-cc-cmd = ./b4-wrapper.py send-auto-cc-cmd
>> +  prep-pre-flight-checks = disable-needs-checking
>> diff --git a/b4-wrapper.py b/b4-wrapper.py
>> new file mode 100755
>> index 0000000000000000000000000000000000000000..ddc2597bc0374fa5124a83be94eeab52df6f38d3
>> --- /dev/null
>> +++ b/b4-wrapper.py
>> @@ -0,0 +1,38 @@
>> +#!/usr/bin/env python3
>> +#
>> +# This script is to be called by b4:
>> +# - through b4.send-auto-cc-cmd with "send-auto-cc-cmd" as first argument,
>> +#
>> +# When send-auto-cc-cmd is passed:
>> +#
>> +#  This returns the list of Cc recipients for a patch.
>> +#
>> +# This script takes as stdin a patch.
>> +
>> +import subprocess
>> +import sys
>> +
>> +cmd = sys.argv[1]
>> +if cmd != "send-auto-cc-cmd":
>> +    sys.exit(-1)
>> +
>> +patch = sys.stdin.read()
>> +
>> +if subprocess.call(["which", "lsdiff"], stdout=subprocess.DEVNULL) != 0:
>> +    print("lsdiff missing from host, please install patchutils")
>> +    sys.exit(-1)
>> +
>> +print("bitbake-devel@lists.openembedded.org")
>> +
>> +files = subprocess.check_output(["lsdiff", "--strip-match=1", "--strip=1", "--include=doc/*"],
>> +                                input=patch, text=True)
>> +if len(files):
>> +    print("docs@lists.yoctoproject.org")
>> +else:
>> +# Handle patches made with --no-prefix
>> +    files = subprocess.check_output(["lsdiff", "--include=doc/*"],
>> +                                    input=patch, text=True)
>> +    if len(files):
>> +        print("docs@lists.yoctoproject.org")
>> +
>> +sys.exit(0)
>>

I forgot to add in the cover letter, but we could add a check to make 
sure a patch doesn't touch both documentation and code. But I'm not sure 
this is something we need to enforce, and maybe that's actually 
absolutely fine to have both in one commit? I can add that check though, 
so up to you.

>> ---
>> base-commit: 0329a7e3ac694737f2d2c1861f65492551360663
>> change-id: 20240524-b4-support-e9855fc54d40
>>
>> Best regards,
> 
> Thanks for the script Quentin!
> 
> I was thinking, for eocore we could even extend the list of cc from
> meta/conf/distro/include/maintainers.inc.
> 

This is something Richard does not want :)

I'm working on b4 support for poky/oe-core and yocto-docs, but I somehow 
stumbled upon a bug in b4 now :), c.f. 
https://lore.kernel.org/tools/a8bc0958-6c46-4622-96ef-b1e55c15f30f@cherry.de/T/#u

Will send patches soon. poky will be fun to review :)

Cheers,
Quentin

