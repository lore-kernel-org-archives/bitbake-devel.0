Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16DEC433F5
	for <webhook@archiver.kernel.org>; Sat, 12 Mar 2022 04:43:38 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web12.1959.1647060217302967074
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Mar 2022 20:43:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=k8rSaoid;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=007057a150=david.reyna@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 22C4hK6p010174
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Mar 2022 04:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=gQA5joYJmK07LiVwsn/cN6kgoiUBbiAj+W5xSaCLSS8=;
 b=k8rSaoidYipW1QlLSVxXRyNh3IZxcqLuW5kTrCC13QitmalMyf/WIAak4sOli9HToPEb
 sP45gsHCZl7TzxCMZk1F6NPJX7pcK2X+ZpKcnIg4WeC6OaqTq+opMVkBqQ6k4G12X+L0
 nwdXFqSPQRef9If65TFQ3ZrpM40h5OPzbnRt0C7fnNNXUxuOrWkvb+86ogay1nX3ge91
 Y26inrokf0BL440gVOpjrp+2jx6nZAr6vlxq0Ng+yJsj0TVOFNCbJytbABRnMPHobpS2
 YqadPGrkmFXcTzmUnP+U9GbmvTp9YFQLbcazP7M4ecmIsA30JppJn3o0ts2h7LRp/QdD CA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3erjg7r1ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Mar 2022 04:43:36 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22C4hZS5010267
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Mar 2022 04:43:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3erjg7r1wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Mar 2022 04:43:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjqbEyssT+O0PxwtvArPOVhZMO0preOJ6kxTSsjhQYQhlnUMdE38G7CFVWLoVAVMuttshiMUMYaCfSSNsAx448LwormrYMctDP/MuK2feraaoywnsDJmbR1r3e3KcjGtFdVibpo7OUOEV8s+ktp9oCMXUCbgjBfJl2CJ4B6sUcwJoMSpbMpZMB02RbKte03BL8lc5yVOcFBOxGQetpixaH6gGgHvZbFruYCw2107UerJsAsFl7RVsB5j0x6gLEllHHMGYrgrR7KeT2zI3lQKtLv7eqAF/erA4KzD4SDApUB0YJxU3mQPx5r7k/6zltigjSJvLwqbU+ayFTJeb58XbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQA5joYJmK07LiVwsn/cN6kgoiUBbiAj+W5xSaCLSS8=;
 b=Y8CtXlDzP2Vp3aUo/t3utKL5znCaOV8rdWr1/VcxGKwWLLagoTHHLeHj6Nsg+illPVmsc6Ust8ziAb3ttiCOT9iSbCHslmkMUuJuKTowW77VmrDBCWkZ0Nfzo/uZTXJN3b0gmMZDB9yKTN5YlmRL8uKY6JqDgXbQ0UY3RRx2tSZSu1nUuCcm+f2pNDy0BUPsINAq41EEICXeCljemO7mQb9FB9oHbXd3f03wvxDkDhW/4zK0vAzIGgwnpAvLhNCuwtwLF2XCsgRObqTF1XQWLqqCFVQXszGSCy90+jFnOD93o/LyG8rGgoKiYhQVZZG/7ELOzttNOae3JZiQFJckPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Sat, 12 Mar
 2022 04:43:34 +0000
Received: from BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::f0c6:ef53:bffd:962e]) by BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::f0c6:ef53:bffd:962e%6]) with mapi id 15.20.5038.027; Sat, 12 Mar 2022
 04:43:34 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] toaster: Fix IMAGE_INSTALL issues with
 _append vs :append
Thread-Topic: [bitbake-devel] [PATCH] toaster: Fix IMAGE_INSTALL issues with
 _append vs :append
Thread-Index: AQHYNIZNKb+51jKdP0KRGKzfQQ1Vwqy7LZ8Q
Date: Sat, 12 Mar 2022 04:43:33 +0000
Message-ID: 
 <BY5PR11MB4167951BBA9847C6F319CC61EA0D9@BY5PR11MB4167.namprd11.prod.outlook.com>
