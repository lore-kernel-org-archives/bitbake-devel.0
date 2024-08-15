Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0DC3DA7F
	for <webhook@archiver.kernel.org>; Thu, 15 Aug 2024 14:11:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.84])
 by mx.groups.io with SMTP id smtpd.web10.124072.1723731103672785190
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Aug 2024 07:11:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=RILw72xF;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.101.84, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjLKbdh6pCA08nR+u2PcdBohHjbcogR9Ess1UZc3UG1poRo31y9hx9e9hu7auZcJjx4hbs27wx8GtpuFzz0zjbl3I5KM4bclp4kB/jPyiRWa0IUKsarn7z+phlooibX9tuN2AXn+RjOv88pvxOkErKR7vhIQuWnQzoN0iILi2R0QNUzWyWtVwnawF6gDgr3I7F2+Vlzpgus5zHeXC4nW7RY9iDxM0RHN9N4EQeD+sSLK1vGINbNfYOhiAP3KhdxQmqovKUqLhwXzD2ZpeNz4MWPD9WeBdYg/6X+tYyYWmgH4X3pmJwLlk6ueMLR0whR2R4+U8AZ6tBv15vHNbJ+k8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ABgkm3ht6vUhv63apT+z86nVNhFlKXwMYh0S5dUIys=;
 b=LFX6GE4le/XUndGz5jOhQ1NQ2jnECGstOn+mx/DFMtB3b4amwfFCqZilYvHCiIqR090N6MxhVCN3aHjM/RDks4NeL1fYHgzDgYhGJaxR1gdCZuwqdzd9qb7+czOUDof4SFD4JMt1WhWuZY+Z/fFijWH4LB4lVqPwKSwgtUwkToswCWN973mqLniCIJdJwtCN3SejWmOrfpW9YgCqrwXpXOQHXrCLtbVTYwm081SGejoa/tAuyS/7E7g5SmSSsS5zWm7ILPQP4UYwS/fD6vwcBzfovSyn95nMwm6S0wQAnK0adshr+9z7zMijH4WJN2z49dXytVmO8lQBLBc219M8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ABgkm3ht6vUhv63apT+z86nVNhFlKXwMYh0S5dUIys=;
 b=RILw72xF2TfaM7p5PPx4an/WGQAP4+AiQHzUYvQHWsAGbIjNxUnDJikxdoyAH19M4m8O8u/9d3g3pBwMMBxHNhTXKYzKmvoNTOttH/85RVePxHLWQrD5/vphNX55CUDImh4tlEik8Tg+LG40k4CNpptFRoeRP8v/u9b+Yfyty/fvjC22ASXlj6R6w+MqJOdzgSwYta4hkwdfsuQJSzHAjeSMhs20ZDqHYbUUwFFOE1oVbgDFrHX6K8cLeSGrRH8LYPLWH7Chr1r6e+Xsd+TII02VOCX+ZZFBQJP6LTYzTyx6NVL6evxyTTMCZpUttuECIaNmW/G7QlPQdA6y77UqyA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 15 Aug
 2024 14:11:40 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 14:11:40 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 1/1] ui/knotty: print log paths for failed
 tasks in summary
Thread-Topic: [bitbake-devel] [PATCH 1/1] ui/knotty: print log paths for
 failed tasks in summary
Thread-Index: AQHa7lEB++IGQGF0cU+woY2AeikDcLIoXI6AgAAAQ6A=
Date: Thu, 15 Aug 2024 14:11:40 +0000
Message-ID: 
 <DM8PR12MB543032DA043DD96DEF338D4D8B802@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20240814135037.4018930-1-chris.laplante@agilent.com>
	 <20240814135037.4018930-2-chris.laplante@agilent.com>
 <3dd5799cf6df1fc72042c505a75b803f2e208c69.camel@linuxfoundation.org>
In-Reply-To: 
 <3dd5799cf6df1fc72042c505a75b803f2e208c69.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=a6a7b971-5cce-4dcb-bf79-4073c22968b3;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-08-15T14:09:21Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|LV2PR12MB5800:EE_
