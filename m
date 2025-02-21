Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA535C021B9
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 16:31:55 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.70])
 by mx.groups.io with SMTP id smtpd.web11.27412.1740155509639422600
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 08:31:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=GnmX4N7l;
 spf=pass (domain: cherry.de, ip: 40.107.103.70, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPtMU7yryzMls41tPw5XJUOEvdvFPUNq6Z1XgRB+P1LpcYhsga/JZOHcWAaq43MYcAjev3/puscTtYxSRuthwCXiB5VcnO+8IKcHrUojYFpm421e1VhIX02mrhD/Gz0M7RE3KzEXur/pzw5BQUqcBn7rTNlWo2xtVd1bzMvria2d7h8CmxAhY4jIkOyp5hpmM3lH88rrPcpn+1Qy+NdU/gZ+qFzCzgreBr8+GFsXQLRrVzpDhLhLSgTgS0Ibp9ai8Ob2/0+2TPuBBBzSF7670/67sHsDB79hcbQsrLdnjIHjEHGM90eIE1RVmhGbkB8iA52V6xrmQOD+hb7Xdw/dNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoITnLsK4UD99mLnaPbfxKlQiXqXyGyUoNzkQvDbRzw=;
 b=n8PHSE7VNWCxIQeF5kzOBAWvRUV+94tN7z0Cl45zjVKWKPCPaavB7ZMxbXxxkBqdgkPJWUaz6T3OVJO2NEwxuARgdZnzhNk7BenuGi/QdXZEmv7O8/HUrWA9BMizL66ovMV8hZn92FpjVaiaoSoIOQhjIv7BKcEvFWjvhel2j17ENbAt3uLiAmqCv9gDPLlca4/eb1klKNNHOHg/ZRf3uYaAB6qL2CYviDGYuoOHdbJuZzHODiLT9M4V8V8HQx7baxX2Uso6SeKhyKCNeqiF/cS8w7gWs+jaqvqQ0qbR+4licwFCZ12VirUGSBqYGzmi2hiF4LAYboFs0qSzx63Ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoITnLsK4UD99mLnaPbfxKlQiXqXyGyUoNzkQvDbRzw=;
 b=GnmX4N7lnqVIBuKloYGIPTdX6vLzz4tVBMomVyS8cqrgLowg5+d48xdfwXi8Dmm9wrkX3EzEnFc/K1tVatWMaiQd3M1BzyVakMxF7NGb8dgQJD388aGRAuu+XxY1PeS83YnRjDKpbKLUbLrHQAmVhlb+rCYh7Q9pSNE79fu3a6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB11068.eurprd04.prod.outlook.com (2603:10a6:150:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:31:43 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Fri, 21 Feb 2025
 16:31:43 +0000
Message-ID: <22a6cd68-6dd1-49af-878c-fcd7b40e275c@cherry.de>
Date: Fri, 21 Feb 2025 17:31:42 +0100
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
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7cc484189ee7db4f27523351993ab454424d0794.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB11068:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c742ae-3e81-4bf2-af78-08dd529539d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DPG98xEgN9eUDMxPKbF1dtFf6RpFWEgvatWec2N1vA6Y4Nr4QkT2oZjFiyQn?=
 =?us-ascii?Q?vON1W2XJqnfRYuZgStcxD0aYjnezEKn5CwOdpl8BHLr2DaMk5XnIE1fHpam3?=
 =?us-ascii?Q?dpF4Eu/r9lCeeNGZFMWmLxMdeY5ONIqPjxRuawPeG/NbqhKXp15vft6XR6o5?=
 =?us-ascii?Q?kFLx041GkWHMGTDR2cJhoisJYh4n3EcLnVmq2FE9rpU3cnNZVhj8Q3SUxNLq?=
 =?us-ascii?Q?1eF1cSBgbHTqDjMl0PE0AwaTg8HkPwKNEYGfYeIpDa1POZOrOUATcs/aL5Re?=
 =?us-ascii?Q?bLyROuMMNKsW7JHrvo+YOgV2veYV/eO/MVDh4DeJktYH8p4WIK89tgaF4tLq?=
 =?us-ascii?Q?DMTYjgiquqcBXaVOADbW2UXkI0YTzFuSWV8ukhaLz3NECjLM2u4hP6gnsWVV?=
 =?us-ascii?Q?2dgHnKpmeAK4AkyTxn0cvcny3pCPMY9TuualMOrP8fY8mSC41au7NgLag4t+?=
 =?us-ascii?Q?g0Qjg0QI6IWV8Ob2Shz8Klno3Ay2tIxolBoRqJT4V+4tWWaqyL8e9vdBpWPs?=
 =?us-ascii?Q?od43EHgNhdY5thsAmDtOh2MfPUkQjcRc3VpjzEluIKHE6Z+7hzFDy00Au38O?=
 =?us-ascii?Q?863K5SDByahmtuLY9sIwgjhcDxa6JA7SlFiFoHoCbY4JS5+N8iBYYHj3Q5Kz?=
 =?us-ascii?Q?S7HjtSMG5Q4KSCKM73VO52agpCksNRbRiSAfvqeCWgYxa7dOOvQjGjGEeXxx?=
 =?us-ascii?Q?ICvHPeXCx3kGMLgRoBUzQBJLzj3AcH4fErSQo9sRKGkAvbS7ckxYaza4f21M?=
 =?us-ascii?Q?4/q8Kzaw9ISzhp4zQF+bwaTNlP6flsbPwp/lpcxX8QjTA8M4tyG5AmZBKVKs?=
 =?us-ascii?Q?D2N1vjhFdTGdMYB4GInB8aUUfTQOeQaEyrwbL0mC7v6opWSakg414pX5j3I7?=
 =?us-ascii?Q?cVoyDghNqk/35NTpVSAFD6as+hJiYtBf2x4KBtD83oqKICcJvxlocr14EV1U?=
 =?us-ascii?Q?S0HLMk+UQNNjICaYA04hiN4St7XZ6RqZbirRT53APW9knXEx31aqNIfGb9CB?=
 =?us-ascii?Q?0f5N2Wqu3CgaJeLN+EPlLOov0ZVr1dd3ccq6BDoYb/VbLZ3PROoQ+WWsXQxT?=
 =?us-ascii?Q?8ifhdMyESH0gFHXg7KtJSeeAu/8IiifYxFv4SPqUeHj70lcYlqfKeoJSAY9D?=
 =?us-ascii?Q?FjXTcf6o45wg8yMCkvtJk3a+cLYeYu8luxIEtn7sTMb28YImdJvO4JaH8+FK?=
 =?us-ascii?Q?ic4R8rygeF4l94PlH1NmuYdRl8LINBYTQlTI4gSYh8hLQT3Pm/EP4Ua2Uqde?=
 =?us-ascii?Q?BPfPmtckW6CIK61r6mUknF6G5VXJu4wi2flOWk7Wzu8YoTPCVUTxYsl0Jn2Y?=
 =?us-ascii?Q?MhpKiPEElaEcEoC6AcYXeWgKl8w+Psmc8krdpmBXjH9uIb10nlyIGgfsEptb?=
 =?us-ascii?Q?jV/oXu8nqwXjOTm8lrM+9J03Qqkz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ns0sdRL7HENUDFXsgzphbqRnCYKkYLs++evSXNw2Jqp15m9YsiW5Kvb/vANq?=
 =?us-ascii?Q?XcPLBWeSQolP+nmZjO8LKtpS7bI+lnk/Sm26FhveOKVLpsg0CwLiPnE0XdQT?=
 =?us-ascii?Q?aWZko5LQU0QPYPbIvrOIkl391ce3TKdesVyxKbXY0TiFRwUqNWm5ACCNBUGR?=
 =?us-ascii?Q?tu+r/VToIn/1hk1J0iDi4pw/EZvcyUplZyi4oSwFTgrTZx7yy5C8ACqNCYUZ?=
 =?us-ascii?Q?5Rf/njYurkU8RLLwWUqougng9FSOwtVtThGJMFgrNUrhRu/VCB9gwshbsUWF?=
 =?us-ascii?Q?UOu3vrP1PrXeugs8qTuqbEkPSd5A+CHp+PRfxaAz8fkgXVa1UNucrygW/uEq?=
 =?us-ascii?Q?RZRzPp1DVAADI5wXsq/da3bAlLRMSDODaZYkw9LBZkjnHdmh1vyxype4Cj8k?=
 =?us-ascii?Q?EtcnVnPYLzLU1vG56C6FG78ypWmf8fMAgORDu+SaROY8t7er7Wnbw9I/COcI?=
 =?us-ascii?Q?3GwnY+YWa7lyWtZBT8GuCeT5Tu+N7UTmWBv1NpbDEw/aXQplnoT/JXUOWH1k?=
 =?us-ascii?Q?8D8QEk+Vo1FxPfQ0ap0HQCIZZpbQaY7IZezzU60zoF/YNQkIpiM/y3I90wR9?=
 =?us-ascii?Q?uBaKOzHqIMzyNHARJoHGtdBtgiIaN0zZxlJJJcQZPturhEk0bHrX0lgl+c2r?=
 =?us-ascii?Q?OGYbyXdPYTCGAWzfcXXQicOTbjI15KnZLVyVhI11Rvw9w3jWfSVcvRGVIbZp?=
 =?us-ascii?Q?Tpto6VeZtEQbCQQcl00vV/Bk3s6ZpIbBAc2i6UvostgPqXA7ibSGi6ozrZEb?=
 =?us-ascii?Q?DcXKL/tmKxJPyAvAbvl/y6o0Vd4/ueh7bZhxriLG59pEpv6Y2b3TiHZS07kp?=
 =?us-ascii?Q?0B8gR4RuXk/IR0MhNj8uuvT9HRhkKsXSqifPWSZKiguqsRB+2kTeCHLO+QOl?=
 =?us-ascii?Q?cr4Hwx4cKA16d5Iiw3qbG+PACTAUqCzgK+c7PotQIFlOJxR6YZGhjPHkZspl?=
 =?us-ascii?Q?BUIEhJosBFOKVh13Y7RbeGFhupAzWzUFycX1zihOgUSUlfUCh6539XJEf1NP?=
 =?us-ascii?Q?e0T0uNN40lRKeFHE/ptMspqA1uLWUpeuZOn9iLz7P/MkarqgK7MtLqWvAq+i?=
 =?us-ascii?Q?xVJOu1YZMup3NtORG7jDMu2WnvLIoQKYK5slXbNzxD86hcI46Eb26gEXcpEF?=
 =?us-ascii?Q?FbiCaPW336/BBlSF3dKALciUVD9vntWjNoUwptQ2M2mmvCd7S9RuNgG340Eg?=
 =?us-ascii?Q?GiEaRNGqIA8BVRLtWFJKBS0j0T1XnZUe3ZxTzDkikG4qyxmX6D9LmaHuvbRO?=
 =?us-ascii?Q?L+jmBzBcmG4x+ho7cyL6O0eWH2DLo7MgxVdNl7QxkTZad1HbNV7SzIOJKKP5?=
 =?us-ascii?Q?BgxdC2o9PMj7z/zTMbv9wcbxU+0lbh1wO1+Gf/s6dqxnwYCXmD1eEzT2Sp+7?=
 =?us-ascii?Q?7jITOBGM8PtWdUnJDlBmS3OuNWFm1m37fRYCQGbTc4yGe5CTtgbcKTL5QCe3?=
 =?us-ascii?Q?TRx9Sa4EEpzto9+cmzDcxJAwf609wTh4LpsE9hXer7dCme8VB4JvlBYQVhlY?=
 =?us-ascii?Q?C9bGll5RrfjamCeK9TR9/EsyGx8FI2E7F2QE39z2lkTL8SRLCuyejhYCtTy+?=
 =?us-ascii?Q?xeTfPa+T3wuIBASp5EoT+6hHXjzYLFmkM9vC2y1X1i7kLHVpEuUM4gILqoTF?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c742ae-3e81-4bf2-af78-08dd529539d2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:31:43.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Veqn1RpT+mLTeup4koqqTYOJ9dZd+pXTP8mf8zCd9LrX75zSdz4ReFHoLwLwM5zXC10Wfs29ZT9c/k2HMG5qiVx2didx/wp2V49agjz5UD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11068
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 16:31:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17279

Hi Stefan,

On 2/21/25 5:23 PM, Koch, Stefan wrote:
> On Fri, 2025-02-21 at 11:52 +0100, Quentin Schulz wrote:
>> Hi Stefan,
>>
>> Please Cc the docs mailing list as well
>>
>> +Cc docs
> Thanks. I'll send updated docs in v4 patch series.
>>
>> On 2/20/25 6:27 PM, Koch, Stefan via lists.openembedded.org wrote:
>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>> ---
>>>  =C2=A0 .../bitbake-user-manual-ref-variables.rst=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 16
>>> +++++++++++-----
>>>  =C2=A0 1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-
>>> variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-
>>> variables.rst
>>> index ad219b531..f781c004e 100644
>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>>> @@ -315,11 +315,17 @@ overview of their function and contents.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mirror tarball. If the shal=
low mirror tarball cannot be
>>> fetched, it will
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try to fetch the full mirro=
r tarball and use that.
>>>   =20
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When a mirror tarball is not available,=
 a full git clone
>>> will be performed
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regardless of whether this variable is =
set or not. Support
>>> for shallow
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clones is not currently implemented as =
git does not directly
>>> support
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shallow cloning a particular git commit=
 hash (it only
>>> supports cloning
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from a tag or branch reference).
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This setting causes an initial shallow =
clone instead of an
>>> initial full bare clone.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The amount of data transferred during t=
he initial clone will
>>> be significantly reduced.
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For updates, when keeping the cache wit=
hin the download
>>> directory,
>>
>> I guess by "updates" you mean pointing to a different commit hash to
>> fetch from the remote?
> Every time when the SRCREV changes

I can then suggest:

When keeping the cache within the download directory, a change to=20
:term:`SRCREV` may induce a significantly higher data transfer because=20
entirely new shallow clones are required.

>>
>> Is there a possible setup where the cache is not within the download
>> directory? Not sure to understand the implications here?
> Regardless of cleaning the cache the effect is the same.
> When not using shallow and have a cache, the delta downloads for SRCREV
> change are smaller.

OK, I think I see what you mean here. Does "cache" for you mean the git=20
repo for the recipe in DL_DIR?

I think the point you're trying to make is:

If DL_DIR is persistent between builds, using shallow clones may induce=20
significantly higher data transfer than when using bare clones, because=20
entirely new shallow clones are required whereas bare clones may simply=20
be updated.

Did I get that right? I'm being careful about the use of "cache" here=20
because we already have sstate-cache, hashserv that does operate like=20
some kind of caching, bitbake parsing cache, etc...

Cheers,
Quentin

