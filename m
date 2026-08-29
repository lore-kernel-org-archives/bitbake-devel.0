Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF66C61DD9
	for <webhook@archiver.kernel.org>; Sat, 29 Aug 2026 16:12:26 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10211.1788019939044101298
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 29 Aug 2026 09:12:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=2M7hCKOV;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.201.20, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2W6RLGGpD4Op8xLX24Y6Fced1E199ALQngFmqMRz68Efp9EdkGCNFFfEKfbcabXetKwjhQux8J18YGSLJQ3Vkgb1fuuIjXszRZv7Hydw3HEaqEcXnvInhAf5stPfoP42iPdzwfLjTWk/U9ffWhVyUA2B6inEswFhUAAi1vTvSIcjrULWEMXceiRzjrCgPkHMpZX1kxQ/60NACsWNHTlKt6bOhv5Sg0WTOJevxOoXBn+fXsOsY75OGQdxUEJep6L3Q9xXHG0KRwnmx/9ZbwhbAxkgxe0mpfwok66BN/xV/XhaMfJMGOgbAnMpuHTaEgOLk+Xx/AlqFBv9Wf/M1Atbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ndrv6UdM8yMw46CWhJCYqVeKvkmXcc+sdM2kv56xMA=;
 b=cDmhkIk14dGd0hnRCnrPuV9gkJxROcitgmL0AwIQZNf23xO49moSOMON+X2N8Tx8a8OKii/DgVP+y86yJ1nxrZYgimB41bKa68px82Ppra4OwAZJaXz7t9JU+htTFnP/c5SlqKXb+jxNzYMMeeNzhhhR1kjPRE1comM6QcEPMaAB+5cpsQGj1dkIVKNOazegWEfGZm7zL1S34exVu1sDtY9hIRz/ruoTsAOg0/xX6q8U8Zm+Chsp4x1QLoHv68cjR0JuNxEqvcEv1JvB/ubWxZoFaofVW8ExtHxWcZgHRyH6g1Gp9JY9OrUb+wFfS2uRdfeRMUw8j6DXVGKxx1up0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ndrv6UdM8yMw46CWhJCYqVeKvkmXcc+sdM2kv56xMA=;
 b=2M7hCKOV5uy4volz0LvoU/sFc3HuDZTZrGnR/2i83f+E6DtH6rlIEhsR/rsmB3fy107lTbts7ECfA31BkECYzPJmIOmP3Yk5OPBlAve3H0/B7CYnJEunBuq79eKn/c2T7bEl5XFSdMwtRUOutau09tNF9CFkTar3ToMu0z7JeXcRzl79oQeiWIoH+MzmrSGJedGruGSDwXW4wEl1RKRB8Pf6u36YddDUipV4TZWu0mf7XyyUbL8FIfjj1XwV+mdMULOuVA4kNlyYYZH8HJ+Jm3MnxOVe4ADjXs+dvk0vDcV1j6yUxU9UAyTeMuiQzD4N2GtoJBcVW7bury1CczgqgA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 16:12:15 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 16:12:13 +0000
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
Thread-Index: AQHdNwoK38+J/mz3P06K3mDmr6DsAra0y6yAgABntVA=
Date: Sat, 29 Aug 2026 16:12:13 +0000
Message-ID: 
 <DM8PR12MB5430BA865CCED3DCCC43896D8BAB2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260828162612.753815-1-chris.laplante@agilent.com>
 <81f397e0bfb6373b29d8a6205ae926946f8c12e0.camel@linuxfoundation.org>
