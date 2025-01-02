Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943CCE77188
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 10:51:18 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.103])
 by mx.groups.io with SMTP id smtpd.web10.6173.1735815075617878954
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 02:51:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=kYFVZRVt;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.103, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7TIAjstZectVXAVjbOa8ENJH+qLS47Bjke1gd0SylCbcZ5CrXUiAhXfKv8j/QCOXznsfdOfSW6mHke4kM0xCSCiP4DlPcWe3jPTLI9nxndWovM0CdP7zdEPB+Vx3c/YM1WD5EzdoZv97DO0WzHio+4RiGAAyNtmVay8XUXqARrQvt6jr/yVqM0HSvZmqXfRgki0eONXcObfNuRHYPAGj8Uz/xDEHz8b/O3hrd/DfpRab4+1IqlxlaWfdQaR3sC6pfYu+9w3To76J5cDwYAVkXaNJUqOHLdccE5Ntiv7xBG5lwD/a2BOdo844RPgDCBHadVdwcOW7VYUFiZ8Qo4HVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8lHmT3gsSh+C2VwtNSNT5iJWSml7d6t8YeWkQIOwK4=;
 b=IoqrmAxo88W3P2MhoK06WVzueW97u1UVlWx+Cp5EUR7EhwaXaxI7VDdFehUaz0hyv75UMozAggwiMqe2nYi3PTmMrcnuHSp/SncQ4kWA/Di/QLOorTD/lhCa9EqeZoBtZQBDtb7Cedz0VpmvxgA6jypM4zmGFV+j3aa6n5q/OYKqaPkB30sqZ6hYASqIAmCGCWjLMWrZSfvPMz1DLeNkGJPR/cBD8vzI7aG8sB7ChGg/awmToIyVN66gTawoo0uAoTAGgQNRQorf/peZARa/wzB5KI9miT9M/mI9TuuNttJ1svwe4Yb4CZwDjg89FEtf4Vy/dJt4TqcHi63UXSx8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8lHmT3gsSh+C2VwtNSNT5iJWSml7d6t8YeWkQIOwK4=;
 b=kYFVZRVtfqeTbsKVFgr9EndrtaIuXLu0wlstRc1vp+65pg8UAJ3LTS9qrrWV31jLj/19q28OrVpK43iMlNdLb0GgEUvEdPvHJhmY+Nymc8rt+5Sfy/QfYdZc6oi1+DKinB8UBEYtE0KyBEzMInYbJkT+3n+ZogrRrLT/JSiK3JhVX1ftApsWjcdlJXBlgtEz1Qx1xfi/6oDM1aaHGqZBIFt9wQYKSceRqgyItiDhKG8RqS88aBmi26j7Uo3ofWF3FPd2SxJ4CPoc1W9RCGHIirqmGL7rvpYLF4dEEqlwuw83rpVWyUVN+K+RCF1XD0V/FQostVvOYyif+hlunNHEnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by GV1PR08MB10807.eurprd08.prod.outlook.com (2603:10a6:150:161::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 10:51:05 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 10:51:03 +0000
Message-ID: <bb6ea76d-e2d6-4356-baa6-1a3082104d8c@weidmueller.com>
Date: Thu, 2 Jan 2025 11:51:02 +0100
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
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <7fcc6a2d93e0535c8c79c60ae302ca92e322fd4a.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|GV1PR08MB10807:EE_
X-MS-Office365-Filtering-Correlation-Id: 18124f6a-cb30-4ff4-14c3-08dd2b1b5a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9CU//ieD8aFK7TWBv0iHCMTrlZYbKAuL3Hy33COvu7V0UIy9z3cRIkyGkxvd?=
 =?us-ascii?Q?WopUSuyhs0aKwtj7yiSl/+yrKfB/3Marnu21JPNFZFGw2wM1D47djcgnGTqc?=
 =?us-ascii?Q?aS1i+i+9yqnJZQo0zEV3i7BfplsHTgb2HJLFqjQWdUonM+X1CTA3mL0vhvjv?=
 =?us-ascii?Q?+V1De8fovf+dVIaDee2DEepqotugFvyhUOnXSTfpNVm/wFWaEewudQ2OcA9r?=
 =?us-ascii?Q?UDMshaXU4YAP8Ecd3W1sBo07TfG8vXvqJmJAQ2A40i3LlbpijLt7dMck86B/?=
 =?us-ascii?Q?R63IP8HyyDo5rsWcOcqDQxbXs6kz7JRzaQ5UrEwOW563CJ78qeVV+3v9sb1o?=
 =?us-ascii?Q?umFFQzNOUacBr0prX35V1OI6xmDMFvg9HtM3g9voOXU2qarmBBppRbtgcZ3q?=
 =?us-ascii?Q?8TKeynQ8VhLyXZoGHHF46lsCgshQ6FgQVSDZpJQcRR84eR+JL1Aorb0Pm8ol?=
 =?us-ascii?Q?/iX3bNODOSWXisXhoOKvTLNzxoUJSsCxFjv+8NAI+tP1G7S+3Km2GhYY4bpH?=
 =?us-ascii?Q?gsivUaJpr2RRCM3Q0NtXQBOwXDsMtA1rlxMERtz3W60tD6uD8mPjP5D1+jAH?=
 =?us-ascii?Q?1AoF8augGuDQlvNiHL7qpeq3A7LK5parn3Kkp5QwMwms5ETVaTWh1YlxIqGf?=
 =?us-ascii?Q?3bspZ31pU58P0+U9WkIFuNe9gp3h/lK36sMjr+6+RDIjJAhGVS5K7SzJ+Vul?=
 =?us-ascii?Q?LuFsz6EuRK/mUCOdDrEuLGhd45QLztRvUcqwPM0y7m1zbpaTVuMgB90GBsjD?=
 =?us-ascii?Q?qKhchSgebd/j/gP7XTwzLL7g0O4ON0DUm5WL1cjcW3vLhxm6ZoeIK4d38TDD?=
 =?us-ascii?Q?3e9yjZ8hbn5Kv3OimGEgVsmI/nT8ZNX1B634ZJS4Sg0IcBwqTxjfdnh01Cyo?=
 =?us-ascii?Q?S4mJxHQiXUOeNzn4Jj3DTdBaY2F7SxNlcW2p71/F1hugbZjSy9j7rgbCfLVH?=
 =?us-ascii?Q?jAM7muLYIdhJcOaCvNlzApCPtAnzu9SEcOda8lR6lOVzAjrBI56fUOn+QClm?=
 =?us-ascii?Q?W+9oRUoazoPGuFnHOiK3oZ5XiYuGcTw6qCEMizP0O+/y2Y6aQZWh2cA/Ipz+?=
 =?us-ascii?Q?S18grVbtWLBgk/ZxgpGOzZJX44H+o2Y/HGxbUxY1uJTalVsRq4yYwS8G2o8V?=
 =?us-ascii?Q?98qSbqKgOqbmWPCKJLRq/ONtPXmR4wwuYU4gAH0gxytF/lHsacLF31+DDioo?=
 =?us-ascii?Q?j3tOqN+nQ0sfcxVdQ/MtTTqAoZ+/XhimvSU8+SIXaNgugIDjXQhGd7E8AH4W?=
 =?us-ascii?Q?VLOk4Oy/xkJSXFflHI77wtDVPob84ZcwwrivZi+cIVkVCD7pt090DIwN/gMC?=
 =?us-ascii?Q?xdylTAna6R1+XdgX+BuhJnzdp95D/upfQFUA1+fqqbf5Ug=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iABRVv0EdKofkCZ6E0ndmBtbhGUB4wmxIZm4wZvXeSG4CwyvYfSlbYO6N2Sg?=
 =?us-ascii?Q?soeuK8drwAuW+Jq31Tdg3YDl1E9KAZPK55xlKSPC7qz83eAXxNAYD6Bi8v0f?=
 =?us-ascii?Q?rXcdQN/w+C8HDr1E2k1J0Qg/NWXVfWY6I4/W7NiSpdZFFwbR69YYPwVB8utj?=
 =?us-ascii?Q?FuIBvVT+XeqRQ7NegXByQHW13EZNK/elxmDCW5JtbWn3rBrmTezjuojmZ9vF?=
 =?us-ascii?Q?ZKW5sWnql7lFBplQn4D2bDFEpKBEMMmVubeVES652OZqm3RTlIB3R/ZoUC7D?=
 =?us-ascii?Q?AxbAajniTMR7lHT6ZPYaouub6RphBisolNPpDUekEnJcRHOlM54U37jIf03N?=
 =?us-ascii?Q?vmKVwFGfveu26VuyiElP85PJ4bVGt8QE6cr3SUzPAKqNJRHplMvZeJ+FUj+y?=
 =?us-ascii?Q?7VUvvPaHwTfjPJ5uZ6//otSphOX5zcn1XQBfVJaJpUKu+asLem5Jg1b3NWBV?=
 =?us-ascii?Q?1EGq4tiusaMk0lqpstA1ft17Ag/65kZFtdwDH11XvdCEpTbSzBBAEw9StzUM?=
 =?us-ascii?Q?9GFynGhRQkrZDYVbZwBz6YWW1zZAXND2nVwtQdypWIVwe6+oUxl08B60BMjd?=
 =?us-ascii?Q?Mo6wVJARwPQP4cZN+d8yGG2Y/FHU44BYkDlRTqMtrE/s3piuiMbzDJrGL8YR?=
 =?us-ascii?Q?KI4GyAWzaxIdsE2lCaRyE6yL+xUz1Sy5a+mkEAtcjyxmkqHqu5C5RQVVZE3l?=
 =?us-ascii?Q?KmbkmybLdl2zr8MsLSd6BY/mi/dL4fp+IJJzqwx4OryzX46mo8hUuGteVaD5?=
 =?us-ascii?Q?AdWC4b3tVQw++loxenzHtUyCB8hzfx9ww6TyBXAKvFa/RxSx7FTZjGSm0Cix?=
 =?us-ascii?Q?bSa+asDBEIF9xum7KHClencnlzPoquJuYnH+ImVzvOfU6o1U9J2f6Ig8ZV/J?=
 =?us-ascii?Q?FQh0+1DOV9HCeIUXOWUZuoxfbaiZHSvHsrgdlO3qx+9sSa+ZQSkDLrcgUSfz?=
 =?us-ascii?Q?Fnw3+LPqE2Yb8y8jfIxK48lqkUCfwxs3JBuB2N3Jz7a15ViZQ9y6lEsDbEBA?=
 =?us-ascii?Q?/7XvNNAHLeDZ5Di1gGkkSu0llLSoQpOw4dKdVHbdoEfogWF+xuBnFI/BflXh?=
 =?us-ascii?Q?GKU1Ax4Kdxl1OobQn18UbKvc64xft0u//wbH3KufLnvSFdRPgzjp1UbWnc4V?=
 =?us-ascii?Q?Odc6TKalpxKPhdnbEWC/88bek0VJil8GA0DPHUFcPkqsSTSaHKjf1akmYRCT?=
 =?us-ascii?Q?bInHWDDiLtFlgiJZ86JoUC/ijcSDRJznT4dgcFOEinqhrkU9PM54qzJwDwL/?=
 =?us-ascii?Q?SjtMbRP9hOecsY/dJaK2/1BztoatgPpVScEm5tHJeEG0k2cyrq0Zv2uDAGvi?=
 =?us-ascii?Q?1LnG7FdlHHBB4Jqti9jQ/IweiaLjFriimzOIrXzXSVn7InXXQi/NgsMz7+s2?=
 =?us-ascii?Q?SRhAMZquXl+ehsFmubd8hfdV09DzA3Xl3vmOSCVjIr3U2UGhx+3sxBLpubs+?=
 =?us-ascii?Q?je36TZufm2uDBxhFBGsAxhVIG77XEZaKnNhv4LBQSq3wyEGcT9KemMOwOCxo?=
 =?us-ascii?Q?TN85ULP9FT4nxTGZ6V/LWf6d2IusIUnScpsrpFjfcyyCnYAy1DZQ4Kqa8RYi?=
 =?us-ascii?Q?Rd6xj/AcfuswYpWe0re3Fis4Aj6+m7/KUEVoHhLOFCFUofKra488kXz/wlM6?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18124f6a-cb30-4ff4-14c3-08dd2b1b5a38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 10:51:03.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+fn6WzetjYVeKb4mInHwpQjTbDutXq17+dRw9vmoORzVE3GYiMJvq9n5xqoVVyxtr7eFxHlg0+TwtcWPZ762A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10807
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 10:51:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16957

Am 02.01.2025 um 10:32 schrieb Richard Purdie:
> On Thu, 2025-01-02 at 09:55 +0100, Stefan Herbrechtsmeier wrote:
>> Am 23.12.2024 um 11:03 schrieb Richard Purdie via lists.openembedded.org=
:
>>> On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.ope=
nembedded.org wrote:
>>>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>>>>
>>>> The patch series improves the fetcher support for tightly coupled
>>>> package manager (npm, go and cargo). It adds support for embedded
>>>> dependency fetcher via a common dependency mixin. The patch series
>>>> reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
>>>> fetcher for go.sum and cargo.lock files. The dependency mixin contains
>>>> two stages. The first stage locates a local specification file or
>>>> fetches an archive or git repository with a specification file. The
>>>> second stage resolves the dependency URLs from the specification file
>>>> and fetches the dependencies.
>>>>
>>>> SRC_URI =3D "<type>://npm-shrinkwrap.json"
>>>> SRC_URI =3D "<type>+http://example.com/=C2=A0npm-shrinkwrap.json"
>>>> SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;sub=
dir=3D${BP}"
>>>> SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"
>>>>
>>>> Additionally, the patch series reworks the npm fetcher to work without=
 a
>>>> npm binary and external package repository. It adds support for a comm=
on
>>>> dependency name and version schema to integrate the dependencies into
>>>> the SBOM.
>>> This certainly sounds promising, thanks for working on it. It will take
>>> me a bit of time to digest the changes.
>>>
>>> A while back I was asked to document the constraints the fetchers
>>> operate within and I documented this here:
>>>
>>> https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/fetch2/README
>>>
>>> Would you be able to check if this work meets the criteria set out
>>> there and if not, what the differences are?
>> The fetchers inheritance existing fetchers and reuse existent
>> functionality. The npm fetcher inheritance the wget fetcher and only
>> override the urldata_init and latest_versionstring function. The
>> reworked urldata_init=C2=A0 function preprocess the url and works withou=
t
>> internet access. The dependency mixin is inspired by the gitsm fetcher.
>> The cargolock, gosum and npmsw fetcher inherit the local, wget and git
>> fetcher. They forward the function calls to the parent class, process
>> the dependency specification file and handle the dependencies if needed.
>> Thereby the content of the specification file is translated into source
>> urls for existing fetchers and saved inside a proxy object. The user has
>> to call the download function to download the main source with
>> specification file and all dependencies. The dependencies are downloaded
>> via existing fetchers.
>>
>> Because of the reuse of existing fetchers all criteria should be
>> satisfied by the new fetcher or need to be fixed inside the existing
>> fetchers.
> Even if you forward everything to the parent API, there are ways you
> could use it such that the parent class meets the criteria but the
> dervived one does not. I'm trying to aid the review process by asking
> those questions, it will just take longer if I have to work this out
> myself.

I don't see a reason why the fetchers shouldn't meet the constraints.=20
The fetchers were designed to fulfill the constraints.

> The other question I'm wondering about is compatibility and how we
> change the way urls are working. Do these changes need a flag day where
> recipes need to be updated to match? If so, how do we best handle that?
> Is the user going to get errors they can easily fix or how is that
> going to work?

The fetcher should be backward compatible for recipes. I add warnings=20
which propose the desired changes:

Parameter 'package' in '<url>' is deprecated. Please use 'dn' parameter=20
instead.
Parameter 'version' in '<url>' is deprecated. Please use 'dv' parameter=20
instead.

If we have an agreement about a common schema for repository host,=20
package name and package version I will update the crate and gomod=20
fetcher in an backward compatible way too. Hopefully most users will=20
switch to the new fetcher instead of updating there own tools to=20
generate recipes and include files.

The only desired incompatible changes are the remove of the old=20
npm-shrinkwrap.json format and the support for "latest" version in the=20
npm fetcher. All upstream supported npm versions supports the new format=20
and the user could update the package lock file via npm. Like AUTOREV=20
the "latest" version for npm leads to many problems and the usability=20
should be very low.

I leave the function which are used by oe-core in the npm and npmsw=20
fetcher. They should be moved into oe-core and afterwards removed from=20
the fetcher.