References: <20220310135344.612089-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20220310135344.612089-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec4cc101-f65c-4bce-8117-08da03e2dd8e
x-ms-traffictypediagnostic: MW3PR11MB4602:EE_
x-microsoft-antispam-prvs: 
 <MW3PR11MB460264D7C010E4E8824B267CEA0D9@MW3PR11MB4602.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vRbrbu1ZMqrOKKJw+EIves97PJL673OnZVeMJj+8uBwx6QPSWCu0iACx+6/vR0c4YdH+z+/x/SlftdCGWO7U3F56u3dU2YucwjVphH901LmXXJb+o/zfRPPkagYSonr3W8gpSrEHCwNd/X4HSU0aafTUI4Z+XXdX4jaBkEC7XLw5QphMp3d9RmOCYMx8JCk0iss00GR92/r7e92XX8yiCinekS1Eg9v8nLVsjdKTqR+p+hX53yQCZ5Ga//mdaYoQcUrj00se6ePU8mhWka3Vh9OCbshIu0dxdI6wXfBg8yu4ct49WjZM3EqfnCL0jW3cpieRKQHaGnoKV7rMnMTqAePESNgNwWYZ43OQ3y0aoN5NKPYmWh5rA8VT9giHvG/+r7C7NmdyH4/2oH86JBAsmqSFe/R6quKEpBrn3pEQZq4ZOq6O1hbFQyAJajoZw7MG2u4RSmwIp2QRQ/Ivo7DQgdbSAtFvTKQt9D0D9SzSbZ1iJyY4R6fWI0fz/NKoONRQIw0MUKiSy160NzchvYujUDBOOdlR1k7Bug6YbRetaS3+e9jppU8oCMh42duK25FZZkpYlh256+3J8xsY+oKY2jjqn40/liYk62RNabHLR0mwDOd/wsDpPF413VEs+3MOgD/75aFFDMCf8rmGLaa2Q5kuHM1uXqff+vtIeBsS7KlPWfQ2rsozIaeMA6P5baR+NW9yupG3EE4HG1zxP/06sg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(55016003)(5660300002)(38070700005)(110136005)(316002)(52536014)(83380400001)(8936002)(38100700002)(8676002)(508600001)(86362001)(53546011)(6506007)(7696005)(9686003)(2906002)(33656002)(122000001)(76116006)(66946007)(64756008)(66476007)(66556008)(66446008)(71200400001)(19627405001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?AQ550L8W/N4kMX4sL3pcterVqdwzQPti/jsBM8MTLJpmsEbNsqSX7+Efevkd?=
 =?us-ascii?Q?lK1Ep5iDf+1C6uInTixO4XKQcWBIVb4ynMQl9IjHCDwE/ax9eov35sGSQbzs?=
 =?us-ascii?Q?WOHFEQpCbM2Bs6qr+cOzWJszwENJr0EnP7z3BsATzEARKYPLk+FZLPjlD8dP?=
 =?us-ascii?Q?WKd1EZU5zlMsafhFHuiRvZBuQHbfNLdPT1ARV2FCsXY3k5ycfjh8nGJgTXjy?=
 =?us-ascii?Q?ux6LH6OglleJhFLhuER4mNMzS7GgzvjjY3+wCSrUN0tDngRG6loD8pf8Ie5s?=
 =?us-ascii?Q?Bs3W4VX/+CZvNpfxxoe9Jd+ULpCD3jyGbu+rGeX403jNFdXGodu1hYowzWoE?=
 =?us-ascii?Q?r+8EG2cYop0WKwP9fOEAwKKgcxouoG4SU1SZq5xReaFsguVPWZMIUfiXC6P6?=
 =?us-ascii?Q?0JFa49CAZu5ThBdBcgiDHKYbyTzw2+MXrcCozN5/RW6RFHbmG5ScBSmChWSp?=
 =?us-ascii?Q?40C0z1ABvVOOGSRkOe4mXNQMdIkyjwHS25ELDOYEZAjY/fo8ATNxbxoPJO6v?=
 =?us-ascii?Q?S9D8WNZjwM2vUGeRiriHmGsmTilsG/69+AdZAnpKmLGe+5AZdotISRLhqQ6X?=
 =?us-ascii?Q?q+AOgR1sEzTOkxjD7UFbz+wXq9zqEe/Gc9AX9npvqrLtaPL45K5q1HFpj24/?=
 =?us-ascii?Q?Le2BwFZ4DFgHAvj6QNR4HKM71ZfekNvdGAd5FcBCNj/JsChVy7cpVbyGHIDu?=
 =?us-ascii?Q?rAzy2Q+NaWYcD27XuhzZA4x4zlJ8EbMn1BaSg0PIaj+s7MYJrrxIXkKclL6u?=
 =?us-ascii?Q?9ndWqXCTw5I4W2WLFehOf3TLQr7kIm2S4BvyJ5OKjQMAlvqLHi7eETlmCPv4?=
 =?us-ascii?Q?4eqYuD2GG/dgtiR/gdOs8Ep5GAPY6mTImwj10C1NVTPjdBZNWQiuitnHCZMi?=
 =?us-ascii?Q?M9ddlsfn5ODf2meoA0z99EgIHC9QSUQDDoafsqDvvlxE9DkmKJW7G8hFQQ4B?=
 =?us-ascii?Q?g4jxIVz9lLEKUVquvYgmNk4a9Yd1RjbYsi47LxELGg3Bq6vLaf3+wT2INcpy?=
 =?us-ascii?Q?zMuSjOlnCwX/9SI1p8iIviTK80QoTDPiL21ORrTgRZ26dO3fq3/r9j2FE1+q?=
 =?us-ascii?Q?/C+pxshJ5kMaacFpktLT125mccu/Jru/97Al008ElFHjfPnxkmZl/E8s73Fu?=
 =?us-ascii?Q?ikbBI4Y50oDKSJeud450dmK0Yy7O8y3EEAPhWtll0ESU8WQgNwPrbpmsfodC?=
 =?us-ascii?Q?/+DKvYqP7E2LKmNnAnJKj9tRhmDVbZL4aOP/L1/Awc8j/qKqWrl2bFhs4EqD?=
 =?us-ascii?Q?2X2bWXX4YsrOmZnTfX8LN6fyQhEtQmksnW8OpFOOnCGBzZl1rF2OQMUih2Z8?=
 =?us-ascii?Q?lUUnayNnSF2Ct/gWQaQjI3E7IGXAnCskr7Bq6u1EnD+VfuU8toE9+0LrEZpj?=
 =?us-ascii?Q?7Yh7zZjmrEiO2U6IUn164drvVDQCb2ki537txYaUWYOnPt649QaBaeNAch4C?=
 =?us-ascii?Q?xEAEiRaZilceOcyDjQ5pg3zHx7HZkIP6yOHEm226r1UuDfSAE6QAPU8TpMsX?=
 =?us-ascii?Q?zZjOzJN2inG5XK9MDAyV9Y/4cmnD2VOyFxGnC7iCvffrKtYK0L4z2wzffA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ec4cc101-f65c-4bce-8117-08da03e2dd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2022 04:43:33.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 dpyazROzBmfPRbZwKQyiIkC2cVH7ABOykjZUCKON/1cfq+OgnW9mWViWE3MwVRGyFhr1+9F/VgMENEHjKbVDtKUpQPowth5lCwjTl4F9IGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-Proofpoint-ORIG-GUID: -YUjZQ9c2BoidO6cFI_hcGahbpwdCg5y
