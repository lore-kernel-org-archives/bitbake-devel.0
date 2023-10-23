Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E255FC001E0
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:31 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.63])
 by mx.groups.io with SMTP id smtpd.web10.122848.1698073346789642329
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Oct 2023 08:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=P3sXVEwn;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.212.63, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy3tY7+YV8uo8EopR9zFBj4QiZ8eA12mjguCYGwNlx4fanvZWNQnKeaKhYfZ66nRa1LZYfmojGI/ijb8UxF36WY/q5rv0W3IbieocbW0SOerOrzSS6P+/h2Imt/AmzY0zM/ZQCJN5TERvNL9JHhRzay7azd04Ps8KFVQp1fITF9jm/poPVsGLTrzLkS8nEUJxSMxUU0K28uRb0HNPeXGZ8DjgMkyI4GNcNRqjFXwpk5VK1jp2YQxvkAFHb+BoKt+PB4Ph5cPzjT7KxqganIi2ic8zWHw8xiosRJAy6LZdCTTuhc+rQVLv/qt7iigfbLXAODjxUkK3KsWRSnzew6Spw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiP+5TTNY9H93AND8SJd2QMUNyqOV3vXpR/spItCc/M=;
 b=d0gnhoeUATqIc7pxcGQrYTW/MrRkGgTsPOFKoAF00AH1uosJ13Ie+ET7gJxcHGoFx3nfT3Qkn7CusCXpQEXcKMJ+vAeLVs6VdHd6tKAEDHynXoCZ0KrNjedR+apMNkzwQ9GqUN2LgdbOWjEwrOqCcxoeS2cY6ADkTyRe1z1on+Y509SUWduNs48lU/ot/yHk2KS8j13HH0+buSvgTNLF3uxxVnJLAmwY4D43moYTcG1RW9U5f3zahgZHrJuw6dYzSphPuxR2QGobRl4gnjI8zVwz+7lgzJ5VDJnJDMBZ6uWdtf1GFUagNfo0Ognvwd0559LsCXHyv0MyVX8XoAX+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiP+5TTNY9H93AND8SJd2QMUNyqOV3vXpR/spItCc/M=;
 b=P3sXVEwnabi0BnTfqq6mPikY/ERJ64d6ap/Q9+199cRRvOKUwlJTGSmjPqhWK+iZzo/45tB0ybB2HnPggmtIThH0DqauBCf5RGq0989UHJm/IkiNkv6/3e4rcYxadvbxwNKRfp1mFLw4oW6WIys+y5as37ZeV45dJIyXUAlRGViH4ZUoAJeKbPEsAAxh2EafAUo7nCnbNSBaDAe0YxaUv9sGPTl9OxWJ51tZfUbZU0lQBwsk21ztOTloJFkCXAwnkDehY20aJXb8qjr1DCwXxaf/w2Fa8wfRn/setwipYi0lKoQ2dzmCfU4Hz3FNfqMplO+71AD59g0fAcco8tSqxw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 BY5PR12MB4903.namprd12.prod.outlook.com (2603:10b6:a03:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 15:02:23 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::1e30:3574:8cbc:7278]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::1e30:3574:8cbc:7278%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 15:02:23 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/3] codeparser/utils: clean up more
 deprecated AST usages
Thread-Topic: [bitbake-devel] [PATCH 2/3] codeparser/utils: clean up more
 deprecated AST usages
Thread-Index: AQHaA4WWlWH3MzjuuEyVZPlnAXHK1LBTU2+AgAQpQxA=
Date: Mon, 23 Oct 2023 15:02:23 +0000
Message-ID: 
 <DM8PR12MB54309ED942CDD6873DE313A48BD8A@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20231020184459.1420806-1-chris.laplante@agilent.com>
 <20231020184459.1420806-2-chris.laplante@agilent.com>
 <20231020232915d8ce06bb@mail.local>
