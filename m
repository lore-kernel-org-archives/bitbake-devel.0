Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F35C83F17
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 16:35:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.75])
 by mx.groups.io with SMTP id smtpd.web10.85808.1753720534998702475
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Jul 2025 09:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=GCVZvZaT;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.75, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akpRT2oZCwBEXEf6YQRzLwFGsDs1wcFF2J+QcgINW1QyKtxt12ISNs5G8b6WVwJ6s/ySImOhVjgGM9cSK/gajZR8fFschu8U8zNOQaio13GEQbZqDwuzNWhwed9hHj5NjvT3avuvbOcKkJLTDa7zuX1O7WUbgj8UuIHX6CpAPCpy7Eo6wQRIA1BAbwDofmKyXAkmnGo2zCatU6nRzmG2HD+9NYSoq4yc/ZUyg/GxDQe8CVa2lZ3P1KFNaM6F6QwiDewAFwxc1nDlnyhrN3o04zxHjWbOEZAAt/LXmRtxCMhhMvISZs44NFpndjcGzaZqMLH6nn4BWP90ORTjdtIAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW4YXpXVioPop7Asgindy9YPosSwTN3mwyOLkcZpe80=;
 b=iPdujNQ8uFFOddNVNtGiC3YdVQcW+2kWrL7Sc/rsRym6fm7k+TdpYqqJI3QbcDO0JRw7fDYgFVUnoJB9+RRcKuMt5nn6asFRfbQnEnkgHIlCYpJK/C/GamuvCMs6SkZnu2zQtRyr5aJVkY+ATRWmMnk6ruNZQUId+KWR25T2PD8t6m4qk7npkqjmGiiOXijmMHNPNb9iyN3iew9RjtIllNDr6PwXqAZCVPO2T5d0V0bQnuDhpQTkjibZkkl7EZonJ2e3Qkuo5a6t8Aq1UoaB/DHkuL+hTHjk17Zk4+hTlEXGwLqOIfH18TvUaw1Efc9kkv+4yo2p0jvGpE5mKfLU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW4YXpXVioPop7Asgindy9YPosSwTN3mwyOLkcZpe80=;
 b=GCVZvZaTrky58zvOUupZbIBKuTkuYJXlTCZg+pMub0N2XILmv5RhQj291CNQ+ilMGcMm7yoUiKg9mkvcfKPSfBUSD8EhX1kNYB3SRfBZA2BwMTA1y8PTcqGfB0WbFpoi1YVvltjN1HmpjupU5F8PCZElPuYk3vdu1Hz67yn3XZz9VDBwNgweHk4N7yqHkYTrdnktLs2gOXdennvr9lxr37DV3+xLsE995RJHzNhFKvffXGJ10aVXoxBfeCeKy73X5Pbba+Np07BoDz66V0HqnFLjBJbhkSHfhAFhUtna2HIFcewYjelNohn/GGKLVmPIGpxjjEgqppoFUq5mkTADmA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Mon, 28 Jul
 2025 16:35:30 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 16:35:29 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Steve Sakoman <steve@sakoman.com>
Subject: RE: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Topic: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Index: AQHb9+uF8KM7bcNTukeelXLn+jrOubRHyDoAgAAC6eA=
Date: Mon, 28 Jul 2025 16:35:29 +0000
Message-ID: 
 <DM8PR12MB54308BAB68E5AA158005724E8B5AA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
 <DM8PR12MB543065BB1FD2642696C540D88B5AA@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB543065BB1FD2642696C540D88B5AA@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=46537642-836e-45d7-80da-87d58a8cf1df;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-07-28T16:24:04Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SA5PPF8BD1FB094:EE_
