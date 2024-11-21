Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1ED75BCF
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 17:54:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.71])
 by mx.groups.io with SMTP id smtpd.web11.5021.1732211687236936916
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Nov 2024 09:54:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=d/euUc7R;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.71, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kafuidNJDkbr9HFNNG1krGgHbgC8MwJ+hpZwno30xTL1HrEwzflLLr8j7wAutZ2kerIbVZtf6VYiYGe7kimDrW/Zk9yLkK1yBffgIXOwG51yyaOTgj7XOgq7yFS+8DQ4pm5EzbUuy8zqLHwOFWui6p0iNxBH3n0rgq66aa77hPNur8Ps6l039njt5KBb7yhZFz+HG36nkxbHGQ3IP2uSIQs2PXSZIiOyzKukHAX+2dEAXyeaKH8art+zWa3mLrkqJlInZvDKPk8VUvNAR5FoInWUe+POHsKVsSm6gABr3trGnycUrTcWAw6BfmdKOMsJZTnZlO4PDgORXCz4sb+yIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQbkWjpyWz2OtaKVLYfvpSAus0Htao8UrR/KIaVx9hk=;
 b=kk/vnxaFvYnjktmN3YYJfzxEKgFoEfkLTjXpqtl8sw1al30eK9ZL7fn0SnQI0H1Kh2xf4BcSCTwwEZlsms4eHLmuJIkblPiKdfRKARQ0xTrJoiQlP/afi27jCPceO7/VC13GM1YBxo8f/HAkyUwfA0DHfxFaQ40+3lrkZMkr/8FVOT2VKkbSc5f5BIE/i9bOqdtbleBA2xjY83DkivMPpDxyzhBTxzH9hVeaa0qieS3krJ/GRnFbAwlGbAcjdAHSDymQ4atON4NUvMMAfgs8f2ZUhHgNrY5fKkq5kXaBK96sAbsUliG7r8XV4ITN0viZSHSC48vJcHIueIuXk8/c6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQbkWjpyWz2OtaKVLYfvpSAus0Htao8UrR/KIaVx9hk=;
 b=d/euUc7Rj5mGa5hKDMZ5TnzR+H/u96Z0vT6utPyS7rM20ZDN01ubretIr/YEeLml2VzB3vtRvAZMAbl6upzG4KhcZCwfLgbkI1aYarDyiV5pElA5L17ckNBDvuh7HuX/ic2maxdofUDlVflnOI3SGbhPPz5Kw6tzRFy9ntJiLs5Svww+/YppOIH1/6YR/yy+iG3m9eNTmRMoChBhNQqK4ekuY9j+hysi+oQkRwmagQPVgHdjO09ugcQcjxIiUqdCVkz8lmoGBEJWklKCGhrCUStLvafw/RecLwZ0DBUFq/m2Gu83fNkXzLEwXSb7SivQccjSxhX1v5I+4qlvMcxTvQ==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.27; Thu, 21 Nov 2024 17:54:44 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8182.016; Thu, 21 Nov 2024
 17:54:44 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "steve@sakoman.com" <steve@sakoman.com>
Subject: RE: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
 persist_data to a standard cache file
Thread-Topic: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
 persist_data to a standard cache file
Thread-Index: AQHbGX65WALcs3wjNUOGQEjavFXHBLK/znQwgAD1tICAAX2WgIAABnsAgAABnYA=
Date: Thu, 21 Nov 2024 17:54:44 +0000
Message-ID: 
 <DM8PR12MB5430A554AC3944E40A6F1B898B222@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
		 <20241008123627.252307-3-richard.purdie@linuxfoundation.org>
		 <DM8PR12MB5430F82E66A733A5687F5FB78B212@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <e7fcf2110ae769882a989d104e92bb7291245a6a.camel@linuxfoundation.org>
	 <DM8PR12MB5430E29DAE622F328269C0E48B222@DM8PR12MB5430.namprd12.prod.outlook.com>
 <d63db1ebb79dacf3b5ff5303eba5be0587df7925.camel@linuxfoundation.org>
In-Reply-To: 
 <d63db1ebb79dacf3b5ff5303eba5be0587df7925.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=e14edd8e-27ef-4449-87f5-4799ea8f26c9;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-11-21T17:54:29Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|CY8PR12MB7217:EE_
