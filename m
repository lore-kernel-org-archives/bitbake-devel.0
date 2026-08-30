Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FFAC61DD9
	for <webhook@archiver.kernel.org>; Sun, 30 Aug 2026 13:43:02 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8709.1788097375716452302
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 30 Aug 2026 06:42:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=lfAyeS64;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.53.44, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAK3TiMTcgi/n7Ra++npypgHH+ni4/U6SKAMwYRJSrGKoOEuZaXWG7im8QTd2hOIQrDVHHa6vtVwT+mmV/svcGI8wHXo1jv9FCjbvQKlIP5c512m8KxNFpXUfv1b21fIubSXKfxBDqhO33OsbePK5rL05qVx3vRRzTCAlVIjx8jga+FFq0epwU3pLVBxfmmQ8OSz4XnluEOZRTfTV0FkltKLysZMPQMBEDm8pNzTwutD1Jry44Vj4ECAtKP7mrY0AlXuqVeBwsqjt60JLCbEVWbJLHEO3Yzo2Z3IlxPsQE4T+tFqqa+1bcenSQSfCjL30fAO7+nBtGRdxi54MP96Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NtHc6cVJ5u4/CTCGkDYbOIsOIANmIEQHLJtTIWNaQA=;
 b=Y7jaOk0TBmh/uPv91ZX3BAgOZqcayw6/TWv5+qZZca9rwGu4I1U2pDQ0lzyHpebapECwHJTyvuKCGCSJTYGVrZDjKRepM5Sm1u/R2BGKOT4K7eeJsddXNq/lZGkFnQqS3UWguR7NK7IB8sMO0r37KmUY9jeORB7fjsyDywL9wTLpG8lxQnEUxcxAt/dXRcJ++Rj6CjEM2WcnXr9nWkCQcwIUKOK37fRYLKHeKToRTODnqCbN22eurTLn7VCwikxv61UyOK6OdnrIyiH3js3CH5Xe+rPZH4Mw9hQz8obxamdm4SQMXIMwzGeLyFPLFxq4rP5kq0J7wzTrcaMjujYJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NtHc6cVJ5u4/CTCGkDYbOIsOIANmIEQHLJtTIWNaQA=;
 b=lfAyeS64Fd6jjLzxN3PDSPMn0D5RDsZottNs+LGNnpnpTcTteHwu1G2o+lI05U0KQE+lU1CzR4SaggCCGb5Tk0dhgwNsKBUoRka8Q3UeWXzQLpB44j8vNed8k760plMJWncVtGcmmHwzo8OOnnXH+hUm7ujWa3CS0I49KOt8xU6DuRPYd/Uu7RVezNug1XCxXKD0daYW48ZB/jRGE32zH2EizKSpKAsl20XpSj7+DLVR66a/QqafAmYcxc4Y6Zn6SQEHbe4BBD5Jmwjjwuvs9rLXVMRZuP0doYjyyDkiLxgGvWQlyMB27DcAbt7ckQeV3dnoN1he5b7uaUuLPWMEIw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Sun, 30 Aug 2026 13:42:51 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 13:42:51 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Mathieu Dubois-Briand
	<mathieu.dubois-briand@bootlin.com>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [docs] [PATCH v2 1/4] lib: rename fetch2 as fetch; invert compat
 shim to make bb.fetch2 = bb.fetch
Thread-Topic: [docs] [PATCH v2 1/4] lib: rename fetch2 as fetch; invert compat
 shim to make bb.fetch2 = bb.fetch
Thread-Index: AQHdNwoK38+J/mz3P06K3mDmr6DsAra0y6yAgABntVCAAWh1EA==
Date: Sun, 30 Aug 2026 13:42:50 +0000
Message-ID: 
 <DM8PR12MB5430F04981C8E621C0C666D68BAA2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260828162612.753815-1-chris.laplante@agilent.com>
 <81f397e0bfb6373b29d8a6205ae926946f8c12e0.camel@linuxfoundation.org>
 <DM8PR12MB5430BA865CCED3DCCC43896D8BAB2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB5430BA865CCED3DCCC43896D8BAB2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=b8900b1b-8362-4502-b363-ff34de3a9af7;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-29T16:09:11Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SA0PR12MB4413:EE_
