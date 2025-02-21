Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8960CC021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 16:47:45 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.56])
 by mx.groups.io with SMTP id smtpd.web10.27834.1740156455543547438
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 08:47:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=JbESfod5;
 spf=pass (domain: cherry.de, ip: 40.107.22.56, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyKSVBUH4PLX0+HvSwGLLF1DRed6lAiWGCA/NCJDjC0KZ/4ry+QrL836bEcw6JZdNa9A5GUqKkFaagFKIkYOcjv2wt/NnBvSDx8A9ByPpVFN4UbJRuks4wkaxQWPABByGBOMlq6KZqSVEFYDGL5G5ft+eYOttUA7A7F7ovXEJP0mF/nHVCUwtnDVEj35z7xGC8x4XvcCZzVWYooJj5pESNDZDOEDQM/TOIpIt9FvZ2R/hKmYi0heBrA78/pLzUSExwUB5k/PStFJAO8osre/08Le062HZdnAyusAyVd7gSihDqjyH5i3JtZsBUY16L71PonSjmGHVH2zD3YOOVxKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4amkaykW1BAz4ifOergDIoTC30j+A4FYcx4BNOfe1k=;
 b=D4I/VuUn0iR/zf89gate3MYnz4jOPWpcyXngWi6sBf61eVyzbcDD242+bwe3ZDwOQugydvbWlBSm9QaMsWQVre/NyvyQPhYq90xBa4RYxNChFvb8y2/RAycjA7kH9AEibRVvEkUGHzl1OxjYw2TmBjj6hwhClRkocDwp8EWf1fgtM/S06n7OmNylgvII2s5+f8ciqg0gkwIWVK9qR8prQMkurOANN5jE7Vcf905JBgGfJoERQFdwqkP7jHNi0TgfZJXBv7GsarTyrzzjGRQ/N8xOcfMkc3pY4LKpGSAInaQj1ckyclkC/Ks9bNLHLlBlie3hbzxRet4ul6VtfK6GYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4amkaykW1BAz4ifOergDIoTC30j+A4FYcx4BNOfe1k=;
 b=JbESfod56YG7w3KesFnvWeELWMPQ4jDA9P5Xpu7vq2eU//Q+ulz20T75SIDWyBq6Xlyt51zDJLtb4pDD9LWQ6DdSal+FIdxNEHhiXw6GRJWcBXwQMwIVYASGGy8JgFBlrtIqpwVzq4rXMUIIynrNJ32Ovmb92uvBnjtDNgiphn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7568.eurprd04.prod.outlook.com (2603:10a6:102:f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:47:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Fri, 21 Feb 2025
 16:47:30 +0000
Message-ID: <a1d88e3c-9d12-4ac8-8868-b8f97024e80c@cherry.de>
Date: Fri, 21 Feb 2025 17:47:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3 2/4] bitbake-user-manual: Update
 documentation for fast `BB_GIT_SHALLOW`
