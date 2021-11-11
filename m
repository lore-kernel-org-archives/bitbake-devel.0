Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB40C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 12:31:42 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.41])
 by mx.groups.io with SMTP id smtpd.web10.9934.1636633898629873079
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 04:31:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=ZtxERVhV;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.7.41,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt1Me9xjDNfUuVCxx+KvZakilT8f+7EbazKcZEjUR+lHILKfILaI9B7P82/iiA7PG8lmwaohTx5YCIgHLfbTAoQGBw37f7B/PTxXTdHPNGIEgoqChZppC7iIxwCGkbxOYMdO4EioqpAplpqYp7K/eQs4qudEyPMgedWeygtyBlkNiuj2OZQ8fLBA/0Nnq4gOwmmMFqiEd32TJZYp7tnGmQPYXpwSiOO6xqdZqj+woGboPZRUJbXWDSWYXhQ/4rki2U5T73Vr5M6o6zROS6uiIHSWuFN6pWb5+vRqQQP07L6E52Ga00nOWv7lRlY5IBp5VrUx+9+smDLKQU3W760Jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Js/PJzf5dQRqFyjVa+i8l+8Ig07XbVEq3Ugx+rIDsg=;
 b=QPeIuHRmHpjj6fCl9Q4+Vk3SmmeJ4BSP0lGYeDq0oSu/PWZGjmQgAqTBhCQ6tdJSli6Ur8QzLCA0rytgw6s4hV43lUCUYQLCG2IJZmx9W7uy2Vbm4aN8Sn9CvGXkNB3eneS81g1hQrX4g8JMHnqkR18hs0ukf2Do714xRwWZnJyLOgECj+r7I+PJj14fu0fFbnWop2CgAx82AvQHKtIhX285RD5URE6+vB59XfeVKXpLayB0TW9hNIMKFrcn+BPm2+Dx+pH7Q0kqu9PDCyfbD1W8xf++G8gJirDSv1zwUAyyEqFfkJcUX0vsQxryUU8XEtjmpZxDTB26YtD596e41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Js/PJzf5dQRqFyjVa+i8l+8Ig07XbVEq3Ugx+rIDsg=;
 b=ZtxERVhV6OsUIp25H6RRMCpwxDxVpzf+wiQPe1e+fdorAoeA8mGUoCqq71ll2ozZhtJBL3qc5elMKskxetSnkGMBOs3fqk/lYsueB5rH4ktrtGq16RLwyEcsuU1AqtbtNbVj6UOas3KEFfkbxFwX0VcsUryTFwKzAD84+9jW/EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB6194.eurprd04.prod.outlook.com
 (2603:10a6:208:13a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Thu, 11 Nov
 2021 12:31:34 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 12:31:34 +0000
Date: Thu, 11 Nov 2021 13:31:32 +0100
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch: Add README on fetcher design
 constraints
Message-ID: <20211111123132.flujykp3i5xtfgg3@fedora>
References: <20211111112123.3853646-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111112123.3853646-1-richard.purdie@linuxfoundation.org>
X-ClientProxiedBy: AS9PR06CA0313.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::29) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AS9PR06CA0313.eurprd06.prod.outlook.com (2603:10a6:20b:45b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Thu, 11 Nov 2021 12:31:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dc2ddc9-48ee-49a5-d107-08d9a50f327a
X-MS-TrafficTypeDiagnostic: AM0PR04MB6194:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB6194BB4579EDA04684284B41C2949@AM0PR04MB6194.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5T+XREkC1RWB2OfQGojs0DvXhOjGUqY4QTwWc8oZSJPYhBrTxFQkZwTREU1Jy6Il+0Rx6YAXwmzGqOUJBBGXroQ2TWIHYCbMg8IGRSwpfJuq6QnrwZ523i3EA72F9/MHeX7JjmrKHjpaWMKeWpZlBadIMu3mfwLqahCnVniYX0+VCI3w32NnwQqIIk7X0dLYL3RMghhkYobLJYY9mfUmkk0u2feunkLdXNljLEvAo2WjwlXv5JyvyJ6R65r35h/0bUDrLCaPnQyo+zK3DdhYaHPB9l0/qD0SBoPkr1vpBjQyY4XOaulSDK4qkd66AZVuj9T3y7EAz2xwpYBv7mWc9SoYX/4E4fKtiFTeJqgPACaNmkRDwSE1IVaMRwicLv/8JjMvr0TqjNSccBD2LqPdP2DKn7nQj82Ty8gSAa96zJgctUVJlbbYJ4eUHWvpiFRF6EOi1FOdcKAPMxFaTcrkJpXmqYJVrG9MrS9nGbrt2eFzrlqK85lsCCRuyTUaQRsGOKL2+Bcpmudfnm4i3hsrqAaWNLOjUvJAPrRW/z0q+PkXG9vz3JbixWrB6+lvM7Qd27pCiYoFXIbUN7/PxnU6PPKJAy8wO92vBR0kfXDsmjyKcOTvDgtHZObFIo32+ciCWggH9xLKlaPzYnqTEDRU8YG6/GSNxZkmAgr4etYaflJl5TOBrx/wdjzV3XUupf8eR73wL3T0N5/YundeQMKXakfaPx7QiefI71Aia7UK1xo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(55016002)(26005)(186003)(6496006)(8676002)(508600001)(8936002)(52116002)(86362001)(66476007)(66556008)(2906002)(956004)(9576002)(66946007)(316002)(9686003)(44832011)(6916009)(4326008)(5660300002)(33716001)(1076003)(38100700002)(38350700002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n+pY/1LNBrwrzx/VEQ7K7+3KLE9IeVz1hi3Z50a2PzlYZFgf2yXLiinlFq6M?=
 =?us-ascii?Q?EQfjM+QyNXWoV2/fftX7/XOtAMnandGT0VLzc/77WbiWKIskp5vO+gNEOjT+?=
 =?us-ascii?Q?eDLrvc6Pk9751mg8dLsJKF1ugrUWTqmsLMj9gLS2nYwYJ0kitPfHwUxN9LB3?=
 =?us-ascii?Q?Olxp3qLFxGt8V/kp3p0YdFGfuh1Yy6vf5Cq85sBFc1d9CxYLELVcjuSpl3Ub?=
 =?us-ascii?Q?bv5RgtIvYNWVnl9yWYnZ0zngJW123R5daxGrihAnWQpfrv6YTfguNQMxrnLw?=
 =?us-ascii?Q?nC+yq7jK85TEyXPqnofHzaNoMaHj3StbccbRPeWBUyQMqGdgrMXV++MAHEmm?=
 =?us-ascii?Q?Gj9+wuqcOOgNEfOhNCCikt49dBpx71CnpIpqj4GJpUN6zHzOD92f0uq6nAWK?=
 =?us-ascii?Q?xFHsUYyN06FIxLp7AnTU+fEKlasbvaL+Y7/hOPsExC0ld0yHJnbDtvkVWRLc?=
 =?us-ascii?Q?yXDSDBF8IG8gQfITs7sasFo1d3q0mjVeX633U82IPjk2PCPauotnR8yDDHn3?=
 =?us-ascii?Q?XLxKYXn944WEE3y8nsuSyG5+FCwNsJKSidl5fMUuuWT8/os8VUmBNrPVpmeT?=
 =?us-ascii?Q?Lgo/F+2kiBDQSzM5NAzI2PLfHeS3lIb5+S8eY89BwvdCtmPw9JOC2XK/1LmN?=
 =?us-ascii?Q?Oc0xepDnvRmqQRd1UbP2bnqH4fcsVOSpa1M1/J6Uvu9l5g8K5QJZnF2mfes7?=
 =?us-ascii?Q?Dk3Mnf+aPSkEcTzMmpqvHuTR2SVODNiWKaEcMandN1tUpVF0TTdFBF2c8uGh?=
 =?us-ascii?Q?Nv+BceXDQUpS3758giX8VJuPzZf1FHf9c4sEjQYxTZRc28RYd6ygZnwdAKG1?=
 =?us-ascii?Q?GjxqePIdcLeGcwhLCHp67s6UKANCxnPFFi6ZIga32dRbieknXX8uCv/uZWB1?=
 =?us-ascii?Q?NAQETQEFnn58w3k9MggxVy+0zSL9PRfeMcn3oSHev+cRjImgs1HRjh6C6MXK?=
 =?us-ascii?Q?Zna0/MFCjQpraYujCb5ee3zxOeJ7BSpR3z5g4mlzULPcMUZkyuiVFC+eMrNy?=
 =?us-ascii?Q?5Y79qPKMQGgnPsst+5cOzpw9b2Rs4SBaEpansZ2p4C0tCftUOGBMgOCM8oOK?=
 =?us-ascii?Q?BzCMjR+kNWkjkAHfBIURmGha4CX4a5Ko9r/XSAZqDMnIdJqS+v4pe3BUbelT?=
 =?us-ascii?Q?Tn0RatMz1z2ZqvpK1q+xR1NgsYfrqzW1cP7ja20qoic007lTk2QDxrVvz9vo?=
 =?us-ascii?Q?bof6h+O1iwL/BrFXa5ZLfgbLfJIRCaXEK/A1lOZb6TpV01kT7kKaTtNfsUnv?=
 =?us-ascii?Q?rVTpqz7v4QPxvngVk8KeHv3JgDIcDnpRXAxyt6RinbsUJYN4qjDpEsMC2dya?=
 =?us-ascii?Q?T357mbxgBmdFs6YUTZAqO6OM9+99MWmiHATdnjGd6wf2HHicyQDyRvdGWqhV?=
 =?us-ascii?Q?2zTo0EJFYkBYJ9Yt08VTtahYB7j1gJlx227V5uS7qjS5zRUJ174y91HIsu3J?=
 =?us-ascii?Q?XvYhQQ1PIEUcBJtlCSgRDm+B4BtoFoDHNSamw5N3ikD4Fypw+isMQFcO1+g0?=
 =?us-ascii?Q?bPgCs7+3xUFR88cPT2zM4mOBkBzbxYMLXUZPjS3XruWTMTRfH2/3/3l2CeGl?=
 =?us-ascii?Q?NqlBC6YKnOzcQbXDvExmNzCOThCiZaTr2cwNEHxJuArxv7p6xOzBNhLfMFWa?=
 =?us-ascii?Q?oEBfwb8m0tNHWQe0RjFbGLj1BcUv0XbTPolQ5tJJoSPU9+/IRuD4c2opJ8Vu?=
 =?us-ascii?Q?ASmYalyeqmX1dPL0+xmj9jaRBIEL9+STehy6Z+3iX/tSDu87lqTHuuSgsufK?=
 =?us-ascii?Q?4Q6Jw6hPvg=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5dc2ddc9-48ee-49a5-d107-08d9a50f327a
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 12:31:34.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 yat/QzQbL9IbYJ9DEcyLBqrgHU6juSrNh0L6u8EPX7+u9OrTUP7sYCBB1DK2h+2MZDW+R/1fgVfJA/1Wz3QiGyR8K2ED8qZlnWaeGl32uVdOOtngRtak5DmdDWVHqmRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6194
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 12:31:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13018

Hi Richard,

On Thu, Nov 11, 2021 at 11:21:23AM +0000, Richard Purdie wrote:
> There have been requests to better document the contraints of fetcher

s/contraints/constraints/

> design and operation. This README attempts to start that.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/README | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 lib/bb/fetch2/README
> 
> diff --git a/lib/bb/fetch2/README b/lib/bb/fetch2/README
> new file mode 100644
> index 0000000000..eb214709e5
> --- /dev/null
> +++ b/lib/bb/fetch2/README
> @@ -0,0 +1,58 @@
> +There are expectations of users of the fetcher code. This file attempts to document
> +some of the constraints that are present. Some are obvious, some are less so. It is
> +documented in the context of how OE uses it but the API calls are generic.
> +
> +a) network access for sources is only expected to happen in the do_fetch step.

s/step/task/ ?

> +   This is not enforced or tested but is required so that we can:
> +
> +   i) audit the sources used (i.e. for license/manifest reasons) 
> +   ii) support offline builds with a suitable cache
> +   iii) allow work to continue even with downtime upstream
> +   iv) allow for changes upstream in incompatible ways
> +   v) allow rebuilding of the software in X years time
> +
> +b) network access is not expected in do_unpack
> +

