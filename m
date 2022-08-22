Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F3C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 10:57:44 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web12.16643.1661165855556775091
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 03:57:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=s2bjCBnY;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.22.58,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCyrTpYHf7xPFYUugoO4kVPi+mMoqB4ikeDU6d0AYp0nnJIj21FHk9BbMQl0+6ncsvnbQs4Zc/BFIsTg/ZN/rBjMSVfXkCa5MTYdNa3IRRjyr4imAW11cmpzmCUTHBLwr8wQVvnLwgT7nkTMP3SwN+vp6eXUUWQ4YL5Bpi70PdM6+42lJFUes6fBOYu8sFyvCNvZOPFsFOah60+7okAMxCb7IRP4a31tjFM+UCSvGSvbRkadjJZE/2CyTwTOXt7L3SZda5x6sUE5bNExtK9TGNT57/Xop5d8CkFEpHwonZEVN64e5nISKbgt9onVnDXGdeQJwvv3btKpm4epKcCeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9HB9xTlsEVcFCT7EqaRe0KBzNGmxrowDtdjYCtZGgk=;
 b=JWL/xMSu6PEu+WXcmMquq+zJ3DRwyJxhVfJfAxVL4uX/FlN8l/8CjoNWUd5CdlLQAxPToYAz4BL0vCHO3CcDvvDVvVBwaO7gHfVUgV5dsfNm8286i2VcOE2zBRmfUOw2sfyIbrhb0mvcE0benY/MKZyod01TvPXSxpbQAlblFeszwAwgX9MkcQqeZfyxY1i50HhwrqYxl/r2NzUOLooeBJgVDKHRo+vIg7GoUHmjOd3P7OUVJGNE5EfxQlMBRudVmTr9Jb29Kqnqr5sUT1nj0QDn0n5wZ7s4k2sovoLBCQgvFMNvT+v75FY5hEcRRl8H/7cEmmynLri+MDU7IMZjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9HB9xTlsEVcFCT7EqaRe0KBzNGmxrowDtdjYCtZGgk=;
 b=s2bjCBnYP+K1P9cIV+jRH0Qy9jJbpdImUvQ4vYBRDOnQVG0LcTpIePPoxs/uuXJsoA9D33V7uaaU29yCs3QPcIn+ZDhZs1wZgc2zRJQ+u8xGZli4Pe1UTF0uebfEVeR/tlcLmUM/mJy+dPC9bBwE/XwASKixQyZFH/mZ7n+Geg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by HE1PR0402MB2713.eurprd04.prod.outlook.com (2603:10a6:3:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 10:57:31 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::81a8:1bbf:5e16:9b4e]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::81a8:1bbf:5e16:9b4e%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 10:57:31 +0000
