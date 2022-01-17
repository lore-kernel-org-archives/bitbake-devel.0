Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCB8C433EF
	for <webhook@archiver.kernel.org>; Mon, 17 Jan 2022 15:04:52 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.89])
 by mx.groups.io with SMTP id smtpd.web11.12367.1642431889878857491
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jan 2022 07:04:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=aYicYlNB;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.8.89,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxO+4vgpihm0xvTxZDbwqjyNe/yw5uTSw10T2AGUv2GDoEktvGbOFRrWUlN0AEHxhy9SArtWYURK0c71NFafJw4cyLGRM7zKhvInc0TN+PcIFmIb9QHKjc2d0W87QcQYblHTa00mFibYR6KI0ylARlXypvC5Q5oNY8/Jn7SyqgFouhDD4ydD701VFEvxsCvhyZ3AY5YLygT4LyiVIdmjDuT2G50JMSFquYDcLgnaenohFfX6UCE+sab5dWImtJ1YFRuFnU0TkRyp9XpC2UfN3PHGYmEGKW0CCpjrwIG/nXbpxJtj8D1J3hSoVVeTLMmUIcxXX2riSH9yOOyQiyltFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kvsciEqrhj1wQnmnB6TO44hS8TKDEiVJhXSQmNEDAA=;
 b=balRsLAlmTCrJvg11eInwnrTpazEALEx8/b5LzL4thvjquBv/eqv21MEqS5bmy8yn7Pnjfr+DcoG4P8hZTP/hVI3x3Y4CP6u0blgbp4flRt8bN3TRGpEvOCKBhEG94cIv4qMcTkG9HPM+rlIiJ8/+7xOZEPEy1fGj6g5RQmb9Fw8BJiGRlUH2ODoqPbbRzO3BpMrK6s7shhTPXelZn/qEyf6mETgVbKig4I/Tc5aJAjIr8IxufKy4MsTiRSu09cXKVocKZmhRThINQENnA3IldaqEglMtf3+LaA16FMlvNRE6LJRbDxi8Er2Iz9aSLrNlBlj6+RLYUp1Eum+tznc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kvsciEqrhj1wQnmnB6TO44hS8TKDEiVJhXSQmNEDAA=;
 b=aYicYlNBGkfZMfYbxIgetwxPS2EvbLjvfKiD6faX44PBw0ZD1mwwm0zwubYCea/sOwL70wXAdz97YLmZKVujxMTIjRhvu5ur9FgLWgh3nxc41uLnnbPTRteSIW0A2r5kXX3vbYp/wNqt34BapCYwbJJiVP2MKTzw5gOcLkMLLrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by VI1PR0402MB3808.eurprd04.prod.outlook.com (2603:10a6:803:22::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 15:04:45 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93%7]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 15:04:45 +0000
Message-ID: <6f110600-49bc-b09b-f04f-5c132041ee24@theobroma-systems.com>
Date: Mon, 17 Jan 2022 16:04:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual: specify the URL to be
 used with SSH over git is different from `git clone`'s
