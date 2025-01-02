Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E045DE77188
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 08:55:56 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.136])
 by mx.groups.io with SMTP id smtpd.web10.5016.1735808147946564360
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 00:55:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=XkjLWLwB;
 spf=pass (domain: weidmueller.com, ip: 40.107.247.136, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTWqC0etkU3NdUhhhfmgYDIjXyExngjMvaXaCdPesWhsvR9Qw3kbr4WOaGEyJIBZq6qI0FY5UnvcjUnEQtoaFveKIyerJJW+eKST/KEvx1hjxmhetsODJCzg4pT0cNcpLVgd3lXmvKmu/ccfnTBAPue/NRfTc5mlfbSNzf/tCgEtW5xx3wEKW/YEhQ0DOR8HqQgoI4+MUGBgCdnl4fzIe8gHuGffTgUt6CaVRA30AKSe+zGHhuTP6Rbz2RaK4VztarRSGTw8Lh6I2zPNmxf3qhbJGIH27khPG3AdtuRr+wDEWV9gMwVefqno8/osj+bEQ6aBAtY30HC/NYFEpa5jYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zscH7Fptrl5PnfVds6l53EzzaC1niqWuCFd53cML/Ow=;
 b=uTa6j+0Y4Jzi47aWbVKRhc5QtPoYwQib2XrORTb7UW/QIXgiBm8Zjt+mti5pY+NPILy/Jt23Tz0Sn+31zTo3CksxN5E3NEUQeje+aqtWRnE2args7b6sm8Jy+3pvMLfvuJcWJ1x7xwbIX6BajFyZGRCm+gI3eGjVvsvAaKkQ82SFqaYkaviyYPB9aL9gGZ7DPMBv6MMu7q7Gcaz6eylZcMacZBg0P05acAwKxIZXVrQF/kHiLMYTgyocOumSUvF1YdRYD7Su8EpFbNVQEUpAiUqaFUdWcPgMV9WEKvQ1mLxM4dULff0Bweb2p9XB1gaSBzsKx7uwEBwU9NM7vQ59xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zscH7Fptrl5PnfVds6l53EzzaC1niqWuCFd53cML/Ow=;
 b=XkjLWLwBGD776JwJd1o6VnCtLMSoqfYVPAIeateaDmXEcxgJOcET3KUG20rZ0G3/NCCXS/VN3gsiJA2/btPrMyLTXK4osT9KdtFYD4NEWpjiZVclpsy1swzj1zQj2+28gLZk7uEFQgwyEbpa1KguATnYkeaThCFBAxSXZVy+dzjGuGw357ILcGHpKPVOCEl40N93aoa2ucsaZ4Iy8/fcNuZ+eZ/n4nd+Xy/T7+DcrDRWBVmedw855/YXDsrfK6fH3v3aNGdEfiBPrNrC/GK1+slkR2kHyhIxLUyp3UEj8mwBvYw9u8E33MLwpIhG0ZoQs1i+B+5V+neDMJkE/0Hf2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM8PR08MB6483.eurprd08.prod.outlook.com (2603:10a6:20b:315::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 08:55:40 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 08:55:40 +0000
Message-ID: <347682f4-d1ce-4f8b-9665-3a3490235d1e@weidmueller.com>
Date: Thu, 2 Jan 2025 09:55:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AM8PR08MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d1cfad-5bb8-4208-1b6c-08dd2b0b3b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?J8b8Hygys2btMXfovw8COLCHDaZUMABbLFiMFSjUnGOAaBecBbG4WiW9Ww8X?=
 =?us-ascii?Q?ke6psm4awqvXq4ELV/TXoG7dhoT0hqSWrVy6mth4S4AxVnMtElAxHmzQt4TJ?=
 =?us-ascii?Q?Cevkh1FQIQdcGzdlc1e+VHaykMx95isX1e1y+dt16gdlU5H53/mykZrV/v9m?=
 =?us-ascii?Q?PZuDwoM0gAYiWH5GhOH49jO6Ka3tXFLtXSE756cOKBKZVy8JLgBU+IiJZ/8k?=
 =?us-ascii?Q?rScOaYv8ZnmnJM/BccUZ7FSTXXWeTgSQEkwuz4IBKxeb3kqIGjwaBOtq0F4A?=
 =?us-ascii?Q?3I+8t5E9lphxALEjIg37xs4pyXorWRAycDRHqd9yItq55Dzln1xgNzIvK9A+?=
 =?us-ascii?Q?Lz1XTiNTR9ISOXaSnstjz0qkhvdeTakThvWutWUzdbBVdPxstRHwMGZcbEzo?=
 =?us-ascii?Q?95Alhr7GFVw8/q73vURtzFC1/ngiS5+VBAW8OgRfBFPLDlq4ZF3oGPqV8DN/?=
 =?us-ascii?Q?lMGoNxqbGQCnByXWHiQYIPlDaHxaKK2fNWVm5erlKvBlaGCFFYnaKPtncjH1?=
 =?us-ascii?Q?zeq141y55binidc7Iy8ftpt/U77YC4QnihgL5QJChheugqLKU+FA8FG5a5hf?=
 =?us-ascii?Q?rOumLqWb/daIOpbP2kobksii2R3i4mjMdfD8Ou9UQB/XSLO1EtmU/Zvf9Sbo?=
 =?us-ascii?Q?yZzqZeEA21Uhst+VOhvSBbknR/rR5VatFFCka8rCqpY8J2DO3tRgBLlSZhNr?=
 =?us-ascii?Q?jJ+6MVWJC1rqVCtOHuXnxcECiyVLy+3jM991viMG5T8LuYt6O1R2lXZgdWik?=
 =?us-ascii?Q?SaNGc7AK71kETVfJ17thAX3/BECo1UtotxCWRq2Nx1HB1Rzy/iwSAgbBHuL4?=
 =?us-ascii?Q?aw/dwf1VEM+8v3gBFZ/HG042anCozTEUygjUGaTNxXwfglO9vnDsvZJi6oKc?=
 =?us-ascii?Q?v9+TvLg3bgJZ7YiKI0vch9tvegqiBmWBJjlxH3T2doky/99K4zEnx2I7+7iq?=
 =?us-ascii?Q?XxLmDEoeB3ha4H1GyGQ9ZFjsyVnUT8FtDhNetY7S7d1iFLz6wMVEsuhx3WRq?=
 =?us-ascii?Q?2vOLVCueUq9Y+F3p3ihuPqsFBulQzLc4mnTYchst5jz6DDvsfGRGKKpwFrZo?=
 =?us-ascii?Q?FSQVDgJatELsclhg5NEyMDmWr7j1ycQVA2FezcruLQ9oya/7AewH3I1b8Rit?=
 =?us-ascii?Q?aarWr4FpjE/umb1J4hD36r/oz+TvRBP7D+dMCOCCx18udhNaqdNJV4Q7+2dQ?=
 =?us-ascii?Q?aSorZix0BwhiHjq4OfS6qnT7l/e6+rLzYfTOjGMnv8YvNOXwk/3fzok9Vn7W?=
 =?us-ascii?Q?cZFAqLhMzRmVPnWQqmDFm72H2C0EnhXlGjIzLocuw8MR1/EFRzFM+Ec44GZ2?=
 =?us-ascii?Q?Z7jM2IuvttBWYO6Ulesvwbuay211m2t2yl0TZfvB4v73Ag=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vg8FSNcKRCaq0rvDKV0erHAJJS48dNR1If6hOywuCz/8DNZBW9jzLsW/9mBh?=
 =?us-ascii?Q?NTOKr25mvESELd+/Z5o9V+ZEK2PXXzM4cpz1Xb/fFYyupHadCW64TpmQc68G?=
 =?us-ascii?Q?9fm5z08tqsgKFBDuJaux+EzL3H2TzmGtv8qxdE3fxV4z5Jpcr7H0ZZ3eSEz1?=
 =?us-ascii?Q?jqut0H0U4a76BrwnXTob/RvCU5DMk0dTl33G+mwbPRCvFJZTDdwgUMSb9FDq?=
 =?us-ascii?Q?+4QI3MfcAC72PJg0GvnI8i5Zu9wX/2jVr2NA68vWVCbJ8Zm49uy4ediQRYi7?=
 =?us-ascii?Q?9R5Ih0gk2XC8CZFc/UBV1hoCXgAa1LKHq3mm8oEH7gbNga7vxw3W8i/C1Gc2?=
 =?us-ascii?Q?oRZTrN93v2Hf70p4k5JfUrd2IHG+4CO6h8ds1d6jYjX+CUs+G4X3Pa0UklNt?=
 =?us-ascii?Q?zyrZt2EagZRfbfcrsggG/q/I+gz9cJzgjI8wIZtlkUsN+HSjE6NhRW//srfB?=
 =?us-ascii?Q?1URUGr6UFkE0PKG7zJZez9CUuyXUtVaDWIBvuC/rYn1pspiMyBEswsnOAenX?=
 =?us-ascii?Q?XPM5153mxnUXHkltmjXA+ScGjxiIZz8WtPqmzT+zlz1sGQuiHkGhoYv/qcwQ?=
 =?us-ascii?Q?iDMgmG9XMOtvXfjprcj4v2I34NlHGIwt/yr2xjqDccVYF3vihx6i1HX/eKN6?=
 =?us-ascii?Q?X1GczS3+pB0uLm8Kzj1XEDm0G5uLXdVUX3PeBTwgMydtvsEUeBFrisA9V/Uf?=
 =?us-ascii?Q?Jx3gLlIV1eRX40ZFwgZvmqoTqcsw58lAxf689TXu/yq5N5RjC2XrdB584mJC?=
 =?us-ascii?Q?UM84cDy1R3lv5P1YVYHyAtwmFUcbwgQUiyQUmGJHPSBaU7XYns+FyGeoTfDg?=
 =?us-ascii?Q?/NMpfywglhu+WRRTVSuxtos/yYB9G2dfA16hlRonKrPuhvgwQR8lEkLYEzUC?=
 =?us-ascii?Q?N2WtMBmevSuEKOW+aPb+kOYArLr8pD7uxvnrEsSKJiRAb53nTWUNB/MOX93h?=
 =?us-ascii?Q?TXy//MfSVBbaGZc6ot6MPxpVSwF/a2suwGrdqkgPLT2MvarAiT8vICKALDtL?=
 =?us-ascii?Q?e3caHJn9vSPgukRO19vwF4tJETc1yu54MQwhQKIvPPbJzYpxYkOxa74V8hCi?=
 =?us-ascii?Q?6X8BUxKUj4OhuTmAS7HRQUCBwskFFURqyHGBEVsOR3ei7yV+pKvKQe53q1kv?=
 =?us-ascii?Q?Fiab83aF3jIiXaVbOJJ4MRPVAF2TQKpo0wVjtDLehoL2YCdmOEWSapwR2Cn8?=
 =?us-ascii?Q?oHan9LNIQoZkTt5H4lBAMYxtxXa25f0pFF8C/2VPLBk7GREVO8s2temuMzHm?=
 =?us-ascii?Q?rVa6yQ+paaLpfeY0D8cVSqtIihJyYNOEsRFV857kbyktzpdKIyRMktdDbyCL?=
 =?us-ascii?Q?kljDpIUe7Pif5gFTUNp3ncB9VS49ZfnHpWRlq9pxAcX2fr9ekMQvHQ6H9Bb6?=
 =?us-ascii?Q?t8CM7BkwtAzQc4wQfbVXbWW1jVEth5vNl74vG7oKI460jHRvecQJ5ZTcOOHQ?=
 =?us-ascii?Q?SyaWBADerCiuG56aCIsvxDAptZ7tpr7/nh+mLc+QryC/MJJkHRJ4UQsjlvbk?=
 =?us-ascii?Q?Cw7bXxBSabutKoJ/tQNhNgZLv/zBieVNtmSxyN75C8FV2ExDX9XrQE3Uylgb?=
 =?us-ascii?Q?vPCaEfFBlYucl6g9e9X5BEVFJLO8hFtUEvKwdIrl251lzL9UKDHMIXyw5PLY?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d1cfad-5bb8-4208-1b6c-08dd2b0b3b94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 08:55:40.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTtH4wb0SSv0t8HUeEd9x5izhimA6BvN497o+9J46Xu8STy3GyO5PFj/I9ydzIxQWVihvN3wTxJWDV0fKBB/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6483
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 08:55:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16955

Am 23.12.2024 um 11:03 schrieb Richard Purdie via lists.openembedded.org:
> On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.opene=
mbedded.org wrote:
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
>> SRC_URI =3D "<type>+http://example.com/=C2=A0npm-shrinkwrap.json"
>> SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;subdi=
r=3D${BP}"
>> SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"
>>
>> Additionally, the patch series reworks the npm fetcher to work without a
>> npm binary and external package repository. It adds support for a common
>> dependency name and version schema to integrate the dependencies into
>> the SBOM.
> This certainly sounds promising, thanks for working on it. It will take
> me a bit of time to digest the changes.
>
> A while back I was asked to document the constraints the fetchers
> operate within and I documented this here:
>
> https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/fetch2/README
>
> Would you be able to check if this work meets the criteria set out
> there and if not, what the differences are?

The fetchers inheritance existing fetchers and reuse existent=20
functionality. The npm fetcher inheritance the wget fetcher and only=20
override the urldata_init and latest_versionstring function. The=20
reworked urldata_init=C2=A0 function preprocess the url and works without=20
internet access. The dependency mixin is inspired by the gitsm fetcher.=20
The cargolock, gosum and npmsw fetcher inherit the local, wget and git=20
fetcher. They forward the function calls to the parent class, process=20
the dependency specification file and handle the dependencies if needed.=20
Thereby the content of the specification file is translated into source=20
urls for existing fetchers and saved inside a proxy object. The user has=20
to call the download function to download the main source with=20
specification file and all dependencies. The dependencies are downloaded=20
via existing fetchers.

Because of the reuse of existing fetchers all criteria should be=20
satisfied by the new fetcher or need to be fixed inside the existing=20
fetchers.


