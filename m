Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A35CC61DD3
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 14:37:44 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (SN4PR0501CU005.outbound.protection.outlook.com [40.93.194.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2208.1787927854233328941
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 07:37:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=KSRsZSgT;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.194.14, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMsrBDKOaSxgRvAu6Sv6/2GLfjZbbI6SvQT4y5w0r8W4yJ211mCCScu1kT+4ncdTam46BU8LEP5CGqrs8gM9S45K0zTtpofWo7JDgp/xJstTdkGt5+VymI5YhfwESN2297jo0qhcip+Dawb8p4YXiuHdfuX6HZIJnQpyVva5BUp87s1Ml4Pf81Xc3CsY0AzAl4gSCqL9yWKJOZvrItJ1u7GIHYzx+nnirksEiqxHq8CxWUEXo9ozZIbJaPaQZ/2UXbw/gAy8mEa4Lp1PXXisnTiXb4E6h29JqoazN3DEffbAJLZgF8DYXGPJroqFPTQtQ+n1YI4jUlhVE07M7YoFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eO1ZBHRQJd50k6ZNuu2F7DRcms858hP37n/HpQFJ2Q=;
 b=nDF4VrC3tt5vwjYUb1C9of3zNSH5RAQZtW4n8ZX8LzQxT1RZmpbF4xywoZov6b9U5de8Qk23soBowi8aNG5JYGd/KaLhq0b3Eqrl/pTNEgct7uG4rEWsl10y97e03Pi6WdYzqIB/q4cHWZKqEfIOMwiD8RQ4kb6R3hpCZrJnZs1/G+AAm/tyDkFPQNfaQwelytSzhadbDdX3tzciblGWLzZ08kM2rBH+jYVqOYGwj9ilE6a1Jch6j9TomaRSygz80bs3DDmSOMGZkcNlmukzkDwLc2JTQyKqP2I7OZq2wbkFDTmbG4O9mUaFVGmu+9RjgvMHgxwjusZqw0F0BqqVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eO1ZBHRQJd50k6ZNuu2F7DRcms858hP37n/HpQFJ2Q=;
 b=KSRsZSgTsyjDJOQByOL1muGclFfJ+zXv1XkIDEP4EJUhWTINx5JGSLW2OGQUWTGwGWGHLgl3B9PCOx4yBy+kieu0UR+R96OvzhhuxCHNHXUtY1yAgM/+a9P7r7gGY5dhBnU/17Lr/QWS4rmIJqcVTtsc2G2F/DsDb4trrzTHEBYWHtZQt+vBDxHmGimIn/4Hd7yBa7fyC+vTImCeQ1izQuAQpgFebt4EzT6QCi69O7eMdAKAdBxdqa/FF0sh8Jk/q5F9A90fDMPsXDby2GMXxXUl3v6RU9M696i+zL37nNBdNwIe2+5rSIZKq1/niCy34PSaT+yoOaX6R8TMAPfByA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Fri, 28 Aug 2026 14:37:24 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:37:24 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [bitbake-devel] [docs] [PATCH 1/4] lib: rename fetch2 as fetch;
 invert compat shim to make bb.fetch2 = bb.fetch
Thread-Topic: [bitbake-devel] [docs] [PATCH 1/4] lib: rename fetch2 as fetch;
 invert compat shim to make bb.fetch2 = bb.fetch
Thread-Index: AQHdNjCzG0PhMvCD4UuJ/onN4EB8c7ay9jmAgABnJYCAACt20A==
Date: Fri, 28 Aug 2026 14:37:23 +0000
Message-ID: 
 <DM8PR12MB5430838E898C61E85CBF14818BAC2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260827142958.547182-1-chris.laplante@agilent.com>
 <DL0CCF115T08.227YUHOXXHLP3@bootlin.com>
 <AS8PR02MB10201CF48B8F8DD1675237AD3EFAC2@AS8PR02MB10201.eurprd02.prod.outlook.com>
In-Reply-To: 
 <AS8PR02MB10201CF48B8F8DD1675237AD3EFAC2@AS8PR02MB10201.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=8530a8f5-d2a2-4334-a00c-ce3a38963b2d;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-28T14:36:26Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|MW4PR12MB7336:EE_
x-ms-office365-filtering-correlation-id: 787caab0-a4b5-4f26-e685-08df0511dff3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|4133799003;
x-microsoft-antispam-message-info: 
 tA6dCjMvxew5R+Ph4/9d9+jzZE6oPVg5EMi4S1LhTjrltXFZENMDaqMA5e8BLcpNwZqzgpfZHQk98D6TJjFG3cTGcn2Ckr4D/uy2zIgT9WzUwY/5jwW1NrG7aIFea8RzvZ429Dh+7yea1Dc8GjHVNsA5eO3sUKBzna7PxOJyKvWnAgLukifVvbT0U5BLxXcH6qb1SEDLWAHM5zt31APxKE0o8Kfc4lfNvGZ+0CJj80KxkePVseSCqH0brxq2ZRh9/rX0vpH9WTqcYVJF8oEYHfGYvHqctzLVSn4FBBpImzC5QNyYr9mTFSfxLnP+kETcIoEZXjTe0iw+138X7oDSnAITFKLqz8SCt2xdgvWgal/oCQ22a9d/C9mOR2Z5sp4cIvgHGzJbuWpurs6OiYEV5bE+0x/ACmsa1IEdp16FtdErJphdxp1xfSMMHXyxvDxnWkcijGJyBufmKwfgauhIyv038V9Oolh3Ce4zKB7DBm79KOJvpRmHpCXc4NCP6Wb+JHH9B0MosdpPaONxWF0lO98lDK4FT7YzweEJ2fcfAdi8njIhQRHJ5roIY/FkaH4SPlvsU5nD97ramv7CYH0GA5LVfG+VZmLdz/90AzSDWJljT5w9hYf+QI6bSOkc0yNKJ2bU/UhW9fnBUGba4bG4e0/BCjhcsl1gW6eSVyLkY5w+F8DvGYMOylZg+iCCyve65om5WrotwfV2tWxyC7S09Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kKWlYY23odNE3F7Jjpe1ET9K94VQwylyylMUGYfRmDlp6l/jAryf5r54RnZj?=
 =?us-ascii?Q?4rUP3VAsmAMO5odVXpL+ZmXugBj3ruuM1Jdq7Y7bYrwNoorpta1pAkf0k4i4?=
 =?us-ascii?Q?f1mJQRzEDK5tN/NDM8A69rg0eX76dBZQyQiz+q2hznl2/8oAHTguHKX2ZaRw?=
 =?us-ascii?Q?ip7uQlKzpkLZ6P9IIQz7B27vrjk/TcV+V/XS1TGtkNXdPIVo5MVLp70s5lXy?=
 =?us-ascii?Q?TH+psTG+NZ4BqlhSTOEywtFjQARjjJwVU4cVRS6s11MCbj4wS9ZZbDSUYPtj?=
 =?us-ascii?Q?nhP4UhxhUWRgGzu0glASOiVALKIu93Xww2F8WFELttlLwPAasiKOz+B7aa87?=
 =?us-ascii?Q?uLZpetaL/LWIWZaFVz1u8SMPkl7sgt6sQtNQXvT/MfmdAie2XjjvxDHB4tMg?=
 =?us-ascii?Q?3fQ0zZ9bkjEZ6cAexpMzFo2yExZDH+0F/xeUwfrKR7mtzE9zUUhFfaL42Zsc?=
 =?us-ascii?Q?ruRZy5PF6RPdwO0ino2RQUSrcawzLDD2lg6wzZ7wR5HtnldPYtzs656HIRMP?=
 =?us-ascii?Q?tFDm4QRUM/efrNbOQU5cTnrHyHgfZLUdlt7VCpJV4brbnwxP+WbmPVGiYCXR?=
 =?us-ascii?Q?81M9gxmSmoXF1aCxyrueNqRlHEUmikqHEA/vxI7KM01sPkKE2S0RUOWd/s8q?=
 =?us-ascii?Q?7Y7aXEUip/g5mgV8KqjqIRKKI0Nfix495yYvaJEkYYcToV/XMjj0dt43eVJP?=
 =?us-ascii?Q?sSgMqPTH3BWk5Yskkanq+Wu11OlfKV27n69xhlyLwqpf76p6LuR1QMZTzEhd?=
 =?us-ascii?Q?7zUe+QMK82FfHmJJ66X620Y48+gJbLuZAZ1VCMZ9dcj6TzACnmzvkiINRzhc?=
 =?us-ascii?Q?Etcy7Q3VVpMOlCHKIKBezPL8H6Icbtguz7wKxWdWjWdzXRcauiqXGqR8MFnQ?=
 =?us-ascii?Q?CNR8kA4zDLx1t/m+AMrBsBrWjzeImCgGCjkaQmEtt5ymKPT/CvD0TlSqaX4o?=
 =?us-ascii?Q?YjGW6ZBTg6vyl/FQm1nLYMepWcBS5F7ypYsW2H+R38BdOYUrWnVHalbm+IMr?=
 =?us-ascii?Q?mfYcMeXQlljtunjJIUhOWlyYvZcLZvWtFGnYouGjTN1fFVsC27/FUwDh/FyU?=
 =?us-ascii?Q?AumF7Y2iS6nLtcGMXM82BfQEoH3sJA52W4S8ZosgmM9fFAgyj5y2Ne5EFyJN?=
 =?us-ascii?Q?YAFYwEq3vUS946isQHeyORzFyYdQ+mjQAP8+pPoQvJieYUXGfYrjIQJDZScv?=
 =?us-ascii?Q?oZ+gWycAK5xRDUUyOOrstDutaxVA5s+NqBRd8a0S5ZBQS8A5ry7XbYSKWUkg?=
 =?us-ascii?Q?4HKqYtG1JKb7x6NpuRnFnPGD8PEVGkpUeV3UctlZlFMOXeM5AMa1Q3NBb3KU?=
 =?us-ascii?Q?6PCVOKzco8QT1FM6/cjzFGDLqkxZkrnN0pFT4lfvkJcIpTYtPDe5uG4H+kPW?=
 =?us-ascii?Q?p9pMxI8wmBOvYvzk46ECUMcsOIUE0bIPveF9vf0yoLOjbMYsNbyE5SjplsZE?=
 =?us-ascii?Q?M2dUh9Rk8rCy+JRXjRQk74oO9u2+6LG7xDtpiX3OGcpSAl0btGRN+oqRYD9x?=
 =?us-ascii?Q?8UiFTK4L6zwhOeDarNF5NScgLRa6LMykyTmjumk+JpKJ3D940xYYifcZVVnl?=
 =?us-ascii?Q?nOl+0C0Bei1bMp9unBMU1wQ/oEYbD2dIF6WSFQdoia6ZqmRlVRfyRjO9gIeb?=
 =?us-ascii?Q?aBSGJkWJTn/kZQqbHt30eC7RuSETN02NJOC+g/vcAmexIHf6yXQl+xlays2o?=
 =?us-ascii?Q?DLWL/st4VRGuH3RSVE70WTpMyYjjtEwKSbul4+OWke+Z5d+5+4fgumO1rJZy?=
 =?us-ascii?Q?qXMqXXTekQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787caab0-a4b5-4f26-e685-08df0511dff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 14:37:23.9406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOp42ICHi2g762axQMAq6rvHSvjXWNp4MQItTLxqo4oNqAu2iAhKN4ZPiXpJJQUnnWLD3WNqdXTu9HH+YoV90kn4rq6PY7AosjG2aDu2hW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 14:37:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20103

> >   File "/srv/pokybuild/yocto-worker/qemux86-world-
> alt/build/layers/openembedded-core/meta/lib/oe/sanity.py", line 890, in
> check_sanity_everybuild
> >     decoded =3D bb.fetch2.decodeurl(pattern)
> >               ^^^^^^^^^
> > AttributeError: module 'bb' has no attribute 'fetch2'. Did you mean:
> > 'fetch'?
> >
> > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Faut=
o
> > builder.yoctoproject.org%2Fvalkyrie%2F%23%2Fbuilders%2F17%2Fbuilds%2F4
> >
> 359&data=3D05%7C02%7Cchris.laplante%40agilent.com%7Cdad5794551c641d9d
> d69
> >
> 08df04fc0645%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7C639235
> 152676
> >
> 411590%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
> AuMDA
> >
> wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C
> &sda
> > ta=3DLIOLbRmNl9Dm8MudX%2FGHLYKh6e4FoZrOByT9621lIn0%3D&reserved=3D0
> >
> > Can you have a look at the issue?
> >
> > Thanks,
> > Mathieu
> >
> > --
> > Mathieu Dubois-Briand, Bootlin
> > Embedded Linux and Kernel engineering
> > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fboo=
t
> >
> lin.com%2F&data=3D05%7C02%7Cchris.laplante%40agilent.com%7Cdad5794551c
> 64
> >
> 1d9dd6908df04fc0645%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7
> C63923
> >
> 5152676440948%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsI
> lYiOiIw
> >
> LjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C
> %7C
> >
> %7C&sdata=3DNM5g2OmqXtTBYvIZEK%2BZhXJEgw3kUdwosF6Ptn8heOo%3D&rese
> rved=3D0
>=20
> Isn't the bb.fetch2 shim expected to take care of that?

Yes, this is what the shim is for.  With the full patchset applied things s=
hould work (TM).=20

Thanks,
Chris

