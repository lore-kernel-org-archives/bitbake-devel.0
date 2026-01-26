Return-Path: <johanneskauffmann@hotmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD81FD13C27
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 14:51:17 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [52.103.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21167.1769439072390287665
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jan 2026 06:51:12 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@hotmail.com header.s=selector1 header.b=QA6dtNk9;
 spf=pass (domain: hotmail.com, ip: 52.103.39.39, mailfrom: johanneskauffmann@hotmail.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKjqnb9egTnpykCcEFcVwszO7bNde92q7hUKFIC5+yMGpGNVEnWPhjHeuoKsNN/FZKPFUA+HAiIj7geaoeKNNY1RHOtnELnmF/LBlg0aIWk0oOjr1KUo863kZwwgLu9swvJVq1miRUjy79jmt2iqrEw+40vcK393nEwEOBytY6HJfUI6o8pmtffJDkpv3frBorfqKRFYFciVa5j6tR71mSDWvejcniqlzl4ItAkcoMdFz8Buv98FNJT1x/bceBMt7hbLwVEsj+/WlEeT4mBokmBlY/EPRGJzDpUGNRL0ZV7CwfdJdEw6G/nnvv6LmVHMQhpZpZk3pbczYPCUMsWtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhOr550SQrsA51A1CUUPyATdWQAVoVLeZahlp4Bt/uk=;
 b=QRowO111sNM1McEPjLr55T4lr162XmeBz+OUhmsQ9JShyAJRpZMLAr2An+cZVzAIWvX7mhLW5/Kv+l7ciak6OMVCO2OLjP31GNJDpYTPZBTY6ZoZeN++j3vr9aWPIoldnPoCIK9FV7rc+8AwuRDfmDCj12z+ttlV5f1rL0tyAxtOiAciAI4OWlSaTgfi4P59N1R17VoMaapOtH5hFg0IIxonPCPUTC1Dfcb7XtDH+oMH+mbum0rLqTP6wbvOSXB9Ut3Xm7Om1D4NjeekNpTixE+nUdlN/pc/TMa4/ZzmSHI/dVvgXAvzGD2qPqPsEAFoafJ3vfQcEy2ME68/qsUY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhOr550SQrsA51A1CUUPyATdWQAVoVLeZahlp4Bt/uk=;
 b=QA6dtNk9h+YiFchQaUlXGTR/A4Vj5vvlFkPGyFuK3W5YhZawEAISUbfNVqzMihyHwV+8phaC/24EC9F4ZAdWRpOzdxZV668AABd0IbT5MBB9+MQJ5Ij4emscr/nJu3y547OijA9h1QaN/RSup0BuKID00necFiNsgcYcIBtP8Olsy6ejC9xMcZPC2dLwsOfxNqrkd5EQFeazw9ACR53uGuUJqMIcHg8d/p/R52LG4c3xyI1ongj3WyorCbPxKJ/TL3sh9MBQceKdoEhaJXYFeixXHWbBelhrRX/Pn0ZNe1cznvoWvcNAdqOVudVOMdWeRE0Q3I4lJpbcixeFZ01Jig==
Received: from DU2PR02MB7805.eurprd02.prod.outlook.com (2603:10a6:10:2e5::10)
 by PA1PR02MB11284.eurprd02.prod.outlook.com (2603:10a6:102:4f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 14:51:09 +0000
Received: from DU2PR02MB7805.eurprd02.prod.outlook.com
 ([fe80::c843:bc28:efe3:e298]) by DU2PR02MB7805.eurprd02.prod.outlook.com
 ([fe80::c843:bc28:efe3:e298%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:51:09 +0000
Message-ID: <DU2PR02MB78052FB25EFA02EA3F97536DA693A@DU2PR02MB7805.eurprd02.prod.outlook.com>
Date: Mon, 26 Jan 2026 15:51:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] fetch2/repo: add support for fetching
 submodules
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <AM0PR02MB576490C2267B6F4B73E297DAA612A@AM0PR02MB5764.eurprd02.prod.outlook.com>
 <780bf8b5a76373ed64fa3ac1c8874a54176666cc.camel@linuxfoundation.org>
Content-Language: nl-NL
From: Johannes Kauffmann <johanneskauffmann@hotmail.com>
In-Reply-To: <780bf8b5a76373ed64fa3ac1c8874a54176666cc.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::7) To DU2PR02MB7805.eurprd02.prod.outlook.com
 (2603:10a6:10:2e5::10)
X-Microsoft-Original-Message-ID: <8bfd17e5-dd4e-4143-bbbb-e88f370e5ce9@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR02MB7805:EE_|PA1PR02MB11284:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc959b0-bd55-41ab-41e5-08de5cea570f
X-MS-Exchange-SLBlob-MailProps: 
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6S6Vh16em1lyAwBbtk2PDZQb+DCCIRAobb8meF2LyC/AvAcnzjyl2WPO+U4KrEumrbt4rHoJqCZrdjK6ONjJfL8sucm2QorzISo7sqh0zz+VdBKP7kOkV6lkmwTwYUMH35FpGlNjcqyZcivtp6V+R77UlwmOjNcxj+eumDCbYxB7PiyzjB9Xw+QQDyCdZ7HeDD9hy2/rv3JNVJzVwvyiiixQbPupngRip5kMKDa+DngbatzBicM8hv7ijUAa1GYu/6sAfWSakIE9wBGsVb0pvBKz6y/3Q/MXFJ7XddGi1SfKvMqlsjkxmx4WRFmDPLytJQU2W61WkSD2Ay5TC3/yAet3RytnoaBix+p/XSf7X6LtpUNpKwqXIZJVWvCnnDiCPssgPsZ8NUt5Ul+EwMjqKYsByHAF9y6/Q1ZdjysAnLQ0hGxzGwWvJiT2MsXnMUwC2jVZipzgfrk+vdQi4gI4dSsJpJv2XQu2OVsPwxW2+GqYIp/nX7sJeTJyFhUA1Ew/vMwLP0I4vDpPW9gz2wV7YEwFZVKTObT8CROkAHH2genW9mrNLptnN4aVSGlUC0SUNPoc427vbchq1KY6n8r6RJ+lcMS6Pwz+dGE0BgvU9EbcCuFd8aouxrZi/oPnX7k+Bn/6YxdNSNkqWJ1WDwvadTzaI+Uhrd3aTBYzomKbPgl8nYHqeYQPJvnW/roaze3F8cWY5uF2vCNOiploZorNV5zaw6jXtanjCkkOGOGQaz7Ng=
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|23021999003|39105399006|20031999003|8060799015|19110799012|55001999003|15080799012|5072599009|6090799003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fJ8Wx9Ggs7++Nz1pILyFNHFmavrAEoiKZgcPh8L6GKNjrf6P/jRTbHefOU5U?=
 =?us-ascii?Q?yxmrHNuqmd4Yu13Bvfne8qlrF7dnplIEWxo+jES4PfvTxQNcI+tn7pb03tCe?=
 =?us-ascii?Q?+g3RX3jsb9qQO2eLwipM7Vt1lnVJND1PWWwNqITCwCmI2ZpF8Puto+lOSQHm?=
 =?us-ascii?Q?SoQAj+3PwZ8CU2dSa6uKPZDqxekTysiw22NTvWwPGyzzWlhLiFtZtTb4N98i?=
 =?us-ascii?Q?80QfvbtrPXVq46Feu3n9g/WLp5iRi6SKgYWoZM/DJkfR/YUwI1ltihttZ5sC?=
 =?us-ascii?Q?zP0ChH8SwUZlIN3PqAYWSqyHGis6IZHX8DCYNnA9W/KvJ7pCX28gMQCNYXv3?=
 =?us-ascii?Q?gk+oIPUaSyuJy+qbXtdU3khdDCaFCaS+I68IITEVkB0a6FXmYsWMuLNJcWsh?=
 =?us-ascii?Q?iEVNjYiCZVBoDC8aBSypTjuBHLXn8hDFoLDk3DuJlDb+A++mRribg3xJfZLi?=
 =?us-ascii?Q?GsCmrcq+ngo/0UCEml+G4XCHIO7rbOpeTwADu5CN4nl1eIvKrOjZi6rhZmeh?=
 =?us-ascii?Q?7KoMdEI1WHGmxC99Yv9XssxOE8oi2rABMIY6TNmq5YzMBPVUlxIZojXvXelG?=
 =?us-ascii?Q?+dxuMJssnY2qHqRPXxZ1cdhI4ipfXK6tVQNnPJKuUNIy1VWDxgfZnNfqbF6K?=
 =?us-ascii?Q?YrEOTfI48hcbVbQFkI9/qHkp+ZpibnCledrwVbv7N06m+XFiepeqzCaeYVAq?=
 =?us-ascii?Q?2kDt7pbZnTDRkU1XiHiFeSz2uzkmOEtMe2bv6oP6saalCilDdMn00EvsxDMo?=
 =?us-ascii?Q?Ixq8HMeQe02w+WpRPTDjTiF6KGDnB8m7lvIfeKmTZrIEDCQNq+UeRoCgps78?=
 =?us-ascii?Q?+Ubt4/ZJrkVKbgy3Jq+7WcaEejgIXXRFcAOHRUbxy2Zv7/ApfEFI5cHxJCVi?=
 =?us-ascii?Q?Zu/zgCtmY4xHNana068UhAetJWW8AXhjvQfbp2bgt/Rs4VuRJ1Z7pX4vcJXM?=
 =?us-ascii?Q?Mn7BCQvUepkRMzMGjfd16D/j+gS4yz4zvXRsksS1cSVHSh/ZoZMP0b+X4oiu?=
 =?us-ascii?Q?1qGXGXdxQ+I4gWhnX9NFuleGZ6OHS1iLsWShHfZ8d5LvY1YAg7E+oxmhj3q2?=
 =?us-ascii?Q?Tjan+bIBg3Jrlt0T6KepzBzc5mmkuKKkdptR1maqfLVPVVpDzrgzz0AOEtgM?=
 =?us-ascii?Q?s3IR75vZj6J6Q2MKOLB01ylEzP3ZPSdr49QZOBkaCKEHTLuJl3FGZ29GLu3H?=
 =?us-ascii?Q?u8U/KVfUCsmSjoL2XVnCPhaP3uiagrUioftmJ2KJRDF9M2ylyZopfP9GA3IX?=
 =?us-ascii?Q?BOMxwZ4WvQ5I4qGW/AyMuCrg6yDEg05oLLLHwmUWwQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7rhEDRqSE4LUuLvNatR63mXOovfAWbu2ovsop/Rbl4eYEMKQsWn2IQVih2nu?=
 =?us-ascii?Q?9PJdj9thRq1KQ9jr0TeG9HEY+T6D5rKC98I1QswDP6CJn6blDy1OwVJ2H8rh?=
 =?us-ascii?Q?RSw8JznY14Q4UmO1nF67PCnhmeq3h3bb9+v8RM8VL4DQZ4FbAQh2+ZMuAsNO?=
 =?us-ascii?Q?tDC5K2ErTdhGSHO/Nupp9rDhImPVafg7yCxxcAvOuqzNDGUAAXwiOW5wuUih?=
 =?us-ascii?Q?DGembIUoSQk0k+zYHre5FNiRUKXc4Gk8RdCKKUDcL71kimEJkeCbrn+en9vV?=
 =?us-ascii?Q?huef/weZY01E+WqjLNhCHZRwYyKnaS0Y8YMbPc+ysB/M+GU+sFBvYltJPaJz?=
 =?us-ascii?Q?uCOL+BtEk7LknJmFK6RVBMzeltgGJEJlHzcYRiPhK73JC6pKBcpCDa2h1ZQM?=
 =?us-ascii?Q?31CI0IOGQRuk4pva5qjtVuvooabKSA3EMrW6IDRSqJK/lDGrTluvfNPkvnb4?=
 =?us-ascii?Q?fus/X03SqbBeM46QyJKPZaDNBYuq+3+1K8RqMl17wcZRSX1/GmJaRYwqFlc7?=
 =?us-ascii?Q?nTst97lKXbvkIFHjJZlvWmTr3rtQwi1rLnZe43zpiuUE/zARsd4P0ATVTDIl?=
 =?us-ascii?Q?xEKgUZuIGwh8bZbCskroFPqa+H2m6hm4KIT0i9uDp7Yn/EHpa4mhiuMPE072?=
 =?us-ascii?Q?1k1o41n4Wo3rDGEgDJr3oZnCU+p2nx41AtAnIRhTYwO7OIUsR81DGtX0RrlP?=
 =?us-ascii?Q?EcjwgwJQ87LIpSVHXu/3WOYsiKexuknvLs3TBNMIaW2byjWT4Rln189D3a0Z?=
 =?us-ascii?Q?EFZemlT4fEcF2Gp13DNeU2MjA7CCdhVGOABVEQPnc5AbAcdEE7dgiNoL1siq?=
 =?us-ascii?Q?YXREqBt1pnllTkFg8CeklKf+dG9c3HNoKyCHhZFAIckWtfMO239sTw7jpWBY?=
 =?us-ascii?Q?/oDE3iZmmy6F3fmJCtOvWP6vjqihHH7mHVP5n6ccc3JuNIBYDoLum+37+X7v?=
 =?us-ascii?Q?KO0zHMKydt+7zqQ8pBlwJuXgv4YssiozQGhxVUU/g5TgZAFXIByzEsw6X68r?=
 =?us-ascii?Q?pKqihQtrMdsAVYeaQfjSHiQVHiTWEehc1AsS7wIcPg71/w7ORlc0tJ9B3lGo?=
 =?us-ascii?Q?OutkzjrEepw8WQ18tqe6c6fEbMJQBqqWoBywn7Dz1P0LrycZbid1Wdd4oJlG?=
 =?us-ascii?Q?w17jchFFewSU4rkZ6ot18Y1oAW0kQVX0Z/P+eu7scjFxCPGDCMFYbc4CGlLO?=
 =?us-ascii?Q?7Wi3q6sXt6/Hnb8W35qDW7aES6WPh9/N/F3diIU9ZzJOV/PhEw3rf3XmcR3m?=
 =?us-ascii?Q?pmTiRHzhKSVPO0r2c6JtLzRl7EFW6nnTT6SxBnNLKIQg6gfUEKhNCGerPg1D?=
 =?us-ascii?Q?OzEsMYJQV1RCr0+M07ww5dansvT5DHd7zpY69wFqwY+imRMKv+uUiOB5QzeS?=
 =?us-ascii?Q?UNn0lbLyoJHD2I08MK9w50Ikk9woKDokwsr4xl1bMBDXeIrwIQ=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3f6e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc959b0-bd55-41ab-41e5-08de5cea570f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR02MB7805.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 14:51:08.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11284
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 14:51:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18870

On 9/23/25 10:42, Richard Purdie wrote:
> On Mon, 2025-09-22 at 09:47 +0200, Johannes Kauffmann via lists.openembed=
ded.org wrote:
>> Add the fetch_submodules parameter, which allows fetching submodules of
>> projects by passing the --fetch-submodules option to repo sync.
>>
>> Signed-off-by: Johannes Kauffmann <johanneskauffmann@hotmail.com>
>> ---
>> =C2=A0doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 +++-
>> =C2=A0lib/bb/fetch2/repo.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 9 +++++++--
>> =C2=A02 files changed, 10 insertions(+), 3 deletions(-)
>=20
> This isn't as clear cut as you'd first think. How does this work with
> mirroring with PREMIRRORS? Does the submodule inforation appear on
> software manifests?
>=20
> I'm a bit worried that this will allow information into the system
> which doesn't follow the expected behaviour of fetchers :/
>=20
> Cheers,
>=20
> Richard

Hi, thanks for the review, and sorry for getting back so late.

Indeed, this is a bad solution as the submodule info doesn't appear in any =
manifest or SBOM.
I didn't test with PREMIRRORS but I suspect it doesn't work correctly there=
 either.

Instead of relying on the submodule declaration in the repo manifest.xml, I=
'm now using
the gitsm:// fetcher in addition to the Repo fetcher.
Sorry for the noise.

Regards,

Johannes

