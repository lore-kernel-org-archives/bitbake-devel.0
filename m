Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC33C25B78
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 13:37:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.51])
 by mx.groups.io with SMTP id smtpd.web10.21792.1717508242533909704
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jun 2024 06:37:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=CutLfsVu;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.51, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USt5GsLiQ5gGf2UgzwMkAOGBWBteaoN38kEz3qxB79jnhI5eWdEhI/doEq6DxYfs2Tyi5n+U1KVApmwXGgoeBSwUvcMimDdJ5TqKVqtVPGgyFq0jsvR/bKi4xpU8A3oqLCXgTfZTpZGLoVNaSLP9pHQh9RpYzq8++vIFkQmtYZXa+8FYQ6MFFjpgsNgdgTq2DvbWssRzKJzwaJzIrpAKzfM7iT+Z1bewQ/LdK+/+kAEagKM37Ju3qMTf6N+pzMVgpbWz9JRl8xKQB4kQ/LqSgbu8fE4KRsVjp5Qic36QXWyA7cmafS9i8uNEZAdZLWlLk/W0QueGe4OKtJOn0Zo47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZVwSs8ZXVisqDSTenMx8GDlIbY8TLFD7RdWKgoUbEI=;
 b=g1ZlSd/Oaa5oor4k1X514goNHLOP+ikcxRrO3NIq2NJcznBTtjCSPm/d46KvuUedgC9vkT5GCNKC1Zg/STYKyyjVLWYQMk53wzdl++u82TAPkZWnnHdS42cwvGVqIeuMmD6W9IWQyNsOxLepaseI2aeJuE2WX50xI7pFcI/AcvQ29qCX8LfXnOiVtOndWz7PYVnnwxWk9/0P92iW5l6mb/gncSdjPSm1DbpwWESwTPjOqQDoy0nrLWBytZCiiqwE5yu3wyrwLiq3VUJpNeP/mQvNEmCNZKIt9UPsbCZGe7Z7/XMhZGJ2+/jyEUmrrg0rp7A1+SNVsRbr3Jie8254Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZVwSs8ZXVisqDSTenMx8GDlIbY8TLFD7RdWKgoUbEI=;
 b=CutLfsVuVZy17aQxyHtHjQNya3xzQ1Rwry556R5tlw9/2N5VwzLL/StjoByqPTgkOMXhSp5UXzwyUvYb9zm3ZMhXhhacaE5U2zy0aAOdQzxAaEPH61lCZ0xzhV7ymeVzXSC9MJDSMGr6VTaNTKzkOYuhOQaMiskcm0ZH56ZIWHncCKBAmeDhA4KITmZ86Y++gW45t68m1WSrh5nXsxAidULE8Bfb7YC5sxFv2zfz0uhy9X0si7kB10uNtXB45Ez95IkuW9zsqkq1c2en/nF4r930HQvRTRV/LC6K4FZ9QVuCvQiC3LY7QXui0+ZufpXD/M5/Pl6IUXiIwfTaF0g0vw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.25; Tue, 4 Jun 2024 13:37:20 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:37:19 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: TaskFailed, bb.runqueue.runQueueTaskFailed, and
 bb.runqueue.sceneQueueTaskFailed
Thread-Topic: TaskFailed, bb.runqueue.runQueueTaskFailed, and
 bb.runqueue.sceneQueueTaskFailed