Content-Language: en-US
To: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Cc: Quentin Schulz <foss+yocto@0leil.net>
References: <20220117130816.104203-1-quentin.schulz@theobroma-systems.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220117130816.104203-1-quentin.schulz@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0185.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::15) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99c1d78-380f-41d7-a487-08d9d9cab2bc
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3808:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR0402MB3808F5D99D6BFAC0CD4D7E62C2579@VI1PR0402MB3808.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XJkjV6YqQaw3E3CKSLHsF5eOIsbdB3Q/oikkSG2Yf2zEAia16sTQwyRP8NsEut84s5kYxhArWOf0lbvpTGQ733WqiEfTB66Fw1zk/FZH4QxeO4f0ojEgN5w1ngFuyJdDYMclh5sLplglohmj5vJKVe6c/ogeXNjRjoMfpvpN7NkU9WlLNGXuPQCUvqsOzo6LeP44IfOuQQ1nyfAC/TcNAmIhokKSvFrtjHJfhP9hFuNSmUG2B8SOIyhRL6dUh5DVF+O+Smj6jCxvCZFg5+rIiQliCaqH+PglJoVn3OS0pT+a+kcIaOJub1s43IhGC7wIAKm4zom1aF2Da+3ygVm51LJIwPRlAZ6xGujyHD2shKF7X15HCLWpFS2v+bqOH5N1fh6ixzgmBsgPJLGnZ0CRe3I2Bi3G2NChBqK4jnZFHxqB60Y7THxK0zis83VgUdqtimyVq8aBs3+w0pgKIe05HnJ1MXA9dxO9kvyL7ZcXj11ilKXFqG3aB6T9ENpUiZ7Gnmm77ZXwXajF/H7GE0ln9dcFevLpq3AjogjoO5T1HAwodW5qMrTHPh90AxuO0HQKzKhqPEnk77VujDLjvRWUiBF9OYpCFJ6ldBMCi9pD8X00YdB1ALI/Oh43QgRpoEDucY4/qW8gzWI+5MDU+fGUUFMbZCVCsCYjPcCGGJEnXflUqjt3Wf0tKPFm6TXOQla/X0/LuYo7LD8x4Lbq7jGfvdAKd9cys5u+uM4vl6w6nwB8vLCEfzTb9spPXOD6T+IDlvqimips4Fei0bdvqrXPB5O8vcb+I2+qDMXN4JDxHiMc+1O6rqS3njrVn4IYifpjs5Br1DndbTtHVa1mhfU9GMAX6vBMFxNDJyPq0KcG639tkt3RwjeeH2+NWWI1OR3m
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(8676002)(6512007)(6486002)(38100700002)(31686004)(86362001)(508600001)(36756003)(186003)(316002)(83380400001)(2906002)(2616005)(5660300002)(4326008)(66476007)(66556008)(966005)(8936002)(66946007)(53546011)(6506007)(44832011)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2VhWUxaenhZZ0psU1Z0MXcyeG9MQ0FhL2lCTVNIMVJyTFNWVzV3MkZvUWZE?=
 =?utf-8?B?RlNZaTR2NWlWUU5wV2V4aW95dFZuQzIyazFYOGtTcVA2d3Zwc0FFOTV5RDRx?=
 =?utf-8?B?VGhZWmVGeDdMVTFMWEJlc0IyR2c4TFVTWmpjWjZZcVdObFBCU2hKb1E4aUt6?=
 =?utf-8?B?VkxBRFBEenpYckFEYzhCbDlGczFWQjNDMVJlSjFvdHB4WUVEL0Z1ZlRVeEt6?=
 =?utf-8?B?eWlkdkJPSVN6eWxPQzlCSTZuRFBUbW5qQkdDU0RxQjhzRjI3TFhTdjkvb1pM?=
 =?utf-8?B?T2w5U1NvcXFvMFc5YU1HWmVWa1NQMzJzVGJWRGU1cDZiQnFlMlRRY2x0aDBF?=
 =?utf-8?B?RVR0YmhMZFY1b3RqVVRwZ3MvZ0VaQXh3STF0N25IU1V5MUhvdHUya1JaeVEw?=
 =?utf-8?B?UnJQRVhOVGxNdzg0dm9qZXZYck5tcXZUMjhqeG9seS8yNUZaV0U3M3pYTWph?=
 =?utf-8?B?bEZ4NEsxZFo3OFZBbnVWMUZvZTBkVVVTa2l1MVBZaXVoZ09hSEloeXIvOFJF?=
 =?utf-8?B?MnluTVdEbjlCQjlObmc0NkFBU0VWMWd2Zm5JbmovbGFtUytWWjdNUjI0MSs5?=
 =?utf-8?B?T21nZnE3dWJDWXBHeGlNQ29qaHpadzE4ZmdTUGdKbG43ZW5VK2l2NzZhSkhX?=
 =?utf-8?B?clkxUFlYcjgxWTlSUHRDVkJLVVdsSFVtdkgwM0Q2MkZZanFjYjJxZEQreENW?=
 =?utf-8?B?dklDSDdjZTJjaUtmU0JYRElkL2pMbGRFd0IxeW93TDNEaGRMN1hmbVA0bURu?=
 =?utf-8?B?aE91RXRPTk5MSHBVYk5rWjV6K3d6NjV0bXVUL3hMWC9FbldpcTF4MjBmL1JQ?=
 =?utf-8?B?bFpqWElqdWs3WVVTRmQyN0xVNklxVG54MGdKV3hsUkVteFlzVW94aXNkQlpv?=
 =?utf-8?B?T2JpNklUR0JxbXJVWjgzbEZHL0pDcFR1RkhNUGg3WkFOVUt0amQrV3NNUThT?=
 =?utf-8?B?c2p5OTcza0FKc1N1RFowZ1pocTBQYUFhNzRZNjRJc1JHMGFDblozZ0xBZFIx?=
 =?utf-8?B?Q1BDOXNxa0lqM1ZYYk1CV25ydGtaU3QvYnNQS2RVYUk1NVVDQzVacjROWVZy?=
 =?utf-8?B?R0VNQ0tDckF0R0VGZjZoVVlDcktLdktNZEt1ZXBnRVRrWXBJVlNBVHprdEU4?=
 =?utf-8?B?dGFxSllQM3hGNnl0WHFhMDdQUlhydHBLWHJCQ3VCUXFERnBLN3l3eW5VdDVj?=
 =?utf-8?B?bHlUNHlhR1p6VGZuNFJGcFpWTnFEM2tPV0h0UTJtMWgwdVRyQjV3ZFVTYXQx?=
 =?utf-8?B?QmZUN0VmOVg3bDdRV3M2amtzOE5YSzFIR1l0Ykd3TVhMdXZDanR3dlMxc2pR?=
 =?utf-8?B?TFJ6UGk0VW56dFdQUWlpYW5odWpyV3JwK2x3SjFMWWQrQ2JmTW5CNngvMVU0?=
 =?utf-8?B?Z05NOTVJei8wN0RBL04rUmJhMG5zYld1VzNvM1hwR00xaHptUzdVcVozOG5I?=
 =?utf-8?B?VTJoRzA2ZjF5L1B5WXBVcHJPcFpPY2ZDVUttWFJDbHpGTzJGMFFXZzF3M3kw?=
 =?utf-8?B?U0hBSnRuTXFYajBjVjRJajk4aUhmR0lRMTJoTmRJUFZhdk9HTnRRWG0vNjR0?=
 =?utf-8?B?R2xteGNtNFpHay85aFJ1WFlZWllpdVJ1RVR3djF2R0pVeVo5NzhMcGFZWkNs?=
 =?utf-8?B?ZzZlREpXa2pjVlJkUURUVmZHaUdzaVpSS0Uva3hPMXZCZjJvZDQzYTMzaC8w?=
 =?utf-8?B?UjF6dlNvdnpsUUp4UDBRa2FvMUJ2dXQ2SmxhdTRTcjZENUo2WlZkOE9kUTZU?=
 =?utf-8?B?OFQ5ZXN2elpIa0NCUTN4bGljOHFHRVUvZ1h3M3VwT1dUSE1uVzd1djd4S21j?=
 =?utf-8?B?cGdTTE5OWThVdUJsSWhQMWZTTjZRUCtkZVhUT3VITnlxcXpiWk1ldkFFdENS?=
 =?utf-8?B?QlRxNVMzNkE5VS9pa0xWSnVMN0JPeTVyYW9tWll5TmFqVVRNK3V1aG9ScllP?=
 =?utf-8?B?dWF0dEtyU2xQRVpweFVrU0lON1NIUllnUnlvaTlqRGlVV1lNUk9GKzZZTGli?=
 =?utf-8?B?RFc3UEJ6dER5bUh2VEtRVnhLOStPMzlGSGkyckZNOHluUTRmd0lTSUV1d1k0?=
 =?utf-8?B?OGxXalVVZkFIbFBHOUZ4K2lPM05teU5IRWxpZWtYM3NOY2hwcnh3aTRJdGJZ?=
 =?utf-8?B?TWNTaGZJSjN1VmYzWkE4WHV3dXZWRDdRR3FMZnQ0Uk5NRGJvcWdEV0hsUXZl?=
 =?utf-8?B?WlJ6NCtPMUh1OTdFZWtDd3l2MWZGWFlxYnJOdXdTSXFzTXRNUCtvcUc3M0ND?=
 =?utf-8?B?WnJlK3ZYekhkTHhJNCtERWJsVGtWTmRRNjV0QkZJTEtiVHo3dUl0bUgxQ2tt?=
 =?utf-8?B?dExGYzE2YzMyZEZZdFBzRk9oU2Z1TjdvVmdrTlFpNFE5ek8xRFdtWE5nUXVY?=
 =?utf-8?Q?r0eTg7j0OX7s4zkg=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e99c1d78-380f-41d7-a487-08d9d9cab2bc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 15:04:45.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 WPTW5k8ChnoG0CLppvat7g4YOqu6hNTTJ8vhUZK9xKu9aIbslhcg0i4/fDYuQDpMomsrNhTrym2a2Ot4mOrJ3GZvwD9m99s+gCT5Rs5aG19GElXSC+5ML0RQf+3V6+HM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3808
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jan 2022 15:04:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13238