To: "Koch, Stefan" <stefan-koch@siemens.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "Sudler, Simon" <simon.sudler@siemens.com>,
 "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
 "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
 "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
 <20250220172706.3850722-2-stefan-koch@siemens.com>
 <46ecb25e-9034-4da0-9c20-606dca371ba9@cherry.de>
 <7cc484189ee7db4f27523351993ab454424d0794.camel@siemens.com>
 <22a6cd68-6dd1-49af-878c-fcd7b40e275c@cherry.de>
 <03abd458035cc7a1e4affda62ceccae3b4746ccf.camel@siemens.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <03abd458035cc7a1e4affda62ceccae3b4746ccf.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ae96ae-de58-497f-82d1-08dd52976e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LTZb83p5EYw1pmU+J8VJ6tzhvDIkZuYNfzcaZHPXVIqxzl761oF3vcUCRMeh?=
 =?us-ascii?Q?kFVTnELpKSbyfbsZIq6uvho+isNMsE+KuK7jdKzgKsWwz8VdE0x/0b7HvWUk?=
 =?us-ascii?Q?QWCZPyKafbshxQ83eh1+2WEzqtUjWZ5G6L5x2FzlBdf/7qvSgho+jJCZ5RyQ?=
 =?us-ascii?Q?2cJXMmgSu1voC2ki+O4FHqKeh99NPMz6rLv0955YG14eiK+XOip9Wqh+VpaG?=
 =?us-ascii?Q?wcgwXslmHUPwuDAqnmoNgBnsFsRI8OxQw7bDt1DuAMvW7bYtNxoMWucnAtfp?=
 =?us-ascii?Q?9KBHGP7x/IpRvcvnmJt1mb9JcIkb64DcR3vF011yPAuF9TCwSA7i4EvJlZMq?=
 =?us-ascii?Q?WRqTV2glevPI3ckV1Q0Hzz8ihX5HLarmUxeYhMipcnyNqmH/5988WeW6bSrs?=
 =?us-ascii?Q?8TM1GocAa2nwcKmSFc/2ZI5GBR4emuRKaF0LUYY99hwMXgAyj4E796GAXGOW?=
 =?us-ascii?Q?jaLOa0c/1mb+SsxYOv26AfxAbF+BdWdbt1dKL9muQxMm2INCN3dMcUMnmPUj?=
 =?us-ascii?Q?/k5yzf4F2tJa9BoC7nQ13LejITifkZQcOpMMcettEW3LiD55oQ8GTd/WMYvG?=
 =?us-ascii?Q?dyzw/x3rbEOVav7Ib9GyVyPBCY6ICWTpLIEMqRazD0up+yZht4LyY2eZK1uD?=
 =?us-ascii?Q?14H0PcASmzgxibY1AGuUGeZknmKGy1q0ETRLUmF7T6fPIi6cf3umeXjwc41m?=
 =?us-ascii?Q?5GDSgdpDdCZKr/3YD8qMS9xNQj60NyHfmwnJth41ufyTztK+l5+wQ4gFLjpx?=
 =?us-ascii?Q?2a8Z4h5kPP4xn9Qw61xalh+mE76YT8bO6olWpeodq6yzmz4rh0AsvGa9Rjoz?=
 =?us-ascii?Q?ylbd+j6WyUCHpX/JswC6zkiltss2vsljQ6ir4BxJoeLI0Q7WulFChHfAOkUp?=
 =?us-ascii?Q?rmzg0j76yPOFz771i/rg0WN+Xo5bXXwOJe0GhdETY6PrDPIxNyMlZviZDgF8?=
 =?us-ascii?Q?G+TqWrVeYPhw/nhC2YFbpzyqBi5wzUkzVBTKAucw5UM7WWou5PX75PPDmB/P?=
 =?us-ascii?Q?nMOmffT0mFoSkpdqlmvV+DzQEmqXm//3sqcZt0hEIbLnA6BVbhqGaToswJgb?=
 =?us-ascii?Q?tO8E7hkiMfZFV9EabE1rqyH+3EOAVLX6fomZ0A2sNnPVV+NkMHVTQkQKFNAa?=
 =?us-ascii?Q?uWCHdGFrGJvptIEsMsLgywphprCET0rJg7T9P/EGKjySyRom2nvNzN/afK48?=
 =?us-ascii?Q?a+vB+LogeF/QhvY94AXoPOfy+Ka+iZQVCagtlhcTczHZgkucXn1146jmdIvP?=
 =?us-ascii?Q?1WIuzqqV8eUS4t7TiPDgEhzp4JUVVkasD6rwq00tTZV4OCHICfN3u5EHc2D/?=
 =?us-ascii?Q?kKgcMkpOZrLdlcAAjbawf0Pan3V5w5KCq+UwupMdRu+7oetzdMTOPeVs1eDL?=
 =?us-ascii?Q?pfQj7xpXGk4HaSf1VTVfHrG/Wwhz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mUAQfrI5N4hJa6xJXGe+uX6iqpkROtgjeCijfH6nIf6mWVKPUrrqZkKAFaNA?=
 =?us-ascii?Q?futsPHUboS+7/+8tNFFQJIKgd0joLIdjRxVTGBrzrCuxjSLmvSICZ6oePZaL?=
 =?us-ascii?Q?2V/5pli3qok3SJs7FMGwqlOaRaGPXbf59zdxk0Dh7RIFEiu0+yuLTW0kH7KH?=
 =?us-ascii?Q?qeSXnzlcCtz06G1aNs44IOO7xAI6sIElohyYGOLwCxQKsSbL2mTIw1lis1nD?=
 =?us-ascii?Q?yxvjv0QQ2rFjPapGm/f3V28Axi1z34xoI7i+2eUUjV5Rn95eP+qrFKh4vLYt?=
 =?us-ascii?Q?g/lrCYKA2HRAxeZgN35dmRjNLof8/miDF9i0EjaRjnhhnFoTOAq3CV2g3AjH?=
 =?us-ascii?Q?FTMYDqTnlYvmUwLhlpintPOV99bq2f/pSkcbhR1/pjSHN2cQiXWmgDsdvnIC?=
 =?us-ascii?Q?LyDnrw3KTfUBqfv1aTwc/SDb4CHlWRrpikwUqH3uH5Ksq/ST6LPFX5JOZi8A?=
 =?us-ascii?Q?6GIqs+0J/LGdyZ1KrQEKxliHGLHv2DtCPven+WiT14WOOhAbPba3pafMhncR?=
 =?us-ascii?Q?W2KZHIMwoZK3zv//gFdHFurTPcPp9DE8Tt15WjJVhpy5459H4Qmc5ZztV6ut?=
 =?us-ascii?Q?Xn8TeKXl4AuAQGsRFhIJzSfcHc22zWr8eCMVirKzhfNDSyHb3Cx1za5TP5V5?=
 =?us-ascii?Q?ilqy5adiIu2Yzw6kVHQrYFlooh6evzIM096uJD0amFKn+UgK6gmSvYr0vgm/?=
 =?us-ascii?Q?8DIMvO/Zp1E1XKhfUTcWoDWRUIaAeDcGWDn6zaHr5GOfjQ5qFX1O4aTaZ51g?=
 =?us-ascii?Q?ly47tj0HdpT3dY3yTF8L2+UMvWv9NZCjLYyHa7KMrlb61GZRGxKhZquKtD/5?=
 =?us-ascii?Q?BUbk9C2F+yZO6UNRDV0nAnN4cUPV/K4ESXeaj/YXckghqIgmO8U6MnM9rKG/?=
 =?us-ascii?Q?lt9U1LAcr/V5NIwjXsh2CBYuXwO72xE0if+055ODSxQlwbwlBFp1hTimi7c5?=
 =?us-ascii?Q?M2w71KAKP3+tCvSknsiSWLsTv7kVDrA3xlG2VzEFHaPVqqadZk3mBp63Pvov?=
 =?us-ascii?Q?fIa5rEcOHhtEYJIYmVLd8P0qGxukp5OAf2Gi9PcOWEvaSwx/hTKfvZ3h/+Nb?=
 =?us-ascii?Q?YXwHKPEdVf1M8Wj+AlVe2MAF78QPgoyAqEnyWT6Pc2lwGMjXV+jLBUNqfHpp?=
 =?us-ascii?Q?yfKMcR8esMDTpy72wdwWCq7c1anhHkoanNjwEpccRe+I+JcUCD/xXKezLKTB?=
 =?us-ascii?Q?GxfuQ1yWobA/0oUZs0vba6UwmoZDHWLLgSPJw96+OD7ZGbj362PxfiEbG/ac?=
 =?us-ascii?Q?an6fJlBdOMoXdjw27TnBp6qMhgGjt2H38HCkTz6Fvqc6O+AZvmhhFG+Lc1Yg?=
 =?us-ascii?Q?C1X9hjJ3dCeTkTNAdtLWXPCURVXWzzuKYDDn9ChX6ppAAXvPIJF5NmGyn6nL?=
 =?us-ascii?Q?PCUjjsW3KljvaLBkfbp6ZC+jBq6fRD2uQHBGQBZZiwbQrF4cuxCxBWLeeisu?=
 =?us-ascii?Q?ZYMCKJj5Xty17snmVtWv4K5tp9qZ/0o55akncjK6Gc3/MePQsP/52/G9Gcpc?=
 =?us-ascii?Q?GGR2tuKEoFa2oe8T/7GIJB3fbGtaummHK11JLxVewqqux8m7nl8MMjqSyW5W?=
 =?us-ascii?Q?Hk9ZolS4JtHHEDpPGtXnkOAOdY4jFTxb+r8XyNYHoDNvbSfw9kAjCjaS+lTZ?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ae96ae-de58-497f-82d1-08dd52976e9c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:47:30.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbHg1u5hSpZ34xirYTPyueez/46fM/bgH0VY22/34RqEcBJF5Mx84pTVk/eqU7xJeMzCg4csZWztdahOIwMnsO7jRiU2xPfqdXJhdhyZGIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7568
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 16:47:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17282

