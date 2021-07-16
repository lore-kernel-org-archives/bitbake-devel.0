Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.82])
 by mx.groups.io with SMTP id smtpd.web12.7696.1626448063056020649
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jul 2021 08:07:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=mGGYo+9f;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.82, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAOa58+k57VrLBbHIiumD8R5DMDWxSXZukY6eQr19j4vxPnpjlHcEfxZAzfCqDGhXtxi8fndClO7PknqR5K4qEl/73kIBd5Td8nNVqTE/Hl4NC/P7r4Gy9pQ/yngpmu/QT/ezj+Z+JvQw6T99oYo2Lk0WOia+Ee64HQDOouZY1MKga0W41jXLDYGDd21CPXZ3lNE8WvNd2QhX/ZJRqMQUMTOTZB96n8USX+LRjg9cJD6gzw0ryBHSYeyYAgCCGcoZYL35uThWTI74dtHXlJoZuYKiIDsetcb9wUwS6zF7xCf+S3n7CMOQkJSSRfvfHZBNcZvzeaWVCnyhilZa/cHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tkmm/84fakzhDHij5jzwl1VAKNGlvfdBOe2dBG40JI=;
 b=hlD4F0ByKCeeIsoWN93CEV4WCNFQrZ5KHuUIeDZ1RMC1Nm7FRYj8XNgzuJ2gswL+nIVF15g8FR6SBRsM+vAb+9QTD45DEl63FcwNN95WvQZ380bIL+yzB5BrwLY41HPHMsRgeTe3BDU8uG2wL4QskLM8NkatiruNhZVeusZGre2zOBqRtxNnQj+86lt2o/RyG2462VCRwmZT02flvO+nfQjEC9mcIzdYrlRDW3XwjFOzyoW5zVTyz4fRmvY3Z92gj5dXv00msYghI4uZNRmltYKXJGSuRPpzmV2VGmJtHiHzpT3eMUUsFq8Gy8QeP3gocY1CV3QQvmB5zSOGHWsjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tkmm/84fakzhDHij5jzwl1VAKNGlvfdBOe2dBG40JI=;
 b=mGGYo+9fArjmbveTQyerjo7zhGJpZrzz38gVlp0k5Qr0fOARKpemXeUmg4qOYYl57B1DFnVwx2MwDmyILpWoitJrCNa4GPmkUbUjspMZ0IqbNS3ClxDWcXSJbGq599M6e8PryekLKBhcVVmeuqpxo5NU6rX3diNATfKklqryuHpHRTUruu0KikSx1VK4eauhr4ULBlLWpchlV+RhBcjuIjEtSF9mX3cjMhYKA4oGZqPHQP+Tp7EJExMDmB9LceOFYaE39KfxfZuJE70dc5dl3LkjYaKNJ54tgNpZ7h7XZeO73Kgmhh+a8/uv3mflmyRzdOdbcnM9jLolstWYmlfFHA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Fri, 16 Jul 2021 15:07:41 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::f56e:ab9a:e664:b58]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::f56e:ab9a:e664:b58%6]) with mapi id 15.20.4331.028; Fri, 16 Jul 2021
 15:07:41 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: "mayank77fromindia@gmail.com" <mayank77fromindia@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Bitbake rootfs issue
Thread-Topic: [bitbake-devel] Bitbake rootfs issue
Thread-Index: AQHXejfFBcVZoeQT50mjeCNkEKZL86tFsteg
Date: Fri, 16 Jul 2021 15:07:41 +0000
Message-ID: 
 <DM8PR12MB54306C7002348C00FC41A0798B119@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <CAKjpqyKztYNU8Suaq-PgC=A=VWLGGezYm3OzErSLbRVLZ7QNhQ@mail.gmail.com>
In-Reply-To: 
 <CAKjpqyKztYNU8Suaq-PgC=A=VWLGGezYm3OzErSLbRVLZ7QNhQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3902a14e-ca88-416d-7f9a-08d9486b755f
