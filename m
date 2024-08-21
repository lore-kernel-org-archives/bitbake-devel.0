Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2424FC52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 10:43:43 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.138])
 by mx.groups.io with SMTP id smtpd.web10.16922.1724237018043353870
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Aug 2024 03:43:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=WYVSYY6U;
 spf=pass (domain: weidmueller.com, ip: 40.107.103.138, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAdeebTq7ge0zXCO0GFOhpYUtBZz7YFmeEortrfQysvJ8M+mK6B+PSuiDZvtyQk4bjeIA22J27MGKAup5PZSffbLzRWCCs5B03AGHM9ahLPbQQ0wFX88tnCHLteBFtj3uccYNzOA47enwb/AFN0+kmL3YHAxbl0UXCu8No/+vr9Bv1yU5McyhjfxMaKrQllYmoap0hCc4HT3BVeoAMnPiCnsgVlFemKUz9v8wJH3bDvoXH6tRl8+l5rz1itNIZ25jes7C3MlyHL4sIL4vn2Agh/pbz53lvXTGV2AMxNRU2a2puG2vvPUf8sdBiOklodGZDgIaeDQY2lXV7OUuVraQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUDDHqyElu3aAw+DSF1f9iVJxwjmElYS5KY41hK/0zU=;
 b=yUjVNMuN7r/qgCladEQoFByCK7L4xW3JSPiyd/e7KpXGtf65RvpCa1m3UgsuBxuZ83KjnN7M8eaS1uRLFUYpfawTmtbVIqStNoHfKYHurxZlkXfoO7Y3N7AP+gfVXtD69Aa6TzM4Z32n41+WyB9rPgBBgcTx4H8gjbLjUeDHjQCveY/UC/6N3c4/SgEfu4veEcasDrgs+URwCuvZ4W6fzCeACDSRl/nDJm026aKJuOl9lHEyJqykZM3AwSe+g5aF1LDRdWDVTwxU3ZZPLzRAqzkhmN6/6J7uYmEwjOO3zYt4dqWNjeG+mYo+jUQ0M4HbBFIlBYgWTptPTecm08klrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUDDHqyElu3aAw+DSF1f9iVJxwjmElYS5KY41hK/0zU=;
 b=WYVSYY6Un+jCwCN0lxdwMig1w68V9CaM1deUB2inKFVk4oyHjWnMjRWffO+wbqcRcLfQ90qe1f8k3vt+74XLf4uo9v+6BJxlxWBjTEEnaXbReiPCPSGPH6HCmyVGfckD4wfPOg6E4CF0tM/Bj/OEgHCF8jjPcvOLsogU7CQ8WttarHJ+88pyGAIdl6VMlBRmVK8sEG93RjuLH8V775HvNQ3JHbsPKJfwq2CBoYETqTCnOMAyl4a0XJBt4PH5kT4Dd5bkVgqeTU4vJRXzj9Ar680J4aFVQA04XaBFZMiJ6DRXYJfqvieB8rtovjSAJ7bEXER0ixLraWJ0zViMs9Qf7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR3PR08MB5738.eurprd08.prod.outlook.com (2603:10a6:102:81::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Wed, 21 Aug
 2024 10:43:34 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%5]) with mapi id 15.20.7897.010; Wed, 21 Aug 2024
 10:43:34 +0000
Message-ID: <1520b2a8-f20d-4870-8c04-1579d84b6a1a@weidmueller.com>
Date: Wed, 21 Aug 2024 12:43:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept unspecified versions
 in package.json