x-ms-office365-filtering-correlation-id: 968134e6-5d0f-4bb5-f7a1-08dcbd342f10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?4hNQnyZmLnLAWnUhwReATsQwkoxdDDyHn+Av9hlWHRzEqJF7htCrRiW03g/H?=
 =?us-ascii?Q?9HgUDp40BxqgeRX5HuEJPN9pyZw+mREmsnP/4D0NLCskfR3FP4XfowJU5MfW?=
 =?us-ascii?Q?drX3XR32HaC3nrArBcKNlThdwoEhhapr6V1n9yTP9+wyh0AK5uQOlAUzfmzQ?=
 =?us-ascii?Q?CXSCw9uzGTnygMCBXyzDEb+WCfpwXsLfZD8fee7pcdpHKc812P8/ZLdO7I9C?=
 =?us-ascii?Q?kb5h/NjRtdBtg1u06OqPq1HdqeBV1H0vDEJzR3CmiaINNoZ3LsZfBsS9ZJsS?=
 =?us-ascii?Q?3S6xmWipqJs5wz6eTvNDLdAk1OqKnR0YI/LxbpnGzTn4L0lLvyvZ90S0vfmf?=
 =?us-ascii?Q?1nP0Wps55Dsi3sv/sblDvGDxKP4Ow3mxa8zlNt1kgO5XRPfFcmuvyTcBvfQt?=
 =?us-ascii?Q?XxsbJ5QGLo0A1PspxLakQk4ACnYqH33S4VD0X8LN2a42v4gtJNh55+IQ5NY1?=
 =?us-ascii?Q?aJ8YTOIoThgZgfYJXcv8ybuYoEc+fJTAB8rj4GJ7DKONhDQJygCC4hYjEh+3?=
 =?us-ascii?Q?rl9kH2P2jww4O1vnqp7W9RgLFV04dsStTZmkxNVy5Dv3HqogQP8tT77PTTpI?=
 =?us-ascii?Q?SI2Ijvpai0laiqVQyWHIeKGdXTLRQbUU6nDyoXhJRSZeg0gANuWFkJFpK33+?=
 =?us-ascii?Q?bevmAtnYOuA3g+cUUE59nd31I1DEK9WStzGCdCSvYkvPyMzZBLcsnTW8h9NP?=
 =?us-ascii?Q?DrxJd/GowBAkL/S1IaJ9b1eYnDD2bCI63k5aOiH8rCn3bQE9zCh8I2Vgeeb0?=
 =?us-ascii?Q?PS75HcSdem9mP6n4TeMf0o6FMHCqrdqqCsFAryeyXXzMB1C0RrsEfkEOmBhH?=
 =?us-ascii?Q?IDUsh1zMJBu90Q8nfSsNnFoVscrqWrR5s3OHzHst1mgLsnpllUqISU2kTngy?=
 =?us-ascii?Q?PC13TnSKiGtwiQVTzKxmTFLoPJbcJFLd/RyLnB9sohIBkzy2hwpNbcTB2oDR?=
 =?us-ascii?Q?lJQ5Cl8oL6wZsgtZhudrVHqXymw9FDfgkWqt4aD8YlaA/b2SRQHXGqS6Ylg/?=
 =?us-ascii?Q?J/KZDMkXvGMbeZAXJqRhR+0wdZxirGsnRPbjlSYc0EpZZXy/qSoRavHPCIHR?=
 =?us-ascii?Q?exf7JZs9jd7/UYf91oFTKjdHldEd9ekogMPDBqZba19NiRMR1+v/XhEjAfUl?=
 =?us-ascii?Q?p29k4h7AaUDznlbrV94JTrEhgSTdkGu6LXsEAYhtZhl+jPWUZEBEeJj1WdyS?=
 =?us-ascii?Q?lEXHpVUNz8anSlG/3qES7ZKoO6OCt4nLVWIAI3ycbKwokTG5bBgtaYuIcbpb?=
 =?us-ascii?Q?Pw0PDOhq1Fdzewy4KITHIRyyVHjY6fAuzzL4Yt5WTVh7oaQ6rg11rEjtHUJy?=
 =?us-ascii?Q?ltrQsQJ0U7vLHIai7H/niLPHprrtIBjladMVsCwwgAGfS93LJXBAVxeMtuyw?=
 =?us-ascii?Q?2ciB673gBnbRqvpLC8pJZ9EgS+nAM6JfN84SxCcOEkKUsAGhRw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sKU7EJYiJW9+hoC7aXs4gIQK7mhelZeyJRsL7OLdQ2aYwoE6rXDXE3gFjR/+?=
 =?us-ascii?Q?Klh2pAL5cJ/1bliQx1qM0LiY7rJa1VgyuHGonfjBtTOdQopr0xcXzFj2Ut1j?=
 =?us-ascii?Q?KCQlnJxjpmQ2Mrg1SL5ev53O77vqPIy7zGiR28mX0CQDmil3sXT1qtS074/u?=
 =?us-ascii?Q?Y4sFapbCjo07M1vhwydFv5LTSxEF33n8U0NrkmWFNVylld4sfjB/mG8nQHna?=
 =?us-ascii?Q?JaRTb4RU5NE1gHSK7K5q0ePPKSMQY9N5aYbhB+LHAVvL7xxTWXuLIwU1qYiM?=
 =?us-ascii?Q?ohDa8FqisQ4lJ3y//ewALMY7YO7Wgh+k6zrhAbSytfeSi6rnzk5ywNo62okl?=
 =?us-ascii?Q?B7HEXvtNgGGKVBmjjOZHg8t7eZarKB7u7tT+pdAsHUa9JTLKM0mwE/E9j19T?=
 =?us-ascii?Q?UoPQAb2WH/f6/dgr/GVQwqQdwUfNZt8CV3ws/t9qzisr2P9deprfPr+28rgp?=
 =?us-ascii?Q?k4i4x5mD1qx6NX+kziQdgZjsQOMNi7IblPNGZ65mYf70Eracpu1z1lLQunvB?=
 =?us-ascii?Q?YQZd2GLiB0i77Y5v7GQwNsmSt78SDZGwoc4a88rDwNBDYthN07tYHKyOi1E1?=
 =?us-ascii?Q?Spx/I78dVqGB1qKxF4w+F0nXw5E/oUe66RUp3DfmOkUUxzen8rPaIwenwitR?=
 =?us-ascii?Q?PXgprA/kfFhFoEp2pWdBZsOYQCMKpH3HxwkhtSOX6wGAkO0hR3tP5K6/eGTo?=
 =?us-ascii?Q?rdRzD7yE5wFEQ4NpAz/WTVe6/+U0XdW6qdIN5Yp2EbvwfWlWrGh07Ocy8JCK?=
 =?us-ascii?Q?iA7Guenl5rUDEIumR35kqTHvm6Ds5n3isW7qn08Dm70YlRLV0I7iZeCrObBE?=
 =?us-ascii?Q?sKLS0fwIqD+O2MkEOorFitnSbvirkY4g5OMpgb0rvAdT+jPHD3TX4XEvm5p7?=
 =?us-ascii?Q?/H5u0rMI+FSw0cazykzE5YQsmC56nqF4IBFtwtyiF5Z50UO2YZGQDomd1s6w?=
 =?us-ascii?Q?rlitjRRSfHCE0W63DieAwWqR68G7O6psUrPRc5fQQBxAWSEYN5rIqnPoDUD5?=
 =?us-ascii?Q?hQq42FdQBk3QZgVyGv+KCCfPc6YWQhC0qXHazxaIdxUqusgy/2wrSUvM9W5L?=
 =?us-ascii?Q?z/kZmml6uVOeHy+bezfKbANnCQp37Hid6bfEVCrs18Kk5f4klybuJ2J56tBs?=
 =?us-ascii?Q?ioAZtEV5+6E848CDh8FviGIbZd/CPy9720mfDmtZ15Ahqcm/qJERos9wBzp9?=
 =?us-ascii?Q?4qMZ/kYIxNmpQqQt9qjbM/rkePpGSGRm4kemn7ti3UAtQNPlExOB0AuN8VE/?=
 =?us-ascii?Q?Jz3szOyZ+Asx7RuqLouG4j4gWgisNcqS+2j2UZsgD2dO4B10Dyd1c9ROw5Uv?=
 =?us-ascii?Q?ivpe82g2ZdH6rfNXgAm+KD8w6pdhPUTwEd16RXl4hcVd0/Nqkh6BqgeOpz9a?=
 =?us-ascii?Q?PXpvBazbGUQM3LCuFF++DeAkYQKXwtR38XtcnU2/lBMDTivqsIoNZeCp98M6?=
 =?us-ascii?Q?aR01Gt4QVzelTdN/Vj0Vk7ihGOisHmM9WikjoVgTTj+IEGv6w72HOmozkRKZ?=
 =?us-ascii?Q?sfySjsisv/nkPk+TcPmIQLS2NORAqx05I7oC0XqeInQTT0Qn3rwlFnKJt4DP?=
 =?us-ascii?Q?OoWMn3rp+CVJqt9aZq3SPuxSduth1RFSZzZlKbop?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968134e6-5d0f-4bb5-f7a1-08dcbd342f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 14:11:40.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGoxsDlSKA6adhMkIj70jg9BY8u9QRU9AzLk40q3TWMr+71qR8Q+9G0kn7UQWYFN+O/Xyp3WiQ18zLFChPXYmaR2RYH8bZ61ttQzeUqbQsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Aug 2024 14:11:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16488

Hi Richard,

> Sorry for not replying sooner. Is this not going to print gibberish on st=
ream
> based output instead of console output?
>=20
> At the very least I'd have expected an os.isatty() in there? Knotty does =
that in
> various places and even the name hints it is both a tty and non-tty drive=
r.

No problem :). Yes, absolutely. I will send a v2 with a check of os.isatty(=
).

Thanks!
Chris

