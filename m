Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.52])
 by mx.groups.io with SMTP id smtpd.web09.9092.1627563928670860364
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jul 2021 06:05:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=MDu5GY+x;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.13.52, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHSoQi/AADJqLElGIYDWHl0JWPjFlQH/tleM0QqFd26tloHGRco0AUuFjfXfUDRZP4xq5vT9jz/GEwh/u39v1YYWYqmyuRCUuSMKLgy9nYPuB0Kx+vLRgBOVU89GY7V1huqK+NQZ8g4WKXQtqAyg4NSTd9PJbID+fK6TNRiTlTBKbLMGqxR9yFytDtzoqjbhWkKOfF62ieOfF6kuu4hPP64TW89HmckCexnOK2flFZOUNV9pvYLwp5rcHRIT5NTAfV0QZj97b7oUOewR01vdLGNUorcpcOfnQ6jmZLZv4CBOvIee88ieLJ+F6mkqoDK2wQjXHSQBlXAXLOnjjKkOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ijel9FeYt627ViqKY0wnUsBvdwi7jv9GQsJq60DOo=;
 b=dAo/8Rp+wsSLfWBORFRk5Bj1BoP0ZdgKL56tXMTPlDly/zbQI8xQxHgxiuAL3MBJpC/J0NWlb+WNSNUgrlXaVPbVtenXEivrro9zjuhHO12FU3Ql148eQXna7yDSV+02GMGxoHT4BP2VXA9Cu4vooVcZ0wZFs1u5nG+Mx9cs6ntVbMjphwtpVzTNotYgIYoKcWt9w41SPODlpbqQisYX2A12GZQYlveH68USZ+1E7Vm84IvacBOv0LgRC8EVp2AWkBYmdmYhDc5+tBrBgvdngwEWoipGDTbx0cLP6i83jkqOzdHjuPK5Mm2t8xHYrjVuerjt+5ncY/pcuA+EprKRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ijel9FeYt627ViqKY0wnUsBvdwi7jv9GQsJq60DOo=;
 b=MDu5GY+xv9bnVYO7g8+5MfG69NmBEgJRv8xw0qNsVJw5+mJpaMxx611pLduUHQ7AtkUSeUX+xcgCk9a+jGkM4XWZAoiHPS4DupglsuAvMSq4Q7vZ/S0BVbgzzKT1Xnxt8wbOo+PjvCEKbLQCoNTpvgVeEqWaQJY1Fxh9fF7bRvA=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB6100.eurprd04.prod.outlook.com
 (2603:10a6:208:13b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 13:05:24 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::459d:3240:1c4e:b920%6]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 13:05:23 +0000
Date: Thu, 29 Jul 2021 15:05:21 +0200
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual: grammar fix for the number of "metadata"
Message-ID: <20210729130521.e5dkww5yktdf3uno@fedora>
References: <9aebdc2ca149587d39cd23628c392423148f22ba.camel@linuxfoundation.org>
 <20210729130133.163787-1-michael.opdenacker@bootlin.com>
