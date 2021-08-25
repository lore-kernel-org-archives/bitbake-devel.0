Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.80])
 by mx.groups.io with SMTP id smtpd.web10.16692.1629905262536990175
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Aug 2021 08:27:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=o1eKc1tg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.80, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvR07w7AOhaXZ7PDU9xs34V1yvztGBL6sLF8T1W6zhFgXqoSpZu/doWYTFwb4TCQJ9JJpOwIcdnT39zxul3TMSS6/POUNi5Bq4P0aofcKwXstXymfPdX1AV+D8pKPTkr7WIyKye6VQeIRgjLVZYM3/BBXPusTqju1BA/6C5z9nAI0C5RSYJhjPTPAEoge6OtkCQPfqTe7q/HT0FcFziEtREp+PO+dKsTLGiuPjsYX3nhHL67JPDTRzU/cgzHyMaIc30VdqOBmm2T6cGpBaLf1PfxslAgeTq0rMXhjZvlYUMLip7Rr1IYWJgqJc2EhHJ+5mEhKz21aU4B8/u1T023SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qTVL5VnB4rzTlvuRjlGh/MCOzFpqHFJinA0vyedTAQ=;
 b=j/Ljnhd+lLwvv7WcIu9XflgbUipxijkFi5XJuBpiwHmsengw7QLjgsIjQY+Wgo3KsMKUfFd8b0fEvLiMkqpIk8V9uvxdKpstbdkNbPyKwDRcjpQP5uSEFRw6vdbXNj09DPV1g4x/ShWJahQNHfXTQsSn7XhhmHCG20l98JTNAgc54wQmU3VLWkuLt5WcrMfL93QM3+C+UA3/qMvw+VNZ8PovSXgGy0Djb/Yh/67ntDKdGYY0fhSemriPe5HlDQvtzfj/9C4U9zUJgmWBw0c8/St+tmmyp37ow+oiO20KKvxvmPGflbEXn1hS6ZKeI8203UzjYzWX57xyIgkcyyMfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qTVL5VnB4rzTlvuRjlGh/MCOzFpqHFJinA0vyedTAQ=;
 b=o1eKc1tgg20LI/Q8Q2L06mbs7/O+gQD5IauShgTScx7W1WTFGknRES4QFvxkAsXvyhcAGd9NDfOJJZAzM9fYqUgFR8DyJgJTl9/bZXPuH0avcpBgLL2KmYWGhDB7deRXbZ7ggfVRLocPFTXFFlU3TMIjYu3cxn5H4jEGc2/J2Z5Pg3HsMOY7tfbBojPRQiee1fSTKvtl6rxHRZd8CJWDSwMHLDdotp5h6qxrb5OCuV9LZwx9aI55/wtr72h4AILaYrBO0VQE4zREsStetsyeGRWcrs4JdVfaT8M2sULeX39f6Y58Wu+EHTW1LRpaPjcTQQY9dwf7akx2uSEAjOUhtA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Wed, 25 Aug 2021 15:27:41 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::d02f:e1ca:887e:6000]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::d02f:e1ca:887e:6000%9]) with mapi id 15.20.4436.027; Wed, 25 Aug 2021
 15:27:41 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Trouble capturing layer revision as variable in recipe
Thread-Topic: [bitbake-devel] Trouble capturing layer revision as variable in
 recipe
Thread-Index: AdeUY4xdzX9x5/pnTMWcL9zDPNkTqwAbPvWAAT1EtzA=
Date: Wed, 25 Aug 2021 15:27:41 +0000
Message-ID: 
 <DM8PR12MB5430C33E152645FD5498CB888BC69@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
 <20210819080219.sd2huy4uh4vpniwe@fedora>
In-Reply-To: <20210819080219.sd2huy4uh4vpniwe@fedora>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: theobroma-systems.com; dkim=none (message not signed)
 header.d=none;theobroma-systems.com; dmarc=none action=none
 header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c1be763-6609-482d-f4ad-08d967dce116
