Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC5CAC5AC
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 17:22:52 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com (CY3PR05CU001.outbound.protection.outlook.com [40.93.201.13])
 by mx.groups.io with SMTP id smtpd.web10.3400.1758648164723455411
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Sep 2025 10:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=VH1Szbc2;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.201.13, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA2UlZ+Q/F3tdNk68wVxO/nJWqSyu3h+ETSWZozdnF6GVaLE55fwpQ68a5wQ8exZJFbgKM9+0DwLrRZizsyk29OnPX4VA2Agv4Wub0Ls2/YI0Zm2hLzZAjXaytVCxrc8KMGaQSLtmVYmGZ2nhKBETtUut4C3cGh+R5RCYn4kzdRCJgg61z+RQ607bpZlvIwZZ8eedNg8o1Ot2ihx0XC0pFPcUk1MS6bK8xEumYdaCkIa0FOT80qrxd2P4hQCYJivvkYn3Uh9Fn4X0HK0oM/PKeiVkX/jH//Uuxd2VgPo2DKTfYHAoEUWSalFgZVoziuO4svxBNHYKihcncdmoGJ8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRlBpHn+HOGqBgLiFIwFN1K+d7XvW4sSmDbs8l3fTsA=;
 b=wva0HctY61fEABiod2mWa7psRIY97AnAQ6bCTrTv6PHSmo9oUEa8OwD2koTESmc7S4hRSPSQ52cB18my5URfCYn4GSd3WUS3Y2Ma2Nbg6y+i2UVzFcKy8dt8no2YsxIIdGB95EphMGOpXocPZ0u6B1bu7mRSi5ol/YvyqSv25sIRYhVcKc2fvDPeYmNc7YfVpAZfC7pK0OMFIaM29BTUE+zw36EhTsBzjZGN+jWOiE83Ga4kPVCg1wR+9NLIwrayzfSOszqe1TWFx+i+FfXzYtyrsQ2wz5XtAUxKWSP+hDTahnXqI+CVBM729cdbCHHAjicOYWRsNDyVFFwNBVG5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRlBpHn+HOGqBgLiFIwFN1K+d7XvW4sSmDbs8l3fTsA=;
 b=VH1Szbc2d3Dw3CgpCJXUlwmrcYONjGfqDTjRH4e1kowvA4XY3T8ggh0dVLiPdX+htG2FAelNAffWemorWRLqfDgZjFv4mXCgtWnx0A0YONzIYRH9VBC64XKupnQlU/ln7sKmWg3tw3udzzqDaEm/31qbfdXxFCV9WU260HqBFrIvsTj+itM9YPGgzAn/mbIn3F4u8h6mVs6vdOYjF/bsnr3qimGhTZ7o3+bnTo1bIOxl/QktJgpKtZh2zN1XoUfMuGm72ewPWxiNJptzDfL/lKozOX1x60rwiHJ0n8dYwjUtZa7brDYY15ASM6sGHZGbHXLAOnROz+TNrtmbSoA4Kw==
