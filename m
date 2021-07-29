Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.64])
 by mx.groups.io with SMTP id smtpd.web09.9864.1627567393048454616
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jul 2021 07:03:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=fW51DBT2;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.64, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwf5ndAvNQPQ75Z6rQMz0bxLO48lz/pe6yB/kgGRXVA5GlPWLdiFY4oFVM2BzwHPhM4GbvOdnG0A5uLXUFoe2VHwwIVnInKIdTjuxh3N5ZY0Uec27PRlit/KZ089wMzp6+bVWOgLYWia27ImNy+nfN5Oeysb74mVJqMUbT7YR75x+u1vXVl8ywZ/YlSoPUC0XL7xkUbkmGBs3/w6Q+Ov1l2saiUdzBCQiR0pJXumh9SVBJujZgrRQYfBdS8BsuUEbl87H4b90xmc+1ejlhyHidOQ7hWwYbD905zGV/ENu++LRMTMuQ69Reb2VLF+fNBAA5idDI48cT2DnGbPyOdd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lHPzRxjgx6fyYg0VbJFqA+4+yyaIuZfhofQiGdQ9bw=;
 b=UbLFA5AQyLbFGCGhws6M/3aacgU+UyiohpD/3gl9NFicw61+iJz5gnSW5dEHDsFdhjJx0/7II/eHRJWWCUP+a9P1eJBgoVudegfvsq3qRie/+Ip04P7v4tA1CQ7HaDmdR1tGOWNwcdJg8RzyKUvtqiKZP5WPKXZGc9rOv9zZbxrkpGg1SiKsi2p74D92SjXEnXqsZ8xVrOxaGpKcZaZjTODErwGD9roSi5r+RXdOl1PcltgwSiCK7Qf9rVIk24jSlXqz6kck6R6ukeQkxSY7cIYRd9Oe2ST7bGnNOOAelwu8CeL9faIWnd7/R8W8YV+jDKStJnErQA02iCozexGAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lHPzRxjgx6fyYg0VbJFqA+4+yyaIuZfhofQiGdQ9bw=;
 b=fW51DBT2YAqlFar2q7yiAm83ANL/1AMyrLvkuoe2TehJuFkn3x6D1b6IOYmYMLufkQwHpj5Ymtyb5+suldrjQHbhLqj6SFkUgk6IEWf4Sa+bSGAl4Qkt8snaQqtndx7txNBubcF3wSPzKgI9RsfaGRwGF3YiCNphJC1Oei+bhuw=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM8PR04MB7396.eurprd04.prod.outlook.com
 (2603:10a6:20b:1da::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 14:03:11 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920%6]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 14:03:11 +0000
Date: Thu, 29 Jul 2021 16:03:08 +0200
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org,
	Quentin Schulz <foss@0leil.net>
Subject: Re: [docs] [PATCH v3] doc: bitbake-user-manual: grammar fix for the number of "metadata"
Message-ID: <20210729140308.6logvsvbrnx4h3fc@fedora>
References: <169647C17DBB9BB3.13113@lists.openembedded.org>
 <20210729140051.165306-1-michael.opdenacker@bootlin.com>