Thread-Index: Adq2gVPrTlPcOgA+Qhqq+YhnjOudQQ==
Date: Tue, 4 Jun 2024 13:37:19 +0000
Message-ID: 
 <DM8PR12MB5430BCCCDDB29CCF593F501A8BF82@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=407ea67c-0ef6-49ce-8490-0120c88f103a;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-06-04T13:15:03Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: 923832fb-ea44-481e-033c-08dc849b74d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?EZNHVmR54jr97w2QzY2eLjh+AVN5fwsY1NvCXfKelU5sgmH1syRY5tf+3I?=
 =?iso-8859-1?Q?ct78LsSYwV+8itSEF7Z9QEchjKpDOLn2kVRcu+SKSXzG+WZtD/JKYLEwte?=
 =?iso-8859-1?Q?WYgfdO5St3F5OzUxxTrKnggizTux0GlZTBl6cckXLtQsWHOKKnpAYQa2qw?=
 =?iso-8859-1?Q?WhmBMjyqX/NBOxZovUHwcUd+oWCS7cMPP3AwUxIs09llriIxeqhzkLOvIj?=
 =?iso-8859-1?Q?KIkSnSeF4GhWEwnfZxC1iX3UN6yzwy84jbo7T0eo43RYmwbtToJB7wIlPH?=
 =?iso-8859-1?Q?ivowK1/6/fvWjJ45AgMHkkhoijbu9/9wu60ggClrPXkOzawBfs77Hf2hdt?=
 =?iso-8859-1?Q?jwxgq/2YUAInm8/fPwDi3htStaeLuLz4gIGwgEizfGXXiQkPdMpz+TThn+?=
 =?iso-8859-1?Q?9SeICqoR10j5ZEPkwk/S+Ll7ohFFBFcTN55qKkvzyMPLUuVVWN1qi261Kv?=
 =?iso-8859-1?Q?xqdH7Z7Q0gQpZSB2d3G6rZRgAqZWBt8teJ77UKpne0k1fgqypTN0G9Rt11?=
 =?iso-8859-1?Q?vUFUAoyI2hkyDNZV+fiEX/2/Jo4J+wp34jazZlMXxkeHprBE+32VqZ0kYa?=
 =?iso-8859-1?Q?7pZ+r+hIwcu7go8rsc7wQauqKEkLbuK51YVqO3kxCQit9brP1xIkJfzc8D?=
 =?iso-8859-1?Q?UeqIF5wrqbvnUyt28DT+bw+HTwjd/FPLi7gwieF0X/i25ngt6yh6+x632G?=
 =?iso-8859-1?Q?mZMw1zDQMV2HFu/ZKXhNMVxgJNKiaf6+0cOfGqg7CJ8eddjnLuasZ3RJx5?=
 =?iso-8859-1?Q?G4hBj6dTLTl0SGZ7uFgLC5QX30UWWStgfqB8Uqfr51mwoluPSj5p8erGaB?=
 =?iso-8859-1?Q?4ijr8UeuYj+Vihh5D7Q4bF1bbOieltV3lCYQDLsHS1Ep4o1kvlkFqRnjSc?=
 =?iso-8859-1?Q?GHET5IBbNkDANu8Rej9B+uVkaFlFbnaZjapI/hE+oxx8ktqMCLWPzdPSvk?=
 =?iso-8859-1?Q?hfTLsbzJWImr7M1lM3tOtNei5//Am7XD3fDtjY3gAXKCnk7AA3MFFi7p1V?=
 =?iso-8859-1?Q?5O/cM3zMa66NIWMe0yBjhsyQYGztdF7vosdUMGLYaLJ/bUTVtup6uyysNo?=
 =?iso-8859-1?Q?+xJ88wqG/dPLbPCj9STfvzeuWslToC8RnmozsuaPENf/CYwbDHf+qgkBVW?=
 =?iso-8859-1?Q?/VqXh7NDMlSVwmVop12sjGtkGdQCcuiLIPmhJGOpaGAJ1mzoYslseTZi1N?=
 =?iso-8859-1?Q?FMXTeSnh5zFDXRDkPLZL5bK204OFOF5j+Lwgo/dIv3EiAbymT+4MdxfjdL?=
 =?iso-8859-1?Q?kdFImdXFzoA5sZyRYIaPP+t7GD4j8qLZCwO3R8HPJotzPGcUQF60KiHNg0?=
 =?iso-8859-1?Q?J4OmjGNEPFSsaUJTasIhpYIXA0vtBX86r5JOa953hv6B9JUjTAe2NQdhw0?=
 =?iso-8859-1?Q?5BD4SRk8oE2kXeP30KuB9vpIMDa54jkuV8nbTsIRf+v1wj+LVP4wg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?NqqKszkkB62D0fPzHIGV7utJVMdMEqlY/q3+T+Ywr+0SxhfXzI8UvV3Hiz?=
 =?iso-8859-1?Q?pgt7POP9pW+RXVfR50aNzVkk+102FFSdDRc/uDk/NGUctCZ10mpq4B4ppB?=
 =?iso-8859-1?Q?uHFBoTIenHCimwCMGroZUQTL0DFqi5lNFeeZteON4L9Z7p/RREztfAC5Z/?=
 =?iso-8859-1?Q?9q6PZgaaMyIYUGIgmRTcaz2ed4A91qx528e5RTJLFutTbY8Eue4js5Cyio?=
 =?iso-8859-1?Q?DRYYhpa7KSMSzBVhVtTpovPDPjjHBzBySawv4xXYu6SA/6t3B7GYcun/p6?=
 =?iso-8859-1?Q?myvw0wtBxIiBOH4zckhmnnpdvabSjk1+FjPv3M6sLY3rXFnDfznT9FrWWF?=
 =?iso-8859-1?Q?wcmukA52VtTxGcZH1KSz5wRWqCLJYU26LUO4jjMWmDwciTddUQuaY0sJb5?=
 =?iso-8859-1?Q?cWd0mzpngeypoJ8uFUjUli+eUdRrmEGq1dzzV6xAmQyHDCUq9OndNtUf+p?=
 =?iso-8859-1?Q?bzHQfpGez3DjbTLztkT60dAU4v6YQzn8WV9C4GzTBXUvZvq1RZ0HvE0cDH?=
 =?iso-8859-1?Q?dEnWn6UW37LJXzyxuXpWB8JNn+3LCaQlmgKfzOq0fXtlSiXGwUaO1duKlZ?=
 =?iso-8859-1?Q?JHsy5C6aynDlhMoKlaUJDSclL8W6Zxf2+ShcaZZBE+xg7g7WGw/9ntNocL?=
 =?iso-8859-1?Q?VGU6IEktNWyVuOUcbs+fLRQlY9J/efogkXnuanRPbIvde1aicn+nEkwSX0?=
 =?iso-8859-1?Q?0HQ3cmd+7d8xD66OjHm8AOaYqQJl9Pf8j7H6+8r/zYPRXMuJSBCmF1rBOv?=
 =?iso-8859-1?Q?WMhXLEOq/UFebp70udZKyrK3NgaYIuiAAVfGQ/sGN687VUqhG2J6dKuToG?=
 =?iso-8859-1?Q?m75w0f4+X3QbfTnx4DKFq90XxQsJk5KVAV3GXPpy9ZPFNB3WXJm9/RRsBo?=
 =?iso-8859-1?Q?9HRRCAmlRbbBgR/oquqRSDsLb5dUOsi28s0y1tYGIzrFTI8DQs36avsC2+?=
 =?iso-8859-1?Q?YPjpyBx5jzEA6d3gRba2xT82t+K6omWWpsRz3iAB8zZzGPXxSGdcfIOq0C?=
 =?iso-8859-1?Q?pCiTplIxdowJLGAdfZkgspLNvchPzo8pxYWk1UzJKRBdmeLuvecigZeg1q?=
 =?iso-8859-1?Q?N+uMb0duCOIDIx+1u6EvuXMQfidqRkHBOBddUM7NS4mt0m8+Nt07ChCzKJ?=
 =?iso-8859-1?Q?VTNM2p5R2k3jnq6UAFtcfrmrVVUK87LWVgG7F6bnHs32yypIqsi27uHaS8?=
 =?iso-8859-1?Q?Bg813e//V3D9Br9aGCfNV+JlUXFLtSXI6z0mQdXYqjebwlh2n0xnlmYT4+?=
 =?iso-8859-1?Q?0OD1J/XD2gHGhHWtE1y/1KkQeupEdI5tI5/qWHM0T85vCkD/8tpMfeL+y3?=
 =?iso-8859-1?Q?vG3anzrV3TZyr0wCO5esgOXMc1i3Qbjak93wMpc9/H9OOhRMHMAYLkLDe7?=
 =?iso-8859-1?Q?2yF5a96TgXdFdyf4drcX4CwGt8C6559J7+Ehe/LBeGWWjl/4SvH/YOid9L?=
 =?iso-8859-1?Q?3FYdgS76+AFodNAyjvDSKrGNIwGulCTt6WCn4T4MAPxmIJgArqj9M+z2g0?=
 =?iso-8859-1?Q?kXg3WykGhmDS2XuJ4RGSBRadzNars3QeT1/YkcNzk/GCXxb2K+Ysu5LobQ?=
 =?iso-8859-1?Q?ajlZXjhbtt5vo0Qf5Sa3bTWT8tzy5i6WpSXsyO3V5D6iFTunJqjj5qF9zf?=
 =?iso-8859-1?Q?K3UR/QLOLrZrWGhY1Jlyrw/urfPPu/5JlhCQ+yir9VAEkxACzTywUFsQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB5430BCCCDDB29CCF593F501A8BF82DM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923832fb-ea44-481e-033c-08dc849b74d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 13:37:19.4344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUxJWXZLSRdkRHHwnYwKWi03PH1WxyH7Op96e/NbRSfHIoI9ZIbSJkV1rmj8VVSExp0IZAduL+M3gJ2irdBi24tfXonIwcZ59po/xLwIU9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jun 2024 13:37:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16315

