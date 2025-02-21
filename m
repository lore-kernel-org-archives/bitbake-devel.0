Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE7AC021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 10:52:33 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.51])
 by mx.groups.io with SMTP id smtpd.web11.20512.1740135151678049202
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 02:52:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bQByuBYi;
 spf=pass (domain: cherry.de, ip: 40.107.247.51, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEGwqa6AP5GIjTQIVCL1rQIN8aHpSykmwOhpLwYLKbNFm7ibyXjsr8fkPTzgvWH76ILyaHEIUolmKmcUIdEH1ivQQYDfgkpCjMr6M7Nrd5vS5/8cI6NBfARQJAceCDd95bpnDKJjEXba2FSzImRbSPd1rk1FVCzjS+u41xAKuhKWxFFi1hP/uxQQS70nycjWKMT26TSg4ANMVKIqywrZm3Y2hHXykSTQrRQ15k27q9Kkgmjp4qjFHxfrls9vxCXA+ffqSgm8+YtU9Kv3KI2Pg/FkN2rtig/mA74Ru1+JWbBd3zBc7Y3D5FWCH6IosLlcFqUmfALodvGuIQ4LMDcsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cylxe5UFZk0ZM8uwaCW21kPne16u6OnniLl/ahWXrT4=;
 b=qxOJVzwarOonnBwqGR1NVrOwO1BQ5Ft4YUzzbjRN7fG0XCbSrcM9W6P1ikHRcDkR1qz/ZcrRVDZoNYZeanvQ6ezTQVOKBTmhwIxbI0Zpuo0mYZ5lJSMoYa/k5UMJLTcaKLTKuIUWMyImhWxpKEd10lI1pcNFC+tm3+upHxmZOdtFQ95mzewefBf3R2OEBW7ZxxC8jVl79stzxw9qjkY6d/PE+H5qfNfgm3KbaqlkmJIQn0GZqnePIhmvqKNXrlNhWQMNmeufMmuRA6r8tFlEjUsBBg1BTZVZv2ADjpY6Fvrx+DvtngmjaQmYT2rge+0FNiuQkthsEBMlzTck0WTw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cylxe5UFZk0ZM8uwaCW21kPne16u6OnniLl/ahWXrT4=;
 b=bQByuBYi9lGvRNMdFekVrJyLYO2NR9jtmp9upGFyxc0GBzhmozVu/BS9BpR1+MkfgWj1uHz29VJszPYpLveKoeqXv94x0tMWhq/YwLlcZIhDX/5cf9PiFzQPAxJu8KU3tkWxdVQ3lAYasVEZ7jJP+fg+/3wRYtB47KQjIe8/DEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 10:52:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Fri, 21 Feb 2025
 10:52:27 +0000
Message-ID: <46ecb25e-9034-4da0-9c20-606dca371ba9@cherry.de>
Date: Fri, 21 Feb 2025 11:52:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3 2/4] bitbake-user-manual: Update
 documentation for fast `BB_GIT_SHALLOW`
