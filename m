Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6160DC83F26
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 13:05:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.71])
 by mx.groups.io with SMTP id smtpd.web11.6600.1753794336466856990
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 06:05:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Kn5rPBRR;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.212.71, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPdaKq7RmBsYd6Hq0PnL8IcBGZPMDLiNHnQGoTGkyoJsoZKzStH5cf3HPpLx5tTVqXSkpOCe4Xs2C5sSSwfeoRcdfqfFWgFlxopgylMvi/zue5pm2J8NmUHpPgNJYuZihssWoE6OBQ6K5AdCuaDqk5GTFh4oT2bc2zr8ZW+wtuXf4P/Nqi04m3tGPfbNVN2QpfZL1zAGtfUj08qqDjcbhB8QJWeaAzob6ltLpf6PYUOnt0Wolc6nnUIB8/BK+qccYPK460sFKF9bP6CdbojIY0+3TALJDw38qb8GwAqaaxDJayDqJqNAkMBX9A7X2UbduAXKVt9zS7RWwQpZJb4pJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/IcRjhyeyIVC3138r0su23GrHDt0zyGVaDe6p6aU1k=;
 b=gokRkoNQg8MjLgdliZHB1YHolND1jyLh3MN0yvi9Q7krA1EhvSe2pLjTx962NCz4ceR4wKkS/LBlnZJibtRAoor6uvyJ29LoLffe6Hg4S0JT254fQayXCNoKmuAxYnnoSC3Ve5W7BntLFjJhvs9ijabXIsZ2eAZs6wo46atna5uXpQhgm34x8pXOSJPhlLHva09zQBwfALOQHeURkYbLq7YkdB+BLXIskUZKEQX1BMwMkLar37BKqumY5kqv5o0QG1Wqa3sr/YH25tbSSNLweSvAKQN4cbXmlpGzfjAn1e730o/zGoC0EdDUhi/T+jOwlgK2/RAIEBwN+K/a3wnOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/IcRjhyeyIVC3138r0su23GrHDt0zyGVaDe6p6aU1k=;
 b=Kn5rPBRRgUNlW5FbGGs/6dlrVwQdJlUGx8wG2/8kMpiyVwjESvSRnrygZPr7PTTeLaNqO7ksE4lAXur+4/ZAqTcxPPC7gkvKDT9KmXfnnBbxIeRFA92d8/ukk63SsoV862loMC7wlZaSETiViGt8Rn16eaPdYtp4nT8x0g0lAf7krjLUH95SC7ecvbHQxWWNsJQzOm97ufWMHgVr5Y5VVILI6C37dXpp6y53g93waa6SR+9LpSiXqT9JcSLELxSeMugHCtgnReF6rM9ZbrUYOeZC8avaEqbQpyTcV4IQ9PQA0EwEG9m919FhqEaim+iyksyB66z21SzRXSjKUr6DlQ==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Tue, 29 Jul 2025 13:05:33 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 13:05:33 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "ross.burton@arm.com" <ross.burton@arm.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Topic: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Index: AQHb9+uF8KM7bcNTukeelXLn+jrOubRHyDoAgAEx2ACAACU9QA==
Date: Tue, 29 Jul 2025 13:05:32 +0000
Message-ID: 
 <DM8PR12MB5430F71427C0117F87CA20358B25A@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
 <DM8PR12MB543065BB1FD2642696C540D88B5AA@DM8PR12MB5430.namprd12.prod.outlook.com>
 <ACE5DB76-ABC9-4C30-A44D-E60D0C672013@arm.com>
