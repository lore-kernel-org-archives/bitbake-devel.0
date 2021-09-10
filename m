Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.79])
 by mx.groups.io with SMTP id smtpd.web08.10150.1631284956165667886
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:42:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=MYaKq2ps;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.21.79, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp9L4XktR66AJCUW58V4Mlrihq5zSoI0iMgP5a4rh5eZdxMvHnzaDq5sRlzMxvDciK/H7WEHwCzz6Y2BTLjHEECCzV1P25jNbPjpEj+WgycoKKpp3iI0Ib2Gz4FjdWmKCg8C3fF4sHIhON8CU08hWST9taN8Oi41/MnEAf3Ipi2tIc9+bKulHJB7GT4TxiPed0iNZXnb7uN63E5gi5Hg2HthQ4WoMRco81Zqt/mlzl7u0BtFodC3kVwbNX7a7XVwitsMtCAYNOIKRgekmD9wD7jJ5fE7N3MT4Sv6MliJUD4v4nhlX78B2xxNZqVY7lMh7Mr7L3fpVTDAnz0w1Iw4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bOtKJDPHvESzAVio+kTTkU2G0NeWRkstUEUoJa/yvHc=;
 b=SSbbf0SDG8VVyNTe8FIjH962rIkZDRtFtEMpP35NRLTOIkY1sq+Dij/QuqiZaWWknAge7MeFTJ4p8zT2e9E/EzD6kBoKfSFITewGuEJxxM8CmWoNkKXnz7Re6KOaNY1a3JjFti9uH19ol/guYFIeuHO61IgiMIl2y4D1jI44Ks1r0GxEWofLVviJDMok+Z9rSYsu9An6UII6eJVnb9fBPMefrOdHtNVcHCNqqmscec2sw0HbhsZ46cGy4Bl0EmvjDoT9KzSx3HURvfpmZWDm7PtWr9S2DnYv2oiwNapxJrOmSXZJc2kT/vdC69NOfP3sHMte+RJAj2B+bzXvFMBcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOtKJDPHvESzAVio+kTTkU2G0NeWRkstUEUoJa/yvHc=;
 b=MYaKq2psl0+55brTkmjaPMEEkXTtZ7kWaeDlO4xvlqXr4Wd9EqDIKIjOE/VK+fsMWQ9TN9IirD5D7yubNji8M4Rd4WfMhRfoSdwVRr6dzw/+00rjN/DbBeviq8MC3zcAJufv4NFuoSPMgJAu5sTLsMY82KVHofYy5vlVdIsyNUk=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR0402MB3844.eurprd04.prod.outlook.com
 (2603:10a6:208:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Fri, 10 Sep
 2021 14:42:32 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::7987:898f:55bd:ec64]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::7987:898f:55bd:ec64%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 14:42:32 +0000
