Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996DDC433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 13:19:11 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.92.73.18])
 by mx.groups.io with SMTP id smtpd.web12.969.1635859150181720557
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 06:19:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=qjAbA9j7;
 spf=pass (domain: outlook.com, ip: 40.92.73.18,
 mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX7qXGuaPluN5+Gp70zdchTXo0BZjpwzwINdlbUoLc1G3CfGYTk8AdwM3sMsBePzHmPFEoR3tQZmHTB35CIZFnI2I7HSaXr47WbD2hbJv297F+OxY72wn3aPfEuKz7QM010Rhuj1Oltd8xcVkgyexyGzN9X6YFgQUn6gjZofpL5Jjr51ELbPkUMelxDBTIGXeXjD8/ll6CRWIazj0xIayTd8Pj6gY8FgrzkCqH20eN7/wt2EZVNalbSLpyIzQxnJ1u63JemPcTEabumiAzDGfARUJD0BMbuLYkNkp5YfLFPlCqUVV14eWKVaOg6t9sxAkYHUlDzeWr+U/KhkNh0xWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wO7xIJNq7BvIKVRJcEQ0oQlu5pDY4wmHu+alsOACm8=;
 b=XnuBmT3PlSX/E+bM8MoKDCRT/lbfJIV9TRElktfLNVU6luGwji17JrUdDGaQU359tcaJifpjpvtcJ0mfZ/M/pLAhGdIiZ3RMer3hfYAr3MMbq3jfIBXPkJjIwpFbyN8YjeeC47T1P735kDMigZb1I0bSRnCjvpfFcUkE099zH/zvbwIk6OAue7IcBx9JRPljzKEulOFyAIr0ETFrgNPUpj1t1wSpuvEIiJTLCl3xEj1J+lBQgUm3jpoS1oYUmTRlLEqaMI5RjH2jZMMfc4y/IEa7FZiED3ZuHg590CgHJTyLxuYOMcrB4YxlTjLXw87eUk0BMSmKxKGOpaiK2X+rpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wO7xIJNq7BvIKVRJcEQ0oQlu5pDY4wmHu+alsOACm8=;
 b=qjAbA9j75dOHiO1ud2KY71BXeB7gxuKY27rl8pvdlyYpbeWQVLA8eaWYCJM+3QSU+Fh8xdzEJC4yJ03Gx8MnFYbG+9PiomFiTd8cOu+1LhghSHagyyvxpHAtnMUq4K+cUL/aTWnq2t7ti5JRfMDQmivM/uyC+nXl0sMRPzZ26DhQDnyNG++68O+S0n+Lbt4NfkmSPMYsMG2PsfuoO4Itw3BwcDEMybYmgOcJ8q5lyN+p80LrbGRActI8Ems4eq9GlvKf8cqNlhnL+if2HNin5S9cJnP6tnwHfY1086DDkQPk9N3mnsw1ZBHt9qY01NO0LWH2vkh3qbTh3a3Y4+3h0g==
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com (2603:10a6:20b:284::24)
 by AM0PR09MB3635.eurprd09.prod.outlook.com (2603:10a6:208:18d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 13:19:07 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710%4]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 13:19:07 +0000
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
From: Konrad Weihmann <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB4642729BBF86DB48FCA16DFCA88B9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Tue, 2 Nov 2021 14:19:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN: [UxAtwMYzAW3WhYhI4g8zXNAl4/KQzXDknhQ7S/SywL4MQfDK8oWej2eyoNWydEg/]
X-ClientProxiedBy: AM7PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::36) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
X-Microsoft-Original-Message-ID: 
 <28ab85cf-6935-a8be-2b72-eba6fd4943df@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:3103:205c:200:bed3:df7f:f488:16a2]
 (2a02:3103:205c:200:bed3:df7f:f488:16a2) by
 AM7PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:20b:110::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend
 Transport; Tue, 2 Nov 2021 13:19:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb465b8-756f-4812-b21b-08d99e035956
