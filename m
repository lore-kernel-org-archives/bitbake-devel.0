Received: from EUR03-AM5-obe.outbound.protection.outlook.com (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.80])
 by mx.groups.io with SMTP id smtpd.web09.17546.1627895875212611137
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 02:17:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=m8FCwJ74;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.3.80, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/oedfqfK8+UD2EuSmxGE71ppaKdoVP8YO7rtzvtAHsjsVcn7VRmGVKGHGg61kunfFp9ikfgOj3PMxq93JL154qAe9/s0525BMYKRi2Mvcgcntz5PEhCH9pVdURE+DZLeE2avnMn6cjXlYvoWcJLSaQ0VHK1AfGPjf4mb1RmA+E6y6+uvUi2lzlMz6GmpyZauvA8rN9fZjOiWfKYb7U9jsnHQkxAc0CVuNvQz3SqT4C1Bm9yoU+lgNA8Ftwg4N3UbYd9oxigpaF3ilSwqlSoLyBxNDU+G5xIYs26++U7pFeKZ1o49PdLHGohgVIEPfXFQpkesrOtMyjvmtconjzLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MdXACUQ4t573so5EKAvfrOD5ckIA0kDqyn85g7hW/Q=;
 b=jO0apJ9ABymfP1Rfs0UN7Nu0EeGr4xYWeKaiRqnEWTxF6FzhAquzksIzMuu3wgq3D/4CeKI7ELJyjZSTGziUxVv2Z/ngDoxAykSmB6Z3GkHXTnEU8K2QtTxXKEcwhCpRZOeU0O3BCGF3J1TsNBKWFUDVEhAze6JWzW6Ai+3m+y8+NvYc6imSOhhpmxP6yjA8jb1QhXFgnPPFA5lj10gAdbgjsjA/vkdT0Ich9cR8lqtyLjnvxZIYc1YbWVKc7Q+c1PBpFBLf5ND2/6t1n7y+Y3KDXFx1ZUc/qM3Zu4WH3PNtzyR6PG//CYNvNgrQK8vTJw7rkzp+/b4FiwcMbWoYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MdXACUQ4t573so5EKAvfrOD5ckIA0kDqyn85g7hW/Q=;
 b=m8FCwJ74lPjZ1YXvSVPVfgVEk7H3hnPPAxzVj80DEUNPR6V0f0jFHRC8axGUFs1bqmWwvK2BOdEYe+wNbWroyYb7K6CsNNJTiwjFR1oKLmxfqnVRTFm69SIpErG2klEtuRSBnrFCW9swvWbARb8v1ca8hjjZWXO/Ectl/fO42eA=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB4818.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Mon, 2 Aug
 2021 09:17:52 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 09:17:51 +0000
Date: Mon, 2 Aug 2021 11:17:49 +0200
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/4] doc/lib: Update to use new override syntax containing colons
Message-ID: <20210802091749.ae6xswayswkk2awm@fedora>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
 <20210730134706.3360651-2-richard.purdie@linuxfoundation.org>
 <20210730140804.fsmnmhdxvbdbtcdb@fedora>
 <ac49ab278c80f87ed190355bd489a83994f131e0.camel@linuxfoundation.org>