On 2/21/25 5:35 PM, Koch, Stefan wrote:
> On Fri, 2025-02-21 at 17:31 +0100, Quentin Schulz wrote:
>> Hi Stefan,
>>
>> On 2/21/25 5:23 PM, Koch, Stefan wrote:
>>> On Fri, 2025-02-21 at 11:52 +0100, Quentin Schulz wrote:
>>>> Hi Stefan,
>>>>
>>>> Please Cc the docs mailing list as well
>>>>
>>>> +Cc docs
>>> Thanks. I'll send updated docs in v4 patch series.
>>>>
>>>> On 2/20/25 6:27 PM, Koch, Stefan via lists.openembedded.org
>>>> wrote:
>>>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>>>> ---
>>>>>  =C2=A0=C2=A0 .../bitbake-user-manual-ref-variables.rst=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16
>>>>> +++++++++++-----
>>>>>  =C2=A0=C2=A0 1 file changed, 11 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-
>>>>> variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-
>>>>> ref-
>>>>> variables.rst
>>>>> index ad219b531..f781c004e 100644
>>>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-
>>>>> variables.rst
>>>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-
>>>>> variables.rst
>>>>> @@ -315,11 +315,17 @@ overview of their function and contents.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mirror tarball. If =
the shallow mirror tarball cannot
>>>>> be
>>>>> fetched, it will
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try to fetch the fu=
ll mirror tarball and use that.
>>>>>    =20
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When a mirror tarball is not availabl=
e, a full git clone
>>>>> will be performed
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regardless of whether this variable i=
s set or not.
>>>>> Support
>>>>> for shallow
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clones is not currently implemented a=
s git does not
>>>>> directly
>>>>> support
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shallow cloning a particular git comm=
it hash (it only
>>>>> supports cloning
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from a tag or branch reference).
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This setting causes an initial shallo=
w clone instead of
>>>>> an
>>>>> initial full bare clone.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The amount of data transferred during=
 the initial clone