--_000_DM8PR12MB5430BCCCDDB29CCF593F501A8BF82DM8PR12MB5430namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

Does anyone know the historical reasons for having not just a TaskFailed ev=
ent, but also bb.runqueue.runQueueTaskFailed and bb.runqueue.sceneQueueTask=
Failed events?

The reason I ask is because I am working on enhancing BitBake to print the =
logfile paths for tasks when it prints its final "Summary: x task failed:" =
thing at the end. (There is nothing more annoying to me than having to scro=
ll up past a gillion lines of C++ template error nonsense to find the logfi=
le path. I usually end up just manually navigating to the temp dir in tmp/w=
ork/).

The bb.runqueue.* events don't carry much useful information, which is unfo=
rtunate since they are the source that Knotty uses to generate the Summary =
message. The runqueue understandably seems to just have access to things li=
ke the task ID and base config variables like BB_SETSCENE_ENFORCE, etc. Whe=
ther or not a task was fakeroot is also propagated down. But I don't think =
the runqueue is operating at the right context or abstraction level to have=
 easy access to the particular task details.

Contrast this to TaskFailed, which comes from build.py. I think the na=EFve=
 approach would be to change Knotty to use TaskFailed for the Summary messa=
ge, but then you lose the distinction between runqueue vs scenequeue task. =
Maybe it would be easy to just tag the TaskFailed event with that flag thou=
gh? Or perhaps it's already there - I haven't looked hard to be honest.

