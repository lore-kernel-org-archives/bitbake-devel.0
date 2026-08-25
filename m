Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86942C61DBD
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:22:06 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30354.1787685719953025827
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 12:22:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=pBtgkgA4;
 spf=pass (domain: axis.com, ip: 40.107.162.34, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTuuxaNasGiCeoaw2ArSfJviVpCTMxxNKr8cJblRFVL46sKMImUbY82PepBethy3wWNCfQOyIVYf9x9GbIj8wUhrvcRlMGjEW4RHsERiN8MeXfSMrefFAn435GO9ZZ9KzsDhKtZd8JtQJC0+t8bdoq4HDgeaw6GVJZFjmz6hBtcD9XrIWYrz5jH+9KiNM0hEXSsKsN+Y0OFITeFQHB/0XrhN556K7eurXb9GW6c0T9HbFS55y9EmsuUNAYdtFMHXmnmYkpkPw2TACxTCESnqRLFNyVGrIOvjqXEFmKhpeWmvDlvjEAIb1X5WHvr6ag2DcbatZKFI0j9i4kZGV484Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV3JyJNJDClKrAK2WgIjBrrr4XjdIq/73su0Jrvh3ow=;
 b=L53jviWpvlo8eTbW0eYCXMcLNohqm9wbCXq5DDFFDDihqgd6LTxGvdlax8VNk11wyiE62f+OEb+2luKCTFpKYIiZeYFzR2C7OhnCX4B29A4LLMVWWd19Lem7F60iOrciGKbY0qiqDDu/owaWRux3qiq65bdNmiMYhkMAnAa0OQzOuZgPn4GcDeZZdErZ4kYCyTjb5W6aiB6suHMNp0c/Yeaz0XEeRQ0a9RbPV0CgRb5SPPi3uthu4URBz/095nJmT0+q1sqB+uA5xvqMFJ2+xlGYtA74Vt+clPGr+I7oDiWwwELtGGIPBO0AfNyS/2NYfbe859sxJ1hkzw0KnRKUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV3JyJNJDClKrAK2WgIjBrrr4XjdIq/73su0Jrvh3ow=;
 b=pBtgkgA42Hfpu09vJMV3d30hr2nbntDezEhdhvjKcIXi8cPatsriGvonGGOmMpvcMuwM1IVn7ngsre/58n1MhsM+LTnzvBTMon4T/U7tlcigvn9X+HKOn/TES+HcTNMI0PtY5gICfhMz/rCc/jJm4RtxNL5n/xoVN4dsR0+gi8s=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PAXPR02MB7838.eurprd02.prod.outlook.com (2603:10a6:102:28a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 19:21:56 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%4]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 19:21:55 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
 cleanup fallout
Thread-Topic: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
 cleanup fallout
Thread-Index: AQHdMY+BJ8eJHMnwC0K06s/Mz4icqravFuHAgAAMuACAAAbPMA==
Date: Tue, 25 Aug 2026 19:21:55 +0000
Message-ID: 
 <DB5PR02MB102130F2BF988F3933E6A98BFEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
 <20260821170624.436725-4-chris.laplante@agilent.com>
 <DB5PR02MB102134543E3418DA8C1C06E4FEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <DM8PR12MB5430D033816F4121D4BB00E38BAF2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB5430D033816F4121D4BB00E38BAF2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=22348d46-684e-4df6-84e7-c3399a48c65f;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-25T18:54:55Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PAXPR02MB7838:EE_
x-ms-office365-filtering-correlation-id: e98d947a-a400-40dc-4ce2-08df02de2062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|6133799003|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 z7+6qrbG3mZd1y4dd22bDy1AjKt0TLJ2IdGovtfKGzNlJ4//okL0VMSka//V5goZV+vx/KEztxsFg0BlkTVNVM7xe+HNNUYfMAOW947uf5SIpnh5rtTxj76/rC2qkqQvRKkCHQaGfiERQu3ptyUtGJVtiS8Ca/UXlUWxhDewDVk7l3KbCOSX6+5g3SDBsyMgVuvK86XA70DnV1GaPsKyH4fzZca04scH+5MRWhlw3um6sjMY2mMvhw3WBXXdLct/rATcfrS7YF66sfwTCri7WyhdAkLpuKatyzh0qNb2eQQGnJjTTw+FrvcWZryDItw8IznY2zqnoBvM5HJ6vUflnNGgfdTgiPxnPR6pFGupmAGdYQCpBWfoiJkpY8VdzoTKm4CLnrri+OS3kFy9pFnPwHBiik9UNdB/AzNexo0KpAYxRPvbyIHMuaRNKh944GN1HlncUIPRUHIziiOs6kTA3odJE/R5hDAcsvinqwBZpwd9Tr4K5sqZCyZAAnsVM2kud61N8cfyzd4l12uN5qqBpNr9pHT9tBGiRZl+s2MFQsrfoG6dFEiemb4kha26MVvOulDqVRjylskfg9rYOzEElsvUOkC3GqyA7l2kGe4T9gmKaTFTEe/Wfyu+Utlz1aos8ykbsI1WZnYkBcgyaDPeU/WCjWIv7pTG1Lf5ymlHDl+wOSrkPfqRWZBuYBSMzJDE/bzrJLLNSn/Z3sIjUWpQtMQ9BOXZnqI1EosQXVUrLeo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?FD27drcl0z+BeajfZ91aaOaEw1jFaE8C3dJeZfvwZmGPhFkjL8T26rJP9EwG?=
 =?us-ascii?Q?B6I3h24vJqQPtoNGHw31CnAlEFHKEg37K0lAkoY7dOSsvlJsDPqMECzqTEUH?=
 =?us-ascii?Q?Re3bT9AwLKMa1aRuUq134bv/qxYrv2Wbzrbwt3ClhK0VhOKLmbtHYLrkxZTL?=
 =?us-ascii?Q?Y9CxTRnj8jNsnJQtpgfa7whLFc32o/tJi6QLEPjhSUsKHEeReNSZ0mxzqO2n?=
 =?us-ascii?Q?g0NBxzgpGX/W2dOffCR8O8QzHT//0K9tQ3xSYNDEL2a2I9UGTj+p8mh9B6Cs?=
 =?us-ascii?Q?SEUqyApfhtoVCRbA9EOfpIF3NtoNmBgUdUXVesZiUygIPpI1avhHINFTIvoq?=
 =?us-ascii?Q?OkKCAJJEE+njnWBhdiE10mLsy15FiClGGR6XblHcT79e2eNbHg9Vk31U//9g?=
 =?us-ascii?Q?BnIfMeN7ShOPJMFpfS6o1pJXBzchmaKlsesrLUOIE1PN8Es06tpQj7SbzJ2O?=
 =?us-ascii?Q?gPpaH5KMTqfDxo9eC4yedgPlB0jegySOZXl+S1gyJldhn1awY1jZD7lqcknD?=
 =?us-ascii?Q?oFzBikrU+SQB39gv6u3UoTwXeIvrc7+qq9g+l849CM9/5g/gtEAQKq5CHKDo?=
 =?us-ascii?Q?GMesWj/sDPZo1NCTmFQh6FmruJq0Gp3zHUSJw0obetHOZ0ks8ZTK8xVx6UKY?=
 =?us-ascii?Q?egevG+gYgfoGD0TMs9mKjtquRi9cT4J7AjiLj4cFgeuRRIidkyK+k1ekDL7s?=
 =?us-ascii?Q?5u343i6qfmDcjKLqmfmR4RJrbIVgKEfE+Tvol7hX9Wja2HcABSgt40BWkUuU?=
 =?us-ascii?Q?TFrPOUInr7+m8uJ9vtAtsVum/aCR4BPkY/oicr3KT3zBDrVvoTaCyk80vozC?=
 =?us-ascii?Q?Rb1D4ctfdz5K3iFBiRJ4+WNZ5PGMvL2NXWwr1aVhHI7ai47+1gGIvbMMY5UT?=
 =?us-ascii?Q?xYkiyMwZoOqnvkwQnmkLddzSTgi79KmLm8An7y8OuGDWLt5zEElkaj4ajJ5i?=
 =?us-ascii?Q?jfIv18r4nKucbbt61cgvIzIYeh5oZN/y9k6Zh8+W9TiBl9CwwF9Ax8Gvldc0?=
 =?us-ascii?Q?rdVL+356hpsb8dyiJOeeNdty9K7hsa4WIi63y1Cwfrq3QaFFDxztx5tdaTHS?=
 =?us-ascii?Q?LC83FbU+DfQK3Wv00Qb9VxWlUgx/Z+VKywKNgap6yf6nXwSNYi5Oow1igcPv?=
 =?us-ascii?Q?FBdE1YJmqlRSSKYA0OcQgx4bcdzprVaEHUe2KR/zTmigFTaFaIGGiRRvvEVx?=
 =?us-ascii?Q?S5RLXufr5GFUZZI612U89ZDDOovZVb6WI9rke8JxuiwjQ5z1gNF/OKLgxpJY?=
 =?us-ascii?Q?fz+0BBtA7svYMuBrph3yV2e3KA3FbZ13WJWmeO4ov1nZ94Njdzh30TJOsXtZ?=
 =?us-ascii?Q?Yb4kJsAKiMmMcLCqxaznklWpH/OWfVIpygFsYVQPA/Q2YGcZEPLRgGEef0wB?=
 =?us-ascii?Q?+iBcihGz0m0x4g3h0u19BsoxiHp2P+bYkzJoLjXYqyRd/LsymMyki23zoF8h?=
 =?us-ascii?Q?eccZRldGttWQWXYhfNoFaLLCDMSe77hGUuYm4CqpJBlO/HGLtUwFRGk8i/n2?=
 =?us-ascii?Q?EqTJeF9/sLXS3DrlZt7xv8cN7tDY5velMFDCokGu1UfdWwu/p1evVdcsoG2Z?=
 =?us-ascii?Q?kc7g7D4rXVOxPWoIannE8AvRuRXoXKxofE/W3VFjCAc0/1TpDddDkFfM6J1W?=
 =?us-ascii?Q?Cl5Wvpxq9jU7046FDab400BcyXAcrlZJMh0WP0L9fApzomDatX+jH835h+C/?=
 =?us-ascii?Q?K04EmH3fmDWBJrbA1ijhPW/mH0Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98d947a-a400-40dc-4ce2-08df02de2062
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 19:21:55.8758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hhal0bE7ew6zjfcNvxHDlb+q+6GdE51IKtFXD8fWvM6A9kYJ62cFDdgitkbmIda4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7838
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 19:22:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20041

> -----Original Message-----
> From: chris.laplante@agilent.com <chris.laplante@agilent.com>
> Sent: den 25 augusti 2026 20:56
> To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-devel@lists=
.openembedded.org
> Subject: RE: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module=
; cleanup fallout
>=20
> > > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py index
> > > c5fcd71be..eedfd5406 100644
> > > --- a/lib/bb/cookerdata.py
> > > +++ b/lib/bb/cookerdata.py
> > > @@ -16,9 +16,16 @@ import re
> > >  import sys
> > >  import hashlib
> > >  from functools import wraps
> > > -import bb
> > > -from bb import data
> > > +
> > > +import bb.cache
> > > +import bb.codeparser
> > > +import bb.data
> > > +import bb.data
> >
> > Double import of bb.data.
>=20
> Good catch, thanks. Though I think we are not going with this patchset.
>=20
> Thanks,
> Chris

Well, I assumed (most of) this would be used even if bb.fetch2 is=20
renamed to bb.fetch instead.

//Peter