X-MS-TrafficTypeDiagnostic: AM0PR09MB3635:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1rgaZARlP+6l8BFiy7I73A4JV0q+6xuFhaW4yXwVd/SSNCRg4mBSHWL8yVn2L490Sw6OgQGO0pjFAhKDlt03tCikeK2sutpe/LVeBQGkXyguKaKQAVq3o5qxah4edzBiHWO3vktqT5JlBJB/qcr0d1AJz+HjsDgtEP7m5gqrPqxS2omvk5v9i8VgvsrzWIIj+4Eorgf95Icfp/9FPyLDudiu6KjvN2rXfNV48eXxufLoiWCDlB/SogMEgfALkn/tlJmjYZ48Oa75nVBLWUHBMJS/lv8gBfLV3EGSPeHUVMtm8PskaYo0OJDEfn7md2x0ZGLJ1gQPBagJt+rKwnW5oWKT/mkV8P1gfuGt7aOfqMDtIqhKilUJfcuzaNu2AKFG56xRrm2C6XEGAXSKayAVnJAFKoPgyL159beA7viUkrRcQcnKJW3zCpVkW62+1/7ecQVPh+ej77WY0/Xyx4Za05HJ0mOaH0GTAakzyRS1s1NYRpIFD6pjQwny1hxXSLG8rESCMht02uP56088mu4yu+B3okzlSbDpVZZevJtrIZH8D9xTOiu8YwQzheEMig2FtcytkLYfY1n6yiCt7SFeb7xg/M02RfJZA+JA4GAI52Zl1ml3/0tXo/7g4mzfRkKN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	47DdwfoFXfF36deQg4GAvJupWESYMWnO7huip2LFocHwuTp4bRBHuFt5NYiXFRrn+MzcZipcDfmQx9p3ya7/6G2EFHDhkzmVPMpU2B729YuFve5QyPcYUzaWD0EF4zkgvIkfSJh8BcibTMeVgjbFuwePLDC+dp5r7lmJiv8/9s1iWPgrFV755G/SaEgylGbTsgXH0IQIXkVgNA25X+qyl/1O63OHofndDqJZksteINbB5HQ9IUy6sREXTQWHr1H2lyiJEkmqn4M2HLK6EPRlVmG6LQ6FdZXBpusuc5MAx73vwnmOJvtsMN7sqbDihvOmJM2NqVcbMxeqpaRiiH0jyGm5bJEWVrhnLEVrQb9ohn43LvLBGzJ/7Zg5oGNdn+1mWah47Xn2rlQbgT7NxNxG6c5E1t2AIcaxOQuGGqiCwxn+YhIkUBcsB3k65NUJYIEoOTgnf85lwCTaD1Sui40qpvFqC3W9c3p8J+1My8bql+TXc1DiYsI4nxS1UXSQ03YiYVgcojbzzhO9z6qref+G/4l/HWpCdqFiEhELVdvr9P0WpKO22gHaxK1ShzvAhwRVwH8UaDO0cW0MNokayunq/lYVcaBayj4D8nyArZzcgY49QJHvjZ4i7mdgVh2Bp1V7Q7iZ1+N6GJt97qhGbXZNebek7IeAgHkhwrg/6IY0ryBZcGc1tJybgewcypJIPOezBuihAwpGqRy1geUmT4W2iK/m6MWt6YD7L/LqHOPlV003FtM9Q3TCf3/8aCuXV1FfD8QacvbBmGaEZJ7i+ZJzNg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7cb465b8-756f-4812-b21b-08d99e035956
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4642.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 13:19:07.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3635
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 13:19:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12858



On 02.11.21 13:44, Richard Purdie wrote:
> github is dropping support for git procotol iun git urls. Add code to remap
> this to https in a way that could be used in older bitbake versions.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/fetch2/git.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index e974445fbe..f5be24d6ab 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -142,6 +142,10 @@ class Git(FetchMethod):
>               ud.proto = 'file'
>           else:
>               ud.proto = "git"
> +        if ud.host == "github.com" and ud.proto == "git":
> +            # github stopped supporting git protocol
> +            # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git

While having a warning within the bitbake is something very much 
appreciated, I don't think it's a good idea to remap to https here, as I 
think rather the recipes that still use this should be fixed.
This will just lead to non-core layer (the ones being not so well 
maintained) just ignoring the warning and leave the original offending 
recipes as they are.

I think this solution does scale very well.
For instance this assumes that github.com is used, but I can also think 
of DNS aliases, where this rule here simply won't catch up... same for 
the fact that other hosting platforms will likely go in the same 
direction and we would end up with an ever growing condition here

Bottom line: I like the warning, but would rather insist on the recipes 
that still use git:// + protocol=git to be fixed - at the mentioned 
11.1.22 likely fetching them will fail with an explicit error message 
anyway, so I actually don't see the need to magically fix up things here

> +            ud.proto = "https"
>   
>           if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
>               raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12856): https://lists.openembedded.org/g/bitbake-devel/message/12856
> Mute This Topic: https://lists.openembedded.org/mt/86764631/3647476
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kweihmann@outlook.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

