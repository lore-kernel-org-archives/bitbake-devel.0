Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9836C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 08:14:28 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.41])
 by mx.groups.io with SMTP id smtpd.web09.8730.1633594466130246850
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 01:14:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=deiIxJdJ;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.8.41,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihnvA9HpZ7LY6YBoJEtrCIPTF3327wrYMBY4DlCBLjkMzmCoJwT47TsyhrWlV6MPj0OQgkxb3M0dPMlYe3W1SHDxwovsevi++upAR1pQ/ll2snDArkQd0CBGR0+UwS9YI4xXoJ/FAM0HSuWOCbfoNzN6PCQmMqo7KjSqJUJtTmqmbkL4S2+v9bD7BuLc0o/HZ23/qEgP6x2OlLiaG9fDmtdh4dsk7wrRH0WnB4Q+i24MpGwDSkxDWpYZftlfR0LIAavZDjJZOSUOql3NBAf+ac2db3h6pNNim2tX8ZHgY6ouQFiVdnNBgqKnkm+6+ZEhT2yPbstEuSoPYOPpVt6KyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STgWJr7G/DX8ip6IHtAjJWs/8zpEu/N+xAhSM84P0cE=;
 b=aDdYuPfnEmBmiiooaiEK+Wi8r42zmAuYXbuwYPHO3MIBkjd3RetDMDfZgcbmK8QdUCLM+kGuvQKRBUBjWvOAOhMyU1L2tl0tYCUmSv+KllXBY4Mz4jXGxEtrdBckEtNn2iZx+Jdb9yWM4Bc35vq0HyjQrF36aONTOB1PVGBIreizmMNYvaDIsoj77WMOuWJIsqGR4eXvIg8KRmppuskyq7znrnKz4WPsN/1bFOfjTmByAuA3ctEHOG+oRXgoUL6VUGE9BwFLfEarjnHJXloQ+YN9sUDiDunE4YcCEv5EPa+nzaaDU5TBT9hDzXxp1qLkJaaWfadYXmsVZTFecnWVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STgWJr7G/DX8ip6IHtAjJWs/8zpEu/N+xAhSM84P0cE=;
 b=deiIxJdJPz3dgXKwhAAtrgoByK+ANYBsnF3XrKhBFrKDNHPzQ7BhtJDkcOVSegNIIwT3LYIP0MNz+n5LwELmhjjCU7pSib22PBEKMk43T3UpuONkEjCWTVj+Qr4p6FA9kzaFFyriW+cQKZHMBP3+Aj+7dpCS/YC4PpQzOhZRSP4=
Authentication-Results: kudzu.us; dkim=none (message not signed)
 header.d=none;kudzu.us; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM4PR0401MB2274.eurprd04.prod.outlook.com
 (2603:10a6:200:50::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Thu, 7 Oct
 2021 08:14:22 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4587.019; Thu, 7 Oct 2021
 08:14:22 +0000
Date: Thu, 7 Oct 2021 10:14:20 +0200
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] documentation: update sources
 mirror URL
Message-ID: <20211007081420.awto6s4qi2fjgyxe@fedora>
References: <20211005224513.14134-1-jdmason@kudzu.us>
 <35bcdc42-9ed6-5232-c94e-c69f3fd7af94@bootlin.com>
 <CAPoiz9xhmQ+dCEUibDV7_evNhLVb5i83LjU_uo3k1f_4Q3Y-fA@mail.gmail.com>
 <755f3e7bd1d40628a911b9c1d165785ad6d5a494.camel@linuxfoundation.org>
 <CAPoiz9wSdfgppgopSN7M9TZRRH21j+r8YEBgHdWKHKA-d0fryw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <CAPoiz9wSdfgppgopSN7M9TZRRH21j+r8YEBgHdWKHKA-d0fryw@mail.gmail.com>
