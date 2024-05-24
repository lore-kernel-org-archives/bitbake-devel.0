Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF5DC41513
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 07:35:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.10659.1716536142246867109
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 00:35:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5874387037=david.reyna@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O3mhup021658
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 00:35:42 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yaa8qrjdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 00:35:41 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 44O7ZfUA006473;
	Fri, 24 May 2024 00:35:41 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yaa8qrjdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 00:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXZ1l6Ym8NiNuwp/VM0AOYofSBGr4xASSiBhQ0bEreKi4vXxjMp5uTm3BdUM8V5LtEq9VyIl0MVx77yF/sCM+dIUyKItZZjHOsDovF0JS7sz/txU1BFii3/2w+erWDy3Cxq/R2vJGoAZ/4ygZupGj3QMsQdOtudsnm29T/WUmZu9F2KY2hkNfxtM/9JmACLQts7ncGAHjPFsVzkh473mCKJtZWusYGJdxv6ZKCPNYw5zsXv9LbUHX6J9lmp3hqC2fM9v+sLNsqiVC3ZP+sgFFGVEL6JUkswXRP6m36EVuXQ/DtqUnwNtOm8PluQabC8Y7x2/ILD71fo429cSkUzm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiWVxPicYJPJOD0xqeGQE5xi2RG6uqXcqgp5+FRIzR0=;
 b=V0qQ5asYGc6iSRE+CSfXx6lSiDi79feFW0q9CIouRJwEIBQjlKlWuem788OnclGZ1OERVYwz1u75EF+naUIowWhQNLa74PjPFRa1335XiA23Rfm89qfIZ0uxn6qlqRQthbOmawBDLcSBsOTRiQtrwDJbrU8yrmUxR0Dw6Sv+Sv30L35rdSQs6qwCfBdtG6stedipyXRElgbjrmKFmN6zv2UrUnm0MCXRfI2oiahkeNqYlxaKEEeoOe8y5d/6mXlkwDvbB5gHEitWJphpin6GGozInKiABC5ERirIlDZOBPxEwyfEXFAQ3mHIGpJ+wWELC4zfAzd83/0w4RaPHdADLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 07:35:37 +0000
Received: from BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::5564:d9db:8661:d121]) by BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::5564:d9db:8661:d121%6]) with mapi id 15.20.7587.035; Fri, 24 May 2024
 07:35:36 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "marlon.rodriguez-garcia@savoirfairelinux.com"
	<marlon.rodriguez-garcia@savoirfairelinux.com>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
        "toaster@lists.yoctoproject.org"
	<toaster@lists.yoctoproject.org>
Subject: RE: [Toaster] [PATCH] Add exception treatment to fix missing
 target_file
Thread-Topic: [Toaster] [PATCH] Add exception treatment to fix missing
 target_file
Thread-Index: AQHarSFUIXBlMKI2/E+cdaMegkVjebGl/2ug
Date: Fri, 24 May 2024 07:35:36 +0000
Message-ID: 
 <BY5PR11MB4167BAB5319683E0C6F3A0AFEAF52@BY5PR11MB4167.namprd11.prod.outlook.com>
References: 
 <20240523145541.198353-1-marlon.rodriguez-garcia@savoirfairelinux.com>
In-Reply-To: 
 <20240523145541.198353-1-marlon.rodriguez-garcia@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4167:EE_|MN2PR11MB4677:EE_
