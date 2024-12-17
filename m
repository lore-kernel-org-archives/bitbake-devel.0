Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED47E7717F
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 14:11:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.73])
 by mx.groups.io with SMTP id smtpd.web10.82288.1734444678528051038
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Dec 2024 06:11:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=GcBNLaoi;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.73, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSHoLTVCsXkaJeizN/IdLAqSYGLOhW1FlGVQxGxulhTcJlFEfSnkKFdVGC76MmGJo1RfPsdsRLOMy+AtMLoSVoz9mPOE7KjhZ5uneGXwyKgLzkut0mYGg5aqKOWg1oJ5BA4Rkig4vlHWlmEUU8cUyotjcX3POB8naFlTf7oIOL9n+hsXXPO4B/Q0ZTsV3kNN6U7uDHuAD5h3VeKbW2UxhlVGGHPnJygu3DTGSdERydD9e2eVVoCb2vsZjgWqGu6aGvEOyFtmMql/Qzk7WqQtWpDhB/vznU77R+I4IPwag3Yi8lzF/9U0zcL1J6+NgwDMRSafsFoRI0FLDc03sObB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGXIVwk2v9N08Gg7v/1giNYeTxOeFxc1Tx8ehMH1XK8=;
 b=B+U9Q8bcydSJnrJEMYwC11UN9LUOhPjarYRPaokcAaHQ8NyFIHzS1puQs16j4t0uS8nsrrv8QNNgwKxxLgeG8APWERPDPOaAP8WlFYSDMyXcglVSewbvTNumbFYJuDhlFDV/dcdjWyY9TT2xbcZE4H0yn10Cq0dY2m9mobP4nICxwP3+F78LZWV00UzisajsTInp47TAotUv11FDrT3ocQkyytHLu0zPnfUqkPrz6vi+ch71A8C1E2P3nNeVrQK7i6uOZJQr4W2CptqfXKBGFl0G4OWb+OOq8JvvvGPwU5jatHqb4TYpyQIgqS4RbnHZiMk1tWaICXYFPSHlaoPz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGXIVwk2v9N08Gg7v/1giNYeTxOeFxc1Tx8ehMH1XK8=;
 b=GcBNLaoi8O3jOLK/FUmPHWslwJCcY4btPi9DjwJDsTfl+Z01vnuqohszICOP1kpjGgiLQ6SIIxxsJYdR1fmvTD13HjkpYd9X3cp+4YvzXA6Bu3HqD98DQCWe9o6BxSN5IwaSe1PzmmgEM8MNFvIuxiIbDezPUtiDvm5WZ+Ksx6ChEB0pm+9mXwp3ZjVtn+8rLR1kKAsbdUgwI4hooEWXXTZZ8pZum5j96mGljggiZv2J1hIlSkqLJMVaPArCaOxFnF1ox63xr3sVQzCJB954J1PxkJMWLTjvJ4/3H9OhBHLYhIUsFjb1XyY5kSIWXrLGwILC0Z4afoNt7oq6oQK8Ig==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 14:11:15 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:11:15 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: Potential compromise on adding type hints?
Thread-Topic: Potential compromise on adding type hints?
Thread-Index: AdtP5KtnnMdrNAiwTgmvqLEZTRMWqgAJYkwAACCIRXA=
Date: Tue, 17 Dec 2024 14:11:15 +0000
Message-ID: 
 <DM8PR12MB543038304FB52F448BB740078B042@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB5430AA0A8523E4086243CEB28B3B2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <df46a810902511e9427023e23663c74f5094f16a.camel@linuxfoundation.org>
In-Reply-To: 
 <df46a810902511e9427023e23663c74f5094f16a.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=cf4eb567-93e7-4c30-b327-66a319cb04dc;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-12-17T14:02:40Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA1PR12MB6235:EE_
