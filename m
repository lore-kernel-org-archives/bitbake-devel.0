Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B648C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 08:56:02 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.129])
 by mx.groups.io with SMTP id smtpd.web10.23431.1716800151368673762
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 May 2024 01:55:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=iBu4wJZs;
 spf=pass (domain: cherry.de, ip: 40.107.7.129, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGp+nQi6rz4GXoqdrCYpJoHFzWFY2GhWI4X/s3KOWWXYWO+neBz20nOKoTC4gzu6NGhjeazqh0x/4iX5nhyCwPta8lL51ysa1SifC53cC6Z7VMWIg7GiaohpsuUp+GrfDwvMuRZgOg4VFyJGdvAWz67bMxOg2EcDY2EotEwOPx2AmQ4gmKLhwA26adUerN4pyc9F63x9ysg1iY6E9MgD+2DdWMHZQx7/4oFADe4E4ZbI9iikBUzZNnmgG+719NUqrtQ/TU+3kzRW12ZxNoDjiUIXizkvJ0/pCe9lweQA3To0NvlxjQCjLo86tlUZcMSYF9fVFXGpOqhmrbn+PiXk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRISZyf31KGyZyxNXOTsYVpMJj5jKhifA/5YO0W2ej4=;
 b=bEfm54hU6hvsf2/9lRdfoFjTNZmPyt75F/zwCpjunNsua3vCNaaFhlUrP4wFAN7PvMvVL8YZ5iaH7gasQ5jmqINQqaDxyF7yjysYbWgI4qziQOa59CZVy2xCJJijHbxBWYNWOQEcZy2O3iUPoeIGi611W7/JUoDo9UMaBt134eLGlmHO8UGdb5B0oZdm3mcRA+YChPdrncj2cZorBtKBB7Mhb42/41P/xt4i1jrm0s7WhI/s9bDbWHptG7EC2AKvrCxtE77Ay7axW3usfnymiHtmwIR14aEBv+jzMVYVdXo86UurEqOqiKuKW4khqtUGwn230bV9QR3Jf8580qsBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRISZyf31KGyZyxNXOTsYVpMJj5jKhifA/5YO0W2ej4=;
 b=iBu4wJZs4bHFMRfjDejnyhNL0Rvz77twX1J0f8B6vjXw4Y9VCKN3qjbAVFJn0DonopGcdvX3vzlUkEqZAPSBI+dYRlcQE9XB4rZcRue1Nmtk208tSq8JUXYdxY9Z4bDRcxl4P+Ul9wzOfRk+vZ/2ikgpLwIWDJ/z/w8nc9WNJxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 08:55:46 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:55:46 +0000
Message-ID: <117cbeab-2086-41ba-a787-0ee713b13b14@cherry.de>
Date: Mon, 27 May 2024 10:55:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] add basic b4 config file
To: ticotimo@gmail.com, raj.khem@gmail.com
CC: foss@0leil.net, bitbake-devel@lists.openembedded.org
References: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
 <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com>
 <de18f958-d6db-4f90-a49b-a181d046f77e@cherry.de>
 <CAMKF1spNvMbuy+a-HS7wEbx5D817t6oxb_R12=gBgKgG8Eja1Q@mail.gmail.com>
 <CANx9H-CC9YHqTv6LgZE8jP0KVJC5Wsvyc8wmzhnf9crRG7ej4A@mail.gmail.com>
 <CANx9H-BbTqYwGhd=JqBiFCtnfrf94Hj261SiLZAgJEfUAuw2_g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANx9H-BbTqYwGhd=JqBiFCtnfrf94Hj261SiLZAgJEfUAuw2_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|AM9PR04MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cb29a9-ba91-46e4-6374-08dc7e2acc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4ydEoK6xUqaxixAuIRI+8ySOgi/uv35/cLXRL5nZRidavsoPjBaYuSsSVO8g?=
 =?us-ascii?Q?zA13/uikHWJ6CItBFqgguBGha5TvJEZBylqyvegOSCnxfvDFC68XOMxAieiz?=
 =?us-ascii?Q?yW6WiJn7WJ8VGk6MDf7pcYKfhXZQDLOEhXMeyE+x8iktZ4Kl+ONIGaKK/MM5?=
 =?us-ascii?Q?UTwi+uBO2qQKNpdNPqsQYdE8bLh4puDclWvktAx9RB0+U9t4j4NDnr+3q69B?=
 =?us-ascii?Q?yZb/DvbrlP9D4GqnBzSoUe3VgCoe10F7Ec0L0IGmnuePbMlWYCHijxRdRPSz?=
 =?us-ascii?Q?sr+tZ9alSAKm+jADZZnafJNnTgmYpLjaZ7SL00iHBbu8FfC2VQjAkOn8Pyqs?=
 =?us-ascii?Q?D5e1zvYcdkU9TNs67Xfswc+wz+P2GmVP3MaIGkI/4lxDY4l6shGFhK9pqkM3?=
 =?us-ascii?Q?8T/hjFHYxXcg43cIIED6jCno729yJpGKQ/6jg63FQ8hdl+wO6NmKys9R2r/x?=
 =?us-ascii?Q?l2R3y1Sr8u0cH2JwsmG91q7sBabP5Kz1b5+UlZHIarpPJMItf4YzHn1LPAes?=
 =?us-ascii?Q?Rm5Zd09Gzp4XzP4OMP9iDchAodWcw2frmM6C18q91WNvgFHxdcVpZUqgZDnr?=
 =?us-ascii?Q?qgRtoEMqoXerDrOmn0iLB6z+ORCheGVyVeIx3lPhQN8V1XyHHiEWg9AEtMs5?=
 =?us-ascii?Q?RulEWvMjcvCyfBzUPS9QfUMFDksVTfuTnJB96ahe1ER6wwshoXVPE9wZzEDw?=
 =?us-ascii?Q?2oNIkvCndGUWBPv/MZmCtjf4k1jULT2wA3Pz1Uxx3DRHy26T1kRZBw/ewSsL?=
 =?us-ascii?Q?EziwzXHyF1De5XJZTqM7Y+o2uL50k0B3qIWYm9zoLJ3mZ/5KJ3wHKSGRBJGz?=
 =?us-ascii?Q?jNThr/YNC3uz9Hr2LAZ+lUikrIVU3nLOU5W2yPcbPxQ0mThodtOSnkZWNZAs?=
 =?us-ascii?Q?Sqf013bstIh5FvC2JThmtPf5uPkiMFqAcrIlJyih69VpJDe9gcPiWyKsRIgE?=
 =?us-ascii?Q?NxToElhS69+VSQuLpX6vKP0xtYDlCl7dxVzukAkGjSW4IyraD0Sq9cYa0Eov?=
 =?us-ascii?Q?rxramsBrFo7uuuKgQkc38Xg2z/X4XdqPy6NLyYr/lxEYPJ3pPEf/FzpaFud5?=
 =?us-ascii?Q?jCaPR4GJe0GygEqoVr8Pvbn4o4+eSRo7QXuJzlio/ZF1YW6SgEmulQjo60cp?=
 =?us-ascii?Q?eou4jho5Q5Ej7Kf3CJ+zJ6jWkITl7/azRfDwswRJqJvOhVfowZrtyMIa/019?=
 =?us-ascii?Q?HaR/9OH+ReeKSECYXcQYEQ2/Wphrf10xN1/x65RPCtW0DqB3OcDe1lzHuqc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VlVAzFFLAZUa9ewUaDf0SUMA6EID3QybpmN0nZaBiVR3omhd/idsELVx8bdz?=
 =?us-ascii?Q?ybBWMtVnSQUYsMg75qB92AzCdfwgWAvn2HRAYgBgBkq4cVWdgDvdIQQ2fnkT?=
 =?us-ascii?Q?hWCDpEy1yqAw+twmYDcWcVVeUhN7XN3MqXp7mHNcRUs9r1Iv31nToO/SiOo1?=
 =?us-ascii?Q?w93lArjC9f7l8ZuAITvUWnw/XgOd7sCUD+an72DLOe6QUiG6NF4c+WrFW6/p?=
 =?us-ascii?Q?4+R8zzVPcN+AS4ga2uRdZN30pp3s/dOUGSpR+1IyyMZresJtdEtAcmp47ZFv?=
 =?us-ascii?Q?s/lpNCFP2pCRulQ4ap46LXSnE9qPnM8g/pykWUMu59W2CwLwWu9R6DgYbHtb?=
 =?us-ascii?Q?CYOAbCujK6EVKdZgXeXhRMzzXi3KaBaHnDg+lBO9eUdI5KQ4eG8dbzpCKBUJ?=
 =?us-ascii?Q?JW11FHH+JANyRhfa2sYCsBBFumsflUUO29beSZLbd84ZOjHn9DDQOacIn5a9?=
 =?us-ascii?Q?QswkYIPYCDayU0wJYRjioi96x5jycK1jmtuQZTwJawEHnH5dXHLDXkigMrt8?=
 =?us-ascii?Q?qvFuv5msGjRvcDg6uaILbWGbqs2vVFZP+99pa0fZccsmBdrLLShvuON0SaKJ?=
 =?us-ascii?Q?FYfTYQveTMx4ypcqp6Kt1QRKd5mc83l9dNEXTs9oURO2YBbbyEVVUOGyovvy?=
 =?us-ascii?Q?LgBOtHVpx9tIUq095lLyl/d0caSjgOrQLP5P2NGbABBlm6x2+mBvg3xnjy+2?=
 =?us-ascii?Q?PelSzlgANCw4gU6Rl3Isd1wGDsx0ZOvZBW3xkviwAaxe3qHr6ajScvxcU1bg?=
 =?us-ascii?Q?jWn3iDFhllnayvm2jPowN7WxYnrJgJoS8XWjW6BlNooRrnDoL6NcTjzULGgN?=
 =?us-ascii?Q?SyOEdBw7/oujGjvyy8asYtyyBI1f9oSLf1GSrlTspqTD3EMc2LpS6HrZO8s1?=
 =?us-ascii?Q?1axhbsIqqRBmFo+VD1rytVqFpGB3gC0Wdr3zNJVrXb9wLWFPqYikSCYfvPdz?=
 =?us-ascii?Q?qCTjudIi+3pCBxnnkHc5yTPP7tze0nMVn3RYAZ1q2zVYXefErqH4aUKq0CYv?=
 =?us-ascii?Q?UOuOw4/Z8i59am2Dp5ApvvHHk2QF/ecnEF/i/ATKlN7gxZpu4KwMEsjiaNkG?=
 =?us-ascii?Q?az+ySkWvNlNKWiBO6JNqZWm00j+RSis9nNVfuyg4b7YrUe6l1c7cOF5ulK6I?=
 =?us-ascii?Q?EiLMJKpvdb7g5v1OBuw7dNq/Vyf7f7szhTzok+cZNzqK0G4BXHt2bzZUnXWb?=
 =?us-ascii?Q?X7q7nYF5iFUzI1fbSWWsk8CxUU6rfR178kB+qBmkuQrPrN03Su1CJLv1+1Ip?=
 =?us-ascii?Q?bjda+2JSRbiNuD1VP4+CR7btKfv9k0lJk8wSFYWzI/i/3qX/ExOu5WcojZRR?=
 =?us-ascii?Q?E/J2HU04HCj6JxhVbwcL8GHU8omBQ5mbsuyl8HU3/5QNo3X58/tqM6dcITd2?=
 =?us-ascii?Q?9YuIq6zRukBH8Yd/uXu0V6luu+aLUifEMFxBv3nBzT/adZqiD7wfBXMFAw54?=
 =?us-ascii?Q?+GpNoZgqTepNMvLA0PWeGeycr596invkOgk0yge8XeQ6uI6GWcQah76rkDOS?=
 =?us-ascii?Q?bzrPHYrJT1EFiY7SvWTAxw+YCcvcCE6zVQHMaDZdBtC9aCQpWBXviqJNszUh?=
 =?us-ascii?Q?gxt80+jQ7n4XkWQENHSJrrCpxnE3x6vh+OQP9rnbXR4fLz+WZYRjI9+lvx7+?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cb29a9-ba91-46e4-6374-08dc7e2acc70
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 08:55:46.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SKAyZcRUtZd+mgRNI34ACcTWTNb+AdkZrD7BGc6jT7xiQsWjOW0INXSlY+wkquvzZ9rBTyuK+Tf8XAlxVhJGueBROQt+Z7s+d3zC9oKPvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 May 2024 08:56:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16268