In-Reply-To: <ACE5DB76-ABC9-4C30-A44D-E60D0C672013@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=d6fd5f02-879e-4efb-a698-f6a749c61541;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-07-29T12:52:00Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DM4PR12MB6495:EE_
x-ms-office365-filtering-correlation-id: e45ccb38-0df1-4d2f-5e2f-08ddcea09a07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?X8yLurnWFEx054WqytVevLRwap0paMH1dwNZ2DNL+9vTpfQuVmYLCCsLoib8?=
 =?us-ascii?Q?L/yENQn0Kd2oioGOO0nSSeTIGOQwNDo5rpgBloMf1zQbVwPE8PoFpkuUTXzv?=
 =?us-ascii?Q?PDf0Evbn5N4VSqm15ynEx0ZL/pjKGpJ0/o/4mFpxm0YdfrDN54cHWPxpxLoY?=
 =?us-ascii?Q?+4rjiQ8ab9hfuBvv+8J08x3yfPpwPG9OzIOreb1xqpazw3FYxiAR2AuasFIz?=
 =?us-ascii?Q?Tt2AytIojuWyn0k3/6o7UVxJTQc7KdVP6uh8cWv5Zrthbo/cOT0dYRzNvR2k?=
 =?us-ascii?Q?gWTFOgHjtDoVv04sjjaQTwNN9L1RYV/8SokU47aPxZBGTi4IsGRVdsgUddgl?=
 =?us-ascii?Q?ocWRQRJ+0+g0LlHsaO3LzlYlSF8Jic+3NKTZLrhp01nUNDqCjA2J++r10Td5?=
 =?us-ascii?Q?allW8o6l/hSP2GJZCsjJ6WNBSx37O69pQ36gRNEywFWFeCzckLlNi2wdIPM7?=
 =?us-ascii?Q?vn5wOzu9VcG5c6e1T+WJ0kKTgBi1zt1gFa1K8He+XroKBIBskYJCpJbZABbn?=
 =?us-ascii?Q?auE/QkMX70RTyDHVFBqWkhe9yFE+aSN/oVL01lztkUKXiUih+jOSTkx1Rqo5?=
 =?us-ascii?Q?rE2QJrGBt6LC3GbMqORIS829dXgA3id913W/0FTaqxvSp4uw+2StXGcolvCf?=
 =?us-ascii?Q?0XaKa1p21ZLTBc3iUFpMb+JcFbHDclb3N7uc82FXKHmW4k9x0uLXIpUvR6NQ?=
 =?us-ascii?Q?r8GyYQWVADf7LGUGu8ArNx0fHthmxKquxdgbun66C6BTUNKq3dludgIBQwcz?=
 =?us-ascii?Q?a5N+k3dIsDl58Afiax30C2JA8/HLFBKYTLIj0X5LgnnZC/rnR0u8svealCTS?=
 =?us-ascii?Q?XqGgZTbEki1xbDW5FLxcQ5BqMveDRW+VRR44IDIQOWFYUGhqbR/F7z16jthq?=
 =?us-ascii?Q?j7cCLlQiKgF4Ch6nJpnEW9fgyMbJbkXO3kPWmREt43pPe0dZviQqUC1AOHid?=
 =?us-ascii?Q?bTDo3LkXqTqTUIfEsormlzPTt9qhcrLRCVqz1MnSxSAS1TeZTdnMfBsMw7M/?=
 =?us-ascii?Q?dGC/WVKNevt3bS7d14MAMZNackvEsqEQJojVMXThmN5WlQdaN59EkrcoGZmY?=
 =?us-ascii?Q?hO8xTshobIW3sJmX5H4zM0YA2VBpYrvD43wVyrrWQ69NdgRkh04uok0FD4aJ?=
 =?us-ascii?Q?bxbmiAMeNBgF/2SdeG9h5pYVDrJrxD/mlOuJy7g2bhm5kOFXw+HiSIBMQmMN?=
 =?us-ascii?Q?PgUAwau81IFdjuuM8byiBVSo/13FB9D6fUPVeEpaRXusQ6jp/KKkOGLx6BBf?=
 =?us-ascii?Q?kA/W4tt7ASCM+f4o8qkaB+CZkjJM6znEEf+2Tms0+5xZ6qVBBrmcdBvfkN8I?=
 =?us-ascii?Q?nIGvl+z/22+AOyKW4kS++bwLzrMPI1KmD5oOPE0F1u7Jv9cn4e/j3JY2bMs0?=
 =?us-ascii?Q?fftwFKe7RB/mpjdnnPaf7MTMlVi2cEoaK93dA0/bSgbQ99FC5fFv91Gh+n0X?=
 =?us-ascii?Q?md/o4T+8bOc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?EcVG9LLMZVFwc3XcYEpoGicmHGO1S0vWf6gBeYiyNmM00TnJPgvkM+Gkhacv?=
 =?us-ascii?Q?D3zYAFm+0RI0y6GWQNdVLj2u8dpBAnTFfiWiSFjNaaqvIOqNcCosWKxBEOy2?=
 =?us-ascii?Q?bKLMKL1Cid89lgsHOIVyem2kiBzz5nnKuXpVYlm66LDOUaBGGzKd2/LgNXan?=
 =?us-ascii?Q?tQo2mHRTF9RAUwfaF50wllNmBjd/1S7FknV0sPvYjYX+zzzr1Dta60BAEjZ5?=
 =?us-ascii?Q?5tYt4eDtD4d71v+o+u5j4Uejw1GMYng+xgRFsCrh7VHg45B3bplpJd+BFlpc?=
 =?us-ascii?Q?SDkoy7/se3U4DfixlLsuM1osUXqRknr0631P/9LMDT4hRqAD/up8Yh79AWuG?=
 =?us-ascii?Q?XuNEvJAOIq4MMq293TJ771shVnVq7zTHr65BSePx+yFsgxprXOKIvouzIpNo?=
 =?us-ascii?Q?FSftExiS3UuRHHHUS0EDlIBIfddGaU6Gm2SXhPWFzayHQulMUqpN7ViK/08E?=
 =?us-ascii?Q?HiTC8KIwgYACEW1nGIucda+GXgJBDHtQfyV6uEuYEGvhYGK95fdek9HeTPSw?=
 =?us-ascii?Q?POEhO+z3Egb8S3vsBDf3xkz3hR63fD5QpZ6CyRLAFZSpq0cLq5J2wOHgK29F?=
 =?us-ascii?Q?Zg/4bg67gbdxIyKEw0n0rMnaJdU6gMR1pTGRBKgZhWUpltMA727pip59w20a?=
 =?us-ascii?Q?EquPqDDjY1BAMJMpoc29Ky/6ft+O88w97VeBFmklhYbeoaHGarhEVFeSY5by?=
 =?us-ascii?Q?HOLDoGAvdsJpeLX6isjbTQTLgiQJ0cTK5IqAT+x48sKENdE4QrTF32DvwkXQ?=
 =?us-ascii?Q?7zL8wQra6SxGyfG2cREHVBvN+XQ34h8o0+oOOQYJ28CKXKjm/lsWy0bYEQJT?=
 =?us-ascii?Q?0r9EUewlfQUf+Yc6GitDRrByw6OIC/8bOKTPgENy1Twwo56c2jnl1o4GpaRg?=
 =?us-ascii?Q?YJy5tw2Gs8oFMCmNe0zAK/lynd6KLO+IH6EDt6WyhUgFvvOkCORSoslpfzTx?=
 =?us-ascii?Q?AZZTocCSyZxpzGIFoW2exS54jDhwHb0xpdvQFdCnu2KWnreDULMGycJEL5f0?=
 =?us-ascii?Q?YX0Y+mAA0SDu6s/lL/m3n0Hf2MIKjrDk0GdThwtgCQx0PNDTYl6Ls0rOAy9+?=
 =?us-ascii?Q?TCT1urPgPL8THFHJ//JLgdkbrM9/lQayhAbAts1QSt8VfBKznNMiwosOZE1I?=
 =?us-ascii?Q?ElDLD0nwJt/kK9zdx8NTAnvbvnv0VcLNUtpuzHIlFsGAaqJ2g1va2aAM3vZ8?=
 =?us-ascii?Q?E7IaBzGVyRHVy3FsVqp+0WNZpINaHqsYyK9RBl/AzX/brdP7OoOORSrak7lW?=
 =?us-ascii?Q?axpx1iTyMPXK82Fo/25ZhCrNuMZppc1LtE4LaVhYQE+z/mgdkhF0KUSby+B8?=
 =?us-ascii?Q?U+hxiM9xiNXo2R6FliQrzOjeUq5FLZpYPXvRa0K21megtCNN3jgWczY1iAxg?=
 =?us-ascii?Q?xLzkOHwhYLiqi04Pciyh+ulAhOLUOYOEGHo6QTcRTKhxBWhC6+LYKAup4IH5?=
 =?us-ascii?Q?Tu0m3Lio7/5OKeGWGwmmglFn6ckCEn6v8X+ak1ZXGaWE+T0jRPcRgzn4vwk7?=
 =?us-ascii?Q?RVoNeg+5/fpkEPuF8zAjLPjI1+d9bB0fhIVumSILAEDAdNGHPKGwD30vfigm?=
 =?us-ascii?Q?EG4IIn1RwzmDSmfeQBTUfLwHHucmCMbYU7zjwF8n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45ccb38-0df1-4d2f-5e2f-08ddcea09a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 13:05:33.0297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPCGRvmFRlVfhVjG0HjhxuF6zlJmmY+4niYVEBQbqxGyO49UflbxY2PF9/9rutLTY7h1MqOUm9+zOz9rRKwl1VPAidHa2CaYJM+e51U7CvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 13:05:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17818