x-ms-office365-filtering-correlation-id: 324de878-4704-4c64-89ec-08dd1ea4ab70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?spRQbPPZTiULeU0D6V51Y4PGLyRkHaBz33Pi1WyvcsNGwG238F3HgCwf85SW?=
 =?us-ascii?Q?LEuztEiq05UgpcwiA7/shuUX8WAlgYLyJkk/7vKzLgeAODBnYO5jmwzoPxp8?=
 =?us-ascii?Q?Eo++mUagntCGwl+Y3thb/2zBFf26Gj6peNkmc77IELCo/Y8UNskUikrLv6of?=
 =?us-ascii?Q?OU4NejSRfzW+C2AkqJR8mvE7ngIad0tyKoWvP6SYp496I67vEzG/vdJ9hexw?=
 =?us-ascii?Q?CgXvV5IwMkunQS59vOc/cOjXAj1uDmpSOu6IvfODdwfTEr8CVq+uWSYDj+gc?=
 =?us-ascii?Q?OR4Oyy0GMdLDjPldGo+vtoh7d5PRpxAHdy3A4WGj8Qyge6lGvU6DPI/F+5IP?=
 =?us-ascii?Q?EdHiMRs35zw3vyP9phtJQZGnPgT341cpjSdyZQ+vhTCE41+pknq2eaPHw+98?=
 =?us-ascii?Q?TpWg2WH1IZDg8KmKfzCUMd0KhqbeelxSX7FyJ4CeYRqJaY5L4NdJaEbDACy0?=
 =?us-ascii?Q?vOVAd+O4S5ZwTY5poAxpomkdglzK52BtipDPfSuP+GGJT00VwZZFE1YajJ6l?=
 =?us-ascii?Q?FFv0RO20meI/Qq0kHh5ykniFoJoBEycx3XDziPDPSus/d49MMUHygDuqUiuV?=
 =?us-ascii?Q?lyRUk3wNIgRhIlX5eYELD6maGUg8GeGu9Nlp5Z0wcV5A7UaaQAjEM1fZlN62?=
 =?us-ascii?Q?/uHPzczvMXinpaSpChR6bZqX+wsYzChFdvEmXtjLw6P5O6C/ZLUOvWNuU4Nc?=
 =?us-ascii?Q?In8TNWwfrArZjMF8oySFFI90LmQs7PFzuVpzFz4Bvqm5C12xucuaVqFlrkbx?=
 =?us-ascii?Q?sF1JpPYOlcfc9emhBAaj5beQyjMhXksXmxX7N8y4fbbrgW0sOUvVHZNAQaoF?=
 =?us-ascii?Q?+FbWSFcPernuTLCOyL0t3MxwrsKrpLRWbMYRzAZilzMhm73Z1m57cZ6TmtId?=
 =?us-ascii?Q?E4USULFXtmS2bUw4j/EfKGaj82Ul3JPAkfCzJ42QYzI497S0GmnK0qZl5G3c?=
 =?us-ascii?Q?Y9xMyV6cs9t5TCgBYzXoQqjy30w7B7d9RYF0BIgvRmCN85z9v/VKw1kLAq9c?=
 =?us-ascii?Q?R9hsc/T3EtBCG9Gjgts8HSHoomwuaOiZ1oLYpFx51QdrHkvM5nKtGhkUVDZG?=
 =?us-ascii?Q?9/JNdXxPCiFCgmcsjhZ1uZ1sUkVNIT1MCxR7u5sycQ6SiCcfRfz9N4caU23u?=
 =?us-ascii?Q?TBrS/SEa4e5cAnzMGYNuVuJr2iGrTS865uYSebYSh9zbM/qKkB9BrP7SxMWG?=
 =?us-ascii?Q?eJi2kcBDdfaJN3/2s3wZiMAP0pFYPf0zgcUJ7pJBm+A5q3Lkn5vmIW2quEP1?=
 =?us-ascii?Q?mTjyafc2E0CIUF8YxmkL/6sgsyh4vLD9MybEaZN9lllKXdX5HmdrrXca/v16?=
 =?us-ascii?Q?mn5af4+tcwOPw9uiaOekS3IlGQadueqFon3hWxBCtXJ8J0pVd6fgYNA/kWFe?=
 =?us-ascii?Q?nELnVbRirjbCSb1F0yGierMvoMKuNBYaTMkt5yxWzzXitp6+DBjfaSBBwhOk?=
 =?us-ascii?Q?pmdK/QaREjn1BHvg7rsuTCMd6LQCcsnf?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sTTLbYdOGKE2MeOjkg0/iBVb/keGESVcTQnlByCsvVQr/JqwUykJ13o4Lj8x?=
 =?us-ascii?Q?s/tnCmzp84ccJSbAineVL+JDgy0gnzMzgpNdxUZgKThhCRpCXnfR7UMaxodD?=
 =?us-ascii?Q?EUUZR/wDXNjZCmQyDuAq3FafVDQFoLCCDXRt32IkAMimAzND82dTdNvZNFWN?=
 =?us-ascii?Q?qHWnXSKORPlH0J6aPOln0WAudBMUjJOpIvDQjcXe1aOupljJynTieCQHYbJk?=
 =?us-ascii?Q?o82bIb8LbJG62jGlrO12Z8wLY1hKrDo7nyktDJEgsRKelfsdnlUhwwevTq2O?=
 =?us-ascii?Q?C13XXuyErqnWTw7sSx9J1BzbJrEvsdH2e+Ni60FbBOVhk00/w/RKZQkOa6+8?=
 =?us-ascii?Q?L8kOJw7dSRzNeNPxXSJZpNvudO+4o395cwMtIIp//suCKyEvLrdeOkQS4tsN?=
 =?us-ascii?Q?8ukmkhs60Y5LHMtEk5Q9UXZxIZhH4wuR7MMFc4kuz1IngaAOGB/BlYKCqaZu?=
 =?us-ascii?Q?JirA5Yw4reeFm2waA5j6olSDPReM4O3J8j1DBa844D0m7Gjtm4ArAs/vbnlS?=
 =?us-ascii?Q?NaQlEAf5rINhJSt2VnpJwcS2fSE/s9ru2V60nNxnQydtByXICUYW+RfA8or2?=
 =?us-ascii?Q?tG7dNOAlGNVGsLRX7YN2lup0x5kexd2rDh/GpHpAOVeo7aMwRzk6I6FvJuGh?=
 =?us-ascii?Q?sltP5YbFIUZcj372Dsn7ZSU5NymGumd6XnDFQpX5XeHJOReFYm3ily6Uzn/v?=
 =?us-ascii?Q?tFJxi71OxcLCrTCC54p1rE/JJIr2L9sfjc94gsDxMoBz8DM7HDYsWPq3dfjD?=
 =?us-ascii?Q?ILw8B+ftl0VFc1J0AQLrgnBMO8DG/23HteDMEDgs0ssn2OrfvVcM2CyN4alM?=
 =?us-ascii?Q?FpZbU0aEnadnngCt0YWY46qQS9VpmuT4vgIT5V0bWo7w3Ct7n/1Uz0xyQRvL?=
 =?us-ascii?Q?wFXib63Jx6Pqc5UZTA1ULH16yI1f+oJq/cDFXPPWvKEXk8lqLIbZGGpQEkWF?=
 =?us-ascii?Q?mxpnZkgAw5z/D5PDMlQQQEQzpRCFehk4Fcf/whQ9Tp+t9AvfZKAenmAaAuGE?=
 =?us-ascii?Q?KQEI3wO47S25IHemOSlZ1WtdDWArm1GsnHE3UEIU+Jq+aqbnZIw0LyN5+ISN?=
 =?us-ascii?Q?1lLV/qFAp4k1SYw4Sjv2FyTHBWvwvUbx2bfuw1Gke/oedZrBwVXRQOrH+fjw?=
 =?us-ascii?Q?plDiitQ9xrJRg56vuaYQUvaF4OdMCDrj6SFRb/H6zWTJj2kMIkaHgzmRfSv8?=
 =?us-ascii?Q?qCuJwlCeyk9ElWwW1kCZO+M8vR1UQlgIdaFSYUDm2tG+ijx2fYWiS5AYaMce?=
 =?us-ascii?Q?1f6fkhYAh6kP6RmjC1PdcOBrYZ5gZ6SX1jTFnhwjMm3x0tn6l/qwJ/9ud1bA?=
 =?us-ascii?Q?pcZkDKw/Os7uMxOqHD6za2KWdBSTMTtB6T4uZ/5eMUmBAagORKybcvPSlAhx?=
 =?us-ascii?Q?UYNUg/YkyYOpiQJ2Qbe6KtPVeS2caIK8osG6MxoCM4KQjomqUidrT455TOY0?=
 =?us-ascii?Q?seAMFh5pcaboKBaNkp10MhBfE1f1csqBvHxh2S95Brtc1yJ4KFRgrBNl8ftH?=
 =?us-ascii?Q?Qfq10/MWhRDw0tSWzsCOMqPKlmoowaD+cV93VylH8FyWPEKRSDnnDy1DWSk9?=
 =?us-ascii?Q?J4jRejkF8tUjd0liXZXOYTS8vvoye6QvYUHYRO2N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324de878-4704-4c64-89ec-08dd1ea4ab70
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 14:11:15.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsVRJQIIdZf0k5LtYHlYHFxa62l+/ssQgwXQP447phgH6DTOdTrq8rSsEZ69vtGOBjlDC0iVboi5ptAZmx2BGPiSWzWHrNg6KNPcbjyFx5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Dec 2024 14:11:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16915

Hi Richard,

> > What do you think?
>=20
> I suspect the practicalities of this will become problematic. It will sta=
rt out well,
> then something will get added and not covered and someone will ask the
> original author why they didn't update the stubs.
> Authors will be pressured to update both files and I'll be asked to defen=
d why
> they're separate and not maintained together.

I hadn't thought about that, but I think you're absolutely right.

> Can you see a way to maintain the stub files that is going to avoid those=
 kind of
> scenarios?

Unfortunately not :(.

>=20
> I did look again at the typing and I'm afraid I really really hate the sy=
ntax :(.

It's definitely jarring, but you do get used to it after a while. But I wil=
l stop pushing for the type hinting, as promised.=20

(Expect another email soon regarding some different proposed code moderniza=
tion efforts.)

Thanks,
Chris

