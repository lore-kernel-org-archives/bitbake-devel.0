Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1486DC25B7C
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 09:05:12 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.109])
 by mx.groups.io with SMTP id smtpd.web10.23540.1716800711189565927
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 May 2024 02:05:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=SA/Ys/oc;
 spf=pass (domain: cherry.de, ip: 40.107.6.109, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7awqL1Av7H0WofLXXBp0jpmKz47+P9BCtt44YcCso97hVxfCmHvxx5UdxCeUKitBT7CbnNEsHnr8LQibM/mUvcEd2r/+6QqoH/VWa/PsKYRrE5P4aMWqy4fa2/zWki8fDV+x5iWzQZVYfhQY4loReqBAp+2RKSLYBnsdB5hcJw/39Fqv/JcREMmleu6nncGRLY7LpDM7/p0xPComResbX1pK3hX44NV+GqHIUqknH/MXw0mE+Eq3kpyWcVAL1kBACIaTCWA+SaVUzc5vmUiJSxgCATMGH+DH04U7lrY7MyJqWDieNZ/F/WqvwD3RVWe1TeSj8RVSJBRCm7xKqN0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWi4IdJz89A0fi6ov9lz2ZXXe1nTllr0baArvKpHgdU=;
 b=iyeTibmvabo+iDG0SJ09qbNZ2XvZndJzrD9CJ3qRaTnERSY0595SSrPw6a2E+CBqBX+L/Mk6p4aaEl3zdOMJyzHWtkYx7pOX12YHKigGJotjOMq5Cb0rZEsAfH6mtzjIBI7v5PuyDMauGLbzFqUs/fXm3FraHoZmE378Z7srU2zzmQv8O0eY/M/2HPwIIQ/OxxWmqkVrvAW8L/kucvYVDbtax9BTmjtWcdO03YMP/2VJgp6lg5fqdsMvqqWUcUTmXR8d1oCGtEB3+Yc70rvK5uaAq/yC51Q80fva7gBs5HtKkJ8P1zAe/HOMI7fV2xgGaZ2TrqGxnVQ0XW/gNb+Wdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWi4IdJz89A0fi6ov9lz2ZXXe1nTllr0baArvKpHgdU=;
 b=SA/Ys/ocVH8eD4YZ9SUKQnHH7nhFq6xKTtQmnwayQ7Rs4oO5PSiTJWALDb5bt1D7boQYw/z/GDRfh+3DNxAqdyBX0STukgyqYif5A/EheVWIpYWx4JeLl+YlN12EJnhTYOY7hdVuKuwZDyrvgO5B1AL3w9uKUsi9bdvggqu7/pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:05:07 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 09:05:06 +0000
Message-ID: <ce9cd1f1-bcad-4a60-b280-a97c3406deec@cherry.de>
Date: Mon, 27 May 2024 11:05:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] add basic b4 config file
To: Khem Raj <raj.khem@gmail.com>
CC: foss@0leil.net, bitbake-devel@lists.openembedded.org
References: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
 <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com>
 <de18f958-d6db-4f90-a49b-a181d046f77e@cherry.de>
 <CAMKF1spNvMbuy+a-HS7wEbx5D817t6oxb_R12=gBgKgG8Eja1Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAMKF1spNvMbuy+a-HS7wEbx5D817t6oxb_R12=gBgKgG8Eja1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a43ce1-f06e-4835-bae4-08dc7e2c1a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nozHXG/GXjHm8QboQVdlND7geEfyKf4/kcKehyBoAapkrQv8T9f+AILqkGqw?=
 =?us-ascii?Q?PGEJ+5nWd7ntEBebSsj6Ry1KyG3f60X9FFtQpLyk/0mQk99og8GjGl3dtdo4?=
 =?us-ascii?Q?EocNFeH+q5ERerylvixJ2ZkbfcMo7seafnfSqJeyP7A/eKBLMvg9JIDV8Q/t?=
 =?us-ascii?Q?WEor1MYxhrKVp510lWS1TF59GxSbWifaaI4Wjkwaz9VSE1pMcz+lhL2ooSMR?=
 =?us-ascii?Q?bM9eHum452vEW5zk44Mkf0dfpOLz+Tv1d7xMbHKx7Ee5rwvmNpxMQix6bqmA?=
 =?us-ascii?Q?S28rS6hR3V9iMfOTqc746x0OzsZ3lBILJfMeiFMqdlqz8DMiFA2ZXflO4iAU?=
 =?us-ascii?Q?waGkudGZ7IopAL/VpkrPwEBC0aH/MKUFUT0N3hWzqjQyioPOA4v5/UJVHBFS?=
 =?us-ascii?Q?Hgv/tfVwM7dg/579CKOqyUU2El7g1RpKE53TW4UNVYmDBFzxrW+r3RxhvuAs?=
 =?us-ascii?Q?OML+DozJklsnhxHeRqqC5aYf6k51cHmF28nHDygYCOD5KzFVTvJwnP4mTz4j?=
 =?us-ascii?Q?GkO6PCmwogHRnn3RlQ7aEi+7py1mJBTgzmAQT45HDk0Llht1P4ROVnG/GHBV?=
 =?us-ascii?Q?PsvtX2sjSQT3MCpoj7JhwZi+WQtCv3EJZZMaiPA45MoqiBmyhaXVFPUEizF7?=
 =?us-ascii?Q?axCcK38l6c3XP2QSVoE6p0Te4UwZfIhZaSx8WRRGFW2Kxcc+SusPum+t7hdK?=
 =?us-ascii?Q?QlLSf/bBEkF/MC1jcRrqFa65OumRIJeAZP0vg+Du49TE3ZC1qS2RcidV+Mkh?=
 =?us-ascii?Q?93VUpVjw3e5BtKVzhk0FGoCU5w0uphgnU6r9/usdmGNgOZQ8lIYLEp6KoiZK?=
 =?us-ascii?Q?UklNQrCCf1yAkXR26tda0Z6Zs5LcVS1g96luOQ9lVxbILrSoxMRoK060gWhg?=
 =?us-ascii?Q?J5lDaEoMB835v+Ym8Lut6b9gVcH1OQ5AztZREuOG3mVClinl6RJHP9fRVSmY?=
 =?us-ascii?Q?NhoRYFiuAWB5D9Ls5F1V3XMqxRQ8MS8EAN/MjzJFRyXZd2dEOh5vTEGRfL5+?=
 =?us-ascii?Q?ilmxMWdAqrr28dUifrkf/JeOE5GHVojE+3GdcdBhbBJoj896Po5jsvifXA+d?=
 =?us-ascii?Q?GUYLIAksezNWrRrjpv4eaPYejcDl4JX50n+ru1j72ZW0d09Ap0DowviLzSGu?=
 =?us-ascii?Q?YjrWbh6kyIIe2dubzSxrikKnmHZYRvROPcRzbCXn98yRqcjsywTK0OiWbwwA?=
 =?us-ascii?Q?+ry/kzvK1S69AisF7yWkyBx//MOL/sfgjYry6oEf7IuRZEV/Q9Dq+bUZfEY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PcB6DUmBeHm2BAn/ozKKfVP7wYttUq69j9lKNSCy6B3uMbv75d7IUdoAUI01?=
 =?us-ascii?Q?/6yRtqAGWhhfy3q5K4dnBe0oHFXDKU8hQG6PBzfznJ1iQWiSaJD5qV/CQq96?=
 =?us-ascii?Q?SkyHgRaAfR4s7Z1SE1+eifpL22bEFMMlkTEqp6KygdV7Gv3KgUMFyfSbGTWs?=
 =?us-ascii?Q?fl+UGGboEZkI1BObH21s2MCSUym4TmCXoNKtR5o4Ii9GMfje4otop5gSF2ei?=
 =?us-ascii?Q?rH57vUWHFClRS9CNXFgG7q8U6EW2L2+a703IQN9AhAfnKbjAFfKh2b1EOX6o?=
 =?us-ascii?Q?WnrV7XnV9SQesvAGpL6YNnxFmMSuiEXDuc4yWPuJTteR2ERN/eKYE6TXqfe5?=
 =?us-ascii?Q?m/GE6+CMFUwXRjUEsfk+OnzvGfwsiyCAekSUms1cjOe6lTFfundmGcytET5y?=
 =?us-ascii?Q?CtnJR+j3kFViC45q9FM3OiU3LDPiZ0bOLmPHH+Avpew7+jnJHDLK8IddWgB0?=
 =?us-ascii?Q?Plf4TQaizJy9rz1DHmFR6FlMnvM5lcULCmlg7aM1WlDDE9v9s4973qbQHoyE?=
 =?us-ascii?Q?dfohFnPr9OdH5aF6mX76t0uKB13vi+nHrqM/xn7hNeI4G5pnbc8H2joEj7yR?=
 =?us-ascii?Q?U86+39Izzdyb7SaY4aV3r2a35re7sC+2jX3gf1knj846szWY+R66pMynk2XU?=
 =?us-ascii?Q?reKtQzXlzFtUn1KNxnanP+zwjdniNKIIImptwPQiG/4j0FEM/C9byU15+ufJ?=
 =?us-ascii?Q?DkdhGTiA0KPiHq4TkGQ58g1MDRQ7e5UILdmYtvwddzDAf06pGoR11BxMQhoL?=
 =?us-ascii?Q?J6ARqGEGXU1RdHSAlmQelIrt7fSFJwf18cO/9eytv8ytGSvg9GdFrKl2BUtv?=
 =?us-ascii?Q?QDealQcSiuA0wwTPc4u0BiJMx+oXFxkSqVmXqw8JPSL1jltU4b2wJFzCFSXN?=
 =?us-ascii?Q?xQ2ppq9cJvSimPbMLjqRjTp7O3cO2fTgqd31FZ8Ik+0IYF2S0lr8//f6FsCV?=
 =?us-ascii?Q?lrb0hpgjXpUDpprZX7n7FAwSjt1dZJ6Pfs5/s8XyuUNUUAInLLZe4kgQC8X2?=
 =?us-ascii?Q?92MzmMxpDcDrtvvGMZqK+n9cXVK7wOBnlxb8HeqaStOtMd7zLLUAGLxgSK/b?=
 =?us-ascii?Q?q66Wm9b902rbcX3bsJifv+GLPTJPZmnppsgFhW0BmvascigSUvWt4R3wVYy/?=
 =?us-ascii?Q?t4yFQbFV8Msc8ywsGCT34/j5z52lLMf6I0gwQock3ZamjVAPMJg7YMIl1p1s?=
 =?us-ascii?Q?CtqYOKtFrwKsE5cWsu9vnV0juQDaK2WduWq9lz0qTv7Sog1Q21gRb6eRLk0l?=
 =?us-ascii?Q?Ksu+VuCDNqzxjTJTSr5hknVm4jLcLRYTc+qHpPckjKgj7Z77Z0fILGI+XdXH?=
 =?us-ascii?Q?NWrlAoM+ODKM8vApKcElEwEIs7ATJoFWgIHe66d9nrampPGe2djOxUF42AOy?=
 =?us-ascii?Q?Tm+tnkHGQ7Xq2FLp5zQQLt6cQmAUF9mUYEc620EMYbywmShgc6v2zxi10FAq?=
 =?us-ascii?Q?LQNUyIn+OeqFrCJAndhnGBTbh6GWITSZ7pFgCZU08ObwsDEN3j91Lp3rlLA6?=
 =?us-ascii?Q?RIdrmafrxBwGglKuIHo5WQ/VIP28TcykcJVpXQ1IJzvl/vaW4YkdgHxDAyb4?=
 =?us-ascii?Q?yvFB5zt4rG7hyYlb8La5fNNDAHwcD9N0THMzp/1GARAgttulFKYhd+GB3sp/?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a43ce1-f06e-4835-bae4-08dc7e2c1a58
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:05:06.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbD9y8LTxM7EbvW+pBT9G/iYIj73GDKeSz8sT5lwxQPxBsGouIlNbhtVAflepNxF8sx5AhBibk/A8YdwID/6CBmJh06J1USdIPLFSN4/xoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 May 2024 09:05:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16269

