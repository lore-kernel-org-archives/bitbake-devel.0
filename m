Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF464C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 09:55:17 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.52])
 by mx.groups.io with SMTP id smtpd.web11.3703.1742464508128583237
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Mar 2025 02:55:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=VM/LpSNw;
 spf=pass (domain: axis.com, ip: 52.101.66.52, mailfrom: christian.lindeberg@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coWwJ95jNhCy5JLkS9GBLmWRcBcUyJz1FlIC48e9EFovrhKTOynX9I/or3oHB91hYN12ls2ghJN40PDhMPGYVn6quRJ6gTNdMiSeW9bY6Px70wBSw6YO1Hf88t4PWN7j4j7xR0LjClb5T/J1SA5/a+QG3Jcco+JlRIYl+n67xLYmNsM5um9R19rlicGUc9h/Qe940ggde+3hZ4VQ0DyxpQ3Ylc7ZNpRYJnB7svwiFA3bQKt45vml0oHGe2kIXD5T8QaFMAaBm9ToK90BQ45Zobm7I3J/MMmrglfd3tvnR38j3ZvRhi3XOM9oLNY4SCDT3gqgeAQ9Qp2RdljmcgDlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XuRRvoS6OKGG1jiHM8nVRTjwljGaguRbyBKcMHe5ts=;
 b=tLZSrWhUvOXzil1o0OZVO+CUa5ORnp4GQ7bkq6x+saH02tLVa3Dv9fY7DlkVqinBam8aKgugkTT7mO5mu+iQCDXD+L0JFhktaK0/iKirGUqXosKV2jGntBYxwRHILld6cM+DqeTPlumpdDMHrSOI2CWw9eMyLbuqXxU263FdjWcW57XWKpfz0rwJbyfXiIGtCREVKGp3jpmWuMcGVZRWCdXfp3Tv5g1s/Ovfg3Q22StLJEvEXcRFSqfkE83TzE4DK/1BSBRFL71gJr6Sjqb/N83NIktiwtz+yRbWziXrIxmTmsz5ngW9wSgOK4RJDGTn3XtY7P2w0skmRcuq15Dxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XuRRvoS6OKGG1jiHM8nVRTjwljGaguRbyBKcMHe5ts=;
 b=VM/LpSNwEW3phlmdmUcx4DwBE6xZovhkzaYdACv8j+BXd5RSCfcq2RIQROTgVAH7at7MvqteJTaD+Ilx9oPnH58hIawG8kZRxdZ2pwP3FGq2wTSdWE3kbmlgXbVE4ZDwD63lohde5WizjnpvV3YYltxWIjs4wzQ6Xzum8fU4EgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9894.eurprd02.prod.outlook.com (2603:10a6:10:44a::6)
 by GV2PR02MB8627.eurprd02.prod.outlook.com (2603:10a6:150:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:55:04 +0000
Received: from DU0PR02MB9894.eurprd02.prod.outlook.com
 ([fe80::74bd:5b24:5e73:94e0]) by DU0PR02MB9894.eurprd02.prod.outlook.com
 ([fe80::74bd:5b24:5e73:94e0%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:55:04 +0000
Message-ID: <66f4b7f5-0696-4605-8822-745caacef5a0@axis.com>
Date: Thu, 20 Mar 2025 10:55:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] fetch2/gomod: Fix mirroring problem
To: stefan.herbrechtsmeier-oss@weidmueller.com,
 bitbake-devel@lists.openembedded.org
References: <20250320065011.1560156-1-christli@axis.com>
 <9a1ea09e-9449-4449-ad30-a175df2c8207@weidmueller.com>
Content-Language: en-US
From: Christian Lindeberg <christian.lindeberg@axis.com>
In-Reply-To: <9a1ea09e-9449-4449-ad30-a175df2c8207@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MM0P280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::21) To DU0PR02MB9894.eurprd02.prod.outlook.com
 (2603:10a6:10:44a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9894:EE_|GV2PR02MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fb76ae-6d52-4291-42c8-08dd679549ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yLx1n0e0f7oECjUi26+Jc7R+n3RXYnYGuH/h5zkQPgwy/Vcrv0SATWqyyQDi?=
 =?us-ascii?Q?ORHKN++hfJzQ0kh1N1bNqh5RX7C1QufJPWletNZpYhniRuP8DsKdMVxw2ENf?=
 =?us-ascii?Q?xYLCa4UDumymS29MIOueDk6zjbPmmAuB3IMsHlmcisYW3jiqqRq/lMxKcP/Z?=
 =?us-ascii?Q?nry0S9ccxhqJ9sIsA9WZgVhVC9Et2wS6zlrt+kTqf6YlxDnIetj6890uF19E?=
 =?us-ascii?Q?a+7DqrgpDmO/TJlF2SeyGaeqsFDOX5T9qcacMyM33HGNB/69kzrk5R6ZcC0X?=
 =?us-ascii?Q?AiVyhovOKRo95NURCMwtJh+m485qxJHUFvpFoRdvb5ZinWfdZQJ9SEIYKUg0?=
 =?us-ascii?Q?CJBuW5nBSkZhPQaeIjdNBahUs8QCu61V2lH+6yt24xk52szniiYjZigRJAX2?=
 =?us-ascii?Q?zCmesGGNzan5hHK27FBWZDeb9qHp0f6wVPFcxYWOUYqyNX5n+3vmVW8MP72y?=
 =?us-ascii?Q?iQW8cmjedjwVdLpDtjIBzkdQE5bB7VqikJ/S8sHb57ktfLaS8sMPVa0S8+Ys?=
 =?us-ascii?Q?bSlq/SLyG+sw5IULRjHOsJAZUkfhC3OTCTy9NRatTghDjs+4WdY3cXGvhpC6?=
 =?us-ascii?Q?ZosBV86xKMKtUv24ZCQP82RFwG3ISqVhwFnBni5MBJHFO68oxK0Rhkdi7P/P?=
 =?us-ascii?Q?lfO3hcR54TAWS1cmuczEZ6D99UW9FYGysCr1e1hbN8s69+kgJh3+i+uqbLzO?=
 =?us-ascii?Q?NJ8K9oEz9kQB6uX37IFLdjo35VYKjm/gEaZ//ZoVAXI2sADHSPMzaTc2ORdw?=
 =?us-ascii?Q?Ii09S530eNKfsjUFeId9sAzRO0zSnqSplvboII9vhFp9GzaWLnvuP7psPgLF?=
 =?us-ascii?Q?mTWHp/IuBkSLseNFoAY37Q53qD4U7K+SbRAXRQRftk0DyA9N5oGyBBm2ha7b?=
 =?us-ascii?Q?40PugIag+s9j1i9RFlO1suxzNDRXvVV7V4e8dWaw+sGCAdoy9AU88xOFrqfC?=
 =?us-ascii?Q?xliwfYhzQR+hwPAhm+HpfADzMUbTFIN2N3A69gxjYJHg6rHEdNh/2+dOGi5o?=
 =?us-ascii?Q?sO+G4zKd4ZTIyiMWlOgTouYNFXt7IEFv2r1mdL4UKzMp09CpVsj0QO/8zI2W?=
 =?us-ascii?Q?bI6n6QfAg7tD+5FYHVclrlHbJVxcdjIpkxjR7sfpDoZE2usr6w+DzH6W5KQK?=
 =?us-ascii?Q?EJZTJ0dZ81UIh7N3KZc2rl11PPJ211znBKlXL/xyPoKKW6OnBjOMNCwCe0Q4?=
 =?us-ascii?Q?O1TvwE2HGeeaVl+uiVLBTkjwbAr+CtKbDL1NcsNbL7necb9EZAirDlm6dH6h?=
 =?us-ascii?Q?l8j5r5BGQ7PtVylBNlfS4FyJGgT8EIxbmJfX8AFHxyHfBaiFTZwYcSr7TjL3?=
 =?us-ascii?Q?G3PBu95jC33jHLih5Qs6+JOuOAHMktPW4ukhkGN1mWFCB6jLrxFSczAgJ1GH?=
 =?us-ascii?Q?R+Os/EalXSq8ithLtK2kvQdkPFvc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9894.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zSg5XBXM0B66aXgo3VD7KAcu7cLHXh52ApMs7PotK19n3Irn2DS6gI2B39JP?=
 =?us-ascii?Q?lcPUZBFMktwpGiRxarF4bsDnJSOueLuW0mGKpjuwiBIBJdxG40OYKEw+SBju?=
 =?us-ascii?Q?Xf4zi2O9t3GCNrc2MY7rLKuHQwGHG4fGk9EJGuojHuRHsrIkfps4UWZsXTEC?=
 =?us-ascii?Q?Cdk7NZkgN55f9VkOeg2+eIhT7OtIMekG8AYM4a1bWtFTWFqjDeTXiZVzV1oj?=
 =?us-ascii?Q?xUKEzKklpDD0LKH6w8rC07BXmlknPOJPTkIj4I32hvR6zXCo5cxowec7RRvz?=
 =?us-ascii?Q?5UkiaBdpTxvGs2Kj2I9aMbNmVf6//3YAjX0TTwckDEXfHqcCXx9OmOO5irkf?=
 =?us-ascii?Q?IjVHgl3CriQk2AwNri8U4Nm7cTnUfZO8l98ZYj2uDZvfqBOaQMa+EhTRUo59?=
 =?us-ascii?Q?wy6Yg0IMNzFEMa3fCrJm5nhkKiUfiw4b6FVpsM7rEpBsMNO1RuiyOJNSZQ2c?=
 =?us-ascii?Q?O5Nfk9wY5SeakmApMAlkEk91+Ez7jox2uDMQAduN4aYXdG9ZZ7gR37DnEBGU?=
 =?us-ascii?Q?0rOUsySioCfkFrfVFR+yZTQZKMOHvQZUZOLr5qsca76DflJNg+Zf16VzyzUV?=
 =?us-ascii?Q?/3P2DSfAYwgOkZPX8M2/YaY0HgRfwMpK0vZCzJXbkpIUh0yzf1IPanLnOclx?=
 =?us-ascii?Q?eaqEfkKQQwywOI0djHKwsS9Ar5ohVfZufAA9U0K1CVazsPZ0PdR5hQtv/YK7?=
 =?us-ascii?Q?/LgsHUiGg8XH8J3LVl58eY1NQYg3XzfFAY6zrgzaV3iYZspOuvY3FeIRDLZu?=
 =?us-ascii?Q?wNLrn/z/jZZFtTgz+liJcpNwT9sGDfdLgPJzeGIwYgXGa2NV/dCa/RlTPxE4?=
 =?us-ascii?Q?WV5h3phOY+hVlcSJNif1nOyqgfROMKXbXsgKiKWg6LX2/SK5PMt+oknOlS5W?=
 =?us-ascii?Q?tuW9jFZJIzWswOTlZD6sJrp/fu7KQIFYEtUNviziaiW/s1CRJrWs+NQFth4g?=
 =?us-ascii?Q?sWLTfL7gKZJo0+hwP24Xiyu8cfiW1p7hSFiuXqnRNt7jf9d30+2C8pj2Fair?=
 =?us-ascii?Q?+r4lxGW9Tv8wFrn0PP+Zaku9dyF0bSmZkcKvzYrEdqMz2yFOuEn8w6lhGTpw?=
 =?us-ascii?Q?OYfJRq4rpKfAymsUN2/XtA8EzxInvSCnHLUa9RLYIftk2ysftkYtmUDN0pu5?=
 =?us-ascii?Q?EV88DD7ojPSUexfI1e4aYsU6sQ8pFbcA2w1DbCUk+mz64EtbqjxLUCdSgw0d?=
 =?us-ascii?Q?uezURnSNmCL5Fgmh37xJ340uemnmLPlWsg/PIP+m1bo33yq8HP2Fq+UQFszT?=
 =?us-ascii?Q?xW4AVimYPyEnInHw+l4eccBAlP1AzVu2pJeMzw00EP5IKlShpoJ2UrL2HlCU?=
 =?us-ascii?Q?sG4FX6QnGsLS5qVybrOWMMaOcN4z1vvh4/Hgl0GipQwV3Nf3o8poXKZKS/PL?=
 =?us-ascii?Q?LNiFNGdrZhNw/WA7eNpo6b9hRJGt86bew4Yi5Zw+eEkdxai5yqJTh3nBgSfL?=
 =?us-ascii?Q?i6XrGfxuhSmobrLE8VRmGUX8Kw60sdIfbKZcfQhAuQJsgZZadxjvp54KllsY?=
 =?us-ascii?Q?zgoqITgffrowjxtg4lEL79ZyWUDU04kvRk8pNXDUFLf7sJ1EsJDkYLhxo1kd?=
 =?us-ascii?Q?XMDCPWASgY5bGuzG9iXA9L+E594wLTYKlsc0sx1R?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fb76ae-6d52-4291-42c8-08dd679549ea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9894.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:55:04.6602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffZmohzHEL1ik4f1OrvNVSSH3+jll6gCbdCUaCC3NX0AlxeYE7hGGrDETCbsU7a7eoQA6s2A2/TY8YsJlzqxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8627
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 09:55:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17479


On 20/03/2025 10:17, Stefan Herbrechtsmeier via lists.openembedded.org=20
wrote:
> Am 20.03.2025 um 07:50 schrieb Christian Lindeberg via=20
> lists.openembedded.org:
>> From: Christian Lindeberg <christian.lindeberg@axis.com>
>>
>> Build the 'downloadfilename' parameter by replacing path separators in
>> the module path like the git fetcher builds the mirror tar ball name.
>> Copy the downloaded file in the fetcher's unpack method like the crate
>> fetcher instead of calling the base fetcher's unpack method.
>
> What is the reason for the change?
>
> Do we really prefer to duplicate the code from the unpack function?
>
One could argue that it is not true duplication as it is a special case=20
not supported by the base fetcher. The attempts at fixing this in the=20
base fetcher seemed to have broken other things from what I read in the=20
threads related to this and in the git history. So I am suggesting this=20
patch as a step to get the fetcher working with respect to mirroring.=20
But longer term, some refactoring might be preferred.

Regards,
Christian

> Regards
> =C2=A0 Stefan
>

