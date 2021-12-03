Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E793C433F5
	for <webhook@archiver.kernel.org>; Fri,  3 Dec 2021 09:51:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web12.9938.1638525110853195203
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 01:51:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=nAcH/cry;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.21.49,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d63+FaYazyMXB1JE7975qpeluGRGK63gJshM/6Z7zplJC/seOxH3B/D8y255VNZmJnIPoS47r9X+ZI4FuJtu3WDj0e6Asgq8rLpfnZvB0BEs3crNf3iY+2ZHbRchRHqFngApHXWAPe2Mx4vE6OQ/vGtdg0CNZe+LRrqFhybYht7w0ncoUvqrGbv1FhlM5ymyhAQYTTvBnLb7ecw0htR+3pIxdjlU1a8wdJxdQXseD4W2qWSvbJAIzMjCb0CQea8FAY7uDpcfxUBuvtjxrioFaFKHsbHJdjwND9Afq5TEHPfEDCdBzH/4upDIUFNJmseGEhmvsQNB6rbcmdVA6/ma6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wrA7/X9opwAkuEEAU27YKHiwMVAMi1LESGvLdX9Y5w=;
 b=bJ9QLhExuZVgcASNsWuNvetsbKDk0OH0BlVk4+gCrys9Y979aIMvdOPgvFXwqpKHJcgC8X1ZVLTNThAm2yxmNCtXvKMC3gispWT/fsrMH50QYrEFSgpyOATab12X69swCiubDz2kcJPSCXGv3E/SXIO+tRaxT/vZ2Oju/VnEUC+rrTd7QmmcY8aW3irijdJV45S4WF5A4C/jjDXs7JY2OQI9P6gb+pGKmHQoQu3tgKFM1armT2Ress3yJBLNmrS2dPXSBtTlacsLF9NoVK4mZFUQxaX8Ky8JX4ph3sqxtqTK5hJ9/h9FagU8b1Q8pacA9JnmfITKQNw0C4Q+uuZVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wrA7/X9opwAkuEEAU27YKHiwMVAMi1LESGvLdX9Y5w=;
 b=nAcH/cryF+HBMW9lExVHfpUAKIn9SfsWVHFOcpVoS6AC9+t2lF4nd6jo0YqQnfw9hnYKVLPAPTXm7gF70gm/ZadJ5UrStUWcA9ILZQksC7rRJn8QIhd6sXIuyYPKxB8y9FOAbfRCDFrlBio3fGu7Azew4wnHP5JkraWiUB2Mrjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB5251.eurprd04.prod.outlook.com
 (2603:10a6:208:ce::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 09:51:47 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 09:51:47 +0000
Date: Fri, 3 Dec 2021 10:51:45 +0100
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: YP docs mailing list <docs@lists.yoctoproject.org>,
	BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] Bitbake's manual only refers to DocBook versions