x-ms-office365-filtering-correlation-id: 09d60510-d2cf-474a-9b5e-08dc7bc41a4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?r5s8+AlTZH2mIxXCjsaK5eNPFiswb04fS7zhXyi2JwOVmHaTc8483aheXBEZ?=
 =?us-ascii?Q?OEDM4iEI1nmfwE07eMVJCnLCOicW7wIecPFclRY3+cWjb/3njC2gSAyNL4Qz?=
 =?us-ascii?Q?KHGs7ogILaPhYp5yiyGoDfUEkuXt8YI4ol7nFdZv0SJPPdIAbKilmB82GnHz?=
 =?us-ascii?Q?DCQemTNfykzu673QeI5unepQPZ9ruhWZWJY4nyfs/SYeeP4Qq7csWfuZPxK+?=
 =?us-ascii?Q?9iEy/0vMXYtHYXYzgmuXPQGqPiL6SDHyw6wK6Pmtf4jXiO11hkv9moYgXTcA?=
 =?us-ascii?Q?BYcJgQOK4rIFqVjQQxq01SQxJArq6Y0xJUimM3m83utQf0SGiOQdt/2fuU7h?=
 =?us-ascii?Q?xjwSGcE/A2Oo48tdVnT/aefDCnyJRS9TQBIwE1A2OXJMf9xM8iJblAP9foVI?=
 =?us-ascii?Q?upCIqGJZNG/X4zCO4HoljKyzMxBAMadPOiyk6N8hkbW94ne9bh/4TDo2EovI?=
 =?us-ascii?Q?P37/IuSyN1aSjtrKnXJ/Xuks19ZmFqB6zELfTP+cTcp6IObJduXP3U4Sh4g4?=
 =?us-ascii?Q?/fUIem022Fc98Zxvbx1mLeZgtEuNE4G/fbe3XzYDy2OvXXD4/q4QSFzTwWRK?=
 =?us-ascii?Q?ton7K69zstEjEgeNs6v75aDzL6q+o82YwJ/zpSq7MUU3M4MRNktHAkvAtZbf?=
 =?us-ascii?Q?CVMtemWekm6HMMZo0D9CdpdE7wz6SkYI16qRAoFbHaXExBvksSvdGQUfn7fq?=
 =?us-ascii?Q?TlS4+QBXlb6LRaBbVemxW7fiA+iXAqmEyZLpRw3SFfnnBBAkvXVyS8wKav9I?=
 =?us-ascii?Q?HEC/OkZZs6j5eo3lUfBwX3eRDAAAGe+yhHLCRB1HcKWwlWVMNOdYOOUYACMw?=
 =?us-ascii?Q?rMvOGIlDCXxon7hqtc3gIk3RPmsCdOQ+g9u+3VHpB4d3OKgKOOopx9hHil+E?=
 =?us-ascii?Q?Xd2ZwKNy5XKf2ip1NAn91vj6par8V04xnbwGi23cLJRI3i2Szx4JJsIIreVL?=
 =?us-ascii?Q?lJzewKNK54MK1nUCoqT2DdmHz3LPkl62SIHuESk2PInhUk/W6V8HktFdyr0f?=
 =?us-ascii?Q?Tjjbivthv8Yk3aufhHSCtvSZO66Tv1E2H96KGDw2UoirxvPBYu8on5gIuI7h?=
 =?us-ascii?Q?umhz2L4um8PzWSthiO5T4+IcwnbjZh4yC5LjAYnxcIiwo0stTC1n+V1r4vFK?=
 =?us-ascii?Q?Mbip+uUpjj7LRlWUh/oBcpuDS7GJ1gLQnZBeZI1rzKaIIVxsYNb5XDTSI7dT?=
 =?us-ascii?Q?12RwArSPWfwq55ZmXIKQ6KGonay3aIVOPPLfWBj2Im3coyKBXZk72H/vv8E8?=
 =?us-ascii?Q?FyMxSiMKWVzVomtW/uR3q9aX6++fvjsWXsR7/86b9A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?r9yAgohMsyai84QBK0gfUGE0o5BS9lXCMJaZsYs7gPKk+HT6eyeEy0jvqxM6?=
 =?us-ascii?Q?HyP/rDLIJNwKWwYKOM3ZubHpaFAq9IzA/O1DbjyHgZxSMQvVABTXfHYwY/yP?=
 =?us-ascii?Q?kb4YwjXkxp9fnBFuYv2fgJT7x//dTfvLAzGSDWfK0A6lgCz9QuFJM1w9ThS9?=
 =?us-ascii?Q?vakViXB2IHUi7l5+SuOGPMsShC9Rty7GiS1LHG9SqGzU59wTuTocQMBihbfO?=
 =?us-ascii?Q?hEAzyQCWxHIKewi5tQMFisggHgjHoG15KBzto4RH+0wdyYVK3RtrovgQbgBN?=
 =?us-ascii?Q?R2rhI5ON0i3A/zD8c6SA5p0eHgJksAGNIvh8E0e8JSj1Pjk68xRB7cl92sXm?=
 =?us-ascii?Q?V2yDBUZZ6AVBcFPTurVB0OFTuyK14RgUzp+dbGj5WR+hLnq0kx81aPQX/jSf?=
 =?us-ascii?Q?ObtsgPppZLNbCs+JSkS82d6z+qEXWbs+DEW/Qz+v+1zCtGoma04SABChf/+s?=
 =?us-ascii?Q?tRwXt7fr1Fx9P0/hZDltvr6sITxlbhGv8uWi5L/Dy5Uk0RHvDSaUxmv5sZtH?=
 =?us-ascii?Q?AZApguFMJfg8SPE0UJjr/IUP9eGxUyf+W3d3rIJ2yXn16XNfssbOdQaO2CTA?=
 =?us-ascii?Q?UpBsg7+NOCxlenaBCUH4m83pHc21aHxFOa7QVChTtTvu8UxJwsM+s1od1stD?=
 =?us-ascii?Q?VMEDR/9m/cp74pbO25LACC/MSIWceyKMWRnG6l2vFpl84DL9UrHETob4/43q?=
 =?us-ascii?Q?HTl/+NXCNgaUmlP0I2WPCgPEEvf+7DLpblxxnk5G2xc3JWYXD8FybNzwekG3?=
 =?us-ascii?Q?n51Enzi/0HG8gFPND7Uj8eHu2x2lfHYQ//OkYC09JO4XskTxHINfxc3n7q4H?=
 =?us-ascii?Q?imgf9qP2Wrq63QFovvGcfe1snYFwc/CE1/mm2B10b2C90aRX9L9wgF5Do1Xz?=
 =?us-ascii?Q?L+aSmH6c6x2F0eE/oe0ZsfETZyJoVrh5hY3mgqeCbp0W99lVEG9eRmy6dyC9?=
 =?us-ascii?Q?fDrAsycVZCIVBjPlh2SaOraUfckssl2qA/jJrigcDRs4/oM5GqZkjktpRkl1?=
 =?us-ascii?Q?I6LDd5hSlqA1g2hSrStL73yg0BhBRiOcifD/EZByiegTdOCRt2LLYx7Pj6iE?=
 =?us-ascii?Q?l2GP4rDbaHnmJytBaYgxBFmKDjSJ+/7yXX9/+h70nIf9Gvmp8W/pciZyuD+Z?=
 =?us-ascii?Q?OfcOQ/XX3HNN31Qxc8261vKHGueQcxrKmicBbmdXcfrGRn4CNZKQgYjnOPPw?=
 =?us-ascii?Q?1kjBOsMZJheft86O6+RW23GWznp94XUtsNzsoW3e9swkgIkg3P8xuP33oa0x?=
 =?us-ascii?Q?OKgQd1jfRQog2RP2JWQTjrWQPhL4u8QqCSUfAZxJzuKCsebr0wbAWLVBNqk1?=
 =?us-ascii?Q?v+Ziv1rEHzq5s2cI58UUNDN1r6hmIO+bTGxMezTfIElopKiKWllXBFuZ7Bsk?=
 =?us-ascii?Q?9Q6WhY+JdeYPWMLssFxHGtOcNrplQvSXUFOSfw7F3fpy6TPBVMX+Yuzm8EMU?=
 =?us-ascii?Q?iEnb3WIKXENbrGPh+B3WN8T8XH2sRrSDXLxeBf1gAxhzDbjpleMmkhCxqDgw?=
 =?us-ascii?Q?7Yr9GRP43EWE3KPanDKtrwHC92wAH8Bhti0M24oQGw9QpINQKb7bg08emh8S?=
 =?us-ascii?Q?1gFYpSCNKQ3KE5LWiCWm+nc7haPXLqmEFbFDJh5dKBvxK++1h9/f7x/eQA2w?=
 =?us-ascii?Q?gZAllKWtXsPMIaf3mCFG7GlZJMPL70GtN0n5q3K0qYeg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d60510-d2cf-474a-9b5e-08dc7bc41a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 07:35:36.4697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w14WJ57+zDUQAlb1F4kJBjlopEnm9hZa/Xsx+JuYHzfBxXH9pevcbHkfka1Eq3RsK/04ojXJJNHv720AgUvrII20frRmcAEEglnkPnzgYOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-Proofpoint-GUID: XETdK5UBOwTxJqpb0dfcPIolXm6-A5gj
