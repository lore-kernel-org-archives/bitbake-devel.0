Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36911C433EF
	for <webhook@archiver.kernel.org>; Wed, 25 May 2022 19:37:38 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.11237.1653507451320165428
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 May 2022 12:37:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=IbQV7pPW;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=2144bcd68e=david.reyna@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 24PJVCXh017630
	for <bitbake-devel@lists.openembedded.org>; Wed, 25 May 2022 12:37:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=85a5DPRohXPvlh0u8aG0WGu3LmyEc3kr2UMg1Z+e0zI=;
 b=IbQV7pPWmnabpGNFI5A6mzfhKdVQGAYOcFFE10+V3UIvyI18CeagzZghRHr0GESkFOzC
 DO3onqa+A6FHq//keAq9SEi0s/npHaOunw5h5HsYjwgte5qMAZc3pFbiFtZ3OoXb7syZ
 /+1TEBaEZcUfe3HFwk7VJOcz+Z2eM7bfOIJQ2fYhJKR76/j6QswvJlaDbB7+SQNMDcNX
 re/msg36PMLLMxWb86BFaEhszyhb8aprxNWl5ToUrX7lipO5eDfYgtz2+8wUCvgT+oA4
 D2mLqDnokzSArfrbmWLrN19F6jVf8LJj8lVJl04rwieIuISn4IqmckkzBm20O77ZJGkY Tg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3g93u9gxub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 25 May 2022 12:37:30 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24PJbTqt032570
	for <bitbake-devel@lists.openembedded.org>; Wed, 25 May 2022 12:37:29 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3g93u9gxua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 May 2022 12:37:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik5Lj6KaiP8zy4YLBuBO8MeJUUSxDHPLyhZsdA7RbyS94lhlTHeQxepf8lY7vijCeK+C3N00C4X7xNtyLNeb6Pqg1vCp3VCdEX6ZdukZbriXX99DksfAVHr857yhTc3gm4ddkbIWCvatR+mvqg4pjFZGbgM8UOC+h/wKJzrurw6yRZlmFRiThDxrfbfaBA765n77UK6eGkrkuHKNcZym3Poh3xFP/UcSPSvHAWnRTQeNKe0D6uo7jPpSVvc6UqJ2Ky+pjdHk1c+wXEXM3jQFZlErJgF3ZLIuyC+jkiGysXMoDF70dzAZMYhihpUJzAVEtSUr5p91YeSdcggYRXeRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85a5DPRohXPvlh0u8aG0WGu3LmyEc3kr2UMg1Z+e0zI=;
 b=V4S9GZjD5D7OTS0VUqqx7Qkhi73GsMq+AvEIxMIiYMP3HS36I05ZC4F4CBocRBP8ZQHFS389y160XO4mxqP6gc9WPKEzW64ILaXFHMklcAJx4Vx1if3JfatSG/K5foulzK8hjkFWiCcs+Xs8Js1Lr5c4EQCx31IoFNUObVR4HNtzP4NuoBGy9dA+UT/Ln6QduiRrRnq71IJEA3PhLxr9IpWfIqyHiM9Eq6AgTBhmMGqwZ85Txxgh03zuZO2BbjgRiWhBnR91tabww1WWKyB+fIo8Ww2oyYEAjj/54W3Y0qPED0IokQy593kxDdRiWARB0gRMU4Q1g+8WU6Z4wGbxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 19:37:27 +0000
Received: from BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::c435:73cd:d87c:dcd9]) by BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::c435:73cd:d87c:dcd9%2]) with mapi id 15.20.5273.022; Wed, 25 May 2022
 19:37:27 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
        "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of
 taskexp.py
Thread-Topic: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of
 taskexp.py
Thread-Index: AQHYcAAg2hkgHn6p2kOfI9sjxM8Ye60v8V6AgAAKuAA=
Date: Wed, 25 May 2022 19:37:27 +0000
Message-ID: 
 <BY5PR11MB4167CBD5CFCAC739E65B50BFEAD69@BY5PR11MB4167.namprd11.prod.outlook.com>
References: <cover.1653448549.git.David.Reyna@windriver.com>
 <b17960eece2c4985b066539792242c23@axis.com>