Message-ID: <20211203095145.5bpuu3pwmwl3ngy7@fedora>
References: <4126a709-c4e9-b844-1fca-f72e71d4093a@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4126a709-c4e9-b844-1fca-f72e71d4093a@bootlin.com>
X-ClientProxiedBy: AM6PR0202CA0049.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::26) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AM6PR0202CA0049.eurprd02.prod.outlook.com (2603:10a6:20b:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Fri, 3 Dec 2021 09:51:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7158f6d-5819-4c1c-2dc7-08d9b6428567
X-MS-TrafficTypeDiagnostic: AM0PR04MB5251:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB5251E4AB6855F8FC383F7013C26A9@AM0PR04MB5251.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gKt8NnPn9UJ9hMyaIiTu/mmAZa2FUdnzs7YfPfbHXzkmBuSItgMbmAU1xWRWy3rxvFEDrwhKdqkAvNOKrikLRMOlvSrfHh5PokPng1NYF8LIHdSqqLYWfQUx4RJOX5GqKdm5ZMLbeBbd17AeliH7kZ2S3TKG66HA4axxRH8bTFVTUtr/nRsO/09PP1JjL6eMJ5F9uSVglWMYH1+MPVGZaX74VU/gyRdegVrsP5Ruraodnrc01ioqQeJ3NiO/K4lAOradK1VyCCYy+9GYU6jikzEkUj6iPfLSIUux/DPhawv9Sivtr2oV+ynyRcZ9AnBHD52G3oqBR+JwDQgpW9VjcB42gDS7RBp8WjLb31JaIiUkN6LPFaq5tRrZ+XuFct7BWTXBY087AzAfCB9HSWFAHfGDgtQT63/2sA8YaDzLus8NSUzw1WvTUalUu7StZ4ZvQsgmMrlhoXYiawbsuB81gpE5wciGMJ3a+PlVftWEWf1he/tmNdOAFnhTsm7s1QXmH71ajPUYUBaD8Sc0MbTfFhrWkLnlYVWEM0g79H7Omv06oGJ/+rSUOw5pjC1vmfGOnMGu1VwszIPhIefJ20wgUBKkWvlt/KfJIGTazcCUHoFihC3E+Qnf01wecdTGP086nvO56eDWTuMYVpQu+K9H3+O1YI7x5Wzdqpo6Ub0hiwzt5FCqKWF8v8Ef++Y8+4Ewk/WQgTLQ64u9vS4u1E5fKwPCXeJZEUsGsSdldrL97GEUZGcrskczXLerPSayTHfZZAOfEB+CJrQlL02yO99oXCc1eXYcHuLAniTpjSMyTaQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(52116002)(9686003)(4326008)(38100700002)(38350700002)(8936002)(6916009)(2906002)(9576002)(54906003)(44832011)(33716001)(316002)(8676002)(5660300002)(66946007)(508600001)(1076003)(66556008)(83380400001)(55016003)(966005)(86362001)(186003)(956004)(26005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mWARYv+MOE0z+zJW5P9NKiDlZtD1YUH6D4c2x8Ddv2BlAlHFtzBN+hYGAPlo?=
 =?us-ascii?Q?bpXiRXh3dwh3uEduFsTylpyuVq4nIc7JTDxtLyKw/Zt50EzKg18m+B8EJMWY?=
 =?us-ascii?Q?jtSKfDeSfwxzoRVuyvqhxONI78U4yYWTUvD5GAOAaGoiu3yeeTRmRe+Y5SQS?=
 =?us-ascii?Q?lt+al3jXpoBl/cqkI2B3fvPN/ZfKBYzPjcm0xYAy7zWiUgijfx6Hbt+XweAt?=
 =?us-ascii?Q?Jmh9KfJTMuQx/hEaiMslYGAGoHYB+cPe3YmjifNQQQBsY12zrt7VsX8O4h+N?=
 =?us-ascii?Q?a5GIgLYzRoyR/inLsNEpyK6u8x/ggdbqWvL429fqU4bsrbfduEZ/B4gKAP/4?=
 =?us-ascii?Q?rxPIwmh1PL3QDAVVcoV8+rFtU66FJXeuat4z6uow2YV/UYeT+qfC79CqYjj5?=
 =?us-ascii?Q?IYxnfsqpdWkSKlPHMhPcgQ6nVmsUpZecy66kgeD6LOkrX4bi6/grdOKs0TDW?=
 =?us-ascii?Q?JafnK0mIwhKNm592nMuPl8GvOusvYJfZJ6kjUKb4nW9Plp5gJLXlO8k8tLRJ?=
 =?us-ascii?Q?lhIvqMvCm9HoqTrEG8lTOgdSeSrD178joF9YHkdW2p99EpuAABS3AcZs2Kct?=
 =?us-ascii?Q?QKAiehZWNOIiH9ol6X1dC1XIhMbDVz/uY5OoLUc1UBTd+W3tfrFypUspapzO?=
 =?us-ascii?Q?FGhT99ZcyE+o1uWVXbjgpzjcZ/ZE+biVO8Tp46Y3zAQNTrOLrJS3iqhqSKTo?=
 =?us-ascii?Q?zt+93BDb4LpDCtPp5TjRFjJUY89oM2QRV8jO5mvXSiLMdJdgKZk2Cnha22s4?=
 =?us-ascii?Q?ZFQEmySdp4Xpr0dHh7McA0vpD2RiJs8TOfrNzonsmxIw9IDHbakjBcgKxEbf?=
 =?us-ascii?Q?GJ74Ae49bpwvh30AgNVKJP38PPvMbZt+aB3l+drvJi6XWmiKu4GOvAgg4oQE?=
 =?us-ascii?Q?FkMsqdjIExPNN8g4F2IL80FypLosv3m4bFGSyjjUgeWa0lmXqeP24t/Luqg2?=
 =?us-ascii?Q?T87yNJBDVnQQL11YNw52T4YvjzN9Hkp9Iflz5ip3/opXzwiQ7QZK6fh9RsD1?=
 =?us-ascii?Q?OUgC7YjSzz342pGgWqzOdEsIAWRSvFF34SpE3wAjJTUgBTWq5KT3E8Ec++G8?=
 =?us-ascii?Q?NiYVvoWcwFOnKzqD1OxKFvbTgvh19qauZIUuHmRtddpDUjC1PG1KIfVrN+9o?=
 =?us-ascii?Q?amviQMazZQmEnKSbMbZPakjdbsA39d1tyoKh7Cg8543jd8TvvpuiUA6lHxyT?=
 =?us-ascii?Q?BkJIYJv3lyFEaboC5GxRc3gFenW6HXlBnQaxwRGRPZt+6ygXt2VcEg2gxPMb?=
 =?us-ascii?Q?5K184D0nmIozDRpC+BKMec3zSIoRxaTRZjiv5XKWunaj8EXRWsZZfbLUvuwx?=
 =?us-ascii?Q?8nOvPCzjgDiENPbkRhMHhtZgZuWOvwLcwsdUysfwZfHpoRigGGzIW8MVPo9v?=
 =?us-ascii?Q?0441UuSUxH/n7SzzoGtt16rSoloiIHJhqmyRaFHPnWkuOuekp+/T7HB3xyuZ?=
 =?us-ascii?Q?eP4A8YNDLRlMeU81zhR4u6yLM/ZUVEjHRTwd3A5kHTSnsrJt9/aJGYRuDyBZ?=
 =?us-ascii?Q?1ywter3nz8o2cQPNTbSZLVr6kXpmvkQUXhUb4fuWoxZe/EzfVJw8gK/LCTpR?=
 =?us-ascii?Q?CkoYywrzg1ti/B20tUZFwbq5wG45LM+vZz2eRyFUC9tN1CoAsDfqU7kbWdri?=
 =?us-ascii?Q?yZ6ZIY3dHUJ3nO5iTHJ4mJ8tdSE7xO7kD+/JTc/mVjTi31wLbUjMz71spBSb?=
 =?us-ascii?Q?YQz5Y6qC1XRSURija4tSrBAKl/dXBApf3BGj4/Wf+Hs4nj2BtcYrWf0qBK/C?=
 =?us-ascii?Q?pCdZ3q2HFw=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a7158f6d-5819-4c1c-2dc7-08d9b6428567
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 09:51:47.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 OacMJZ/W6s0JRxw2qHzBTFORy5wvd01Pbkzw2zu8BU4O3+2ze0LT6unhA0hmaRLHEVWAvra8OkGCPyOqSG3qXHbgiO35bzCGfpPos0ms61Ea05dTWSyrg11QlvcLMPB6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5251
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Dec 2021 09:51:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13124

Hi Michael,

On Wed, Dec 01, 2021 at 04:13:22PM +0100, Michael Opdenacker wrote:
> Greetings,
> 
> If you look at https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.yoctoproject.org_bitbake_releases.html&d=DwICaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=nmz6nRfD45I3bnlvaIJlwgW4wYK5G9nb3gDSkyP74fFUUHF4WlbuD9BkNH-9erYP&s=e4XFpr767d7wz5ZNyrurX3eZsxr37oW4HaNlqf6EHzc&e= , only
> DocBook manuals are mentioned (for example
> https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.yoctoproject.org_3.1.2_bitbake-2Duser-2Dmanual_bitbake-2Duser-2Dmanual.html&d=DwICaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=nmz6nRfD45I3bnlvaIJlwgW4wYK5G9nb3gDSkyP74fFUUHF4WlbuD9BkNH-9erYP&s=DnCrJ1SUcsVGumwq8jNF_a5K7LQiyjorQZ0QMzdSwJc&e= ),
> but not the newer Sphinx versions. For example
> https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.yoctoproject.org_3.1.12_bitbake-2Duser-2Dmanual_bitbake-2Duser-2Dmanual.html&d=DwICaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=nmz6nRfD45I3bnlvaIJlwgW4wYK5G9nb3gDSkyP74fFUUHF4WlbuD9BkNH-9erYP&s=ncFosfETX9y5ER-IFzjYY2xcN_XsygOFxo-MmpwA9V4&e= 
> doesn't exist.
> 

We still need to point to the older docs before Sphinx migration but
indeed it's missing the Sphinx ones.

> Fortunately, at least the latest Sphinx build is available on
> https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.yoctoproject.org_bitbake-21&d=DwICaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=nmz6nRfD45I3bnlvaIJlwgW4wYK5G9nb3gDSkyP74fFUUHF4WlbuD9BkNH-9erYP&s=WHxtpElE6Ddm7XaOtkShZ44Z_SAtEAADW8Nwui2veRg&e= 
> 
> What about modifying this page to refer only to BitBake versions (1.48,
> 1.50, 1.52... plus past ones), which are the only ones that we generate,
> instead of Yocto Project ones? It would then make sense to update the
> switchers.js file to make it specific to BitBake.
> 

Not sure to understand the first question, but in any case yes, we
should point to bitbake versions on this page, both pre-Sphinx and
Sphinx. However, I think we need to keep in the text in which Yocto
Project version this version of bitbake is used to make it explicit and
easy to find the bitbake doc that is important.

Not sure how this would help with switchers.js. We could always have a
check on the base URL in switchers.js. If it starts with
https://docs.yoctoproject.org/bitbake then the dropdown menu should show
Bitbake versions, otherwise YP's.

Slightly off-topic but I think we should also modify
https://git.yoctoproject.org/yocto-docs/tree/documentation/conf.py#n93
to point to the objects.inv of the bitbake version that is used by that
release. The point being that old variables may disappear over time,
breaking older YP releases docs build, which is bad. Also, it links to
the newer bitbake docs instead of the one for the one related to the YP
version the user is looking at.

Cheers,
Quentin