To: stefan-koch@siemens.com, bitbake-devel@lists.openembedded.org
Cc: simon.sudler@siemens.com, jan.kiszka@siemens.com, alex.kanavin@gmail.com,
 richard.purdie@linuxfoundation.org, docs <docs@lists.yoctoproject.org>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
 <20250220172706.3850722-2-stefan-koch@siemens.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250220172706.3850722-2-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd373ac-a549-455a-7a8d-08dd5265d4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TWE3K0FVOXNUSHlGdk0wL1lIQ2hGVW83VlRySUhKKzdZNW5jNjNLM1NSVUsy?=
 =?utf-8?B?QU5GU2tUeCt6c1JpM1JibU03RXhYcFFvOGxKUFVSSExXN2VIQUxmempVSG9o?=
 =?utf-8?B?bE5TeGY3dDByWWFhSHNTcmVBa3BRRUZoSE1QSHlLUkJMbVRBL2dOQm9EVnh6?=
 =?utf-8?B?QldrVmVMWGZzakFtSGFyNFd5eFNUUDd4QmMvd0RzWlpKeUhjR2JKamZtVWxW?=
 =?utf-8?B?MWQveWxTQnJUUVNqeERrRjE3RlZpWVFtbC9BenpiS3JDZ0V6MGtBUXRabTRR?=
 =?utf-8?B?cVZPQmcrRnFiUUx5OUtOeHhrcUFIVnRENVhqampHc3VlVVdhV3FjYk1qNGE5?=
 =?utf-8?B?SzhhQ2xWUUQ3Vk1sc0drRWRDbTBuOUIrbnN5NmxiMktEL3hLZkdqa1NUZG1a?=
 =?utf-8?B?amNoems4a3RneVBjRzJSZDRSYVpmalBkWkNPbFZWSDA5ODB3ZytSVHU2Z1lD?=
 =?utf-8?B?R3BXdjNEK2syOFA2a1kwVUVLdDQxblFUT2tQM2FOVjZIRVJTTlhlYU9mODk3?=
 =?utf-8?B?S1lrK2lOczd2Wm9oNnpHbTI2WE9ETkNiaWoxOEJSUzY4WS9oTmtwd1E0Q1pi?=
 =?utf-8?B?RDZONnR1M3BkV1lZWVBGbFY3dnVaQ011M0llYjB0TFl3S0NScUpOYkE5MlVH?=
 =?utf-8?B?RllhZFB0U1RRT0VVODhxd3dkWUFUbWRqMUg2N21neGFyRGwrbCs2cU9Ld3hY?=
 =?utf-8?B?MWxVaUZYYkd5UE91ajQxVkVmc3lRaUw3ZHdac3kvb0dQMFRFU1Q1cVVsSGxm?=
 =?utf-8?B?SWhBOStycWN2aU52L290Sy9Tb1o2QkZQRy9ZSk55eGxiUHJjZEdYajM0ZCs5?=
 =?utf-8?B?bTRGQy9Hb0VOZFN0WDA5WHI1TWtPaHNtNDRBSUFGTjF3WWxoeTN4aUJwV3FZ?=
 =?utf-8?B?SDZzYmw3WFIreEh1b0oxT2Uva0dqZi94VFJ4dFNvUENHZWxGNjgrdDFRWGV2?=
 =?utf-8?B?N2FBeGg5eS92T0ZpVklHREpWVGEvcTY2eXRFSisrS0NqRnh3TnhkU3VNQktJ?=
 =?utf-8?B?T1I1UFhjeDVXMlB1R3RaZWx4MVM5NXZZWUVCalNVRDhOM1E2em1FanJGOG9P?=
 =?utf-8?B?a1kwWkkxUFpKZml6QUdmOWVVSXYweVlvTkhXZzk1aWNqU0dybUdjMGt1QkxH?=
 =?utf-8?B?ZzR0V1daMHdEcHE3M2c0VTc1RTdjZitocTA0MU1EYnE1MThHbUtIYUJ4bWRu?=
 =?utf-8?B?bjg5N0ZCdjVNTndwUE5zM0NDcTBxUHBMVGszbDhuRzZjQXBsVUxQZHhvRDhv?=
 =?utf-8?B?anVhSDc1UWVWVE9ZOFlrNWxrVDJCdDl1Y0dGN25aVmdzSlNtUFN2MjlaczVv?=
 =?utf-8?B?dkpTR1JaYkxiNkxoN05jNGxNVDl5M25KM2pveTllU1A3RzB5SWNhOVoyMHkz?=
 =?utf-8?B?bUdZSzVBbEhBbGQ5dER4YmZKWDVQS2UxWHNkQWFvQ0sxZUlDZWJOZDE1eHQw?=
 =?utf-8?B?NUcxNEhoWUI4TldSNklvMmhIMlRKY1dRVndoZGZtTWRETHNad2lKcGp5eE1l?=
 =?utf-8?B?dSs0S0lqS0RxZ0Npcmx0SlcrRnhVTno1TzZPRlZxTU9jOW9rWjJEbVRGdDE5?=
 =?utf-8?B?bHR4TWplODFBSk9yOEpxWXZTc1YwSTJ2RlNKd3FmNnUwR0tFK21JNTVZZitS?=
 =?utf-8?B?QklGVmRaQXdNSFR1bUhPcmlkbUV3YXVuNzRiU09Idk5MWWlyQWdlUkppb3RL?=
 =?utf-8?B?Y2xpUzRLcnF3MXFDMnhRc21CTmJpSTQ5Vm96VVRHR2tIT012NFM1U0ZLcVB1?=
 =?utf-8?B?R29EMklQS3oxTmZQTi8vMG82dXJFNHNXcGxWZVRrU3QwMmZDTTRKOEVYb1d4?=
 =?utf-8?B?T3RNSWpHeFM5eVA2ZFRRZG1tdVBaS1AvVWhMbWVNa1BBeGRjZGJjTEl1NlJ6?=
 =?utf-8?Q?VyXayabGOyizr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODJPN1N0cnROSk02eSt5eCtRYzlTWThqVmpnOGNxK1pzRVUwVldCMjU0cU9U?=
 =?utf-8?B?clhjbkZEYnd6TGRGU2pPY3FLcVR0dXM5aERxNDlibmpwLzYwWHB2WThIMGJS?=
 =?utf-8?B?ODlXNG11bmllTmcrY0JOcks3WDdPY01MNy83NDFaaXYxOWFRWkgyQnlQZFg2?=
 =?utf-8?B?QWV5bU1hN3luQk1TSnpjU29OeFU3ZlZJa2RLSEI5QVpCc3E0SmtQUmlXZ3k1?=
 =?utf-8?B?L2dkRFVIZ2JZNlFSc09QM2JieCtETHF0ZC9JMTBKYlRaOWx6MWx6TnNKWHRj?=
 =?utf-8?B?azFTWklhaUpXTEtqQUpDWjA5dVRVVE9RRlFPSmoxMDg3RC9sekxjZVZqMStm?=
 =?utf-8?B?ck5md2pLcXFaZFU2a1h4QndRbzFlazcxSUtBZXJZY3R6SUw4bFVkdkVleko1?=
 =?utf-8?B?WWwrQ2haeGpUOXZIUXZqRWNoT1V3UUlTcWZ1TjZlWHBVZXRJTko1eTdXSXZC?=
 =?utf-8?B?RHRpMDRxLy84MFNQYjZWV2JTR2o3a1pEZHFiU2Z1V3V2UHBlSEQvYzRtL1FM?=
 =?utf-8?B?SXh4TWo5bUxQVEZ3UjEvcGZDTGl2MEpPMHlndUdoSUhsY3JhSkVJWHM2U1Bu?=
 =?utf-8?B?WXk1dCt2aURrNDcyUlR1bnE1M25jaVVScVMzN2k4SkJteDFSRHQ0eGpDTUxw?=
 =?utf-8?B?TTFSTzBRV05qQlZLNG9WaUh1YzJ3amd3RUhhMElOaGIxaWZlbkRGRFB0L1lC?=
 =?utf-8?B?bDNsRnkvV2pBL2V4aFNyMW5tL3haZG1pM2cwL2Y2TGVLM0ovR1ByL2FmNXZH?=
 =?utf-8?B?SFJ3TGNDbXFLUlFMdXZiekt0TzJ0WHJBZUJxMHZuNzBNejk1cE1Xc2poZWdZ?=
 =?utf-8?B?MDhNTk5RbnN4VTRIRTF0WnE0QjljRUZwSXYrRm5pVkYyU2VYT1Y5N0Y3VW9x?=
 =?utf-8?B?WU1PNVZtS0J1T3RtcUVQQlZZMkRsNkkrZ2JnLzBUWDY4WTB1WktwUllxSWJq?=
 =?utf-8?B?VjlTYXpsN09vWEtESGxnOE1OcTAyajVwTjZmZ1RUTEVTVTBxRmVtYXl1dGZS?=
 =?utf-8?B?NGVsWGpESnJvUmhHQUh3cWVuQVRyUVVYTHBpdlkvRGIvV2ZwWGZubDd0TkJW?=
 =?utf-8?B?VWJmSlUwU2JtN3dobFBNNDkrSHN4elVBMmZka3ByOUlTMmhicFdSZDA0ZStJ?=
 =?utf-8?B?eFN4emJzVloxTzlONno5ZHVSZVJ5V1lwc1BwSFAxU0RSNjdiR1hlMTBSOE5D?=
 =?utf-8?B?RXRGdUk0czZYWXVSUytKckJnM01mUzUrTmMwWS96RUpOemV0TnN0eEpEZ1ZR?=
 =?utf-8?B?UFo0SVVQVDVjZnE1T0ZKdUQ0Q2xjb3FRVGxQTXhjVUlDUnpySFZ5Ly9WVzgz?=
 =?utf-8?B?UzU3QjVVTkRoR2pmS1hMOW5JZ1VySDJtczhiN3JHN0JLWDhEYjJwTFp6SVdC?=
 =?utf-8?B?WmxMb3NiamdOVWY4SnFoVVRrUDhZazViTG5GcE5HV1p2aFNWRVNEaXF4YnRH?=
 =?utf-8?B?R0g4bXZrUElCOUF6cXg0ZVRrNHArRVd2cVRtZmI0UG1rREJ4c1JQU0FuNThh?=
 =?utf-8?B?TWlUZWYzR2NZcEswWUViaFBEU1J6dzE3dmdVSHVJcDJ3M1VNV3psYlpyWlpP?=
 =?utf-8?B?a1BrZlhzUWxna0VvY0FCMGJqZW1CK010MXNDcWR2S2RNZUxuRDA4WmhDNCs5?=
 =?utf-8?B?VlFQcTNBbW9pZ2pOR0dMOFlrbThWRndqaVlUd2xGb09BdDJrZmdRN1dUQjAv?=
 =?utf-8?B?QzFqSVFyVTFoZzZLOSs2L3J3dUF1S2ozU1JQLy9sRlUyOFo2VEN1KzNvWjk2?=
 =?utf-8?B?YWpTYm02QlZJdy9rSUNZUjRnZHRMNFdha3lxWUx3bkJselg4d05pK2lVN1o2?=
 =?utf-8?B?RE5OeWpaYVRteTFNandVb3BKaTh6VWZkWks0OXQ2L2JQZTNmS01KYWtJTjNW?=
 =?utf-8?B?Mm90eFFXSnJSOFMxeHdjRzNxMlZrbElya0FTZXc4V2YrN2dhUlJZcDRzaDNh?=
 =?utf-8?B?dEl6Q1BxNkJqUmorR0VnRkNEWjJycHM2Sk9SUjh2cjU1K1FOQi9oOUNuYmlj?=
 =?utf-8?B?YmF6OXpiOC95Z2JmVnA4d2hKcThsTmxOWHVrdm5LSTlzdTB6UkQrNE14ZzhL?=
 =?utf-8?B?Q1UrOGM0ZWdHM3Q0cjNTY3A5RStwZFl2QTZYdTVjYmR6WGxKWWh3VjV5RWY4?=
 =?utf-8?B?aWczd1ZYSnBGSkE3VnpWTmZ3SjJxaUJrYmdsYmlTbys5VVZFZ2F1NTJTRzBu?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd373ac-a549-455a-7a8d-08dd5265d4e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 10:52:27.6357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwO3B5fl5zrl8GOgSzZGk7xXFpqN4P2ze9XhKM0T1nTc3etsEpAliih68A38acCTncUpDcwkEigtBeiDfYh7e8lSleIxzhcj6jM8CqzzVIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 10:52:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17275

Hi Stefan,

Please Cc the docs mailing list as well

+Cc docs

On 2/20/25 6:27 PM, Koch, Stefan via lists.openembedded.org wrote:
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>   .../bitbake-user-manual-ref-variables.rst        | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index ad219b531..f781c004e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -315,11 +315,17 @@ overview of their function and contents.
>         mirror tarball. If the shallow mirror tarball cannot be fetched, it will
>         try to fetch the full mirror tarball and use that.
>   
> -      When a mirror tarball is not available, a full git clone will be performed
> -      regardless of whether this variable is set or not. Support for shallow
> -      clones is not currently implemented as git does not directly support
> -      shallow cloning a particular git commit hash (it only supports cloning
> -      from a tag or branch reference).
> +      This setting causes an initial shallow clone instead of an initial full bare clone.
> +      The amount of data transferred during the initial clone will be significantly reduced.
> +
> +      For updates, when keeping the cache within the download directory,

I guess by "updates" you mean pointing to a different commit hash to 
fetch from the remote?

Is there a possible setup where the cache is not within the download 
directory? Not sure to understand the implications here?

Cheers,
Quentin