In-Reply-To: <20210729140051.165306-1-michael.opdenacker@bootlin.com>
X-ClientProxiedBy: PR3P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::18) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (92.42.140.82) by PR3P250CA0013.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:57::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Thu, 29 Jul 2021 14:03:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09111814-111c-4641-c742-08d9529999a5
X-MS-TrafficTypeDiagnostic: AM8PR04MB7396:
X-Microsoft-Antispam-PRVS: 
	<AM8PR04MB7396973DD9D1A7BC62936C72C2EB9@AM8PR04MB7396.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XpdF4nybU+2dlvbMRWn4ZhEBxaL03IDD2BRXAT7+ypqI0zDCTrehqYPIZeAZt0cnw/lh9MbrVWZDfX8b0CYefCWs8fXlhTUwu5IunRtyrKwev4bI2sj1lAp2t5wfwxPdBdSXgoNwXwLvVjgsD5DYKnihCz7FoX8oUsREq6SEVyuVheRKXPDOXnk+vkQL1EHlu3jYlidspOrg8pcTcphLU2cdYVdILa/QfhL/e7FEmlUz7evr2vSmZ+dZvfP5u9FMcPe7aAZ57jEA26isqA2c6lcAxBB/ma3f8t/eqj80PhejPrA4pZJdZGodDREyLj1+enz6SXNBA46lijBjOryOlst2KSu5PWhGyoyFiR23ngVIXqpAyFFGVuKtAor8qkCPHtB9Or+tfExXWwPcXXIU6iZABF5jOVK1LkItcNseQE2me8hdYRSL5rsDMtTvzH+RpQd11je9ndyTXvJNydFHab1CQ4ewBuIZd7TZTYneG/Trkyz5auYlx6XaNOXaGcz//y0AgpQogXsP2OGelbZBdqDTMT74GvuUj+uyCUjsHnWvMTBnwvBwqgQFsXyxqJn5SZnK6ItZOt89UxeiFtFK19sVT3VK+o/sKaQb/q86I5md31yVqwBqIEUEWtwCk6JdT05vbdt3JrQYwEvfckwPKWMpHnP1hz6Rz1psik7Nxg0iIMKes+yO2B0hdwdQEz+F
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39830400003)(66556008)(186003)(66476007)(956004)(38100700002)(4326008)(38350700002)(478600001)(2906002)(9576002)(52116002)(55016002)(9686003)(33716001)(8936002)(26005)(44832011)(5660300002)(86362001)(316002)(6916009)(1076003)(4744005)(8676002)(6496006)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GtTcQXCv2sjwYFeaZQ7DWMZTpLN+ij7H9Z7D7pSlThcy1W1HoYgJI92YlYNw?=
 =?us-ascii?Q?iC6cP/EPEJWyUbKhJo3LwDXkQpNK3keyoUcnUFaO1OloonM3iYZJuMf6Y52r?=
 =?us-ascii?Q?S/6lKgiJCfNvy/awnfmIWU/pppZs8Lw4Ctv8HR+GuEF0niRZJt9sTeZDDRUR?=
 =?us-ascii?Q?F8ICUKOHoxiM+1dYOITDVoF5tktl7+4vRBhhHLVL8a60xJBmkuPOERRcm9zJ?=
 =?us-ascii?Q?rb+k7mftwDFzn7afnYWsFvrLzhbC+lwISz6yLPjNHSut75AMB/CYtYJ/Aa/j?=
 =?us-ascii?Q?PKdQagL1xiG5CWzTBD4err+pJ2XoofOe0UJbouQE25rh3MAGDjlvDSm5qpL1?=
 =?us-ascii?Q?f29OOPPeHVju2t43+6VCeppiFHnz6e/yxuj2AaLIIjcSVcZswAGH4rw6FLLb?=
 =?us-ascii?Q?Xtb7NCGRGL4Dy6y8veYl3+CP3WO8/rP4PMJPH8A1x3NcUdG2c14Eepc9WkLz?=
 =?us-ascii?Q?3mUpn7GRjN6snz75OeeP4zzzIyBgl0ZHIFZVE3IkHVYPz3gKpXY4UixHblcz?=
 =?us-ascii?Q?3KXoLEDznCEZFvWWGT+eIf301T+U3k6IYt6iXJhytpx8B6GUW0aTw/MERac2?=
 =?us-ascii?Q?dWsaKexbu2BPAC5/K5ZuZborLcGO15LJIl9lCcdyCasc91Ax6zNRV8tRpgms?=
 =?us-ascii?Q?ElOEm9nWStGfrfRmvWAQ1JBZ/qvFRFYmMf4/hOt/E65YCCqTNGlLuGlw1SsL?=
 =?us-ascii?Q?PrbmYuDbRt4MIi95DxFw7+0kq74Ad55qggFlmNrorIqYdoARKWzfHsxD2DP2?=
 =?us-ascii?Q?kzzNnuqM0gergWR3MUGfKhEIP/wwrGE7kbdp4ylCnt3732wBUvJ9g4WCXj9y?=
 =?us-ascii?Q?vg1cmCed27ZdVOexiH5nZPRWHBFkYScpIq94uon4dJf1ZKtbtGN1EKJyBxQ+?=
 =?us-ascii?Q?DnzbMDHo7wHvC43mbnUIBu40fuhm5QkLMuIWFzo5XXrCtpbAIVIkBdpfJ3u9?=
 =?us-ascii?Q?wciN5h9+hu0rXVSWBSLvyEyPB9BM749g6BaG+rh1WPWI9L6TWw5Z+KCvc7la?=
 =?us-ascii?Q?Hatx3DljGvuCftoqgNDudfhuMd9IsqLOliMXpopDy+HWwCG6PXRZl9mTyuz2?=
 =?us-ascii?Q?WFwN5uKNGhMgt2YFfcVUr7qdYkIy4+DbZJ6inpHGKH00kFEYH/vc2SZcqgf6?=
 =?us-ascii?Q?y5DRjgTX5g/i9Md6ofv6p049D5QttOBbmnbbWsBLX+sbFDkKKVAEaYjWu8nl?=
 =?us-ascii?Q?O4H1SfGmp/pZ8l/Advm4bw3Cl0md2vkZzHE9zzMoYKaVw3aiamuNEiEN+HTu?=
 =?us-ascii?Q?5W01O8GnUsoZBPc5FBDYJz/seqODjXqscw57Um+cftkl7sz1Yf0+kpplD6st?=
 =?us-ascii?Q?6tOacHEekyh1dGWBc2H2wePq?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09111814-111c-4641-c742-08d9529999a5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 14:03:11.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6nQyQUlKLE2l3+MnGt0UWEQtBUEMcqkikActpF8ZpoA8PI1WcIBDIDOj4yRHCRKcY42wP/ooYsy482Ogpjniof0NVSmYuv6ygopOdwSOedkS7ls06BjxrdqdXTU77+r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 29, 2021 at 04:00:51PM +0200, Michael Opdenacker wrote:
> "metadata" is used both as singular and as plural.
> The first change fixes a case in which the verb has a singular conjugation
> but absence of article indicates a plural case.
> 
> The second and third changes are for consistency with the first one inside
> the same paragraph.
> 

Nitpick: this paragraph does not apply to this patch anymore as far as I
can tell.

Cheers,
Quentin
