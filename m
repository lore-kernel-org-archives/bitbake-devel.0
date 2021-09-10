Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.80])
 by mx.groups.io with SMTP id smtpd.web08.10218.1631285295063210801
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 07:48:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=KF+SLEPV;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.21.80, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqrkAjIQHbu8A5FroqRtTzA2ZHE2LRw9coX6rm6wl76ulH6DwKJx3SFbyr0qsrVWfk3+lor8F5I2roNiLs27HhhKAwQaK2Axi3cFSahvagIT+D6TyygVtZaaEkw6QfVWIEdLllg7cvBQO/dD2K6C5fNrfVPoYRssS/IAXI56ED0raIa0ViwptrSu+iOQEnuRXIDKX5KJFENGkCk4e6eUBkJSkwqb7xNSgpj0dhfR5Y+K2vlAjA2gYrlqQ5BSwa1570MRTXVhoKCTfiAcwFENL5zL3Lk4l4iTD6P9/33cMIhTvbPZfSdwZbduh/ZpvPegTIZ3mKoS6eVMwTDKy8CVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SWpqPdovCruvZzH6Tr6hbyNx8MpjfV8eYDaRksfxDyY=;
 b=Eipp6oEoVqQEWm/254v2e3thd1aSLNqgvYTdii5YFM/CtU8KKXDJdEEL1bv45n5RVf00yAzjIQ2RACHlAEgO4ybRW94PZIjKl+JsjCdrHtuwHSwpfNhFC6LqbS+HK/JJKdD8zdqWDKIT/uaE3I9KjJU6kHPbW8lJzWY0ytVz253MsHo8BNd7CaNN6ge0t0qVnvWDLIPjMDHo0erGEidZTeI4uVbKfayWnrHyWsjBoeHa26rijS8GzpPBqDiF7A10sSYIj1Id2tPRG56rLOgTr1ewa0j/ry3LHwwJelj3QL+PnithfWQ4lV9k+rE71rYBJgDEjxSZS23KEFpKQGejTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWpqPdovCruvZzH6Tr6hbyNx8MpjfV8eYDaRksfxDyY=;
 b=KF+SLEPVB0aeli4KcV4Dgy/sWdZHZlh1c4rlYUAhPws5D2AhwCjKySaY2MpJQYGjLaQI+WQsvFMQcxhqtHLzMJ2quTxX46CNXaMtANKmqLSQ1drx8/0Nf0H1TbqxqmhO+HxyFnH+5An5s+z0HDnWAXtC4QK1eR4I/x1OKLFnjyU=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM8PR04MB7908.eurprd04.prod.outlook.com
 (2603:10a6:20b:24c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 14:48:12 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::7987:898f:55bd:ec64]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::7987:898f:55bd:ec64%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 14:48:11 +0000
Date: Fri, 10 Sep 2021 16:48:09 +0200
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 3/3] fetch2: Add recursion guard
Message-ID: <20210910144809.dngz75n4k4kpis4l@fedora>
References: <20210910140740.1256597-1-richard.purdie@linuxfoundation.org>
 <20210910140740.1256597-3-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210910140740.1256597-3-richard.purdie@linuxfoundation.org>
