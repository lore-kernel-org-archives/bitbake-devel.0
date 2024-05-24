Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF8CC25B7A
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:33:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.118])
 by mx.groups.io with SMTP id smtpd.web11.18895.1716564797878973425
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 08:33:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=fak8azph;
 spf=pass (domain: cherry.de, ip: 40.107.21.118, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiaNmfccYnAmhnHT36mxzV68LO0cZxyQRTioGRXMG8ciA6D7EBtdO4i4TZlCdOaqATf5IYN5YVQOCQjtEQS1oaOVz0to+ql4jTUwpgCUsNz3rfPju3uE9E7jQtROix8Jihr5H0tOjIL+dQ6sy91JTf+4ilX7/9UYsgI9HTf3nzPwVlOatlqVPB2leygaWcY9rhPVcEGFcZiZuO1tjq5XplfjPCFo0dD/52N1HXPF1UIP5io3LSITPBL0gCS9w04/kcW6OD/m6Z326Ase086F+Bine5DI6Yjw4Rd3UyXybr/XT1hwCUshjjNjfkyU4Zdd131qlvtnqE4mrH7pb2c7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOvEYuxIKe+r0w6SwcSSzDJuM4Zny+cMx3V/p+LmJdE=;
 b=NujWhtfz0ZfQvLBzRUUnEGpswC87mUtsuN41r07cIo+H7+I8RtP6REqX2JxlM3YYx2Uvv+ZcGkWQqTbczPhJh5ZptuWujvFz78Gjk7kODrEpuRicvHnoARWqRBC/sZxl26zU3xkC/krPJtXKjNDShCvY99fU10LnFubpWyv/5YHdB+lxx4WoU8on+AHhF1aJRgvLwR/EeU8UhckR1VfNifl+3H+0sOsgB8caO9By1imswo4UbI/AD5uVAkidVw9bSVtZ5VLhE6NXye4cx7heTRC9ogerI0UvqXthkGKf86zXE/5IetK88dYqQrYdXA+UsnuLK4Ci/gG2NOQN47QsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOvEYuxIKe+r0w6SwcSSzDJuM4Zny+cMx3V/p+LmJdE=;
 b=fak8azphO3cKhfNjr8e+DjQtEVqTJuSuJIKEzCOHHrck412ghh7OmRnJNB6jYQoQjBxswvDO3ie8wNpgIJM7c5B9BHhXcpwICaUUHzO8TW25gE4/xEvS0IvH5e34P2LW0x3RIWz08umtqRA28CE/u4z2Vp093qRaMN42EabE6/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by GV1PR04MB10478.eurprd04.prod.outlook.com (2603:10a6:150:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 15:33:12 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 15:33:11 +0000
Message-ID: <de18f958-d6db-4f90-a49b-a181d046f77e@cherry.de>
Date: Fri, 24 May 2024 17:33:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] add basic b4 config file
To: raj.khem@gmail.com, foss@0leil.net
CC: bitbake-devel@lists.openembedded.org
References: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
 <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::42) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|GV1PR04MB10478:EE_
