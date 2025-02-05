Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152FFC02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 13:12:08 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.26])
 by mx.groups.io with SMTP id smtpd.web11.11510.1738761120408604740
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 05:12:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=SZPvz9sP;
 spf=pass (domain: cherry.de, ip: 52.101.70.26, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8so9B3X3fZDWGTAzrv+m3i6+btNV8t6qKJHTGGDO2Tiuyy1LMxkl4+6zoTfdNlpY9k+EJ7JQIba7jAeC6I5fMr2jLMTHotz43mKp33zlP3FUSjg/FNeVPxOtoqMeuzylSGopUO26PN2pwsG0eO7mDX63A1EEW9RI+tmncVuc4CIp+NLjacSR5W+K1pmYMvf8zq0Cm5wsdc+hr33cI+0Tb6Ab+Hy0lagbNV6T+oKpy7gpd6HIfTpgFLnK38ilmu8UGCc3X3S3SuJbp5QqUvhpft44NHWxAnQuSVIYHx+83b4cbCV8jD24yfwsvjqfdda1uKpaSAk0jyTUTNsUekxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4z6nIuAsLP/n+6PktbP/++BHOYpQ56fuqYSzl0ybDA=;
 b=KqejYT5SzblzckgKok7jcy4dQFnMrPRH7fQSCcFGNF8gU2WdVk7PxEPdxzP1CjYpcvja/0+636/iDsJkQilFYXx5yEkB9nxZL/WtGeYnEZCpeMznpJtiSyU6P8sqjUBZxUGdtjCJchRu970DysxZDMgiQPUtDForjWx1uXR9rk1HW9uOn7g5HulDYoFaPwv5IL6C3ZHjLYmigHFQsmfWmE9+5RrQKRgqJ4DGQiOnZf0JC7cFXlXdziKF6J/ku4HLcy4eGDom8QKExbwr7pyjInBhI2FAlWSQ9WiRw+DeH9XAwtRXvlR9zovrCgIMqEVq6u3hG8Hma2Pxvap8RJ6fNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4z6nIuAsLP/n+6PktbP/++BHOYpQ56fuqYSzl0ybDA=;
 b=SZPvz9sPVMt1jdE7ATb+4sINiDMQ/D8MAUU/zp+Z9TnLey81YFLSyt4KhQF6qehJj4XRxqT8rhBayVoVPG7eVf7lahbvevXUnOUKsquRDkntArZ4NuiepLb7d79vNlpfb59Lpcy1rZXXa5ptsH4fxYotoxGKCgFLVi27oQ1On08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 13:11:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 13:11:56 +0000
Message-ID: <abd86c0a-0c57-4425-b4c0-b8c9ba21cbea@cherry.de>
Date: Wed, 5 Feb 2025 14:11:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] add basic support for b4 contribution workflow
To: Quentin Schulz <foss+yocto@0leil.net>,
 bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::28) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: ed680d74-ce20-4561-bb3d-08dd45e6aab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RlpOc01neVU4dzBxemJOajdlVXhjK3dhY2N4MS8yNW9zZHEzOHdxbjVTYUpG?=
 =?utf-8?B?dC8raE5iSXpaMHgzeGRva1pyd3J5OUFEVXZna3BqK2NRYSttQVY5S3ptQ3M5?=
 =?utf-8?B?RW9WMFRoNUw1Ynpkci9ibXVkeU5PMU5PMUlrNGtrUVVuRkJoS0IxNkt0Yk1D?=
 =?utf-8?B?VDZXbzFaeEFyUGFDTnUxNjNxNVQ0U1cxR3JXQ2FZOTljd1h6WFNTZkwxZ2FE?=
 =?utf-8?B?VS9oRXQ0N1B1RGowQ3VSdTFkcjV4Vzk0cUk0VXJyZWpmQStHVFZ5SlE3YlU3?=
 =?utf-8?B?bU40b3hjeDNiQ0J6c0dTMTZnWnJNb25jUUJKOC85dGczWjJXZVV6MlJnZkFN?=
 =?utf-8?B?Ujc0V2NzNUE0QlQvc2poaGV0UC92NHVmWkN5SUtraFAxUGl4OVhodHNUZHZB?=
 =?utf-8?B?amFSOUtqM3l3amw3T0ZYUVM3VERBN251OXlKV3hJVU0vWGhjNHE3Vko0V3hG?=
 =?utf-8?B?eTQ1WTh5bjR3TlJjQnE2cFlTbDc1OGVIU2dhU29oY3UzY04yNlIyQ2grTEN5?=
 =?utf-8?B?ZkJWWWlrcU0yZGhQN2VMb05acHplWXNQSStrVUFIZlpzQjllRnM2SDlkRVhi?=
 =?utf-8?B?UnpUS3JCYVdrMDZ6WjIvdDBjb09xcmpmeG9leTVwdHZnU08xTXc4eWR2aDNl?=
 =?utf-8?B?Q3V0M2thN0xSMkZnWmltbm9yTTgvTEloSDVGVGVrLytuTmoxWVltSTB6akhT?=
 =?utf-8?B?bFZMOWtjaUttZ1lNcHVLWFRkQ1g1dldZM2tscnZZOXFyUWNFeklmRlhMYmkz?=
 =?utf-8?B?aS9vWDc5STJteVhqUmxPdWdOMDdxQ3QxNllha3Ezd29UT1ZZc3JycGg2aC9O?=
 =?utf-8?B?R2Z1K1RXeEJHNGNieG5TUUhkdW1FNG1rc3JvMUJHYUV2YVFVbGxFa1paRDV5?=
 =?utf-8?B?L0QrcEJZcDJXdXVRdjJUUEdsWXpueUVPR2p2SUNxRHFSckJvZEs0S3ZSWW0y?=
 =?utf-8?B?ZnJ3ZXJUbVl3K2JtT1pIdnRIYzdvQjhYeWNWWUxjemRSaVZUeW5zN3RuNlJl?=
 =?utf-8?B?am1pR3MwZ2QxSDlmQlBSUlhRR0gyNXhqVHVtNWFPelF0MldhdHJ6bGMvZWdH?=
 =?utf-8?B?NkpvZUlqeHF4VEhWem90TnRKQzRlVUE5UllYYVpCNTZtQ3djNUxLbW4zeHpl?=
 =?utf-8?B?dUJZck9ZaHA4eUZYU3Y1N256WWxKZDJHOHVEUHhqMm1BRld2cStwcWNVRTgz?=
 =?utf-8?B?RGdSRk9lWXNseFVyMDFiRlBvQnRJbDdHYXh0UTNzME5jeEhIMkZQUUtUUzVx?=
 =?utf-8?B?cFpQeHJpY2xIZE83MlpkSDlPS0RCSmdDeVIwc2xzT2dLdnNOeENzNUx4ZXFt?=
 =?utf-8?B?TW9vbTdUMTM0S0tZRkdlRkJkMVRPN002YmM5ZU9WenBGeGptMjJkQnZWYWpn?=
 =?utf-8?B?d2VUY3lrakVacHkwazZzVlNYcW9iTVgwL2c1b3VGNjVMQUVlTWxKVHlzczB4?=
 =?utf-8?B?YjArQzdUSjBXOXhUb3JGdGFCbzd3TG5XcDhscDJvZlJoTVlBYytkSkhYU1FC?=
 =?utf-8?B?SjIwd09sRlJab3I0UnNXMTBLZHQ4NTdBVGRXSjBLd1djbTYzVnJiMDFKd1Vi?=
 =?utf-8?B?UU5SZi8xRjRzUUl4NENYRmRybDkvVVBQMGtWT0djNGFwMW0xSklKb0czVzRl?=
 =?utf-8?B?S21UN0ljRW95Ymhwcmc3SWhuTDVmVVRVdUtnV0hCcWRRMUEwMzdOOXV4Y3I2?=
 =?utf-8?B?NUZGRzFydEdJZjB1VXhEaU4xOTVYYzFDdTFuWDF6VTJCTEpyZXZPY2VmYkZl?=
 =?utf-8?B?eXlQSHZXa2FDeEY5aDNaanJOaFl0d0lJTU54NkUxTGVEV2ZuaGg2WnNwMWox?=
 =?utf-8?B?VkdZZ0ZXVys3SHBQR01aZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?STM2NzMrM0laZk85ZmxEcTBaYjZuN09vbXpVWXh2VjdKMVNhS1cxNExuZUpy?=
 =?utf-8?B?a2FqZzZSbEw4YS90SCtzbEFSazNhVGtvdWVVazBkbncwSU5UR012ZkVGYy9K?=
 =?utf-8?B?MVJ1WXplR09LakVHSmxwVVZ4ZGFyVVRFdTE4WEM4S1hsVjk1TkYwNDlrZjhC?=
 =?utf-8?B?UWczYitDYUQ1NGF5VzIxNzRiVUxFZlhQN2F4VEVHeC9HUGxNNnZ3S01DaXp2?=
 =?utf-8?B?SzBEL2NZVC9IRGtNcDFNTGF1ZkpOMjV6cVY2NkUzcDVLRjdzOTZEQmxwemlC?=
 =?utf-8?B?MXhJblF2UUthb3ZsRTBkS3ZSTGhaaTZ5V05Canh5K2hwbVZYNnY3bDBUc1hs?=
 =?utf-8?B?b3ZBODgwenk2YmtVVTNBQjVhNnJOUDlVSUtXS1RnY2c1cmZqWUJjakY3NGUx?=
 =?utf-8?B?QSs4bnVtUXlWSFRKc3VaUU1IelNHeUVjcTEvRzVhTFBxWUxtSEMva0FRSjFH?=
 =?utf-8?B?SGdlaHlua0FSSjlXZjlkejA5ZWkxMjY0T1h4aUxWWVAvUjA1MVExYmpsQnU5?=
 =?utf-8?B?RmRRMGZJWE12N2pSVWo0UkttdVRXd1Rjc0xZVFNrNjNOYkpsUWRTQWN3RVJK?=
 =?utf-8?B?aytZUjM3RTJIbnRPSG0zTUkxZDZ3d0REUE9XVE5ReGpucVJ5QTF3YXViRVdL?=
 =?utf-8?B?NWhGZUpXbEI1bUM1MmFsaGhtNFBCYUFqUmlVdFdGR0VqR2hxVjJUUDJ0QUlP?=
 =?utf-8?B?WWlFcmhqRDdSeTZ3Sk5aeERiRGtFcHRNR3NEOFk2bEdsSkQ0ZWhDWGxOc3d4?=
 =?utf-8?B?UjdIWG9vTXVtcENXTk5QU3B1NkdYNkRPdmZBUk4wMC9kMmYwMmxOL1cvRHZK?=
 =?utf-8?B?eFhNZTNmUnZyYk45R3pub3ZvcUFGaDVtMVBKS1NNaWxCeHNsYllMT3NOSkt5?=
 =?utf-8?B?TEVUN1hHdmg0cU1VVHhMNDRIQWdKYVI5dUVWeEQvZXpwRmhVQXg2dS8yS3hV?=
 =?utf-8?B?WlhQQlFQWnJJYnkrb3hzOTF5UTFqc1pJYVV3aDJhQXdqUTcxNTV0OEZSRE9O?=
 =?utf-8?B?T1RlVGd5N1QvTVZJSW53RTc1YTRPUTVWbFFuUEZxSUdTa3lPeWVxeEVPT01G?=
 =?utf-8?B?eDVkTXNDMXFEN083d2t0V0IxNDRzWTJNNWEwamhRdnI2N1lseHdzTzdIUTEx?=
 =?utf-8?B?c01sZ0hjUVRsRWNNeHJJbktyZW8yeW0wejNEeHc0eXNRYUIzRkhoNm9lampl?=
 =?utf-8?B?SGVxaVNhR1dkV3lqSEcwamVid3k5SGJ2MVBNOXN5N0lGNXNwaGNuMUdJT2dP?=
 =?utf-8?B?VDJqZWk0ZENpOWJQVkRpY1NjemY5OFZuUUlUT0RUOTEzNVVYY1dwbHBRdVJN?=
 =?utf-8?B?Vy9BdTg5RGxFWXJzZ1k2Z2tlK1ZWaW8zK2RKdjRPaHpLdmYrQ0RtcE14RjNR?=
 =?utf-8?B?UTdHZTVuSC9rV1lzOVlkbFpNQzJPMllVNnRYUlhPdUtseGJ4aXN1bmJxK0NZ?=
 =?utf-8?B?eG40clI5aWJXMXh0ZnlNTUkvaTY1SjJJNFRpeTNvMG9rSUFRVFNGY1c4cmdK?=
 =?utf-8?B?Ulk4K2gzZG5ZWmkzbnF0VFA0aTd5S0k0UzdBL0ZETXNQR1ZXMlRScEwrZDdK?=
 =?utf-8?B?aUpYNkdsc0ErZlhIUklSRWRhamRjcGpiNjdwRWdOUXFtWHUyZTNLemtWT2F0?=
 =?utf-8?B?MllhcVhiMDI4eXhObFp0RzcxSTFwR0JUUjNuNlNOZThNQW03R3NvNExwdkFu?=
 =?utf-8?B?WjMvMTY0clhCOE1jQkpWVVJYSFhhdlg4YXRTQjlnUWxTSmx1QTFuOENVek9P?=
 =?utf-8?B?OWtrTzJaaldvMXBmeHYzOW1GUEJSWDF2TExsRVl6bnRmT3FRNTQ1eFVIalg2?=
 =?utf-8?B?ZzZyN1NmOXYzb1NuTlJBYlhEeUVpSjRFalc4a3pTa2d0UExNQVFpSWtERlNo?=
 =?utf-8?B?TW1hK2xodjhmUitnSFU2a1lJMnB1cnIwQWdYU0s4OHYzNjVBRjBxZytzWGdr?=
 =?utf-8?B?K3A0K00wVnJCTjk5d1FGMTdreTZ2RTNwVk5tR2pJcHpZSDNZRGNIbjV2Sm8z?=
 =?utf-8?B?bDNjYWIzanNUY2syQ2V2ZzVMdzF1QlRVeEIvT0UwS3JRRWdJZ2ZiUVBldjRq?=
 =?utf-8?B?RWVOMGplYWxPMFNSclVZcG45RXE5VkpQNWE2czZadTJtQTV3TExMK0lubHF4?=
 =?utf-8?B?NmF2MmxEQ1crRHZ0azFXb2tLb1RhbjdOaWlOTExWWElqWk9qaVhSZTlhbHRo?=
 =?utf-8?Q?4LtHIhSZcdF6NguQixc6M0I=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ed680d74-ce20-4561-bb3d-08dd45e6aab8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 13:11:56.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0mI3u3zu80fRqRcOYgz6qYQrTtdbby6/+0h38WUY/LR3bbtO6IetJOy5kyG6KU6EPiZUSPeb3M628L+UGQKE3Utv4KHI9Zw8MGHsz/aye8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 13:12:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17153

