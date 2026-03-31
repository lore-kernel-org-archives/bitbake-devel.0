Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC6FF60F6
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 09:00:45 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15869.1774947641511315783
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 02:00:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=T7PlvlEo;
 spf=pass (domain: cherry.de, ip: 52.101.70.27, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CShI5JDaSzsaEJIrdh1YkwjL2+pbsWHlieCcxAhOgqMfx0TjVNj5Gs6ugK9ziR0HkKS9sK6WBRhBjtImGK/dzgI+QYAJPotkAuzuy7K10yBwXqumbdjvMzDSApc/uw2ec4esdLc8lQ2so5X5gibppTu1ktx0rwYPmvnGxr+SEbPR42JuGJa6xbCbXkJa2VIAz/jxCbgtwBWhwB6Pk410JJrCqFZGAWUeD6+4rgLJpoBM9jhyPtmRDVEb+PJDkv5fXpj3kgwxW4VKdyDBrxEvjTNQtZvVbmkLAYA/wIwElyZ4PG/gSXawTQGTmWNvt9csH/H5RjyJaG9jcS258UkZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiB2c4p4HIwAzv8joC7bf1fzD1Wf4nRmBFmD1/hxNOo=;
 b=rsDbOoJzc2rHMMbyluVNcy8ae4Ud6iLPsJzLa5g/CFfKENfm3ficeNU80aBHu91FqHIQs32hCGz4htlQ8w+x97xFsjqoafYEufYCQtcDE3/BVcW4YV4B0Ah+x63r0ajVlioYxXyG+cL8+ecEQzrDCKAz7sVNXtC2BaG4QelztUUCBOg3bHmuYmO/W43ZFIkY+nbBtaqeNDBPxi1tC/Ho0528zdyb7T7MWrLmLEX77dFbW2y0naFNnw6bz9ohaV4zLJwKy04gYbBjQZVEzyShN1eYg2e7fb0wAF2i3csZPuH+WJshwDWE+MordU1Fxc6a/YnHOaO2SnvnI2h5O1qxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiB2c4p4HIwAzv8joC7bf1fzD1Wf4nRmBFmD1/hxNOo=;
 b=T7PlvlEoWY6KMDUqZJe4nVYLJrKJbnmSV+rtcncigoj4PBmtw6nE+v0qD6GyNZEfJ45sxEnl1z5oht/I/HaPe6MOerazqJo1pdC5Mb3dSQBUg/kk0CQv4NJ1R1RHev4SETN0n5mf2FrsyPNda8rJMSxEg4EiFa4OapnN/i+isVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 09:00:37 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 09:00:35 +0000
Message-ID: <6f743774-fe4b-4e9e-ba99-6ffe1d76a51b@cherry.de>
Date: Tue, 31 Mar 2026 11:00:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH 1/2] bitbake-setup: rename "abort" rebase conflict
 stragegy to "halt"
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
 <20260331-docs-fixes-v1-1-45ee34341e72@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260331-docs-fixes-v1-1-45ee34341e72@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM7PR04MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ded5bb-7a19-4a80-f2b2-08de8f03f8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	AYUFxgpNw9Ith1nrALnxWLtPgXTP6neOI+mQJpK42gbenMGRmT6zp8N/lRV2J9B9h+XNL7vWD1ewbe/w7IURweW27hTYAYVME2UqTtapzG7XochPkHj9d2AKRgXK3BxpAxb+pj2GIcP4h37bp08RCLsdCimqsFTUJOEpgwZ7NgcrnZqBf7Nt4N1aa8ShQuoc29f4D5Ebj0PAlR0h/D2+zU0Ja1l9lrLvy9XwbrupdONmH7xoFs8gH0XmbcwrPnHSM9c0JrbNuLB3jaFJfSL3iwMWEtHs7PcfbHgtmZ2LNJJOPH0XnR0qU+hQyifQeaj1MI5mDiKRnQsGSu9zyZ0Hwg38nct8B5VRL2W5rv1JrpHNqlvGWwTpcKGcT3FiZDvxHF5dmZjPoFIeZDW1lWJqlcmUs/4VUOgSeS8kZHQMcsIBKI2ihSpZFjZU5w7Qv14NyswXgjhDfEWCi5mqKXfqhHpRqzU1h0A7oCuwg6iJREfeTooTfQKbUsdk2dtK65Qp55q6CAshJef6ioIdpk4BlVf4BbD+17KmvZjFgt3VU6+o8Wzy/p9DN2HUlzgk7Epx+Ay8Y6lJxux/CYosCuq46VnFBnjnn+pcpDHylRbFQwGNg0FOvlb5Npsb5I+sldAZgsu6IBWN1836UlwwYXd8J50TL7bb23+AJfRQmxCoVqaXSQ4ccYrG4hWWzemOiN81
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGRsRWt5Uzl0b0U3UGdwWjRpVThRWldoTnU1bVFNMXN4NTRhekg0Q1RvVWtV?=
 =?utf-8?B?N0FtSG5pZnB0ZC9rcXY4NlNHeUFER1B3OW1TcHhJL2hKZnBSMW1laU1ZbEV5?=
 =?utf-8?B?VTZmdlhYY0tjd0pob2hMcXE3cFdkTzBVVktZbEZaaGk5bUVDRFRhMEdqV2px?=
 =?utf-8?B?VGFBUTlXQWxHNXFvSzZVby9pc04xVEl0YWI1U0YzUTBIUUVia0VUTDdxemQx?=
 =?utf-8?B?aXQreWNVZ01wOW5CM2NidFBTZmV0ekt0NGZUM3M0WmdqY0R5YmdQTjdGV24r?=
 =?utf-8?B?cXVYSS9mcmxMQmJXczhLem9GVWE0N2VjTTVyZFlrV1R2czQ2dTZSNnlnV2pp?=
 =?utf-8?B?Ymd6VytJVUJvK3NqMFV2UDJNWXQ5QXN0SVZsU0ZEVk5sQjVWZGZtTy9wdTFh?=
 =?utf-8?B?c3hWdllxK0VtNktkT3lseVBpeW8yTHY2akFuOEV5SWMxQUNtTzdyN3V1L25T?=
 =?utf-8?B?TkNOb1BTbm53R1g5czZkbkUxUEVGNnAxTjRVUFo2QktVQ29ZUk40S2ZtbVY4?=
 =?utf-8?B?THQ0bi9lVVYwbHpmYW5BNlRUcm9WZlFXRUorOU00S1MvZjhlSCtoVzhhOUFE?=
 =?utf-8?B?N1p1NXZueE5ZMHIySERLSTNEL2VzSzZuNDlyUmV6QXpjYTI2NG4wMExYL3cz?=
 =?utf-8?B?VmFDTGxoRGZ2SGpsMVE0MG5UZ1drZDZYaFhjVnV4ZjEzNXA1TGZTQkhCajRI?=
 =?utf-8?B?UDFpMG9Mdk9mSHV0REVEUE9IM0QxUHpzSWZjNkxYdTRGOGc0b1pEaXdIV29H?=
 =?utf-8?B?VWFkY0tNbVU3T2lRSkpLQVdEQkhndks2NkRkZVgxM0tORSt0c1pDU2RJV2Q2?=
 =?utf-8?B?aTBGTXpsZHJQemsrMCtTMXNyOUExTWlaQWV6dnVQZEtWcHoyY2cvbmNwZ0hC?=
 =?utf-8?B?K0JCQVJ6TXlqSkZDeVVxUmI0bFlRNzMyYm9ueWFpUThHM1Z2YW1xdXZNVUZp?=
 =?utf-8?B?Y01WUTFnci8vZW5ZSUgyYURHdXBDRUhVUXI2RVZ2Z2xKNWY0OW5WaTljTjFn?=
 =?utf-8?B?aXU0TGd6MXM2UnZWK1B4cTFlYmRXMCtFemEyNUdXeUdaTlNQNlAzaTc4aXY1?=
 =?utf-8?B?dEk3VEtUQ0V6WTBMTW5PbkdpU05QQXdWNmFTUmpxZitIbm90aGltT3huZnJC?=
 =?utf-8?B?d2pUdzlDUDVxdVhPMzZkSkswSUVPSE5KM0xKbHVVODA5MWUrRCtwTVdSdjd4?=
 =?utf-8?B?ZkhDdGxtL3RxL0NEdmZ2MndYWEJ5R3d5ZmNxWTZ5RElNVU4zTHYyYWgweUhP?=
 =?utf-8?B?SGQvUk5pWEZoUnlUZnkzSW01eU9YWkZKTGdDbVoxRytzN2NKZENsLzJvUk5s?=
 =?utf-8?B?eTl2dVBOUDFWdDhFUXBMRExzZG5kNWlwMmNob3dadjZzTU5jLzJIRW8xYmZy?=
 =?utf-8?B?WnBBQ05xNnZiZTRnRkFUUGFmdGFIc2p3VVlSZVd0bEdmdURuMEQwU2J0bXpV?=
 =?utf-8?B?ZCs2Y3kvVGRBc1FGajJRK1JlRXhIU3o0WkgwNi9lakhuekg3bGRReFIrN2hC?=
 =?utf-8?B?dWtpeDB2UTMvN3dZbzNmaC9NN3Q5MGhaaXZORDVmb0JydVVSTFlVczk4QXZH?=
 =?utf-8?B?VmNBdXpTY1pzeHpaNm9kMW15bVhPREk3SmQ1b0J2R2YvczR1WG4xUHBGTEcz?=
 =?utf-8?B?WW45aXBwOFIzZVEycEZnejJHcFBjNHNjNnlWT1orTG5rL215QU5zVTkvcC9U?=
 =?utf-8?B?c2VXRVVYbGs0RGFmeUpKQWRGbTZvNmo5N3ZHeVJaSWRJYkNLNFpDWVRieUpW?=
 =?utf-8?B?eVpsdDNRZTliMXczTkdIVnlURlJtaDB6OU9KaWZKUDg1eFh3YStQZitJK2Vy?=
 =?utf-8?B?ZG40OFNMcFFHSkRUSS9sZE1LdXQ2eThvSlB4c3N0VXN1KzhYQWxyUElBTlBH?=
 =?utf-8?B?ODErYTFpOStWYVZJOFFqNDQzcmRZYm1CUFoyR3pkYWdHZVBjZW5MV2RFSmhL?=
 =?utf-8?B?V0xtZFJ0ZGdYK25TaEVGTXRtOEVJcUZmTTNHR2tBb1pTUWo5ei95S1V2RWp5?=
 =?utf-8?B?eStZVmxDOThQWkoveExsdW1tZE9aMDFPL0ViZTN3alhNNVJCNkR3Qng1SmFy?=
 =?utf-8?B?Y1FGeEhzTFk0S3RHZnRkclVxby9xeXBwQzlhZVJZZklXR0FqME85TTRLOHNJ?=
 =?utf-8?B?cHFWZTZCa0Q3Y0poOTllSUJwN2l0OXJKVkE1dDNRUUlZNndWNzAyNmZyZnNw?=
 =?utf-8?B?S0ZFOXloVVZVbGVHZDdEUzJESU83RUhpelJVRHdHMmpQSmYzeldMTDBkQWcz?=
 =?utf-8?B?N05qaC9nSlI2OFp0ZEN6UUh1ZXZVeVIrTldORDhwUDRwUkRQai9jbmNWMTc0?=
 =?utf-8?B?Rm5xR0hobDRyTVQwRXROQldTc2FacDA1aGJCeXY4cWNhQ3RVUHM0dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ded5bb-7a19-4a80-f2b2-08de8f03f8df
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:00:35.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4q7BAAayobLrMXzMxofVg1B0LkCM5lX7mGEYMN7x8VRUVSmTL7vsutAmq98sBGLHp/JIN69cpyR8b05Gnbe3AYu+VsW1GXFxTePCEBuDjP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 09:00:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19289