In-Reply-To: 
 <81f397e0bfb6373b29d8a6205ae926946f8c12e0.camel@linuxfoundation.org>
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
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA0PR12MB9048:EE_
x-ms-office365-filtering-correlation-id: 4938837a-fd42-452c-5347-08df05e849cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|4133799003|38070700021|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 dJefL74rOis+K83ITjYZ8fis5H1sy1Y1muMTDP3jAvv1g8A+0K4tVgFjiYiyDrZ9yvkWrzfTkS7usqH90xBnn1l6GlvxAS6rP/JE8Ce7gXzV7yq5QVNQ9Gg9AmOzZkIrQyPEvqn3vC/KJNUYDNm+3cna+AEJ0VE6m8kOsXDZePAnt17H4EHn7epW5EUm6uxGjesYn+tsOA7w9rRAOGlXrJ+CDmpM+XBWdY8lqtzqkB0CLENLDzZnjy0icdO4gsMBIYfvJ0KY49NE+ZCtXllX6uZTfG4IcMr9bnmB2R7Hmg5lcIbAJgQgtQZIY1C2eQvrMp5/GjnyRwjWK89Jb65ySMzeX0SS4B5A7qR053kBP5XvNG4ejZWBCUIRHsEdG2itlwlHMEPq5f9cckVIPoG56r+KwH2ukgKtkxrJz3L0NsmsWcTE4FOohgsfpzfy/tG7TYT1HoHLMcmPUSXxehuzcVmeGtj4VA6i/LhVgQNyPsb5T2OtetZQhT1/ar4MRjFn6ZsOi0I1UkdD+TmdjHRZtyNrbAMcPgWlGdEHx6metsWKW3aKcb5KY3sraaV1qMqsZjMnVUKQ54tAIkLGRH+FnxPFxhdXBKW7tHHu46GlRJZh47p0rIfJC2At1JtqbfJ4cmHK99TAyMWOA0WIofCDc0Dw1lWC/mGEGMaJqW2Hhg4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(4133799003)(38070700021)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pO/CGkYlXHLoVTqbwqcpQNcOSaoc85/UtLUrQ3jV5jtHZJT56RZ8eX49IVVA?=
 =?us-ascii?Q?VHMA7gqWAlWSAKsVyHB8PeBUgDttG02U8nbbTIpEBKfa9tWUvBfdDLgJzGhR?=
 =?us-ascii?Q?DeMsAY7zF2H12AhclyWRXGpPrORGSSt/emXkWUlCgDqFF3hrPuXNAajls2Sz?=
 =?us-ascii?Q?H0UExa8D2qFi5QBYkNHJ6aYW4D9dMywdTeRqyrMB/+9MDD+hu1do43gGpYSX?=
 =?us-ascii?Q?IMi5RNIPu4l815VO0uSfgkKpoSWoXwl7PoxsSwbjw8nQXJ9OepmEiIfywD0P?=
 =?us-ascii?Q?EIDH/Mn9yGDIytUm66+0BxTJJEQj5EYjJVpB2JbJyxayfykUwz65A21H5s0F?=
 =?us-ascii?Q?+yTqJO5zBo+/J08oydaeSsLN43nTUCSU6Rh8WdYY0TUGFH9AYgWWIwzo3h3/?=
 =?us-ascii?Q?aJe39dYgNPohEUi2ZuSJkrOkrpge5/BbY5mUuVjJyb+sjZ/Q3Nf6Y8CEogFy?=
 =?us-ascii?Q?cAcMHfi8qKzdqecNMtnHTvKRoG/stMZpJZ1D1tbdCVEMsXslPKYrUf1KCOcj?=
 =?us-ascii?Q?Ufpg4P3jsQ9Jb9G59udzeYll5QtyCKpGD4aDQsKwJIfhCY/Sdls5lbLOVNX2?=
 =?us-ascii?Q?IcQ/Shy7C/PH4CWwnUIjd5RPLL2Nq1zP3/BdSqZ4l8jufYqzhuBItEVWMiKM?=
 =?us-ascii?Q?eWYG2Z9RBxtl14KgZGOZs83HtB6j/IB0+amhboD6XhvtasJaGPRHyHpkmCDA?=
 =?us-ascii?Q?HRs4/oTCUaiBbrE55aqvvO/hE3bF6+5kIomWb0TICffErSqg6yzmRfsRgrxP?=
 =?us-ascii?Q?EDZFgjBICRacGweE7Q5Ekhgki9+nOD/Gh27B4kZGvWjGrwOmf4DM8oDSA1XA?=
 =?us-ascii?Q?rlpXA7YP0vqz+b5hKDyDvFP+7Chv+krWAq6evPFfVooBkG/rSY9ZKbCVFXwg?=
 =?us-ascii?Q?g6+medmZwe1zgf4RYBM/H1xCqVD01sPmJxz2EjaarVkLHmOAqrAUoF1PMN7w?=
 =?us-ascii?Q?Nj0zvDbMsG18WOR485UbeJM7LXd6MzOn/g++jrIX7U5GaO/N9tc6ecHwN51v?=
 =?us-ascii?Q?Td0x28ZbvWHFWh/j75cjwvFmIKYUoSBuxcOWNhntEM6A/8VED5E6S6hx/R66?=
 =?us-ascii?Q?+OWd2aR7SsyBw3j2bz7fX6B/3d/yULb+X05NSVfbKVPDAvrAyVJJcGwkN5XP?=
 =?us-ascii?Q?Tel8i7mDmjbwBvwk65z+dSdcHY/f6uPV5iD+1TFRVlNdGjHGdIFqZn837U0P?=
 =?us-ascii?Q?IUtyZTiC+EBGIXmKZQVQzODvNAQ67w93qdqfLFsxtCxT2k+FehRYnVUPTHMf?=
 =?us-ascii?Q?Gu7QoOkvr1RA6291CWQ0j9/bzcOaboJ0xaV64DKH5IZiU2Q0628Rtx4+8/yM?=
 =?us-ascii?Q?pMIZTRMSxGmU7IRj1N+U9QD2L+mrtHGfLv+fGvfIzxwnmLB6McVQN6M6/3S9?=
 =?us-ascii?Q?pYVYiiNFBSjOU0YwU8IEJqutRDMK0yO9MFqnkLDVK3EoEku64bOOhbH1WcAu?=
 =?us-ascii?Q?jFaOYKZUm9W6QzbxlXCAECObvjx4zLdSIu7E2Tp8N65WDWF/aKkaMY/ETd2E?=
 =?us-ascii?Q?zhA7ahgREOHnWq+hmlHUmn46q/HXctp73PV08oZZ2eG2mXUeZhj2TG7Wtrii?=
 =?us-ascii?Q?m0Aw5ppkgljAqK948uHkZz1QYo9pnVkpMw180SgCjwJz+guyQyybC+koBO9i?=
 =?us-ascii?Q?7J5ItZNCOKyxNA2UqmJ+yZHDjKh54wNgwU4O1YB6dFbTa2ZwJYW9nkDFiljr?=
 =?us-ascii?Q?KwJwhKGmebqKszF0sNCnDvHdRB6aMU8RYHjrgZ9MYHdFdKNAfGQ5ryAZ+zdN?=
 =?us-ascii?Q?a0/mYQkPFg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4938837a-fd42-452c-5347-08df05e849cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2026 16:12:13.8553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t05eM0Kiajy8m60YjsFJpaoK1plGEt+vvLtdCa46oo7ndKL/dt5+zln7N6N2q16eXx6wV3xzZ0yH+g1SCNmVj9bV8nIm9h4UO0xq7l1T6Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Aug 2026 16:12:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20126