Hi all,

On 1/17/22 14:08, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The URL expected by git fetcher when the SSH protocol is used differs
> from the one given by Git servers to be used with the `git clone`
> command.
> 
> Add a note making this specificity known to users.
> 
> Cc: Quentin Schulz <foss+yocto@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   .../bitbake-user-manual-fetching.rst               | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index 0fc2d5e699..77384cfdc7 100644
> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst

Forgot to make the patch from a subdir instead of poky root, lemme know 
if I need to resend a patch.

Cheers,
Quentin

> @@ -396,6 +396,19 @@ This fetcher supports the following parameters:
>      protocol is "file". You can also use "http", "https", "ssh" and
>      "rsync".
>   
> +   .. note::
> +
> +     When ``protocol`` is "ssh", the URL expected in :term:`SRC_URI` differs
> +     from the one that is typically passed to ``git clone`` command and provided
> +     by the Git server to fetch from. For example, the URL returned by GitLab
> +     server for ``mesa`` when cloning over SSH is
> +     ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected URL in
> +     :term:`SRC_URI` is the following::
> +
> +       SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;protocol=ssh;..."
> +
> +     Note the ``:`` character changed for a ``/`` before the path to the project.
> +
>   -  *"nocheckout":* Tells the fetcher to not checkout source code when
>      unpacking when set to "1". Set this option for the URL where there is
>      a custom routine to checkout code. The default is "0".
> @@ -446,6 +459,7 @@ Here are some example URLs::
>   
>      SRC_URI = "git://git.oe.handhelds.org/git/vip.git;tag=version-1"
>      SRC_URI = "git://git.oe.handhelds.org/git/vip.git;protocol=http"
> +   SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;protocol=ssh;..."
>   
>   .. note::
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2416): https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.yoctoproject.org_g_docs_message_2416&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=_l7-tAR3swWTH4C1S8UI63LA1SPlO2MekWnZZJITMwpYJava3108u83_dMFzD5LU&s=F_w0Ot9oRIjE4kXGRrG-cjdVPE5_S0uSmhOaV74rLKE&e=
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.yoctoproject.org_mt_88483091_6293953&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=_l7-tAR3swWTH4C1S8UI63LA1SPlO2MekWnZZJITMwpYJava3108u83_dMFzD5LU&s=-nz5CF1CFvGdLoLVQGx84M1Jev0zSa2FHRJ-xAWXncg&e=
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.yoctoproject.org_g_docs_unsub&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=_l7-tAR3swWTH4C1S8UI63LA1SPlO2MekWnZZJITMwpYJava3108u83_dMFzD5LU&s=9I0R47Ub2WW27sRRxCqP65jf1LHTx4TU4dhRbBOu888&e=  [quentin.schulz@theobroma-systems.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