Hi Antonin,

On 3/31/26 10:14 AM, Antonin Godard via lists.yoctoproject.org wrote:
> As per [1], do not use the word "abort" and replace it with "halt" for
> the rebase conflicts strategy. This is something we try to follow in our
> documentation.
> 
> [1]: https://inclusivenaming.org/word-lists/tier-1/abort/
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   bin/bitbake-setup                                                 | 8 ++++----
>   doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 6 +++---
>   doc/bitbake-user-manual/bitbake-user-manual-fetching.rst          | 2 +-
>   lib/bb/tests/setup.py                                             | 8 ++++----
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index b02cbc2b1c4..33cbefb4914 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -167,7 +167,7 @@ def _get_remotes(r_remote):
>   
>       return remotes
>   
> -def checkout_layers(layers, confdir, layerdir, d, rebase_conflicts_strategy='abort'):
> +def checkout_layers(layers, confdir, layerdir, d, rebase_conflicts_strategy='halt'):
>       def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
>           rev = r_remote['rev']
>           branch = r_remote.get('branch', None)
> @@ -458,7 +458,7 @@ def merge_overrides_into_sources(sources, overrides):
>               layers[k] = v
>       return layers
>   
> -def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='abort'):
> +def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='halt'):
>       layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
>       sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d, rebase_conflicts_strategy=rebase_conflicts_strategy)
>       bitbake_config = config["bitbake-config"]
> @@ -1273,9 +1273,9 @@ def main():
>       parser_update = subparsers.add_parser('update', help='Update a setup to be in sync with configuration')
>       add_setup_dir_arg(parser_update)
>       parser_update.add_argument('--update-bb-conf', choices=['prompt', 'yes', 'no'], default='prompt', help='Update bitbake configuration files (bblayers.conf, local.conf) (default: prompt)')
> -    parser_update.add_argument('--rebase-conflicts-strategy', choices=['abort', 'backup'], default='abort',
> +    parser_update.add_argument('--rebase-conflicts-strategy', choices=['halt', 'backup'], default='halt',
>                           help="What to do when a layer repository has local modifications that prevent "
> -                             "an in-place update: 'abort' (default) aborts with an error message; "
> +                             "an in-place update: 'halt' (default) halts with an error message; "
>                                "'backup' renames the directory to a timestamped backup and re-clones from upstream.")
>       parser_update.set_defaults(func=build_update)
>   
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index c22e19bd665..c7b73001404 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -458,9 +458,9 @@ In addition, the command can take the following arguments:
>      local modifications or commits that prevent an in-place update. Accepted
>      values are:
>   
> -   -  ``abort`` (default): stop with an error message describing the problem.
> +   -  ``halt`` (default): stop with an error message describing the problem.
>         The repository is left in its previous state (the failed rebase is
> -      automatically aborted). The error message includes a hint to re-run with
> +      automatically halted). The error message includes a hint to re-run with

This is not what halt means. Maybe 'reset' would be a better choice? Or 
if you really want to follow the recommendations from that website, I 
guess "cancel"?

Cheers,
Quentin