x-ms-office365-filtering-correlation-id: 6d0d0962-2be9-4328-cff0-08dd0a559539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?OMSH6zi1XFDIivpyB9Qw34CYLmUQN70cMQvMt1AC/zHeDqLr3T36wpQEns7c?=
 =?us-ascii?Q?o66Nx1qTRNhT0LYzpXk4ev5OGMBv/7IsNIDhkZAOwHGwoIjJi3oHWaFAi9ve?=
 =?us-ascii?Q?btEbnuRM4PcxR47qxQYVVn3msUtI6lspS2FE9FonlwZFYx8uXE+KKvzc4GD4?=
 =?us-ascii?Q?SLD4rp6eH5ZsQc/vXb4LryR1QC8rSe+T3KsfOw5ygJk5MaTEcymHIB3CgrDA?=
 =?us-ascii?Q?OlH7TxeUzEPZBP1twXviLqf6kp7HM0W1F5CC74iY+oZAYJOXzIDwRVjgm5Ea?=
 =?us-ascii?Q?M/UC+gK8Rl0gFlI/+GJyWAt0g7bzzt5vMs4w5RmMXP9y/NOW8+8k6sxs3pvZ?=
 =?us-ascii?Q?zMAHYiFajE5jAHJm0z/U5lC2IS9L2nx/ePIeDJU8sPl5cpAM5rMAtNzukw/5?=
 =?us-ascii?Q?Zs+2NRSY8zUFfbmLadrW9O1HRSGcmiJJz9KJGpnpccf+xmodWD+c63S0XMZH?=
 =?us-ascii?Q?LwolTts0PDkiH+G6Dq3IaWTWkO13YGkjL34q2aDA6/vEUjX4eA81Hhlb+0aM?=
 =?us-ascii?Q?vC40a+B3FDRQE9aI1tz/74CwDbT7W5JyhEeumvnxIZR319d5zEqSF4L86qLt?=
 =?us-ascii?Q?oK4hsStYfBdVmjMTXmEJLxrR09nazANBAAtuyC6AKpkzg54N4bq4GOmKaYke?=
 =?us-ascii?Q?ny3ibRZZYI4raDmI8xpCcL9a8S+eq0YpYG6JMpXpIFWV1vvZjkSoBNI2gKO0?=
 =?us-ascii?Q?xurSnFD6i6v0HzUasEszZcV+6LiI01M6CnXtEPbyClOxk7YbYxWJUGywFNGP?=
 =?us-ascii?Q?MUwXZq6g54G9cuVEGxT6ccLF40tyRIR2hLsP4aD1RD0XAS9oDgftX4XddIr3?=
 =?us-ascii?Q?XB7eORU8vF8t6KXoXso1G1aBiu0VpagHOw6voDfDbdthwPJ1SdyEKANQP8ib?=
 =?us-ascii?Q?sbQCQNVSKunowiXkIBnomN8eyhl8Fdiy2tRZHlAwCag073DYsxf3C/IRzSRh?=
 =?us-ascii?Q?EbFGMXml9gP9A619TuoZ+aRdEwITHHoSFdHLIZYSYc1EU2S/f77fI7HtaY7L?=
 =?us-ascii?Q?Ok7bYdFH7K2OrXrFJLNYQ88QQxnOzcaRCcYk7bh6QN60aSGmw5pFcLWJBQtz?=
 =?us-ascii?Q?PVjy35s1BFVR6dtJmPP2uVKwdm/E06ZlGCggkD21HqMXpDme25zqQByrT09K?=
 =?us-ascii?Q?bM+L/ub5KnXRPUPe+IhAH/vg7qvCi6NX6tKEdESG4+251//xdh1a9IozUCGH?=
 =?us-ascii?Q?znWlouG6I/1eWqsKM2qAnB6A4/p+pFAPEjvGiG47I8UuEA0CDDFfxx5A2T5l?=
 =?us-ascii?Q?JXxJTcN10cInMKCan9+lnvIYfA9K+eugkx0O1iM3yX8D+QiK/tC8UAiIsytb?=
 =?us-ascii?Q?quNGPf7is6EugtC6cLcAAy5oXtZfforg+KQ8WcXI4r4muMgup3OGI6tF5OLL?=
 =?us-ascii?Q?jc2jHfA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Wd2Ie/vqnwubRjBaN5BqI0oi7+jdVb5IQ6sBpQyFaJyEyYp3GchcQwOuy/4o?=
 =?us-ascii?Q?j/ahNvKEN+AKXrKyaw3+HZ6S137FAHYoiXUDbWXLcgm5nJyjsnE+XEhSvt7b?=
 =?us-ascii?Q?x04jVzYhW3gDm9JfSJXUsDvBOLEPmessntkiyM+0PLbYjriIazJJD0VeRrgv?=
 =?us-ascii?Q?y/z/QJHBWJMBAtfOR9zB6aQb2HQt3unNCl23MI22HTWEqZXVutRiul6EA/6L?=
 =?us-ascii?Q?cYd/liXafGTOOpHNu9AkznMQsFvPE9dBcbh159u/TjNX4cEqHI7NYjfs9hZE?=
 =?us-ascii?Q?WXmdRjc/Kf2aG6OEmV03Vs2QCZ/BDLMjxn4eQGyHHDXkKQo4YiTKBEoVAscV?=
 =?us-ascii?Q?zSEBZ6qJhA0eOeEGzrQ7P3NM0dowJIo0JU6HyEtOM+QDM6CFziYzejsWeQVP?=
 =?us-ascii?Q?euXIqv3S4QPp69HA5nXHFZCL3U3/BsILKVTfsLy3n44IEC2oimPQU7EkJYOY?=
 =?us-ascii?Q?xUT2V+8Kf8jC2Z2VwKBzAbotSivcsdN5C11SuVc9BWjIVmnG7+6ipmFT+oCc?=
 =?us-ascii?Q?POjrFnm+74sxHBGx1dGFGC/4LrB9QLfwEORuIOe6RSFJ0mJUoEnix6w3il+e?=
 =?us-ascii?Q?c6uQD6oorvrw2p1863oTXmkKO9AHqkmsui69sia7YzkSKWafzftL9rinboVX?=
 =?us-ascii?Q?Ru/LrzMgdTKiSS76JcZ2tv5Cxeq1n8+LmkQcJxk/ke9V49QxH/3pw0tXCzZo?=
 =?us-ascii?Q?lgLU6xelj3baFgL7qjs96POpxF9CPMtj9wMLbTVCQHGeALJ8EGbBzYe9oKhY?=
 =?us-ascii?Q?DNvP12QQwvzmMqsxGGV2GmJMb6pZbaMABhojC2IRnW5cMIlY1FsitMxr/f+o?=
 =?us-ascii?Q?mxgHD4oi2bhL5T06/YlxAej81mJJzAEP4r+ba91sZJFBYDjkVeQ/TvOw3SVT?=
 =?us-ascii?Q?QREpeqRJf51uveEF8nGYU+vnWDm8jE6BGY0DojUAHtJfDg9W1C1XrewhCXi7?=
 =?us-ascii?Q?F51LWtskSasGkllaJWNo7y5P8PYBlbaYz8DWDVq4CExJLJD1f+9DG05kMPns?=
 =?us-ascii?Q?GkUOaGIdkfIPr41A9TWsPqdGDriM5uzf+9QJj7bdoE4T5XRKb/XPoZodmlD1?=
 =?us-ascii?Q?X3GRCwnr/OmZxhU4sLH2H8MoL50lwxjcK983mIsQYDVw6bUAjHk9KqoDQcNW?=
 =?us-ascii?Q?uKCAlLlr263fD9/YFd46DJQJqTEHMnGUyKIzpQ7Y8epClVfoqAGW0rU8TcT6?=
 =?us-ascii?Q?9gSQ5J4A1rd5fhqUCe2HH9OPbMtoxSFGVfuZKsi+bKteihCA92te112d7hdj?=
 =?us-ascii?Q?0FzZASCWQWDK5ZhwPsRtFNX5OIigos7ZGGnqjbrs3rzxEtJlzA1hSFEFfnmo?=
 =?us-ascii?Q?yLIlzDN4WXfleGiUyn4LTIjx+hlz1IggtaXACmQmaSZFMHRs2qecsd5pZNUZ?=
 =?us-ascii?Q?1YLI8Y1cmrTs+6fMoHqjKdWMsAGOTbEA+nn4SPwAsxQ1ivR0t/rxU3Pq3kqK?=
 =?us-ascii?Q?kMDnaSz07YTHJVqJZZY/6bS/U8wT21wRulCR0l5u6jGu/8TXKm8/AIFN9tzE?=
 =?us-ascii?Q?QqDmJYVciYXX0PjQEtebguiM+gO0LnyVjZK4HlPXK8oBg/Qf45MHQwwT0/Tv?=
 =?us-ascii?Q?+riRuNSGldw8hoECi19rXDh8QiPMsYSxNnl9RCb8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0d0962-2be9-4328-cff0-08dd0a559539
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 17:54:44.8118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYP3yWPdXhnS0wHYjVT3/PotGdwobXFFmxxVzcItfwDP30WDV/KXPfxSQzAsXLw50tGBqRxFEXQ8pCI/K5roXpumX8WVz35xecGZLW8J30Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Nov 2024 17:54:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16825

>=20
> kirkstone is based on the 2.0 bitbake branch, scarthgap on 2.8 and styhea=
d on
> 2.10 so those are LTS branches and are where we'd need patches. Prefix wo=
uld
> be [2.0] with a note on why it wasn't needed for master in the commit
> message.

Ah gotcha, will do. Thanks again!

Chris

