Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A41C433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 14:42:48 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.73])
 by mx.groups.io with SMTP id smtpd.web10.41062.1639579365956421396
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 06:42:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=meOBqTHD;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.8.73,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWIRDZB/K6CWNIbkLREjGj9Rmp3lKx+Jfr9SdFIU3ccbvnfgfWpVr+hmgiNu7iV+/VnECM6Q+4jPJxbOgDzSKjoIppEXPX+s/b3lsFhRzwc9SzmJ6IfD/fE6f4UQNeMyCETGdWv0rJCZwWcM6p0T/gnXEDTTZ8EPfAXZSa/O8q8cWjhF5v6DEd5GqOBWahifua/ua/Yxe0wCzkg5uB2Nl7uO3v9ISHlZxKXShPtrwO9EoJw0Yx4avSs/4deLqxGjSJ2uoHd82m+Q5+8hDnc5I8rj61hjswGUhNo1t5atmXwTrAZ9arG7TuRfdBfCgnd97zLcHEMB8vBROaPzov51cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2SXw027Gj+CmgVlr+UGTmHPu7ytKLc4DtAzkqEcuqw=;
 b=GlHTEDhDnKvJ7PZIBu5Kb3Zg5DPau8jaLtXVOWiAfxdyLJ9xM/63MptUdQOZyLWuWpsHVZa4nJt7e96W5GQrY+xpIyRXYu57LVFhQ/gXrlGMoW5IRFkUm/fKtVHV0ypln5w/s3jaeSgJ9wfb2h6oyjkZqFhWwHtNLFyRFcGk6dpPjS9CyhDof6YE5qsxMcIg5/TXNWPOyLQpeTqn//YNmjy4/Qatx6nN+MYJlPaLczl/XEm1E8dHATxjqYk0H+C6Z8D4ISfBJwRdGJiM36CYp+cZjx+z2/eW9POaWp5GE+y9M3l3uU/9DSt0KGouirtFJm8JHqA3aLjMB3MCNRbe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2SXw027Gj+CmgVlr+UGTmHPu7ytKLc4DtAzkqEcuqw=;
 b=meOBqTHDbfOt7DAcTjcPhgWc5RtIKY6CQ3hmdnvf7UkoN0mUGNpkOyY+zxwBQncilu1JDAGvi7ajVFoTzntnZa24gSYlKGPEfMCApqykB7Mb0b0EsL6zWCopZhqjO9/UR54UvN9AJdTVTFuiLS94dB39d/x3JnnUrZ9VjO/4SMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB5940.eurprd04.prod.outlook.com
 (2603:10a6:208:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 14:42:43 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::9930:f9a4:e6da:a1d1]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::9930:f9a4:e6da:a1d1%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 14:42:43 +0000
Date: Wed, 15 Dec 2021 15:42:41 +0100
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Pontus Jaensson <pontus.jaensson@axis.com>
Cc: bitbake-devel@lists.openembedded.org, fredrik.gustafsson@axis.com,
	Pontus Jaensson <pontusja@axis.com>