x-ms-traffictypediagnostic: DM4PR12MB5296:
x-microsoft-antispam-prvs: 
 <DM4PR12MB5296BAC4800880152AF92E478BC69@DM4PR12MB5296.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WrFeFKjQ9l0B+wcogvs7+aHQw9JSWUNe9U/VFwT04d9NbxME8DgzJKQ9vuV5P8TvW1RYAWAfgMCG6F3veamYBy/3ABGMG2KMPIERkCmA6I5wSz4vSRnUUEk6jFEDC/zviQRsCfDIsuahQYNB1fPDDJxFeuJijgcoUGUh8McWD+IbJMAn+YeWWm0ae6g5Y4VndS+vdOAmZBR3z+vmT3iv0ZuNzQdkPNWjW14LnAsul09DIP6m/4naBaQn4O3BCQDLj5Kg+LmwLt2qYciaxss0WOgwLiL0ECNK+7d4Jzw0NHLvXSWiOR7EQ59oljGLCT2IJKEJasNsYmiqV4mHnWGKiNVlgwzj9JP+iid05UR19BXB8gmJLo32TbDOjCy1ZSBCV3TUDDW8qvkJOvgkiEt6XLCQcvaOSFWDjV/5tCpNUcXTAoHYSEXyyhjWygYR7bm3MfOvqIstYO1Z4LJXZHBPOUf5NLZ8GrSyhLG1jP2RGcEV1uBy/kO8mz84vcOuP+HnYatEUG24ejv8KbBb4SjrXRmq+x6MXwQdb1zRkBoVGnL6ec7hRMAdT/QPAXnCg6XK0XAjZ10UhzfexIxyZaIAXcO9R3as650rD0InO3/zUXRVYBmsduyUUODYhhyNs8hrKXppD+hbPOBTJcv2iwewL6VHbyUn/NCFKRmVOP+h51zt0hc+n8cD7IKaGcOLuZUU2ovime3YDYJYXOA5nHgfLTFZmd9jLIe3YZZTwg6w0/wPdvWqWvdXU0k3ItuxqIyf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(29502001)(6916009)(7696005)(316002)(4326008)(5660300002)(8676002)(38070700005)(66446008)(64756008)(66556008)(122000001)(66946007)(66476007)(2906002)(86362001)(52536014)(71200400001)(38100700002)(33656002)(9686003)(4744005)(8936002)(186003)(478600001)(26005)(76116006)(55016002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UlvOcUxg8txyiw5pHFigMf0xWwt27TO7gjlJNKKI/RquKL/QDyPusZwEiT9+?=
 =?us-ascii?Q?YKETG81yy83JU+hMge+1LmXJZuqnm/yG1r7h1AMTGp5g0N6QQM0/P/hhv9kq?=
 =?us-ascii?Q?vM8GeGzSAQ6ha0y1VzyjJNqyGVniuAMtwepfOviLs1fmBq79qnyvCm1s26xc?=
 =?us-ascii?Q?oPahgcnH+f9+ZScUXPtLRNWNnhx/8Fo+Qz0Gz9tyYNoJZ5O7fIbDKuLGMcma?=
 =?us-ascii?Q?Ku/WgPKrkOOXm119agqTO7xQDBbvndsaOWWJlnlvCwwXiVleLYIfuTZbLlOM?=
 =?us-ascii?Q?nPq5AyOmUArs9pu66FBFd5NwIkUEkoP0c9JUjN323zRCMyLmOLmUs7WdY2ke?=
 =?us-ascii?Q?+qjywqLEiom89kAxIIDrb00yXvMe989T5d/6y/gqnnZNKXU2bsJevRI854WQ?=
 =?us-ascii?Q?leFgx2Wxm1Ixb0r1cNqUHjwKdVSBY4Z5iONVp9ADkr1YgMx+jDXydemllW26?=
 =?us-ascii?Q?jDCS2jlvvGQAjg2lww98/unPq8wUKTAt3ZOd1rhWYhTwdRp8kHacpVeMLV8d?=
 =?us-ascii?Q?pT4I/Ts8m80jrKBl7qEA2oUB8eZARTnyX0UtA7neHkTzv4k7/jTUbP8uNbRM?=
 =?us-ascii?Q?CP3zN5tF6kdK0xrVCX0HXBnEP00b87BsG/am0oOT6qKiIRSZ0QVoH8sSll6v?=
 =?us-ascii?Q?lkGA8sIr4prIh3jyFkmyoXpxjrd6PT5uOFTD5g7a2dJ+zTwEQgu3qXsErAL/?=
 =?us-ascii?Q?kN8piB4vNwoDjHhqqvb3i2CZPs9m1KoHbAISjLJ0nZjIwEKr3KTbG3DWmO/K?=
 =?us-ascii?Q?5vzlGKNj7vjQY8VRUH+resELprwG3B5x5dFVGYPNRR8dJNe8c/Yk2fLSx4he?=
 =?us-ascii?Q?cEoLD3Oz8OZS9l0jeonsHriHpzYDRVAytb5fY9uWefG2JbLN1vdbRfVGb8jV?=
 =?us-ascii?Q?0O4AuQZxXDhjbjVieq4BonJGnwhi5jJuOjmTK7OVdSrzG/T3DHeAOawOdj/f?=
 =?us-ascii?Q?e1HxeUELrOHToyLlRS9s90XI5ISC4UvRXYBB08qAKFcJZvjlzwp5K3aVUe29?=
 =?us-ascii?Q?QdgbDDlxvH92OO6+PINmHTzyDm08yljZ/uQ9RI3iVf8+psIi+H5svAH63MGV?=
 =?us-ascii?Q?1K+wcYotCzZFvrp5eXPPpdpwuspZk6wO5IbQEEGPR+nADb8MIZi+SeZynHmi?=
 =?us-ascii?Q?1+eqB50l5TJeN4nPJtvjRZp0YoNEOdx5xrMzr977bk0j3e8QpM4kn9QCGQSc?=
 =?us-ascii?Q?0W4GtKiMfTyKobyDdj9Nh7o2LcXLDPWEoQ32Ozo1PmE8cn3DeLDwEFOolJnL?=
 =?us-ascii?Q?NEUVHizC5UG+aZ6KwBk0tGzZAsMqT7wjyfR5fCNjWoHm5n6dFKTWYs4wB1lJ?=
 =?us-ascii?Q?a3BcjPVKm7+Yg5mZFGI8reqj?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1be763-6609-482d-f4ad-08d967dce116
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 15:27:41.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61mnG21rKeyDsYOl1gd/3VeU1eQ0P4rHCflsA2TxDFVF3IdeXdJTFqi489jtq1R+C8MCDxV/vc0pZN8ljMukplxP/TzQj0fvLi2YsT+dfp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > OUR_LAYER_PATH :=3D "${@get_layer_path(d, "meta-our-layer")}"
> >
>=20
> Maybe LAYERDIR works?
>=20
> But for sure THISDIR would work.
>=20
> So just replace cwd with d.getVar("THISDIR") instead of the complex
> handling since git rev-parse can run in a dir different from the root.

Thanks, but one detail I left out is that this is a bbappended recipe. The =
bbappend lives in meta-our-layer, so LAYERDIR/THISDIR won't work here.

Chris