Hi Khem,

On 5/24/24 6:28 PM, Khem Raj wrote:
> On Fri, May 24, 2024 at 8:33=E2=80=AFAM Quentin Schulz <quentin.schulz@ch=
erry.de> wrote:
>>
>> Hi Khem,
>>
>> On 5/24/24 5:18 PM, Khem Raj via lists.openembedded.org wrote:
>>> On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via
>>> lists.openembedded.org <foss=3D0leil.net@lists.openembedded.org> wrote:
>>>>
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> b4[1] is a very nice tool for mail-based contribution. A config[2] fil=
e
>>>> exists to set up a few defaults. We can use it to set the Cc recipient=
s
>>>> to always add, in our case the mailing list.
>>>>
>>>> This shouldn't be necessary if we had a script that b4 prep --auto-to-=
cc
>>>> could call to find the mail address(es) to send to. While we could do
>>>> that, this opens the door to people trying to add a way to notify some
>>>> people (e.g. a MAINTAINERS file) which is not somewhere the project
>>>> wants to go right now, and this also makes sure the address is always
>>>> added even if one forgets to run b4 prep --auto-to-cc (which is part o=
f
>>>> the typical workflow for U-Boot and Linux kernel, but is not necessary
>>>> thanks to this patch).
>>>>
>>>> [1] https://pypi.org/project/b4/
>>>> [2] https://b4.docs.kernel.org/en/latest/config.html
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>> This adds a basic config file for b4 to avoid to have to add the maili=
ng
>>>> list by hand. For documentation patches, one will still need to run
>>>> b4 send --cc docs@lists.yoctoproject.org
>>>> manually for sending it to the docs ML as well.
>>>>
>>>> Note that b4 supports patchwork, c.f.
>>>> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration=
-settings
>>>> though I have no clue what it does with it as I am no maintainer, but
>>>> maybe something worth having a look at if some maintainer of this repo
>>>> wants to use b4 to merge stuff?
>>>
>>> I use b4 regularly for meta-openembedded maintenance and it also update=
s
>>> patchwork when patch is accepted, I have this config.
>>>
>>>      [b4]
>>>       pw-url =3D "https://patchwork.yoctoproject.org/"
>>>       pw-key =3D "<mykey>"
>>>       pw-project =3D "oe"
>>>       pw-review-state =3D "under-review"
>>>       pw-accept-state =3D  "accepted"
>>>       pw-discard-state =3D "rejected"
>>>       send-series-to =3D "openembedded-devel@lists.openembedded.org"
>>>
>>
>> Thanks for the example! Would it make sense for me to add the pw parts
>> to this patch as well (in a v2 for example)?
>=20
> Maybe, it can be documented like this but I would leave it to the maintai=
ners
> to promote using b4 not.
>=20