X-Proofpoint-GUID: whB2PlCnXNHsBkbNtn-zCvCvlsagruWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_01,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203120028
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 12 Mar 2022 04:43:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13475

> "I have a suspicion that exiting toaster databases may struggle with
the change and there are some migration steps missing for the whole
overrides syntax change step."

The syntax schema is not captured in the database, only the name/values pai=
rs. It is used in the UI and the code generation for the respective project=
's 'local.conf'.

See Bug 14758 "Toaster: add overrides to UI and parameter generation"

Patch in progress.

David

-----Original Message-----
From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org> On Behalf Of Richard Purdie
Sent: Thursday, March 10, 2022 5:54 AM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [PATCH] toaster: Fix IMAGE_INSTALL issues with _ap=
pend vs :append

After the override syntax change, toaster isn't working correctly. This
is because it uses IMAGE_INSTALL_append instead of IMAGE_INSTALL:append.

This tweaks the code accordingly to fix this.

I have a suspicion that exiting toaster databases may struggle with
the change and there are some migration steps missing for the whole
overrides syntax change step.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/settings.xml            |  2 +-
 lib/toaster/orm/models.py                        |  2 +-
 .../toastergui/templates/projectconf.html        | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/orm/fixtures/settings.xml b/lib/toaster/orm/fixtur=
es/settings.xml
index 78c0fdca7f..ab3ea021f5 100644
--- a/lib/toaster/orm/fixtures/settings.xml
+++ b/lib/toaster/orm/fixtures/settings.xml
@@ -19,7 +19,7 @@
     <field type=3D"CharField" name=3D"value">${TOPDIR}/../sstate-cache</fi=
