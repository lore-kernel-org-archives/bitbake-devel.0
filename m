Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50105C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:48:51 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.43])
 by mx.groups.io with SMTP id smtpd.web11.75339.1752490120933340932
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Jul 2025 03:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=KUnJbYjT;
 spf=pass (domain: cherry.de, ip: 52.101.70.43, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbwGuPPix5vTLTx2a2tG9srhUr/Hb+Zoehq0nX4awboEJcjNFsCv3laJjiknSQdy0RGL4u3GgmCOxjTkFUZlJJdTNnbYR4K//blJcAfKQKD0i8k+TIEXVL60CqeNOxFE4A21l3PCTS+zyYMq0xzzUTK1iZ4x24BgoT/m+t7AHXXyHlM82G/6BY0AnK/d0WNF6uEjxWO4lIW1UlA6DWxFHSuB2Vj/eBx9VFvLxrSYDwfDZYDhoA3Y5nz3YIyPwnGPY1wEpSpWka11nL+RTvc6rbVvCyi+MXuL+lEHClYfzotvDkEZvcHaibONadBiZ0cIqWEMBt905j1BlWAmJQ0XIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPX0kOAc9VJI/njLMg5Pyor1zc1fpBxtiwbUlUjHUjs=;
 b=mYPRstmdll0CwgpocyvrefdYGqMa2ZkaBHTQjbui3GyUm4tN0JxsRNVkLVpbwXsaJsKPZxlVM7sB5lFKc9QhQsV4d82yzGaX0bycuWyRtAlPnOnCp5APx83DWwbc80sV6Ur2bkX+zuoJlCkAS3KvMkKOPM9K6GJYoSJXs6xdAjFWT0BUHIA6fihdDOMUFiKYPgfTuGJ9jyRoVu+8xSIXqr9Y77ZHVebDwjJG15RJOle/3s7B3otDAXhESIoAcXFa2Py3u/nPivrxcJTfyzuDNVItZrWjzTTaNu7zF7d4L0uV7jpucfzcRHU1wwkY+/E1UNdbLghAFalVSoWpTqCtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPX0kOAc9VJI/njLMg5Pyor1zc1fpBxtiwbUlUjHUjs=;
 b=KUnJbYjTGNhh+/cv4XYASl++NzcFc1S3htfzwI4VdJGCggZjr3sxwoE+3lUaVkeoxLigKAUE80ygy2tz9tWXWcRjAxc7vlzqoO1aRDQ6KmpjPCOZSqFQGYl9yVhXBnkKphQ32+Ey1CgASdPg0tjW5ZyH284elFHxr/dlJ2MR1cM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 10:48:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:48:34 +0000
Message-ID: <916aac3c-04d7-4abc-b0fd-5bf2666fc87a@cherry.de>
Date: Mon, 14 Jul 2025 12:48:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] runqueue: show the current pressure as
 debug messages