x-ms-traffictypediagnostic: DM6PR12MB5549:
x-microsoft-antispam-prvs: 
 <DM6PR12MB5549E9A76AE5EE9DE1A6232E8B119@DM6PR12MB5549.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3dOLWpridGQCNTCLZ2a2nE08DzjKeI2AvZ5okfu+XYCPr6deAyq87tk8zWS4Rb5YIVMxRgYQGVzt9V6jG2n3DwTdvbT99h0BMv6PlGmKR+DMGoPf3Tu+mFdvUA7of/gfZNMCyiGv9dAjbPLEeA3cR1vQVJk+KMMedWUc9dOfMuhMQmyb2szw5XnCjyOjYKmRiJ/IUuslMtEiserqv86se1OSkvgAb89Pc219penQpOy3fQtcUSsxG8l21Wz5Cf25imYzQKKW4IiCCPuJ+ymVxycR/4FLw8/upSyvNY489w5qFN3aJyJA7crstiM+Rxo1xIWanFqMLhBqYSodAWUmxK15Keo+Grsui4TTLzZdRHcJFyc4NwpBYpacUBurtHegk3JwUxVE/U8G5SZGJJN2Wr9r82o7SgPM+uT3+0Yndg4KPa8SPW/73CoZ1yQpgxPFMJP94ftMtHt09TpA7wV/sE7/A9nymIZ5xKUq0MVua5PnWW7NJylZGBo/9x8kVrNpIDAdbAOaYLsk0VDU0JCIb82QFwDhMHeoiC7rJdOI6gFXnY9eVPEmGr6jyUYaSDrQ7EZ3os1q95iCHEVIV4Dc8GgojRL85Hzig4Iy8bsdaY+i01CyaGYifuAu0/ZrE6kCqtHa2v/V5vQkHLW05Xqp5YTp0M1+LxPLSWnZwXMbKhMuNS3e28ie8Xtsqs7LLZjKrvZ+utHd97cmEVl/P+lOSJvp/jbjbcTZRJDp9aTyK9doctsSs7XeTFuIwC0drjkDtNBNm82tOKqCCW7tDjtk8ZGxaNWAEafiySQXwaKfX+ZCGAeMMZBV6r6ZZsA17+B3
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(29502001)(86362001)(316002)(26005)(66446008)(8936002)(64756008)(966005)(71200400001)(66556008)(55016002)(66476007)(478600001)(7696005)(2906002)(9686003)(38100700002)(5660300002)(33656002)(66946007)(110136005)(6506007)(76116006)(8676002)(4744005)(122000001)(52536014)(186003)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gwkwyeLiuHPB0UMFBv7mwhaKjBqc1F96QcIYTi59gy+yniFe1tV4Znun6/ZR?=
 =?us-ascii?Q?7sTQb7Susp9FWbFc5R1hNTKsDnpPKXFeTxrpxtdTXopVi/EAMYG58iI81s3B?=
 =?us-ascii?Q?z4Ln+lWCrZE4459Dpw4sKzxg+eSFoSdah+G1nNpXm6HcaCzAir6hnRkaP63T?=
 =?us-ascii?Q?YpRgHXN26aPZuJdR5c/PwUY4+145eKTgV3UauvkyRGwgK8tO4UGpv+M9+O+U?=
 =?us-ascii?Q?CyJ9Vlnihf4eGjou5DvRACw9LP0LwaHCwL8iT6XmatUBaO/zCLEZpx+ahZL3?=
 =?us-ascii?Q?mE1eRdfta/VN8a72KdWfKqbjO0shWQoUtfx6WU+YvQzzak9tnAafOM38BXcy?=
 =?us-ascii?Q?HtoYLnmc/PJPP588E3gzWMrZOWLwrKUTEynqvEP5kRyPBc05oAPKCQolJ1rg?=
 =?us-ascii?Q?qSiGKCcIXCCqcBZiUVUb/BlndJdfGUjuFQpw1W7VretCyexGVWJjaK2sHi/H?=
 =?us-ascii?Q?flZI5FLmyVpWpCMjY4zfMYwsYRwlHGUhGVthXhnXXJRdFn2DG7U761/ZWwnU?=
 =?us-ascii?Q?SJIPtHojF0bbeu6XY6UdSNr6D9n2n4I2jDJQGUQzFkuFOgRcXbYz0msxchAU?=
 =?us-ascii?Q?E9KF+AG0xezTq/haJ56Cp/rV+FYKEZaw2y8wkd9dkgfBIOSdVZ8Y2Q3yx7/N?=
 =?us-ascii?Q?g04gKVN0X8jtXumfwaGp5xdgrOKvBnrjTpw5B7e42w3cKb96A0YzKf4bNDgd?=
 =?us-ascii?Q?pai+ZyDmy0Sy2TnUdMEiSQPVaCXVO7iyVqP383eflKhx2OlYGdFYt3MoI53G?=
 =?us-ascii?Q?rD3zsPJX4C463+U0aFUnQUKDMoB961j0Wx5WJ9SwDKEZ6b88ycUoGCAXFGnu?=
 =?us-ascii?Q?+MbRUkTcn3bXOOZbq13owtCK0BY3WXh8PYJX7U2OAoM1XNdzi91l8UXAqh37?=
 =?us-ascii?Q?Zs/zW1LKPoFTZosx3yYnPftX9BzxwgV5L+GZKr3vbgFEQ9kAypMCNauIP2Py?=
 =?us-ascii?Q?SpsiTjxbGMBuV1baDGDYK69yIEWCYgF/eC+2Iid2tgPkMwb+zRKtkJxDr/wb?=
 =?us-ascii?Q?8+ZnmFfdjCdYYBVmB0SjYyuud9o8dXGq9pTfBbv85YrfAutm++n7Z/VtIFIu?=
 =?us-ascii?Q?lOL8S33z8eLRl1NTEQDaEPIO/UMg7voG/u7nSsitAGuPqkp5C63QvCsko5My?=
 =?us-ascii?Q?3x0OXa3MasRQoiruEedGg1sw/v2iGU7262tOSb2TppcikJ4Kff2FztVEonY3?=
 =?us-ascii?Q?HGiCMyNldZLV6VWEsf9SvBy6LdzqzxoVLTKMhWlwcXcyn+ihEIIi5BntwF6n?=
 =?us-ascii?Q?6yyDXoexZ8Py8Kf9Xhl320FJhMArqxfjvM5GlZiO01o7gL+F+JB3NmlfMBiI?=
 =?us-ascii?Q?O6cycNRJbFPEPyuUscDrYT4b?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3902a14e-ca88-416d-7f9a-08d9486b755f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 15:07:41.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bg09ta5q7mte4m4xWcbtv+/GT2hZQrSTeowmtjlwkxa0BGKiOiUyjVebAMOGpS/ywPMePfRVcA+kzxn0MGAAUgg9TM2Fkxp36Xq+xosD4ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5549
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Mayank,

> I am getting the issue that binaries are not installed in the final rootf=
s after
> executing the build
> using bitbake.The do_install function executes successfully but i am not =
seeing
> the binaries
> in rootfs.How can i debug this.

The name do_install is a little misleading - it is not installing anything =
in the rootfs. It is installing to a staging area. See https://www.yoctopro=
ject.org/docs/latest/ref-manual/ref-manual.html#ref-tasks-install. To actua=
lly get something installed in the rootfs, you need to use IMAGE_INSTALL: h=
ttps://www.yoctoproject.org/docs/3.1/ref-manual/ref-manual.html#var-IMAGE_I=
NSTALL.  See also https://www.yoctoproject.org/docs/3.1/dev-manual/dev-manu=
al.html#usingpoky-extend-customimage.

Thanks,
Chris