X-ClientProxiedBy: AS9PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::23) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AS9PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:20b:46a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Thu, 7 Oct 2021 08:14:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b76183db-1e3e-427d-cbc1-08d9896a7834
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2274:
X-Microsoft-Antispam-PRVS: 
	<AM4PR0401MB2274081F1CBA8E8909696F5CC2B19@AM4PR0401MB2274.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TycsQW6TlvxBS7RbElu7kI3WGS4/9IHVmufQhKt2Bh0RDLRFJULb5Oe8OMBPU0YARw8zPOaos9QgYwocyWklB6rdQi2K+xkkGgrEPeSVg89SZqR7SsIHm2wP3q7M+36M9VfSzPKJo7wAX6pAheh4HbeX2pB7SQAGGWI00xYsDAgXd6W9l2dY3XZsYoPagsxpc5PtL502+oBSUyZEMF/l4gjYbFjTnTY9sMfAh9hdKafrayYbTNowpNDJdd59ntMSRTudsh5VlEseiVpxL0VTQ/gZhhGaq1SphwlJedLACdr8k/1yTlLTwnL4FmR2zSXAMb9tZ+L0ZpBTvOwPAJCkphFu/iAFvMpxD7W4g+Zv6WlXboqXP39HBTq/5ad+LFz6r4G6Cg+48f55eWWt1mL+8yvwXVsT+rlEppGQk6XBY0J6GhsSrnHB00bos2IUMcm5IbJhG8nmqc2MbWDbNnPFWpjMah8wZky7htS9ykbcmFgkEmldp8FFjKK3ylRSMZJElgnpAEohDV6Qx18OIVN2NzcuIs55+c6IOP9o7j3gjQqBYOLqsF3fepd3O7NJrIoioJUyeY8thj3RQPVp0K15MDlGBQUyQY+8MWe3TKpRIh/1TJkGHd1B5BYkJkwHNzl6yerSZTtm2u8Zz4/H5vk8X3GHLxlbmRjfN1velZJMgwhPiDWK/w6XUMMJxLS61AksewTXqlqGUfV+hUB45r1dEw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(316002)(15650500001)(83380400001)(186003)(6916009)(2906002)(66556008)(6496006)(4326008)(33716001)(38350700002)(38100700002)(66946007)(9576002)(66476007)(54906003)(52116002)(86362001)(26005)(55016002)(1076003)(9686003)(508600001)(956004)(8676002)(44832011)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pQmCgr7YxkHeKQzVQWF8re0IPodj/U0hPZxy30l0pC87o4mRMNqO23zxvkgW?=
 =?us-ascii?Q?d+IJ/d++KOv55rij8xh2prevsD+aV+OxSDkvCmWnKGrs+lX/eDL951nvfC79?=
 =?us-ascii?Q?Z2fqf5x0Sep8zdjGe8fkFPg8DkYvNkLk8OzaRXEmNKWuQnUHNXZgSHOzPG6d?=
 =?us-ascii?Q?pQoMHOCU+myLUaPWuJkU2wy7ImlbyX14w1JWUYm+/eGSydEN8wwi9sYDCcbO?=
 =?us-ascii?Q?ZAYMBEBQr6Ggf+xowLCZXtiNS7jWjtlaFgg1J82rynCkBzuPf3qaL4piuSZO?=
 =?us-ascii?Q?KTtiwT3GjcaGTFqgQxKWX5F8M53nqlndSE7KU2UJjiiGzIS0bNr+RDQ3rObh?=
 =?us-ascii?Q?4dx+mNlwGeS7aAIRQAF9VaTrMU+sl6rQxBCIllcs2txdh+JqJdEFRCj4kHE0?=
 =?us-ascii?Q?vPAi3+ozDpJBl6tdDTzXvfzNpVd+2LsV1BdFVc2CNt5mxrWKzDLWsSBvlCY8?=
 =?us-ascii?Q?+jp+qEEap/+bbbJWJkIaigCEE2GjeC/nLr93Jxm47FYcL+67zo5N1PXQP5aT?=
 =?us-ascii?Q?BFvOn660Pq3blyFj4Ja0S0fFZ6fYYFDyokHT+xgne+SPGG0Jv4pu8AU9rj2/?=
 =?us-ascii?Q?vzKFT1nzDcMpV9mMN+ivO6JjttC7JP/OFTnc45yLZHds0dG1Kni8u/6OYJ4+?=
 =?us-ascii?Q?6IK7zx50+hawCKl6DbqSBOxUVTB/soWX8DzmKjv/D8jCHuzBg3eJqSOi6Xg5?=
 =?us-ascii?Q?GFaHuXw7N7atkARQmq62u3tt1yXr/qebMnKHecWuJmoWacP2dkSzgwo0faXl?=
 =?us-ascii?Q?CAIQ+cdVUdnqYQGVN2kimjW4jvG3xmYMPgMMHYHoXaJrbTgOnoDmjWaDf4g3?=
 =?us-ascii?Q?JJ2SAEOrsKUjaV5daYGcdkLpSEWs1as6k9UB0fR3kEDlNRtiOg2cLuJDg/x5?=
 =?us-ascii?Q?rgfowtVdHLpZEoXrpZS06oE/gnCvYeFsl0B18EX3rjXk0zV7q4hNQg2RsTr2?=
 =?us-ascii?Q?AkWRYVX5uLgsQInXbxbBNMNljJi7R4OnQFk58j+m5oTgjb46eFqcnCmha6Nx?=
 =?us-ascii?Q?l6grMhGgITuDvjFeYLMEzTw5pDA4VVPYs+Hpe23QxKxcgbI1QTmq+BbtbKcs?=
 =?us-ascii?Q?o4MwahuOGSDfzTjYX1xjZEhm95KN8+mFvMQYKTc6ObpZbDypPd7wywrpVSyd?=
 =?us-ascii?Q?0CHwd0p38wVt3bxn4IL1+2gGUF9npbfUwMjxnF5EHNyoyB0arK9qYXXGon8D?=
 =?us-ascii?Q?cvXn8uCaOhP6bXQcFyuGa8WgOx2NnkjPYqGQgboSRraLTe081CxnY63mvGgi?=
 =?us-ascii?Q?DE8Hz3goIWGHgfi4FnunLFnlQOlfkgwlNXqiW3U1G5CT1UQuN019nUIG0LTz?=
 =?us-ascii?Q?Z6EXL1BfYGGGmG3NKjdADApH?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b76183db-1e3e-427d-cbc1-08d9896a7834
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 08:14:22.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 nZp0NU/ivWSP6rTsNTM7M9lrQT5VEkYd5MXAAiUucFYP9GM2oJVfpkq3fW/Rz4Oe2Et0IbsKhUJHOpE8kt6dzurPv698mH04Z+LHQ/DSryVeLtIZk++07VA1UdBl1EHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2274
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 08:14:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12736