x-ms-office365-filtering-correlation-id: 03ed90d8-cdf3-4279-67ea-08df069c95f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 hiAf86SzH/H2tuNi2PQOT3oS5iwvb9C/GeVb1wBwfBJXKM7s75cMuDmTsWo6Ob1Jz4hV6frYSeHqDD1k7pScbCn4K8ZgvEDrecWgQvpv0RX8u0yRkZt4RPcpQzh9dAM6IsjlHQZ74gNVRMYJF/RvuRg3yRarz5Z0hEgiz6xFzj2y7Y1ddKQr6ixAhN3xTQBKBjlYF9G+/RNpR1KdcxwkfI/ohH/dMc5hsQSL1Yb4O3XY3WSg8C+49YHkz1O6cRrC/VpePlElLtXC9cIngskMC0rnHFe/fIJ0xTLXqx6/WiBR9OVpNQHPS04uGS7i4MdjtXNZYBJ53Xuh1A5TPNnTkQ4PXqDoCqvYCiMzsYhO05deKbhFQUkrP4ijz71rAL12jAcYWymWj8VpShJDY2GAtUB2YhLPA9Awn9izdq51uxT2n2O3qT/cpTXtjfIMwZS2IpC3R7oYhyug+N/8/eAuMff9DjhjkdBYfKbgzRdQeAVO9ISbMDXSjN7rWwaNqxhLstbMzoCTO2x17huxCWDxEtGMXEcEmSB8Wjolf183FjTaEVqgZBtaDqcjtTiS0UoaWg5PNKB3xLTaTt2y93YtXGlHNOVwSBW90jrqrorpIgVHf1bhlL+U5vhoIQ7QmerTekQ/t31hccOgT8eUmIAQy7OfmTyJBE8kIMHjei4mbtQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?58Q5EIrm86YotKEbinjWay36TpSPmci3h9nHTWZnzLqZ1GrS+Lg3x7OzfAvy?=
 =?us-ascii?Q?amU5DMMuHGWuv4RDGh6wZiRHpbnyzw3vZYU+Im5DEoCg0gZfCPxWOcMH4/80?=
 =?us-ascii?Q?PLMHoHFgLm3qQDKV4fMr5NssXgebuXH/LuchDrAkK3tINSoNekLSXlUVacPE?=
 =?us-ascii?Q?Q0c7kjCi3eKxpFGF1FbiCvL9gBYJgMc6IN9Z9a88ZmNtGhbmyeWqUlc07C/k?=
 =?us-ascii?Q?kKk7GN8Pm813PNbv/45sB84RXxwoN0crFNCgMJCTbs8X2LlS1aNRCoJRwtK7?=
 =?us-ascii?Q?fmfiPUDd3t54hterTC+04zcNK/tiq2y0ZBPfTwj0Ofsj1JJW+UEgqDkIeIV1?=
 =?us-ascii?Q?9JVjz6xt6JoKp0URODtj8RFfTsUdyTmpOQsq2t5RV5hcM9arfAoXBSaeCvmu?=
 =?us-ascii?Q?jEHjhvLTwsqA+x3Iyi+OpvC9/5/Kiqw7MSBckg5ovWetGsV02tRemD4wHGvw?=
 =?us-ascii?Q?Z1k5X3/3odr2aL5viN/IwbPRGh/ztpv+kb43g71TzapMXGM92/RU0V5c2EM5?=
 =?us-ascii?Q?vfo+/LsRn4arxjmkAzNZa/vd6FbaCXzC9Jdm/FYFL6u+cIt/GPewoy9V+OC3?=
 =?us-ascii?Q?efRl/WUkoGp9zldVe5Jba/noGKK8kY692iMuh+4NAwG4Th1XrWSupnlszN5u?=
 =?us-ascii?Q?oiZ4mzI/1sxLD5Os1alYD8aS7G7pb/AUyul3y2XD//p+cgC3qv+dDewVviVi?=
 =?us-ascii?Q?cIzJJSLa4cLoTA8BE6ddHnmEePEdvnbOAzCiAH7UF1c6F0jaU3lJZslvTCvg?=
 =?us-ascii?Q?Cylt9c0fSjG0JQq7pa8Mq7WqRDbRTinLMAlGHmZVq9MvtyrZf528N2gTilDC?=
 =?us-ascii?Q?cwQhiv7YsbMdiZpBSaiG0sxMJf6/CQMQXJ5T/pW04kJ8EshgKrWryMc3LOBe?=
 =?us-ascii?Q?cKPfwhhHoWnwYK43KFi3vg7KKZQjLqGv7n0T4jUM5borUtv6k83zvlZ32LJL?=
 =?us-ascii?Q?08ZT+gbY4aow9kC68RPBMxYJgMjzUNC6GX4M/Vf5BmamjDB9zrbOrLs8JfyM?=
 =?us-ascii?Q?10cwJ4YxNjSc/cFS6H6LZx4uPDnOrQwe+wmHM9Nbsb0LmMcasov/d8p9ZXJC?=
 =?us-ascii?Q?nAx2Mg999yHvw5k2Hroxm2CvvH1O6w8tw8fFVpZNeTH+WTToGJSH+PzMyDih?=
 =?us-ascii?Q?oughDTDxP15O4bzjkSlcWtUcQBBcLXQnjt4skmzKh4Zkz1EWyYui4WmGo3MO?=
 =?us-ascii?Q?FIowOdf9wld0iMW3P+Mg6/vFozGZ+1En4umtbxCPUcUhmvpZR7A6O5IneulK?=
 =?us-ascii?Q?pM9wsmAWhxIfs9bVHkZlHqDDjLDwJmHjZvFJso8Qn5oLBcDrSkssioWx+2qK?=
 =?us-ascii?Q?4kEu5S8OMaZPMsY4cJDa3HHg9sqj2s2Ulwy91e5JGiAB0eu/PZhfCsZEyiUA?=
 =?us-ascii?Q?JYFO9oeTVJJjxjvI9bm6P6Hrrrih4KxcoKMo5oLOhLST6CMyg8eJPXhP0+Nm?=
 =?us-ascii?Q?Nf2KWm+lWxgzFgsvew6ZpVcghpJxDs1tcgufuKi/0OoT3t+A3QZ/Ed3h6aQ0?=
 =?us-ascii?Q?bhqNusHOdShCbDRvEKwhlv235F7dqFQW4ppe28jr+rM32xV+Sbw90dyTAeDB?=
 =?us-ascii?Q?/hXqPbH3jk4LWILVMLCFM5pKNqwHFlDyRw203gQsme7/dPnt9H2qyYR2fj+3?=
 =?us-ascii?Q?B8EeW9yxihVsU4VWrJyMO+nZbjvIbywJIUygh1mnogj79C4QsAPH8x+BtYpM?=
 =?us-ascii?Q?ny6peE8aO31zG63u4Z5F7+6m4paXlVaCfKGVKHCymaFnqGji1DjzMFQ1hZgC?=
 =?us-ascii?Q?YY+Q2ROKSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ed90d8-cdf3-4279-67ea-08df069c95f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2026 13:42:50.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKWJuksx2ckOga9SgCcqbqiRiEkWST85I6arNKLaSg+OJBkpYgQsH7ToHG1/64t7OYsWywhnHuOZ0a4w3+Z0A0UY2K3XJoKE8M0i/y3NC3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 30 Aug 2026 13:43:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20128

Hi Richard,

> > I've not dug into why...
>=20
> Looks like it's failing in gitunpackoffline:
>=20
> stdio: ERROR: gitunpackoffline-fail-1.0-r0 do_fetch: Bitbake Fetcher Erro=
r:
> FetchError("Recipe uses a floating tag/branch '2.10' for repo
> 'git.yoctoproject.org/matchbox-panel-2' without a fixed SRCREV yet doesn'=
t call
> bb.fetch.get_srcrev() (use SRCPV in PV for OE).", None)
>=20
> (https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4744/=
steps
> /17/logs/errors)
>=20
> I'll try to reproduce locally.

The test failed because it is re searching for this pattern: "Recipe uses a=
 floating tag/branch .* for repo .* without a fixed SRCREV yet doesn't call=
 bb.fetch2.get_srcrev()"

But the rename changed it to be "bb.fetch.get_srcrev()".=20

I'll submit a patch to openembedded-core that tweaks the regex to match eit=
her fetch2 or fetch in the name.=20

Thanks,
Chris