x-ms-office365-filtering-correlation-id: 3b6d519d-822d-40a0-5b26-08ddcdf4c3b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?C3mAvbxmOzlP9psZpoNQCipOdxk5oqutUMKyK/9QxRSHfV5Hf7f0sgszEo9M?=
 =?us-ascii?Q?Q1gS3KoA7Mij5se0hzjpKwhCoRg0oJKKYUakOk7BlPus8c+EtYKBMjP8JYBN?=
 =?us-ascii?Q?uI4b/v241JBgskpKh70LZ2WWb/TiHHSfyZpyi1N+d2/E6ttLdq/TEj0YYWs8?=
 =?us-ascii?Q?WlrVRW2qHLjprNK578TbABt+sWr1tUwNO4m+x2QhiO8sLOsR4aYaEFi68Gp9?=
 =?us-ascii?Q?iJQGiV3wP3hGBS2ZH1RE/Sb2Q41RNK2A4SbzjNuBO20RU9SHEpXLvYiuPEYi?=
 =?us-ascii?Q?ZVDaYklPmERKnmcVgUJ6j+rb6x2Zob0QSZLD8woWJOQF6G/ANwtkSUrQWPTE?=
 =?us-ascii?Q?2zPLR+Du86GGDJi9etUzOO+MQhDpmPsz3MkPbTlYp27JKRaHRm+N3HCrwFT0?=
 =?us-ascii?Q?u1+gAoFefsgLUXxn90LS+FISCetfNM64HxoU/RvQauq0OHpJGyu8vn7SL/Xd?=
 =?us-ascii?Q?OjHJje0X8Db4frUV+1q8h5UseEvEnzJ/M4rwD8HQXsnWQYUz24tKcj+zzcYR?=
 =?us-ascii?Q?rIlLExpeOSvBSMnaNAfz3GFma1WqXLMYhvzKq3NyHJGRFlzithmxMcbsmLJ3?=
 =?us-ascii?Q?C8G1AS+Qk9Xhb1YhNpGpw0nJBoac117W8qqyISIZZJ+7cndyX+LD3KpcWIQW?=
 =?us-ascii?Q?NBjpxg34Cz1S0nYfwYKobEK8jyYHkp6+r1+AQ/h/vi3lne0DyXT00YobmzTc?=
 =?us-ascii?Q?ozunEUc3s4QltWhG/mzc6NaT04f84cUkNx49+7RSKTL/H7Vou/asiV37tDNX?=
 =?us-ascii?Q?Srb96KuZd5smtx3qrxitllAtfVM/B1+HFHXQqKtqpPopms8P00hdMaAD5Jsb?=
 =?us-ascii?Q?OKLo+JFgEV/k/D87lyU28m0Jq9D7Jlxb5Bg4HBfue4TijLmTwntNzbrB+KN+?=
 =?us-ascii?Q?s7bsMZ+2n6fsLbRahqcqFOKVXn0pIXoWidGUQsvl1HQfAwziedtPTU9ctL6F?=
 =?us-ascii?Q?CWk+UQJYqlVSHkH69poiM+uBxmDj58Nws8u3oxUDFLHGktb/WZKwwQQAVxre?=
 =?us-ascii?Q?DAvER0RK/UD5dDwq/8+3ULwRm424jjIqbuJtGCbUq92fnzTOzWuBe/t6AA6J?=
 =?us-ascii?Q?LL/MLrcBDHxmy3jZIbpvADNU6U9lkDp4i+Ro9ncbCcqYORhG3hh7yyhc3A4c?=
 =?us-ascii?Q?ICS84WtFFo1n5hG41s1oNiK8UAzg5D2B5stPpf3M3a8w2oBd6+Hmy2PE2n3w?=
 =?us-ascii?Q?FrFeivkPUoffMgrwdJZJNJFRc/i63xqRESCGJvUtFUJIna2KbsqFTBClmsU5?=
 =?us-ascii?Q?ehuqjpObYq56+D5HL2btveipD58gjr8qMsUg1jqXbX0+Rzqi4MoxKzQh5Rr4?=
 =?us-ascii?Q?qKRlTi1z7DMWeu4jZaCVuQYL/ZlCSvUxzmZtCu2Uz+q7W6Nkamcn1APzBpKk?=
 =?us-ascii?Q?YWkBvDIFdFLaM90MNLrjlOC6F2Id/jkFVoCkflpiX8b3JfAiS657AEA7cgkc?=
 =?us-ascii?Q?ruVsmbISRlU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?9XAh9CEv5HHlGrGOV8C4JNeK+Rn9O2u9DI7e+O3qf3K/gvI51G2I7pTtWbjv?=
 =?us-ascii?Q?mnGvNvocoUfxc6RXEaDG8WWei8I3MXn5bLyIQg53+5OlsGcpPFTPZpxyrXli?=
 =?us-ascii?Q?O/bIDpGOnSouFTjqfhl9kLReMgNpqDhzobGUWTb5k+RHIKxmACKudcWujb3k?=
 =?us-ascii?Q?vGvF0oxCv31kRBi96lWHk1WnaoqYUe3lZ0yXP3Sar/TBkVnP3vngZz9qPYHa?=
 =?us-ascii?Q?fVj02+RhIwed7RuEWNnxiqgFDhGOSNtwvoq/GA/S23OnwGpwiR/PHCRNFbk5?=
 =?us-ascii?Q?xD3HFU7n1EdXR+25d1xtwWaA4t88hcGXF3lTMQbOFO28CIrdyf204HBwhWio?=
 =?us-ascii?Q?ETfuFt+QS9z3lBbaxru9RJ87mmtwYOX2sNyA6ckJL03AZIn4Fd1PYwhN2pZf?=
 =?us-ascii?Q?kxb4Tt4asBa2K9bnqmcrWSmiABVtARBOHtxxr447SklyIASfvJ6CZwgdz8Fu?=
 =?us-ascii?Q?okWc9ivNRNf5wcuReJ/zYL/Xg6Vuo+A5+Q6VQPRwz9Rx22qp+UelxdGhKpET?=
 =?us-ascii?Q?Jw1yjnVp2sYH1wzu8DJr74/ngPT35rWES4x30sHnWBe+tZJMA30JBK1kH8gd?=
 =?us-ascii?Q?24OzeoBuOW4n4aQafnc6yxP68EH6ToMzpuR6dakp8qJurrPXWVPQ17Ujfb8+?=
 =?us-ascii?Q?6Fw0cjuzD6h0siPWasfOf9V+Urs16DTuEJoZwSgqNfdIim0CqjA6BNjSs7/5?=
 =?us-ascii?Q?xcLtFOo+Y1FVpD+1XchH8AeodC0EuPFwy7a5AMAKJ9iI0p88+H2GCc7/GHKc?=
 =?us-ascii?Q?mPSeE1XtgdjVTI3j8CixHm+D2G425bKdJdZY6lVgt6n6EQ48clbID8g6Uzfc?=
 =?us-ascii?Q?R+saCSssq55IopNF1j+Vr1Osdd+BDnAFMfg9g4p2xK9jCClv1qKcYdktz0cP?=
 =?us-ascii?Q?3TkPNc/+J3+gPLOEuj3SxPCgMwcTYaIGAk5YDu7Y2qJpcqqWSbyOE9MDAnAy?=
 =?us-ascii?Q?OthAk6nYiclQWZ8R0V4AykNBtGMAIOLnDHEY3fZD0RS2wFRjs/ie4Ye7RzCz?=
 =?us-ascii?Q?cIye8RHNRGHDoahgmYvKy0+ObOCHRjjj4QzFqvNFKEeDAkUe/tlH+vZmPgPj?=
 =?us-ascii?Q?wMH5kTgWUABSCcjqa95re0RNlU93d3iZwsvMEBoGsB0YqSfiRiV1N4T0y3xG?=
 =?us-ascii?Q?QT1EjZNjCDFqKLwqJNy8k5pZEYyJ496xChYI1F7WWLPbGuxDZniome407hsG?=
 =?us-ascii?Q?BOaWVVMLC7ADwjw2wm3/8HCVBjEPiqwOqvz2ZvO/3bZXmTrIwcVgu9DDl046?=
 =?us-ascii?Q?DbmheHNFQILQKtyKWhAh47eb3+PPOaM78HQH/2S+ZZ+OyjYblldP5ZaEuYgu?=
 =?us-ascii?Q?mD2y2HNm6POhgzVBjsp86X3AQ660a/1QwdwK78iC/ndEppCKsrR8q9cCj3jT?=
 =?us-ascii?Q?bArkqRrBJT2hp7ZV5Cki7Kkdu7LDJymsryH2igBp3Gw9GzMXEM9by/f8QIRU?=
 =?us-ascii?Q?PtTNUos1vQExm8yizoFSMi8vezBVm7iSsaf9AVH3P4B464JL2aiisSvv8BYO?=
 =?us-ascii?Q?leOqxC1Dex4E7UcfwIu14DC6uA4WVGbZZ0vX33toqtgmdzC4GfwuB+EWPo8w?=
 =?us-ascii?Q?P/dXEaDe+xyH8vGU0divgBsDIiWzKYzevUk1zGwO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6d519d-822d-40a0-5b26-08ddcdf4c3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 16:35:29.5295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yf5CiTz0cyqIUu83G52RI5Ldyf3sPcJfeVVIsIJm1v3gNku42Px31OJv4bftxwVFbju2rwcn+Jwtz7kRGIN6fuEZm14hPaT1EtbDZqDCgaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Jul 2025 16:35:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17816

> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Richard Purdie via
> > lists.openembedded.org
> > Sent: Friday, July 18, 2025 9:55 AM
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
> > performance
> >
> >
> >
> > External Sender - Use caution opening files, clicking links, or
> > responding to requests.
> >
> >
> > Running "time bitbake -pP idle" with a valid cache shows around
> > 800,000 calls to enum creation from python's signal.py. We don't care
> > about this overhead and it adversely affects cache load time quite badl=
y.
> >
> > Try and use _signal directly, falling back to signal, which avoids
> > this overhead we don't need and makes cache loading much faster.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> Coincidentally, for the past couple months I have occasionally been playi=
ng
> around with VizTracer (https://github.com/gaogaotiantian/viztracer) for
> profiling BitBake. Just today (on Scarthgap) while profiling the cache pa=
rsing, I
> also observed the issue with the sigmask. In case anyone is curious, here=
 is
> what the results look like: https://i.imgur.com/BGdzSe5.png
>=20

By the way, at least on Scarthgap, this patch turned what used to be a 30s =
cache load (for a build with about 7 multiconfigs) into a near-instant proc=
ess. So thanks :)

Thanks,
Chris

