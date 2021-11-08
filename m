Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767C0C433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 07:41:27 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.83])
 by mx.groups.io with SMTP id smtpd.web11.42074.1636357284882960738
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Nov 2021 23:41:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=oK/1S+rG;
 spf=pass (domain: weidmueller.com, ip: 40.107.5.83,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ+XvqgQPRxeN997zmmDZ7LDHvLmopO2GRMSC8QgDlQ72MiJdAW+Ui+Z1mNTHh2qC1rJTHmpmZpwpeEBwiMRcxUNHR22eUctuseVBW3XYd8F/ZWCbNCqhBQaMVQNvRQB1y7IgPA19STcK/lxI3yeGWlK6LaSjxDmzNYEwwkQllrEmo1kxvcAtDqoRW4wz3mi6SHKcUuT1HMLVj74wF025Hox0AJ4xB4Fu0T3f2NT3GlZDuIXSNwaetym2ZOp78bruUzuTHEojLOQO6Rbvkfksl6chg1gHsBRzhc5o5jrZG1PuMFN3Eq9AAGEwLVsfT1+cmLMfcu6m45vB3uPeP3+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z18ffq2cTCwjlj4aXgB/YwR7IDyaqcu+xVpLpcckL4=;
 b=lYueBLwkVIq9rtCFeYGmhU6wAyrNaps9Z5OMSEY2hMp07XrIxpdUejQirEZxPY5i1ti+WxuiqAuXhoPeG12xro9a9T4ChhxV3E6h9hzW1PymZh1oFKjsqC4wNFEh2/9NA3PLyjpSgZrl4VF/5XCZKW1AitzL+5SQDafrA4JAOe1Kd4gzxYdo2bti5CL9/qGVS8OADVZr/5MBDJP9oFFrjK8vNrv5srTONw1tfzYBDFtb5Xt/34K4m6aLLVNI80AA6q4v61/1l27zFNbVSPtPV5ct2jjm4vx4Ix5hu0EYbDJpds6O8XwDs6l9cqZrlK+njh986D4Wt4AtbwY8OK5A8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7z18ffq2cTCwjlj4aXgB/YwR7IDyaqcu+xVpLpcckL4=;
 b=oK/1S+rGcC/+r+qFf1S+1BuXCdIlhFT9GgrRqn/SiIJZNlT0tJzuBu5KKCV6zzWWIu3me4jfT9MfwMVsLoDLKT4z3MfD70y+TU8HV5NdzdGiYEkbWwjtFyqR2BAhao6crOUfM4khkJ9xc7aS3r1TT33ES08tByEl3Kabc55Jlvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB6512.eurprd08.prod.outlook.com (2603:10a6:102:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Mon, 8 Nov
 2021 07:41:21 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::45dd:11b5:8f4:981c%7]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 07:41:21 +0000
Message-ID: <6c13452e-77cc-6cd5-8d3d-0e2128663286@weidmueller.com>
Date: Mon, 8 Nov 2021 08:41:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
 "jeanmarie.lemetayer@gmail.com" <jeanmarie.lemetayer@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
 <42a0350d-991a-731d-29c2-83cd62da8c7b@weidmueller.com>
 <CAAdc0hwA12CiWHCXQV=MBHv-h=vopK7of3CUViR58fJ8k2rK1g@mail.gmail.com>
 <3556fec928b8b3f86c1a08b3cb4e2a2fb708cc9c.camel@iris-sensing.com>
 <5fb67154d576b74629e4836a86dcb5e479b73e67.camel@linuxfoundation.org>
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: 
 <5fb67154d576b74629e4836a86dcb5e479b73e67.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P195CA0093.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::34) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from [192.168.178.36] (94.134.94.8) by
 AM6P195CA0093.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::34) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 07:41:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24d55702-ddd1-4c5e-5013-08d9a28b2865