X-MS-Office365-Filtering-Correlation-Id: a73ded59-1c48-4433-3dd1-08dc7c06d17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+dwouwYmLf4kjYTajnHp9CuAbc8OEOtfP34OdNcMueLuWbXHWyOZmZTpbHNa?=
 =?us-ascii?Q?YKc6n4+TEZi1RDfMCgaZNSVllkk3MM0Uwwi1V+vlS0tvdBA1Tq/Ez0TdCNWZ?=
 =?us-ascii?Q?IuJ+RMHo/xtjr+SRFQZ55oUyDHKkZOS2iSFriaav/3Cpa7X/Uj+IYsKWVt/1?=
 =?us-ascii?Q?5K5W0JUbsopPX6uB74Ta78viPtbDnf4hTNNmbFUjhekdQtmqh3vrM86ZTSy8?=
 =?us-ascii?Q?FddFeMvEqHekPQrzit+nfCMwJ6+9EhXge0Xoa3Pc3vn7OkaCuJ2jgZXSWZhP?=
 =?us-ascii?Q?sSxJx6X9bl7r/HIycoeYFVZ1tKUYTGonf/rY3MVi5MmfDJgvDyOG9+dnrBas?=
 =?us-ascii?Q?8GszJGapNQGxvvIBu9jPqmSkxUScmuhzNIj17/PuUHpMq2OOsMucuJawdi8W?=
 =?us-ascii?Q?m3PSSyMjwIjmsNiDB6X9UKow5RKdBU/DqulyAS1OxXnwoNno2xz/7xrpkPR0?=
 =?us-ascii?Q?5JkYgPl3NyGOYqEJ+FUw3TwnoCubxvJidhTXPX0SZB7l6oVjuBFoPArY03wF?=
 =?us-ascii?Q?IvcjhVDwgfQiRCruzi6bjtXRRREjH76VaA5KhUuQFsl3f9yvS327VWefFYQA?=
 =?us-ascii?Q?d8euVPOF7H4rKIriyXp82BAslCt9vFpSmmMF8ICY4CnGoxouydetijDHEXM0?=
 =?us-ascii?Q?egWFMwNfg5CdCVWhrU/h5yXGsdFzs7QC0LFkcIeHrUybHD7JXVbI8+FbXnKS?=
 =?us-ascii?Q?NAe9xsjEn3RvdbDlHadE0u0fKdDMh6XRgs733SrpyHjOd+VyNB468jo11d49?=
 =?us-ascii?Q?QeOjRH1QzcG+6FpRH5rDcgtlJFB0idQKBj2nGR/kbZyODm0Hto0bF2ttH1qf?=
 =?us-ascii?Q?1OgcEvIt5sBrEPfHu9cosrMLcGqCWAgWDzjZALMchVzZzsEHy5Gydq8LIHSo?=
 =?us-ascii?Q?iH5Q/d78u+QiQMUfrAY4ux9pj2l52rub2PwlN6Zz3VIgCctsaD6zSNYo5/zG?=
 =?us-ascii?Q?JyiEbUKMZqbnLNYzmYgh5hjYSsYCp6Qz6jUvK/km8sd8Gaf4U703ITjtMgyC?=
 =?us-ascii?Q?1GmS7o2S/jmjtHqB+3MGp3j5nga9STzzzWKkm7qzuKzjsl/POLWib7y8tQ4d?=
 =?us-ascii?Q?Zi8A72swa6qYNBskjiwxHvvtLZf8PtrpnyHNP9NODJqHVootVnU1vysdYXxN?=
 =?us-ascii?Q?auSXvrR0kWcndyOHnIqM6HuA+spFImBFGzi0zmOVlN1DOhfxg9KaOCP92RHF?=
 =?us-ascii?Q?w+5NRNVe+/nyIMNs6GT96MJ2qhpGNmtoxaokUobVVvfbviiyCZxFn/qoFLY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?erXaX9YWvoxKHE7/hEDTpSya2t5DZtLvCyB3okwSbJrL+AopbzugQY4UCZGE?=
 =?us-ascii?Q?S4jYJQKFbu7vTG8TZZhdnGbUFbltDXASTSf4/NzemsQIhYh+TyHaQWd4yaza?=
 =?us-ascii?Q?q7+EnpeXPxVwKelBV/sFfnfXycp1yrGSyQEPqEPOOoiiUUPtJrp6O/jNw96Z?=
 =?us-ascii?Q?XovWwsQlfsimgtASCY7NblqwkAdclNyj7UtkVsTnjFPBwFZV9mizjcVXFxv1?=
 =?us-ascii?Q?D7Ha3khynahn3dvPgl/VxhJ7ciJxdVMHoaG+XSCCwUUDGfHic1lAn4Eeg+zd?=
 =?us-ascii?Q?6ornJos+5AfuzBeJEUhgPEqehRs5GA6FCDr78wgTNIaVTXSGcX9C1kmvBwML?=
 =?us-ascii?Q?WboM950xn3pCtP/VgYiRpsFz/DLPTIRRx59HGsJRovY1ee4uzH0VEcD83DBe?=
 =?us-ascii?Q?tbluA3TwhZ+pR3Sg43zq6U+VYJcgC8ZBysyelbs1UMtq9jTDSAKRQQ37jpJ5?=
 =?us-ascii?Q?eUkVYdrT8Cz73vfL0xpb9NlLLphAm/boBnUT23jV+hrEvCPHHL3yRrOMlCgl?=
 =?us-ascii?Q?FhzidqAEp/HYRqfNKcHiWVjTh+1hzU2/GidVF79BoOx3Zf//klSRRtYHy+v2?=
 =?us-ascii?Q?t28ifiFavdcHKxn7+mc9m5tgD4DhiBgpJGxyrjtDiO3kbR2Ex2WxGTSEsBtL?=
 =?us-ascii?Q?IUTMxDlwXHpuX8a87/hzEzE63LGVWfyakum6EDJK+VPuRfmNfSOJHoK2jnUf?=
 =?us-ascii?Q?6nxe2TgCZq1Qnt1Eou7MgAkoc23/sQ+nhsf6xunsKYZK+g6ixuk+nIRd966U?=
 =?us-ascii?Q?gNQAph1JpP9dzl3JtgJ+kaqpiUE/HY2NUYVT0D7x+SWZDY/wAetLJhRDF6IQ?=
 =?us-ascii?Q?4pEBzy3EF4Zh9QCydKa0YTMKBBd8tUCV8iTV0LcHSlr5xPdV2e5qRJWIZYTR?=
 =?us-ascii?Q?vjuAOswXIn98yr6kYOMfPUKR3gnTRth/BHCY/YfM8U9fR960IC3xZbovE5lv?=
 =?us-ascii?Q?4C1yjw+V8bT6kGYhPsHEZnnhj7552oZstF2Kd49wD6j1whs6Hze0VYOeQv/g?=
 =?us-ascii?Q?GSBrNK9vUZKwJ2Hem/Z4HDnIcY8FjB94HkMe8LUn08Nk+a9bV38nUZ7M9X91?=
 =?us-ascii?Q?2kqd99rei3eQCY9Q888Gu0MKZu3O2u7DTPmFaErPmWTnbMSF2UmbMLMcd4Pk?=
 =?us-ascii?Q?qHFG5dDNv/ap15TlEnYencgrmU1K4FQHYetZwCB7XPo001JTnrpsUsWmNFmB?=
 =?us-ascii?Q?UTLTVU15O4uqK3AXub/XeVNOfNerSiVRcTJw8wtlpGKKHZDfp2aIYwxyXyL7?=
 =?us-ascii?Q?zhHry1xmRYESp2CNA53DnqMkOd0GwS/VXlxqbdyb/zRdRVHvlIMootFzKJas?=
 =?us-ascii?Q?UjeAgwo3yxZWmNTVtXIR4GG0sF0R7VY0YSqsQwX86PL1/Do0E9+VBzXdylUI?=
 =?us-ascii?Q?q4qoFh+Jv3JXToM5z9FETuP7Y10v5TW0wwh6cN+2QVbTaIXOdkjNjsZUuxaH?=
 =?us-ascii?Q?FoYm9rbvEwrTKPpUc4U+JbFzTHAtUaPP53qAAlh4Z2SP6Il1e96XTbB74VWT?=
 =?us-ascii?Q?ZIri5UONaOMZcqEGX894LIg7fmBguX9VFzEJ5oMd8++06Q+8ghYwnmOtPgGv?=
 =?us-ascii?Q?VImQUxO9CA21VWIDFpn/YtihwsJJn6O2UKujn1saJtKl7RsgBRPd/J87E2fR?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a73ded59-1c48-4433-3dd1-08dc7c06d17b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 15:33:11.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn+tyisOE+xVcRB24xWioCCfk8sfzOujXNRkcOH7IAtAWh3ujaE4fY9UFjlWRwzOwTkUDBMoBqoWkxKseNK0yOfPgQKpR2S0H2LJYeMbwlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10478
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:33:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16262

