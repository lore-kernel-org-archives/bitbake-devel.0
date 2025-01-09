Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB89E7719A
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 14:26:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.104])
 by mx.groups.io with SMTP id smtpd.web11.49478.1736432771275475890
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 06:26:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=O2Dubl98;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.104, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGfXRJRE9rk07bBW6bhYHeKC66IVg0ganjN2yZds3NMlxcO7IdmGbc+0ETVwdPfMwucpNrnZ8Rok4xlYBKcA4HGIRkExdMFNxKiAJAA/mcJA/s0pyNQQuI/0CllMmH0oqRsyo/DMfAkqtv2/Zu9b31pVrKRTXZYjqQLpUd4FZZ7jiIbZP99HmpbaV2+SmrUsiZ9fuZYerTLqAPz3l2uGU92kwRSEprtrrBLnEKMncVX+m7EI2xRmztVeUaorV3SGGMw7qVFTZF9BUV3tSBX5D8NSUc6/z/qDpsk4b+8VsO0ED+UyFyuweUD3J1jLkm4PELP70lIaxh0t/pjxNPMEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRGoe1HluX6C9Gbsuh9XhM4z5dPksPmin4L6U/VjlEQ=;
 b=Ra4Bh1VExOkoqkMwPkqD85elMMzcIrTHZEDlFj+YyWDgixv0LjdbkDo0Ikdn1U3MMCLC4pq1OG0tA2iie23D/37IvhI6sQh0glW7ElJUUgF/peLSQWqc7c0tY3xxqffY5vQwZsImVpl63Cjp6gmG+baAjmdq17Ic95FoHH3QQ/vXEPXBCrZusmakyx4Dqx2WS71W7zCGfaFqOjjVExpL6awzfE9D12IFlpoghmw15HgJEok4CzHR+yRwn/3UUdS0/D55HCfVJLzBieO059TFAGEuIQ3TZPSJ/VidzylspGEL1vu5lYHGHr1CzTahIx3avH1sQy2I0YlOmsAFVlfFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRGoe1HluX6C9Gbsuh9XhM4z5dPksPmin4L6U/VjlEQ=;
 b=O2Dubl98DUdTYxvUbY/h7BtHwsRyb8vwjEvYNy3KPAtHmqsaNxHksU4jOmPyUCGjbQkIHxnbpECYS9gn9WkyFomCWzonT2oU72o+ckim6IeC5BfxJaUJz/gtKJJo308Pyh2UmKp7xHUAivBsvv4VVPIZFYbje9OfxjKE1nmu7I1yHoiA0hT+G+GCRWRAkZYq/FzTcNP0k9FvU5jArtZ8oPNbZ9FM6QCY2b5OXXS4oBg2WYEeE4gaqm+/VeAPYqRJJOErh6GZWtejvqod4WgRI6OFucWAKaGS7SEYFWkZhg58fJSrZ/H7Btrdk4Spp72kvAHtN5QvnKZMeB0L98xadQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAWPR08MB8982.eurprd08.prod.outlook.com (2603:10a6:102:33f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 14:26:08 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 14:26:08 +0000
Message-ID: <7f975727-aa6d-4e49-a6f3-eadea64505a5@weidmueller.com>
Date: Thu, 9 Jan 2025 15:26:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Martin Jansa <martin.jansa@gmail.com>
CC: bitbake-devel@lists.openembedded.org,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <CA+chaQdqdphd78MWOFgb5hziOLdT+SnT_=bLnFwDPbs=9FYOAw@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CA+chaQdqdphd78MWOFgb5hziOLdT+SnT_=bLnFwDPbs=9FYOAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|PAWPR08MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 1612f4b8-3dee-4cf0-d16f-08dd30b98ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1m+a4rwGwTdr4eRtS+7bFI54R+sL041Zw8d2yhsfSXzkRcFsM2quILWCcLnA?=
 =?us-ascii?Q?xrFa8Mso5borFN9G8nVBdJ3k62GfHvDEseSliSWz/wTq9H7zzxo4rK16YtJd?=
 =?us-ascii?Q?XVPgzw5jVdCLdb9vn7sQOnsAh5VYD+g9qh2+Zpsk7uJpwlO+ULndFnt5axrD?=
 =?us-ascii?Q?CsOq4parZuDr39qUASptcy1jk2WUgncU1dtfTWn6jKaqT1PAqfS5wA13Xn/s?=
 =?us-ascii?Q?cOJ46gJsA0Q9ROnjbsxjpsctRXBWGeehHRFkiQa8ubfI3mKc8pzB0/Bo1KOq?=
 =?us-ascii?Q?uzuGOKZXwQvLjHcRmsX4b0G2rRxb5SShv0WooWBkCmX++zTEWN6Ygi6BSCv1?=
 =?us-ascii?Q?Kw13iX3LyMp4PtHwbqAAuGo9S0o3ianUx0F+lmncHVdAIP7I6OCC5BQfTxM3?=
 =?us-ascii?Q?Ou3PXXB0DJ+7coqgBvyz3EexeRAH4TQtFDQ1fmer/6nNGkVWcLsoEYlQ3d8/?=
 =?us-ascii?Q?oBXSpxwh9VVKPPdSS6IGoxfsPMwjV00B1B5yzZqoHQiJBw6fQS4vAFwnVfh9?=
 =?us-ascii?Q?BRLbA677zWnBWZItqD2d2SKFvm6Opj25GkDAdfS9+JMXaSTWZJZ11NXGso/v?=
 =?us-ascii?Q?iSbx6LDM+VXA7yfeJEHidjVKPaL4/vADC9Kl3LoYp1iwRgO9UymL1qxQfrmB?=
 =?us-ascii?Q?fDYKkRkPLDH1GUfkOfqfZdaZ4Yg2SiO3jK+5GBVzF2rQtvXi/QkoQl3uCVJV?=
 =?us-ascii?Q?4Vjt2EGGnvtCqIjn583FtsyfIPwEGvtNzxLfR8Kc8Jp6HNdxf+YgUfUD/TxA?=
 =?us-ascii?Q?8S0OnbQXxCoxvawkShR9m+Yvt9ZoOY72ohD0aBaBYnPwfb7QWzAVf6N7LM6t?=
 =?us-ascii?Q?bzp9vG0tLg0oXDQAsFUBDTVTvkG/drxLTa0ipspq+dezCFf2w0JhW1Ojh+U4?=
 =?us-ascii?Q?QdkgqhGBLCbwR56NtlIAi84u0Vr1NtCDBHVVv1Nf9E8Vmzygir90u61tZ/Qq?=
 =?us-ascii?Q?+0LbVDwXaWipKhOAv9aQ9KHD6OnCGjJ0O5LsSah9HyEy0h4wIfHENUaVsSYq?=
 =?us-ascii?Q?9B8GLev2n4D92opAa6dmDad3tNlz4UjRB/tShPsEcM8a42tL+EWmrWKdFUFs?=
 =?us-ascii?Q?2T2PJcNiE7SKG3C26QhwkX1DSPgEe0OWF7ztjSuL+SPKI0THHot5FGTbh9kl?=
 =?us-ascii?Q?l8J6utTf98aHHDUtkuAOovfHBZ2wG/dHmWrIyR34rN9iNmjfNiP/QUDe1xZM?=
 =?us-ascii?Q?4prC6Bm+wsQIowvmbNtt+zXswxlU+J/tiIMTkjgBMvY4SpL6wPUammr5BsIx?=
 =?us-ascii?Q?DK/5kPmhee2eYTDFDd2jbRe/spzyBr5LAcJPE/NDoDHxlm2ZCo5jN+Ud7Z0D?=
 =?us-ascii?Q?GmJ0Ukt2kdSl0BkfvG15g8gUnADFh+PJdEMYH6aZRwXqkQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4022899009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OVy09oQ299XLMppGqJcKce+Yg/g9eLMus9hCobTn+D6dhFJUugoSZKYBs1mr?=
 =?us-ascii?Q?/7/OHZaxTf9uiLAYPheqSS3aqMkT2UaXHab7rMH9ytfmQp/70wtyEeGdt/Hx?=
 =?us-ascii?Q?O8IkJsPWTYrJtsQC7Evrd1UsuYW5+TNmkVzwD0Z8Rmw5eDj1wFBmDf32x6HA?=
 =?us-ascii?Q?NpG/9mqoPP16YSzTdbm8FxaQOh5GSKcHd098lN1fP033jiIRLkT5X5ITM3l3?=
 =?us-ascii?Q?rYm1W48o9Symu2E8MJeRuE/IUDovxNihMnlv/gb6FsQMZDNbUfwRsYGqCrGD?=
 =?us-ascii?Q?EwqtqJWo6ACI54OgZ66cbcQvUys0pPXPkl4zr6k6pbVPYmv8ptcqmyeJJUYz?=
 =?us-ascii?Q?/AfsIhnjwSqXCVoQHIE0FUfAln36Qxx03/kV1yDUOj3gO3FeChDRFrSM5TCO?=
 =?us-ascii?Q?RWW/JlP0pUSLBEpDniY+j6hl8QJTuxjKsBBolg9BbV+kPs3TWHogoV69xuOM?=
 =?us-ascii?Q?hFx/DM3Jqs1YA9z/WnsXb9NDoJcAyj28ZAuDOqJsR2MXCUjsWRuMhZBemOqR?=
 =?us-ascii?Q?yoALG08dAroWcQh9IQlb0KyDQkCffU31P8YNbqR46UdVLJ/ZTO0mDnl1jXQA?=
 =?us-ascii?Q?cGP7fU0KbwZ1yaKfIvIVbYz22s1OS1sGTnOOuq8fKCd0MeaX+eZ3LXWaXW2D?=
 =?us-ascii?Q?3b1H3a1YuaZIIDiJSY7Q/phUf40dLyxhfHZajpPPk0XuA4PjI4filwkVu9W2?=
 =?us-ascii?Q?qOsbBNyNimR8kksF/XVdD7fDSqvGhAr9F/oOJTL03n7EBglRs2HwGIsAnT7E?=
 =?us-ascii?Q?xnrD+H5DC2eN0anYcJF3OX3b8g1xTWjXeHo5VVveCz6S01t+SgCen/I4N1VK?=
 =?us-ascii?Q?SqqN4b92RDSWSx0e4eA++nseWCY4+0HQkgbIZT8+Yp6VxHQpzykw7CTMDqdW?=
 =?us-ascii?Q?kcVOvCJuWlbJTvSwZZjXXOzXxEYqokMw7HK+2m3EaLD+WOG9dm5cRlfAqYg4?=
 =?us-ascii?Q?lg3t6maQsVf6RGXxjLyryxA16jGWNs2gWTnXb/cIrQN5OC8pk9TKXQu8lX5g?=
 =?us-ascii?Q?/JQqxuvTnflOK5iGxlor8qRWj+kph/kyRWQNnOKuOG+0RjwtWnhrmRX7eGXk?=
 =?us-ascii?Q?Lmidt7tNS1/xC9j0P1CBjoEZ/xBtlF8AHgm/eOtaqAJTVdaa0VL1GPSxo32l?=
 =?us-ascii?Q?BqVxugFVSST79aCbAuSGdIzSToLv6g+ItGjn/cZvL7fS0DhqrQih+0W8rnwA?=
 =?us-ascii?Q?vphJpQrRBGIUaDxLgy16dsKyGkpOmyH2B/QbTUZs6QJ+SoUsRpJaBPcdCL6q?=
 =?us-ascii?Q?j0gSaalo+HQWeRQ0FxX+Byr1bGpElEPCK0mo0AyKv73s7G0BEsSWTsqFKGfW?=
 =?us-ascii?Q?Xe4mJ9bv4CnocXvaPkuz15cgc7c17VESRMk68zOEumfdP/29BM19YVmqL2GB?=
 =?us-ascii?Q?wmhoqS1kZ4UMMy16QMh6jBetNInmfNpL0qEtRKfreHLnBcrteaquKK3Bat+R?=
 =?us-ascii?Q?aALQkD6BZoTekDCGPaea8/g7Sf5VhAtFutk2mCKyVsb762z/mLk/mU3pGUak?=
 =?us-ascii?Q?P4Zl5OYxudcjUBqRFJnBWxrcJytyYD8RghSjHFcQYd0N8g2ijqqA+LfF9eMZ?=
 =?us-ascii?Q?C+vXiB6z/0o23Hdk2EaLCacrrNwHJ8Kj3ifinOs+15YhcPepbJl5t5TC5QAA?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1612f4b8-3dee-4cf0-d16f-08dd30b98ec4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 14:26:08.0398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z5dfRDG7+Ww3/oEDU2dHBjuo/M63icKSFQGiUB3MHkoFdAaO3KkdojLbRN3LzF0JVECWBnn+K07SqrW5kEphA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8982
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 14:26:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16998

Am 09.01.2025 um 12:53 schrieb Martin Jansa:
> Hi,
>
> thanks for looking into this.
>
> With this series applied I've noticed some recipes now showing warnings l=
ike:
> WARNING: enact-dev-native-6.1.3-r0 do_unpack: Please add support for
> the url to npm fetcher:
> https://registry.npmjs.org/string-width/-/string-width-4.2.3.tgz
> WARNING: enact-dev-native-6.1.3-r0 do_unpack: Please add support for
> the url to npm fetcher:
> https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.1.tgz
> WARNING: enact-dev-native-6.1.3-r0 do_unpack: Please add support for
> the url to npm fetcher:
> https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-7.0.0.tgz

Thanks for your test.

I assume the packages are renamed. I have a fix for that in my WIP branch.
https://github.com/weidmueller/poky/commit/ae988d20777d7a542fe18fcbf9511082=
9eef0b4f

> and the same is shown before from do_fetch.
>
> Not sure what's special about these, but I believe it used to work
> with previous npmsw implementation. Any hint what to check?
Could you please check if the entry in the package-lock.json contains a=20
"name" field. It looks like this is an undocumented feature of the=20
package-lock.json.

> On Fri, Dec 20, 2024 at 12:26=E2=80=AFPM Stefan Herbrechtsmeier via
> lists.openembedded.org
> <stefan.herbrechtsmeier-oss=3Dweidmueller.com@lists.openembedded.org>
> wrote:
>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>>
>> The patch series improves the fetcher support for tightly coupled
>> package manager (npm, go and cargo). It adds support for embedded
>> dependency fetcher via a common dependency mixin. The patch series
>> reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
>> fetcher for go.sum and cargo.lock files. The dependency mixin contains
>> two stages. The first stage locates a local specification file or
>> fetches an archive or git repository with a specification file. The
>> second stage resolves the dependency URLs from the specification file
>> and fetches the dependencies.
>>
>> SRC_URI =3D "<type>://npm-shrinkwrap.json"
>> SRC_URI =3D "<type>+http://example.com/ npm-shrinkwrap.json"
>> SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;subdi=
r=3D${BP}"
>> SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"
>>
>> Additionally, the patch series reworks the npm fetcher to work without a
>> npm binary and external package repository. It adds support for a common
>> dependency name and version schema to integrate the dependencies into
>> the SBOM.
>>
>> =3D Background
>> Bitbake has diverse concepts and drawbacks for different tightly coupled
>> package manager. The Python support uses a recipe per dependency and
>> generates common fetcher URLs via a python function. The other languages
>> embed the dependencies inside the recipe. The Node.js support offers a
>> npmsw fetcher which uses a lock file beside the recipe to generates
>> multiple common fetcher URLs on the fly and thereby hides the real
>> download sources. This leads to a single source in the SBOM for example.
>> The Go support contains two parallel implementations. A vendor-based
>> solution with a common fetcher and a go-mod-based solution with a gomod
>> fetcher. The vendor-based solution includes the individual dependencies
>> into the SRC_URI of the recipe and uses a python function to generate
>> common fetcher URLs which additional information for the vendor task.The
>> gomod fetcher uses a proprietary gomod URL. It translates the URL into a
>> common URL and prepares meta data during unpack. The Rust support
>> includes the individual dependencies in the SRC_URI of the recipe and
>> uses proprietary crate URLs. The crate fetcher translates a proprietary
>> URL into a common fetcher URL and prepares meta data during unpack. The
>> recipetool does not support the crate and the gomod fetcher. This leads
>> to missing licenses of the dependencies in the recipe for example
>> librsvg.
>>
>> The steps needed to fetch dependencies for Node.js, Go and Rust are
>> similar:
>> 1. Extract the dependencies from a specification file (name, version,
>>     checksum and URL)
>> 2. Generate proprietary fetcher URIs
>>    a. npm://registry.npmjs.org/;package=3Dglob;version=3D 10.3.15
>>    b. gomod://golang.org/x/net;version=3Dv0.9.0
>>       gomodgit://golang.org/x/net;version=3Dv0.9.0;repo=3Dgo.googlesourc=
e.com/net
>>    c. crate://crates.io/glob/0.3.1
>> 3. Generate wget or git fetcher URIs
>>    a. https://registry.npmjs.org/glob/-/glob-10.3.15.tgz;downloadfilenam=
e=3D=E2=80=A6
>>    b. https://proxy.golang.org/golang.org/x/net/@v/v0.9.0.zip;downloadfi=
lename=3D=E2=80=A6
>>       git://go.googlesource.com/net;protocol=3Dhttps; subdir=3D=E2=80=A6
>>    c. https://crates.io/api/v1/crates/glob/0.3.1/download;downloadfilena=
me=3D=E2=80=A6
>> 4. Unpack
>> 5. Create meta files
>>    a. Update lockfile and create tar.gz archives
>>    b. Create go.mod file
>>       Create info, go.mod file and zip archives
>>    c. Create .cargo-checksum.json files
>>
>> It looks like the recipetool is not widely used and therefore this patch
>> series integrates the dependency resolving into the fetcher. After an
>> agreement on a concept the fetcher could be extended. The fetcher could
>> download the license information per package and a new build task could
>> run the license cruncher from the recipetool.
>>
>> =3D Open questions
>>
>> * Where should we download dependencies?
>> ** Should we use a folder per fetcher (ex. git and npm)?
>> ** Should we use the main folder (ex. crate)?
>> ** Should we translate the name into folder (ex. gomod)?
>> ** Should we integrate the name into the filename (ex. git)?
>> * Where should we unpack the dependencies?
>> ** Should we use a folder inside the parent folder (ex. node_modules)?
>> ** Should we use a fixed folder inside unpackdir
>>     (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
>> * How should we treat archives for package manager caches?
>> ** Should we unpack the archives to support patching (ex. npm)?
>> ** Should we copy the packed archive to avoid unpacking and packaging
>>     (ex. gomod)?
>>
>> This patch series depends on patch series
>> 20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com
>> ("[1/4] tests: fetch: adapt npmsw tests to fixed unpack behavior").
>>
>>
>> Stefan Herbrechtsmeier (21):
>>    tests: fetch: update npmsw tests to new lockfile format
>>    fetch2: npmsw: remove old lockfile format support
>>    tests: fetch: replace [url] with urls for npm
>>    fetch2: do not prefix embedded checksums
>>    fetch2: read checksum from SRC_URI flag for npm
>>    fetch2: introduce common package manager metadata
>>    fetch2: add unpack support for npm archives
>>    utils: add Go mod h1 checksum support
>>    fetch2: add destdir to FetchData
>>    fetch: npm: rework
>>    tests: fetch: adapt style in npm(sw) class
>>    tests: fetch: move npmsw test cases into npmsw test class
>>    tests: fetch: adapt npm test cases
>>    fetch: add dependency mixin
>>    tests: fetch: add test cases for dependency fetcher
>>    fetch: npmsw: migrate to dependency mixin
>>    tests: fetch: adapt npmsw test cases
>>    fetch: add gosum fetcher
>>    tests: fetch: add test cases for gosum
>>    fetch: add cargolock fetcher
>>    tests: fetch: add test cases for cargolock
>>
>>   lib/bb/fetch2/__init__.py   |  35 +-
>>   lib/bb/fetch2/cargolock.py  |  73 +++
>>   lib/bb/fetch2/dependency.py | 167 +++++++
>>   lib/bb/fetch2/gomod.py      |   5 +-
>>   lib/bb/fetch2/gosum.py      |  51 +++
>>   lib/bb/fetch2/npm.py        | 244 +++-------
>>   lib/bb/fetch2/npmsw.py      | 347 ++++----------
>>   lib/bb/tests/fetch.py       | 880 +++++++++++++++++-------------------
>>   lib/bb/utils.py             |  25 +
>>   9 files changed, 916 insertions(+), 911 deletions(-)
>>   create mode 100644 lib/bb/fetch2/cargolock.py
>>   create mode 100644 lib/bb/fetch2/dependency.py
>>   create mode 100644 lib/bb/fetch2/gosum.py
>>
>> --
>> 2.39.5
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#16920): https://lists.openembedded.org/g/bitbake-dev=
el/message/16920
>> Mute This Topic: https://lists.openembedded.org/mt/110212697/3617156
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [marti=
n.jansa@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