X-MS-TrafficTypeDiagnostic: PAXPR08MB6512:
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB6512AA3F7D9FEA0448B18445D7919@PAXPR08MB6512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BCW4RXTf/cARnrZBOE6XICh5H8VIzjjH2SBJdyvINzNdeIrGZlnsJtxDJi7Au9oqunPQrIis/WaJuCXLf9wjySf48Iy8CpNoEdw4wR/zDeFZ0geEh7+WbAGI0jb6BcTekHOuYCfWgXd7h7vXaxd+3kPdWt3QwYg2U0dkkoPA53aRUVnXx0g4anVYtM12Q//qgan+RZXT5UuaIdyF5VvtrkiQ/c3D06Bd/B39zl9Ibtg5MvgcLQ5YqYXQzKZQkxXBfYNDS+jyh9iOBHliAXA90JQNNcRz8usYLqxwcH8O6qBAKDxf37xQc6tFKMGTUYDXvM/6DiRwouMHXp1sXboLMW5ne7gJM1PtWSMtMHfHvDg8YnJvcz3b9qbZnYEJod6qUxMGY/i7r1cG2JPS9vFpwkAzPR4BwJToeZ+9OfCnTy6Xj7cY7Xphfv6dkIj7iov0lqT0TokOz+ngdXSSJmaSt2GXGBmHp4Ue5WUr/fcPf7NV67WRrYCrk7v3PKO6+cn4b40ibpWtrMsCYWyXLdwUK0qhJii4a7CFTbd8T5yFK4TZkQ3zC6GQwaTa65MrTL0elfWtqVZsvTDMvhto9Ng3KAMo7fPenoNXryN/3Q9T6L6xo43MCoycMnq4vygte0qzGNIw6c6uI5onMpEts9LGokVUrzuwAL0AWdlrXl+bVn93X7pifbd/SbMOicRoZPO6nxNDiiJNwTGboWBvFr0FWQmmeEsZZR0o9saWZqa9MKzE/8gue10ebHu1SuwZYvQkqvvTpHeyUFI9tUTuR4IcZRdtci16Uoa1PkaQbB12Tqc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(26005)(38350700002)(508600001)(8936002)(38100700002)(2616005)(956004)(316002)(4326008)(5660300002)(31696002)(2906002)(8676002)(6486002)(83380400001)(54906003)(186003)(52116002)(66946007)(66476007)(86362001)(6666004)(66556008)(16576012)(110136005)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3S8JxG+MDcE4ryh3Uo9MxFUbyXolu1uRAPTihbJWlwC96hrHf4Mfnu2s1vmj?=
 =?us-ascii?Q?SvjDTtF6nJsUDev6vOMz7ZpDdVO44YCAJ1KHeqPTsTFUu5QnnuT1u6lQ2vKV?=
 =?us-ascii?Q?XeqdbzGqnFpMv7X8Tj59YRjtAF26tmYcEvQrWM5nm+Zk/7svlgAQMEnFQDL7?=
 =?us-ascii?Q?QO89MxHinfI7z9ECzlYHncmVyD7iqH2mkaJLnufh+mVb8ohq+wl59GPR8h6T?=
 =?us-ascii?Q?VZX6eHB2XcDXACMDooFJsx4AC8gp2DkHITutToq5cZwDd/L6NaR13/lCWsgF?=
 =?us-ascii?Q?+IagTotwhshWmT6pbENLq6ZQ466dq3FCeYhXfGsPYu4f1EqvfDxvZ7/Y3Lvx?=
 =?us-ascii?Q?FQ8V8LktORdCgUAhGysyV3e1KSxyuQN/Z1nD+TBpgY5/Os1+sgawqktrO3DB?=
 =?us-ascii?Q?EZuzXOX8RUfhPgk4TpPzusN5P0kuZvRMy5u8iPIN1l/RtLEJjjOi7T2XF4WY?=
 =?us-ascii?Q?H9NiAlcLXrZgBEriGuglWgKIUW6BskmKcSb1eln0/G10WTDjpinEyJwhdU16?=
 =?us-ascii?Q?c+NUetX3RkuJibYp5c6G7aG3mZbZI9ZHxs8wTaTZQKrQDo4WCYkmFexkQPGW?=
 =?us-ascii?Q?IwUiae667Y3VQ8GJ7U9YrCyDhQQ3NBDXDkM5oi0m06QR2AkN88hL8SUCCiO5?=
 =?us-ascii?Q?4NiRbllobKs0CnLdfbAHh9O6mI9rTCAUusF62GrqUQ4l46Vr5uyCwigXEqdx?=
 =?us-ascii?Q?MSebi2sU2pbwDgJ9ZnW4gF4XUMxUwF+C0h+N+RQTMBrTBJHfUb0Ttb4nsbbA?=
 =?us-ascii?Q?3cjXM/m+VxzU5z8xsFs4sfNqYJbB9A7AmSMEh/D0PHA/Ge9TeUJgb5JaWPuR?=
 =?us-ascii?Q?EGiHmh4l5X8Bvb3LzruQS40AMlTcRhORxSOOmFE52ZnbuH31DZJDpK1NBNHZ?=
 =?us-ascii?Q?blzjZOoTArJxYXhroY/lzzQqEPf7cVOUsmKPcm+kJCzQCB7B4v0rKc1dpdwY?=
 =?us-ascii?Q?EUfNyqzLWC2pG/Iui4A9Cs9dZwke4VsT8RBWqAnNMsSWXGpKJ7lO3gpxbKFx?=
 =?us-ascii?Q?fyEDjsSXAVN/2L6P4lTyg2WALN1w8w3FA90i1AgbvLwH8shwI03NrHlfP5dy?=
 =?us-ascii?Q?mj9kfJsoOQOpiFTW+qcX+F14ULGHA+mwyTlmMYreLsJHTe12tRYzKO89SVZK?=
 =?us-ascii?Q?yvmNb94V+SOtkU9L9oBi+qoJPygiXnXH2fK9oaD85TfXZZtvzPAcrxKISe1B?=
 =?us-ascii?Q?TQtDbiCydaoeVC4TqQlLwkvUkqkeXWEv7n4P4TrJwBvnGHqlhYpfiI8y+K95?=
 =?us-ascii?Q?7yttsHF1lKJh6sKDicntmX3DFayYI4eEEtP6qQWP70fschZwWH7uLl1QbPBn?=
 =?us-ascii?Q?UyDeJwC9c+6VRVHk+J3gsrjTA4Za0zazVk1z7BYYy0vqfBqR0QHdrUnhgpd5?=
 =?us-ascii?Q?z8dVx4MKvdSVRmbMIs9SVOKb+nr+Ary4MUmKOzldQJwnoX3C454cpR47kWzG?=
 =?us-ascii?Q?0QzsSdC7DMeTAyJicYzaMIAJ0lP7osuibjPVz3hYa+SwcHrw3VosGi1UD928?=
 =?us-ascii?Q?32cK8zxUBr3IexJ940qPM40oK06mNa5TrV0bc9zB0T44PHPkMd+aNpSa9rH6?=
 =?us-ascii?Q?UsRtWDpL5N+/INn4MmmOEXGfWb4+gbdP/1yMd4zgGJstEv3gufkf60MBQRL2?=
 =?us-ascii?Q?xtbsRs2NgaC5vnAFlN0ffJU=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 24d55702-ddd1-4c5e-5013-08d9a28b2865
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 07:41:21.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 SXNXU3lB/T2nxuFzwk4CwPw+IVsYtcDkx5MIecodpFmD07bDptziPqK9O70KJQK3b02JcFPmlr7a+FolAPiK/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6512
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 07:41:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12929

