Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4360C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 13:49:27 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17006.1787579365669111539
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 06:49:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=ZYiYhiH/;
 spf=pass (domain: cherry.de, ip: 52.101.72.31, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfB+bWXBoo/Kmyz7PzTnVtlCbyvZugCPRIRvbFES3G+0SVerUCFdJ9xCM5k1tITX/BBSu7PchGf01ISKZz7GYAKfjontMd6h9iNSqGdTDPk3zdm5bpYs1CbVF3iMf0u3hAfbdscwr2hicu6C708VwJtuC66V7mR/aqxmVOtbv/8MLWY7agr+ZajJdijxlrh22C+afj99PLALcAEVuwYNDARPfdkxGuP2+J+6N9nDVpT6EC8kv+7f6tFHBt4RcBMzKJ07RDwt2Fy+bryl1FCP8jk0yookQGvlYkDNQYAqZ2H523ROz0JtTX88K3i70UOzuVtLJOLka2PiSGNuTZaSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yU48sA4ARCwia0MTgOpja/Tj4oPLLuSfG9jYEJsU/Bw=;
 b=nVdtvUXQtXqkKfB/bZwP/smZ46e/g2+iVJZQwgru0Tm1hMYvVVuBja9nHBfOoVSGcou7Yn+d6scSISjOHnw4BFUjCUIzhTWq2WJqOK1N4jtpjiEY9pETZknIJ11+LgAtMQx2qMF+axI1FotVjDe//5fqoflV0RaG8A0+Joq5NpI1TUjKvS21UUzBA8kbQimQ5FwfSxgQYQdvM93kHa+cGN3tqSjbWtdoNtL5/vqL51jJXGMJ0Mr6y+8QQAmQaRDCi3p6Jb9Xod3/GeH3DPQjtit435NT6whtyUdCezvpeE7kauqVz5ldYHoxCJFF88nSRFOMlqhOXn68pR1sZeup2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yU48sA4ARCwia0MTgOpja/Tj4oPLLuSfG9jYEJsU/Bw=;
 b=ZYiYhiH/gJGkzaz8d9yjQn8JTJVp5GQtH8K6SPkOf0VVHfM9BoiQ2eZx9A6Z+9rD5/9eZekrYs/dJugqOTOVOPX8R38oP+l5/gnDRsggazjkKKZrcDUCnXKzZ1qstbZUyyr6W2Qcof3pJGftFp8OLbZt2nTu6SJ1xtw4mSNF+Sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:49:20 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:49:20 +0000
Message-ID: <47fe0410-84b3-4d5a-a427-fa12b3dec05b@cherry.de>
Date: Mon, 24 Aug 2026 15:49:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-user-manual-ref-variables:
 document PREFERRED_RPROVIDER
To: Yann Dirson <yann.dirson@vates.tech>, bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org
References: <1787566358.8631fc262581453bbf619ec5b2062170.1a033420133000c4f3@vates.tech>
 <ac19f181-f193-4a84-8ec3-94a374c9ee56@cherry.de>
 <1787578817.8631fc262581453bbf619ec5b2062170.1a034001c5f000c4f3@vates.tech>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1787578817.8631fc262581453bbf619ec5b2062170.1a034001c5f000c4f3@vates.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0016.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:354::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB8PR04MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: a650c083-322b-4abc-0892-08df01e67f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	H/HGOae1hFLPxFfVJRlBXulBuOfsMp5WZzPD7cSsXwbLp+bxXGdHLrkkSE5No0SW53PgizufkNMAMBDQRC/kaZaYZqjHcLr27+1bgUZTlyiu5NcM4kf35KIxYFo6tncV/i4JHnvMJJIaMno1Edhw+/9DrZPv6+1zq29zzijYUo25BkVKSuj5W9xbdPxy/ir0noOIzMXudGAAfbHGhf4+7V3AQNketwPIceMStNZkeEa426rXG57fG4sa3RBJB6hKLL5bKrX7Fja4VNy1IHxzRrUBb132JZfm0nKYKaiZnCeRpS6UE36YGVbj6tOaSW/1MRVJzbOX5HNvrc4ivriFHT6AVGTv5qx/h5VMs0Yu8OIvF+DYbAr+G4GwZKQ9mcWytd+I9HYq+Kl8YFAOVDf0XQLVI+Y9koQB1ivIE1oYgcg9T9ugCCAnj3XRxcvyCHW0JJ726D7+bWpLImcbZvr5kCjsGK6YtUn+OZ/wMj2jvZKh59YDv61WEBAxfWQrFFjBMyOR0eM+WaVkpD9BOamw3GivXQJitbNZekPv+I2/hds0RXnkNPtMhxFW0P/5WF4nhLI/XLN9WVipPovC5qHoBuNdv5KTgDLqBnWk1H/QvLdQj+gMmxtQxziDWN512sNmy94aX5jU6KIOiyIct4nlvRoY/JoGjkRGnZNDn8kv5fM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KmqoRbvNXur4zsFfwLmjfE5hTGRI+UGkNkyLPh7KsYrIQ7VrHmZBvIb6OEZr?=
 =?us-ascii?Q?o0OECAbTiruTMlLsKk3Co7ch0mavvY6lFjCDKDAgLxJ80jy+YdzwwSzL47sW?=
 =?us-ascii?Q?l50qhcXv4qlr6UZis68V8+tdihYSAxCJ6oFuXyBNy/h+hpcwORKxIN+IduCg?=
 =?us-ascii?Q?Nh6QLqH45c2t4NIRyYbkz3JDs1y2sdSPbDRL3sra3f8rFPmdCq9kXL6ZfxDU?=
 =?us-ascii?Q?lCTB5BKwhL0eURzh+SSdpEWRmnWkab1qeHcZJGLUQObmvR0R8WJMLb6BdvNg?=
 =?us-ascii?Q?7M1NjV1ioXJ/7ysPqJC0iQX7iJRESUN3i3ur8PMXTShkdx8Upbko+ZldV7C8?=
 =?us-ascii?Q?tYhWoHKVQPA1JGAvtAkX9c6+DItgkjxnu1dAHpUvT6NsTyn/rhSXYb9H+uJ9?=
 =?us-ascii?Q?c6P01W8xBYNbbwJ4FetPI71YuCjViTVT9qoUbq+VYw6CvxggERTz8m4WL64J?=
 =?us-ascii?Q?DZZUE3aoBb1K9uGExxmxGwqv32z0ZNp6RQv63GxTROp/G81X3ZdXCiRDumGh?=
 =?us-ascii?Q?ypb9YGtjrcO5z5mStVcc5VWTO6jVpcxrmL/UgjoijK3cboHEFk3eb+Ls448m?=
 =?us-ascii?Q?JevGRaYdWkAx8R/HRRUSA2r1m6mpKGIgEHkLdE0Es9yqHOSS8zGUJIln0F/w?=
 =?us-ascii?Q?444PBJcXq/+jp6aMOvl0DPLrGv6qCFU75lbjiOc/a1GhLQ1Z/6AP0ntymzbt?=
 =?us-ascii?Q?9cit8DflAANNhsP4YzkaInbzAvp6qXHeV3+Hr4xMqVX8xEP4KNS3lOS8suow?=
 =?us-ascii?Q?gvV8H0aGPznusppH1Wus990btg/VpyyOrmMib8e4YS2AaHx414ARWgUuo2HO?=
 =?us-ascii?Q?jzfqTZZedWGXk1Zb031IdfUSFVEJ6gIsTBdBkqCcPv6h/AwmkC+fSYOuQ3Fn?=
 =?us-ascii?Q?+tffkDUkldOGbZuy0909IL9IbrQhhmy6f0fGLcmdChhSxac81kszVtXmlNOC?=
 =?us-ascii?Q?K96BUImjD0OzCqPgfqF3dKEndxD4e9OQcTnz1EU+XjbkbO985Ndatfb+kGWL?=
 =?us-ascii?Q?3oxR0jDp/paG81M653KFqo6uyHReUyzgy4nfrTO6MQyhGB9+0/AbpKNXhGp3?=
 =?us-ascii?Q?dQC48f9T1SHZKGsiF00V5pMuYrfuvkfZHjDUpeS3EhFRxE+bGjY4xuxt40bf?=
 =?us-ascii?Q?nNSe/EaeJuWmup5k7UQj+LZRboRPZ6NPSXw9L/YyPaf0Llpp+6LfTJ+cEPll?=
 =?us-ascii?Q?QLRlOwcJDBzwsB6WjETzV2sG9U/lrROkxsnE5tJhhZoNi28QG78KI9TZy3fL?=
 =?us-ascii?Q?exE50eck0PdyWWSd9B6tME7EX9nBJVuo7LDzxPvNkYtSAbabme2Q0LfF3lKr?=
 =?us-ascii?Q?Rag+Kp6vzuOOSrg5gJ29SClHowvdP/I4L7DvpC36dMWPNLpmaSysMfhd8iPO?=
 =?us-ascii?Q?DvkZhxIPmrcTUmIM34NM5oEiGyj/hJl2GBs23Qqop0glbxaTHyBbMdFEI3y0?=
 =?us-ascii?Q?yTdw8yCUKfi4XKxMHrd4bx5IC8NspuUsaNa2lDIuj4IfRpMimnnEzsim1uYm?=
 =?us-ascii?Q?7Xovsf0q0SP0m32yzmnq/1A9A5yre6AIsC/76PwIgMB3inKrt+z/Mcknr4iI?=
 =?us-ascii?Q?W3ZImk1/0Y/RS2TJE27MpFWaMk8QlBUQYgDRR0o3bGDZzcp0J4dZA3xg1dTL?=
 =?us-ascii?Q?d05N6MCxAHG0dAspBAauhHyP8VG7fllnsS90W0OiMD9Kf+pFW5eabGhx8/L9?=
 =?us-ascii?Q?USVCDjlgLlNlVCUsK4Lnt/9drc43ZQLcMkBl7wEiJOUiuENj7XAfEEZCSkeV?=
 =?us-ascii?Q?3K1U4ggxWrIZAQEGNPjfDeI2wHu3mEm5Uvme414YwPJUbZKDGWRveVDbYtDS?=
X-MS-Exchange-AntiSpam-MessageData-1: Tqo6oaWFkRyMiFlpY84dH4zi5J0NrDlru9U=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a650c083-322b-4abc-0892-08df01e67f8f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:49:20.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jc0iecmKiscylEO2b9jXorYrI2SSB7M/Q62WmnPbd9nEYI6FdYdEUt3jsE9CfI2ehn4ij31wfWxChOHxIyBs0friVFjh+hIw/UikOkcTGC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 13:49:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20027



On 8/24/26 3:40 PM, Yann Dirson wrote:
>=20
>=20
> On 8/24/26 12:26 PM, Quentin Schulz wrote:
>> Hi Yann,
>>
>> On 8/24/26 12:12 PM, Yann Dirson via lists.openembedded.org wrote:
>>> [You don't often get email from
>>> yann.dirson=3Dvates.tech@lists.openembedded.org. Learn why this is
>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
>>> ---
>>>  =C2=A0 .../bitbake-user-manual-ref-variables.rst=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +=
++++++++
>>>  =C2=A0 1 file changed, 9 insertions(+)
>>>
>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-
>>> variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-
>>> variables.rst
>>> index 5395ce5e3..2756fc0c4 100644
>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>>> @@ -1558,6 +1558,15 @@ overview of their function and contents.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREFERRED=
_PROVIDER_xxx =3D "yyy"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREFERRED=
_PROVIDER_aaa =3D "bbb"
>>>
>>> +=C2=A0=C2=A0 :term:`PREFERRED_RPROVIDER` Determines which recipe shoul=
d be given
>>
>> Please be consistent with the rest of the
>> file. :term:`PREFERRED_RPROVIDER` should be on its own on the first line=
.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 preference when multiple packages rprov=
ide the same item. Beware
>>
>> rprovide is not an English term so all readers won't necessarily know
>> what this means. I can suggest:
>>
>> """
>> Determines which *recipe* generating a package runtime-providing
>> (:term:`RPROVIDES`) the same item as other packages should be given
>> preference. Some examples::
>> [...]
>=20
> Good points.
>=20
>>
>> """
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this should contain the name of the *re=
cipe* producing the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 package that rprovides the item, not th=
at of the package. Some
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples::
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREFERRED_RPROVIDER_i=
nitd-functions ?=3D "initscripts"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREFERRED_RPROVIDER_v=
irtual-libegl-icd ?=3D "mesa"
>>
>> Are you sure this is still valid? I don't see an RPROVIDES for virtual-
>> libegl-icd so maybe this is not doing anything?
>=20
> Those examples are literally taken from oe-core's
> meta/conf/distro/include/default-providers.inc.  Digging a bit, they

Doesn't mean that it's still correct. It's not unusual to discover some=20
leftovers of past migration or deletion while writing/updating the docs :)

> seem to be dynamically-generated values from an anonymous python block
> in ./meta/recipes-graphics/mesa/mesa.inc
>=20

Indeed, I had missed that, thanks for the pointer.

I think it'd be nice to then write in plain English what at least one of=20
the above line does. The easiest example would be the initscripts one as=20
we've a simple RPROVIDES counterpart in OE-Core.

Cheers,
Quentin

