Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41056C02198
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 16:22:06 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.139])
 by mx.groups.io with SMTP id smtpd.web11.45754.1738858923176783680
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Feb 2025 08:22:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=qtYu7P8u;
 spf=pass (domain: weidmueller.com, ip: 40.107.247.139, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrevVBzt/VN3cy2CxI6W0p4DA1q1LqQPAc+7pXESvp1HXT2N5L6rQ/jfoE0N8ltjJ35xkn1qpAO/wX5r8jKCCmTMg8jtUkihC0SqfTxrb/F4qG2qHKC1f6mFYNELwf7crbFfwhZozFS96LR8d/IEK1KUBtTHFQLSB/X/PQReQPItl/3d4/JJrj3piyjetmIL8bQE3kukm94TnxV6LaDbF6W8kI+XzG0TDqdWGMixG94KeFOrG4QCVQDMsIWkrFB/fFJjpLONbEa6N4f80iAwMmY0U4i49J3FwwzLn/tSKAnbhZqmeAL3rgTGPjeB98jWg1C770o7gnCVQ6LOOhVOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0S0EHZvlJSUOYnHJgcodxP2TbO6PjY+3s/MBd48p00=;
 b=gR2PbPb6CBvY/jOv6wh/3Jq1o7ZNWsuA2kxGJ02L6C9lnKg/M62jwX6vdB4fOqMCC89hRbegyES4XclnjXDGYG/4siY3bFhHedOm+jgkMPG4+dq18Hyucr+nr1Y92c5vegpUg9TkKHd0GLwEvPvWL2d0rXCeLZkH2Ppih7Vgi6zkyAtnZxv8KcP00PZDTVgrKqU0H7+HdmoKTa2w8kDEI4dI7pB73GVpPHv7KzRHpXNMpfxL3TPoZJARekZKHuC6k99m20uHTsDJsYLJCMhSJfx3moNw+xVfDueb14dHj0oBPAYfMLR506itM9sq/j39UkPPHS0fJuaToU4l/tpxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0S0EHZvlJSUOYnHJgcodxP2TbO6PjY+3s/MBd48p00=;
 b=qtYu7P8uW/DXHzWN/ohR8D6dkFURZtRgfDiUBINlFzx8YMl77q/Quxa527Bhg+8zFmsYypjzo94Rnp8zGDSZr8P9cak9V9T6ihvkeJiujat/G8ivFus9tD7pl96ntaqYdqvJlZvIHk9rgYo6bVen1uzETrrCy8hkCm5ipNZ1EnOExDbzfY7yPUoWspik4vrz+9oKpK3jk0KiVLSZOQ+QygVdIvlfLAvV4Q0k6F4KCOeOmPZCOfaSdOCori7Rra8JYgc5Z8uEdoBTzvczbueDGnY5flegqwgu34xr+AD1srbt+/9K+urAgJXhmLbUoUfMDMALDWKG9nTFyOKMY7/pvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DU0PR08MB8882.eurprd08.prod.outlook.com (2603:10a6:10:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Thu, 6 Feb
 2025 16:21:59 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 16:21:58 +0000
Message-ID: <65b6db34-277e-4405-bd0e-50e4ef1910b9@weidmueller.com>
Date: Thu, 6 Feb 2025 17:21:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 08/15] fetch2: use localpath instead
 of localfile
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250205071538.2681-9-stefan.herbrechtsmeier-oss@weidmueller.com>
 <7314b5c9248b9c1b73de6133dc34cf31bf41d43f.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <7314b5c9248b9c1b73de6133dc34cf31bf41d43f.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DU0PR08MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 02261aac-1f71-4ae7-c0b5-08dd46ca6130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yJ/vIo35GFlzpQBu5YWHiVuipkn1P2lPSL1yPk/ekbV9OKHfLAZzwIKgDlMp?=
 =?us-ascii?Q?uec1AMOvDTWHbeFKPLHyn4s1phytBAWDrBqLOXb4Z+YAYLpNYBAG4WP2JKwq?=
 =?us-ascii?Q?DKPnkMizp4awVTJeUuIPOJbvWpoWQ3cd2mffKZMLm15ZyXgVl3vP2bDEZS2m?=
 =?us-ascii?Q?S02EB43xQ9lIChMXOTVlwFdZLVEEznBBotM7qd4//UShxcxqzXiazHk2RHB9?=
 =?us-ascii?Q?I4pABYQBTVCw2pB0JKFL3JyxAfQyMOjn1diL/7e/oJczONkIm+VSWz1pPToa?=
 =?us-ascii?Q?2I+T+LGvbyBdkleN0Pys0XB7vo8Fe2TOicBRmDgZEkU9b8od24lAu5FRUDJw?=
 =?us-ascii?Q?FfIcKF8PGbHiSL02NO3eDG8O86E+3s/nft8LyERIHM7nFLLDPSHii2KF+8Gb?=
 =?us-ascii?Q?la7e4HUsoMpNHek3Y7PaWMsdgGGphk7dEIwFDKgoDRrL82nxkMGnNf+mdkg5?=
 =?us-ascii?Q?WLWK0UjZnEo/lKT7K8YKoAgwfGzLAVC9CAAbm3FiTv7a77IzqE+wxo/UFu32?=
 =?us-ascii?Q?7FPw5Vqw90XUk3RWl/Jo/o5/JG128oFZaWvEtGHbK/GhPw34Ebl600CRqAJs?=
 =?us-ascii?Q?zYv0v4bRJYpayx2kfzq8X6/mfnAsSmwx/11EV0JA0CA52MgMAw6sK9d7ERcg?=
 =?us-ascii?Q?yovUr9qJ6ScWYT8+AX8IMVcjYahuYGqGutY+bUbsOm6VbOuK50pa7Jb0terQ?=
 =?us-ascii?Q?13P+DXDkquSUVPhcLeQRv9UnnSDY8Gl015VvaQBNZ6wM4xHqVWPjnMTvJMc6?=
 =?us-ascii?Q?u8nh9dKyok0ECfPuE/vey+WGwAjl2A8kB3nYpAmhF7uc/2bazwrPIQyWNRnM?=
 =?us-ascii?Q?yta6AqqopIVj25SrEN+RRVIf5jeI++GWiVS056LHW4h3Z85J7w4lK6XV4f0u?=
 =?us-ascii?Q?JiZA+ibFcPGYMMN/MM2bplMiRe4Tm+RD39Hi0+rJDjky+PIc/W/JBcdOWk2S?=
 =?us-ascii?Q?rsho2Ao8I5VWNyILlmoBDjKQZElYkmet2UZGMSWrGwSp8a/MQPlZkNfXNDgQ?=
 =?us-ascii?Q?5YfYPgQ8qAZhmvvLnx+Ys/Ui0oaXAeF9DjYPCJuUd7BNOO2fYyrwZ6ItWiUx?=
 =?us-ascii?Q?8Q7+Z96NjxweTxxdMlxoKZXlidfGLBRdx89CukqCLSGRdV3Apna2r7+JNJGW?=
 =?us-ascii?Q?E6aBuEyQrU9vzW30/VcnQ74TQ7UueojuHjxtoGSm9zaZOH7IEpEucDV/wSVa?=
 =?us-ascii?Q?7c5Iq2xKbdrKwxFB2wTzEMOQbJw5olyG0mW/u4jfWP2Ktm3ud4hibeejbLeO?=
 =?us-ascii?Q?Ro3K34PpVdQ3KAUTGO+VV/9ms1BkjIkI4BFuRbJsyt4t+WSNjfhrEW3FlUui?=
 =?us-ascii?Q?GyJzn0cJ9NU8HsnpyGw704iqYIh0CKes71r81VUewJHhfw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YZS2S/yFIXChKzKPXNyAw1V+AMtXlhUgP+jv78BnfwDCsR1Dd+LJZsz67Igl?=
 =?us-ascii?Q?/CfpdMD6Lj9OZvb5rl7nBZneXUoIN2CDVBigQYtqPpJof6+392VmH3WXMJoH?=
 =?us-ascii?Q?1Vf6ddLg8HUd+x2wm8dC3qOunbS9ZxTnDf6VX1NeM6gcTTNTH1TysS5gGNPO?=
 =?us-ascii?Q?FvMa8McV8MccmGtOl9OEWYta4Qyf8XORePci19faOSNAK8L4OS3nVqwW5xFX?=
 =?us-ascii?Q?jcphCF9GXQ8z972WtvY60pLQX2eC/ORz6Ko+gbO32W9ixNLexQbz3CiMGsCN?=
 =?us-ascii?Q?91kZSDvUqsuh0wjuzZCXeO64l3iCwg1s6N81FFUhQtpC9AmT8vnhTkS44mJW?=
 =?us-ascii?Q?c7aDN/kOZSd9+vzeFCOPTbTmj3KD70zDkNNR2LETvORyjKfDntUAaHVoGYkG?=
 =?us-ascii?Q?kPvB8qcuACB8f8I6LoRhLYkoEfPkTRCWW8GIwZVomFPqV6xi3+IGvAS1Ypfd?=
 =?us-ascii?Q?nof/CvJBNbiOvyoMxwnP9J7tHIc/Ky5L6snqaFXPSurkXlEE3gjjuAO+whd1?=
 =?us-ascii?Q?S/HzpA7k6/EClLZpeiQBHM0DF3KUe+eTbd4Z8aQ8KNWpm1m2Ny8LbBn+XxIM?=
 =?us-ascii?Q?pnf4wCDQOPe7/KZPpbmUaFHwV/YS+D+5Pv1+MBI+hnn+oMgX40hRk5ZLb0zl?=
 =?us-ascii?Q?MZ9EhxK3BIn2Q/MCUJ0YIzu5QEfizkPP9t7vFZAfX8/cwdS412adPj1yASV0?=
 =?us-ascii?Q?spOcUXKrhYKG1ZHvtXFlwGApvFcjq15n+1pXt6DPPLBA4Wu9QcXD6xIQHNWB?=
 =?us-ascii?Q?Uw4WZ8RsPjEYNhK+iH6YZiNAyp4CtRPMwpy9bwxOpn2pMMIFS2mJVGTTQ09J?=
 =?us-ascii?Q?TzxKfNDDfnWHvB0XhpQfNTiZAgFACzrO1VwpD9L3y2IYi/BGJfqAnIcyX1KP?=
 =?us-ascii?Q?W5ChvEeQTY0lAlxP50eYJQ/m7+A5B7VS3RT08PIif+mVyil9VXgMx2bWeq3l?=
 =?us-ascii?Q?3VpHMVeLcAxLZw+Laa9cHbiacRltwD13F684ZRPcWyA1L+krSvuYHYaGaIs1?=
 =?us-ascii?Q?kT7oBg5NLFv3aSJj2sgx7EBEjM5Nke5MB/vU43+14QHygRRoRdtsKPPsXKgV?=
 =?us-ascii?Q?syFiS55IqSF5z6pYF2QsPn3uUb52RuNWFKJqUGYI/ryHogNd9uSLdVWn9dk7?=
 =?us-ascii?Q?XmwOXym7Vs2zhZdDptMLa3nkd70phNoJdh3aMFJPFBjPB2RNEL0lUbLptYcv?=
 =?us-ascii?Q?iaj18rqH0RSByTanVWHn8psSJs6WUETnA2TXG06SQH+fGZ2NHO5Ob+T7p1tE?=
 =?us-ascii?Q?PKhLdL3sk9ewg+OY+nvX05FXPMHPNbVfU2f6K4YLbvZ1dN/EfpCRps5GSAjL?=
 =?us-ascii?Q?gJWIYZFKL4jesT7H0pc0ObyDqqFtjElC7nYiBJPyS5c4AotJogsAc9lJqbh5?=
 =?us-ascii?Q?HS9afejhGw3vyW7kH7xpR3eeJZgu+KVG9/bSg+FzcpOG7mqMJJcridH6D4WL?=
 =?us-ascii?Q?GFH8Up6wF7+OWLCR8MokxwPtAYx5xpoOlSDVDKkAthHHPOceorgwzV3NFH06?=
 =?us-ascii?Q?FcwGfmZ1pr+hPOX6Z1NOYBBmaoy6geb+2582iwEM2YhiJ4KpOdrUhg2P8Umw?=
 =?us-ascii?Q?+Mca3TCjqXulqUvLABR9K8nxbReooW5L23RzJlDUnudKW8etMhQTzJwB7lFc?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02261aac-1f71-4ae7-c0b5-08dd46ca6130
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 16:21:58.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BH+GQPD4fRCnAvgogV3pN9YNwnyR1wXrfn6+De6VTYSOh4q9LNUZ2M+bmpOV7W+qe2hNfwaBI4+X8J695R99Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8882
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Feb 2025 16:22:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17162

Am 06.02.2025 um 16:26 schrieb Richard Purdie:
> On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.opene=
mbedded.org wrote:
>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>>
>> Use localpath variable instead of localfile and DL_DIR variable.
>>
>> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmuelle=
r.com>
>> ---
>>
>>  =C2=A0lib/bb/fetch2/az.py=C2=A0=C2=A0 | 3 +--
>>  =C2=A0lib/bb/fetch2/repo.py | 2 +-
>>  =C2=A0lib/bb/fetch2/sftp.py=C2=A0| 3 +--
>>  =C2=A0lib/bb/fetch2/wget.py | 2 +-
>>  =C2=A04 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
>> index 346124a8b..1f0f1337a 100644
>> --- a/lib/bb/fetch2/az.py
>> +++ b/lib/bb/fetch2/az.py
>> @@ -49,8 +49,7 @@ class Az(Wget):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd =3D self.base=
cmd + ' --retry-connrefused --waitretry=3D5'
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # We need to provide a=
 localpath to avoid wget using the SAS
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ud.localfile either has th=
e downloadfilename or ud.path
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D os.path.join(d=
.getVar("DL_DIR"), ud.localfile)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D ud.localpath
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.mkdirhier(os.=
path.dirname(localpath))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd +=3D " -O %s"=
 % shlex.quote(localpath)
>>  =20
>> diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
>> index fa4cb8149..5c0edf1f2 100644
>> --- a/lib/bb/fetch2/repo.py
>> +++ b/lib/bb/fetch2/repo.py
>> @@ -46,7 +46,7 @@ class Repo(FetchMethod):
>>  =C2=A0=C2=A0=C2=A0=C2=A0 def download(self, ud, d):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Fetch url"""
>>  =20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.access(os.path.join(d.=
getVar("DL_DIR"), ud.localfile), os.R_OK):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.access(ud.localpath, o=
s.R_OK):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 logger.debug("%s already exists (or was stashed). Skipping repo init / =
sync.", ud.localpath)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return
>>  =20
>> diff --git a/lib/bb/fetch2/sftp.py=C2=A0b/lib/bb/fetch2/sftp.py
>> index 2a2a70a1b..b88dc5a28 100644
>> --- a/lib/bb/fetch2/sftp.py
>> +++ b/lib/bb/fetch2/sftp.py
>> @@ -82,8 +82,7 @@ class SFTP(FetchMethod):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 port =3D '-P %d' % urlo.port
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 urlo.port =3D None
>>  =20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dldir =3D d.getVar('DL_DIR')
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpath =3D os.path.join(dldir=
, ud.localfile)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpath =3D ud.localpath
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 user =3D ''
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if urlo.userinfo:
>> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
>> index 161c66bea..1194f0e7a 100644
>> --- a/lib/bb/fetch2/wget.py
>> +++ b/lib/bb/fetch2/wget.py
>> @@ -95,7 +95,7 @@ class Wget(FetchMethod):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd =3D self.base=
cmd
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dldir =3D os.path.real=
path(d.getVar("DL_DIR"))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D os.path.join(d=
ldir, ud.localfile) + ".tmp"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D ud.localpath +=
 ".tmp"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.mkdirhier(os.=
path.dirname(localpath))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd +=3D " -O %s"=
 % shlex.quote(localpath)
>>  =20
>>
>
> I put the first 8 patches of this series into a test branch and ran it
> against the autobuilder. It fails to parse, unable to find files :(.

Thanks for the test.

> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/st=
eps/13/logs/stdio
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/st=
eps/13/logs/errors
>
> That suggests there is some breaking change in here unfortunately.

I assume the @ in the filename is interpreter as username separator . I=20
will look into it and add a test to the selftest.