Hi Khem,

On 5/24/24 5:18 PM, Khem Raj via lists.openembedded.org wrote:
> On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via
> lists.openembedded.org <foss=3D0leil.net@lists.openembedded.org> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> b4[1] is a very nice tool for mail-based contribution. A config[2] file
>> exists to set up a few defaults. We can use it to set the Cc recipients
>> to always add, in our case the mailing list.
>>
>> This shouldn't be necessary if we had a script that b4 prep --auto-to-cc
>> could call to find the mail address(es) to send to. While we could do
>> that, this opens the door to people trying to add a way to notify some
>> people (e.g. a MAINTAINERS file) which is not somewhere the project
>> wants to go right now, and this also makes sure the address is always
>> added even if one forgets to run b4 prep --auto-to-cc (which is part of
>> the typical workflow for U-Boot and Linux kernel, but is not necessary
>> thanks to this patch).
>>
>> [1] https://pypi.org/project/b4/
>> [2] https://b4.docs.kernel.org/en/latest/config.html
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> This adds a basic config file for b4 to avoid to have to add the mailing
>> list by hand. For documentation patches, one will still need to run
>> b4 send --cc docs@lists.yoctoproject.org
>> manually for sending it to the docs ML as well.
>>
>> Note that b4 supports patchwork, c.f.
>> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-s=
ettings
>> though I have no clue what it does with it as I am no maintainer, but
>> maybe something worth having a look at if some maintainer of this repo
>> wants to use b4 to merge stuff?
>=20
> I use b4 regularly for meta-openembedded maintenance and it also updates
> patchwork when patch is accepted, I have this config.
>=20
>     [b4]
>      pw-url =3D "https://patchwork.yoctoproject.org/"
>      pw-key =3D "<mykey>"
>      pw-project =3D "oe"
>      pw-review-state =3D "under-review"
>      pw-accept-state =3D  "accepted"
>      pw-discard-state =3D "rejected"
>      send-series-to =3D "openembedded-devel@lists.openembedded.org"
>=20

Thanks for the example! Would it make sense for me to add the pw parts=20
to this patch as well (in a v2 for example)?

I'm perplexed about the pw-key though. This is very much something we=20
don't want to version nor potentially leak by mistake. I assume it is=20
not possible to add to the global ~/.config/git/config or ~/.gitconfig=20
because the URL would change for example between projects (I assume we=20
may have a different patchwork for OE and YP, but for sure if people=20
maintain kernel stuff as well, then they would have one for kernel.org=20
for example). Mmmm but maybe a simple

git config b4.pw-key "<mykey>"

from within the local git repo would be enough :)

BTW, I see you have -to instead of what I sent (-cc), is there a=20
preference here? (I took Cc since this is what we document in the README).

Cheers,
Quentin

