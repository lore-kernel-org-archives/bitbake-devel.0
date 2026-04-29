Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A080CCFA13
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 14:25:05 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12588.1777472695898400430
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2026 07:24:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=Gm5vR+Tv;
 spf=pass (domain: cherry.de, ip: 40.107.130.10, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOtCbMdy4+M9m5mh2oIBlIecgGVYPhw4zD8Ur4siOLTVn4FvBL3XzZQ1NFezxsOcrvI2vBb43+gkZDcX9+TfIq4L36puTtXp5Y2j+Re+zteybev2qjxV2HKSRCD5lSsihn+ak4egbXJNSC6j0aPJEyAZ1n5YxrGznB2GFs/UueIneemq3tjKFqcwQpHBLmziWrliCsdrwrx3vq31oSF4Y9oTR5vD2SPBVL1QVO4LBIk3x9T71e+WMowaouPy06rbrhAjWbD8h3Wmyj/tmiIvAiUM8CTsopzBtHuO/IcvvjxGL3TX2bQkT7Pf3iJFz5JUKI+qxhM5WVT6fE/lZg3+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a82EVYtVgpHSnpgEjONYARghF5W645WL8stsSJJyNQ=;
 b=K3E/5C9SPyyxR6cK7O15vy8LKdfziNAoI67b20Fg0RtGNlzTs+m/TZcwdnCB2E9o9LFYkkLHBFPbBOCtXRRC4en4lMOUpi9EQ4L1jJLL4Z0U4Qwx9sFgoxeSBzkoXrG57s+tOhr5fDfqIgJtWw5Qmhw+zYUGRAkgnLALa9GRM/bk/BjTPMUH3kpvPnahf7PI/IHXMGRIsYHQuorfFEgofzVZz4Jks9UF4ugUEky63C/6aCWlFLzx9Tdax6gEuCBaxQ39O1CsPKjkBwPUZ0OkR7cqP6Kv1dFysRJ6cIVpGK/+EKOk8+6PRHIL2cXNMYSINgfwsQofH+9kOj6Z40qmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a82EVYtVgpHSnpgEjONYARghF5W645WL8stsSJJyNQ=;
 b=Gm5vR+Tv2emxEYNMHKKeuqxAPuJRGXj77FEf/uKc3fkQVvdRi4AD+0ycGz5uqNBEeC9vkjus7ZMvolx0cO9FOCPtrUHwbLV4rKefJNBkRgnaxXmP5Qt7v0sLziHctoouRA7nVj8PM+G4/2jWueskcf+bhHCooQwRCvTQ0NC3jQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 14:24:50 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 14:24:49 +0000
Message-ID: <9df7bd7f-3a5a-43d7-a0c3-415f69917f18@cherry.de>
Date: Wed, 29 Apr 2026 16:24:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [docs] [PATCH 1/1] doc:
 bitbake-user-manual-metadata: fix inherit_defer documentation
To: Dawid Bijak <bijak.dawid@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
CC: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
References: <20260424062327.820993-1-bijak.dawid@gmail.com>
 <20260424062327.820993-2-bijak.dawid@gmail.com>
 <c25e0e9a-8809-4ac6-90ee-3687972e03af@cherry.de>
 <ljbjkwt32h72aziah2gepb6k5rfxygfrhkfysmulj5scnca5pu@o4vikz4hfmh3>
 <eeab5758b01722f5474855d21f718ea2d5cabff8.camel@linuxfoundation.org>
 <qwehgszst3cphuw4jqsj2u36333p2lpo6cytkdcx22prjmxrdx@acnraxmxwfl5>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <qwehgszst3cphuw4jqsj2u36333p2lpo6cytkdcx22prjmxrdx@acnraxmxwfl5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR08CA0266.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::39) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2a71fc-9819-4d8b-0560-08dea5fb1247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	E0wDPFlL0ghP3BL+LCu+UvV2tX5Yf1EtJHM8ly0S2omeWDI4adhRpiMUl2hPdHGPr6SdZhxIgHlyLzu7loQLT/yQ0ZasDN4JPSXfroSOxrqJdhMCeTUpb71opTOmpYfBQEOnq4uve6T+X3fzZpIsRhKr5H0ANQWpS76lZGgPC63cgbu7WKa79DRv6ScjjXJ/SrZwNxnbcpjKyYT2HCzm5bCoqkCHsdFaYR9k6e+B7roIdo1uwGW52D/pZWfpt21XjMLUIMkRV9CMm6+LdEla/Pl71tXi6+pxfyL6nuU1Ozs0yWjMP8KEoIOmTIZw36Bv1tEl4QuSWuglQSxBeMnfsVJNnpVZIkCB8VOqOej0R8CSUZvRGicme+P7zIO/wWo6K8X4dKa9fLoTKIX7uYLHu2tsHK0/QmAxy9l0HeZ/nFF/nB9FHOk1W1LbUPTuokCNHeWuC4nnoLZoVydy/y1pOa7hgoNs67vhxqWMKA+7gXAjprTqLF6cxdopuGfsscq6RxKvsqHUAHi+KiY0sO+B+tMVg5HLzcx4ZG5s/+5mTTLK/sXiGTDD84ut2UhjNKVt4MsH7cmn3vhNHYIEhd1fofXTvutmSgoGeY8Aa93eXXR024n5cxLKKjDrLF88u85rwGLnwWiIxTKiiSkvZXgzu8dOfnChm1LYdZO20NDQsVhDZgqPRo5yH7J69YxALRyfLJPfnvd79c5yeLhiNKdiS3RINZhxRBgg5urWklJNhGg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ge0EGUbFtHaP+bmuni2TVrqhaAWpB0HnODTluTViTlHMC3pHdSvASJd+OgF5?=
 =?us-ascii?Q?ZAkXmA99GjQqzzLHw3VJNgVVbl8TF2Qo0qqyq2hmcC0xeaHO3+tirGNgV0MJ?=
 =?us-ascii?Q?S175Ew+XIMp8jS7iYGLXK9HEQTodNcXxNLLubbPGQJgRuvAoNuqGlq2y9D8I?=
 =?us-ascii?Q?f84khepqZpGp2zdryxsShXqNz4MazkFWSAiOWPY65Wy7zRR0z2xgaBm22RCn?=
 =?us-ascii?Q?4zUjcSdulOE65qEMZCKVcStXqTSGnCLuiG6FKjQHeNEgqhhCMwdNSr8X6C5F?=
 =?us-ascii?Q?5e7AOYvFiOCXsobn1P80ZXC4Q7zZi5HfaZtvMJSwKLvqwo1PlMgqOIVnzyD/?=
 =?us-ascii?Q?5rFVFj9Uqz+mPIQaS2QwCV0dgfQ+GqVLKO8s0XxDXaxUncNJoxijbK7ilBJ0?=
 =?us-ascii?Q?Kot73qP7SPUWoAt/zmUe7cAxw4f+WLGkbDitn+BahhvH/C7xqkvvJh1FsC5Q?=
 =?us-ascii?Q?+tY0dmWVWjhGstOVFJmrToT8RBjhZra2msNoPnGblBmG5Tfs8wZB+OaOLpYq?=
 =?us-ascii?Q?sD/9Kn/NPYyCCiJ5iTdwFL6d+Pfj3hsQTNVLZSg6TGqUvZ1R3wLQvi8VSFar?=
 =?us-ascii?Q?JFxhwDDIHATKLA1JR7vE9hQCJsAsS4wzrHnq1cmnVcAWxRNT80P78A2ITkFl?=
 =?us-ascii?Q?dnYZyyKvJDHfAbL8I2yrgIf7QGsG7HVvY6PmHsLR2Kw+LIMAs/tUqwsWcmWP?=
 =?us-ascii?Q?YoMHIuOxuuhuplGtwww2z0rQ5PYLOu6Vip6lTEXXIaSIYdgIHR3NuUyXdyM2?=
 =?us-ascii?Q?05bbnjnZYbSGXVTlDwHCH8ICgDMfbxwaMPwdr1HWgDFMTVPqAdqJzrqoTi9Z?=
 =?us-ascii?Q?ebL2/7+aZZAO/LPQgHO1GUTtBg0INJfDYLwTMhqo01mLMxd+dDvb6LeWf+C0?=
 =?us-ascii?Q?ZGCp3yOHBWStaRbF95/vUU5nR7sZV40j39qb+qenjGZqH/IJ0yaikKg273UZ?=
 =?us-ascii?Q?uJpcsuvMpLNyFIWfKwr70i85ZIjgOSnMCNZROoC6SvKDdGVJzdzLDTG4iqFL?=
 =?us-ascii?Q?bIe+e2fPVrS4cXiUBEvXWtowffmyDQbE5S+gUdQu7Q76by8BaVIv19xS3Cb7?=
 =?us-ascii?Q?lQO7PHJeX7KAZNsehSwyFfP8oDie2ULGzfJukKOKhMgIA0cbOYLz7TLWHyd4?=
 =?us-ascii?Q?xCYfCfhJkNH27IQYIjwIEhmz1So60vIyaI3eqlL+9DRvJHgrw/PZFyAdgEuX?=
 =?us-ascii?Q?dZPxa8xFRDEldf5gTMUNDW4MhVzsuJwI039MLF1lfXs3tg7NnTms5Cab6ihj?=
 =?us-ascii?Q?/ZO9zAdaUaI1vgHUH/gJyk8BBDtT7ZHY21jL7dnAb0cgmO7m7rDbr3Cj8uiz?=
 =?us-ascii?Q?5AeZ19rpTyWFY79VN69FUNfrU6mcqq3/+tcvnJy9jjw58MFhQQx67hDyqOS2?=
 =?us-ascii?Q?0vj5lOm7RFs40bbSdJqJKqsWjZgItCsNJWtvfuWWKX/iToa1DgKO699rfO8B?=
 =?us-ascii?Q?K6aPLQqSmHPa39RfgJsvI+AOXJfJZOCJqpnksXvixdlpriqdv/Q6Qh5REpci?=
 =?us-ascii?Q?ohZ+/wWUVhe6kKFnq9/ZXqN1rbGUw22T1p1QfGyaRa2DbxdgVqivfEPMeWFW?=
 =?us-ascii?Q?Y6fr6QPfA4a4CumzkDJUS3KK2o0/u2Ym0dQuPdW0CxhESgWuKk8o32NXel5u?=
 =?us-ascii?Q?m5L21Eh8EgnJdZIdMbCQzXlkg/k3GkrvbdA+J/iKJLKwWV30bTdt8WGEH0cL?=
 =?us-ascii?Q?zBHcwPzGLVzevmeMoqnqdeWgflQmlbvPb7UCawAoMzj4p30dPLHoquCKgNGo?=
 =?us-ascii?Q?KzOzMSNgLDiHvpVtE2Tp4i5N4WfcEdWn+TqXeebHm3cqRFaiwX5C?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2a71fc-9819-4d8b-0560-08dea5fb1247
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:24:49.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnoK+X51hrju2DfhrSIAkFn0v41Pr6Yg2XFnmd1sguDGaVBH5TEGe82flc6XtHFWup0qQEkVNLtbcflgoUuWc1FswDcwFCe7YmASUp6B+o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 14:25:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19416