X-ClientProxiedBy: PR0P264CA0175.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::19) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (92.42.140.82) by PR0P264CA0175.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Fri, 10 Sep 2021 14:48:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 598ae6d0-c341-403e-3051-08d9746a0323
X-MS-TrafficTypeDiagnostic: AM8PR04MB7908:
X-Microsoft-Antispam-PRVS: 
	<AM8PR04MB79088AEDEA4E5251B53387E4C2D69@AM8PR04MB7908.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6aMOOHkaKtdOIgv0UYBEryYnbblf6mxoVPT+karO6XfH80xLghQPUUAY/VbXDyVHbMHa1Z924Yljq5Xrr4xEeKhnenatOxDvEdDpeOlyIoEf1m7PfrAnSFsdhuz7ldbZrkS+OShWv6cxDxXVKWjSPcJ9r+qo69mA3TRvJSFVdEBkE8y93FZO+0ApBFs6RQtxNoEXyXE9jac2xb7BfyF26TnDL3CSgtlSDu9ETbz0vs6mVeTkDuNOVEqS0hFG5ZMCXziffUMxkygpKrW5CSuMPiiH4i9IUXtpewLMiRnHFD3VVfpqHtXtnhlmtgarKMyMGLDiD+eyGbJuW2ebyrMfuDFSfmCNwwfGoe2uMrx53UKrvYU0dIuoBbGCOpjO9p5OIBA6epG0H+eFZlkIJyEkOKjhibNnhTjVSIIXp1pAvGDu+fyd1YF+aNAJQ1rk/SNrLxJDuR+Rbng8v5jvvbeyJOEut5m4lGor/WY+y9QjQeomvNDXAPiarjXJKU5VDgfNeUaZWYVdMG7LcGAFE2MvWNe/D86Roh0/zkL0EQtntua6BTp5bTzwR0rCZ6HfRG6NaZQJotXk6tkQKB+jzH5+p8LwyUeiyPuGaUEfdPqybjzYoNT7mmYxFuTaIqXRzhiEIPD7QD8qLSqruZJZ90RmKqe5BtSNIQM14MhHabd+A8I9FlY4uzKe25gJOCy/T0lbLnVDlneAuv+WH95prQHEsQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(8676002)(9686003)(52116002)(2906002)(4744005)(66946007)(26005)(33716001)(6916009)(83380400001)(66556008)(9576002)(55016002)(6496006)(956004)(86362001)(4326008)(5660300002)(8936002)(1076003)(38100700002)(38350700002)(508600001)(66476007)(316002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xhaYuT3v+2qudv9SkVdWVlhN/cFqz1/xi8YLJhya71LbHISNac6m3Zh9wPgC?=
 =?us-ascii?Q?a3OdVy3/2h5V4Ttaw8fBQhHYFF8imY3m5s7qbuHnqFHuhrKS3pHNgU+3eHNX?=
 =?us-ascii?Q?S95bOkjXhM86wzUhPG229VEEVn8Sszboh7ZokU2U7MsLqxujq6Oxyhf5ZFod?=
 =?us-ascii?Q?TGT4DB2jws1WE9tcMYJzRUc7cxcta2r+YW1NsSos8ltSbARFQ+yVSZbRowG2?=
 =?us-ascii?Q?B01akPbI9jNdevWE/oPOVEkcbjq1i7DzCeykUxNBhkU0oC6Tsj8yLBR7OiTd?=
 =?us-ascii?Q?65rUgluH1vqjm/8DfRx/Uux1/9fdT+C+7r1SdbqGA9T02MQT+7Udn+le0hR4?=
 =?us-ascii?Q?RTKJ0t+XYsF2Rw+FDUF/VY8OOJFbSFITUkLuxczi2zwPdZ98TS39/sG40S+/?=
 =?us-ascii?Q?TRGUJZlhqFSov4p1qdhXcEvppwQSAJ16Bf56KWUYodogXJVNQoovlI3OqI21?=
 =?us-ascii?Q?ndIjJNc2iFsJb8qzGhmxtfBShufhflrVKv3qxZYzTH3OJd1U8cZ1XbcSONna?=
 =?us-ascii?Q?L6bJ2nCx4FHr4+5zR8Nj/e6i07C4WXZGN8jv382IKYwMAqHfTZq1eqMnGMHr?=
 =?us-ascii?Q?QToFqQuL5lCcjcba7//QWpCefPtu+zcU9COM5OU7/eKUYoDZ+Yu7lyb64wTM?=
 =?us-ascii?Q?V8kGDxgEhXIiZIwG5DvtXTKz9PvBTUzDdLHP6sZfEzpFjgwP7PW9QuTpkicp?=
 =?us-ascii?Q?7i4hNlcpghXoZDMEHRNwV1rK8eSe2kCuP44haGsz+M3R0XB2IcQ3ilhyErD7?=
 =?us-ascii?Q?I3w9XQgjTXWwzljasUdg/T2oEEVBg2YkooMTZ0yJAnw4uFZVCXTVqPpPKxXj?=
 =?us-ascii?Q?X0tG4rekpz3+hb4w53qhLqhSjiOsk2OOqyuqosQDrwvMZX3bP430nmzX/Ws0?=
 =?us-ascii?Q?Ay8Ngd5WNx7YvmRKpwPQzEvbC0t3a8+zVzd6X4UTXLibf1eSxtHlETdJ0iqa?=
 =?us-ascii?Q?IKSH8WlIAaVUMpB8fX5V1ZjsH15VTfqLfjOfQjutC0V5Y+ZKSIUs8Bh+Pf0z?=
 =?us-ascii?Q?yZtmxFk2Wr2YgZipsRDeHHp7Zo04W4lfx7UKTYCpHdUT6aidSJ52DSZ8Wm5m?=
 =?us-ascii?Q?qPcTTkMqUuIuUDeeCYhgL811bFrrBtjTL464Dhh4Bhk0mbS6HNzg2P+NGCys?=
 =?us-ascii?Q?/OqY7e/JoQvRq7MGpSaWeNzXzopCd+T62jYva/H7y2TWRXgHOi8bD9C+6KUr?=
 =?us-ascii?Q?FTnHpqN+A/FEgfL4SJrF16ElSnMDpjqAQvvX4IabmqN9i71jtzm5HrYEPWtD?=
 =?us-ascii?Q?K+AiopcKNAYyWn80/BwotEhRi8OpN1QW3v8SMcYHT2Nzsli4hjoTQCWZp4+4?=
 =?us-ascii?Q?ZB8Q/fVKGmIF6yCf6YLfPT+C?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598ae6d0-c341-403e-3051-08d9746a0323
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 14:48:11.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoUGiAkYa7Y5zQwarQ++OrEvEDRHGChyinnfNQ7kBoPU8caNjpG38cmEYTvxmPlBcnI4FqLJZSkXkQoskmXWGsktcus80/JZ/2QMe9uBkyeC3T0pCbe/XBE6AR/XLbvX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7908
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Richard,

On Fri, Sep 10, 2021 at 03:07:40PM +0100, Richard Purdie wrote:
> Users sometimes put ${S} references in ${SRC_URI} without realising this can be
> problematic. Improve the error messages if they accidentally do.
> 

I think we could also add this check to
insane.bbclass:package_qa_check_src_uri ?

Cheers,
Quentin