In-Reply-To: <20210729130133.163787-1-michael.opdenacker@bootlin.com>
X-ClientProxiedBy: PR3P193CA0022.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::27) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (92.42.140.82) by PR3P193CA0022.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Thu, 29 Jul 2021 13:05:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee887540-8c2e-43d5-f4fb-08d9529186dc
X-MS-TrafficTypeDiagnostic: AM0PR04MB6100:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB61009EA468E3E73278EE34FEC2EB9@AM0PR04MB6100.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l6orMhUEf4tnTHk6txwAmfXkEA/HHIfQyZTBk2UY62oLMA63DekmWTmKny53e70vEXvwOo1P84e3cs1DlM9j1F2XypAxP5x5gUjzsi46EOwl0hQukdGy417ERqpKq7wpI9JjUTtA2J3tpOUYdPxn9wlG41JAb9sKoYYJ+pGsQ/LNzMONwOS2KkivCbXVIgh2+U8YH1WE8aAQhFeH6r/8RBRoPLRzi7F3saf5ro7rVmyUK/1cRlX49+adl+3xSqQGSHQg5IPnqShiWGnVUyIh5aToDtVbWONs8212gUKzrA8cCIn4Zt9eOquGkm559uYnPmhjviSWoRb+EREaLMT/3B1fVCSwfg42ZoWB7YelWIKheyYNiJ+IHLIrqEu/kWRa+98DFNHF5jsbNnPl1A8y6lC+QMs0zNfZGkSZm3cuklobF3TjSef9p3hPjvjEBswGc9n+cyZdGnkuIlybyXbserefMY0yIQHE3mRMGFbd3YNfhdvLrtOuLvzyXj7o5c9zt0fxkVjcoM64gJcKP6zy5TXz2PvFgCJ0ERodKxz8G4WeX+KHnLlFIOdVz4AHBssHrClT6l/o2m6WWxxM/BnvyiucRw14ddYqUcjPFwtVJTNytLFOq0NXaITAxBt6B/kVGtzz1ra1Z44qWaxewgGyFVkW2Zk750Nhe9D05n/UG6zRpSz7VZ2eZFE0LA4vPnBWo8l1SfgV/svhvNJZ/VRrSg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39850400004)(396003)(346002)(5660300002)(44832011)(38350700002)(6916009)(38100700002)(52116002)(2906002)(1076003)(478600001)(8936002)(4326008)(9576002)(83380400001)(9686003)(33716001)(6496006)(316002)(86362001)(66946007)(956004)(66476007)(26005)(186003)(66556008)(8676002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vH0OwqyUGK9yxEEfzg++4bd532m6ZRNqW+GYkpOh8mID8lqDP9FZhoF12J+O?=
 =?us-ascii?Q?+EYziAVe2yvuFaOyMlb7e5SiUB/kg/+mqlckjOCOn5MuxFGDIzkGnlU3YnQ3?=
 =?us-ascii?Q?DGDTbgSAqN5cr5AeiPH/ljadXI3GctM755h0kHWTslKgqvj+emdJDI8LjTK+?=
 =?us-ascii?Q?7iVVz0BvgtuwKYxw1qWyFWpklTKmrvO1Ttyr/mdfQaix54A7NqR+8lOl0iDI?=
 =?us-ascii?Q?BJjLSNF0cR0qb5x0oVUDZmcIQzzz4yXWQfpb3uggrMdN8kYkeeO2F5PoThYD?=
 =?us-ascii?Q?qoGerH8+VloU3ouuks7xiaETSCP/9L6JMfrmvaqXyHCtVeM7ArDXJghvoH2i?=
 =?us-ascii?Q?q7vU430sFBVnLA+WdAj5aFi8AzHTIF6XH8WtWelMW+Q2AfOy/QRGEv+G2Ru+?=
 =?us-ascii?Q?P3rcBBdjEVwTY3UKoLp7xYHhc/wfQnlOvevv5l9dEM8KtMQMUOyLChQQm/Ls?=
 =?us-ascii?Q?ttlturzdphs06O5x2BUu7ejaD2SVOi88ZM6kRuTV1EYAQSsi04JjLnVAoCXa?=
 =?us-ascii?Q?C7ZL9JnQiDZ1p+Tt3wODIcykmQbv87MLwjgQQZvKMc1Zb2w+ynM3uakOGHJN?=
 =?us-ascii?Q?YNgfq3H5vjJAj7tPLeRujttc39KFtaRIpm9ljnJRK5VQo7RTGHKqp+Awspiw?=
 =?us-ascii?Q?LTOKNX/YXJIXP/F/CB9AAuFohP30PGt3Er3ipkLNmS/K/1UT0I2btXZReQfX?=
 =?us-ascii?Q?yEOFNFElB/YGONHJ+Ixoy3ZpM3k3SEZuLhyHMXVQVsnCqtIufqVU6k3jl79I?=
 =?us-ascii?Q?BMlUzLc+s8VCebIssSgqCdGoKIASfeAwS4P3N0MgB81yi3eGs5O4AXZFtU7Q?=
 =?us-ascii?Q?GjhrBVtSU1r1pbg1wWpo9kswB7HTHQfWV8IZiw+o+PSoSsY4CWoCJ5bQV4PU?=
 =?us-ascii?Q?2zQ0+i3FS7veMLCI6zfJ8LoZEJ+LLd002pDxt5GCk7+Op+dtAI5+Uv+4/L3P?=
 =?us-ascii?Q?WkOc3gwqoxAlH8vhl9xstCWXNBmPM6eLAuyEaRr8oVx+byF6UsvaMG/qypaG?=
 =?us-ascii?Q?jkqnRSJ+c3tMD6fONtdPoi0xJ14Cv95mfGTOpI7ql+98cQOjZFfYU5svDX6n?=
 =?us-ascii?Q?EQbuqetYNhOiRp/5nrLCTm5654Djk0j+rzd7Oua6MdDbe5MmJZ3HLricxEbp?=
 =?us-ascii?Q?ytMpmLNxwwhfn1v65p+4Q0WBn8oF5CDYl/O9PCwhw6NUZGtudNDb06c0gmXf?=
 =?us-ascii?Q?UGzEHpLJFSn7gmQB/XWPnd96WvmsOkV4s1rrG9nzIRF0rV0U3/e3X0quzPFI?=
 =?us-ascii?Q?IqBY+zMdaE4YWTWN2zRvrM6DTJehj0N891XDzk4o6F/oN3tCKc3Dqbxe0OZi?=
 =?us-ascii?Q?KGCdrS9LCsej+aRkaov6oKOf?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee887540-8c2e-43d5-f4fb-08d9529186dc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 13:05:23.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMrDBQsM78EAJif+fV/z0jNgPXhe/nKojU7uRppn5bph+7Sa/ecvCAJztrguAU8e/3asYyafpdAozUKhLMj3QFq1F+PcgoarCG/wfj6auBXLCUT37i7MuI/aTgT1a/fZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6100
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

On Thu, Jul 29, 2021 at 03:01:33PM +0200, Michael Opdenacker wrote:
> "metadata" is used both as singular and as plural.
> The first change fixes a case in which the verbs have a singular conjugation
> but articles that indicate a plural case.
> 
> The second change is for consistency with the first one inside
> the same paragraph.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> index eb140665..64e7305d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -27,11 +27,11 @@ Linux software stacks using a task-oriented approach.
>  Conceptually, BitBake is similar to GNU Make in some regards but has
>  significant differences:
>  
> --  BitBake executes tasks according to provided metadata that builds up
> +-  BitBake executes tasks according to provided metadata that build up
>     the tasks. Metadata is stored in recipe (``.bb``) and related recipe

Then "Metadata are" here seems appropriate to me. What do you think?

Cheers,
Quentin
