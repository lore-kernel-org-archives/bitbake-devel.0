Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7422E7718B
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 15:11:19 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.131])
 by mx.groups.io with SMTP id smtpd.web11.9561.1735830674715488457
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 07:11:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=OFiYRZVK;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.131, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3WNtaqO95GiNbfah5yWPFX6GknQRzLo0q/EvI8MWPnc0dtlvem6ZJ05AZLxgMQdMQlDCmCtKh+k5EndAnoG3guWZxTUeWS64TTLyyrX0oy1wpHT3n93x9SSm+GCyPL2maxF5ZtLxraUeWtRPAyjYkDHva/rPq9OY3SNz/dMl/AdgkLZcdetjLaUU9UVgs2lF2GDAkgeaQVUKz0I4URUqblfjdKwbuNvCgiJlzqi5ukZKG6LYnoqlRhWRQGEEfpXkGESCtZQfoBQcmYs02OpONRtC6ZgcdA9EznuhASQnr89KZWpCP6nK69/KSeop76HWMYcvvVLxrbAm+CSeghB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO0lLONX/GSbcm9ZGndpX3H9kC9l3jrGVfJ+9UIueQ4=;
 b=dmwcxRB3Kad6m1kl7mywkjVDVikt7WcYbN/cf2eHCoj1CSk644V1hcp1EnfUFuwM8+piOfjTC+DqAliMJFCbklVkCi1LuQRpmEbpA0NBIX3R+GqWUvEDuuf1e3DKRCOZ+SLlt2/UcfPwcRSG1YaFV7oBgar/K7kM91d2u5AjtA7lpOfHQyWZhHxz7AplIdZMY2/pWg4zxxAskaDbgCFoaB3MM25/grhsZe+qU09DTlPvP5LDNNxLc3TlAxGKs1AuLQvWOorEonSVPk5Fuulj44KWLPvQz/RCJUOo6vlMm07V1nR2gHwpRLOYGl3wMvFZvpEhvBzP5abJt8+2UPRJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO0lLONX/GSbcm9ZGndpX3H9kC9l3jrGVfJ+9UIueQ4=;
 b=OFiYRZVKSbidlR0jqDPly59cDj9cTX4EBjzH3Qr4tgmjMUmX75UzW6Bv46wk9PGP/rb5R/bipKann9Rb4wy4UqndlvwmwmV5FYz5l6AmsIAAYXukPu0Ra0azohv1xYjNuWpkUouhnpxVgpx5/64lKzS6df/n3yHGAvAnWuwb/DS2bm2gRr4GWFYosSqlFqG8Dcqpm+2VptaOoVQoXMKG4PWVDsPt/ZrEQrKu7zQMQydrR7b0X8nt/C7d0F/xlRhvl7VrsEct6GV3SkHEBy8s4DgSWnWN+dhH9XqwPT5aVQJFsYapRx8RWMETHiTFe6i0E29KCp/GMtjnn2UPxV73Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DB9PR08MB7867.eurprd08.prod.outlook.com (2603:10a6:10:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 15:11:07 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 15:11:06 +0000
Message-ID: <cc93b61e-9295-4a66-a3e3-2e072c315d73@weidmueller.com>
Date: Thu, 2 Jan 2025 16:11:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <347682f4-d1ce-4f8b-9665-3a3490235d1e@weidmueller.com>
 <7fcc6a2d93e0535c8c79c60ae302ca92e322fd4a.camel@linuxfoundation.org>
 <f5aaf9dc-6c1e-44c1-afce-33c6beac0290@weidmueller.com>
 <2ef6ab29f58822233bd2599b00d7b444852e828c.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <2ef6ab29f58822233bd2599b00d7b444852e828c.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DB9PR08MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: c49314ee-135a-4b8b-76b0-08dd2b3fae79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?j7jTBf+76fq8JtCT+v8tsm9iluj5HQq23W7cBpMXMr4pVWlWafpHQxxjrvO6?=
 =?us-ascii?Q?IVuOE4wawlvFylOksmrmZI9mEhRVsWLaLph9eSyPY7AMaJjZo9cF2yfSPQ8Y?=
 =?us-ascii?Q?2QuxbyHISB9PnVoJLkHgp+7s4t2rOXU/jtgxWASakGgzxr8PBS36lmtSf/vA?=
 =?us-ascii?Q?0h0fulzTuCMAStpssr07h+LU8x1lSKudMr5APir/iWZp9KHt3PYD6FyvMLPJ?=
 =?us-ascii?Q?wzTzuautIYNCyKjRnLIh2wIJS6LM0cKANgNAT+04JwDDwnfq+IFRL9mgqnnz?=
 =?us-ascii?Q?pdlhIjsTGNKIJ8haB+KBYdJ9UKgfOQdeIat2w37hnilfUf9Pn+clIY4SKURH?=
 =?us-ascii?Q?ZNx7V0Qodw5tsbJo1AjyodfvuhyRTqtlH8A9S0yTwCRV6nxyMKBzusFT81r5?=
 =?us-ascii?Q?WtiMXgd23vV70IuxvQBumc2Uj1lV9mEyrRsqLZWMa3boRmPgFQyopIVihWeT?=
 =?us-ascii?Q?f12uQdUqx1cibFHlYbpNgWBmEKZqp8mlvS6pEf4ppbwK+EGo9grIX+L80bsg?=
 =?us-ascii?Q?pFYWScKn4CfWR7LsxuosRGgGW2kPtNfcOOM09VQFQMWoVG4p+aPq0QBqdMcz?=
 =?us-ascii?Q?IrIkJmw42OaWbxG+/n2shZASk+3xEZNvXJbLBgt1jzDvIaVaZmd/0RRd/pKY?=
 =?us-ascii?Q?GROUrKmqBRscgTkjyNkG1aEBUjMS0R/HP++Ofqv4O/rsv7MQuf0IXdkIT0Ng?=
 =?us-ascii?Q?MPmzdlEBojkmhAq/ElxaZYNwxrsvygbSp7ZN7NiMMJx2Z41QhZHiQ5ly/1hY?=
 =?us-ascii?Q?IdB4yQOxwUXBxzHGsB0FYd/1yTHPA1BP7YbcWD4QJCvsBO+doFHU7Xcqqz8I?=
 =?us-ascii?Q?i3cXhaps1sHJ50PG5+CLwOiR1GEDTqpPWrgRAxo5WbXRM/FE8yzuQFKS40LM?=
 =?us-ascii?Q?KsQ8yGaEIa2m26V5DVLG8HCxePY4icClpXYDOf5vR8Hu4Xi5IYvGQj+NIXJG?=
 =?us-ascii?Q?A33EKc8vAmo3CNvktxL+KJ4iH8XL5lBDNGsvIONGUpMBHAkBPxQnPNqYNdFR?=
 =?us-ascii?Q?1pCK4/MwLvjQ1qGIEDB1KSEjfqHn073jzrdci74DSMEMhG6McZCVAVxkRvxr?=
 =?us-ascii?Q?lwtlT36S2eSnghPDyAIAWyGV5gkA65yhIzEEAZmx78di3rGCIrmMcLTBcfBT?=
 =?us-ascii?Q?9WKoM15qwebpEW50msBu2iqWticY244MXVf94Dk3499oYLb2xZ1JFEWOBCyu?=
 =?us-ascii?Q?TKU17AIhsb18545DWqoSsasXFrGy09gr0In+v3VnsKeyHuQ5EkoH0SjncAoA?=
 =?us-ascii?Q?IWdulSA9a43du2nvRYSP8dbxkY3V++bvR5Ne+RfPNuXo7kOkAXIHxskYyVJB?=
 =?us-ascii?Q?VFgK7seT7SYB9gqalcnbM9bNEijEfP2eMW3mLmkwsJQMzv/cw2HYg8bnA+Tu?=
 =?us-ascii?Q?xRgUT3EGWuUiRlVYuwR5DFw1LZFz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V8FlZkRzIRPaSJTYe73EKTEznWX7zVDAxyHOWdVQtcA1qDrlaE4y6NTwSBv1?=
 =?us-ascii?Q?EAg9YVy2i/+34+nK2JgD3OSdoPIZe9mBggw6F5P2QC5cBh977CX2ZO+O6u81?=
 =?us-ascii?Q?/Fw2tTy+QUwwDF+VBzLH5EnozDI7oW9oUePxColIUxSD7bjwHazGRVP83q+M?=
 =?us-ascii?Q?v9ay1OZJvb9qgXcqLZROclhV9irp2GcpXVDYXsvMcoavhKmeCbi50htz43+P?=
 =?us-ascii?Q?YvXX4kdoIR2duXn2yBWewxGoS+e5fDPeC5v00LEM472xPyl9XX9HXQ/munCM?=
 =?us-ascii?Q?ScGYbPdvNrZLsxxKO8hZ5mI0LOyU19ec343OzpGyJ81Cfq2PSFNlxkA7ubst?=
 =?us-ascii?Q?hzIZjzB4KcCGDl2b1LTLDuJWsR/eoO4cksg3/YsNLimv2a0qhf5/GwgBqh2j?=
 =?us-ascii?Q?M5GHqXX4C14gfsdO4zrPQ3e3nIBnxAOpYVlYSYZxgejBGf3P3SI47Fj+EEhS?=
 =?us-ascii?Q?pA7KfUYrWeW/Ke494rUVKHHrI19nTMKq1oEkEJO5XDBBmXE0Ue4jT/NjrTq6?=
 =?us-ascii?Q?qCXxTycAm8KV+nkK/6YdopRn4ISqBG6ypmBsy+Ok/QOPgEviKsA+VqG8BqsK?=
 =?us-ascii?Q?gaUO+S/Az2mqELWgeVFfNVFzK/jv5RFEONlsi2YBhFYzlG9e4KmMM/K8T/23?=
 =?us-ascii?Q?0lkyBgQXbrgVBEYeR5l+LDkuVqBb8/DA3ayj1g66JFNnsj/bWlSm4ziPk8Vl?=
 =?us-ascii?Q?w/osJelOtanupm5G7UcRhfjcB5YDpLn3KnvukZVWtodKanz5G1lLLSxH7IUU?=
 =?us-ascii?Q?CwfH2uBlH0sdrZ7yUgu7KKzBKejYwVb2zmGWthhFOl2IvE43R0ZkjlT8FrE7?=
 =?us-ascii?Q?tJFzBlmXpD2wuEKqI1zrtGQ1kYRpduQf7juw1FV6vDP/ucdyxHwvyi3GVpl3?=
 =?us-ascii?Q?UW4uBfvkQYNp4sdBTLwj07/XRIYgYM0z75ni8DbSSbycKRyHPJ2DkMSesz3p?=
 =?us-ascii?Q?xcrZTOMSy6GW7yXuLzG0wXASzX8RSk4IXKj6eA52rw0gXcfjnUgCCH63uuJI?=
 =?us-ascii?Q?zL12dHkmWS9iQcMNL5RzyOQusvL38tFFfNx7fsxUbG/3QC7wl5O9Shgsq62F?=
 =?us-ascii?Q?bk82v6gfVNpFo8x3ktvw2CcswfTJRqu2OjdUpxqSTORTIThmYc+L2DJUkJCp?=
 =?us-ascii?Q?a5hH3MEnEYibItxMxqH4+RT3gR8x7+Xuk+V1P5l67UgMDOZNW4+zBU4Iu6O9?=
 =?us-ascii?Q?Vk45YWcRwUunS5SH6wQpRDSCU7VMlmA0gs2Z3WePiy6jnB5f/zfgQ51K8OEp?=
 =?us-ascii?Q?sy1TjmtIrTnoroZT3tFBM1VfjM7ZpTrXrKnKUrzCPlKeF1TayvoDoHvwg0mr?=
 =?us-ascii?Q?dQzPmbiref/2mnBTomdcmErnJ786pY+/U06/1rVhwN05a7GW0jJNmlshYVSr?=
 =?us-ascii?Q?Zu3PYI6xj4wchDSjSqcVOe2GewN5SYGbHumvFCurmpf3GIOq01MXYeHl6Gpk?=
 =?us-ascii?Q?lU1tLHx9u7Q107QP3crw9WKiJ57PmDflH8yq6OmMPSLr1ayf1BLhcvix0j3P?=
 =?us-ascii?Q?L4+H7BZT8M3Dhzb0ycXNbQYu+kdK8AdQUlFJBAl5DjfOBQ1qDpMvHWVSFR0Q?=
 =?us-ascii?Q?N1ip0ijfccOo46l0A4i27ZnWB/oa+l473KY5qaD5UiAK7HkBpu4Vx+fNYvdH?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49314ee-135a-4b8b-76b0-08dd2b3fae79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 15:11:06.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B1E1x3KYobNCPpB6sCOlONrNyhk/hXYi4n2vbkAjwhaovGWFgmoRqq+UrKdDFO4zDtYxQn00H4CAt8807LOjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7867
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 15:11:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16962

Am 02.01.2025 um 15:07 schrieb Richard Purdie:
> On Thu, 2025-01-02 at 14:50 +0100, Stefan Herbrechtsmeier wrote:
>>> I'm trying to aid the review process by asking
>>> those questions, it will just take longer if I have to work this
>>> out
>>> myself.
>>>  =20
>> Maybe we are able to discuss some design decision without code to
>> simplify the review:
>>
>>  =C2=A0The dependency fetcher need to know the path of the dependency
>> specification file. In case of the local fetcher the path is the uri.
>> In case of the git fetcher the path depends on the subdir and
>> destsuffix parameter. In case of the wget the path is unknown. This
>> series requires the parameters=C2=A0striplevel=3D1 and subdir=3D${BP} to=
 work.
>> Additionally it doesn't support specification files inside sub
>> directories. Therefore I plan to add a srcdir parameter. Should this
>> parameter be mandatory for the wget fetcher or should the fetcher use
>> the PN or S variable to determine a default value?
> do_fetch never touches ${S}, it would only touch ${DL_DIR}. For that
> reason, ${S} is passed as a parameter to do_unpack and is only
> referenced at that time.

The do_unpack use the ${UNPACKDIR} and not the ${S}. The ${S} points to=20
the main folder of the source and in most cases contains the main folder=20
of the archive.

> wget shouldn't need more information to have a default it already has
> in the current code so something isn't adding up.

The additional information are needed by the dependency resolution not=20
the wget. The dependency resolution need to temporary unpack the archive=20
to read the dependency specification file inside the archive.

> I'm still not sure why you'd need both a subdir and srcdir but I think
> I need to think about this more deeply, FWIW I'm technically still on
> vacation.

The subdir is used to place the archive content inside an arbitrary=20
folder. This is only needed, if you need to place one source into an=20
other source. The srcdir is needed to know the path of the specification=20
file inside the archive. The main folder inside an archive is archive=20
specific. Therefore the S variable uses a common default=20
(${WORKDIR}/${BP}) and it is common to override the variable because the=20
archive uses an other folder name. Additionally the specification file=20
could be located inside a sub folder of the archive.

librsvg:
SRC_URI =3D=20
"cargolock+${GNOME_MIRROR}/${GNOMEBN}/${@gnome_verdir("${PV}")}/${GNOMEBN}-=
${PV}.tar.${GNOME_COMPRESS_TYPE};name=3Darchive;srcdir=3D${BP}"
--> librsvg-2.58.2/Cargo.lock

python3-bcrypt:
SRC_URI =3D=20
"cargolock+${@pypi_src_uri(d)};srcdir=3D${PYPI_PACKAGE}-${PV}/${CARGO_SRC_D=
IR}"
S =3D "${WORKDIR}/${PYPI_PACKAGE}-${PV}"
CARGO_SRC_DIR =3D "src/_bcrypt"
--> bcrypt-4.2.1/src/_bcrypt/Cargo.lock


Maybe the srcdir should be named specdir. Or specsuffix if its default=20
value is ${BN}.