Subject: Re: [bitbake-devel] [RFC] Implementation of a submodule fetcher
Message-ID: <20211215144241.yvzsdgdwbnrr3yax@fedora>
References: <20211215142449.13469-1-pontusja@lap5cg1077w4w.se.axis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215142449.13469-1-pontusja@lap5cg1077w4w.se.axis.com>
X-ClientProxiedBy: AM6P192CA0054.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::31) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b385d40-5b64-40db-ff4f-08d9bfd926f4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5940:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB5940836E5EDFEFF68D4D035AC2769@AM0PR04MB5940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OACWmGaKbXVpCH2YvtEXmhXFl/lUGklYwVaW+LKFhX8/M+N4Meu+cXmYNVA6J9XRiIJQuCA/kruPl5/f0Uy2rqXjNJ1Ao3hvSa5rwJ4z8zNSZ4p6vOXlJ0uEw7kQI0ygLs9d/fV0DBEZWAwoA2ng/258HympB0l3hMl0nDYbRFS7rKpSJ57YXIW/6++TgCKhrWvm/qlJNixsk4I+TQxYxZgjEf62/Qqkk7FsPafVbPJxVR4lGDLlt0L8tJNFB+VeqZA472+RHii9v1BiIXSnu25JktC93DnJzMjGd7LBMQCog4Q252nJdFBUcK4kDx405UME5kXbdeLoz1H6sI59PZMrYwE9ijle4jl6Z2a8s4yHMYEz6nnbxfhx+fJK8nfFdJk0DPE4VliecL2fIPEAIe57FPnEk3VZOSOPQeBfJUmR5DcfZZETsFtdB6btpDDdxe8ijAEI5IVYjb3Yt8vsDw8zKftMBbEA0H9eoesGdEGbyuCyUSuOsje8GE8g1wXCo5FeJgDsq5AhuF1nbiRU61GO7i+4PsyzUPSCqmff+G8Bkv4lMcDnW2mjBibEDX4kUkXSj8l+NCOkRVEG6xERXkC181AACIMNNZaMiZFTNdicqUnpyW3ByppoemDffGV6S5+9FiriVz6aea5NkqMx5qOowK5rsE4zdskghM7n/3/1h8xOrKXu9EwKW66ABUequgfgyaDTI/fiowm3j1Z0dU5H91K1+3g9x7Bac4/7dsA4P+j+yp54ecTqx55CRhpGyi4Qerf7Wpy4kSmQw/3rYidS75SGghCRSrp3u/spX18=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(6486002)(44832011)(66946007)(5660300002)(26005)(8676002)(1076003)(83380400001)(9686003)(38350700002)(2906002)(6512007)(966005)(86362001)(508600001)(4326008)(33716001)(66556008)(6916009)(66476007)(8936002)(38100700002)(186003)(316002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mc8T7EUvtfR12H0JQKIv6G3XAvffT/AKKqFAGvGrR0wS7c8Ku6aNgii+opK/?=
 =?us-ascii?Q?815DUJFhOu7LzQRPLW4d7BhDkMcQ6cxuxPoxVf2ffwjRgdEp32eVpcbxeMky?=
 =?us-ascii?Q?5UXPBQBuMYaMK//BKyZCwQib4JGPan782uNqDNt3999b8Mo9d4S8Ka7uib6m?=
 =?us-ascii?Q?rl+UNM1wMxFGA1q/yJFHIj6b8Atli8FXJSdV1mIPt8h+47UjB/c1wJ1Bndhd?=
 =?us-ascii?Q?KuuXC1KudaGHxVwjXtqJNDVVAtZ3gX1QwGgA46UAfOq28Ge9Q/YIh4KTVouE?=
 =?us-ascii?Q?rWStaEj94eNpSyqouCk56KQd+dW9nzPgzaUGkVdw1FYn5pzoY0PT6rs18j7W?=
 =?us-ascii?Q?xywfrW58JEXTV2gWVglOdQ4WsB07cO6o9pA61GJ0nvJ7BjprqGE6V+zTE8H5?=
 =?us-ascii?Q?QimNI8nmtT4k+34qgoSq5LCHmq30klDfsL972GbQ7CCjGsOgsikWwrOrhbVw?=
 =?us-ascii?Q?6S7d0MhTHgz9nHEc3SOvlQAVierJU+Aj3IBbwBj/v38JRF4a342AblKBcRxr?=
 =?us-ascii?Q?C+JAZdyA3rj12dm66FjH85uLBwFn+797dEZnF6ycVt/d8oqYQ8KDThJs8nYT?=
 =?us-ascii?Q?3DcL4sbiBvhzykT2DXR5ecqepfIJyFLnPVTltkDIfNeqxH+otuwk+LDWbkpg?=
 =?us-ascii?Q?ppP2LyWihFhczUaSV9FfQGPNKzQzfN+qjBjdZsyOHVxQcgcu/PWDB/xTO3R9?=
 =?us-ascii?Q?P6Ka1LadWXnfNZW9muJDlMe+Ge5BEiJOXHX38RprwAU5dZa9Q9SM8f0iJ+pY?=
 =?us-ascii?Q?MAefmBmIbS9x/vMH/GWjTrVW/9XKKalusF32dnHvGYsT3nMEeYxuHKbWoxIx?=
 =?us-ascii?Q?Eis8mcrHyVyXW4scjMdjuvAteiQZ3AM3lqP51DNpXeZs8TDQudtqindYwK4K?=
 =?us-ascii?Q?9I9vcudLKfiwuUeey5HdzGNidNRqNvt5V5uJripcE6wAOrph1Yr8wtRUOoHh?=
 =?us-ascii?Q?W3GhzYiV2UxC1rPaqBiRMnoSCQg2cn+EUwHBw1DuZ9tgjhQwJ2oWFkyZfNzL?=
 =?us-ascii?Q?EM8u/hIKTGXDVS0KZ2vxHjIIsb2NIVJIcxo16+MCe95954ee7FvmKLzd4tzn?=
 =?us-ascii?Q?fsw5Wv5wEzMooiX0aLon+KxJUypzMFe1D9sqJ/GQbaKF6udxl+73+HADzURX?=
 =?us-ascii?Q?BbAdfxD68e4ZZyMy19MfWKKzyfei+BgXt3KjtbK3ywmjelEmyh3Q4wqPrn/h?=
 =?us-ascii?Q?BgTZj5Vs5IZyoLFBgQ648Tx3tv9i2NpNVTTXxUBtn5lwGWpuv4QVjigtATJ6?=
 =?us-ascii?Q?Gn+rACpqXV+pUi/EKTZAjUmIeYiOGTCJyOsbFLuhTeNfsSVtjHGcvq10q/Bj?=
 =?us-ascii?Q?AcDjHQukgXdv+XLV0c1OvtRiZteblAtf50dQXnM7CwOqg4jtqKILHZIbBGET?=
 =?us-ascii?Q?cZvCZa0KEpJ1hEWgLJe66l3KglgSDPdn9FXJjdw2s0a5ZIsX6WTGZB3L1HSU?=
 =?us-ascii?Q?E6SXMKdx6Ef95/mLOuG/yRB7tl/J5r/DL/V1ib01+imwS29jmp86Sdcf+QtK?=
 =?us-ascii?Q?xLoN8Zz9knpTqBTxKL8mKIvm8XEKu9hxCHA8vhqNBH/nCew+yuLhGN6PkuvF?=
 =?us-ascii?Q?td4InDLLyW1+h5YynwYHX5L00PC1/Zyy0kTU0thdyzuo08YMQ6Ihdd3xzGl1?=
 =?us-ascii?Q?LkSLCO8vFZCF0sqWdbxw7Qw+9SEnhzXin43eQxgAOZNhveYBpAjJBAK0kcVD?=
 =?us-ascii?Q?ZSdB+t5Z24BqDjD8kCw4Ar+cl0rjoKQEnh0FlScV5vKuVqv9JEEMuwMIkvtA?=
 =?us-ascii?Q?OOewoHKeMQ=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0b385d40-5b64-40db-ff4f-08d9bfd926f4
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 14:42:43.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 2y3LLHePOCRAGypiKLQUQnAe8tVl1+/KHOHKZ32oL0xuneLCOO6NB3UWREb+MW24jb5jZTTqmSb1ZoD+3cfCdNkMIM3K1MrPMGSAK0qjzN/BuH1DjZ1cV0iA8quI/5nh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5940
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Dec 2021 14:42:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13169

Hi Pontus,

On Wed, Dec 15, 2021 at 03:24:50PM +0100, Pontus Jaensson wrote:
> From: Pontus Jaensson <pontusja@axis.com>
> 
> This patch consists of a Submodule class which inherits from and extends the FetchMethod-class
> for retrieving, initializing and updating a submodule directory. The main reason for implementing
> it is to make it possible to track the version of a packet with git instead of just a recipe.
> 
> The submodule fetcher is used by using the following syntax in the SRC_URI field in the recipe:
> SRC_URI = submodule://<PATH TO TOP LEVEL DIRECTORY>;localpath=<NAME OF THE WANTED SUBMODULE>.
> Where the submodule-keyword is necessary to use in order to call this specific fetcher.
> 
> In the download-method the URI is then parsed and the relevant parts from it are extracted and
> used to find information about the module in the .gitmodules-file in the top level git directory.
> The final thing that happens in the download-method is that git submodule init & git submodule
> update are called and executed at the right location for the specified submodule.
> 
> In the unpack-method the empty directory, that is being created during the process but contains no
> information, is removed and replaced with a symlink to the directory that contains the actual
> source code.
> 
> The code has been tested and so far it seems to work fine.

Your Signed-off-by is missing. Please read https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded

We already have a gitsm fetcher, c.f.
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-fetching.html#git-submodule-fetcher-gitsm
what is missing in this fetcher to be able to support your usecase? I
think it makes more sense to extend it than create a new fetcher if only
a few features are missing.

Cheers,
Quentin