To: bitbake-devel@lists.openembedded.org
References: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
 <c2136d36-fac4-401d-9220-0f227260ef2d@savoirfairelinux.com>
 <b89f6243322fc0e72ae6a9773c437ee598d773e4.camel@linuxfoundation.org>
 <AS4PR08MB8046E1B791A39B4751C4D732958E2@AS4PR08MB8046.eurprd08.prod.outlook.com>
 <028bd9ca-a8ca-4d8d-87a9-00d19232855b@savoirfairelinux.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <028bd9ca-a8ca-4d8d-87a9-00d19232855b@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|PR3PR08MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: af9810ea-bef3-42f4-dbb8-08dcc1ce1b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6MySYMEoyChBRdHFC2AuFRZYjuGvN7Hg6UzFlTdogJgPDDOyUbSWP3YOAt02?=
 =?us-ascii?Q?JlOLUkMXc62rp2//jvqud2eHFcBTzeoWG35cRFLJG6ZctA3EsKiPECTpgDHu?=
 =?us-ascii?Q?Kxp0d4+RQv+GM7XidK3W5n/zDxuE9SKOuYkZnX20y8nJen5Byxp5HTY4H1f+?=
 =?us-ascii?Q?jtMKCcBKSdEsdUju8iGkOPoE6Jps0QpSOfIPAPm3ANCvu2TvZ+fj+BBSK3Em?=
 =?us-ascii?Q?GnowHv705eDEHGEYqFQP9l/9nlIDLpG9F8KEThqJSieBDrCSIdFh8zgRq0SK?=
 =?us-ascii?Q?Hrr9yGVTXnGtLkegJ3zW34W47CAfltpPpfx5ThdNMN93RvgyWsrgUBW425uP?=
 =?us-ascii?Q?BjYutvOkiLU6gQbU0/qIAimUOWF4Uy8Wbjy1cnhYxo1eVV2Nei7LnnHsX57Z?=
 =?us-ascii?Q?YGU7TU83OL0WthGff/WvtgaDb4qHbUr4giwdb7RgGHS4WZIo18Kd6uSZwa3F?=
 =?us-ascii?Q?uJ123oOsPtFYJEdzXh8AnJW5524YDLrdVGQ7fAE5f2G1WtvtlkJ8/fKPjC/u?=
 =?us-ascii?Q?2QmbLMZBGmF3srysEqzgHjaQTupjkUnj4IrSFUFpCfzUWtporggmH0SJwHf9?=
 =?us-ascii?Q?SmGyD8GB2tD+VEIOGPfoBQ0RaVs5i/v9294wHntRPnz+hBXLB1L8lC+W3aQD?=
 =?us-ascii?Q?9yOcW/BaWEYJXB14Tyw4zUA1QEVBdO2lAtUHq5ODHozD++Ggv8DJSyTpV4cR?=
 =?us-ascii?Q?I/8fCN7GP2/A0qkGGd7E/rQ1dqkZzchaabqNmWl4PlfhZjk/eMzGsz1f2n/D?=
 =?us-ascii?Q?27wqX0HvOtYAzK/MzGc7S/7XVcsiZv7hw2qyhfEWNPAkl6xpS6iTY3FKrzQ3?=
 =?us-ascii?Q?/Y3BOVdfHjYk4YO5FD2sBhU/SPjTz9pY1L5X05R4sWmfQPXhGv7M9uxaBjb1?=
 =?us-ascii?Q?14cQxnqyiwX2ginaRVn3vx7T5YYfEXzcX0lAchjcbjwbKKYCmipj+PuNQzwo?=
 =?us-ascii?Q?0yb1AABvZYKWnlXAB2x8xRvfzFIdwX+3teOvzqPIzLD0T74M3oIM41kvMks6?=
 =?us-ascii?Q?NZeLKGV9mbusNZyCdITMrCUJhn5rJej9Q2Nlk/UIr3qK2QvEvqxi01BeMVCb?=
 =?us-ascii?Q?0GNBbSzUoeCRgpahAcdy/CQd1sBGZvEWboKaRj9oqjZXcMemlyf60quRn5lV?=
 =?us-ascii?Q?hhwgF7WurcXfJzJqgmkmJtRGzf1CkrnUMTObgPMFYBpiiiuciZCF3k7dj+U2?=
 =?us-ascii?Q?K539yDmGgovL7HAziORel/FOt17eJmGoQtRTjzYaaXkQCciap//6/DnOqx8Y?=
 =?us-ascii?Q?kd/lmX3QY/u0fhcQqsBn+BTFGjLJqzNTUSL0nfC0kUCchPd6Mrs+NoLUxhCg?=
 =?us-ascii?Q?Sv8O9uZjIu6olC57XqVY3KReke2SxjT4j4rqY/vKybErZQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MtY/hKq5tOSvjYug/YICa8CyPmCe5ZMQZffW2ob+7HFsYFKMGQhhu8SvuCVz?=
 =?us-ascii?Q?izzMhHwTlqTyGMGBuCNvFjszBjwpw+1Nf54rDmLXuPCdNn/qjax3EHsXJydP?=
 =?us-ascii?Q?+C6pDTRdj/lmFc9CSAu+An5z81gQyZSaZA26J20x2lwV6f4hyJDLBVSJ9ZLB?=
 =?us-ascii?Q?PVm6alQmGEVI8EWVEH9sipAc5GfwdGoI4YxoM/6mGb8rHHqvMJDF0zgjj9uN?=
 =?us-ascii?Q?+E8fG/ikJEo+5ga336+dC8Qur5eAK/7BVgH/7AJbYT0JCXQNTE0dvpAZPlPO?=
 =?us-ascii?Q?J/Ghi3WlRBuvwWQ8bEZdPKg0z7TnHjQabxcmBjDDXQzgR+oqXpQqsrFbPzRZ?=
 =?us-ascii?Q?uzMtTPyO4wYyIF6+nuqKXlTEKbZjgs/VXXUsg1Kw0Ch6CSMgqoy2wh+JMjiT?=
 =?us-ascii?Q?KB37wbMD1kZcs4mN0npxdDfZ4dxwwSPvzAz1hy5udZYBNMRGH+z+eqiE4Vsg?=
 =?us-ascii?Q?fQGD/o6gpmRm9mIvhJyckQ1xB+4ZsKR3wQD6AWrXQm3kR1H3KZiHUARJkUTy?=
 =?us-ascii?Q?P0aSgZfMs8xeWv/iUikZQ45Mr5TDSnjwBSPftXGsaQGnGpHI8aKhH/Y52bBZ?=
 =?us-ascii?Q?ACVB1B+vUNmj4Re6G/b3Me8jQ2tlZutbzXAOh2APdnoEQZf3mLr4I3eGbtl6?=
 =?us-ascii?Q?Mbe8J+Wu/bgUWXmVcwvKshy0rzhnNTm/cAi3Go21RsJF6Au4gtCGYrl9QP2d?=
 =?us-ascii?Q?7kmvw60+4T7YRq0iv+gIcvhZ8R4flpwpCGZsQvk62GBB+AMbHqew4XRZvkom?=
 =?us-ascii?Q?ouzU0OBtgn8jresPR/vHnMF8vFqA/bJrYLHAeMD1/wMlJJhkBXHGRIBs9z1Y?=
 =?us-ascii?Q?dS6HNyma30zSWXDPf2NbsyRqLbjzvxhNX6NOwJVGDs78mTWNtanv4o7J+dLH?=
 =?us-ascii?Q?ZALlOk2WiVRcBAIv8bRoY7HPXt7L4FYQK5WTcT2wk/eqWZ/SNa8QZyqojdLl?=
 =?us-ascii?Q?G6YBDvGA1de2CLm0FjZHoCk6zWH3RhyA+SSD1G1Bgp69cUvJmWHEXPuBU/u7?=
 =?us-ascii?Q?KQ3kYiZx5ks+F4rTc0pHIt2auYNPSzmMGM1LbL4u0ElOJ2QJ+YPkWUWaMKOu?=
 =?us-ascii?Q?4X/MjgawHInpjFarnBRnVJyDHiHm3gvgTNHtjCoIXaqKITUyjCpk1OVOKqIy?=
 =?us-ascii?Q?K56ieKkx05Z5j8coCOZsPwJnh9T6CGmHut0edcMAopdFPw/iPnlnpdMZuauj?=
 =?us-ascii?Q?Kpj8DLm/p2OcMk9g3NTHbdVy7YtcXpp+SeSnTq038bp40aHveXh9Rv+If47D?=
 =?us-ascii?Q?21MXPk75D2dpLAT77Riq0BAoFsxgT4HpRwLf810QgOEX9ugc6zEhaUQNsxfb?=
 =?us-ascii?Q?rT4v2L5DoNlCwTvpjRaQnPFBF5PYn6rDLB0PETz/fh6+4DN2gkZmNnpaD7lS?=
 =?us-ascii?Q?3yqKcw40fGmBNB8Gyycx9gjkq29lYeo6SakPJtqTG5ODiAqyy8ECsn1Vvr7c?=
 =?us-ascii?Q?al0TwRHO0pT712TEaOHvkSQm0l35jU3N4V8akEXRHOoiBSbujcFWEnfy6uY6?=
 =?us-ascii?Q?1zkAYwR3XusmyzPUFI8vOIlt5+UE8k9sgDZaZ4r3/tYLu5kJKDQLqTD6+HcI?=
 =?us-ascii?Q?8V0Zu30zYiaSLZRnEzL/N4O+S/81/cr/BCnDs6qcpemKDBshrdV2QxeMW1BF?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9810ea-bef3-42f4-dbb8-08dcc1ce1b2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 10:43:34.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nE1QriuGrn97cIcFMABrGzUv+aVNe1bZS3Yf6UCF70CQ+BxkiTm1xXkFwpUAS8l5Qw/hbEWEz+HVUFMsN/euA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5738
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 10:43:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16507

