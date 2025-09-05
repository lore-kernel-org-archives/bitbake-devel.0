Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C726CA1010
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 07:02:05 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.133])
 by mx.groups.io with SMTP id smtpd.web11.15397.1757055723706931356
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Sep 2025 00:02:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=oVycMwSb;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.133, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+W26ALlYLEgLogatK4u0lDcRCseKkKsvhyyky38gjMUT+qAiqpKwuHR89Go5qpIW328iGYfN0IGQf0mYybbFw4zhouQxmhXOHHJCZAP4P+cIluaifBtmX1AvRjt4h+pw4YshQ80MC9fTcSzO9a+UzXKVQAPYn1uStWjSts+GZdNyjQjjRQoV74H3g837GjC+2h3cCKqt95lImZZQkmHxpKA343ksJcZEc1kpQFFolNQ3MkKcByIw+66+ES5Nt69c10Ysyu6Tf/mI6CJcPu4m53Trox+ixhK7pI7GaECh1gCYNymBx84Nzrwnc7iUSvUerrwGvttDEU1VzM2dp9RQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9RYfJhl9DZjJBNq57U4cD/Olz+J2cR6bM5CbAKAZEw=;
 b=C4YCKmB4vjQzvJHi9MEmHpRjQv7a5z+PmSfUspRNqs+d+LS8C+L7PpiViOl8iEItDWizemeFqjbjpkNEl7JxCDNDs+f90Egi5jZ431Cgxv64n24hWTgP7LFbELyZeqo9x83HF0qVmxU2rnEF6uuK+CbhgGb9sQG700U3vL3Bb69LdIIAwd92c3DijN+cBjnNSjqAC4yUnodUJPnRkgac7H+t4qgPhhpzYrlsdYHeLvXPlX5u4CSeE7NfVTUFxhpWBeV0zm4kwiqc/VwstrgMw2aoeBI79Oqd73lcLbStURFuKKSypfG21Hq1q1zd+9Kd0b7TppYBnFHKkhioznGHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9RYfJhl9DZjJBNq57U4cD/Olz+J2cR6bM5CbAKAZEw=;
 b=oVycMwSb4hjrBelQ6SrZuoWDEKl4fAz5Mn1WxOq0ggcyRgy00PwSCYyiJSodtjbIs6U6/twnGsdQQgwdTmnfkuG9vtMgma5zl04z5nZll1UBAoTmUFrDAb9LQVzvKf9+jhEK6L95IhRFkLXkNfIucU8J/P52cTPA8deof2htZv2E4befZ9UvMc+w/6Bfjz7R7y8iyVkRQWtOQtKmQ2G16Uh4+XzBZUVJt+A7hSL4jKuvYaJfYfu6icR0+E8JcJDywemaQjW0BKrbec2yfs13lfWXRLY3wqohn1W5TX5CpeRVq7t9TZ85Ib7YayME9euScVe8GN5W9BqCdfJNetlkkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AM9PR08MB6722.eurprd08.prod.outlook.com (2603:10a6:20b:302::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 07:02:00 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 07:01:59 +0000
Message-ID: <5c599f32-e9b1-4fec-8c14-ce7fa28bd1f1@weidmueller.com>
Date: Fri, 5 Sep 2025 09:01:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 0/6] fetch2: add support for implicit
 urls
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <DCJSCC879XGB.27MF8X0RDL3@bootlin.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <DCJSCC879XGB.27MF8X0RDL3@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::12) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AM9PR08MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: caf27a0b-bfc8-4b42-c824-08ddec4a1bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OnVuvX7L+rkjvoO0vO4KaNZLoCvx8/0USNbGubDavjXsGGsQWU5xqoQnxdrE?=
 =?us-ascii?Q?VPKdd0yXOqin+9AtGO79WCoHNmuSNVf1/lPlc8CCVfnf4P/NIupDcpe3/jkc?=
 =?us-ascii?Q?wiL51uuExRUsWmCC8zS7ZPG3jbQfYeB8l+8tialE8W4g4HCB2zfYHeauARNC?=
 =?us-ascii?Q?slwwz6oTxrwfAFTP4OrS9YnZxksu7qDVvxnVJr4BIdw3rnOZD2Zza8zjZbyt?=
 =?us-ascii?Q?SIHtm6yQnMqAT4PUFavwCqnhCwoCo5qguEw7kbLS6REjMeDkPIPuVtcQUHHx?=
 =?us-ascii?Q?wB7dMjpu8HSyJ45RJZLdgGll4B7C0qQBd9BI8f0Wn8q3B12jegPVJZ1205WX?=
 =?us-ascii?Q?rytSTdR/wzVPtD2KWaA+jWvz11m2W/OQURJj/bAZp/VmKadHEE9QbD1fdSYA?=
 =?us-ascii?Q?OHlK64U2oEFss/wTipDD/Zy61fXtz9WF7FlASmwGbAdf+vhndauJ9JBMgW5a?=
 =?us-ascii?Q?ZklcBs3Pjp/Y3Cafe9fUuZ/QdstI0RP9FEr3vLQYCvYWhaTZWD1kpGHwdAJL?=
 =?us-ascii?Q?b9jJB4AskuqcNBp4ex7zeFgCdNS1mgaz9lV2wPNYEjpsHpLVQ4EBSOWl+zPK?=
 =?us-ascii?Q?TgvYphwzSBtneQZtuABIxShBlJ2l6UUykQf0sohJCGDl8gFpsgNkDqYt57QJ?=
 =?us-ascii?Q?zNg9A7k9HzWhwgYDwdLg2od5nQk5Q01/WudGjyJm+r23BuAReYGPzbtZeTf1?=
 =?us-ascii?Q?ehG4StS5qPw70zWuDDA+v8QgQabXKQmF3aTp3jEMfNDq8jkWzkeirEeO4gKe?=
 =?us-ascii?Q?jWYKUNSmArnrtkbVMnpehcTQBxhJzcB6zai2CBOAxfOTY9CaMyJz7Bn8RcuT?=
 =?us-ascii?Q?THCwr4Hfwkgng3ygx9AaJrADqBPUFmgytZfc8+1LE385HyqaWKo1wk0rClOT?=
 =?us-ascii?Q?Bw9IO0V7hDbMWqB7A5UTECY8jfhZ9y6V7BbarxoJPIa9UVMDIXs2SgghLy3R?=
 =?us-ascii?Q?x5PdMINpBs9Xj1g1g4KqG4cJiqoA5JYLg0KuYglXZJSb+e1qUyCdes7AbvSr?=
 =?us-ascii?Q?FXfQc7EU8ChYHsdUfGKZga173Ab4X3rkQipK5T9S/f3DRtmLnXorzfwmY8pA?=
 =?us-ascii?Q?XKBFzYCDJLWBQSVEahF8QHgxpkzAuKmqlJJu0hUjYCbKTeKj/By442oN8O7D?=
 =?us-ascii?Q?XUbWa9UsgEXfhDPG0MHVGrtBmxwYt2xiufcAHcciL/h0t/gkg8pBO1lR6sD0?=
 =?us-ascii?Q?1qmCVuzz7JR87VPXPCHWT0nqJg06RU93gFcI3QtykfsdVbbA5IMWJ1Q0UZ5S?=
 =?us-ascii?Q?kZdNgR3cAFNOltrklcODhhBur5+hOPpQM3UqO8FwWTkB5rdwCCJQX/R5Gt3b?=
 =?us-ascii?Q?fH26jl/TvnYHPt2dascjcJhxhOJAyYfm0daZUi0Q12qzwdLq+cJfOj5Ikgdg?=
 =?us-ascii?Q?2n4chOimSabQ1RLyZ+y/jkemwhdCW/QaU1MTlV72K8rSvxYK/kA0/JGj2HhS?=
 =?us-ascii?Q?E+iVDgS9pXY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VIu5DtH1uXYeTfKBwq+35uXUwYYZ3ALejv9mIO176aVF3sWzPr6pHH+xSK6U?=
 =?us-ascii?Q?H+DzsfQM3kx1V19lAtPHi66MpQ+VavBSg4QF5pv2Fo1RfMv4iyDYDYNrNC2c?=
 =?us-ascii?Q?ZkuEAIPUR49v/+wZXr7jxUVH/dwrru7KNGZo5fiZjxX+rnydxNqUbbZNaE1D?=
 =?us-ascii?Q?vlk6WI8ACK9o1/6pIWrZJf/xEi+huMSYE8S9+zeZ6SSUHNQv+NY9al9Ax8qk?=
 =?us-ascii?Q?AA/H/ZsveU1wxRBTvLI/+hDOeh/oo/KRhU26oksTNqdyESsNFbexw69v7W0i?=
 =?us-ascii?Q?IdiLno6cQHIulMHh5sBADKUZNqk2BK1qHtnB5DafKkCIq6WYZJT+M6Sgu1BE?=
 =?us-ascii?Q?SEcq1eJxxZfVQY5rIIwt+OfJ+O6hIGj4z74QzEOKsvAlXBCroxeukS6mdY63?=
 =?us-ascii?Q?T/TswYZ0KssioLkwInbN1Cv6agGTbNGJSZPJUwT90FKMxQpmcI1yEK8++mlM?=
 =?us-ascii?Q?0o7j0ayXEL3Rl3IHBodGM17m5isKXnehgx4f9GjkqNXLL8s62TRvwZnZan7L?=
 =?us-ascii?Q?R4B+dLhT2K6l4t0D/RF0WBcSmMK+s9Cx9DyFpH9LlNH3m3YdxKtqUWvpwunG?=
 =?us-ascii?Q?w544WA/OME37t338cjyMrBpfgd/qdB35gVp4P5AfzxYR3d8CKv2ZojQ9p5te?=
 =?us-ascii?Q?OpA/Z7h1v9Wp2rKsu/whReHGqwF7vjfx0FyYJj8budK+C75LUdzziyZ095Q0?=
 =?us-ascii?Q?lkeR4gviSaYh7Dmd5nW84KYKTtTjBCj+X78MxiLrfiqqFTCKkJHBN9x5QUl7?=
 =?us-ascii?Q?f2Kwk2/73Fvr987wfWNosPv5jOCzEWKRO72Ly5e2w7w2iOe0lhElne61Zx9C?=
 =?us-ascii?Q?HsuWAmuFwbd3P+p2m33J8lxU+JsrQErRJh8DQqaWMyWaj4Md9RRDKynB9bNZ?=
 =?us-ascii?Q?49iwCuvLKcdKrTljIfJeId5blf9DdATvZFoQ4/NvvMnOhb0yd072Swt6+d5x?=
 =?us-ascii?Q?QjvQdOi7IFab6+rA4ZpNl/bSPViKdE7bkr5q6cClto0QX3v42aMgmZfKlCek?=
 =?us-ascii?Q?FwO0PQE+KfCHy+2WflEDVbURvSWHr2HRWsNKZuyuXou7z9aMlS5lwz+F6LHq?=
 =?us-ascii?Q?5d9dkpcmE8BNkPV7nvhX6mnQ9nFg2lci2lAx7Wwi9JUkPiefBKzyKxM1/Sc0?=
 =?us-ascii?Q?rK10mll2lMFw/kRvu48CfCITGkTogkE2Id17vzGFtxpOW11/RDm0/dF2mHEG?=
 =?us-ascii?Q?iYDvN1RPgD7hM0SMBpGOUYO7I6AOvDK1ZcJIPUjb+MpUImQWziharKnr7PMp?=
 =?us-ascii?Q?Gwp3uHbdm5QBby399wEMskBELMWnQjFbCVCpixAHV+XUICZ19Ogx2X6eVUKy?=
 =?us-ascii?Q?19x/Zxt1t7RrAvaIV7qEyBvV4E1UsHC3nfxb7UW/2ExbnPaMo7x30jdnl2wn?=
 =?us-ascii?Q?Lf/u7tTYDPTkj90LCYFVwpZxxLYm2MvJFjFqNHyYeGNaiWq4sa5U42lGW4rN?=
 =?us-ascii?Q?MwK1FTVPcKpJvQEja9UKKzKD4LS2cNfdCUqsSsOafvT6zaKFllAGHsQIXMLc?=
 =?us-ascii?Q?AsbjsajpgnOj6Cb6mI8Vckr7u/Zt4EZFlthBzd8hgoW+3gKDQI+WEm7ZRYg+?=
 =?us-ascii?Q?Li7LIO+np9CAc20bka6KBMbDF0cY2PH6nD9lVYgpMkGc54ahaGyijT/owQ6L?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf27a0b-bfc8-4b42-c824-08ddec4a1bb0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:01:59.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjcvuJgGrJT80xPIlyGQ8lded3phogNRbRvFYQRhuDqbG+F0Z9J1J+EyKapRdycsNod+Pt52LTLBdMLrOrhwcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6722
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 07:02:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17981