Hi Richard,

> On Fri, 2026-08-28 at 12:26 -0400, Chris Laplante via lists.yoctoproject.=
org
> wrote:
> > From: Chris Laplante <chris.laplante@agilent.com>
> >
> > bb.fetch2 replaced bb.fetch back in 2012, and the compatibility shim
> > of bb.fetch =3D bb.fetch2 has been in place ever since. There's no
> > longer a good reason to keep the '2' suffix, so lets drop it.
> >
> > We also invert the bb.fetch =3D bb.fetch2 compatibility shim to now mak=
e
> > bb.fetch2 =3D bb.fetch. We do this by creating a new lib/bb/fetch2.py.
> >
> > Layers are accustomed to accessing bb.fetch2 without first importing
> > bb.fetch2, so we declare a module __getattr__
> >
> (https://peps.p/
> ython.org%2Fpep-
> 0562%2F&data=3D05%7C02%7Cchris.laplante%40agilent.com%7C8dcf4cbed7a94
> a6d07e408df05b40514%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%
> 7C639235942913901460%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiO
> nRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ
> %3D%3D%7C0%7C%7C%7C&sdata=3DTKmQWEwWxoF3%2BT0vRYaCXXzYNTcxFrS
> kbPzd5KOKKAM%3D&reserved=3D0) to keep this working.
> >
> > Finally, we add a deprecation warning for good measure.
> >
> > Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
>
> I confirmed this is still resulting in failures in oe-selftest, e.g.:
>
> https://autobui/
> lder.yoctoproject.org%2Fvalkyrie%2F%23%2Fbuilders%2F23%2Fbuilds%2F4744
> &data=3D05%7C02%7Cchris.laplante%40agilent.com%7C8dcf4cbed7a94a6d07e4
> 08df05b40514%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7C63923
> 5942913938265%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWU
> sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D
> %7C0%7C%7C%7C&sdata=3DL7erW%2B9r5fo18eAI86c5LrCm0fR9a%2FOKEn5Kw7
> LooU4%3D&reserved=3D0
>
> I've not dug into why...

Looks like it's failing in gitunpackoffline:

stdio: ERROR: gitunpackoffline-fail-1.0-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError("Recipe uses a floating tag/branch '2.10' for repo 'git.yoctopr=
oject.org/matchbox-panel-2' without a fixed SRCREV yet doesn't call bb.fetc=
h.get_srcrev() (use SRCPV in PV for OE).", None)

(https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4744/st=
eps/17/logs/errors)

I'll try to reproduce locally.

Thanks,
Chris

