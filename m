Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9360BC61DB9
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:30:06 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com (BYAPR05CU005.outbound.protection.outlook.com [52.101.85.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30112.1787686200474320108
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 12:30:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=CzBZIPJx;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.85.65, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzLptC7rCnPqlFdmDHrRZhIAsLXN/WN8bX6tOcP5bV79GDqbwoH3dHjHVIS66i40N2IT/nMluvUYeyXq+0cibEZDMpZERQW+sUQvw4WKToLdOFWyUU7sRGYoL3GlKfXNM62+gmUYakH9JxDbIDci8VJ4wU4WmIH5oTf/WV3ZG+MZEN6NMgx5m05dkm9D9HV+3prWevy2z4Rsr9a/5M+wTU5znIq4a2d0pM/q/0bS5p/fOfWFfqLKnn47vJz3NkwhHyHBunLMcB7KIRcsnKI700WRlgg1Sbb5H7yMQYvDQ9DKzFI1T1JUo8HRUkOY4sMZr967c7wWewD2FULAnwTx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9fH++aEYtSOm6wdbZBsSCR5CrJRqxRIUY5IIEkpE5Y=;
 b=jN6IY3+N/UV8BCsk+XP5OcUPQ/2HKljhuSkgrWMGmjP4x4t6jmQvU4ZoaJqYq31UUMcwDrMxfnVJdzmR7hvyCe3KMQ5ZBCKdWfCpUw26QCvsr7FVyqxXawORVisB6WQzamk7CqvsVi0KIweiD7q9Jfd+qOWxndAdzpjwCh8itTKkxhNUZIWDmDQDAwPfNzfcDmtHRa+oQLtXk//nUBO+fWkgVK8C/7eBV5f1AMEdnkPoAbWDeeHLwxI3Lrha+7+Rs1vk2588/kr9i+sbduYhSRyJChKyQNQgOttdg4Ovqs/28HOo9ej4AzZIzO5VGN5cBAzvn4SJ8conwJYFGBC/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9fH++aEYtSOm6wdbZBsSCR5CrJRqxRIUY5IIEkpE5Y=;
 b=CzBZIPJxOGXELa1fus8hpyYYqxJR1Jx/7Xfy2whJrd2r2eZKK8JiN7Qd9GcwQmUOKA5F5ocsl0VvF7bUoskzQqEjVnHoT4C8dzf2SSfBSlnQP28V/2R9J4MO/HoqroucFimOuXFjaVtcKF26iuHSwmEnZlu096LmKjmkZc170m/tK48wpwySAXkzPJlX/CTZCUuzMoU7+Xg4R2EYfCVgR25eJGyT+CIofSWLA2tCM8St2GSIopFxbtCHiQ9BuHmGPhvT+jIKRYjEoqlTHlxj470/9BOJBubZEThZL8FpAB0kq26hx5X0bYYvZ/NLbnzABnzxF2S8vF4eHndtBVQK2w==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 19:29:47 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 19:29:46 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
 cleanup fallout
Thread-Topic: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
 cleanup fallout
Thread-Index: AQHdMY96b7k/tzWQW0W/TmDkBQeZsbavF1IAgAAL/tCAAAeLgIAAAZpg
Date: Tue, 25 Aug 2026 19:29:46 +0000
Message-ID: 
 <DM8PR12MB54309ACE3083EBD81F6EF2158BAF2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
 <20260821170624.436725-4-chris.laplante@agilent.com>
 <DB5PR02MB102134543E3418DA8C1C06E4FEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <DM8PR12MB5430D033816F4121D4BB00E38BAF2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DB5PR02MB102130F2BF988F3933E6A98BFEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: 
 <DB5PR02MB102130F2BF988F3933E6A98BFEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=22348d46-684e-4df6-84e7-c3399a48c65f;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-25T18:54:55Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA1PR12MB6354:EE_
x-ms-office365-filtering-correlation-id: fcf2cf33-bf29-431d-6e02-08df02df38db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 sBS+3d0IYomMTiDCVOuh6v06MuhFPPJraMb9W9/IwUqVrf1w7T4lunxMfzn6x8vQo7yTIl+taUlBwnpQ23pr5NDET5IA8BolagKSEOFeVZkYIPZTzgiWz38AD/UGegRMOmxJVwbXdVjsga7qj0oZ2+xOtirF/xnq5oyikLZvxGCSVWvR2q9vnboDbg1mbbws+xXp4tW+ig77Ft8xbbWUHq3x6l/173//TRFZPKvh16RIJ42wo9oK4DriocL8tVAoRTip2Gj90djJ5ubzz4bZipt1hgApLE6TDTCd7ltNtm5VmXZvpquQyIZinl7+XrKW51Bdcn8eRTBXM5B7uT2xRjtBT3JZMVfx3ctQOAhHtH4dsymfalt+cS9sIp/xTOG02ZTPepEcqt7txiP+Rtn8H36gQBwb4OAeaTw/l/aWzL0A3iFYc0rDFYUPH5FTuFXiXQxk6Ttzo6Ct4hjtPQAVHsa7VHsVYx01gTiVAEuF+vvnyxWaOmHaO96W1nChcZwI5SdjZatT/D6w7Q0jlEhaEBO6eejGsrKdog6HPEkgyegTiBhWAyy/2CEleW/DHAPGx3tCt2Pj6GnCPLzxbSPAIzKlhzjWo6kI+AmJ00tVtWqAc7BGbEbK9gaiwYeFukTParUM8XdI48snxO2e3upkNVgtUZVb41EOxo7kPcW/5hfqvcfcan5AvYw+8Ow5QCI5GVp8coPLm9Sj+7z+B78xKw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yGARbj0LH5JgkOhTJV3q1+TD3BvZTJ0/XdHO4nPmOFY+XFZEW96Xu0NkBrNc?=
 =?us-ascii?Q?6KWKuGpFVtoBP6cr9Odi1zpgBqDhA4m4u2zK8ccNxKAyGnJG2h4mry9Q2mIQ?=
 =?us-ascii?Q?s0oA4GMjc89fLKUfQe/QIszVE5jSsMJmGywGgh7fhGKImonT7PM1yIp03jBi?=
 =?us-ascii?Q?MDW8HsveH5mJkxrrFW434zQVjeK+dvA0YH/+FOXzyxd/w1F9ZqvvS3iuygPL?=
 =?us-ascii?Q?EdNHepxkp3Rr3DFWOcV1JXEdewBDnO4sO6wKq8Qno4vHCzFuRJCX96auwCGW?=
 =?us-ascii?Q?0ahUJTv6VsVmzLJAhVJtPeBkGPb5G0wdJ11YlnzIoZIVYpAbNI5zok5XLWfZ?=
 =?us-ascii?Q?l6GllJiLfF4MXVySHBlK4pd692sCIeyE8EwM3RQ5RXd+AwBOBAYqgyER30j3?=
 =?us-ascii?Q?F0UhawQSdXqsbbfvoTywjE+ULB39ZDjXfdqoaYbbrhsqkMJXqh0/M0PYp70J?=
 =?us-ascii?Q?bodjcTWxi6YQ9CYeDtanyakqIdvubFHA+7n3bqR0cXFchBhU+QNGlPIvi+A/?=
 =?us-ascii?Q?7o2lxu7DPRb5n4e8RlQUDfnuRWN5cOd3mfUEyRCbJC7z7kYWkdia5s/srbUc?=
 =?us-ascii?Q?7NXhaseM5QwSY+XKTuee4BW+6UWgkR144ScbhhEkuL4/cVthWUIFqoGyTmka?=
 =?us-ascii?Q?mpDvmhy/E47EtrY8m3wPV8i6TRLZk1X5Lp+tiYjVJ39r08nIJycnnHfg0JO9?=
 =?us-ascii?Q?k5XutDForIyjPSwmad/J2sU0iZxui3Y2CMq80wdsQodNT/ddSXiIQCqKBUXd?=
 =?us-ascii?Q?t07Op7255+LEqxt102SxOI48cKe3bmNNyMw2YQAZRDwGTGeYQhn/kkXQEL6R?=
 =?us-ascii?Q?nhNh7KmNrOu89Kv5W9cZtGwSN7srVkbmpH8F2uExphB+is4IXULwlKKwrMcx?=
 =?us-ascii?Q?6Gp1DC3IDbhwDWxrDQydUKKCVhcC8c9z70VFdF3L+jCZkmNuxx40NKPUN6OX?=
 =?us-ascii?Q?zSDpsGduU+Yvq3QKYnodLoTg6ZsO+JmG5YWHq/PsZemHEj+1VR+7Ffehxo2I?=
 =?us-ascii?Q?UcMNiTfemIKN7Lg/MHENSr6rWJHDJ8m8xTIjJphmw+xCXAX3Rx90smRUIFDB?=
 =?us-ascii?Q?K/k0+MDeBvioMt0R/oqiuCeNojhhZ0ZUhTtSHy21zKGfoz2cXE8CGqSGrSDf?=
 =?us-ascii?Q?Bz5fZ0/9TXq8UIXnc6Z9WkIvGXVUT+fT4dsOkENjxAreVktFzPbmX3YaILdt?=
 =?us-ascii?Q?p6gfsSt2Ycx+zksP7yxiiXLeGTJGmSEEuPK34SAMdUi+USykMjFrrv9pgeuI?=
 =?us-ascii?Q?7ISCdg8g7EE0hmIWdN1hGom+9YRkOaytP3aSduQKa4e0BZCWjuMvQIIUS6TG?=
 =?us-ascii?Q?QoFqFs0QP3QK6InqQyR/reYwOyUHj4aDlylRqt2lh5nEaNd4kt67ethNPXE1?=
 =?us-ascii?Q?puPaIOxy5S5so9vpFcLzyl7VUZ78URUjCUQe92FJU3SxL+Xri878Y984kBQs?=
 =?us-ascii?Q?HljYN7Wj73ozAHvVzjPBVkVaLPJ/4APq1QiL1UtSJFpe4pZh/eAxrBGkINv3?=
 =?us-ascii?Q?2wboUwrBj1NX9gcQ3pz5KInJFO/Y6r6xciEf5TmpWgU4393o/rhvU/tPg0cr?=
 =?us-ascii?Q?w5MVzjRGQYHZmPIwuVAZcrj+P9Cg1VfmWhMO9WsqMVTSDdE2/wcOxARyJTWZ?=
 =?us-ascii?Q?Tbll8c7dEP7MNEXejEpdeMfTHc8v2yZjmu17VC7tHRX3NYEzjbC5yeEz7W1b?=
 =?us-ascii?Q?hCnyOg6Wl3Tp1wtYOE37mxq5dGtlc3AaIXk7gJzhcwCMMlGGcgs/40Q5QeU4?=
 =?us-ascii?Q?wrg6GHqZgg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf2cf33-bf29-431d-6e02-08df02df38db
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 19:29:46.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1rUBBC9W9j/AA22I1/MIaZnoXA/VfH4YLlAyX3xElOPEKWxSKlT/dwFx97bHE2qHd3InVb5UEiQHUk2Agxva54dKUYU9kqsBRxtgvUp6S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 19:30:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20042

> > > Double import of bb.data.
> >
> > Good catch, thanks. Though I think we are not going with this patchset.
> >
> > Thanks,
> > Chris
>=20
> Well, I assumed (most of) this would be used even if bb.fetch2 is renamed=
 to
> bb.fetch instead.
>

Very true... I will submit these parts soon before I forget about them.=20

Thanks,
Chris