X-Proofpoint-ORIG-GUID: bOOa8HcK-sQFuIdekDcQSgSLsoLn003-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_02,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240052
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 07:35:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16249

Hi Marlon,

The patch looks good. Thank you for fixing this edge case.

David

-----Original Message-----
From: toaster@lists.yoctoproject.org <toaster@lists.yoctoproject.org> On Be=
half Of Marlon Rodriguez Garcia via lists.yoctoproject.org
Sent: Thursday, May 23, 2024 7:56 AM
To: bitbake-devel@lists.openembedded.org; toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [Toaster] [PATCH] Add exception treatment to fix missing target_fi=
le

Based on the discution on  https://lists.yoctoproject.org/g/toaster/message=
/6157 in some cases the value for Target_file could be missing and is neede=
d to bypass it to finish build

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfaire=
linux.com>
---
 lib/bb/ui/buildinfohelper.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 8b212b780..4ee45d67a 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -559,7 +559,10 @@ class ORMWrapper(object):
                 # we might have an invalid link; no way to detect this. ju=
st set it to None
                 filetarget_obj =3D None
=20
-            parent_obj =3D Target_File.objects.get(target =3D target_obj, =
path =3D parent_path, inodetype =3D Target_File.ITYPE_DIRECTORY)
+            try:
+                parent_obj =3D Target_File.objects.get(target =3D target_o=
bj, path =3D parent_path, inodetype =3D Target_File.ITYPE_DIRECTORY)
+            except Target_File.DoesNotExist:
+                parent_obj =3D None
=20
             Target_File.objects.create(
                         target =3D target_obj,
--=20
2.34.1


