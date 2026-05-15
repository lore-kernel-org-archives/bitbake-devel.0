Return-Path: <jamin_lin@aspeedtech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD910CD4851
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 08:03:36 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (TYPPR03CU001.outbound.protection.outlook.com [52.101.126.85])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30312.1778832213358424434
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 May 2026 01:03:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@aspeedtech.com header.s=selector1 header.b=YV31H66c;
 spf=pass (domain: aspeedtech.com, ip: 52.101.126.85, mailfrom: jamin_lin@aspeedtech.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wutaKhGxHXf1+5KJWmzySm/VNCbXL8HO9tn8eZkbUN6oGtZpYyBmcxrXOsoYTSTnlZLanKeid7oHur+rV7k2FlyGz1OYOzjkQjju8djn31yiziMeBRm2F0pzXVgYY58nlL+T3YUAM+SlFynui8Aa3AjfJ6n+1qn578j+TpatQr+dPUCIK70O4zB9cabIz0bexVhNd+ypJHbSRLpMIgXofZ/mAWIYB/dXuQxXPrrHsGyQSlQX116CtImSbrb6By4rs7dZnCzEKzq8U9VAjOHi83YwGqTAxnjdE/obLx+qr11MOAvg/3RdjnNIcrOmOZPGiGW98p2Iu/y/s7QnZdEWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkuEJ5FiyZVhjfoBFPVEMMu3BrB5q2LRLo8SqZwhxXs=;
 b=sUDZTGxzAiLwyo09fd8W6V7gst0Yd1Q3gIsvmdynqgFArzCn841947IFcHWXUp5G8bLw2WCzxKzr+fKOUNARTrf1xV76XqxHkvczM8SJmiktUmsMQzIhkve/mtuO/mKP0P49y6CJrj5wM5GRUmH7CYlKtQEz1x3iueNalAwPWXS2FE/oe5QH2OZ0+SWLMgBoCDcdsTzwSkUbjtgO/CeMD/HhiFrI2hvJKOlgwKwVl4C57J6mdww2ciPf/VgdjnNGDCZwcRcCTBd7pmAFqMtGrK/46As90DqcXW9jMpw7ib9mjBQqFye2QNvHzuihHyyMcYh8zuBlbyMzJO2SBprBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkuEJ5FiyZVhjfoBFPVEMMu3BrB5q2LRLo8SqZwhxXs=;
 b=YV31H66cNr+m7Nngbvcpqm3QYACnPKpjwNmwfduq/F2IZbC4kJWX8eGfAhlLOczdx4Mbq3bPG8oPqVvV6pWw01cOJf7X0yHtQQfcLAciCGav3sgg31Gi/DSTzndAWmr+jZtcHq9urR3Bbt3BSoOAIkLBI2e7giClFHZ2jOgrmbkUQV1i+k7BqKlnDq6bkrWQN4o7hN7TkTD8eGhURT/ZjPj/oGnGrKX8hdo9CHV8+QgmL9LEjqr7bsq2nEK553rnF48xDTVGu5i7UvK34Xnm5HvnfLoNrnbEpZDWnzQKAUEEwQCSHUwSHxs5UMFvKk2T+1i79LgrthaBcs4AuFE1Dg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB7286.apcprd06.prod.outlook.com (2603:1096:820:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 08:03:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 08:03:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>, Troy Lee
	<troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH] fetch2/git: Fix trailing slash in clone command causing
 double slash in alternates
Thread-Topic: [PATCH] fetch2/git: Fix trailing slash in clone command causing
 double slash in alternates
Thread-Index: AQHc5EFQkscYWoO3NUGlVd5DdjMs1w==
Date: Fri, 15 May 2026 08:03:29 +0000
Message-ID: <20260515080327.1285043-2-jamin_lin@aspeedtech.com>
References: <20260515080327.1285043-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260515080327.1285043-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB7286:EE_
x-ms-office365-filtering-correlation-id: 2f6b6200-3707-472d-79d3-08deb258736b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 nPFOTsNKFyhCp6F1jyTN6FLN3HIPmqAEo7b/DoE9whJzcQiDqnEi+0IffdiOcXes84EzU4Lq5x/2b63I+ikNFRdSdcUJW+lS2Btwxd29gpjiUCK9r99Ig84KE5oj59Tm/gdDobuzKJygRZJAsk665CMuIf1Qi4Frp3GemEB6FCxgaJ0iyJib0lNwt69ck9jet5O3IBxWCl046+W9TJ61EAAiu3AU5ZDUPqz7Zba4RexAvGSYKC43g6TCcrVv+qrvHTg3OhnHXb/zPIjRTZO9uvtHZ19EyJXIoMyDjb3c5IGriSF7uYKM5e/N5sq6Jjbk3Pl9VyWyV20aJvOOtFfn0QrTO8kgzWU3/j0HqcKEpoSEB4WBfYJmoXRg3B6rEbURj2ECMsPdYhGHeHfZCCrbWWOIYCBFWiDBXxWkOX9Au5i9VOpiSgsn/dtau0N5p2zFZodw/KZRm0ueE/sfjZ0pljRGWlPMG6tKIozdPJOAVSyjNtmEnDVdZTsnJ2rSOhOAupDB0Mg8MqevQxXBYRdls/WIW7ZVhHxYBpIj/FV7pe2WZ7fB4u84qESxOJvtvVKMFes5WG2FOvWErjjQWdCpugb/Ll5erImUyZycBDDw7xXIybrrN9sTGcMhsd8lhs3KRIzyEtS3AQxSlwgPS9IpaFLKUOPBACTpo67Y3Y8C/xq+S5jIGHhQ/aSs6X8m1yVOg8QBVNkLG9gPAGEsu7ZK8B6iAon75vradU/oN/57Ygq+UR/BvwNPrtZdZZSrhylU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYPPR06MB8206.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?FyoYXK9U5iC7g92hc+WMg7hNsl2L00hMAyG7T+gRrA2AZ/UAnW43Dw8OgRlK?=
 =?us-ascii?Q?aKLtJ/jzJgrUmuBWSQ9r4UPhYdmeZHGGY320d8f1k8IYT6K5YLAEkmTCHS8n?=
 =?us-ascii?Q?g8mVEzbEGV1U5Xl9EbkFOLnJtwVuVfmCHLX6Oc/qn3SB8TaERjTIUqe1i87F?=
 =?us-ascii?Q?8y6YpVF5l1IT1PXTRvaHvSVLYkYdFvYtW1aquoxi0R7hdqYNJaOPrrrhqN61?=
 =?us-ascii?Q?K+Bcilt2oXvMU4zMIG3WCUsyDouezW0FMBiQO4cGfa6nRBRjGMFbov/0PDTv?=
 =?us-ascii?Q?f/M6c1ekJGPUsuYTsdsBoZ9JJW1zvNKKHfBf7vlCanlzoBZiJZRy+6qVqIIg?=
 =?us-ascii?Q?PT4T+fPnpOcCm9bcpTzpSQSSzaBdf0Cd3QbtRz+oc8qBY/ZtHKnSbw5ucMn3?=
 =?us-ascii?Q?zKwk/gNfkcWNa/5YOffIg3MxVdGTlwrCBW4X+7Xb9zu75PhGAJj19Yoc+wE6?=
 =?us-ascii?Q?yYTDDooqoDIwtZX9XhrTH6wpau2MnMNQYEZb+pVPQFGG+O5xPfBy8lJd0C+5?=
 =?us-ascii?Q?0e9Z4FZkv44uTt4u/tcA0EbSIO//STwRa0/kdMjR9hQ+mjJYq/6whnLKKNoG?=
 =?us-ascii?Q?BnuP26hMMc/kIgAxTra272yNMMh2R5UZAoPp1HGuhi+mdWyWbDShhkLuPI8t?=
 =?us-ascii?Q?3apIU6VNNN+gBHL+VwnNmy/9NAJriWSZdeqbx877orCYsVI7YyFXpinCsFIq?=
 =?us-ascii?Q?sEVw8LgNKlg2zlBfLBs5oU1/pwDVS5FsscJpugQhjKbFTWfG1l4H5n3O8Idz?=
 =?us-ascii?Q?geyGUA16NzoGXoTlXmQgJ5aV7Mc0ATUdiMU6AOj55r4Ff0siEL0A8EgCP/XF?=
 =?us-ascii?Q?zuU8izG68/k5eQY1ixYbIs3XJMpctX4Y1fAZ2RgaHzH1QGLukmppJwXRQGLI?=
 =?us-ascii?Q?p9ufljoX/fULsi0FNQK1Zg1h28SzlesUGdfVOvKPwSiHT1Xd13BawQX0DC48?=
 =?us-ascii?Q?ajvIT/kJDCcBbOQoJE79IXZScRXcsHsaE8LkSBmM2LNdKBGNykoRlIgsotCd?=
 =?us-ascii?Q?eCNmLmanLpucmQ7vSCkXzEMfx5AmmB0MsJbrpUNkkUBTz66NCS6J8RGc7w00?=
 =?us-ascii?Q?dlMOvD4F+/TO3nd8Vfp5U8oxgv66eXGQab+bgO/IAlN6qDjUu8LB3ZIM2C6q?=
 =?us-ascii?Q?mQu8Jrbdtr3vdxpTduEgd9c6KOGtOix0+1GQug/pqsSd2ICMc8Bz/JodjniQ?=
 =?us-ascii?Q?asNgB/Xq6f3vxE8Bf4R493I/2sfH4XOxbjKloma2MISK7iPRgfC3eDw3rI/H?=
 =?us-ascii?Q?QHXCdvQ3/wWsJu+N7yiPfUcBiL3UPCSVGSJRf6Pi7vQmAfbDLhbL0jUZvW4A?=
 =?us-ascii?Q?dQRB1FiZ4lZdP91Yh5DOC1kM2bivpoKQ8hojrjAMZGTIV5emPvciLPLNQxAf?=
 =?us-ascii?Q?OgP6q4y1a/qC5DH6j7EzLfFrY4uh+ZDDnnrQD2vVII3aPzH1b9T/A5u3Zalr?=
 =?us-ascii?Q?ewhAWT0Vw6BYscwPye3Xzhc1YSIVuJne3SeN7ELO4H2yI6j33phz90ci/UKL?=
 =?us-ascii?Q?nOe811kFQVuwDULz7V2U0Pwy/saU+YVPCn0Xs+wAcdiwINbTcSvLisBhpmX0?=
 =?us-ascii?Q?dTZdeD3dK3fGQs54A/0WWtv6dem9o191EA0q3J3yx0fh2a1bfULTu2NKTK1n?=
 =?us-ascii?Q?+7/0SaUsQfmwCxzbTe1BkQKrvwjvs23pzTKzDtGoYYTGQtLw9E4WQYvk09MK?=
 =?us-ascii?Q?AZIeSh5BhwDPkrq4ssd3ELmVRYG8cRrgGYlnywacU7fCjjHI6VkpnAoPVrx7?=
 =?us-ascii?Q?iYlqjQxePw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6b6200-3707-472d-79d3-08deb258736b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 08:03:29.6423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1IJrzKy5OWW1Oa6/tAtsCTAwW44KlGo8CiruA1AP8jpAuBD0B6qBi+VscQOmM5j5WFlAZAoq3/kxYpJOSdTwj6TBzUvZZvEmi21DI/y6hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7286
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 May 2026 08:03:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19527

The unpack() method constructs the git clone command with a trailing=0A=
slash appended to ud.clonedir:=0A=
=0A=
  git clone -s <clonedir>/ <destdir>=0A=
=0A=
When git processes 'clone -s', it writes the source object path into=0A=
<destdir>/.git/objects/info/alternates by appending '/objects' to the=0A=
source path. The extra trailing slash produces a double slash:=0A=
=0A=
  <clonedir>//objects=0A=
=0A=
Newer versions of git refuse to normalize this path and report:=0A=
=0A=
 error: unable to normalize alternate object path: <path>//objects=0A=
  fatal: bad object HEAD=0A=
=0A=
Remove the spurious trailing slash so the alternates file contains a=0A=
valid, normalizable path.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 lib/bb/fetch2/git.py | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py=0A=
index 01bebb764..b2b39549d 100644=0A=
--- a/lib/bb/fetch2/git.py=0A=
+++ b/lib/bb/fetch2/git.py=0A=
@@ -697,7 +697,7 @@ class Git(FetchMethod):=0A=
             if update and os.path.exists(destdir):=0A=
                 update_mode =3D True=0A=
             else:=0A=
-                runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.clonefl=
ags, ud.clonedir, destdir), d)=0A=
+                runfetchcmd("%s clone %s %s %s" % (ud.basecmd, ud.clonefla=
gs, ud.clonedir, destdir), d)=0A=
             source_found =3D True=0A=
         else:=0A=
             source_error.append("clone directory not available or not up t=
o date: " + ud.clonedir)=0A=
-- =0A=
2.43.0=0A=