[snip]

>>>>>
>>>> Back to our commit, we do not change the aforementioned behavior, we
>>>> only make it compatible with packages which do not declare a version
>>>> in their package.json. The npmsw.py code wants to have a version to
>>>> validate what's being downloaded, so we pass a dummy version. But the
>>>> npm-shrinkwrap.json file, generated by npm native, still contains the
>>>> reproducible metadata. Example here with a package that doesn't
>>>> declare a version field: NPM still added integrity and resolved fields
>>>> which will ensure reproducibility:
>>>>
>>>> ```
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node_modules/cockpit-repo": {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name": "CockpitDevelopment=
Dependencies",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "resolved":
>>>> "git+ssh://git@github.com/cockpit-
>>> project/cockpit.git#d34cabacb8e5e1e028c7eea3d6e3b606d862b8ac",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "integrity":
>>>> "sha512-
>>> 4nBWhDtVLwF++ZPY/67QtpsXc9y/Jpa/jj1LW/gScSafDKoHmtg1BwAQ7sqpN/
>>>> fdyi1xrkysM9hxLq3Q16ofaw=3D=3D",
>>>> ```
>>>>>
>>>>> We should probably error if a version cannot be found and force the
>>>>> user to add one?
>>>> An NPM project can typically pull hundreds of dependencies with some
>>>> not declaring a version, the user would need to submit patches to all
>>>> of their upstreams to fix that which is challenging. Meanwhile, the
>>>> real NPM tool is perfectly fine with accepting that, as illustrated
>>>> above. I believe we should hence behave like the official NPM tool.
>>>
>>> I'm not asking for the upstream NPM projects to be locked down. I'm=20
>>> asking
>>> that our recipes always have versions specified. This is similar to=20
>>> what we do in
>>> other places like crates with carg under rust, which probably is the=20
>>> best
>>> example of how we can lock down situations like this.
>>
>> The rust solution has the advantage, that the lock is parsed during=20
>> recipe creation and the recipe author can rework the result.
>>
>> But the real problem is that the project wasn't published to the=20
>> registry and has no release. Both cargo and npm support git=20
>> repositories without a version. Maybe the parser should set the=20
>> version to `0-git<short git commit sha>` and extract the hash from=20
>> the `resolved` field.
> We do declare a dummy version in another patchset somewhere else=20
> indeed to pass some checks and allow building such packages. However=20
> in this specific place, the version field is what's used to fetch the=20
> packages and it needs a URL (git://, ...) which is conveniently=20
> provided by the `resolved` field!

You are right the npm version field isn't always a semantic version.=20
Maybe the git sources handler should always use the `resolved` field.