Hi all,

On 1/17/25 11:44 AM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> b4[1] is a very nice tool for mail-based contribution. A config[2] file
> exists to set up a few defaults. We can use it to set the Cc recipients
> to always add, in our case the mailing list.
> 
> This also adds a wrapper script that is called by b4 to figure out which
> addresses to put as Cc recipients. Considering that patches to the doc/
> directory also need to be sent to the yocto-docs mailing list, this
> wrapper handles that. A limitation of the script (lsdiff actually) is
> that it doesn't know how to handle empty files, but those should be
> of rather rare occurrences.
> 
> While the wrapper script should be enough by itself to add the bitbake
> mailing list to the Cc recipients, one still needs to manually run b4
> prep --auto-to-cc for that to happen. Therefore, let's add an explicit
> send-series-cc so that at least that mailing list is always there.
> 
> Because we currently do not have anything to check for patch validity,
> remove requirement for b4 prep --check to be run before sending a patch
> series, via disable-needs-checking in prep-pre-flight-checks.
> 
> [1] https://pypi.org/project/b4/
> [2] https://b4.docs.kernel.org/en/latest/config.html
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This adds a basic config file for b4 to avoid to have to add the mailing
> list by hand.
> For documentation patches, the additional mailing list will be added
> when running b4 prep --check, as is required for each new series managed
> by b4.
> 
> Note that b4 supports patchwork, c.f.
> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings
> though I have no clue what it does with it as I am no maintainer, but
> maybe something worth having a look at if some maintainer of this repo
> wants to use b4 to merge stuff?
> ---
> Changes in v2:
> - add b4-wrapper for auto-detecting patches that are to be sent to the
>    docs mailing list as well,
> - disable forced b4 prep --check for each b4-managed series,
> - Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c4334c36cc7@cherry.de
> ---
>   .b4-config    |  4 ++++
>   b4-wrapper.py | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000000000000000000000000000000000000..0b699f204c414099f2118ffdbc9f7b24454e4a4e
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,4 @@
> +[b4]
> +  send-series-cc = bitbake-devel@lists.openembedded.org
> +  send-auto-cc-cmd = ./b4-wrapper.py send-auto-cc-cmd

All the above should be to instead of cc, will fix in next version.

@Richard, is the b4-wrapper.py below (this one for BitBake and not 
Poky!) fine in BitBake git repo? I believe it should since it needs to 
be called even when one develops from "vanilla" BitBake git repo and not 
poky combo repo. Just asking for confirmation here (and maybe you want a 
different name too?).

Cheers,
Quentin