Thanks,
Chris

--_000_DM8PR12MB5430BCCCDDB29CCF593F501A8BF82DM8PR12MB5430namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Does anyone know the historical reasons for having n=
ot just a TaskFailed event, but also bb.runqueue.runQueueTaskFailed and bb.=
runqueue.sceneQueueTaskFailed events?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The reason I ask is because I am working on enhancin=
g BitBake to print the logfile paths for tasks when it prints its final &#8=
220;Summary: x task failed:&#8221; thing at the end. (There is nothing more=
 annoying to me than having to scroll up past
 a gillion lines of C++ template error nonsense to find the logfile path. I=
 usually end up just manually navigating to the temp dir in tmp/work/).<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The bb.runqueue.* events don&#8217;t carry much usef=
ul information, which is unfortunate since they are the source that Knotty =
uses to generate the Summary message. The runqueue understandably seems to =
just have access to things like the task
 ID and base config variables like BB_SETSCENE_ENFORCE, etc. Whether or not=
 a task was fakeroot is also propagated down. But I don&#8217;t think the r=
unqueue is operating at the right context or abstraction level to have easy=
 access to the particular task details.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Contrast this to TaskFailed, which comes from build.=
py. I think the na=EFve approach would be to change Knotty to use TaskFaile=
d for the Summary message, but then you lose the distinction between runque=
ue vs scenequeue task. Maybe it would
 be easy to just tag the TaskFailed event with that flag though? Or perhaps=
 it&#8217;s already there - I haven&#8217;t looked hard to be honest.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></p>
</div>
</body>
</html>

--_000_DM8PR12MB5430BCCCDDB29CCF593F501A8BF82DM8PR12MB5430namp_--