Hi Jon,

On Wed, Oct 06, 2021 at 08:48:05PM -0400, Jon Mason wrote:
> On Wed, Oct 6, 2021 at 6:17 PM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >
> > On Wed, 2021-10-06 at 15:53 -0400, Jon Mason wrote:
> > > On Wed, Oct 6, 2021 at 10:41 AM Michael Opdenacker
> > > <michael.opdenacker@bootlin.com> wrote:
> > > >
> > > > Hi Jon
> > > >
> > > > Thanks for the proposed update !
> > > >
> > > > On 10/6/21 12:45 AM, Jon Mason wrote:
[...]
> > > A quick and dirty grep of the trees shows many occurrences of
> > > downloads.yoctoproject.org without https.  Perhaps it would be good to
> > > correct all of these in a follow-on patch.  I can do a quick patch of
> > > all of these and get that out in the next day or so.
> > >
> > > Also, looking at documentation/profile-manual/usage.rst (where most of
> > > the occurrences in the docs are), shouldn't we have a newer kernel
> > > than 2.6.19.2 as an example?  I mean, it's almost 15 years old.
> >
> > Careful, some of us remember working on the 2.6.19 kernel and have patches in it
> > :)
> >
> > I don't think we've worried too much about http vs https for the downloads as
> > they are checksumed but it is probably cleaner just to convert them.
> 
> It's a fool's errand, and I'm just the fool to do it.  Changes all
> over the place, broken URLs, etc.  Patches coming shortly (as soon as
> my sanity tests make sure I didn't break anything obvious).
> 

For non-literal blocks (where extlinks aren't replaced), please use
:yocto_dl: to replace downloads.yoctoproject.org :)

Thanks!
Quentin