Date: Fri, 10 Sep 2021 16:42:29 +0200
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/3] build: Catch and error upon circular task references
Message-ID: <20210910144229.osayhx4ewsmtc7cl@fedora>
References: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
X-ClientProxiedBy: PR3P193CA0030.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::35) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (92.42.140.82) by PR3P193CA0030.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 14:42:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7587a20-25fb-48c3-d8e0-08d974693894
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3844:
X-Microsoft-Antispam-PRVS: 
	<AM0PR0402MB38444A6F9F99B04A81D57149C2D69@AM0PR0402MB3844.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vNpfREaYra92asAeg3llmBYozVst9vBJ9clAdWGIZImt5+C8Eds/WvDV0Gd0mGewb1xzz3C2FSmBV+FsH7/ZPslO7cOAkjkbhj7M8p41x8qgxelXs65aItQXZJyEmAIPSmCoC6g90ONGRq3oE8lJa9DIbUlGHg5V70alndvTB/0x19e8Z5mub+wee90Sh3PWURdxZs5+4LfskRzLKLDWAd5PySJC7k9JNcd9jv85I4aXfaUbc/FWKE/Pc4S/kNf9CSOXSYRsw7gTS71Xrv7bxzit3YbIpSDBjXS4hEygysNYWZ65o4Nvqd5+7fJrtt2DOUiztiy5Hx3dkTreUHIABYJLWTP5f5qYV8t+05MyC/f4a3oVl6dGsq4/bLcPkGB1LFvQl8Jh2V/hFFr3iYnyC/6txE+G7GiAQG6nv7pV3QXrPuDcLbPrGtEzPLT58T4/10NX3gv6jdBn5JMk6nBk6nV4Z1o8Gy4iOO8iXiEf5rtz8un7MKTxcY35I4c/hlFWXpcjfAn2FPVH7ZaI7b/9mGxwIOrS2+VrNt1w9/kDATYPCW3Z72Ht7CmKOzmqUJEMeOoeaMTWujKNSeydBKNvVgmr/XMO1iK9O03lQniQbRHnqDDc4jHJ2+CI1alJKyV61vgQ8euVstFd3jCAQ8bE5aqV3P1BLHnz4vVHtVg700W+VS5pd5NUabQ/ws2x+c3vJseuKU9mab4StxewLHt1JQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(366004)(376002)(396003)(136003)(6916009)(55016002)(86362001)(83380400001)(9576002)(9686003)(26005)(478600001)(66556008)(66946007)(44832011)(66476007)(956004)(1076003)(8676002)(38350700002)(316002)(52116002)(8936002)(2906002)(6496006)(5660300002)(33716001)(38100700002)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PedH1m9UelubuZkTEbMUsQ1TM8OA8CwsZQqAGpNH8HfH56uYuPKDBowI3S0y?=
 =?us-ascii?Q?8t4XcYLTxkRWatl4pMBCDXNR7BxpuJ+QKye0KShYVwYtsMkxOpJfvz5kIhaQ?=
 =?us-ascii?Q?FwZBjf/vqihgR0cUjWhxLXAiCz4L/IjoDbzLdKkphhaI5IGv4zHeY1CVA9LQ?=
 =?us-ascii?Q?8R3NO0+7jVgbu9znuri6X4oc6TsuCX9uWzN5Q4agx8qhkx2x7GWe9361ckxD?=
 =?us-ascii?Q?rmMBIZCXAKj2Nc03jwMZyppYVxYtCHlzpijafIvZULzteg2YC0fGKo7Pt+vA?=
 =?us-ascii?Q?vzyS+WBF1h/tSHdVLFqTzeUk0DwSHvRDQy9KFtwomfEAD8iBHVXOujaMTkZn?=
 =?us-ascii?Q?fGs4IPodkxm2J1mV+jZgCyRCwYLW2swROzevbOhlkHqkBdd4bfpHp1W1qLQw?=
 =?us-ascii?Q?Dv0acxTk6aNGwudHNoDNMbqOZ1jBlxZGlq2+MTFYssPvr+VchGlHrO8FEfqy?=
 =?us-ascii?Q?h9WIkNL4FbQKxPbNCu6/T4KEifeYbPwCK7c/hVAlCOXijEY1qdLbCOrP1kt3?=
 =?us-ascii?Q?plyM3UK7XFP5OKuExak0dTlu7NU66V7CS3LpAAWc0UpoHvwKCguY6GFrykOz?=
 =?us-ascii?Q?NFL6HbPPh2LaLab/SeO4s3h42qusKeWxNqQ9nWXyPsb1JI0V0pBGtzfi5nae?=
 =?us-ascii?Q?u5LIQ8XlU1I65yY0h5iy2Qw+BgqHgsgLcQwHaKxFbyubyMogSoHw1sV5fcy7?=
 =?us-ascii?Q?FsHL+0DPsyCRGC2l5t0dTP3GGi2yDCyjSHjEoEgmT69cjZEvi4CsmLi/jrYT?=
 =?us-ascii?Q?0uVMUu/Xz0QToqAWS/GWDY/Xy4jUf8rrcSvxpZMCMF348KTpEoAXUCVAJ/ow?=
 =?us-ascii?Q?JsF1BA0DUUwB4dD+QQVZ2cJg8pTfWD32NALvmfUgqpHp75YiM6K6Qc/tqvC1?=
 =?us-ascii?Q?dHUk+2wMHvZISSqLqF1kvbQBoRQTTB0G5trHbW0nzgw2hfNVfi2caJ603gWu?=
 =?us-ascii?Q?UqOL8uQnkn373Kpb4OwFPYXu5PzQ/9vNBNn+y1FY4kRPxTPx347GY7PzIz1j?=
 =?us-ascii?Q?O46EiwCd2ucVQMPKra3ya34Y+Kf0LqQVUwR3s2cIyOfv3Kc1QEJjnJ7Pt3UA?=
 =?us-ascii?Q?wH1UVZN7Pp4WwbazzokUwqFGMUdq7UNliwoRHFaJa69X8vn0ArZH/YlL0ylX?=
 =?us-ascii?Q?QmTotpMzcIXb/ACCrkFMRnhvjbK08a+zB1G/JHpM8/kcuNCbsN+TsGqPpJ0G?=
 =?us-ascii?Q?hSYR+tABa7qwo9TryGwyK6jGqFtRLjcEU5C8pJ5lxhx20psg7iVugkHYnGgH?=
 =?us-ascii?Q?+VGSlIrKUnS+N6YGfmX6onfafgOvJ/qwSsJ13FTIX6bG2uZVlLSnI89J692A?=
 =?us-ascii?Q?Xg9uZeoD99GPvVwaetc/8lUy?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7587a20-25fb-48c3-d8e0-08d974693894
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 14:42:32.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0RzMQ/3zwzrpR58asGH0iaKwP74v0LPG6ASDMkchbQj5pXBYwxYOJJEPgnJlp0MJ+rUPULRLoh6U64ECmvCaVdIXDZc5Yh/mek4S+UswXinBAj6L0SM68CZVvoHuyud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3844
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Richard,

On Fri, Sep 10, 2021 at 03:07:38PM +0100, Richard Purdie wrote:
> If there are circular task references, error on them rather than show
> a recursion error. A simple reproducer is:
> 
> """
> do_packageswu () {
>        :
> }
> 
> addtask do_packageswu after do_image_complete before do_image_qa
> """
> 
> into image_types.bbclass. There is code in runqueue to detect these but
> we never get that far with the current codebase.
> 
> [YOCTO #13140]
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/build.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 1e062adb51..4249c0be2b 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -1034,6 +1034,8 @@ def tasksbetween(task_start, task_end, d):
>      def follow_chain(task, endtask, chain=None):
>          if not chain:
>              chain = []
> +        if task in chain:
> +            bb.fatal("Circular task dependencies as %s depends itself via the chain %s" % (task, " -> ".join(chain)))

depends +on itself?

Cheers,
Quentin
