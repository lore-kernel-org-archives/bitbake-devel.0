Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF54FC433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 10:46:44 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.78])
 by mx.groups.io with SMTP id smtpd.web12.8216.1637059602773546428
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Nov 2021 02:46:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=FQsyX0Kb;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.1.78,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmLn+1mtDG9hyyEJ5w19EQv8QHBTfgOj5NuJEWApfb76+Vo6UL+AfJemCi1yVzvbaXWcI1RotQdMZCBCAy69FTVK9BEwxBAnI83/B8467HHEIP4uslw9W9eatp0rWzF95m4O6Pt21MTJay6EfzYKOH774Q2NXAv5wPtHy/m+8tK+hlUBwhockCxSNi7T7FC77MZEf47Yb0J7qiWNvw5Mru3loNLHOJwFqeRwhPvlHcWPmiTkKCYmUMOtzH+JwCtGtM97ivXnB+WMViJih6BIgGfyOkkrfhkPvLBec4d/P97Eo9g4wMgKSPWRbL0vQQ+lPf3fupfdRtqzCFmImSfGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve0f8NTxbRZ/UGbLH1N/ndlI91wGAmS3jS8GFQkDt+Q=;
 b=KGDPIWlD1mOHMy3lWcnJC5OKKpwZNKqhjq9fpONUUcEKl+cXAyfwq2JVtKM6BPtSQSJgjDo9EuXAi6KV+N7TComNF5tBEyUoXVLY9mViTz39xJof3fdzNYuWnarE+t2r/c63akyu9p4QQLckgTUfHPBV0xjjjiuALguYTYul1TDfy7JAFo1MFkRZZsP0Wejwn+3H4bbpkrrPO3zvyu7Ax3gdAMDjS9g/KHX8d+QV5gcX63Jk+hjYjDd2m6BMOP+mp1N84JXB/EHjcv1zF2/fnvvNECn0NnWLBc9iyhrs35uqALhwboQoXGBlQH6NF1EIvZ0rbyoK1Dzb0CyOr/Ue7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve0f8NTxbRZ/UGbLH1N/ndlI91wGAmS3jS8GFQkDt+Q=;
 b=FQsyX0Kbli8dhQz/vmywov+oCK9tLDrvNS9tJEiJtRheAjELFxCMxxyh5PKZjKVPtb27l7BZoiuojaPI6I/3iMuNv5vRCD8Kb/+hwTbqB8d/UMrS0s3/qSC2lk1ak7l7xIYnEGVgpzusg/7eLOW4T4M1c7Lt2mvWArOlygHOoJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB4433.eurprd04.prod.outlook.com
 (2603:10a6:208:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.22; Tue, 16 Nov
 2021 10:46:39 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 10:46:39 +0000
Date: Tue, 16 Nov 2021 11:46:36 +0100
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: mohammed aqdam <mohammedaqdam@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	bitbake-devel+help@lists.openembedded.org
Subject: Re: [bitbake-devel] Use of FSL_EULA_FILE_MD5SUMS_append with latest
 bitbake(master)
Message-ID: <20211116104636.ryxoflji4bgfb5ap@fedora>
References: 
 <CAGsrAHdBHjCn5Onwczj12UHAbsHm_tdh1FKdY_g7kq_W=3VGPw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <CAGsrAHdBHjCn5Onwczj12UHAbsHm_tdh1FKdY_g7kq_W=3VGPw@mail.gmail.com>
X-ClientProxiedBy: AM6PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::16) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AM6PR04CA0003.eurprd04.prod.outlook.com (2603:10a6:20b:92::16) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Tue, 16 Nov 2021 10:46:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ed29421-6517-4263-af70-08d9a8ee5e66
X-MS-TrafficTypeDiagnostic: AM0PR04MB4433:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB44334875625F4A91F9FE6324C2999@AM0PR04MB4433.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QNkG2ucBSa3XSU9KQuaBCmOG/C21cXnuAJMcM2iP4qCinTENkbU6mnu/d2S3a6OHr9Z2Dmu4FFKma5e4BjyTC1RDMMxr4X3X9AxU/tPR0H0ypGSqMckJUEjx1DaGBzc1ui+0PqaYft5BT30XximnpyPDnb+jU/6XlcFTaJZQhzfPCPGv8QJHyxVdrH7XSinqAY17G6+9znQfvvCLcfebPmy31N78SqNSwFoKex8bcllBiNzQF2cK9xP05TkawPKD/Ct6G7+crRQeG4VnBwsrDnDY2rWGfVMCzP4BR8DkNkulkonxFkelvBDus2wlkgfRB/4WELyD4UGl3Ky/HgUUeJ/udpE7PucL9EkKibjJ/nKXLgHP2fiLqvdzCw11ITttcDOdO6FKoKlBELKFwFfBK94ATwuN0tkOWoAJhT9EjVKpxOEaPdNz9JZqCduz6Pe00dvl5u9YchxKgx1qYUbz5zDpnpApWcQj80aLRccULTzm+FpWYoglFQgr1TKyP8uTUhOwKtm0FxvhWWQgHNSYkJF0KS3BgCoc3Kzdr4dsfEYKWz2oU96otBhDDU6S14e4FW387aVtZmJTRUu/4yFnxFY6qCeTTF4jjH++0/IAENqXRzoaczd4jXlRo54bCEbTUCLEYJeA5aS4L5kXLsz1LECnuj1G+f7ChgLTl40/8UaA/b94FbCT1a1lCgaeLFYlo6eX/xrrQfeL/YrrQDZAS1zbZ+XsPIjqC6yzPF+Pnml4aL5aRs0yFlMPzUWqdNdCTWbSG3FJqai05vi/Hi01qc/Upvi5XuqLip+TamLuD/c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(4326008)(66476007)(508600001)(8936002)(316002)(33716001)(38100700002)(26005)(956004)(6916009)(38350700002)(1076003)(186003)(55016002)(9576002)(86362001)(83380400001)(2906002)(6496006)(8676002)(5660300002)(966005)(9686003)(44832011)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tfTGTO/RGFRW/HpKIL839vghyboRkNljzyFma8gI90WdZvl4ZYFET+NFc3PE?=
 =?us-ascii?Q?LFYkQwAtp99pBfKr87+3Zc+z6snwIXTmGnhMjhucS5vbr/gxFx8VJorFaaZX?=
 =?us-ascii?Q?lDxSwr0CRA3XW+U5ktwFoYMzUTC+Wo+Q1kKdHjhOMa0dctIDltv2WQLDt1ET?=
 =?us-ascii?Q?T64ZFDo8Vyw1S2FREhImefCesXx2c6Ep9VQuRqRsqhi/IEtSCvHr9RznTrtx?=
 =?us-ascii?Q?8syDyMjqbAnrqqWWplzcfBxz16De5GA/86iZcYPAl5fUOGJSOcqHhoE81rhY?=
 =?us-ascii?Q?IrrcHSwI2q0QD+Z0jDnAdi6lHF4L/IRAxUBGuHmolcNhua2mChki5av6gRxV?=
 =?us-ascii?Q?YaUfTw7BGLMjO/FjN6hwEGVbvm3UJWi90b+fnRaIXwdegAZ4fNm4CmDEOBiI?=
 =?us-ascii?Q?3n5tliGmCmA/voqxzlO5CsDQj9LPovSD5OcoBeKmmjDUxl/oD+F/VQwptb6q?=
 =?us-ascii?Q?GAgyUTWX3kQ4LEJyEak2fGcoFVJsWyh5ceUKB5LYTXXcVwpM16F+4YImU61T?=
 =?us-ascii?Q?1nFEgUIQWfWCy9S5Zhulcn8OB1MadGyI7PvYXkHhOJ83TH+65ITspLWwCV6P?=
 =?us-ascii?Q?VDj8EOEbtSoXYLFVgyYm2Qq7H00L0uNKXgGLOJWpsLJx9UnxZrE+c+oToVAj?=
 =?us-ascii?Q?0WR/Xm1ul+D3oPW65z+cmOuF2dbJ0YOH9Da4TT6Mbzou9fD5FAnhVxCFkdbv?=
 =?us-ascii?Q?Zf7rgAsDtc7nk0mC2kybLNdyTOeneJjnwxdC7bsODt8OSZwNraoIdO5ZGqbC?=
 =?us-ascii?Q?eN0NP2oa6gMvuPd25qsopJ/QRuj8nYZEZuZv/hQDEhL7Pv/qfsxzTZxcVUFa?=
 =?us-ascii?Q?S5hBHcpVxgcwP70CKh/7FoLg9NBAggP8VTdkmAYDyHY2tGWj18yvGX1GMAyk?=
 =?us-ascii?Q?/shApur/yOs4HRCyQbB5K4oUT4g8iBnDQI46/B8odVybFC/yoQbMD1L1wUd6?=
 =?us-ascii?Q?n+Wgh31qzkFDKWOQ4S4lBvOvi2bpCBR/jTqMvDj8xxQ5B6vYP+T6CAChOxNP?=
 =?us-ascii?Q?rApIp2Hm7dHe0FLZpaEA1nId4UsKA4vc/07j/UW0ccm9bS0w5sB/PxoAnjXn?=
 =?us-ascii?Q?+I50JxQ1GEVFUG3VQKiLQdki2ob0UcLKxg5tx4EpQaoxb++dwyz5n0rDJZAp?=
 =?us-ascii?Q?z0y9pWap7FoqyrQ0KSgDPjAnoXOEDGbNwusUbmGfaqlVjHkAcqSXG4dBN3TK?=
 =?us-ascii?Q?2gKVmZDeltz1QNIUoSV7vSvJH9U+qdX/d4X4z47Iwx9eiqWhKg5tlmJqdJzA?=
 =?us-ascii?Q?PknR0jWZS4rUVWS94wRzHTBeXSpSB4ZrkniG7xSm+wrS0GoQd5M2J1eCeoJ/?=
 =?us-ascii?Q?Ccp7v/bwO3jfgsKgPpdG+jz2ooq2AI4XQjVn5c3LLID/3RZU3+DiaMDJLkon?=
 =?us-ascii?Q?zX3rPeRP8qB6ZIh3E2oY/ydBrLI/385sBixicpqyQLSoc0i63BnL1Yg8i9Ii?=
 =?us-ascii?Q?uM0olB8AObLPpFUWNO/PQy4HIejRfGFoUCpZLTxZzGUB8YdfLjCzewwG4Pvr?=
 =?us-ascii?Q?aYWsEySAj4GyU36k+XlPL4/5LTLvJ5qBMDSeV4dRpyo9fWFme0y9v/Wc9XGD?=
 =?us-ascii?Q?pCxoRD3GcDjmLkIOjSPIrv42G0II3m6TTpU01mG8Yt6Gio1wNuc6yhi62qFT?=
 =?us-ascii?Q?onWeJMR1/HEnriMVEHGCPqyCfUM78ziysJMcJu4s+6g2PoENyq6/lfA2ZDVP?=
 =?us-ascii?Q?dpkb/k5FjP55cbgbyTgYK87qDdYEFypNmkqWrKbEV5Ubj4YB+pu3KM796bCE?=
 =?us-ascii?Q?PElNmzQvkw=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0ed29421-6517-4263-af70-08d9a8ee5e66
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 10:46:39.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 cpsmwr/zqTZnRZ46n8Hk6x20geJseR4qoRJC5x4yPt8RasSkM0N/ryt7hA0zLQSbW9PkrY2ff2fe2u1UZDqSUmvgCXQTnbO2ko6fBPaepb2u1z/MzN++kCCQwKskAa4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4433
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 10:46:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13058