Promoting !=3D supporting.

Right now, I was just planning on adding basic support for b4 so that=20
people who are in the know can use it. We can decide whether we want to=20
document this and/or make this the default contribution workflow later,=20
they don't have to happen at the same time.

As for the pw bits, it's one less barrier to maintainers using it if=20
they only have to run
git config b4.pw-key "<mykey>"
once (which I can even put as a comment in the file). It can silently=20
and slowly drive adoption if they only have to run one command for=20
trying things out. Reminder that I'm not a maintainer and I'm not using=20
b4 as a maintainer so I have no clue if this is actually useful to=20
Yocto/OE maintainers.

Paul Barker presented his use of b4+lei 3 years ago and I have a vague=20
recollection Bruce may be doing it but cannot find a presentation of his=20
quickly so maybe I'm misremembering.

Providing those defaults (provided they work) doesn't mean people have=20
to use b4 for contribution or as a maintainer as part of their workflow,=20
we just make it easier for people to use that workflow if they want to.

>>
>> I'm perplexed about the pw-key though. This is very much something we
>> don't want to version nor potentially leak by mistake. I assume it is
>> not possible to add to the global ~/.config/git/config or ~/.gitconfig
>> because the URL would change for example between projects (I assume we
>> may have a different patchwork for OE and YP, but for sure if people
>> maintain kernel stuff as well, then they would have one for kernel.org
>> for example). Mmmm but maybe a simple
>>
>> git config b4.pw-key "<mykey>"
>>
>> from within the local git repo would be enough :)
>=20
> right, it must be documented clearly. setting up b4 is not simple like a =
pull
> request merge.
>=20

Do we want to document this now. If so, where? yocto-docs and bitbake/docs?

Richard "suggested" something a bit more involved for git repos merged=20
into the poky git repo so that it finds stuff automagically, if you are=20
writing patches for bitbake inside poky git repo, bitbake/docs, oe-core,=20
etc... So maybe I should think about something a bit "smarter" :)

Cheers,
Quentin