In-Reply-To: <20231020232915d8ce06bb@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=b4ffa08b-185c-440a-bc98-243cae7efe9f;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2023-10-23T15:01:58Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|BY5PR12MB4903:EE_
x-ms-office365-filtering-correlation-id: 890ccada-c898-4a4b-be08-08dbd3d91016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZWaLFj+kO+U96cNXKMp3BPZ5mUmkMq6Xrh5P90x9lKNjeUsmU2OJ1FccWltmHZxrotPxrUt/4UsKVcMDEFOO5BzgxnLEKMRuDYtpDxibqCuh2YhiLm83V+MHvJu5jzrYESOZLmb5YTBsrlYA9w8Db2rTK5Dd7m4Qokx+/oMcydiPOaA3i95PwnOn42M0stAxnhsxNonQPwXhOD6KC/lAXIP1+sP2b6bdg8C843gvMkeFX03P3Hy02WbZbkIwzPgrUDOEMkhCqgzKj+Uqcl22zeQ2gVHZERWiw8GrdKUG2yEA2IqEiJQijx8/6274BTPSiXfMQ/fuun1Ntdpiv/t+0vsnO3cZAeLe/EyU0lkiHxZi10QJ7viHnfTh5YIeAVdtxRMBCYpx9XtGchQuapcZItn7ENM6iaxc+CaTMLmEBONwyIaOc4MEOYO2tnUks3I2f0Dh+gZYxtyhuB7bnDq78dyc/Zg9FZU/Ek2bAAqrdg5P1UgdKKjOi1WvW4++NVn0EqVFKLZf314Wa9SJK6QPVndB+NIm+zrl95LUxolvm5KLU4V292QQOVXtYQK0LbOLdl83gE4AzXiVeghxwt8kogk/u2KTGzXMHJTmPXB7Lqgy6G7gwdPJwPcoRP23JyJt
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38070700009)(38100700002)(2906002)(55016003)(4744005)(41300700001)(5660300002)(86362001)(52536014)(4326008)(8676002)(8936002)(33656002)(7696005)(6506007)(71200400001)(478600001)(26005)(122000001)(66476007)(66446008)(316002)(76116006)(64756008)(6916009)(66946007)(66556008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DjlalQLjas7qorDW/MIhHYoxjBKY2I4icV6hOxluHGdKrKAsSQVhVtz1CvF2?=
 =?us-ascii?Q?lHooaAz4vLWPK28ANPV4/rHZsCoOYfcMOh2FZVro6ukyR52wu01cnf22GP3Z?=
 =?us-ascii?Q?Hngn81ldFHISF+jUM/n134MTL3ItlLYZ1GtaJAoV9Ge5VpBIQwVNqOKW5ua2?=
 =?us-ascii?Q?Mj0LZm/zDG5jphIUVLT8p/m6e6rXtN2Pmn0K43gunY5Do9lnLpJ9wcdyfeyJ?=
 =?us-ascii?Q?9QT2p94JS606W9RzDN72mE4Qs+gUvGv1fvRJeG5+hVIGLT8FNWwEDelM2Cqy?=
 =?us-ascii?Q?mK7eOC5/Nuy7SKiTqs/xfQHxRsx0TcqF1iR87v61DHOGjd+Pbmg/0JR5MR6H?=
 =?us-ascii?Q?GK1Oh/JhahyQXss21bLY0o3R1NuhhcBZgarZYBP1gw3lifS/VtzZTK6pFaZk?=
 =?us-ascii?Q?MYIzw/EPVtmLLItx1pCRCrQ/jF0ZQS7DM6W3EZfszcO0TQzRLo8ZTWYrbIFI?=
 =?us-ascii?Q?npp/D5CUBKWcAmezJU7Mxd3ZKtYEjt6kvr8dHdRtBCZTOm20Amw1ldsLUkw5?=
 =?us-ascii?Q?VgXCwrZlOJFthBH5BwU+k0RQmOt6Y6Yw5kL79H4uyBlHb1gR1Pdf4PxmgBsF?=
 =?us-ascii?Q?hsVC2xJSvpP1nW+DC6lHPynAjFQOJ3bTvauTwbBrDF5yuELNZW1Dz3QxnJ2j?=
 =?us-ascii?Q?V4HBQKbZUMkZLji1IsQiD9M4jXWcDnR/c0fS2r3FPuySdii+BIjYgZSIkDqU?=
 =?us-ascii?Q?gZxDGYStlmFWpznqB5h4Ua30jqamsLvOKXvsQk6dah5bjsCjQTKElk4fVBUT?=
 =?us-ascii?Q?5BI3Tvn5VekGduB8q/NuziWVeYIqwgkIv7kOD4A07YSMUIv5msefXMdxqiCZ?=
 =?us-ascii?Q?7GV2WzjO2DGiYRgC7ibS/jJ+x/TCO4IHF1vsSBso/XRDuwzNiUUMUSXhqWDX?=
 =?us-ascii?Q?9OPvgemx4LvnXRPhm7CbEJW7E8WgBb6tVvo/V0EU2whYmv4TtRMn2SnVIJDM?=
 =?us-ascii?Q?A/48pw+69ipL9UdzRyHKxA8UCv6F6X0pl3S87abb2Bgz188Xc/J4IYcfEu/3?=
 =?us-ascii?Q?X/dLIVbdZlGmxzOTdmJXqEUrAmqKcIhuMb8mc9xqp5aq7SERmWFryVvcLTuW?=
 =?us-ascii?Q?DXJge7uDr8o2mWmEwo/OZj9XaUFaL4zjPV7kuxZIKRRKWy8K+EFvWTloXAnH?=
 =?us-ascii?Q?qeKGv23V50EMDVbPuhqxEiFpTAxMjXUeqiWMr/a6hP76iJhR6UsAwnisxRwl?=
 =?us-ascii?Q?V2zJyajRn21OYFgEtrpMfXEZbJOE+o5GbVXInme11z+4WhAn+JJdU0GXH4uY?=
 =?us-ascii?Q?h2NEme/WBb02dYPfEHpql4WTS0kMQMTu3kNtT4/TQRZGCDvPwZ1602SVDg5t?=
 =?us-ascii?Q?uOdsKdQjX0lCzjYTJIBQkw9/KYFgKyTl5UP+MfJDkLCHF363gZuYJ0pXHuoS?=
 =?us-ascii?Q?9O9AfUww8EaOTE1CFWQUUTvnvGErH1XHMM8PYJPVJQ4X3yd0rFf+oI0+rlyU?=
 =?us-ascii?Q?CUqO4DHfIKSe3FOjWDD2VmR/LXSoB94cNGsioYdOgwHwRBBe6sY2G50xA/wq?=
 =?us-ascii?Q?iZdNF4X/2wK7Srxq4FR+/fYEwayRuMd8eXZzTfPx6Z5SHKF6AJYmGpVS6ohZ?=
 =?us-ascii?Q?gvCMjmeeJUfinqNWz9tjrHdKkN2bh1/2ADBbEpO8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890ccada-c898-4a4b-be08-08dbd3d91016
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 15:02:23.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 379P5nt0F7I4JXn78lPv9MFmb3T91irEndzDSIth1jW2WVOwnX2JJoQscfCstX050pMnUDLPJOPueif3ct4EuhWZxSBeQduUjHCArcpk24E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4903
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Oct 2023 15:02:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15274

>=20
> Traceback (most recent call last):
>   File "/home/pokybuild/yocto-worker/musl-
> qemux86/build/bitbake/bin/bitbake", line 21, in <module>
>     import bb
>   File "/home/pokybuild/yocto-worker/musl-
> qemux86/build/bitbake/lib/bb/__init__.py", line 137, in <module>
>     import bb.msg
>   File "/home/pokybuild/yocto-worker/musl-
> qemux86/build/bitbake/lib/bb/msg.py", line 20, in <module>
>     import bb.event
>   File "/home/pokybuild/yocto-worker/musl-
> qemux86/build/bitbake/lib/bb/event.py", line 23, in <module>
>     import bb.utils
>   File "/home/pokybuild/yocto-worker/musl-
> qemux86/build/bitbake/lib/bb/utils.py", line 1868, in <module>
>     def ast_node_str_value(node: ast.AST) -> str | None:
> TypeError: unsupported operand type(s) for |: 'type' and 'NoneType'
>=20

My mistake, that syntax was introduced in Python 3.10. I will resubmit.

Thanks,
Chris