Hi Tim,

On 5/24/24 8:36 PM, Tim Orling via lists.openembedded.org wrote:
> On Fri, May 24, 2024 at 11:24=E2=80=AFAM Tim Orling <ticotimo@gmail.com> =
wrote:
>=20
>>
>>
>> On Fri, May 24, 2024 at 9:28=E2=80=AFAM Khem Raj via lists.openembedded.=
org
>> <raj.khem=3Dgmail.com@lists.openembedded.org> wrote:
>>
>>> On Fri, May 24, 2024 at 8:33=E2=80=AFAM Quentin Schulz <quentin.schulz@=
cherry.de>
>>> wrote:
>>>>
>>>> Hi Khem,
>>>>
>>>> On 5/24/24 5:18 PM, Khem Raj via lists.openembedded.org wrote:
>>>>> On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via
>>>>> lists.openembedded.org <foss=3D0leil.net@lists.openembedded.org> wrot=
e:
>>>>>>
>>>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>
>>>>>> b4[1] is a very nice tool for mail-based contribution. A config[2]
>>> file
>>>>>> exists to set up a few defaults. We can use it to set the Cc
>>> recipients
>>>>>> to always add, in our case the mailing list.
>>>>>>
>>>>>> This shouldn't be necessary if we had a script that b4 prep
>>> --auto-to-cc
>>>>>> could call to find the mail address(es) to send to. While we could d=
o
>>>>>> that, this opens the door to people trying to add a way to notify
>>> some
>>>>>> people (e.g. a MAINTAINERS file) which is not somewhere the project
>>>>>> wants to go right now, and this also makes sure the address is alway=
s
>>>>>> added even if one forgets to run b4 prep --auto-to-cc (which is part
>>> of
>>>>>> the typical workflow for U-Boot and Linux kernel, but is not
>>> necessary
>>>>>> thanks to this patch).
>>>>>>
>>>>>> [1] https://pypi.org/project/b4/
>>>>>> [2] https://b4.docs.kernel.org/en/latest/config.html
>>>>>>
>>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>> ---
>>>>>> This adds a basic config file for b4 to avoid to have to add the
>>> mailing
>>>>>> list by hand. For documentation patches, one will still need to run
>>>>>> b4 send --cc docs@lists.yoctoproject.org
>>>>>> manually for sending it to the docs ML as well.
>>>>>>
>>>>>> Note that b4 supports patchwork, c.f.
>>>>>>
>>> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-=
settings
>>>>>> though I have no clue what it does with it as I am no maintainer, bu=
t
>>>>>> maybe something worth having a look at if some maintainer of this
>>> repo
>>>>>> wants to use b4 to merge stuff?
>>>>>
>>>>> I use b4 regularly for meta-openembedded maintenance and it also
>>> updates
>>>>> patchwork when patch is accepted, I have this config.
>>>>>
>>>>>      [b4]
>>>>>       pw-url =3D "https://patchwork.yoctoproject.org/"
>>>>>       pw-key =3D "<mykey>"
>>>>>       pw-project =3D "oe"
>>>>>       pw-review-state =3D "under-review"
>>>>>       pw-accept-state =3D  "accepted"
>>>>>       pw-discard-state =3D "rejected"
>>>>>       send-series-to =3D "openembedded-devel@lists.openembedded.org"
>>>
>>
>> This inspired me to revisit the issue I was having with "b4 shazam <
>> message.id for an AUH upgrade>", where
>> shazam would stumble because of the "scissors line" (--- >8 ---)
>>
>> Turns out the solution appears to be
>> [b4]
>>      stdin-pipe-sep =3D "--- >8 ---"
>>
>=20
> Correction, where I was having trouble was with "git pw patch apply"
>=20
> $ git pw patch apply 43726
> Failed to apply patch:
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To record the empty patch as an empty commit, run "git am
> --allow-empty".
> hint: To restore the original branch and stop patching, run "git am
> --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> Patch is empty.
>=20
> Whereas "b4 shazam
> 0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833-000000@us-west-2.am=
azonses.com"
> works:
>=20
> $ b4 shazam
> 0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833-000000@us-west-2.am=
azonses.com
> Grabbing thread from
> lore.kernel.org/all/0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833=
-000000@us-west-2.amazonses.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 1 messages in the thread
> Checking attestation on all messages, may take a moment...
> Retrieving CI status, may take a moment...
> ---
>    =E2=9C=93 [PATCH] nghttp2: upgrading to 1.62.0 SUCCEEDED
>    ---
>    =E2=9C=93 Signed: DKIM/yoctoproject.org
> ---
> Total patches: 1
> ---
> Applying: nghttp2: upgrade 1.61.0 -> 1.62.0
>=20
>=20
> Any tricks to getting the Message-Id from patchwork?
>=20

I assume you mean you want to use the patchwork id with b4 shazam?

In any case, you can send a mail on https://lore.kernel.org/tools/ with=20
[b4] as prefix to ask for help or suggest something :)

Cheers,
Quentin