eld>
   </object>
   <object model=3D"orm.toastersetting" pk=3D"6">
-    <field type=3D"CharField" name=3D"name">DEFCONF_IMAGE_INSTALL_append</=
field>
+    <field type=3D"CharField" name=3D"name">DEFCONF_IMAGE_INSTALL:append</=
field>
     <field type=3D"CharField" name=3D"value"></field>
   </object>
   <object model=3D"orm.toastersetting" pk=3D"7">
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4c94b407d7..6d772367d8 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1717,7 +1717,7 @@ class CustomImageRecipe(Recipe):
=20
     def generate_recipe_file_contents(self):
         """Generate the contents for the recipe file."""
-        # If we have no excluded packages we only need to _append
+        # If we have no excluded packages we only need to :append
         if self.excludes_set.count() =3D=3D 0:
             packages_conf =3D "IMAGE_INSTALL:append =3D \" "
=20
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaste=
r/toastergui/templates/projectconf.html
index d62691df1d..3b91b6679b 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -73,7 +73,7 @@
=20
     {% if image_install_append_defined %}
     <dt>
-    <span class=3D"js-config-var-name js-config-var-managed-name">IMAGE_IN=
STALL_append</span>
+    <span class=3D"js-config-var-name js-config-var-managed-name">IMAGE_IN=
STALL:append</span>
     <span class=3D"glyphicon glyphicon-question-sign get-help" title=3D"Sp=
ecifies additional packages to install into an image. If your build creates=
 more than one image, the packages will be installed in all of them"></span=
>
     </dt>
     <dd class=3D"variable-list">
@@ -83,7 +83,7 @@
     <form id=3D"change-image_install-form" class=3D"form-inline" style=3D"=
display:none;">
       <div class=3D"row">
         <div class=3D"col-md-4">
-          <span class=3D"help-block">To set IMAGE_INSTALL_append to more t=
han one package, type the package names separated by a space.</span>
+          <span class=3D"help-block">To set IMAGE_INSTALL:append to more t=
han one package, type the package names separated by a space.</span>
         </div>
       </div>
       <div class=3D"form-group">
@@ -771,10 +771,10 @@ $(document).ready(function() {
=20
   {% if image_install_append_defined %}
=20
-  // init IMAGE_INSTALL_append trash icon
+  // init IMAGE_INSTALL:append trash icon
   setDeleteTooltip($('#delete-image_install-icon'));
=20
-  // change IMAGE_INSTALL_append variable
+  // change IMAGE_INSTALL:append variable
   $('#change-image_install-icon').click(function() {
     // preset the edit value
     var current_val =3D $("span#image_install").text().trim();
@@ -814,7 +814,7 @@ $(document).ready(function() {
   $('#apply-change-image_install').click(function(){
     // insure these non-empty values have single space prefix
     var value =3D " " + $('#new-image_install').val().trim();
-    postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+value=
});
+    postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL:append:'+value=
});
     $('#image_install').text(value);
     $('#image_install').removeClass('text-muted');
     $("#change-image_install-form").slideUp(function () {
@@ -826,10 +826,10 @@ $(document).ready(function() {
     });
   });
=20
-  // delete IMAGE_INSTALL_append variable value
+  // delete IMAGE_INSTALL:append variable value
   $('#delete-image_install-icon').click(function(){
     $(this).tooltip('hide');
-    postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+''});
+    postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL:append:'+''});
     $('#image_install').parent().fadeOut(1000, function(){
       $('#image_install').addClass('text-muted');
       $('#image_install').text('Not set');
@@ -1011,7 +1011,7 @@ $(document).ready(function() {
     $(".save").attr("disabled","disabled");
=20
     // Reload page if admin-removed core managed value is manually added b=
ack in
-    if (0 <=3D " DISTRO DL_DIR IMAGE_FSTYPES IMAGE_INSTALL_append PACKAGE_=
CLASSES SSTATE_DIR ".indexOf( " "+variable+" " )) {
+    if (0 <=3D " DISTRO DL_DIR IMAGE_FSTYPES IMAGE_INSTALL:append PACKAGE_=
CLASSES SSTATE_DIR ".indexOf( " "+variable+" " )) {
       // delayed reload to avoid race condition with postEditAjaxRequest
       do_reload=3Dtrue;
     }
--=20
2.32.0