Am 06.11.2021 um 11:06 schrieb Richard Purdie:
> On Fri, 2021-11-05 at 16:02 +0000, Jasper Orschulko wrote:
>> Thanks @all for your input.
>>
>> It seems like there is a lot to be considered. When it comes to under-
>> the-hood development, the yocto project is fairly new to Martin and
>> myself. The term "bitbake requirements" has been used more than once in
>> this conversation, yet I am currently not aware of any formal
>> requirements. You wouldn't happen to have some documentation on this by
>> any chance? A common understanding of this and the actual usecases for
>> npm would be great, before we go into further details on how a possible
>> solution might look like.
>=20
> We've used that term as there is a set of things which the bitbake fetche=
r is
> expected to provide in terms of workflows and user experiences, effective=
ly what
> is it's API. Sadly there isn't a formal document, just a long understandi=
ng of
> what this looks like. It isn't a piece of the project that people have wa=
nted to
> change too often so writing such documentation hasn't been a priority.
>=20
> I can try and briefly summarise the expectations I can think of in the li=
st
> below and we should perhaps just put this as a text file in the fetcher
> directory of the codebase. If others see anything I'm missing please add =
to the
> list.
>=20
> Just to be clear, we're not trying to be awkward about making changes, th=
ere is
> just a long history with this codebase and end users tend to get upset if=
 we
> break the API. Different users do have very different use cases from the =
code.
>=20
>=20
> a) network access for sources is only expected to happen in the do_fetch =
step.
> This is not enforced or tested but is required so that we can:
>=20
>    i) audit the sources used (i.e. for license/manifest reasons)
>    ii) support offline builds with a suitable cache
>    iii) allow work to continue even with downtime upstream
>    iv) allow for changes upstream in incompatible ways
>    v) allow rebuilding of the software in X years time
>=20
> b) network access is not expected in do_unpack
>=20
> c) you can take DL_DIR and use it as a mirror for offline builds
>=20
> d) access to the network is only made when explicitly configured in recip=
es
>     (e.g. use of AUTOREV, or use of git tags which change revision)
>=20
> e) fetcher output is deterministic
>     (i.e. if you fetch configuration XXX now it will match in future exac=
tly in
>      a=C2=A0clean build with a new DL_DIR)
>=20
> f) network access is expected to work with the standard linux proxy varia=
bles
>     so that access behind firewalls works (the fetcher sets these in the
>     environment but only in the do_fetch tasks)
>=20
> g) access during parsing has to be minimal, a "git ls-remote" for an AUTO=
REV
>     git=C2=A0recipe might be ok but you can't expect to checkout a git tr=
ee
>=20
> h) we need to provide revision information during parsing such that a ver=
sion
>     for the recipe can be constructed.
>=20
> i) versions are expected to be able to increase in a way which sorts allo=
wing
>     package feeds to operate (see PR server required for git revisions to=
 sort)
>=20
> j) API to query for possible version upgrades of a url is highly desireab=
le to
>     allow out automated upgrage code to function (it is implied this does=
 always
>     have=C2=A0network access)
>=20
> k) Where fixes or changes to behaviour in the fetcher are made, we ask th=
at
>     test=C2=A0cases are added (run with "bitbake-selftest bb.tests.fetch"=
). We do
>     have=C2=A0fairly extensive test coverage of the fetcher as it is the =
only way
>     to track all of it's corner cases, it still doesn't give entire cover=
age
>     though sadly.
>=20
> Not all fetchers support all features, autorev is optional and doesn't ma=
ke
> sense for some. Upgrade detection means different things in different con=
texts
> too.

Thanks for the list and I would like to see that as part of the bitbake=20
source tree.

> Also, I did realise the npm fetcher tests simply don't work anymore. They=
're not
> run as standard as our infrastructure didn't have npm on it to run the te=
sts so
> they have bitrotted :(.

Is it possible to add the nodejs recipe to the core?


