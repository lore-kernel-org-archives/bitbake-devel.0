Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C414C02194
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 13:38:08 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web11.11992.1738762685389796295
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 05:38:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=FqadB2Zq;
 spf=pass (domain: cherry.de, ip: 40.107.20.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bkoi1BO8qz/4Arx1iJ8VYdxc1ytWoolTBsomrhm9ag7Od90cwU5omIEQL1xS8oZNK61aHXoSH77PphzBDMEvG3BwWo/cXGce48v7oWlXOuSBbxfZzQ1FgvNpNWRNf/QJhgeqhLuACATT9WuktBwYNuNgvN9uhtMCb8toEp5e4wta6YfitrfLa5aZTQiTIytK8MtnUutYszYV9QS4aLZyRUeUTd0x5u5JsWG+6sePz3H3NLYQFHfgLTt0DDdckTskGWTO9NGDQHVjMMmVAGELQh0P1cBYsLhJLQFNUYlfVJNRYHXLmi9gEH/X4OC0dd1MQOU+CfmgqnCyoadHy1lKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wZiU5JerdzFsxnMIT74FdUsjt1ZKYg82iz9GL0RBFI=;
 b=SPV0TsrBYeF14+UycOb3UPuv11Vp+WEUjkDtgRjbHtMq+RMohDEMaBrszlh2ZXH9nSgiUXCqlT26a7JXu+Cw367FeOs7nMVRdUj8FmBv8NK1xwqdG0YRgtVN2mtgF8niz9Qkx1+/LJXEYi6h18Sdu/PXXUe836AK2y908112uUfSK0/+J2EWPzOZSgBH9fkvxo+FwY9bmtMQIZVBK0Dsr7rXTRSEHfd4M20JR7poxJGO5KGkn4x+zw5qhHfjUTDt6wSQOD6eZJXPx75GRP64gnpRI+N7nktSRnEnl8+RoBKuz5oL+YR9kQert09hbz6vOWwN9JyXz8L3yYKu989f3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wZiU5JerdzFsxnMIT74FdUsjt1ZKYg82iz9GL0RBFI=;
 b=FqadB2ZqCFlIqP8VLQkatwPolMF/bwECaDVBicJjDwX+vIg4QSo8yBJtX5s8L51XuomQHYNsxlAvM2jrz2c+lBGmvyBymwEvt5WZ1dBzXD1AoPmq3Sx12BqED5SlvUcMm4fPt87hikh/JvAdNLOZaZ0ojT7Q5uhzfxDumZsDEc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8860.eurprd04.prod.outlook.com (2603:10a6:20b:40b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 13:38:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 13:38:01 +0000
Message-ID: <e81c3992-5da5-42f4-b629-3288c63d00a8@cherry.de>
Date: Wed, 5 Feb 2025 14:38:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] add basic support for b4 contribution
 workflow
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Quentin Schulz <foss+yocto@0leil.net>, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
 <abd86c0a-0c57-4425-b4c0-b8c9ba21cbea@cherry.de>
 <7b5e158cc6d983ec0aac8c13365572fe5a44b3d2.camel@linuxfoundation.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7b5e158cc6d983ec0aac8c13365572fe5a44b3d2.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e4bfe4-2427-49da-e08e-08dd45ea4f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YM7wrvT9Tdidr7uWmp/bjVFG4YoyDxgJIhoeOoHaTRBXc68GljdqpV51hVFn?=
 =?us-ascii?Q?zEMcRd+Y+ZjandaJZyUGN6XS1zidMcGsyEs0Tozf49xZsP8mweETirDUM76B?=
 =?us-ascii?Q?WbXYiSDFlEHqRLUkLpyMiEEcp60kLcKu7bwEV8pe3sh7MGHapu9qQh0jitWO?=
 =?us-ascii?Q?H0mi1DKIlLyBwjJSt7Cmqg9uEUjSuTAnqqtk70xytAc0wmwjPX3n3LO0wVJT?=
 =?us-ascii?Q?EnYgwPJApxq2k3AZlwD7tAP/DP3t0VhSPUWrzauVHt0iRfYlcmywN1jBwWrR?=
 =?us-ascii?Q?wRT7KEGQQZtm74yNwS2nP4S4NQJUAY5T6IifvxwWMm+12ADVwjXRqcIfulGy?=
 =?us-ascii?Q?uzlTNr++uW3TufqQwrq/TUdsTWVdIoKMhUsjfUb+bEqtCketY0j8QXy4ZY7t?=
 =?us-ascii?Q?59ejjBiBe5HB5gJwhLSAG9DfHK5gs7UU7SNT5d4Cv//uw4XPZFZk/Kk/Qt+5?=
 =?us-ascii?Q?X5Ste0ARWcwcg4/5p+sOrGsoBN5iqXC12A2ZRdsQhXsUlaFSKbP3QbfCuFpu?=
 =?us-ascii?Q?D5dJBUEbvRoECVxQc9EDunAJZ3g+PzH6fnmpZ8HWc5iBWYK8sc3bis0VD9GH?=
 =?us-ascii?Q?MXhqNZPo5z7ev2nxNQobO8nN74hArhu6jAFRo0T8/HBEIXBpXkPgML9VBQfo?=
 =?us-ascii?Q?CisPsPZEwbQRkpIAprPACzivVmSCm5abAjyVFNOqwXN0jjAoaFyXSckkGflF?=
 =?us-ascii?Q?CPkyCWmGjX52Ly/WnRTzcuFW5KOjui/2uHwrjlctqUOVwe+vX4aifqrvrrq/?=
 =?us-ascii?Q?IqH56/nt3rEUqzHMEjIOaCq6BAA44lf32AaXcPk6H4MJRplBTcYKZziH2aUa?=
 =?us-ascii?Q?a/7peo3paXSSohsAkmEpm/ks6R+OdA0sV9mhEoiGM9CtuvwY1uD6+dWcIaES?=
 =?us-ascii?Q?58exnSFEvuLLnUP9A4WZ56yaCYhn1oIFZpUePRYczznKxJx7t3y5Q6e/T53D?=
 =?us-ascii?Q?hVvQgmS+K+eAdgvhJSnRaBkJzLEVdOGFYIliFz6EW0G/RiD/YAFFKAore6TA?=
 =?us-ascii?Q?GniEL5eSZhlRtSJP5wiBlpxPOfIT50YYhkyxPvT3HsPRA+d5iXL4Fw4MU4Bp?=
 =?us-ascii?Q?lQjMcGzL/pfjBC9HsvokqbclBAlJqyee52HlC+wSIFv36Ju6boWyd1rnkjQZ?=
 =?us-ascii?Q?9WB9a2OB51mHmGyZywXBfq8d8umT6MPOQckawFcdwmTMGlIaVjq32YCLDThJ?=
 =?us-ascii?Q?kZF5SdBGdCzy9m5XYhx8OC1XuSsPkp1YRq+kLkZeYFvB151RqBH2zm25gat/?=
 =?us-ascii?Q?TBqNBBOqYtuEVC+CvpppYEnBV4+ZlYIoHmtqIeADnIs9BLyHItoumhhvW6OC?=
 =?us-ascii?Q?uO0ao9y9uYibnWKUNQQfy6+INvC4lrcfbwTrIXgduiNJaw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KTfUn+RlMbmGmXsKAPYIzC+1+0qELZbBHofpnKZA7VimBRo1AeDWnDI3mwxM?=
 =?us-ascii?Q?+jfAvq3kNxafdohHnGRVTsLjIf8m/HCx2uf1lcfRjzpeFxiO5oi5IcKTTCez?=
 =?us-ascii?Q?vz8WEQYBI6J2oCF+cLPbpfIL4VD8Yoie0DDVPTS/FpgIeNxGRovuZ4YAkUk9?=
 =?us-ascii?Q?BKstHnMXTosHPfs39Qb17aYBgYvFYUGbYcBn8+9/i/1CrDhatOBEb7p2nxnj?=
 =?us-ascii?Q?fs+eOqpok8Ymk8y+hAP7H3aOixMu4o28ZmgwTt7OATZik77SQtC7q/PDjqdW?=
 =?us-ascii?Q?uURto5Lv11/COlTg4ApuK3hGWGKbIFLxsXtsjLToQmYKbI5LgOeBMNW60uT7?=
 =?us-ascii?Q?r1N65DRQAI/NmqWBT4IOzU9h0Tvu6ZOIKyxyutg2a9+UsL0AOAx4s7zGSf/I?=
 =?us-ascii?Q?JNQyAsmKgf+HLKJdptCnBUbbJ/dQvsdAFGKUYc8xEGHfsIlnjHPnesN1V/9+?=
 =?us-ascii?Q?9dkzkZ+H66axVu3YpF9QRZhJDe+wj23/0G0xqKdbgTjlyGzhm11MAxR9nP92?=
 =?us-ascii?Q?pShzk67UXeldUvPNHmKwJwKv83HbqTT39AIa2InzbULj8pnjHG898jpPxlI7?=
 =?us-ascii?Q?y2KKGwmnA26XS95IC7//4gD4i9/d003grkg1QMiGbEsWoJzxPH7U3BBZOKcY?=
 =?us-ascii?Q?nUe7bFgSVxIA50EGP3N9yWY/J9jDc2D2cCrZb8O3dvuDDORhc5bVomEhjyHO?=
 =?us-ascii?Q?Mn+RtdYmj5TFVbH59j+OEZ3qZCosnUyKUgcXJnR9apMhRkFsyFHvL27Y+0nB?=
 =?us-ascii?Q?E6azpGBmYhoLngO+yoejUsGt+Kpdo3TxDwoc70K9+HC3rkMjWQoZ2ZlEQ8OC?=
 =?us-ascii?Q?QoTSOtgWnTxBMgITnoy+rRWwRok23Rqtoij5Xwv9O05MrbxfyGGFOVH5kehj?=
 =?us-ascii?Q?3nWcI/x9obsi1Rgp6z0i1tpar9PR8JfJBSQCB7kZOCbI0JYRsYWFS7sbdL6P?=
 =?us-ascii?Q?cKp2FPToOZAZQD+h1m6kaG0H33kwmJXoixG+mQ8+u/Smbx22kIZyjwGUplA5?=
 =?us-ascii?Q?R2et45Mc+XB8dxUJR1FkuKX9U4QWaKDjQw8vnQEmS8LEyMPHX17WPnGuWp2H?=
 =?us-ascii?Q?FwInd1A8D+TEyJXWnSOcqweGvvvGujcJiTAeCUjbjz2EExvpxbjAbLzaTDgC?=
 =?us-ascii?Q?pTd491M76UY2k5LHibFN1CUlmsM7o8zLoEe91hd+L76WnJ0vSzTCe6/NHQyh?=
 =?us-ascii?Q?tQ4DQKc2ViIRVaaAU0CTjOhwo2ivl+F+V50ANoMGXNxmA8XyAOZYjTgo30+C?=
 =?us-ascii?Q?njhACZlqFAMVA7ooXCIugcccwJrHRb9hrKoEtpZUv3jV4Ras9dFRXV5F0M3r?=
 =?us-ascii?Q?0gFwlBnnf+NaB4f5P25sgoKOS2o9ikKULozEoorw/WJm441Cws63fs+x4Vff?=
 =?us-ascii?Q?Bhfk4S0zfg1RW40mY/xuAwBzh0yKzTe9d7eu5nQ03u3KQyJMnpKXEsAWkk4S?=
 =?us-ascii?Q?s8Iy8eAZDkX5c57mOQ5Dsd+ByusC6PXxp5DXlPeaLj/L950XjkgwuFV7WINF?=
 =?us-ascii?Q?KfpUuc5e76saiqrO5JjNKe1FQQveo7zp1YeaSt7y4qhEQuWY7AMVTqB6QtOw?=
 =?us-ascii?Q?Wy4efolVFNOzOMeWA1fL4V6QdkfyvOIyu+8SZCdM9IqwPmczsuvji0m3dUF7?=
 =?us-ascii?Q?V3v7UQ7agddQpVmHXpWNu4c=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e4bfe4-2427-49da-e08e-08dd45ea4f7d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 13:38:01.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFh4p4PkglG/loQYQuOwwER9q8f+lmZnjJSoj3VfAVKslBndUsXAb8sAjIGfRMm7kGLqZM1DI9z5wipC9iSNpkv3u/5nwlz4Zjy72ItMir4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8860
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 13:38:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17155

Hi Richard,

On 2/5/25 2:34 PM, Richard Purdie wrote:
> On Wed, 2025-02-05 at 14:11 +0100, Quentin Schulz via lists.openembedded.=
org wrote:
>> Hi all,
>>
>> On 1/17/25 11:44 AM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> b4[1] is a very nice tool for mail-based contribution. A config[2] file
>>> exists to set up a few defaults. We can use it to set the Cc recipients
>>> to always add, in our case the mailing list.
>>>
>>> This also adds a wrapper script that is called by b4 to figure out whic=
h
>>> addresses to put as Cc recipients. Considering that patches to the doc/
>>> directory also need to be sent to the yocto-docs mailing list, this
>>> wrapper handles that. A limitation of the script (lsdiff actually) is
>>> that it doesn't know how to handle empty files, but those should be
>>> of rather rare occurrences.
>>>
>>> While the wrapper script should be enough by itself to add the bitbake
>>> mailing list to the Cc recipients, one still needs to manually run b4
>>> prep --auto-to-cc for that to happen. Therefore, let's add an explicit
>>> send-series-cc so that at least that mailing list is always there.
>>>
>>> Because we currently do not have anything to check for patch validity,
>>> remove requirement for b4 prep --check to be run before sending a patch
>>> series, via disable-needs-checking in prep-pre-flight-checks.
>>>
>>> [1] https://pypi.org/project/b4/
>>> [2] https://b4.docs.kernel.org/en/latest/config.html
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>> This adds a basic config file for b4 to avoid to have to add the mailin=
g
>>> list by hand.
>>> For documentation patches, the additional mailing list will be added
>>> when running b4 prep --check, as is required for each new series manage=
d
>>> by b4.
>>>
>>> Note that b4 supports patchwork, c.f.
>>> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-=
settings
>>> though I have no clue what it does with it as I am no maintainer, but
>>> maybe something worth having a look at if some maintainer of this repo
>>> wants to use b4 to merge stuff?
>>> ---
>>> Changes in v2:
>>> - add b4-wrapper for auto-detecting patches that are to be sent to the
>>>  =C2=A0=C2=A0 docs mailing list as well,
>>> - disable forced b4 prep --check for each b4-managed series,
>>> - Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c4334=
c36cc7@cherry.de
>>> ---
>>>  =C2=A0 .b4-config=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
>>>  =C2=A0 b4-wrapper.py | 38 ++++++++++++++++++++++++++++++++++++++
>>>  =C2=A0 2 files changed, 42 insertions(+)
>>>
>>> diff --git a/.b4-config b/.b4-config
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..0b699f204c414099f2118ff=
dbc9f7b24454e4a4e
>>> --- /dev/null
>>> +++ b/.b4-config
>>> @@ -0,0 +1,4 @@
>>> +[b4]
>>> +=C2=A0 send-series-cc =3D bitbake-devel@lists.openembedded.org
>>> +=C2=A0 send-auto-cc-cmd =3D ./b4-wrapper.py send-auto-cc-cmd
>>
>> All the above should be to instead of cc, will fix in next version.
>>
>> @Richard, is the b4-wrapper.py below (this one for BitBake and not
>> Poky!) fine in BitBake git repo? I believe it should since it needs to
>> be called even when one develops from "vanilla" BitBake git repo and not
>> poky combo repo. Just asking for confirmation here (and maybe you want a
>> different name too?).
>=20
> I guess the location is ok but can we call it b4-bitbake-wrapper.py

b4-wrapper-bitbake.py to follow the same naming scheme as for the one=20
for poky that is stored in OE-Core maybe?

> please? This is so that if someone sends patches, it is clear which
> wrapper the patch is against. Top level files in repos can sometimes
> get interesting for that, even if b4 should be helping make sure the
> right patches go to the right lists in future!
>=20

One could have the interesting idea of contributing patches to the=20
b4-wrapper-bitbake.py script without using b4, so a unique name across=20
the code bases makes sense to me.

Looking at it, do we want the script to be in contrib/ in BitBake repo=20
maybe?

Cheers,
Quentin