Hi Ross,

> Me too!
>=20
> Did you manage to get "viztracer bitbake ..." to actually follow all of t=
he forks
> and children correctly, or were you just wrapping the parse itself with t=
he
> tracing?

Neat! :)=20

I have never gotten the command-line 'viztracer' to work well for bitbake. =
As I'm guessing you also found, it just can't follow what BitBake is doing =
despite all the documented support for concurrency. However, you can sort-o=
f get it to "see everything" by manually wrapping the individual parts with=
 unique file names, then post-processing to combine the results into a sing=
le file.

For example, in bin/bitbake-server, I just wrap the entire file with:

    import os
    from viztracer import VizTracer
    with VizTracer(output_file=3Df"server-{os.getpid()}.json") as tracer:

Then for bin/bitbake-worker:

    with VizTracer(output_file=3Df"worker-{os.getpid()}.json") as tracer:

etc. When bitbake finishes running, merge with:

viztracer --combine *.json

My captures are sometimes multiple GB in size, which the web viewer chokes =
on. For those cases, I use TraceProcessor to handle them: https://perfetto.=
dev/docs/visualization/large-traces

By the way, prior to using this capture method, I tried using their 'generi=
c multi process support': https://viztracer.readthedocs.io/en/latest/concur=
rency.html#generic-multi-process-support. It was not worth the effort, beca=
use there are so many processes/threads in bitbake that it is difficult to =
propagate the init_kwargs through all the layers.=20

Thanks,
Chris