In-Reply-To: <b17960eece2c4985b066539792242c23@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a088a940-b1a4-4684-9b97-08da3e86000a
x-ms-traffictypediagnostic: BN9PR11MB5228:EE_
x-microsoft-antispam-prvs: 
 <BN9PR11MB52285709A2CA33323DC9FDAAEAD69@BN9PR11MB5228.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 j5U+OBn1CCSU3DOJrnNv2cM98wruVzjdkwiez9jcdlrv8kXe7j6mpZqcY8apJeJ8ebthhUnouYaf7u5Hn3v1ClJg4nZcbw3FDfl6KJ9yyqjD2Xp2fi5QHqk9UBdFDIaoxiTOky0lgpSX59DglLOfgKmE28YSvVVESNtqQdk3EygUIuqMEJJJBDeXnSOcKUT0HXYOpaZ1g7tnMA/u1QLuLzQbltO2RzgpzESAmTyUs++ng0SkW+osMa9urfS5h4J2+Jb4p8DHpkmKZxl8hbjtFzN0Qg/IgfAzp1ky2TnPF9PJ3kdCTXVXWcHat1nRSzZoFhZRfAKqHXXvskthqwHkfRCdGStIJ9IM2hkLEHExq08UZchFwXK38cAFrQUGs3tGnLBW5LcVct6ukigbUUH5/eAvDlSPpg263wznMZMn4lZyDxumEO5JBuzMSSMITCRJojs0h6k+Yvyt6NwK/ruPWrJq85CKO7gh/o/QC2SQY44RlTTmuKGNZgxUQGD8qtzzmW8g830ItVz+wJn/SgsIqcU0A2H0stF/fs9ueslAf2lb2WUBTMhszi7mX4iOn+X4EMSBcs74L5HuT/GvERSizlXHHBo2MU0k/lU8nNLLR7rcFabfJAJqdvnUbNLrVxWgiARcFiRMkTLOmfF1440/BM+BR3uieG23zsnAzHic/UiQul8jxLppLoHpDdi/mctArCJdTs3W2BAHHAOAO8ARBQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(53546011)(52536014)(71200400001)(5660300002)(6506007)(64756008)(8936002)(66556008)(66446008)(8676002)(316002)(66476007)(110136005)(7696005)(38070700005)(86362001)(508600001)(83380400001)(55016003)(186003)(122000001)(33656002)(2906002)(38100700002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kUAQWLwjH0dAXOhsehTfhw+K9Wy3skRnenFHp7yo1JAH8q85XzLYvlwZmyYu?=
 =?us-ascii?Q?5IGE653n8axMs2DKHobjaEbLprplpUJg2c7yGBKqgXRj7no2QS5H+VyUrJ+s?=
 =?us-ascii?Q?Yz3SsKcQrU0U+MdYNR14OuQ2r7uhDZBOPIb6Oh95PB9NOX2pnxhYOCF/UKer?=
 =?us-ascii?Q?xKEUEMkmwgVkvug9rXbZcpRiEeQGRGPnLLXSxoelV6IjITpvY3pW2Oo8Wy5T?=
 =?us-ascii?Q?NVqUKBgxxhMYR3LsUOwQaNfX9/4GupFJ+P+YA/OdRboasGfeXEd3JFFfDcqN?=
 =?us-ascii?Q?8/nLxMp4SaREbCfO7p/lvd+KS5hiLAdkDeBpEkLSjZFpPT1JoZ60OzMLsBC6?=
 =?us-ascii?Q?Y2Dqg67CBfYX+0hLFf4tMwPzg+J9eLa2RZCA9FDO1uXTEbyKBqlZL7ccEpwV?=
 =?us-ascii?Q?aDxWFb84lMyyqlh4NbWMb4Br5dh1lG9f2JdMpVNEk9NyQKEpzeZg5S1Cyb1j?=
 =?us-ascii?Q?03VSSXoFUxBVizhP8H8goP7kzzjDDWZDrBw8o1Ei1X/jZa7e5qRe4kF8jvj1?=
 =?us-ascii?Q?v9IILotDcdniVyIriSJ7CtZDS38U43HDkQFTXAO5Wo7Rgg0rPi8cyH/+8NxN?=
 =?us-ascii?Q?B2cd7s7PD5P5ik2g9RJdxSyNLYVCNuffWUAH9CJf7AVdkMIbM++ExRmjEpGl?=
 =?us-ascii?Q?daq1xI5wCjkVbIIeK2UpKPwSVWtTdAl0o2OzPPRyGAb3i2jMYE+VTYOFhO6m?=
 =?us-ascii?Q?xm4iOfEJ0cFn/yq+85raNslb3Td7dYIVauq4WUly94QLqlHItaDkj1FetnlO?=
 =?us-ascii?Q?WuzDgeVLr1OWhRfBY424s5qMwSb4P0SXHXEDjLUih5N479xcpzOcz7A+4sbj?=
 =?us-ascii?Q?Nb6KA+t4LnoLyVxgAcvmgIi/3uFFZ7FemybT7xlgucYWU/OO9Tj3iNKkfAZi?=
 =?us-ascii?Q?FpScxTi0lq5jAihw8fBWheNX2baLj0hXsD2ANZRjT7af2DTzdeTz5KbEiLSd?=
 =?us-ascii?Q?J/vf8bMvYQ5BSRwi5ckjwNwu98dN5/ekA6vtHeMGBTqqHcJ+2lc2W1EM3S8I?=
 =?us-ascii?Q?5ZIZBqP/5WT72Hqtxt2G21s+kzHuRHlBeVTk3HDnQzZS/zPkV2rEB8A8s3kI?=
 =?us-ascii?Q?ydgyT3/nDlmF+/l8tNophZVgM3w52FISTxIM/UC8SwcHhs2uoxzdsgPzc9DY?=
 =?us-ascii?Q?gQ7+MvFntFW3ngUiThSFZ3GhrdrA5UPWEGNDu0AYd42ZnJtpvCyUFBChj2dX?=
 =?us-ascii?Q?nOgH8FIp755pz5Ye5hy6m2c3XbqAT9tRdPDGubyR2qaDstezVdiInU/uvoQ7?=
 =?us-ascii?Q?y8nTTUS3ndw7jReEkzjvSr1MVXU69kha8lbiT4uBXLix8ECv3AyET+6/CzGP?=
 =?us-ascii?Q?1AVfI5lCMzXo3ir38iLakdSDKivHv+7sLyJYPCe/7b5H9GqBHIP8En7zutRb?=
 =?us-ascii?Q?9eRbYl6lYkBzuTy4Nz8cLCTcDVogYPdGrck4YUid/C6Tt21WOlKLVxxdyPQr?=
 =?us-ascii?Q?Kpl6LJ5InjnSVmZ03inCoXojI+eVIf1iYWrUnvuwWxjHrB7WSKTPxRljFVV3?=
 =?us-ascii?Q?AKyyXpPNI27M8LFyge/wnYU5LZmtlY/fmjaR/+gz7aEz7ypNli+1g/yoM2FO?=
 =?us-ascii?Q?lR0z2aNl8NLsRNVRj7wMG34D5GP7pd5HVWkrXKMb31n1NRUFLCjMCToiug4B?=
 =?us-ascii?Q?IviIB7YW0EjJJK4CeiPd04vdoRS1bjpgs4Kf1KaZSOjjPbeRXv/x2ovQmyfl?=
 =?us-ascii?Q?PucbryoGmhswZ9gIwFhCwyuDBo39MnxEAY1f269JF3HhhIJT0JtIKUr1xYaC?=
 =?us-ascii?Q?qnnNjqWCxDU5UgcjvZsXBrO004n1DH1jKZX2KohoFSqiFqtw9QwO1oC8ecsN?=
x-ms-exchange-antispam-messagedata-1: QDa4gOvp7+GA4EV/p6dr0nblmAM4b5GsInY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a088a940-b1a4-4684-9b97-08da3e86000a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 19:37:27.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 dpUTlyOtMVJ9G3mMgjif2cLg1qwNmsWInqQRj37V4Lm8jE7ebnlaVfTqrlvGFT7iVz75a92QJohDCh77o+j1mr2SSI1mMTN2Ir0uUnWTJCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-Proofpoint-GUID: mIvPLGbiIuOnIXbBBUF16t0M3VAhcvmQ
X-Proofpoint-ORIG-GUID: RFf1eyTsr1zqn0V-CyJIYeM5D-RFEWQZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_05,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205250093
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 May 2022 19:37:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13715

Hi,

> "May I suggest using a name that does not include "cli", because as I see=
 it, ... may be something like 'tty' or 'ncurses'."

I am open to a name change.
=20
My take:
   taskexp_tty : my preference
   taskexp_nc : short, but not memorable
   taskexp_ncurses : long name, but accurate

David

-----Original Message-----
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>=20
Sent: Wednesday, May 25, 2022 11:53 AM
To: Reyna, David <david.reyna@windriver.com>; bitbake-devel@lists.openembed=
ded.org
Subject: RE: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of taskex=
p.py

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Reyna, David
> Sent: den 25 maj 2022 08:25
> To: bitbake-devel@lists.openembedded.org
> Cc: David Reyna <David.Reyna@windriver.com>
> Subject: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of taskexp.=
py
>=20
> From: David Reyna <David.Reyna@windriver.com>
>=20
>=20
> Added since demo at YP Summit:
>  * Protection against window resizing
>  * Line art (with ASCII line art as backup)
>  * Additional internal documentation
>  * Tested against misspelled recipe errors
>=20
>=20
> The following changes since commit 13d70e57f8693e506aada946ae9b2e0997e4c5=
f0:
>=20
>   migration guides: release notes for 3.4.3 and 3.4.4 (2022-05-24 13:58:4=
7 +0100)
>=20
> are available in the Git repository at:
>=20
>   git://push.yoctoproject.org/poky-contrib dreyna/bitbake/ncurses_taskexp=
_14814
>=20
> David Reyna (1):
>   bitbake: ncurses version of taskexp.py
>=20
>  lib/bb/ui/taskexp_cli.py | 1302 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1302 insertions(+)
>  create mode 100755 bitbake/lib/bb/ui/taskexp_cli.py
>=20
> --
> 2.35.1

May I suggest using a name that does not include "cli", because as I see it=
,=20
this has nothing to do with a command line interface, rather it is a text=20
based UI. More appropriate may be something like "tty" or "ncurses". Or to=
=20
complement "knotty", you could call it "tetty". ;) (Though I guess it may b=
e=20
harder to remember what that does compared to "taskexp_tty".)

//Peter