To: antonin.godard@bootlin.com,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250701-pressure-messages-v1-1-bebffe123676@bootlin.com>
 <e0ec39370f30659958447e6a5def8d88d3dc4649.camel@linuxfoundation.org>
 <DB1CPMFTBKOK.1B0C9LPTCQK1B@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DB1CPMFTBKOK.1B0C9LPTCQK1B@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR07CA0239.eurprd07.prod.outlook.com
 (2603:10a6:802:58::42) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: da00ed85-00fc-4533-a2de-08ddc2c3fb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b90Ou1AEuAh62c7n0eZwYKdUS1sXwD4Wibt/swj+IXKZ3+yPl+3s4rWWUG5w?=
 =?us-ascii?Q?gIQI+y6JxeOZDWWG1SKEkSRFLqdyr1Cchfc3RUEMxrJ+MIs74T2CJ0tKf9W8?=
 =?us-ascii?Q?crrsPcss5FobrQQxB6jL72qWUTq0cimvO2P3YlZz4zmFVhrFdGCgAaYU4k5V?=
 =?us-ascii?Q?JyWI2Qvt1amV0SnLGTY9SJNwisfwvu6epDO0HoW1wt7Dr9S4zMzfGtSovyT2?=
 =?us-ascii?Q?hWxxWzWS5rTxlHM3/SI+U0rHh3i5vC/HFHPj/dG6lxMwDFJ0ddBWbnVXsA68?=
 =?us-ascii?Q?3Vp2grhLtJFRWNNdNZvSpKnJ85ddqwkuJfODy1tkS1J2nRcDeyK43/gjVToi?=
 =?us-ascii?Q?lhqn6OpV7nBFm9u7bGrilpI/2w42BjGzAfvDs6swTvbRiClWLyk9om3CSZfo?=
 =?us-ascii?Q?ZcQasNMQrk44rou4iPsZWBcLIHbfvvQ0v1gIMfZYQ5B1AX9aoNihYIYRKk/i?=
 =?us-ascii?Q?QFPlj4g2g0OXpE/cdAKKnNbFJ+QLbziHC+nhPVjNUWGOYBZM/TFEVof86rrS?=
 =?us-ascii?Q?Ga76BYC8OUHHYkuiNFHYsZLZfia+5d+Fltr3ISBSuMU9PoLt5/mFX6wfCJy5?=
 =?us-ascii?Q?K/MDgGc6zE8rBW+pYe4wikaD77HT+92zNzBNBFoluHcrPXeaxYcuYpNj+FdO?=
 =?us-ascii?Q?bMfy4Kbz6NV4HsN7I3soZPQ1e8gcQCpbYk4a74NAXhJNDm2++LVcZB30uNgS?=
 =?us-ascii?Q?JDue/cQZLrWProQITwfCS1UFhjXnWepg/8QlPS92Cz4iVaKqiRQZIUThOlyc?=
 =?us-ascii?Q?5HRwWmjE+neSTsYbs1qd1MKT7HMfXL2thoYosUpzIWzP2Jaam+OKs2vQTsYr?=
 =?us-ascii?Q?k7Mu/HqoxFOelAXUZgW7NYU29lhaBKUw9Z30Pmz3zxIwst01y9rneaIKEzJD?=
 =?us-ascii?Q?yntlZS6W5lyzOnPWAV4BpAYfCmcKiDyaeBJ6XzgqoB4v+okQ8Ih+pmKR9tkh?=
 =?us-ascii?Q?HJ9AfCfsPr5ubP8kd8YnoMFkIiXfiH5D9h1o96HqYgOjoQNtdtSNP0Sw1Uxz?=
 =?us-ascii?Q?dAh9HXOP3I/y4aPbm3zvV/aWjn9NUMQvPs3JAwMwe3VAVrs48aRn/fxMdVvP?=
 =?us-ascii?Q?dBoCrnFpF4XybK3eu9SlESrKRbZmbkYQeo0xSicEXRIEEF1u74ACUAehazUc?=
 =?us-ascii?Q?GAGUFrMZAUimfMRam3EXsjnnl+hh6JC+1/NBKRSCv0yCzxl9IdZOrjl3C4lc?=
 =?us-ascii?Q?vMMkrqbfeFmvJD82aXZcgKs5NAdshkhoG2yEl7D+baXKuWDnTKaBB3fRPneX?=
 =?us-ascii?Q?BwymdQyCF4Uf/+RY86QluCc9mMDmKbYC7mtmsWOKXlu1lGwBBHT0S6HX0F9l?=
 =?us-ascii?Q?9bBgSK5Ert2egiKsGAeDQi+sK/rKWiFnfCh0LdpXO9j2JOtBzZHaB5l34Qu4?=
 =?us-ascii?Q?kxtZBQuSc7QBvVTkh1fgXtGLDIJ8yb0IDvAAYRvZH0zPHF1gW75jyq2mRdg6?=
 =?us-ascii?Q?N0PmF4yOvgc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yaeN1+lrQ59z8ODu1TZamY+qjOUfktB9DTDFTe/3I6gEracj2nIN/e4PpBJP?=
 =?us-ascii?Q?Uxj3Wf1qkRHJ5J5KTYFGhJiPsaN0EE0q1j/A8q1HPwWG6ZHpo8YE8sGGEVxH?=
 =?us-ascii?Q?dHYIXl9uEb/onBgDC1v6eZj3GTL1BlTk86zXU9l30zt9wp2ZBP9E63Zofg4y?=
 =?us-ascii?Q?Mrl1cL+wa2p5wzkzzIe8r3+y34Q/lv4UyvK7hMhg3rsPBgzQjbbuw8pVe4aG?=
 =?us-ascii?Q?v8l4tai9th/ONyDSxFhsiyb7O09J/1eI8V7/oHNbPKmL2TnE/p1RK34Z4eEv?=
 =?us-ascii?Q?2g12xgmB5CLoAgsuex60pOA8vudIKn59Vx37zOSyZ81pq0nBr6KeTyTEPpZ6?=
 =?us-ascii?Q?oaevrmmxVaDavwBQNKXz+OM+ykRYxNbBOKZn1NoLcgUxH05C3vOxX0KMjJ1t?=
 =?us-ascii?Q?4GDjt+/+vxkc3LqcgIRrR4Nye23mMqAaMOiFU61achfNtB25NyHowopcLRXP?=
 =?us-ascii?Q?tEYbD07NfqZP+5X1tu+QeEIZU0PJMfY5RHLCuaewSb7cTmjcBxKJoZMGM836?=
 =?us-ascii?Q?JmR80LIXWXERQzDitO8WcW9SkOw4aNLYY1OYnTPMTBC8rm8wDIPKgMtYjxSG?=
 =?us-ascii?Q?UC8UFHoVjRRbhmpXT3RZyXU5WRO4tEnW6nuXch0UFS4g7e5iDKgUr5QLdq0q?=
 =?us-ascii?Q?fqY5UowFmPG2SN9CDmUW4lLwvNfB27/fGoCGKMlrSDHUI7WXqHL/gorxbQmN?=
 =?us-ascii?Q?6x5JG1pvuQv3jC6qH+fDI/OMPElCGV1QZV6OzPriT9f2qmKC+BBICoIXDVLQ?=
 =?us-ascii?Q?qutbD0ryHKjl4m6Y7ydMkk3EgrzcR4EMrZR9I86TB+mdIs931XqermCQphiz?=
 =?us-ascii?Q?0HEtJJmeUW0aNDek8wC8t+AmeCCSAMVegC8zZ8eWqCa5hnPNgfxlja3OX24V?=
 =?us-ascii?Q?X9//4lTvPgcKd63UmV9suxgJOqkZj9ROc2hVRZHvn2clUOitvB9x4segZN60?=
 =?us-ascii?Q?o22CG9Dzif/1uduY7MlaTRuzs4LL+tEkk0ygEygBARX1UjHiU3v06nD4zvpG?=
 =?us-ascii?Q?4AfM3+NlBshur2riVGi3548SUQ4bxSTpyCRZ/QLhRO78YKiddjvs9t1zRdcE?=
 =?us-ascii?Q?QxXVd20cFZSm4BHGqOEKMf8klemKSS2a8qxeAOBnKXFgBw9Z1BrjKdDXAUZU?=
 =?us-ascii?Q?xU/5ar5wiMTd//TfgLAeSdNqV65W50IB93z/KMKbeuLtdx8b12I6v+OtWl/c?=
 =?us-ascii?Q?pN8gRrFIaG+3a8rl1kX9DFcJj84ia91j/egZrxoOKjFf8TPVLmKOIF4Wkd+7?=
 =?us-ascii?Q?XXEoiH5VmE8xz+NT9/FII/0ToIAYoJEMoNknjZEGafubtrFw2zO1rNxBj/0j?=
 =?us-ascii?Q?5Y+isYUBuPI+j5VKY3buhzG9/3QUNh2sTj9bgeppx0h8g7UslwiSTqrxqkJ2?=
 =?us-ascii?Q?vW9eHGy168oW31ItZFJj/lAXS+wK6xHbcGSZshoR8+N9VX91CiwdxjtP0Nht?=
 =?us-ascii?Q?A3c6d9LcqYEP/5wsT22XJaTCNH6CIOWcGBoONPxrCvtKShUmJ/PvyglrbFX+?=
 =?us-ascii?Q?05acho8txOMT9oXSAcnU2q7z9OIqBFM2RkhCbcs1ZOkgAiydLvfHtGp9HVe3?=
 =?us-ascii?Q?qCmdwHk1XXql+ZWUABSz54HrvfnQcatf2KWk1dPEMRco5Q+YtxiE00VWM3D5?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: da00ed85-00fc-4533-a2de-08ddc2c3fb20
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:48:34.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZThaSyqMPsAN27Hict1gRq8RSudkcFSWW2M4SYPeTKaBISqnhXQqgTqTNCOYb7+JVTGsa6bSLmI2ovfD6/281JTuqzA4BtWBxeX8dO27e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Jul 2025 10:48:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17772