Received: from SJ0PR12MB5437.namprd12.prod.outlook.com (2603:10b6:a03:302::19)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 17:22:39 +0000
Received: from SJ0PR12MB5437.namprd12.prod.outlook.com
 ([fe80::4d:3813:a91:40db]) by SJ0PR12MB5437.namprd12.prod.outlook.com
 ([fe80::4d:3813:a91:40db%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 17:22:39 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "steve@sakoman.com" <steve@sakoman.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [bitbake][scarthgap][2.8][PATCH 3/3]
 bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()
Thread-Topic: [bitbake-devel] [bitbake][scarthgap][2.8][PATCH 3/3]
 bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()
Thread-Index: AQHcInPoU1K11qFkM0ug2+dG8IO8HrShGCow
Date: Tue, 23 Sep 2025 17:22:38 +0000
Message-ID: 
 <SJ0PR12MB5437EA9316337B0E3C844A3C8B1DA@SJ0PR12MB5437.namprd12.prod.outlook.com>
References: <cover.1757523235.git.steve@sakoman.com>
 <5bdc63d1647e21a530568c0635d95c17354a18db.1757523235.git.steve@sakoman.com>
In-Reply-To: 
 <5bdc63d1647e21a530568c0635d95c17354a18db.1757523235.git.steve@sakoman.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=72e03e3d-9585-426e-b23b-20aaaec9d6e4;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-09-23T17:21:45Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5437:EE_|CH2PR12MB4135:EE_
x-ms-office365-filtering-correlation-id: 9aca5686-1e25-43e8-fb31-08ddfac5cbc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?EwJtsXaATjgwPj6p5G/lZuqVRS4ynHJhmeyP8mJkLWM56wUCLJmsd9YVNbuJ?=
 =?us-ascii?Q?IA2cc8SOSRtTu3kYWJj58btxw9+6+7JuQcIyu7zyH68/EiFTlIEy1VJr1d3y?=
 =?us-ascii?Q?ct/ypRUTrJfqDMmRRERGsnbHqma4E+bOuzCeKsL3FCkD7ZUKYbKZyPIAau2P?=
 =?us-ascii?Q?imKDt3z3ThhUXaWnm7cORpreNHMCsgd9kQKq5ayef1XM9DSUq3ZksKKu/Dzs?=
 =?us-ascii?Q?ZQQ8+kkAwZCc9C79fAoKFIALdcZUeMVlREe7igv0e4ybvcpaTS5gRqclXHpu?=
 =?us-ascii?Q?witIPlu6z9KuPhKdWtLRxWVj4X4Rga06AFMxvoHe0uZ/JmYLrTbzKu/cC3w2?=
 =?us-ascii?Q?q6PrtJSO2op9rkPOUFTiwqsTVvM8hIhkDIagqaO5KsTLGO6kxlc0vtM3/7GM?=
 =?us-ascii?Q?Urho8MFQ3Bbm3C41a8dVH5w7oKVc7eqLaSkj8gpwiCdvUS8vUlKTllc30P+l?=
 =?us-ascii?Q?LY21F+mI00Cfo4/z7RN+FClHajhNT7jUK11Iwf6dCWJrOiRsPYmcb1TSsXnd?=
 =?us-ascii?Q?pdwtJBkSFwqFX+ffeQCvanRXK+LmEBm5Xq5w1TnQVt27F1gt8eLZh/FJr10i?=
 =?us-ascii?Q?1e8SBqNCeUgfgflgCpqLuK7fYHN9slt9PclSuGa0QBr7ewPbnFcgRe7313H9?=
 =?us-ascii?Q?KWlLpum/j99skmOxHRJl/c4mX5TxkxIliUVh9jmg1NNphuvazr7/wOKpZ4h2?=
 =?us-ascii?Q?LHD7Fupb4anUNYqi0EnJBg92wZRWCVfQLfF+2b4wDqhcqcLo5D21VImHFDlk?=
 =?us-ascii?Q?fsAWfAN3WTGalUVxxfc4N5QikQnQEgdriMPd8jhGHLDwb/KJy5q8etLvyJKt?=
 =?us-ascii?Q?Ey9andpAAWNOchW6cYuddb8MCbbILY6ouZUhrtkThPHsXIHBdryaukDMzB9c?=
 =?us-ascii?Q?be0EIJ+0uy+ARcR6yD5yxCu46g0fKyTxm72uzZ6HhsKT7rLiFGz9b76rprpt?=
 =?us-ascii?Q?AfxbK4WtpXOmxXBU4VhkbI687an7WmECsE7PlquCoJ1gpLXF3AzaCvl58INu?=
 =?us-ascii?Q?wAoFKqKX11H33xUaM3GpGScGy7jvhjlK/KhH4n73rUwwzGMdRWg1GQ+GlsOd?=
 =?us-ascii?Q?C5oIqeBUTW+SSRDSWc60qSt3+ZuYz6BPWelXSjbAFwVMt0GEmAd8iK+6WDfb?=
 =?us-ascii?Q?gEJh+Paapr5LjYrCu/kO5eM21u910WYKu9iKReDDAzx+z66tJqGWgnlngxys?=
 =?us-ascii?Q?Yr/HQhnUuH1IjqUmCfPec5ZufLdlL/LNz0Vu7I6snJtiAUYXFJHCkLY4wQt0?=
 =?us-ascii?Q?6kGEDSB/fcd+lVR5opiCr3b1STjIMof39HPbqHI/4Yqlx6E7DrlxvYMfAr99?=
 =?us-ascii?Q?mtxWplANQ27gTyYqyptt07l7jgaBb7B+XiB4kaztj1orSgVU1GwfJPIgvsbV?=
 =?us-ascii?Q?UomCohXzPq1heoX4vv2F+Uh+idDo0wTVTuDBp9nk6RnDHsJq7w7fPwr5KRx0?=
 =?us-ascii?Q?PZiBu/K03/nj4eAFATeG554FZayoGEpfNxeTJ0St/rxSCUUhz3+wHw+QHLO/?=
 =?us-ascii?Q?jybbBPiT4TE1bVg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5UyhvUe69unYVDi6XwFL8JzsvS4a1FWd1/GUzZRLqtik/lq94IUr6zFMVwgM?=
 =?us-ascii?Q?DG+RYNTTZrabAx1qmFuo4qx0eaNEx7LqbXnwTDHvsmCMXyGORE86v8LG4qzu?=
 =?us-ascii?Q?dOgjKCZYRaFE8OINSagE2cXV8yOfye0qaqA/sNsnLKRE33s3aB3J7PptK8tu?=
 =?us-ascii?Q?KpBnDfVkzBgIVrjJK8q91qOD+WaNdmh1fqroYVc+oyU3oRaPrOxg6IKNbYGd?=
 =?us-ascii?Q?Ja7PpbUsdylfb4moNj0kT0+FFA3HZSbmz1y1G3qXbgqYCL4SYwDsdhljoxgF?=
 =?us-ascii?Q?Fa/EVjwOs9wMzPTiEKY2IPBs849tMDONkBIEks5mN/Gmklsd9jAARblf0P0J?=
 =?us-ascii?Q?NekbY1IxkXcwQJZNSMkBVjcna0Q2O+YFn5dqod+dKD+ZVqqQbzyNxUXf6e5+?=
 =?us-ascii?Q?qOsnbwEZKOgW1Jt1oaQuBZTVTiCMD1J2GYh3BeY3KDXpA9HE0pwj3gCH6RQh?=
 =?us-ascii?Q?ajjYgqlxheX71X8wRSpcLYxmhQE4OdQCE2ECyK7Xq4xxlUs9Wm9h6QQeSAh4?=
 =?us-ascii?Q?Wj+RZg2zwdo0dixk/LeD7SAzbWu8gP1jQqioKofwPSR3AJR/IqmSGTiJml53?=
 =?us-ascii?Q?CKQhZ7hWRGDXGlfw0KOll9pm3EuIiNVjSjq40HTY6juHGUYQMzjrmZH65J4z?=
 =?us-ascii?Q?C+CGetFHmEWKZHuMB2phVcfZTTkltZm22Bn6/hjxD72HE0dqdRZk6xPMJe3b?=
 =?us-ascii?Q?skAET9j9GuPi4waaS8J+ppUw4RrpQo7npAZa6L07aYDFSoO8aYN/dtPO87r6?=
 =?us-ascii?Q?LE1sCbqPLLXb3IztdDVHZ9/rz55riPUcvXwxrHdUQqqPxdkRB4hHH4irACxk?=
 =?us-ascii?Q?SR+Xaz4CFoPG9cb5CzWNUwb12SzwcukXeckqIke42lY6u1rRNygvtKaEkfrg?=
 =?us-ascii?Q?fbadRTd5c0XCgbfJ7FqsXXPA0NJyvZVAZZooJCdW2PGW9culHtk6m0uizqkU?=
 =?us-ascii?Q?Z2VvH8h1Qgeg5sIFMx1QKxe6c+W7yK+7UFL/7wziZsB3xeHWUALNgmiDCKAc?=
 =?us-ascii?Q?3UGQvZJLgAeZKqpvFkYXhRlThE8CSVaQzInMhpnVIQRx8RV5Dnl+/D2ZB7bM?=
 =?us-ascii?Q?bu8xo1uwYq25AhaOyyF0w36dyk6bfBeMjPOlapHyIaFubKMnbdvID3Z0ijaF?=
 =?us-ascii?Q?doA2NgJuc9oMxrFX4yIBFMMpGP2E3dDSYF0BFs3fDnaE20EFtWWlGl2Lyt1m?=
 =?us-ascii?Q?Zu01ARkR+yf5Z5rBGtss4XOSs0qiD4cdLG2TnZX+7iyQ6P6N1tJjZrNJ/tBC?=
 =?us-ascii?Q?1fy8V3kOEzR3Lk9t1+FOqFXHlvUhUT1EH1I2/COeOZzeEDag6d9eqUQFsLj6?=
 =?us-ascii?Q?Q7mNWymxqJXNwYGglycbcH5VavfL/iP+WjFOWvm9WdGNZyUYISqfT/zGCuCg?=
 =?us-ascii?Q?OHthNjdvYmIIRMRRMpIFFYofTY3XerVaBPwIW9EefJUOxwYMlW5mJOgUgTjD?=
 =?us-ascii?Q?Ocn7bzysaDeROzb2X3j7PGAHWPBSs9iCvHDwaTNDNuVcCjBttl57OTb5Y441?=
 =?us-ascii?Q?O1oMgjI2JsfuChKiqNChhKBqEH1M7OBU+8WGHWP8P6r6Ev17zXOwJ+D1MRYx?=
 =?us-ascii?Q?VTMIchDwnxZzEQrygsPPN+V16UeHgEeUwnenlxyR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aca5686-1e25-43e8-fb31-08ddfac5cbc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 17:22:39.0363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNKn7n37OAfbyCn3iqNACaaCwSxLweftkuiEXckIrRcjWQ2BaodhowwbANdNpRhf1M5liHQYHc5ydiy7DCwrHNdtKDvXtp5TKwy+r09DRvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Sep 2025 17:22:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18082

Hi Steve,

> From: Bin Lan <bin.lan.cn@windriver.com>
>=20
> There is the following warning when executing to bitbake linux-yocto:
>   bitbake/lib/bb/fetch2/__init__.py:464: DeprecationWarning: 'count' is p=
assed
> as positional argument
>=20
> This is because the 4th parameter of re.sub(pattern, repl, string, count=
=3D0,
> flags=3D0) is a keyword parameter. We use keyword arguments for parameter=
s
> that are not positional.
>=20
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  lib/bb/fetch2/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py index
> 1a6ff25d4..7b75d5d83 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -460,7 +460,7 @@ def uri_replace(ud, uri_find, uri_replace,
> replacements, d, mirrortarball=3DNone):
>                  for k in replacements:
>                      uri_replace_decoded[loc] =3D uri_replace_decoded[loc=
].replace(k,
> replacements[k])
>                  #bb.note("%s %s %s" % (regexp, uri_replace_decoded[loc],
> uri_decoded[loc]))
> -                result_decoded[loc] =3D re.sub(regexp, uri_replace_decod=
ed[loc],
> uri_decoded[loc], 1)
> +                result_decoded[loc] =3D re.sub(regexp,
> + uri_replace_decoded[loc], uri_decoded[loc], count=3D1)
>              if loc =3D=3D 2:
>                  # Handle path manipulations
>                  basename =3D None
> --
> 2.43.0

I think this cherry-pick got swallowed up somewhere as I don't see it on 2.=
8. Do you need me to resubmit it?

Thanks,
Chris