Am 04.09.2025 um 08:00 schrieb Mathieu Dubois-Briand:
> On Tue Sep 2, 2025 at 8:55 AM CEST, Stefan Herbrechtsmeier via lists.open=
embedded.org wrote:
>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>>
>> The patch series add support for implicit URLs inside the fetcher. The
>> implicit URLs could be defined inside a source like a version control
>> system (git submodule) or a lock file (package-lock.json, cargo.lock or
>> go.sum). The integration of implicit URLs beside explicit URLs
>> simplifies the fetcher classes and avoid bugs because of iterations
>> between the Fetch and FetchMethod classes.
>>
>> The series remove most methods inside the gitsm fetcher and only leaves
>> the parsing of the git submodules and the unpack functionality. It
>> allows the gitsm fetcher to use the premirror only feature. The current
>> implementation leads to problems because the download of the git
>> submodules is triggered via the download method which is called deeply
>> inside the fetcher code.
>>
>>
>> Stefan Herbrechtsmeier (6):
>>    fetch2: rename u to url in Fetch class
>>    fetch2: call functions within loops of Fetch class
>>    fetch2: add helper to get urldata in Fetch class
>>    fetch2: add support for implicit urls
>>    fetch2: gitsm: use implicit urls feature
>>    tests: fetch: add test case for gitsm implicit local paths
>>
>>   lib/bb/fetch2/__init__.py | 128 +++++++++++++++++++++++++++-----------
>>   lib/bb/fetch2/gitsm.py    |  46 ++------------
>>   lib/bb/tests/fetch.py     |  12 ++++
>>   3 files changed, 109 insertions(+), 77 deletions(-)
> I know it is just an RFC so far, but I did launch a build on the
> autobuilder. It was mostly correct but fails a selftest:
>
> ERROR: git-submodule-test-1.0-r0 do_ar_mirror: Error executing a python f=
unction in exec_func_python() autogenerated:
> ...
> File: '/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/b=
b/fetch2/__init__.py', lineno: 2102, function: expand_urldata
> ...
> Exception: UnboundLocalError: cannot access local variable 'urldata' wher=
e it is not associated with a value
> ...
> 2025-09-03 06:21:46,098 - oe-selftest - INFO - archiver.Archiver.test_arc=
hiver_mode_mirror_gitsm (subunit.RemotedTestCase)
> 2025-09-03 06:21:46,099 - oe-selftest - INFO -  ... FAIL
>
> And a similar error with
> archiver.Archiver.test_archiver_mode_mirror_gitsm_shallow.

I've fixed the issue and added a BitBake test case. Perhaps you could=20
test the second version of the two patch series.

Regards
 =C2=A0 Stefan