Hi Antonin,

On 7/2/25 8:21 AM, Antonin Godard via lists.openembedded.org wrote:
> On Tue Jul 1, 2025 at 11:23 PM CEST, Richard Purdie wrote:
>> On Tue, 2025-07-01 at 11:53 +0200, Antonin Godard via lists.openembedded=
.org wrote:
>>> The current pressure logic only prints pressure information when the
>>> limits set by BB_PRESSURE_* variables are exceeded. But in order to
>>> determine the best pressure limits for a given host, it can be useful t=
o
>>> monitor pressure information after setting BB_PRESSURE_* to the maximum
>>> (1000000) and get a sense of how high the pressure can be.
>>>
>>> Add three bb.debug() calls showing that information.
>>>
>>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>>> ---
>>>  =C2=A0lib/bb/runqueue.py | 3 +++
>>>  =C2=A01 file changed, 3 insertions(+)
>>>
>>> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
>>> index 80f3d3282f..cae4bfa3e5 100644
>>> --- a/lib/bb/runqueue.py
>>> +++ b/lib/bb/runqueue.py
>>> @@ -206,6 +206,9 @@ class RunQueueScheduler(object):
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_pressure =3D (float(curr_cpu_pressure) - fl=
oat(self.prev_cpu_pressure)) / tdiff
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_pressure =3D (float(curr_io_pressure) - floa=
t(self.prev_io_pressure)) / tdiff
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_pressure =3D (float(curr_memory_pressure=
) - float(self.prev_memory_pressure)) / tdiff
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current CPU pressure: {cpu_pressure}")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current IO pressure: {io_pressure}")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current Memory pressure: {memory_pressu=
re}")
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_cpu_pressure =3D=C2=A0 self.rq.max_cpu_=
pressure and cpu_pressure > self.rq.max_cpu_pressure
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_io_pressure =3D=C2=A0 self.rq.max_io_pr=
essure and io_pressure > self.rq.max_io_pressure
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_memory_pressure =3D=C2=A0 self.rq.max_m=
emory_pressure and memory_pressure > self.rq.max_memory_pressure
>>>
>>
>> I'm torn on this, debug messages aren't without their overhead even if
>> not printed. How often do these end up outputted? If nothing else there
>> should be one bb.debug call and not 3...
>=20
> Actually, quite a lot, so I should reduce this to one call, or find out a=
 way to
> reduce the amount of messages printed.
>=20

We could also have this printed only every X seconds but that could make=20
us miss the highest pressure before bitbake gets OOM'ed for example.

We could also only print this whenever a new max pressure is reached and=20
we would only need to store the last max pressure values between rounds.

Cheers,
Quentin

