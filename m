Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF00C54798
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 16:38:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.132])
 by mx.groups.io with SMTP id smtpd.web11.16662.1709051918221442207
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 08:38:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@theobroma-systems.com header.s=selector1 header.b=jUcLIppE;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.21.132, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjHbagYCcNWsfWDDsE5zOsmJ15uo4ikCb9P7Pu7wCoy7D3nYfhfRv+D9f2jDTu5TkFwJJZrcgu+qiDvriYai5nfEAPDy9kYb0K0Xt/ZC4P5xlliWgtLWzV+inE0m3O0G2442LUCweAiv9ftv84nxLn1dreLacn/CKvSFFBl7XGcDGB03duciH+MSVJ40Itp16TIXp2dtWUx95vvFe0XRL7GZAkn43iB/LHQsV1ifHgUo4EuZsJZaFdmXmVJCO5tejQCFqacmZyxx5d/oPJ4NcrXbjNhz5uwnQGsi2P2qzYbbfLeqlqU700oPLSUqH1BIegw3ugaqcghtVRzBBic9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yksNt4Djh90slrVZXyURWTIgsEm28YajQ8Ip+OefFsk=;
 b=nqUNtQxzYdDvuAakHJbVFStGHwcWXeTVotxW1J/CBQ1EsIWLUzQ7b6URX41GyvYhECypHU+iXOlXuhdLC+zgNTiRYaJwwm6jS1tgYvzLcl6f+z/WmvyhMx/vHOJ0OV0caVWkvIRvDtMYh2VMvwvJ2LHqXps7rodPfdk3IS4h+NkzZO8hoUFhgaa05X4mdi7qm/j6m0ysA87lU3DyMidxJR6HAnFf65NjkgYIBqkJz/7PEv4hHTxZlFLBGnFFpsA3YYFQr16LokQPs0ydV3RFHANK7r2e5Ey5nv70Ty6YeER7MnV135XDEUeQVCWStCxMTtUPjWybyZ8H+AphM8tnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yksNt4Djh90slrVZXyURWTIgsEm28YajQ8Ip+OefFsk=;
 b=jUcLIppExpX8y1bVoepoqD7VI8y4hlKGQhe+XQkXdG5nR3sh8CG+iN5E/0Niudw1M3nYLkKkNx7DwUDYxHZdHGjufMypiS0c9h+pz+jDI+LHktRfrKdgbNRbjYDMAHkQ23UJ688HELrUK9eOaUJjILW78hlR6rPp5kk4DMutbmSOJOcgrLinlCnLv8JLfx4UDZt3WXB3k2JilN1wyB/26+tDKo7n87geDQVTvhWTV9hQ9fL6pPW7Ce4z2FAe9Q9kfrREnhENKWtQMsD7HZY7cR8ZKaE72RLzIk3+ZhWZHISMRXs7GtA1/B+ymp0bpsARnV2CyCpYKyAXWNqhMVzK1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI0PR04MB10253.eurprd04.prod.outlook.com (2603:10a6:800:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 16:38:33 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 16:38:33 +0000
Message-ID: <ce7e0116-69e9-4103-874b-c1f16d0a64e6@theobroma-systems.com>
Date: Tue, 27 Feb 2024 17:38:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [bitbake-devel] [PATCH v3] bitbake: doc: Add section for
 variable context
Content-Language: en-US
To: michael.opdenacker@bootlin.com, =?UTF-8?Q?Simone_Wei=C3=9F?=
 <simone.p.weiss@posteo.com>
CC: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <20240223192047.7431-1-simone.p.weiss@posteo.com>
 <0a3f67b7-06ea-4dc0-bdf6-506098cf46b2@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <0a3f67b7-06ea-4dc0-bdf6-506098cf46b2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI0PR04MB10253:EE_
X-MS-Office365-Filtering-Correlation-Id: 328ecff5-32b6-46c5-99e9-08dc37b289a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cqHCZWptTEw9QX1PbaBG9DRWdZcsoLx4m3hUoGhfvfJoUNts2EECA1GlS/v+1KmphuYOQiami0QYSLT+3qLFoXjVEfNt4XNPPDY3Qpt4JbcOqSdGTLlxf3UrxRMqb/aPN2QwN8fdsU2/62YnMI5ereWxwBKP8DBFB/idnZdtkmS75BUrCQvuAjjYAOGr6he+m8JXTtYUF07T8+RbAEWF6RxZlBdxEUFBrwKr1slYcQ3Y+9JymfKRQUIr1YRS5BcZ0paVsVPnwdlsDqNRH1QPciIlyFMx+c8CMdQI3b34BixaWhi5/PSv1Hl6NI38BR7qy1G1STGe3qXTRLa3HMb3VXYUJlgRE3B75M8cBqmdv3x2sV775YCo94bhUad7Id/71aOsq+kTRCrp/sC0N+t057NhV8a+l4cgqQPUrBETyS2l8wSzwUvJFzd9inqApAArH+x/3uZdVT0s8HghhiiSH1gBNACPwtVx7Mc4e4J3B2JDGY/FJgqSCtKwyxabreU0kn5BYttXVyaSuqUgZKr/BH3QnXiJ02R7MyQWOY4NGfAi9/Nj5T/gzE7qnVJsirkRTQyaX94saLw5ul5zZotOfxV9a5ccGAbhlBBHpQWLatKF5fQsodT4iU1g1NeXB9y7302iUxy9Gj0tUz6zyTKTp3nmayut52gKQMwBSaaeFss=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BGdKkn/2oNeelzxBID4rlOcCUxTFxpabZXmCNIopHozEozAbiUjLPnbxSGcH?=
 =?us-ascii?Q?ESGzEmRoOrAUwzqUGAuMCBCJ3R1jH0pR629GiM8e1oUhHLuzCN1x8YyMhvRV?=
 =?us-ascii?Q?aH+TFPvw93OnsYBZZDXzczmgBn3IHh8Qgmqpj6FVxSndr5FYcrfIgJKdpnyQ?=
 =?us-ascii?Q?bnAJkZLMO9FOHON/fMDPgJeavVoIN6brQSy8VfbVF68n0+3DRLUTLdbHVIJs?=
 =?us-ascii?Q?e4c8NV3nWV+QW5ZMuKB6iTV148gp5cZG9yIwXpBn4KtMBCxFqUfS04C6dx6x?=
 =?us-ascii?Q?/kE+H3xSTVCsER2pa0KeZoe8w/fq29FA4G0ypUuAKOczXOmvaW8LG6Aod645?=
 =?us-ascii?Q?R3bMjUl+n2XqX79UXuQ88eSjCI4YHFsaKSjDax8pEtQ8sI90OezdQf5jSZJD?=
 =?us-ascii?Q?th7fl5mbtGZHOz5t//o90HtyTru/PidyZeytUZDbhtvJGGzbSWgRIjThzT/h?=
 =?us-ascii?Q?Pxq3l+zzjBtHQ6uZHsfnukqjwzujEUuhMjgM/0VaBrqwa4DMXSpecKbWA3YR?=
 =?us-ascii?Q?pZhxwRUtts1t8cyq+lj238K/D2ALuQ1ctPmnS2978+39ErMyL70pxMaelLyF?=
 =?us-ascii?Q?R5V8d8G7D5PUuvcE5AIPBAwMJF7WssCwcrv7qiywvi3K1dbDZw6Yukbe9yz9?=
 =?us-ascii?Q?g+onLPNarnpWrfZ8IMHWbVVlTzObg6235ehXD2HpDLTvXvAlYPzSjjpUNaow?=
 =?us-ascii?Q?K2LxVlwIGzCS//6LRNY5KeMfGMw+K8PwiiXHumAb8BVlzfEhghEDBkrUnPD1?=
 =?us-ascii?Q?qe0GxXCiszsXxnbryxddl5ZFRECiI1bwuerTsb7VZ1u8CNH2EnABwABeNzcu?=
 =?us-ascii?Q?CxW4RX96EiOkSuAu9Wzbgsq6X6TZTKXl7XtcHBBzBZgQEJsNMHBAf3EzBfqu?=
 =?us-ascii?Q?2Wd3wI35QEj+9x8XeGx5vwLtCVf27wmfDISk2OggJ1VB4U1YbGQ3XIA/rEwI?=
 =?us-ascii?Q?sMUPuBhT0Q5zyPtxRlNy4QMbIuY0ivJEtKrWjEu8a7Se2npFNGAMNdpy2qy8?=
 =?us-ascii?Q?k1Owh+VwmYftDljxDOY/vLKBr4W+9lNTL9s/upKCmLAAVKull56f8IC7bKFw?=
 =?us-ascii?Q?p8w3ZDUGmpag1LIgft1r731/jjrTPcVJc10rlEddL83WODPtmVzbKMyeXigv?=
 =?us-ascii?Q?gaiiOAznQY8Bk3urdt0g08XMxf881tiWROSk21JxKoGcqHY1qWWk3rb1Tm/D?=
 =?us-ascii?Q?2SQWvrJG8T8912Frr4zB13lRNgOnrJWkTwYKuTadL0+SUKwludB47DiIsGoD?=
 =?us-ascii?Q?q8apzAfcF+WgKyfx6wHjAh8pjiEW+GULMaY2JBOxHZG2IClVeYzpQeQpHE+j?=
 =?us-ascii?Q?HPVSjPUk0Vq4ehZCugX1PBTAq3bd5Ji2axWUFBUplbgC/msasi26uL8Z85xH?=
 =?us-ascii?Q?BhH9nEF0qnqkK0Jf7pFUcBk2MPFjLdb2QZGTr5TpBZayzdza4s8emSIzACyw?=
 =?us-ascii?Q?Eg23KNjQ9ccAe/Vxj5EQDSkBQvwDJfpPRFn8g3A3L+MGyARt48kpccvVJzGr?=
 =?us-ascii?Q?80NVMcrGGld9tYKResPtcWWs71GAIsG8zh1mKLTDt3LLegZoEuyDbDkEjE/j?=
 =?us-ascii?Q?iffZ9SReX0GL7mx/ndVGQrWLbzs5IjDbXeaMgByl2IecxXJHUfZkcd4+8Gib?=
 =?us-ascii?Q?EPCSRurTyN4wqJymrkRLFH0=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328ecff5-32b6-46c5-99e9-08dc37b289a9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:38:33.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PaBcoNlIrnL9fz7orut9GfbBHo8cfcBThnLsBIxDD/Kx7Ioxf8n+SRa6f+9cLRitTophylw/UBOYGwFJNstzCCA82sNe+mcrs1SltjTrer+Xd+YB2ZUSJgHr3e6pFjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10253
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 16:38:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15964

Hi all,

On 2/26/24 15:16, Michael Opdenacker via lists.yoctoproject.org wrote:
> Hi Simone,
>=20
> On 2/23/24 at 20:20, Simone Wei=C3=9F wrote:
>> From: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
>>
>> This is inspired by the same section in the yocto-docs. It aims to=20
>> provide
>> information in what contexts(recipes, .conf, bbclass,...) a variable=20
>> is usually
>> used. For that I tried to group similar variables, so that a short=20
>> overview is
>> given. This was inspired by [YOCTO #14072], but of course does not=20
>> implement a
>> warning if a variable is used in an unintended context.
>>
>> Signed-off-by: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> ---
>>
>> Notes to v3:
>> - Applied the fixes suggested in review (thanks for the patch! I hope=20
>> adding the
>> =C2=A0=C2=A0 Signed-off like this during squashing is fine)
>> - For the ref label, I plan to come up with an svg that illustrates=20
>> tasks,
>> =C2=A0=C2=A0 recipes, classes, conf (thanks Quentin for the suggestion),=
 but in=20
>> a generic
>> =C2=A0=C2=A0 way and add it to the Concepts section, I want to add a ref=
 from=20
>> there.
>> =C2=A0 ...bake-user-manual-ref-variables-context.rst | 91 ++++++++++++++=
+++++
>> =C2=A0 doc/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
>> =C2=A0 2 files changed, 92 insertions(+)
>> =C2=A0 create mode 100644=20
>> doc/bitbake-user-manual/bitbake-user-manual-ref-variables-context.rst
>=20
>=20
> Thanks for this new update of this worthy addition to the BitBake=20
> documentation! Everything looks good now.
> Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

A section on task context would be nice but it can come up in a later=20
patch I guess.

Thanks!

By the way, I had an old doc build lying around and just git pull my=20
local branch + applying this patch and somehow the navbar was not=20
updated to contain this new section, I had to remove the build dir and=20
compile it from scratch. I'm wondering if we aren't missing something=20
somewhere so that this navbar is updated whenever it needs to?

Cheers,
Quentin

