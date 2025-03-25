Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B232C3600B
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 17:30:20 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.24])
 by mx.groups.io with SMTP id smtpd.web11.1791.1742923815023336314
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Mar 2025 10:30:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=GqKlYM8l;
 spf=pass (domain: cherry.de, ip: 52.101.67.24, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxSdFq0TJNH+g5fzgpwXinDGhLUyBZIDI84YdynJ2aK0viqovlyjq8YeCdTZGpY48/tY2XCcZ5XQeSN/i77CfT40sVMpAINY9aIhB5aC/vNkhBmZ5ZDqnmrWEXQ9Ib+KHmLrozxZAcm90qtha+QZPqDeTJ6prmsmePgHlZVUFmtZv78q5D+2JUVzbm0wa39+S0d+1PGQ0maed3G7N08xRnaQHweFc82YxXuNK6OTxdALGeMOCK6V9lD9Pz/wMEQ1clyMdd+zPlVboWhZx7hRJG3nWdYTK3NIWk2huZGkHo1a2ZFD4zEZY/zfZiHFPNXRBbO/3batpuToRy04F1WsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0ZU/mksuAv2aTzcg5wU4+7hvpDPJv7+L9nHhC80Kbw=;
 b=ierh2M+sb1UTM7WvXivTPOdNStUH3yHoLoC5gaOdzViO75viH4xs/40JHriiUBsU7vnFIgpBRvYkBk3qYMCxBI3tRRgmJp743zjzJkRcRROeBwe1E+rUS1pboMbM3JFNzxmsg1uRmjbtPltOMo7RRBqti57brDnBPeW3eLB0PaMBGOrbJC2rU5eV3N6wSp49iuPAPalgUTKIXcMhwmnF6hjhFuGBEpgYMlsLvWL2JsllfmO/4/YXHtsdjY8dMcfZPeSCPw4dJg3wcDjwlifFKSCV994y0rxftXgwOHWf/9ZjxoORJ3OkJkAZvxO3CWavnPr3TiG+/i/89D95wKs5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0ZU/mksuAv2aTzcg5wU4+7hvpDPJv7+L9nHhC80Kbw=;
 b=GqKlYM8lmvEmlnZt5Gb2PEQyAirmSrl8OrJM63amcnpj6umeNoGqx4hwsayicWWNqY/XiLksrQEl1W+FkJ0zeo5MErD86sVD0ymuUAjvsLWQiY4ozvp9wu0HG54EEijESLCduzXpAOVP2aZT52MJw8b+IKfEKtW/ptz3UZXnk4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10915.eurprd04.prod.outlook.com (2603:10a6:102:492::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:30:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 17:30:11 +0000
Message-ID: <92482b25-bd0e-4a9d-82f5-1fd4fdf473cb@cherry.de>
Date: Tue, 25 Mar 2025 18:30:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [bitbake-devel] [PATCH] doc: Mention `if [[ somecondition
 ]]` is not supported
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 javier.tia@linaro.org, bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250320003358.977774-1-javier.tia@linaro.org>
 <0531cca3-683c-4ec3-853c-59da9492c8b6@cherry.de>
 <7275d5d500666f6278ec7937ab15ceb10cdf4f58.camel@linuxfoundation.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7275d5d500666f6278ec7937ab15ceb10cdf4f58.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10915:EE_
X-MS-Office365-Filtering-Correlation-Id: 5969db89-d1d0-4812-1477-08dd6bc2b20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xyMWlQbtd9m2L+zGSoB53rp36jY5l5Sm7w12sz+l1CE8kukDVJ96SKDaFZeG?=
 =?us-ascii?Q?9SHg3aDOKRAAx0OC4xFC5FQerJk5glsReAW0qYuPXPQYnQjmKHev4D+SvIt9?=
 =?us-ascii?Q?PYbAuevV/31tYzvs45BhEIhVgOXKO5fvvI7TwCDpGoTPsY2fwwQeIG0diJ3T?=
 =?us-ascii?Q?asltBbC6ly13cn7/6rBt+f6OsfXJ0OcGl0qBAi8fuUiNusI3n3AVCIgpg7vG?=
 =?us-ascii?Q?liIL+Ankr/uEVQTJ+gg6yvv3nQKMOidFJha0K7dB5QprPoOp7Ub30BbugZpQ?=
 =?us-ascii?Q?rEcq6h0S1710h1CX0C4Imf9esLzznPIiChAKD7b+X6eujI/psUUTOqbCWOD3?=
 =?us-ascii?Q?jQEitw9QmhTUYcrKmFVIeV01ssnW8HNwxOpZCo+6W1kGFVz5Nzoxho6exG2c?=
 =?us-ascii?Q?mMn8ad682Po29nET0MGtBKRaEtuszKwbj6cTtHQZLnKNgBmsTUa0ws8j+lLL?=
 =?us-ascii?Q?XUdzn13Ojjm7Er9aovpXn/gF5ZdQg+q8F4PfH8PM0Lux3mKz1+/tU9xbsj+G?=
 =?us-ascii?Q?K5kic7YmXgqkkXXdFWbDmAXdWlojFx6Wa7qtsLqnXM4qeRQcoBtuucLzPjcR?=
 =?us-ascii?Q?yRRQ6+zLkfcVNoubOu9UrkmgVq3hELP3D1PhMtq7r0awmSidmXohUbULY6D/?=
 =?us-ascii?Q?gn8S361D0xa+uCmQCRx13EZEAAwsaHSq0/rEhPRH/CZv5iA3Q8O/U++W7lQH?=
 =?us-ascii?Q?xhEbDtnKlq8JwBsm0NfTepbzuZh90+R4/WiP9973r1P7LXSfVz7M8t4RUBax?=
 =?us-ascii?Q?aYExGKJe7AvUQ2BBeZXerEY3TfNWK90o5xN6Ia9LC2FWi7tGM60Gmffwexu+?=
 =?us-ascii?Q?LuNZCuSWJHWTpQIarCYU/A185n4nI6c+ske5xvLYWo07U9Du4WRngkqv9Hnk?=
 =?us-ascii?Q?9E8Cs1EW42vtzROW0zFaRz2+F57KT2gWgQDUs+etto3p6OUe+5Na5pUuPthT?=
 =?us-ascii?Q?C+dKtdQJJSvig2kEAXyax5Cc8T2sk986engXy9oRFQT6PhPZSYg+ogs97KKa?=
 =?us-ascii?Q?aamQ5b36Z9Shdhn+bPO5+Wi5cqAJCbUHUcre40zm1OUuRyTnax7a9DKCu3Pw?=
 =?us-ascii?Q?NiYmA2rNsO2iWbbC5jNJyG7hyUkiopRwfPHV399TcVcMXlaXiAjgWHQhT6Wi?=
 =?us-ascii?Q?MwtR2IaFrHrzbJc99aQvknfBRjYL7h1+dsFxWZWAhZSGkLxRXgLriLRMjR6l?=
 =?us-ascii?Q?IrTDOa8mB+y5MaHMJsyITFrioajHhQ9lTfQZu2e5buBt9etQh39PrSCDeHGy?=
 =?us-ascii?Q?OnWUxvdXygzJbl2rjPRw37CoB91u54WMjDX6W/ssPmsSmzChM94tJ0fj7WHX?=
 =?us-ascii?Q?gaujpWgd+WX0IbCE/aV8FXCM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MsuUNvBYvexZ+mksRnb3fw5tS7LQ0+dHWFIltG35e6kTwMVIUfjGN0gcF0m6?=
 =?us-ascii?Q?xq+OgmXDH29LQvBNkvOOqUWu5FkMvfNH5dyvs+mdWcGoxxlTsrwMp4CBUivP?=
 =?us-ascii?Q?W43MOfRZzzsDPN8ZACWAR1eNqywX1sQkBcuAANvot8z6VtDQ8sA0a2cFeTsr?=
 =?us-ascii?Q?dbCquGSOvBYL11fHSXGvp9KQ4/mFWiqA4kJifJMCOhSEeSJE0IC+9815pgG8?=
 =?us-ascii?Q?7TDdZTA3aQMqyN/NorRL99ZugjykaRs1PFlCt1ESwaQMOt1PCsfNZrUey29W?=
 =?us-ascii?Q?INP4gQzZk4zmvQMwSQrNe6tkyK5bH+VpBP7uOmTWyf66RSWjhJ4txDoB8u39?=
 =?us-ascii?Q?IZuxR2d3S9FgksDY4TZUYO1lPYt4qxjqxAKrKAA3IgykWl0JUXj5MGTiqwPJ?=
 =?us-ascii?Q?ujGB59Xy1kLsdZtux9yqyipx8VpO9DQpN8j8lrJaSXZy6GsQ31C/MPyGAhzi?=
 =?us-ascii?Q?kprEFrqGxl+cfgAvkocgjPFcJTtaGxa1W5116L6naOMiO/Ve7vEi3eUV5fUL?=
 =?us-ascii?Q?UrRyd7a04d4XruWG1P9SpRzbNBqwusOo45S3guCOKWVeY1C6Y3VASIOxYWDz?=
 =?us-ascii?Q?Whf3wUaR1xlshxwC2t/Y8lw26ALbRigT6YVHl+MYyY7VC8d4VWYfVaz3uyJ6?=
 =?us-ascii?Q?W/XlBbvNOYfbvmY8BmqyewIq2amjL6bEOCN6/lbVUMeHKOebuE6BI0t49/3c?=
 =?us-ascii?Q?2qpKp8uEC+1VYz4+TuangLCRbIxmCcqT/dFfB8n2JxJekXjVGGI5GzjVbXVw?=
 =?us-ascii?Q?+GWTtyO453XlB1C8c1l3kySsw5swjQ1lYDpHHVkFNkUCrSLhWSqTk8hybsXa?=
 =?us-ascii?Q?S5rtd6fuQvesRs4ex53fa21oPV1q6jdZE9qpYUDbPKNWtx8vq5xp55Y/W6AQ?=
 =?us-ascii?Q?qjPUIqUajixFZT80Rbqi3EgmWNHPqplghUiqKwWAsoA+hT67AMRY7cTGJCcY?=
 =?us-ascii?Q?+kRRCaZW3DAR0LId5egrui5SvAcrz6Mnr7ijdZUkMTa6wOTHy5P4LDaJjZ5s?=
 =?us-ascii?Q?bdyjQtC4xONIi22pjjqWrlYwwhKPJP1bKkUzXP5boDvS71nJhGWkgoUWHq99?=
 =?us-ascii?Q?aqg2wMxKa9cteaUe5wGiUrstkhA7nAzcdJk79AnOOgT6Bd9VveAoWQola22e?=
 =?us-ascii?Q?g5nggt3gDxW8rwJGdlt4KGujs5GpwI6kI1T+loz1J4/JeeYZ/pKb0vBypvsh?=
 =?us-ascii?Q?OtMcmY0EbJAXDv9QNPVHIsGesvYSB/WyK6U+08t7N5WNj77gxQmr7NdHWXy4?=
 =?us-ascii?Q?96kE5rj4/VA7a6eTvSzaxYL+Xy8UQLHtSUmuJhsry4YylkOu5aMwrJd6HMic?=
 =?us-ascii?Q?MbDTdvEoJJgKzbdTAYX7D1p0lX0y2Dah/C5532S9t/b4tS0eTOAhdsW4JYh0?=
 =?us-ascii?Q?8oD0RnxWwU2uT6td5gcKNBdi6cfgGqYUbilj7aibkl+fM7drwsgBbGiM77Mi?=
 =?us-ascii?Q?bh/dOI0sVuNN3os60ZBz1jXeEb6tFk36DYkT9B1mYMWz8rHy2K3ULrW2V+x2?=
 =?us-ascii?Q?GAPKeow09aOYBDBglpby2wv88+IYPiDINK7jPExvXe8ZbzXUpuGgSMoytpPv?=
 =?us-ascii?Q?/4ehW6B3S9WKzUAjL3Hsmk+ZFM9/uiNDDV4BOFAIHYjJi2to9ALtQLj8nesV?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5969db89-d1d0-4812-1477-08dd6bc2b20a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 17:30:11.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcCHqFq/0CajapAtgmdZAgJ0fC9PVslIhP8I+24RRaeUZqCAY56aNE7MoPtKJ4ytbn+NiT3On51KRwcxd7P8365xyfnR3iyJCshpHF5w8UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10915
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 17:30:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17492

Hi Richard,

On 3/25/25 11:14 AM, Richard Purdie wrote:
> On Tue, 2025-03-25 at 11:04 +0100, Quentin Schulz via lists.yoctoproject.=
org wrote:
>>
>>
>> On 3/20/25 1:33 AM, Javier Tia via lists.openembedded.org wrote:
>>> I keep forgetting using `if [[ somecondition ]]` is not supported.
>>>
>>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>>> ---
>>>  =C2=A0 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++=
++
>>>  =C2=A0 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b=
/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>> index 415fbf6d6..5474e154f 100644
>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>> @@ -1381,6 +1381,10 @@ To make use of this technique, you need the foll=
owing things in place:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 To call your modified version of the function=
 as defined in your recipe,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 call it as ``do_foo``.
>>>   =20
>>> +=C2=A0=C2=A0 .. note::
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Conditional expression using ``[[ somec=
ondition ]]`` is not supported.
>>> +
>>
>> Do you know what the reason is for that limitation?
>>
>> The example above this git context is not really implying `[[
>> somecondition ]]` would be valid though.
>>
>> If I remember correctly, the shell functions are run by /bin/sh
>> interpreter, so it depends on which shell you have configured by default
>> in your system. Is it possible this is due to you being used to develop
>> with bash where this is possible and having your Yocto build run with a
>> different shell (e.g. dash, which doesn't seem to support that? c.f.
>> https://manned.org/dash.1)?
>>
>> I think we should recommend people write POSIX-compliant shell functions
>> and tasks rather no?
>=20
> Bitbake parses the shell functions and our shell parser can't cope with
> certain syntax unfortunately.
>=20

Ah, I see. This happens before the shell even runs the code. Do we=20
happen to have a list of things/syntax we cannot parse?

I think it therefore deserves a bigger place than a small note, maybe=20
e.g. a sub(sub...)section of limitations?

Cheers,
Quentin