Message-ID: <0761a8c9-78b4-0794-6bc3-14afd248ac16@theobroma-systems.com>
Date: Mon, 22 Aug 2022 12:57:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Alexander Kanavin <alex.kanavin@gmail.com>
CC: Mikko Rapeli <Mikko.Rapeli@bmw.de>, Martin Jansa
 <Martin.Jansa@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
 <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::6) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d11d7f1-58dd-4c69-d7c4-08da842d1c69
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7ptOF/SxxUuV1NvyeupzyXqcut24VpHlu98FOxTd/yF91nXL7MOpvE4D5BbxB+NiY/2I3FHMEhpdYmgkpnmQzxQkMioRkiKpA6OQCI1vRm/FOQlxqLaViZQaCFrvVqQQfdvitKKs9We0LS82waWlejIuxZH9Q23w+3NKwkAnGgYLUR1GhZKF0W2ITD81ElzqZYXC/2u82I3sgWI8OsqzleD+emn916kzyEhUmXS6kgtiC2teBOoq050zfckuzSlUECO5zL2gYvJEc8M0dQdWD6U8KbYJZSvyhZ3uuiSPJSwwBuWneDn8mBGmcSFuU5XDtEBA8n2LmYVPn92rr54vivCEXs/aLrbhQS5MvhgsUF49qHQHmT4wiB0ZC0Xhwg1ump8FP5NUJuhYTA5AXSXtgzBEjoy/LWPtblyUoxGtA8RY5fO2YZ4+2dBLe7JruxP0gWwVvosOxyaEXrYpdx3QEZ/EzKKBMJXUPMenfl8uFGJVNGLusQKd+sf7KauDLuywojQoU46h8zO55I54u4ODSjjC+anghv/fBchIeVgMzyYwdAfnprb6hXLyT1jRz029Yj02etDad9jurCBTpEZLaAEelrPjEPKa3I4mzqkbYO80JM952XX7FHBeJn9NQ34r6xGXrMyFtGYYY0MLRg1pShevQcP+ApbtES7+Cf6OsO4HPgFtyYFvzAjX/a+SmNYmEFUKR1JVINQGWg5RfagYBxvozuxUIA78XrJ3iqVXQTpEZZmQzWuWKsUfJdTYInPnJRBhAMJmD/5ooz5xOIJjGFbJiQ1kDZdJTMgO0qTw79HM9Gx5CA6/uRr5G5seQaTj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39850400004)(136003)(346002)(376002)(83380400001)(38100700002)(66946007)(316002)(66476007)(478600001)(6486002)(966005)(66556008)(4326008)(8676002)(53546011)(110136005)(54906003)(86362001)(31696002)(26005)(6512007)(2616005)(186003)(41300700001)(36756003)(2906002)(44832011)(5660300002)(31686004)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f4F52wPGDczAn07uojWx8HA9P61E+/lE9Q5QDIt3TlNNDwTwYECrqrKcLG9c?=
 =?us-ascii?Q?H++EUfJICRfFTajlVaLx5+vINPRlZITf1JORKkIxK/j2sArrXCdXsPXzFmoL?=
 =?us-ascii?Q?m0lVpNTKnRKJfONlTBYftg2A6J6rcqxmPDfOW2wWXJ/05hJqSMNkbXqpN7+3?=
 =?us-ascii?Q?Yq8SwnAs8/h6Lqj0SfjTUuNzfnGIcESa8Lq28RG9wMVwk9SQVWRd6up8uYU8?=
 =?us-ascii?Q?H8ajNuPCsOq5XNjZdyVF0C1qit9axw17pYwwo39lW3+FKH5aGBLLVH/WR5os?=
 =?us-ascii?Q?Bhw2PpDn++xDIUrp6Ivscf0V6gyWx7x6ZotSKvJaoyErGB2DioL87pmVhxzW?=
 =?us-ascii?Q?y6ZjN0j7K4/TX1WtMdPtY+7b95qv6+oLoT45teLu500mIbMPjyFuPseXUd+x?=
 =?us-ascii?Q?aThO8eS/2RqdyaBqGPWDO63oa5JmaoMS9OFzGKZWjQrvE30YBYMwnMqWOm4q?=
 =?us-ascii?Q?T2iI6RoAGtbiSw22MZ9PeS0ycLXv557xoZgHxkQ/ORwcMoqPOn/oC1+/l0Q4?=
 =?us-ascii?Q?+K0N513jjlgVjoFg1ANs5voLtrLLU7dq8ZxHUYmE59gB6iQqZBIF8m7EWSsH?=
 =?us-ascii?Q?K/9N3XUm6/fHmkPaZV10TEP9t+gEVk1BCHlxAaVI6o6Y7YP2DfI3Ua0uUlPk?=
 =?us-ascii?Q?XWT2WuqsPzSgcoUKR2w7lYrQUVzUbZQWWzvvAbRE0v/3De+7OQkusQgiPFeQ?=
 =?us-ascii?Q?eBzHxxzmB8Q/AwPH9d5NMmLwiQskK9KVT4ZocxmOeLCERF3BEBPjr98xdTQX?=
 =?us-ascii?Q?acDabuZO+8v2cbb7Oto6LEcgCTHFKKVmXG41bOugDythHJtWkHJPh2rJSmh/?=
 =?us-ascii?Q?CUSXF9S+ORpGqiiiFgiawC7iakm/RbQXjgja8CpCpRw+Ocx3EgrFYVNGMGgw?=
 =?us-ascii?Q?t0ZlTgfCGjpm9HExq03Y7iPzj876aKkwVF7kBdZGkU8JwijYNyXasWbb+Ve9?=
 =?us-ascii?Q?whqAGnVus33P9dPqjiJzaZ7Baca21vJN57A8UPNF9wKFvjLzeuaIDqqxaf6g?=
 =?us-ascii?Q?oe612kmKBQbk2vwN9jNMOo9yTC/8dGDWLrilRrdogyiHGTihKOXUfdsZGsBm?=
 =?us-ascii?Q?pywvxyQeCj9U96ZZLcr9iFThICgDuQqyqMJJcBnnOjY71/tQJeC60J57VadP?=
 =?us-ascii?Q?0PfLuUMKi1nmT3AQIvHIQi2AsNjduD2Zo3H7FZSIHwjFhWFony0MkkVGgrFA?=
 =?us-ascii?Q?fb5E5U2pp0B9KqDXebubYFAkI/BX10k7fpUwx4RI5GiOiQPhf950nF9lIxZN?=
 =?us-ascii?Q?vDP1KTNF5ScP/B7y+cHmBq/FXTmfMtKlsf3Rm+68YdL9KQpGMo015qQ2a33e?=
 =?us-ascii?Q?HyXXCKaP6XhqDo0zpt3jdLxMSqADll4vraOn46Bv4uv08K4QqoIv2rIOFYp3?=
 =?us-ascii?Q?UpqIz95pVzwmCr+CZgakzfK0lW4F3dJFrJNjGJEp70V7ALtFeJ1a07WHLO1L?=
 =?us-ascii?Q?9SklCbwlcQFrio6F2Mquk9UAYx8t5cSDajWLSc1qhOfGZfTRieuQn0danRwg?=
 =?us-ascii?Q?LOJhIFkEQ1gXvsOh1+SIcAVxfy4qGXaiH4XU+HaQudCIsntTI/zzfvsF3LzN?=
 =?us-ascii?Q?WY6nsctTqB0YnYmisZqRztszV5Jt5I7HbDFRIz56gomv16oHpQ3ZrEvr4Fet?=
 =?us-ascii?Q?T/tN2S4gdF1Uf3rUm1uxWEw=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5d11d7f1-58dd-4c69-d7c4-08da842d1c69
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 10:57:31.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 M4/yQB8e32vhC6KG2Kq9ToFJWRH7djw8XR5DMuWtRZMZ2B+eVq7cM+MOonxNXG+4fH7hs/DKVNE0KUAMG4W3MZeGJd1/WdCZVw0EaqnHNYF6uysGgdMpsqaGKUPnLn+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2713
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 10:57:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13920

