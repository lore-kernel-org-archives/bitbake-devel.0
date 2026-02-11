Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C08E9E31C
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 14:45:47 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20581.1770821138559787145
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 06:45:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=U7pkkYzM;
 spf=pass (domain: cherry.de, ip: 52.101.84.66, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMsGAZK4Pb3kfyaTyHSIQ3QLl9EHf1RDAJktvaAkTgPHoyRn/mqPtQ84XFmCpNMp9Ypl7X7yyAA5M4hm4YehgxtgopVYzbvryzvoGOpZtV6Y+c6IjNHCTEDO8bGEY88YV9SOdSHtJGd0wgFgP9mLrCZhdrGjA/VERT5z+YW2/cj+H49kD7w6KwyYC/4yV6r5KDdB4ClrlMZ+EWGT+vHmOah+LAkrh6DAifajkpRb1hQZ2Tl7q9rMPnqBHnJjFirvcucTs6Z5RpHRtl4/D6xImmpjuwMdlv3E5TYjPM/qJUwjYOtlYmZKJrv4AGuv2IuuGP2HPFrQgxiOxQjSNavw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aZB4OEojNiwAyNdQiKgWMDBhF0MdpFXKvlpHDizxwE=;
 b=lTtggz+Lndcm8s1d0KmZX1t1PW4cG9twO+bMyyo0UObbGG+IQSVShieiQvOPe0LDu2w4jtjrwPQFXw0HDWSBkAerZER/Q4THaAShSygwNdN7DdH0+6ubZdBalc6de6pRPqFvBcEtDvQljLQUT5MydhAHOSk9XAHVJc1kXnu24eOD/c794Me5HCQv97ZyOD7X9SEbE0QgsH94SN0z/rrSp/L/thRlocRBzjaq5Rm2dKCTc9aHAq0qwX16QXJji/n1E17bxh+6cPArtLjJ+MbJSAspeLpTVuR0SAC0Wv18QPEhcjUmZjptUu5ndt1tD43Ivs3wyOW9qlSxqPasE1Jkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aZB4OEojNiwAyNdQiKgWMDBhF0MdpFXKvlpHDizxwE=;
 b=U7pkkYzMs/h8dyct3Zt8QA4p/i2AviGhSoOWmacLjwufyshTLIPBB/YUxuFIKEyBa0TJHoGlnRUlSKirpXdnn9XMM0eRNEiDFTXiN7A6Ev5K1xR4gpBTIgiBUDM7+thoaTUh8AC3zxvSF+dJQnOIF1YPqM6mYMfs6wPXXXAWuVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Wed, 11 Feb
 2026 14:45:34 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 14:45:34 +0000
Message-ID: <6c68419f-4827-4173-905e-534acadfeecc@cherry.de>
Date: Wed, 11 Feb 2026 15:45:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual-metadata: list
 known limitations for shell tasks
To: Paul Barker <paul@paulbarker.me.uk>, Quentin Schulz <foss@0leil.net>,
 bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org, Javier Tia <javier.tia@linaro.org>
References: <20260121-shell-invalid-v1-1-3d49dfcd78a7@cherry.de>
 <835b21954f52c9416d9eeea9824b6437ceaa6482.camel@paulbarker.me.uk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <835b21954f52c9416d9eeea9824b6437ceaa6482.camel@paulbarker.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0392.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB8PR04MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6c13e8-a962-432e-0b42-08de697c361d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Tb0aUJ7itXk2xw43W2LvPUbBLU7vpqIj9N2J/EP6kF0zgwATbp4D8FIJK4Yc?=
 =?us-ascii?Q?+uT7Fay6U/CBbnBGnXQ9NeQ4tFZpl+am8+1ipm0A7LUHGlmMDxBuHFR6oDuk?=
 =?us-ascii?Q?sxQq1y/ON435TyRGAglk/mjx4aWCuIV81HYSDSWbWPF9MMdrAhEf1SGUR7La?=
 =?us-ascii?Q?szHOF4VV2/aV7kjLTbNOtzUOGYVyUFRGE/PzWcQETzzEB8OVUpD7NkPIY5gV?=
 =?us-ascii?Q?hG8nf3Pj7TW2i+YnMhjwI/q2OvQj/DXavU92Ijv3M6k7pY1wuPxQb9bu4Ozg?=
 =?us-ascii?Q?NA/Fynu6dikDrR7beZvnKuQfGqLx2XCYYIY+h8zFn+Cd76qSq5iyAzdudk67?=
 =?us-ascii?Q?CShPjhgtJY1KbSmua1kf7Qux4psnjszRNGZw21BEkY+5luLHeDRjH/KYmChp?=
 =?us-ascii?Q?cLZOE2DiMxA2Jp4bz1WX8LgSW5I3KKVWMT3dqS4ASJT829PSRcfABRwVy6Yv?=
 =?us-ascii?Q?iMuMKmLOIsEIeyfr4uX/6W6x9L9oCm1FABbj0ggsNtMK4umJQ1U96sNkpGuw?=
 =?us-ascii?Q?Oslbso6zOWNwxmUarfNlgT3UzyhANTJUtYYHY1q7vKfz2VyDNPxIrZTwkbpY?=
 =?us-ascii?Q?oG4Xl+gR1g7iP0qbcTxQCJ9ATMtrxLXnRvgIyUYK42PmmjhH6zzb5McsxbX6?=
 =?us-ascii?Q?Ne+phl+P0tQusfwge4etkSvEVeUFlbhepzq4D3YKZYSIKJzYAOADisWEYrMP?=
 =?us-ascii?Q?cLbkyTZ6sn6AfxOreyXkQHf+v8vaNjqppKMhXZe3KEuQUGnwH7Y/ybncDmZn?=
 =?us-ascii?Q?jDJpFrHS/y52V1K1Fw6MoT/lI1VlIUEWpaKcYgdmWaosUcGchHeZYWcSm8tg?=
 =?us-ascii?Q?PBrCBiK4e8NsWzVeibqVjmtvSMKYIcSwK+DQkid4akIB7zXi8P5FTdzKtRPK?=
 =?us-ascii?Q?D5+HwIXpv5jAh/Zixwn/jeJkzbu2drQFy34olkt/ISxsXZRfXdXVyWcWos8O?=
 =?us-ascii?Q?fiTy5feLXy9e5U8FfDPHUszZYDwTzQyaOAFjzhzwtk2dVJR5FKmUmlD3fngm?=
 =?us-ascii?Q?ED9a3ocjXF8lc9RbkgeZXQ8ShFoXFEj67O4RwVqTghuMgdt6AOKXix+ZaUzb?=
 =?us-ascii?Q?fu/qvREbRaoKQodUJcNbEzz0mf1MbwqNOT2AldRehYuiW/VFiLxmWsXFZKu2?=
 =?us-ascii?Q?Duifuq/L5mH2TjAa0QXb7rvfdsJk0kdWX07i5RV3x9kSE8AUpAzh4nUk+O6i?=
 =?us-ascii?Q?5dYMQCvM1ZbEmjTB6jKlXJa2Cdt/LlRaoPQlyamybnkTtKAxAf7kSvyBHNRv?=
 =?us-ascii?Q?oIbH+vNcaPhKPGrFeNSWD0KmEEJj2bY3LcgZ4Yh4folqB3Ji88mrVkZHic5Q?=
 =?us-ascii?Q?Ju+4zaRYmFouK8k/TpyEWK9aW3osl5K1lxi94lIrd3wJKSIhFmZdc4D1dJsd?=
 =?us-ascii?Q?xClC16eSHWmtcpypLyv7ZalXa9gLuUsqmTTeVgDzu2H6sqEKXXfBmh7KhgPQ?=
 =?us-ascii?Q?UJAa0oqtWbvmhD9yjCiiAW/A4zwg8nPan5NJT2PbRm5egTWTexLaryb/cXJb?=
 =?us-ascii?Q?ZMe8w3vIRMsGrgnRGW1xCx/CASQiRdcISafb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ck/eAUJHVNF15kWvEWAFEeOZfEtm4L26Y4AGob/R6rWTuafL+YbtGOgpeKvd?=
 =?us-ascii?Q?u5nNkludP4qrYGuRqq8onaKGf1E8At/hlPh5I4XX1f3tJEIaQZsyp8lmsJnl?=
 =?us-ascii?Q?wMFyrY2+cvL/NQoJxD8xiO1uqmICV7n4HGjx1Tus++/ooizrCJaPUQDAdmgQ?=
 =?us-ascii?Q?f8SEvDjHkce6CpFpxMneIkUWR0xQjTM6CORsR3dCxg3mJjMmAR9PVyN1EGKO?=
 =?us-ascii?Q?MDnvl6sJ62LXT1eLst/aN/8BqfReub1MoZe+rUW9r/z6VM9bdjBgJJAvnPdM?=
 =?us-ascii?Q?TGwvPxua0cS4nxeqvOlMqqOWhPhPncVdaAFgrFZcJKvv3adnZIwz/z+6PaF8?=
 =?us-ascii?Q?9Yt61dcRhiFHZwErFHQHqXELKhX3re3EeqYNziV35icvXKyhyMDGihqgoSZa?=
 =?us-ascii?Q?CzTfsYNQ90V7YnGIMhR9pwNmewZOmMdmvcSgh8KP5DlEs/oj8jlAnYiCwhEF?=
 =?us-ascii?Q?FrNJWF6fixRRzplN63yUilOiQOikJd6Lw/MhH5/NOOP/ajfXnEuOZR8Q1L1M?=
 =?us-ascii?Q?cyDhtDjQXa/Hc1PcmOnagWrmRxJyWBkVrkPLg8F+0yXmLamqWvPZ1q2fXXTX?=
 =?us-ascii?Q?KPD6Zexd+Ytcg8Xhxs3Wd+xvxaNm2cSh233eAfzFf646Kso4IseVjwIiBQOu?=
 =?us-ascii?Q?Zci9rgQKKrKzskZID4pAr/ZUyvqce816VSCUmpHLdhS+pLsJGbNarr0XOgXG?=
 =?us-ascii?Q?um7IBZyW9f/pKcabkUHuWXTQRzO8oLzmhKNm9ERb3Jgk8AoFj+TaMudjx/FY?=
 =?us-ascii?Q?8/7gS1snqYPJEr4PhLGkNOk1UduzodOOlWgyICb4RL+dEwCqvwlLptvnTinD?=
 =?us-ascii?Q?ajsrvWhZOnrS5OBDdIqRLDayoMtmgTZf/9dDzbxPFl4bLIdPrXWttC2Q6Jzf?=
 =?us-ascii?Q?NG1//y/jDDeQGGKSbMuCdOnRpdIztppq5pzTzuU5G2rotp49N07LL9qscKY9?=
 =?us-ascii?Q?eaHK4JmzHLObj8Ag3ZCauipVFFRhpNO9fDWpENgb2/Zm3BwYJ2xsFYX8s9v4?=
 =?us-ascii?Q?XIYmqvth/4BJjpm4tHfUSljq0oggbgF7WrsDOZft82XNDSxfw1yXOtOcPa8E?=
 =?us-ascii?Q?XROpDSpyABn71oQk78VUOE4kmihei6K9qwwHs5+UnZo8qoJ9c9vDJbIeySfQ?=
 =?us-ascii?Q?zCW4et4zX7f86N1IE/CaiEod+H+cYlZvOhkDidNnGak6dyibl/M1O4NxmXBR?=
 =?us-ascii?Q?ErU4NVFEIcX621YfqH69vv+aKNS6CyjMZH22qDkT2PfAxVU98iDkcQP1pbMh?=
 =?us-ascii?Q?atjwsO/9d2zNtFHwTY6ZEknfGDxGYUn9prQq8DHv1TZUGFAagChV2ICZegH5?=
 =?us-ascii?Q?rWWL30LYFc2YQMJzx6WIidi5EIjfh1RdcUEqvZ9hGXnZTSwjUl8DNgW+i9Rb?=
 =?us-ascii?Q?1wb/bNbgFwR3XXGjjfEsKC2v35T6J32T4SmLbRBt3zrWrb1nJbBSMFa5d6b5?=
 =?us-ascii?Q?Bq5Mou8sxtXK8HcSUjO/SeBoLDyu3w1YYRDgZOh4JRMZWkYbGnwQZtMR5vyS?=
 =?us-ascii?Q?Vk6i0CJjybfwGzIw7BXaJ336G67QoVohGgGCvaCgLCbrbknXWnoVFEJorvlE?=
 =?us-ascii?Q?cIM3tj0H29J6PDO3txAh/lQZ7xzMcjhajXK+oiVreIyvQlZm/KDObepG7RdW?=
 =?us-ascii?Q?ni5Mh90lowTqJFiFXJRYCtiSWSyc5e/F/bsf8K2unMhpShrlV8ZAIVv5Nr5z?=
 =?us-ascii?Q?ROBu+tjN0S8+J+5sa+IWamhRcCYMY+H+ixd28kekjU9yyEgSkBcK5rDTOfJM?=
 =?us-ascii?Q?njPXrerH+9HZ0FKe0pY6xg1G+jPUsJrvHNvr9LDWWVOj2aNa08Jz?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6c13e8-a962-432e-0b42-08de697c361d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 14:45:33.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4s8gwxWjCgyNbngb5Hud+ap1xLbD6sjqBZH7o5U12D6BY0BKg6uasXtO7fft127T31Ufikm/KLgzUiGfx/1O1bO19VgtMjY6heUrU11X4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 14:45:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19004

Hi Paul,

On 2/11/26 12:09 PM, Paul Barker wrote:
> On Wed, 2026-01-21 at 15:07 +0100, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Javier Tia reported[1] they keep forgetting `[[` conditional isn't
>> supported and scouring our BugZilla, I found[2] another "bug" where
>> arithmetic expansion isn't supported either.
>>
>> Let's add a subsection of the shell tasks with the known limitations.
>>
>> [1] https://lore.kernel.org/bitbake-devel/20250320003358.977774-1-javier=
.tia@linaro.org/
>> [2] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11314
>>
>> Reported-by: Javier Tia <javier.tia@linaro.org>
>> Suggested-by: Javier Tia <javier.tia@linaro.org>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> I see[1] that Antonin wasn't really for adding the [[ conditional to the
>> list of limitations, so maybe I should remove that part from the patch?
>>
>> [1] https://lore.kernel.org/bitbake-devel/D8R3DBLE3C5T.12J03WL0YNGID@boo=
tlin.com/
>=20
> I agree we should avoid starting a list of bashisms, as that encourages
> others to continue expanding the list until we've replicated a complete
> list of bash features. Instead, we could modify the sentence earlier in
> the file about bashisms to read:
>=20
>      You should not use Bash-specific features (bashisms), such as ``[[``
>      (use ``[`` instead). The shell parser in bitbake also has further
>      :ref:`limitations` documented below.
>=20

Ack.

>>
>> Richard said that "there are open bugs" but my "shell" and "parser"
>> search on bugzilla didn't return much outside from the limitation I just
>> added. There used to be a bug for handling background processes with &
>> but it was fixed (according to the bugzilla entry:
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10668).
>> ---
>>   doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 13 ++++++++=
+++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/=
doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index 18f293f4b..c93845f01 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -1272,6 +1272,19 @@ Running ``do_foo`` prints the following::
>>   You can use the ``bitbake -e=C2=A0recipename`` command to view the fin=
al
>>   assembled function after all overrides have been applied.
>>  =20
>=20
> Add anchor here so we can link to this section from above text:
>=20
>      .. _limitations:
>=20

We have sphinx.ext.autosectionlabel extension enabled, so I would rather=20
use the full path to the section instead of adding a label. Makes it=20
much easier to find where it points at than having to grep for it in the=20
repo.

>> +Limitations
>> +^^^^^^^^^^^
>> +
>=20
> Add an introductory paragraph here, maybe:
>=20
>    Shell functions must be parsable by bitbake, which cannot handle all
>    syntax supported by POSIX shells. In particular, we do not support:
>=20
>> +#. Arithmetic expansion is not supported. This means you cannot do:
>> +
>> +    .. code-block:: shell
>> +
>> +       VAR=3D$(( i + 1 ))
>> +
>> +    See `https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11314`__
>> +
>> +#. The ``[[`` conditional command is not supported (it also is not vali=
d POSIX shell).
>=20
> Drop this as mentioned above, we can cover bashisms in the previous
> section.
>=20

I've been curious and tried some other things in POSIX standard and it=20
seems we don't support most of the advanced parameter expansions=20
(https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#=
tag_18_06_02):
- ${#parameter} always returns 0
- ${parameter%word}, ${parameter%%word}, ${parameter#word} and=20
${parameter##word} always return the empty string (as if parameter isn't=20
set).

Can you confirm on your side? Do we want that listed among the=20
limitations as well?

Cheers,
Quentin

