Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B7FF8875
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 09:24:51 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.6])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7549.1777454688682251510
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2026 02:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=QpbQWYqt;
 spf=pass (domain: cherry.de, ip: 40.107.159.6, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYoibKsGBCCSypLDxT7CLAkq1Hu3OSyvyE2IWqk+TM2+TZbEhaTwWpDdkWxTdL3Tb7d/lJuhhcdCkvYP5X3BEhqIUao6sl2QJj3ifR0ZQ87dqaDxgKOWMhicmldtUGyT3HhgF6aTca8WbIn/VfZdCKfeQhhmuGoiew8v5HeFS9AlwZ7do+zSfNYh4EBjxqgsulwTjvMkF96EBg/81E+Mn18hVTkh64frbVxpzm6WS9j5ShiTEtwf0iLBBf4pE6NDIOpyHFO5Yi/Lnv6yF4TVDa5p5ddi8vDsrVYEGiDU7w0o4xC/gLt3ND0VwC0+mI+ODTpz622gZny3on+ES8DHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3eISAlujRgBaosFZ72Ptr56TOYSMAFxdLvRa7qnJcA=;
 b=nUbBrwFZVwO2smaDmj1ItqwSNE0MnDHj4X81yxY6lWdI/A6+CuWNeWj4FKTpKAtgrX61EDT7aghtrzJqOspHWrGpZPTKmQ0zf9hgE0v3+/sjoP/amViU9JopDt4JdSdrJoQFdzDiuth0oHzux2uhHDn6IzCGEV3RK6+plGaWp5nhhqgZeRXfdSaYxXXmMHtn05y333k3lS6uRg/Si1kiMjyghDV1eaDML2OrP7UxFqlaDJf3SQn7cyj4XY2sxs/BvGWvtV40zmQUwpm62Z9XNgrHr7E9f4VFkATPUY8zct9Jevr4RrdBxGgL8bgVH1Gnw96s6nWscO8qpjKa/TB/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3eISAlujRgBaosFZ72Ptr56TOYSMAFxdLvRa7qnJcA=;
 b=QpbQWYqt/Nrit0qLtp1177f1QzaCIUS+VnPW9vI8N00G/ly7lrtfVbcOTuDAXMB3w8ELOdgDeidtXTEqVj2kRBj2J8oRriaPWYD2jlgkMMMC3Mm49sv0S8lUNIMs1xT/faFN5Eg7CuC0bZmbIMK6E77lg6kJcRbWY8sMThu7/04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 09:24:42 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 09:24:42 +0000
Message-ID: <8d3b4f54-5850-44d6-a08f-3b6808836ccb@cherry.de>
Date: Wed, 29 Apr 2026 11:24:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] doc/setversions.py: add --get-latest-branch
 argument
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20260429-doc-get-latest-branch-v1-1-e5a0ce87cec4@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429-doc-get-latest-branch-v1-1-e5a0ce87cec4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBBPR04MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a14fee3-7698-4abe-d602-08dea5d1251a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	YUKEePRE4L+Rd++6HAzz8ctB9Co/woXqH+xB6GYrmHe3NW6BFvu9qj6RhzdzLsO5dyPOh1vtJ6r6fFpVX/iepdu/h6ZvwHxc2igVkgxgwShJ4m7vX+pk7/4lWn72tjqluAYk+F6VBndwJpBwSF/CpxyaPkvlVaFjOreItwULigfUBosb/zSwQQOUvOTFkZnue3BGlPt7GTE4OvzlIszxZ3edoMUEbnNDPA39sn0DnJACMNRZLYUJ8Sh4ocgzVokg/6lbS52KH/x/mu5dTToLuTEItakgXZDWXq29JE7pwgkziaddcL9u3fyhYo5M3yGl6EG8iGnt/bC3O3MhPFZVNAhX0QnXhUjNKfwognCkqgCGJ1HFelDW5o0hfvyoN37kHpVjD4GV6pMe1UCRuGCD2rOepydzhT8h8uPabldzOdhJsRpSR2hWbN3zXN+NwvdIlAZ3HXTuDH/QqQhhPFF+6/9fVuuSOYf4YBuzFgDOJUmC2znmsWAWN8KnR0bBJw70irGded5g7k/zlnfjfXHJZROiZbX96O/ehT1l+C7Sd4WMhahcQl50q5Xpg0kM5Ye9pndqZQqQ0Wo/INUDjLMLFRVcU+Ky2LussG80le6gbLrQ52ZKOXI2qyiuZjH7iHT3TnDKlUToNI0krtmckzm1r41rJb3QnTEV6+J+LJRHiXvPXKrBiHbgf7am31TtrhxF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnNKOGtXNnhOMzJIUmRTVTkrc01WOTlIRVBZTjZDWXM5L2ZEQlRMTFFocGs1?=
 =?utf-8?B?QVplRmFacDJtTWlSL3lKRTUzTWEydGg0SHk2T2VKMnJRbDlobUhPNWlNRERD?=
 =?utf-8?B?TnBLTDlRZHlkYURQTlp6dlN3WEpZZ1ltUmZld2p2ZzNNRDBUeXlNQ0pzaGVL?=
 =?utf-8?B?YVdOWEd5MFAvWElmZDRLd2RZWWM5ZS9hQU1NdHNVcHZySURLMkNUejBvZ0Vj?=
 =?utf-8?B?NytUWXhUQkk0K3pkUnR0eWMybnVOd0h5bjhNME5kRE1RamJBNjdEUGY2ZW1k?=
 =?utf-8?B?dkRYZHJBalplM01JQ0tLVENIdnl6MUtDaWN0NHE2QXFjVmV4T1BkWHZhUFE3?=
 =?utf-8?B?MDkvaHNjV1VxVTFsTjhiUXh5SHBWeGFWc0UzdmNyTnR4TnJ4OFo5V0ZoZllm?=
 =?utf-8?B?ZlZyd0Jva0NYRS9RS2tycFU4SU5tR1ZqNXVxWU9aVXp4Y29QY0EzWGFVVCta?=
 =?utf-8?B?NkdkS1ZBbTlnREVGTFhMOFhoOURaZzRrRkkxNC9lZWw5L1lkYU9wa0pmaXAy?=
 =?utf-8?B?N3dEdTNhQVVyMlBNWGg0YW9HQWhxZ01qcXRjWVdBSEIwekp3V3RqbGRZeVRa?=
 =?utf-8?B?QVA4QlJsZjJSS3RmOUl1UVJmUlFjaFBlREZzU3RrUTJYb3hvRytXZUloNjNV?=
 =?utf-8?B?VWhETFlSQVVsUU5hWlBQNlJ0cDZ4RWIrWGZXa0ZWeTdtQ3BpakIyTTBJcENm?=
 =?utf-8?B?MHRMc1NpRFBFVnRPUXIzRndYMGFHTnZUOGRhVmtIRkJZTDIvUEJBSytVUlRt?=
 =?utf-8?B?SEJNSlo4Tk1CV2xkTm1oNyttbDBUZEg0bW9YZCtUWW94eEtYQ29XazF4eTZX?=
 =?utf-8?B?Y29Mc0NiK1U3YlFSVFFYcGpUVXpqWTI3K2lnR3pXeUFtdm9qZ3BpQ09JNURz?=
 =?utf-8?B?b1hZWXN1aFpmYkxCTDZ0VjEzcndNeVlsN1ZqWFFDd3pXazNaWlBHWnNvOXhX?=
 =?utf-8?B?U3BSd0Y4NS91TjluK05mS0h5aXpqT1pCOFlrL0I2ZW5jQStLU1lwYjFqRkpI?=
 =?utf-8?B?eEp2SHBoUU0vdzg5bFE5bnpmN0Y3RlNhS1lKSUpqdjU5RUFFNGNXRFFxaFNi?=
 =?utf-8?B?cGlUSjAreHM2SWVNUFYvSEFzbDErYi82MGV5MWlDOEI3NjFuQ1Axbk1MTXJa?=
 =?utf-8?B?eDBONWk2clprc1ovQlpaRGNCMkZXS3lrZE5DWSs1MGxaZmROWUtHTTdIb3VQ?=
 =?utf-8?B?T3VvZGJKVXlabkI2bG5BdVI3MkxLNUlSUjNnbzZKdlh3MG1sUlV4WGtOakJD?=
 =?utf-8?B?NzNEMUNKeG5GOWlTeGVBd05sWnVOL2ZQaEpwNzNpbUxrZWdLWkUraUFxbTZ3?=
 =?utf-8?B?T2dVL1lwOFR3Yzh5UkZvT0hGeXdpaVNZZXo1dDhPdFF0RTJXeWNuR1Jtemt0?=
 =?utf-8?B?bWdUMmt6NkdxREtIWUx6VldhcGNsSWd3ZFZVUVg3YTdkaTBHT2hWWHpLQkx0?=
 =?utf-8?B?cnNoU3h6Yi9DN3BFRnlIWTRiNlpPZWxvZWd4bERmdGdDSWpqWDZacEVyZ3gr?=
 =?utf-8?B?R29xalQ3d0NVUjJXRHdaWUJmTHdPU3UxY2xCVlVPTlA2N0R3dDRWR1RJOU9x?=
 =?utf-8?B?YlVaYkp1Q1ZtRkcrTkxIQVorRDY5dEowTFgwNTEvb2h3M3V0UTFOTjU5bjJz?=
 =?utf-8?B?aFU2eU5ENWs4cm1FNHUybjR0R2hpMTBZME9NTHQzc0E0dmw0ejZkL0FWdlYv?=
 =?utf-8?B?UTYwcXc0WXFiQ1N1TGlweE9pSCsvejR5U0prWFN0VEZHQVdyd09JaWljTEpp?=
 =?utf-8?B?aEhqRk0xUXNkZDNmdDVlbWJ5SUIzbTdBZ2l6UFNBQTdOSzFaUzJIZnRCbXUx?=
 =?utf-8?B?ejMxRDhxbnFJTDZMTWEyUkpzbE5Bck1uek1MSUlxUmdHYWErSnNJTEMzU1Ra?=
 =?utf-8?B?WW9SYXIzeENidXNtc2UrRkZ1WHNvRmFRVXNublpkS2VjL3JwOS8zeFNLYWZJ?=
 =?utf-8?B?UmFpcHRVL3VZbDIydDEwZUVUbldFcXF4T1lSY2trQTNpSlFWS2h5dXZmVG1M?=
 =?utf-8?B?OGZENllCRVdZSmEzN3J0ZWhtT2xsTVFGTktjYVVmbTJwb2xqWE44djlBU0Vv?=
 =?utf-8?B?djZCL1JCNzlmREhPQWVjbjhIeTZSSHdhZzYxb1VJUFlIcFlFdWpYS1N5dHRW?=
 =?utf-8?B?RTlOS0hBL0lLRzd0VWg2SW43dm52R0Y3Y014UkNvL1lVVllUSlprSWVKdDdR?=
 =?utf-8?B?MC8wNTNxNW9DSll3N1EvSXliTjY0QjZjYnBZYnlXdzI2WkJkeVZiUG9oU1VU?=
 =?utf-8?B?Z0JVTnpOSDdiS1NNUXluenprSHZDa2xhRy9UODl0RUdVWDlnSktLQzlrOTNm?=
 =?utf-8?B?bzl4OG1lTGQ5YW5IWFZLclFzMHNzN2JCSUppbmVMY2tRVU1pNy84MW9zZFh2?=
 =?utf-8?Q?FuVjHBCvw4WvPu0c1AsFDM92Xuu9r4bKVfAp0?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a14fee3-7698-4abe-d602-08dea5d1251a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:24:42.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS690RgyjdpGN8pCcasqKvsEy6lLQqJwdkjSrMnes+YMwAZ9rID8KijoeClfuqcuxZE3uxusyrABzA4zPJX8jyk8UHVWepHIyCYJA3DnaS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 09:24:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19412

Hi Antonin,

On 4/29/26 11:12 AM, Antonin Godard via lists.yoctoproject.org wrote:
> Add a --get-latest-branch argument that can be used to show the latest
> branch from the parsed releases.json file. This will be used by the
> Autobuilder to know what the version of the default bitbake docs page
> should be.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Note: Companion patch on the yocto-autobuilder-helper repo will be sent
> after this one.
> ---
>   doc/setversions.py | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/doc/setversions.py b/doc/setversions.py
> index f1aea0a4225..c4127bb43fd 100755
> --- a/doc/setversions.py
> +++ b/doc/setversions.py
> @@ -13,6 +13,7 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> +import argparse
>   import itertools
>   import json
>   import os
> @@ -23,6 +24,15 @@ import textwrap
>   
>   from urllib.request import urlopen, URLError
>   
> +parser = argparse.ArgumentParser(
> +    description="Parse https://dashboard.yoctoproject.org/releases.json to get current releases information"
> +)
> +parser.add_argument("--get-latest-branch",
> +                    help="Get current latest branch",

s/Get/Print/

+and exit.

Cheers,
Quentin