In-Reply-To: <ac49ab278c80f87ed190355bd489a83994f131e0.camel@linuxfoundation.org>
X-ClientProxiedBy: AM0PR03CA0087.eurprd03.prod.outlook.com
 (2603:10a6:208:69::28) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (92.42.140.82) by AM0PR03CA0087.eurprd03.prod.outlook.com (2603:10a6:208:69::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 09:17:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b086091-be8c-4076-9362-08d95596675e
X-MS-TrafficTypeDiagnostic: AM0PR04MB4818:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB48181372A66AECC75157CF29C2EF9@AM0PR04MB4818.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a7465vT7HRAY3D9Oye9Ve6Ms9zU9uHboaLxqZkk7c9w9L/CVLEMHAfzXxD/0IFENSCgBh3atMEkU5z46d/o5+3cUFvZCtQHi3LGuORkQ6Y0GlkOGHnAsNaXzTc9E1Mi4egdqHOpmzNGoNWVVGQ5B4m2Sk4MtEQCdSZlUSjB5z6SpckRqrvnzn9r/tk/KsKR6Kx1wCpNM9aP5nHl4PiXXhKHF/peO9mK/uYaTBRFVfuRlHhu2qLn58dl9fSh1Xa/2qZOPZBxifbPaXye7RbWOTVSce2tMBLM3kb0UV6mDoQ9l4EaOHD2vqCSsbOVGVVsdQV+usMvkYgqKhr46gbGrxeBq73KQ+QHCHS+oBE/2+OB1XnNBwj29TCK6cFBsRBJNhR64ez9z8bZNzC0eX9kMnuFK7Uqlhplj6wG4YcEYetKIwkLpcAR6F5yM3zIuOT3HVOI3vRS4DmczXw83Iunf1saXtQlSfRdYfrSoCbmhTvO7SooP40f2L47u3/4GkjHhrBh7q57gYcI1KdukGFtJzkiVrt8EI/PJdg4WdTY6Y8rwbrLDCREJFrMRBv/J+yj/6qmDjsWmZShcM53n7NxE1WDtG82IDVpb8n9yHimruJqJeFF+4+me5oOtZrNAwLpcPQGkWVyjGhl98DSE40VHhj2RCrF5avyXxtuxQ3LOUglue+Z1+oCrRcy4GdBR23eZqsIGyX2yVUWGYLbSzc88Eg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39850400004)(366004)(376002)(6916009)(4326008)(8936002)(956004)(2906002)(1076003)(38100700002)(4744005)(38350700002)(52116002)(6496006)(33716001)(26005)(9576002)(5660300002)(8676002)(55016002)(83380400001)(186003)(478600001)(86362001)(66556008)(66476007)(66946007)(9686003)(316002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sv+Bie04mHCoEU/Q9Jmq9VH7WZen6Ca7NeCG9GbNHYEPxBClmiZb5m3kzmqz?=
 =?us-ascii?Q?Gvbez/YHxtBKo2qsMRSdR7tkuUzuj7aNfiHIUvOBPQL1HAvWBNpzs/giou9v?=
 =?us-ascii?Q?nb5XWASMxbQlA9bg1ZKoYvH4COu2RQWKWR9rslGS8rdCmexgo4lXFxsLsCJl?=
 =?us-ascii?Q?+PlXGpHfsNMmrH+DyKv2Ohk3kLZjBluLXmaQgSyRdHKZ+BsG4Zw/gXKZcDnU?=
 =?us-ascii?Q?FZwUgdPgDLLlGrbywohfDwjlakpoCxNtdZnl5g+98v9tollwSsBa3KXi0f3I?=
 =?us-ascii?Q?i+fH9r8C0vgiPX4OQSlaC7ZM2H9vqWeOxkAlnYgXKcSFS88tvBj3KazGEfkH?=
 =?us-ascii?Q?gIn5QfolIOwA9fueqBuiFLAJ1ySrZmYA/9O5TlSlTze4zNomD1B9KUr1sEll?=
 =?us-ascii?Q?EKps8oV9tvDd+L6Pp+cPn4uyxU/ewDp7JDCct+Z3KGDLcNQrbHqrIBr+7NBj?=
 =?us-ascii?Q?/8/kNZGs9Xt+v7NYZyxWq5vYQZItGKc4K7ZWtMr74T4JKlw5vb231iUgXSrp?=
 =?us-ascii?Q?4noSYdYGAHxfNWkIidy/Cbs1jvjnE5tTV9lBlSQGaUiZV51NTcHSl5gJfsjh?=
 =?us-ascii?Q?vj0kcL2Mg+ZNzYGPVgDbGvL7e4yDwwkOfSqYI5OnQ36nqG2q1lJjyqk6wfM3?=
 =?us-ascii?Q?dvNNiExJoV0VcAp3/4mQ3kyC8h27t8SE71h/yzMk4AFZWakXv8Y2mZhPCFzV?=
 =?us-ascii?Q?LoK/2rnEKqk10c2uXJ/w2AMANq7bhaAojlGxkhsBdiaaUSoKkJE3nxxBgu+K?=
 =?us-ascii?Q?5nLubDlI6orU83/DUVXpm8JcHGGBuaihu9kzdGhe0r195AIsoS1bm8ZKkPkJ?=
 =?us-ascii?Q?7EMZieLhX6ybbc5aKj6TsdfM/E73x+ieA/Tu7Bv9CT8wE0dXsYMtK029cvZd?=
 =?us-ascii?Q?cfzIAMqLDvdiM+MGEgtyiRCMKe6k1NaHLFfAb0T/dj63bRel5pbAcj7ZMdoa?=
 =?us-ascii?Q?iyLXcXiCBNa6KQaTC76wLMvr+sdIecOeK0Q2J+PeKpcADQiCtRXibgoOMzU4?=
 =?us-ascii?Q?d4tvRxBnG6LwjNvZRiaqSjr0DYJ23igBQ6xVNnKJJxIKwM+NhUpijYVNk1gg?=
 =?us-ascii?Q?+ToMWp+c0kwpWSNtw1hzMN0XFp6DjiIrv/GoeCIbZNOC6vjQ4HNSmCwhYuqE?=
 =?us-ascii?Q?QozZpnCgWVSaG5jIlqhka8CAfSkFYYLt/B4jEzure/tWE5jWKjP57mOvTpym?=
 =?us-ascii?Q?FuI8vswvy3Xcpb29CdJhrmxcameEShRrSwAZeVrArMIZ2QII7tRinGnFOnGr?=
 =?us-ascii?Q?OXptLsB2WZOBRxKFby5Az64U1wc8LryEw+pKq7clP1972W05DdphBiWmlkFZ?=
 =?us-ascii?Q?FjFn4diOqGHHM1MN59HFzWsq?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b086091-be8c-4076-9362-08d95596675e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 09:17:51.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRarZgwWnzgRd24OOKeEOOvkXt1MnPTnP42O0+V3dOR7i77+nn4epRtsPnsqI7k+Atg3O6K6HKCLRCz8J5xLQVCR1p87A7bASo88Yf50Er/bNh3sbfkPK/unOmQev5va
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4818
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Richard, Michael,

On Fri, Jul 30, 2021 at 03:11:21PM +0100, Richard Purdie wrote:
> On Fri, 2021-07-30 at 16:08 +0200, Quentin Schulz wrote:
> > Hi Richard,
> > 
> > On Fri, Jul 30, 2021 at 02:47:04PM +0100, Richard Purdie wrote:
[...]
> This patch was the automated conversion, there is a followup patch which
> does fix most of these, I haven't checked them all. Could you have a look and see
> if that does catch the other issues?
> 

I'll check this ASAP. Please give me a day or two before shouting :)
I can provide a fixup patch for the follow-up patch if that makes it
easier.

> I left them as two separate patches since it makes it clear the things the script
> does and does not fix.
> 

Makes it harder to review but I understand where you're going with this
:)

Cheers,
Quentin