Hi Mohammed,

On Tue, Nov 16, 2021 at 11:32:41AM +0530, mohammed aqdam wrote:
> Hi There,
> 
> I am working on a yocto image for the imx8 board, for this I have created a
> project with zeus layers for all layers(including meta-imx) using the below
> manifest file.
> 
> repo init -u https://urldefense.proofpoint.com/v2/url?u=https-3A__source.codeaurora.org_external_imx_imx-2Dmanifest&d=DwIBaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=vPekFtBCWH-ycaf2_zSJFByHD-jIBQ83qmmRwMlsQS2flAX8x4OwQWD1fT-XxHC4&s=gqaRsn9hMd4BuXixlk1z3IArRZ3lzWKsmD17u8jJjDI&e=  -b
> imx-linux-zeus -m imx-5.4.47-2.2.0.xml
> 
> 
> I am trying to fetch master/honister code of openEmbedded on my
> existing project(Earlier i was using Zeus branch) to use latest modules of
> perl(5.34.0), chrony(4.1) & gpsd(gpsd 3.23.1
> <https://urldefense.proofpoint.com/v2/url?u=http-3A__layers.openembedded.org_layerindex_recipe_1120_&d=DwIBaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=vPekFtBCWH-ycaf2_zSJFByHD-jIBQ83qmmRwMlsQS2flAX8x4OwQWD1fT-XxHC4&s=w4ScHxAP1xoEzZcfuYXOUt5RZMb6Pq397c-vmu4q5rM&e= >), by modifying
> .repo/manifests/imx-5.4.47-2.2.0.xml with master/honister code for
> openEmbedded(revision="refs/heads/honister"), later i ran into below error,
> 

Please don't mix and match versions of layers and bitbake. Use the same
branch everywhere, it's not intended to work between branches of
different releases.

The override syntax change is documented in the migration manual:
https://docs.yoctoproject.org/migration-guides/migration-3.4.html#override-syntax-changes
Even if you manage to fix those parsing issues, you'll likely have other
issues. It's highly recommended you either update everything or backport
from master the recipes you need. I'd assume that backporting newer
versions of perl, chrony and gpsd should not be too hard (compared to
other such as gcc, python, openssl (1.0 vs 1.1), etc.).

Also, FYI, zeus has been EoL (not maintained) for almost a year and half
now, see https://wiki.yoctoproject.org/wiki/Releases. We recommend you
seriously think about upgrading to newer (maintained) releases such as
Dunfell or Honister.

Cheers,
Quentin