s/do_unpack/do_unpack task/ ?

> +c) you can take DL_DIR and use it as a mirror for offline builds
> +
> +d) access to the network is only made when explicitly configured in recipes
> +   (e.g. use of AUTOREV, or use of git tags which change revision)
> +
> +e) fetcher output is deterministic
> +   (i.e. if you fetch configuration XXX now it will match in future exactly in 

Surprising place for a newline, shouldn't the ( start above?

> +    a clean build with a new DL_DIR)
> +   One specific pain point example are git tags. They can be replaced and change
> +   so the git fetcher has to resolve them with the network. We use git revisions
> +   where possible to avoid this and ensure determinism.
> +
> +f) network access is expected to work with the standard linux proxy variables
> +   so that access behind firewalls works (the fetcher sets these in the 
> +   environment but only in the do_fetch tasks)
> +
> +g) access during parsing has to be minimal, a "git ls-remote" for an AUTOREV 
> +   git recipe might be ok but you can't expect to checkout a git tree
> +
> +h) we need to provide revision information during parsing such that a version
> +   for the recipe can be constructed.
> +
> +i) versions are expected to be able to increase in a way which sorts allowing 
> +   package feeds to operate (see PR server required for git revisions to sort)
> +
> +j) API to query for possible version upgrades of a url is highly desireable to 
> +   allow out automated upgrage code to function (it is implied this does always 

s/out/our/ ?

> +   have network access)
> +
> +k) Where fixes or changes to behaviour in the fetcher are made, we ask that 
> +   test cases are added (run with "bitbake-selftest bb.tests.fetch"). We do 
> +   have fairly extensive test coverage of the fetcher as it is the only way
> +   to track all of it's corner cases, it still doesn't give entire coverage 

s/it's/its/

> +   though sadly.
> +   
> +l) If using tools during parse time, they will have to be in ASSUME_PROVIDED
> +   in OE's context as we can't build git-native, then parse a recipe and use
> +   git to ls-remote.
> +

s/to// ?

As a side note, there's some inconsistency on how you end the list
items, sometimes with a dot, sometimes not. Some items such as c, h and
k are written in "active" form (as opposed to passive form). e.g. I'd
reword to something like:

c) DL_DIR alone - as a mirror - shall be enough for offline builds.

Not a biggie but since I'm sending a mail anyway, better say it :)

Cheers,
Quentin