Hi Dawid,

On 4/29/26 4:11 PM, Dawid Bijak wrote:
> Hi,
>=20
> On Tue, Apr 28, 2026 at 09:42:28PM +0100, Richard Purdie wrote:
>> On Mon, 2026-04-27 at 20:14 +0200, Dawid Bijak via lists.openembedded.or=
g wrote:
>>> Hi Quentin,
>>> Thanks for your response.
>>> I'm afraid I don't quite follow your point about PACKAGECONFIG.contains=
.
>>> I'm not sure what you're referring to exactly.
>>> But, as far as I can tell, the inherit statement works fine with inline=
 python expressions.
>>> I think, it evaluates the expression in place, much like :=3D would.
>>>
>>> For example, on current master I tried the following:
>>>  =C2=A0COND =3D ""
>>>  =C2=A0COND:append =3D " x"
>>>  =C2=A0inherit ${@bb.utils.contains('COND', 'x', 'foo', 'bar', d)}
>>> This inherits foo.
>>>
>>> However, if I move the :append below the inherit directive:
>>>  =C2=A0COND =3D ""
>>>  =C2=A0inherit ${@bb.utils.contains('COND', 'x', 'foo', 'bar', d)}
>>>  =C2=A0COND:append =3D " x"
>>> it inherits bar.
>>
>> It works, as long as you are sure that COND won't be changed after the
>> inherit. When mutliple files altering the variables are involved, that
>> is often unclear. I think the doc's intent is therefore to recommend
>> anything with variable accesses is therefore deferred, unless the user
>> is sure they know what they're doing.
>=20
> Richard, thanks for chiming in. Your explanation reassures me that my und=
erstanding
> of inherit_defer was correct.
>=20
> In summary, I believe the 3 issues with the current documentation that I =
identified
> in the cover letter are still valid, and my patch still applies.
>=20

1) The sentence should only apply to the inherit statement, and not=20
inherit_defer as that's the point of inherit_defer. So this is fine.

2) NACK. We're deliberately not documenting footguns. You can provide an=20
example if you really want to in the inherit section, and add a big fat=20
warning after it that it'll break in some scenario so you really=20
shouldn't do that and instead use inherit_defer.

3) This is fine, thanks for the fix.

I would suggest to make three separate commits, with 2) last, that way=20
we can pick 1) and 3) (which will become 1) and 2)) and argue on 2)=20
(which will become 3)) without hindering merging of the other commits.

Cheers,
Quentin