Hi Marek,

On 8/22/22 12:35, Marek Vasut wrote:
> On 8/22/22 10:41, Alexander Kanavin wrote:
>> On Mon, 22 Aug 2022 at 10:37, Marek Vasut <marex@denx.de> wrote:
>>
>>>> So maybe the easy way out is, if nobranch=3D1 then fetch everything, e=
lse
>>>> just heads and tags ?
>>>
>>> No, this won't do, nobranch expects the commit to be in a tag.
>>
>> I don't think it expects that.
>=20
> Documentation says it does:
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.openembedded.o=
rg_bitbake_tree_lib_bb_fetch2_git.py-23n45&d=3DDwICaQ&c=3D_sEr5x9kUWhuk4_nF=
wjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&=
m=3DuZNWVMGEowy_ntO8q5fjINXu3LIe9haqbSTYjwWiqO6Q5sEPsUIx5nw28YTBw6oI&s=3D_A=
J3mkGnnM8peSNP8k6MePZ0RtEkQLo7yS1Cll2yjmc&e=3D=20
> "
> - nobranch
>  =C2=A0=C2=A0 Don't check the SHA validation for branch. set this option =
for the=20
> recipe
>  =C2=A0=C2=A0 referring to commit which is valid in tag instead of branch=
.

I assume this was meant to give the example of tags which aren't=20
necessarily in a branch (annotated tags or tags of commits not belong to=20
any branch anymore (force-push for example, or branch deletion).

The git fetcher does a git log --pretty=3Doneline -n 1 <hash> when=20
nobranch is set, otherwise git branch --contains <hash> --list <branch>=20
to check whether a commit exists and can be used by bitbake.

Considering this check, I assume nobranch=3D1 is working for any commit=20
that was fetched by the git fetcher?

(We need to update the docs to reflect that in that case).

Cheers,
Quentin

>  =C2=A0=C2=A0 The default is "0", set nobranch=3D1 if needed.
> "
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13918): https://urldefense.proofpoint.com/v2/url?u=3D=
https-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_13918&d=3DDwIFaQ=
&c=3D_sEr5x9kUWhuk4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4=
njZguQhZhkI_-172IIy1t&m=3DuZNWVMGEowy_ntO8q5fjINXu3LIe9haqbSTYjwWiqO6Q5sEPs=
UIx5nw28YTBw6oI&s=3Dg4KWyxwbq71V3gbvIJNG-oA9Gdvj3A5wqfz8Kws5qZg&e=3D
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__l=
ists.openembedded.org_mt_93128921_6293953&d=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nFw=
jJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=
=3DuZNWVMGEowy_ntO8q5fjINXu3LIe9haqbSTYjwWiqO6Q5sEPsUIx5nw28YTBw6oI&s=3DKMe=
lWJJL5NtG7NWmtiS3jFAONb4GRttyl1ziLzEHhr8&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists=
.openembedded.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nFw=
jJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=
=3DuZNWVMGEowy_ntO8q5fjINXu3LIe9haqbSTYjwWiqO6Q5sEPsUIx5nw28YTBw6oI&s=3DnyY=
O56WzR2jmLa4g95pgXToervc-fJhqbVjnOOUDm0g&e=3D   [quentin.schulz@theobroma-s=
ystems.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

