Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E4C02194
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 13:19:17 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.126])
 by mx.groups.io with SMTP id smtpd.web11.115553.1738675149330189759
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 05:19:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=Oq+nz40C;
 spf=pass (domain: weidmueller.com, ip: 40.107.103.126, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzxlJlpeKtxVtdXkDtRvhi2SjBGb0Rf3gr9qQyXCmOSi2TfACQAA0FfC0tEnxmDeQuiB+Ht5JdBo4f4eF/46ae6ep4dapywx/Yex0x9Hh6zZeBpu2enRVK+Hb3SR1oAwyFChrTKO6qgNr8/uJOxhyf+xOqVm5zUjR8C0sUbSBGhqgQdIntjHNeY9o74BYibEQfs6VU1CA6ICXu/DTBmBQUjN/56cjr/qaFGFmyPEqHsl9RedUa+ZhKFN2VrJcgbRmAydgAUSviVZolQgnjJRExyPHncpZvH8l6YbgOD07qyEVVNjYqFyUkPZCfjp1zEAQ/fyU1rJjpIIvc3eoIi8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb+wzBjnrxmKkMYBHs5RJO0+rnNzoNN596YCIjvCmI0=;
 b=EuKddtugPT2Ii0DZg7aaqzOvmU/fM9IxumDIgXweZs7xbjdrL3KYQjOcsR0XEIZdscCxYVhJyaVaUtIB7qPxHKJcIfJJkHcXlTTj1Q7hKoru6NXE/ojzN5fMlotfhHRv9c/BvucjEkREgYJhL3dQVUjDXjtv3LXpQsU6gZwkkB9b3xKJkPr6f3t5MOsV1pTgFAkcnzA/NLZ8zR8sClqD6tcH8ODvuLtorKdgaQv6lHB7t4Pbuuw5xb+MR9LVbdtVIMQtIaM3dZgy4FFcQtbnDeXaKY8EfcgoD1q1c8X3KAba9YNxEuKbsMmV+bmDWEwYN6Zm+2AnNIlQWjz4kVlpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb+wzBjnrxmKkMYBHs5RJO0+rnNzoNN596YCIjvCmI0=;
 b=Oq+nz40ClkkKbEq3jtRGJbWuBO7fJ8/5dn3ChXDhvLgLnMeIX7t27uEN1gjBB8/OOJSSTlmY9L+KO8IWv2HfJSWmHdm3IuqqE0V72vrF+e2odxNNhuZPqDaAN6Vtb05bPQSbLwRKMh9vVdrPewpwWmzufUOUd81waPglfIdOP7BYGPT9DhP8dsX8HZm5zIdrHn/YNJNKDKUsfQxOYue/t3jSZ9bC0Yy6YS+S2PBZ/6pjLxvSvwpINMJlszyAsJfggFBgY/bdfBmrAYi5bqFb3I2Ez0Uv4HF5zHF/B42z5kVVLgidyhMe3sc6kxDy9vXYSzeD54F76fIuBwa+kQYHCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV1PR08MB8129.eurprd08.prod.outlook.com (2603:10a6:150:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 13:19:01 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 13:19:01 +0000
Message-ID: <e02d51c4-12e6-4cec-8405-e1b9b1f714d9@weidmueller.com>
Date: Tue, 4 Feb 2025 14:19:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 0/3] NPM/NPM Shrinkwrap Basic
 Authentication Credential Support:
To: eric.meyers15310@gmail.com, Chuck Wolber <chuckwolber@gmail.com>
CC: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org,
 "eric.meyers@arthrex.com" <eric.meyers@arthrex.com>
References: <20250127142918.163-1-eric.meyers@arthrex.com>
 <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
 <CA+cKJ+HEK9d-tvf-Srz=NwHCrkyikb-ws1u8Bn9kD--EiDF5zQ@mail.gmail.com>
 <CANNYZj8jjBpFrix4mwYG2SJ1JuvX6MHSmvcrO70WNmuEs=x0rQ@mail.gmail.com>
 <CAB=6tBR1y2Xzpy0MK1uW2TLV7O1opcW_UP_LGd-t=yYg+SAL2Q@mail.gmail.com>
 <CA+cKJ+HRxtWLSehYjUc6rLS18xxp2C_kvq8Tx_vJ_FvuxdTPXw@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CA+cKJ+HRxtWLSehYjUc6rLS18xxp2C_kvq8Tx_vJ_FvuxdTPXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV1PR08MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: c3031888-b09a-4f22-c16e-08dd451e7d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YYNCf4TyiH9U6Q3exQ+8FWIBIzP2rBAetQ/rWB1Y/qmkKFlElgNPLtVfiOvu?=
 =?us-ascii?Q?Hd/wLWmlEZlbIVmWyZBoVOe1lxnP3GaDTtuit0BGHdXAd25U36PVe6Rr+hUx?=
 =?us-ascii?Q?Bnq9SeIpJzv1OOZPFrMLvXLZHqQwhdaSN825EOiEz9Gxrt9uzaK36dJGqbNC?=
 =?us-ascii?Q?iNa0P7l7MjicLNU7yZ6Cb1k/hnQhbQTkMEa7r8rUXevdVTAU8mElBElnXI/E?=
 =?us-ascii?Q?X6o+5lqPmGkXffjYHXNGFxX+CDee+iC8zqZZ2d1p6GyVTI2RRNZU+SnLIHBt?=
 =?us-ascii?Q?0KARh3CZ68eNL/p6kd0rEi8cTHW2MBF+W34KE7nANGQOcfKhFPASNjgZwgIu?=
 =?us-ascii?Q?9IadQu+/gspOKGWS/adYHAhC1JLXNXpL6sdY/8vSmb5T4MiTOcWx+9qLLj/Y?=
 =?us-ascii?Q?IIPcKNkOiqkU2jAgAliBtSzQvkKBU+iyN8LnyEz8oZN7aG1bgQPYTMFU6nrL?=
 =?us-ascii?Q?PX9Wv+Q0XhTb/xixz9NKPwP37B183eI5WYGvRii+l36kv/+9+jTm7JyGfAtn?=
 =?us-ascii?Q?f1qPszvT9ll38Z6BBVGoUe8PGNNtqLBqLFSDuUDSoL7ckpg4hyfbs2E/N2aO?=
 =?us-ascii?Q?SZIFW6e15O8ly8qjk7dVX3QnKo445krMIBg3YoCRbvdWauBW6TAoiJ5cA4if?=
 =?us-ascii?Q?OOlRk5nrC/hIM6COc8uy9FfygjF13XMh0aXmxC/OnmpsZ+P0N18N/hOkihLN?=
 =?us-ascii?Q?8/gg2ETpD3maYMqmzEnQJ5FmtpEMn80wFt2c383uDKO+ERtVUcE7QiK6ixaE?=
 =?us-ascii?Q?YxT2G67o82MbT5eDJvenDzPl1b9hvgVRkmsjlnS54jWEFIiXbO/wqAsPsi6q?=
 =?us-ascii?Q?SYbHuk76UajY1sakTwDfdHTBGknnsO/Cm6/M9XMaqmI3Esr7WkXq8sM4b7bo?=
 =?us-ascii?Q?fsgli0KXoYD45wzxFtf+qSjFrtyCZjEZPONaBfFMRgeMuLDg636ii4GlhrEK?=
 =?us-ascii?Q?lCa2q3CGhmeA89PWACVVK0nSSqnr60cZYTP2qKgxIwBgWIyHcBrmE3sa1mAc?=
 =?us-ascii?Q?caloDlmnxzL9Ojln0Rg2iIef1QMqgU2sJmPqaEeVv/P0U9FccTtrEWSynAaf?=
 =?us-ascii?Q?ExfjfjlJZbp2agq2EOcPwcEKkl9eQ9ZOgnyiuswnDKbcBqkWyuucWqS9v7uw?=
 =?us-ascii?Q?qD91Sc6VhBGmf1viX//tTB/ghNf9clyBtrE8zejSMlCEuofcSyCf8BziNrmr?=
 =?us-ascii?Q?EMEVW3oc7x11buwfrw4C3hGmp96lSH3LmJA1AblHsmreRJy1zGlWNTVPNr7K?=
 =?us-ascii?Q?I3bYS0ANZMcNQR3dQPcmWuZrU8nCrHlWv+pP7hviRkAHs0KUzEJbdRbqZM+e?=
 =?us-ascii?Q?toBjYq2Pb+pFGloV3eRX8IkL8wjIS45QR8hlcGAiuC8YZA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?M/KRiZvhTcOtaz4Y5HlBL/kGb3I0PeSmwkKiIUm/xyvX50n6kH/U2Tkcjtf3?=
 =?us-ascii?Q?/yzMcGc0xOAiLi14L+pjPlfQYV+jx7BmFYFXrD0r0UHOhfWL+5UrihEYOjiJ?=
 =?us-ascii?Q?vAi9pnuCOOWXQTfby2mxMJHVuYbOLo/y09hgeTuQ7LuyM07XiAlek4V2pS6/?=
 =?us-ascii?Q?LZeIjf0nc1yoBC1Ea5Q5HjRxjmr9d4MTDbARYwNcrlY5Nu748utvQJrHMIeW?=
 =?us-ascii?Q?fjmIFz8FEgugS4JDrn0JHIg8kCTwDiiffAV3YtYyerpZpKgtUSm0L/2VcoTD?=
 =?us-ascii?Q?rKHfWWGLeHfsz4A9fjppkWudV+UOVzh4YHEM2zEG97Mijj0hIPTloD2Iieva?=
 =?us-ascii?Q?CZJiJk2DxxP6N6nXBxDfAS/m3SRLRlq0F6fFe9TBZ9BS/rhIbzqmr0sAiWr6?=
 =?us-ascii?Q?ql1QCoGiVsO8yIoeJnNWrQi/FoJR1+Qzg6+KHCY147ot0xM7U1MgcANBgfbO?=
 =?us-ascii?Q?mrzY5CLgVc3e2vThz40sxKDTPmGOFUNN9gPPcytkim74utPKYh88s8+m7kPc?=
 =?us-ascii?Q?qSQwU29evDysv9FKrl75YXEgpsGtU80G8r9XrUF4bixcTqQTrsOGmjvmWlHq?=
 =?us-ascii?Q?rnVVtbM3dF+kCSIy6afupG1cIx3BUiSo/5Lim2ifnpqhGiu3ThSM64+9erMX?=
 =?us-ascii?Q?KUOaQ0ZpszW6fB7CxDsMuHlksyJHncKygOOrW15B6HUF+Q4MVlGEK6LAs0tl?=
 =?us-ascii?Q?3zj9BBHE8x0YSPrYtSa0YJCcfELJ6+rMNmrgXPtc8v1ahStPTrgynAMjCBAE?=
 =?us-ascii?Q?r7YssC50/zuoeqtPpCII6uLJoKLTspJIGlnTEUaPehOiDujJhc7RM0HJ6XHn?=
 =?us-ascii?Q?xWFJElYsybyg5KoYtg8LQpZdi6CZ99urYNlFGrYhnVyDShQSOg/ebHiDfsK+?=
 =?us-ascii?Q?EspyvWPYFPznJph9YM+piZgllqidQ1Tq+43+f4b/1WYGegHpRnJKBdytBASK?=
 =?us-ascii?Q?WI0s7/bVjec9gKbhs1K/Jn0GyZi5qhkt84ccmsQbpJ0iIgV5P3ujs1S9P9Es?=
 =?us-ascii?Q?MmSJ2NqF0YlHJ/M0HotccHLvbpdeQRBW1EBPaaZdGFuEm/XZDyavEwvGN856?=
 =?us-ascii?Q?+cF7rz/hjlnCXw8yrwjA67BVzP8uNaV3m4rPjEA7htIYVSnfmXEHjBYgDmmV?=
 =?us-ascii?Q?owRbnjD4Ad4iSJIwzv44l64DEg3HDeebsBuSSAMKreMvYNbv+TDFxsKuiqcD?=
 =?us-ascii?Q?9gymr49VZhdJFnqiWi+yiIcOMNgtGYo7tNVcxv9vk68GlProTkMgxswFSo2B?=
 =?us-ascii?Q?ZO3t2GSxkAb9JTj4i/TVlUPY26qPFxPixlKScoZbWa1j0fJxNoAd+ncD56hZ?=
 =?us-ascii?Q?I+DtiNw3lHdsBpl/2XXVcKEPvBzpL+qwlExQvVvaJLizeWPlRQdJZ9i1zYKV?=
 =?us-ascii?Q?LUsKNB7dJgb1jBCity4Ktn82k4aIddpN1Ik2fO8ZNQ+QD45oqbKcFSqh+2Wd?=
 =?us-ascii?Q?XuX+MZeoNIfFfx/96RYDhRyyEH+Y9t571j3beD0bfMfHbOT/Ee5oea4yQU0W?=
 =?us-ascii?Q?9ORa49itCOhbVGLmLFA52LhKUumzkWtiIKspuvUcYH5Y9DqhmKxH8VjuhFTy?=
 =?us-ascii?Q?vdWY2UfG49rx2JFiic6vmXintIcdG0zXbfFcaDI3PSzxTLa4PWPBjhAGKMSq?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3031888-b09a-4f22-c16e-08dd451e7d64
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:19:01.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB1e2ARoO8hWGpPTk1e0FMeh7zTsn8cLj9XY1jSYnfR2o2uvRQVN9VMsFQfEVrjvWtTMCrxyaFqYEnWC4tgYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8129
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Feb 2025 13:19:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17132

Hi Eric,

have you seen my RFC [1] to remove the npm dependency from the npm=20
fetcher and use plain wget? I have a Work in Progress to parse the=20
package-lock.json inside a task. This task generate plain https SRC_URIs=20
and fetch everything with the wget fetcher. Furthermore I have eliminate=20
the npm cache to speed up the build. I plan to post a first RFC with=20
cargo, go mod and npm support in the next days.

Regards
 =C2=A0 Stefan

[1] https://lists.openembedded.org/g/bitbake-devel/topic/110212697

Am 03.02.2025 um 16:33 schrieb Eric Meyers via lists.openembedded.org:
> On Mon, Jan 27, 2025 at 3:06=E2=80=AFPM Chuck Wolber <chuckwolber@gmail.c=
om> wrote:
>>
>>
>> On Mon, Jan 27, 2025 at 10:01=E2=80=AFAM Alexander Kanavin via lists.ope=
nembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:
>>> On Mon, 27 Jan 2025 at 16:44, Eric Meyers <eric.meyers15310@gmail.com> =
wrote:
>>>> Are you suggesting that instead of username=3D and password=3D paramet=
ers
>>>> in the npm/npmsw SRC_URI, it should be an "npmrc" parameter that
>>>> effectively the user can point to the location of their .npmrc file
>>>> for authentication on an NPM registry? Then, within a user's
>>>> associated recipe, they would need to create the npmrc file in a
>>>> do_fetch:prepend() step that that corresponds to the path passed into
>>>> the SRC_URI?
>>> The only acceptable solution would be one that takes passwords written
>>> in plain text out of layers and local.conf altogether. And the way to
>>> do it is to write these things into ~/.npmrc and ~/.netrc in a secure
>>> manner (e.g. pass in to users via encrypted email with instructions
>>> that the file must not be readable by anyone but the user), and ensure
>>> that npm and wget are able to pick them up from those files (wget does
>>> this already, npm I'm not sure).
>>
>> Could this also be solved by letting the end user decide, sort of like t=
he way FETCHCMD_*
>> works?
>>
>> A CREDENTIALCMD_npm variable in local.conf could be saddled with exporti=
ng the
>> namespace, password, and username values into whatever environment needs=
 them in a
>> "Just in Time" fashion to lower (but not completely eliminate) exposure.
>>
>> An identity agent, like the 1P or vault CLI would be an obvious choice h=
ere, but one could
>> just as easily tie it to a script that devolves down to looking in ~/.np=
mrc if they wanted to.
>>
>> ..Ch:W..
>>
>> --
>> "Perfection must be reached by degrees; she requires the slow hand of ti=
me." - Voltaire
> Last week I had off, so I'm just getting around to addressing these
> comments this week. Chuck's suggestion is interesting and I will
> definitely consider it. So this amounts to two potential paths forward
> for this issue (1 by Alex and 1 by Chuck):
>
> 1. Take a similar approach to how the wget fetcher uses default netrc
> credentials within the user's home directory and use default
> credentials populated by the user within an npmrc file in their home
> directory.
>      - Pros: Moves away from specifying username/password in recipe,
> using precedent set in wget fetcher, potentially less changes in
> fetcher (no parameter additions, no creation of npmrc file, etc)
>      - Cons: Currently, the wget fetcher relies on default behavior of
> "netrc" python library - there is no analogous "npmrc" python library
> and we would need to add logic to check this file manually (shouldn't
> be too difficult but still would need to rework current NPM
> environment behavior in the fetcher). Might pose challenges in CI/CD
> environments where these files need to now be created if using private
> registries (again should be easy enough).
>
> 2. Take a similar approach to how FETCHCMD_npm is used and specify
> another variable named "FETCHCREDENTIALCMD_npm" that allows the user
> to point to a specific npmrc file to use in their environment.
>      - Pros: Moves away from specifying username/password in recipe
>      - Cons: Adding another variable to bitbake, lowers (but doesn't
> completely eliminate) credential exposure, might require more support
> within recipetool within poky
>
> I am going to take a stab at reworking this patch to match approach #1
> outlined above, but if any hiccups come up, I'll post issues here and
> re-evaluate using another approach (potentially #2 above). #1 feels
> like it will be easier to implement and more straightforward than #2,
> but perhaps I'm missing something.
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17122): https://lists.openembedded.org/g/bitbake-deve=
l/message/17122
> Mute This Topic: https://lists.openembedded.org/mt/110839321/6374899
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [stefan=
.herbrechtsmeier-oss@weidmueller.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