>>>>> will
>>>>> be significantly reduced.
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For updates, when keeping the cache w=
ithin the download
>>>>> directory,
>>>>
>>>> I guess by "updates" you mean pointing to a different commit hash
>>>> to
>>>> fetch from the remote?
>>> Every time when the SRCREV changes
>>
>> I can then suggest:
>>
>> When keeping the cache within the download directory, a change to
>> :term:`SRCREV` may induce a significantly higher data transfer
>> because
>> entirely new shallow clones are required.
>>
>>>>
>>>> Is there a possible setup where the cache is not within the
>>>> download
>>>> directory? Not sure to understand the implications here?
>>> Regardless of cleaning the cache the effect is the same.
>>> When not using shallow and have a cache, the delta downloads for
>>> SRCREV
>>> change are smaller.
>>
>> OK, I think I see what you mean here. Does "cache" for you mean the
>> git
>> repo for the recipe in DL_DIR?
>>
>> I think the point you're trying to make is:
>>
>> If DL_DIR is persistent between builds, using shallow clones may
>> induce
>> significantly higher data transfer than when using bare clones,
>> because
>> entirely new shallow clones are required whereas bare clones may
>> simply
>> be updated.
>>
>> Did I get that right? I'm being careful about the use of "cache" here
>> because we already have sstate-cache, hashserv that does operate like
>> some kind of caching, bitbake parsing cache, etc...
>=20
> That was what I have prepared for now:
>=20
> This setting causes an initial shallow clone instead of an initial full
> bare clone.
> The amount of data transferred during the initial clone will be
> significantly reduced.
>=20
> However, every time the source revision changes, regardless of
> whether the cache within the download directory is cleaned up or not,

Would suggest:

regardless of the cache within the download directory having been=20
cleaned up or not

But nothing blocking :)

> the data transfer may be significantly higher because entirely new
> shallow clones are required for each source revision change.
> Over time, numerous shallow clones may cumulatively transfer
> the same amount of data as an initial full bare clone.
> This is especially the case with very large repositories.
>=20
> Existing initial full bare clones, created without this setting,
> will still be utilized.
>=20

This new wording is clear to me, thanks!

Cheers,
Quentin

