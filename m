Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD14C49EA1
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 13:41:40 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.30])
 by mx.groups.io with SMTP id smtpd.web11.7568.1722951696557431879
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Aug 2024 06:41:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=XuPODpDp;
 spf=pass (domain: axis.com, ip: 52.101.67.30, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUDOihEERfP+qfx2Cmkl2UN/hOKm3wxT/KsG1r66HrpOq2nvYoYYf5jlArVfahN+Og+L5jYXTZGH+laboVfSFDpo6MmzKHTygAJIGn5b0LzV3vc4+TTKqwcQbATut9iOAEqf41V5aBNThRnG4VyT18Ktu38E7xfnFnI29e5tBSa9Wp5L+/0xVAO3joBO+V2B1E+hNRHbjyGp/5GphlfQBws1tvJ9+wVmCPpCjD8Ij2Zgq7lleX5kXlDvm/ktFnW6keurtS7WxCUsVwmIpW0B8NxWftPAL0HP11nh+tFRVz2Ri5WIhpgI2bPOoCK/17vBhNuL1EhONzkhT+B0ZyJorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2ugKW9p3CyD2jkoGwEH477Be0jLVsSRc6yn1x+FTGc=;
 b=PpElZ8hgcirFEqEiqNc5J+s/D7y9+BMBUuqjQpG3HWukd9LWewBiXSZp0AjU99dIoh+L64kr4VLO9ilIUlVQpGxHdUOyRWgZpfXfJXPd0m1Rqd+FP6ppZj94+jrjq6OX4UkG5ijMcj4gl96Q76Zcij/u4vSgojj5sYMqdQ15h5qYT92WZ7VTNJIeVtKOJIkvZuoxe6XhQuqZQ2kfjopLHlhdPZiLENmtV3RDAk6zAOMg00E3ic78mRc8sSgH9/uQX9TvUuGKjrPkj3V4WJaF6UinN2rg8xxPSfVJKb0DGC81NbFIluB6prq4e/aR0PpRCO+ul7UeiO9Hr0QzHZbrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2ugKW9p3CyD2jkoGwEH477Be0jLVsSRc6yn1x+FTGc=;
 b=XuPODpDpXHc2LbrDx6mL2OJxg/HnHS0s93BHKxQoGPJ7MB27zHG7SpXBpw1raf7vZqXWAzcvTRSqnifQAUfnQtSO2KCYcqHU6dyrpw47OM6xacvUpb1QW0li/0OAmi6pf01yzAcp7TN+93kU6stWkeCtFG0NfaYUie6+BKOLm/o=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PA6PR02MB10709.eurprd02.prod.outlook.com (2603:10a6:102:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:41:33 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%2]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:41:33 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for failed
 tasks in summary
Thread-Topic: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for
 failed tasks in summary
Thread-Index: AQHawPIapS/6pGKeAESDdgOaEDjIOLHNuM1QgDcBcXCAAWQL0IAUakEA
Date: Tue, 6 Aug 2024 13:41:32 +0000
Message-ID: 
 <DB5PR02MB10213C66CEE84882C7B8D12A5EFBF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <17D9E3841C981E13.27929@lists.openembedded.org>
 <DM8PR12MB5430FE1BDE5343FD142CA3D78BCE2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DB5PR02MB10213FAD2E238F7AB9390A4D2EFA92@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <DM8PR12MB54305463A787C28830751D948BAA2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB54305463A787C28830751D948BAA2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=df634e94-fdaf-4c67-8d26-2b3b695eef37;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-06-18T16:34:10Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PA6PR02MB10709:EE_
x-ms-office365-filtering-correlation-id: 6eb21514-ecf9-47b8-35d2-08dcb61d7c00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Y2pAbej3E/taFxHYgvKmdj10JN4w4vgR2XERhjXaBUF58veAX5iL8Cz3gfwV?=
 =?us-ascii?Q?7mZ7f+4oJqQEZYkxeBN79h5iHmOs1a6Jjsl5cpu4bbGFo3YLKxBzQ4SCKtCu?=
 =?us-ascii?Q?VLA26r9wpFW8GB3YLaO+WLuW9v5v/3xESfIv5/Gmmi5nYCptPg93JA/l4Pd/?=
 =?us-ascii?Q?KXXN4+h4zLTpsK3nQ76O2U5/d4duIJzRqFFdy8zgL59MC6scfIY82TctB3ck?=
 =?us-ascii?Q?0qwtI4FeH3DD3WQgALH/2m1V2QbFHVGuI1e81vLJbA4zILbW7BDFgskJGb3t?=
 =?us-ascii?Q?uQPvVOQxMKfd47OxTW8EpC+swYUMjxEl6PoP9JV4SzyzMpRAPjeEcTRp/pLx?=
 =?us-ascii?Q?QTi248bEFGxN1ojmFSeQSMReQVdJx8VDhaYXMK48UDNXk1y6Ed/MHy9TlwEp?=
 =?us-ascii?Q?pHbPeyqrzpwXFypFOFHr1KAbdg+tBJIzlFO+e9oMwtbcDtTRzLgQnpHEf96D?=
 =?us-ascii?Q?DOlETJbH4sNhiUtjmh4W6mh/NExium1NifbpEiXdn63nogfgOYZmo1Bm56fH?=
 =?us-ascii?Q?q8ZDPyjDyae6liQITKaA77gvkKw/g2m4MlbIqL42U0WLPGY3sDp33nHZ9ev4?=
 =?us-ascii?Q?z7GZGMV+2b6+rMTsMMbWWJRFUfxjvrW+EUmZex3qvK5zU+A63EP09z6+um9o?=
 =?us-ascii?Q?COETu2THWoINCf8UgtxyaHHSmnauJvF1PE8IfD1zsjkZ+kxyztvUuADTWrpt?=
 =?us-ascii?Q?j4q3bwmIuZcp+ajsw6vFSWQdPuJcGdJFWuItyQl0WaKVdkObZSuyKSxQO2zf?=
 =?us-ascii?Q?BrQ3nEP7Q7CrPJEWF+c+yMxmj4q2sbY9VPHB4CNk9kjYd1iDLtztRaetaTpf?=
 =?us-ascii?Q?FxRQNm7/VWeQ1ZjZcTO5Kv71OtoUtBdZgBSGZjuPVhXv+UPhHqIsSTv6al4W?=
 =?us-ascii?Q?KNpLFnqXRkhFN0+21VjIMD5sUDp78hN60qtDdgd1SdZTKIVOLlBA7pGiLx6L?=
 =?us-ascii?Q?2e1fFwiFlbsp0ypHG6/sm23JIyWGGCH+8DP2VDjIbhVRseXCjiSfAI66YPwd?=
 =?us-ascii?Q?HLXvM6DJtY2K6ed+F045nRwWjl4u6jeApe++H40yPsRny+q6+r9FXV3UL2I/?=
 =?us-ascii?Q?pzg1+qJELIzhuNCAX/sF+CDUgMVn/Or8iMtumLfqdGqaK/GrMLBSWpY5PQbO?=
 =?us-ascii?Q?VQ5tJvUap/5kinph+Jan7SnBundt1uahs83QyihiGfaIS1eKxNPk7lq1Cp4u?=
 =?us-ascii?Q?qsoeyhpBIRmpklqNY5Q1DBbX3c2YAuJeqbTGkcW+24bcRA5T9fhmCaazIfJu?=
 =?us-ascii?Q?iU6hFMLt0QNvoLSaTuADC0JtbC05BkmUz48yjRjxost2VRtLTVjgbHg1Ld0Z?=
 =?us-ascii?Q?QevWI9UK+Ev/NaQpswzLRVauV4gfW0wH2w5Ki79jPTePxtg1wSGVoROTAxFc?=
 =?us-ascii?Q?2HQOZUDzQJ3MZuhmxvQK0j/jq5R8xlXMp4VaQy75ULp4hb55Tg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lwjAwDcj4wmhfPYW+Gd7Yr5vIB3zpAjzjW2DkOEnSjoh/xnOvBgL1igomR8c?=
 =?us-ascii?Q?GiT4IJqv2WI7lekVlXUZ6J5AMo09RLAG7RKwA0Eoh2SdetG9aGgnxUP7skKy?=
 =?us-ascii?Q?CUKPFyR6Z5BwJoYt0P13IyJgAuYnfGZezwhBBIF+KqL1lp0IzPrSqFe7SQVZ?=
 =?us-ascii?Q?xQEHsUuEK4ksrqfhEo/RpyqSyKRF5FpUTH3ghPvuERwBV58Nv0BjF0Pp2Ig8?=
 =?us-ascii?Q?b+5w1yL08AXWkv8jwv3FQPO/8BWKsxoPMfBUMG82qNsiPVSKSJyvRqYBQd+g?=
 =?us-ascii?Q?DUkkJQYs1CmI/fZAEH8Z/hgbZ1nkL9DkqRsJ2m4k9/HTFuMPkeGoTISaNkso?=
 =?us-ascii?Q?tgXEg23tCXHD9hl2ak+X49I+94s4EJFAQoC2OdZmYg9s2OGFVhKfm6US6+fh?=
 =?us-ascii?Q?D4SQnuxYBIx7rAiBwBmVKT9qAYSwG4mDFLN+jtDe/AdgjjonTRl5GL1YKXWm?=
 =?us-ascii?Q?8AYYZ45ApIO6v2iA/KWgjKkW9YhbuLB/s9t9slK+W7FPPeqBXbTlXhUrOUzX?=
 =?us-ascii?Q?hmkGa83XcJX9im3Xur6y2/HWC2YmEcPe/quXkxejV4oTVdmU4p7QmbnRHvmo?=
 =?us-ascii?Q?VwY8HBpuisGAe5qCfgL8S77LUbLl/TFrfrg4x+ha3JzKtjL0ROMt6Fx0hqWx?=
 =?us-ascii?Q?Q/y5ulRTvrLLEg6VszPUcOa3xLyFih03CC3Cl0PSgxx4NmiEtp/ArFgQFNCZ?=
 =?us-ascii?Q?tmXScdlT5O6bB/NUdLa7SEhC/FC3840LCh9nqBIrXBG/LQ4kq90nxicTDh3T?=
 =?us-ascii?Q?3phiTOoLbNp2Pwf1T6tiOuAi8kiz5D3Fy7/xZBIzAL15eiBXb3mxj5C4vocV?=
 =?us-ascii?Q?b3ohovlORG0fFZUvhF7cASSLYPIE+TW4jj3NGrSIMaAwAxD5c7NbO0urwOnA?=
 =?us-ascii?Q?NuivhST694dTnll5ZeE5eulKrAK9dqoU6MsbjSPI/Cu+BIO9dTuA3OqeRYrQ?=
 =?us-ascii?Q?AWpwIsTgfNVpq8mp2slXrrk8jdnK4HrpoLD6xFmin4g2G9P2ahI5SUPsQ0OI?=
 =?us-ascii?Q?dMzJRw5MIhCPWcjWJlApk7M8fouXpIWL38UnTnxBBWyhq1Q+bpoba+FNmyFD?=
 =?us-ascii?Q?FYkd0VWSiroAmOl6jgEUg8JBkmgw832YDeCS6H0VagSSGC7Q7GBy7tShwczp?=
 =?us-ascii?Q?ekkRCcfibn0I+5P5zo5/P47TW1Ng27Q9DFNIzh6VWOMFYAM0C9kv1CNw3QJR?=
 =?us-ascii?Q?0z6Q4bZw+Lh9I66a/HDqo3r0jN8zjQ7mzZVZFqDHEadsCe2ru2ykmDBmPh/r?=
 =?us-ascii?Q?gNUjoR7Fe+eMD1GPl9jFKTbQ72S0fNHg3FV+0uvyPSWsVsJxHgsKKt1IkD3H?=
 =?us-ascii?Q?xasq4Arat3qkHOr/P0gVTRSt9RWbaKq8+w9Gh87/TqVZH+KKzk60Z0iZvdjn?=
 =?us-ascii?Q?56sVhQ9rKw6Xid2iIVhujVhYaE2fQefma2ihJ+NwAUn6AxWNgBMRh7/oMcqN?=
 =?us-ascii?Q?eLJeGqMpsL12YtUlUiEuq4ZURy9kfWJkIzeQDEtOJm3yDTFpXaYZfRntkV41?=
 =?us-ascii?Q?qJj1Oc+z3xJTxpC6YwP3PAmI/0SQ1fkWPYYIULosWbrgtDM6Gu1pXj03q0rp?=
 =?us-ascii?Q?CkLcNAn/eqroEeGzBX4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb21514-ecf9-47b8-35d2-08dcb61d7c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 13:41:33.0093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdviY6oJOmv5DaEJQZgAC+84OssF0YIPzqDhiR/vnJrEhYZIBcYnOWu3hm0CzTSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10709
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 13:41:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16446

> -----Original Message-----
> From: chris.laplante@agilent.com <chris.laplante@agilent.com>
> Sent: den 24 juli 2024 15:50
> To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-
> devel@lists.openembedded.org
> Subject: RE: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for
> failed tasks in summary
>=20
> Hi Peter,
>=20
> > > I probably should have included a cover letter, but FYI the reason
> > > this is RFC is that I'm unsure if we should disable the hyperlinking
> > > in response to NO_COLOR being set. I'm leaning towards 'yes, it shoul=
d
> > > disable'.
> > >
> > > Unfortunately there is no universal reliable way to detect if
> > > hyperlinking is supported by the terminal (at least according to
> > >
> > https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgis=
t.
> > github.com%2Fegmontkob%2Feb114294efbcd5adb1944c9f3cb5feda&data=3D
> > 05%7C02%7Cchris.laplante%40agilent.com%7C3bd654f041734bd60ee508d
> > cab4d8dc1%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7C6385
> > 73596794212235%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> > AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&s
> > data=3DqFMRLWNPjXTL11pB%2Ft97P4CzJ4QRzBXcWS9AUnCXxcQ%3D&reserv
> > ed=3D0).
> > >
> > > Thanks,
> > > Chris
> >
> > I don't have anything to say about the link support as the terminal I=20
> > use does not support it, but I would very much like to have the support=
=20
> > for listing the log files integrated. I have added this patch to my two=
=20
> > main build trees and it helps a lot to not have to go hunt for the log=
=20
> > files when there is a build error.
>=20
> Did you have to tweak the code to suppress printing the hyperlink ANSI
> codes, or did your terminal just gracefully ignore them?
>=20
> The feedback is much appreciated, thanks!
>=20
> Thanks,
> Chris

I use MobaXterm (on Windows) and connect using SSH. It silently ignores the=
=20
hyperlink. Same with Xterm running on my Linux computer.=20
Gnome Terminal shows the hyperlink properly.

//Peter


