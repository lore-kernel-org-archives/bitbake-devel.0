Return-Path: <kari.sivonen@live.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF52C25B74
	for <webhook@archiver.kernel.org>; Tue, 21 May 2024 07:51:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.92.19.96])
 by mx.groups.io with SMTP id smtpd.web11.14528.1716277869516377747
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 May 2024 00:51:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@live.com header.s=selector1 header.b=QGL/Ev1j;
 spf=pass (domain: live.com, ip: 40.92.19.96, mailfrom: kari.sivonen@live.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Iuj3A87+TDqFrqaSI8m/5SjP9jvFJ4ShN1uh1e4SSQ+LSHa5DzEQkZh2cXXuGeiHhEPF4e+Gs8yy6C726b7LrI8twmKKUH4hal5vAO7i3HwEfnTzFMovbWslNEJf2MSnFNpBssw0RH2Qfu7oU7O7qvXRWx4H/FU2REt4G+ja3qSHMVP/uP6dWxuGrxYn9FCLP75SRP2rc4zZEXmcJhjpyKDVg/vsM0307vtoly4kqq++ia1yHupeHyflJ8F9XVb3VXtglERUaj5XD5I1PtX/5XE2qoV/WPchojzKUPyGC6Yj2xtOCMfrz9Hy+Ub2hvudMq+64u3NUQzE1RKi1how==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BSkbj5VRaCAxGJ1GmTK7qJaqs5DHoBykOaEKp4iAUk=;
 b=ENJ985hzoL4YUKZLoV2y1yOqFCczjR9LyP6bUDPkuMif7DzXF/hZx5hqN486uUSD963k6tgW4pfX307iCJsIaQLkrY6+UsImtVLHuAtsmrSsIrpYMKhJ6sWz+mFXdq0kQhtlwPPf8Q7ptnpXTjlQeyPx79UDosvS+DgzUCc63TdfnSy06FITa9WcEmwu9VGspTpphc+evvfNncjvC3czIOKiLLIDgYMNLGEb5VIR5HbsC4lwkk0N64lDoD71EsK/JJYkA6gpBMpjhBE3RZvs0PiPWETPPi+rz6BTllRWY8jqL5pUGbu7YkkP59Es+h5nhcz34NitFIOzN978O3xCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BSkbj5VRaCAxGJ1GmTK7qJaqs5DHoBykOaEKp4iAUk=;
 b=QGL/Ev1jOBn5imVSWoIIQMIeWfeen5vWOGqGgxDKAjYoqNwBwCfeWJvOTiVS2TXHq68g8jsqFx44ByyjzO7frVA9RI6tqsEdfSfLzW+ypTtaZ7PbzHEbOHB3lLFqnFBfEizjIa+nVCUHtjx9WnJr8jZlN5VhH7k1BhVYEYJaNXLBt4nVVbrc8vFrW0NTitTBoHdC7SOh7qX+57cc8u/OC7Kj7KNEYhxvDKhkBcLT0u+GpErjiRsTbIikA5LBUVb8mBNAk5rHk2QRsV+drBIfspuRPkylgwwxYSE/ti9ZGB1p0L/mtugYLFP5rYf7yZzFPccH+hBiUI9KhJtB3IBWIw==
Received: from SJ0PR22MB2795.namprd22.prod.outlook.com (2603:10b6:a03:3e7::10)
 by LV8PR22MB5391.namprd22.prod.outlook.com (2603:10b6:408:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 07:51:06 +0000
Received: from SJ0PR22MB2795.namprd22.prod.outlook.com
 ([fe80::2ffe:8aca:ae2e:3a85]) by SJ0PR22MB2795.namprd22.prod.outlook.com
 ([fe80::2ffe:8aca:ae2e:3a85%7]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 07:51:06 +0000
From: Kari Sivonen <kari.sivonen@live.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Kari Sivonen <kari.sivonen@live.com>
Subject: [PATCH] fetch2/svn: Fix mirroring issue with svn
Thread-Topic: [PATCH] fetch2/svn: Fix mirroring issue with svn
Thread-Index: AQHaq1N0kHy18PghjEysR+P2RdMWRA==
Date: Tue, 21 May 2024 07:51:06 +0000
Message-ID: 
 <SJ0PR22MB2795A6612E85C6D7B2D5CAB7FAEA2@SJ0PR22MB2795.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [HyCevZkT16pq8hPar4Zz8Ii06ua+3n1W]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR22MB2795:EE_|LV8PR22MB5391:EE_
x-ms-office365-filtering-correlation-id: 8780db50-df2a-4041-f78d-08dc796ac543
x-microsoft-antispam: 
 BCL:0;ARA:14566002|461199019|440099019|3412199016|102099023|3430499023|1710799017;
x-microsoft-antispam-message-info: 
 9zU9ZOjBp+gNuKWovYo3Q6zuqC9+SQlLAKcPZv0bDibjtYMAvBxmHyPkjdfYTjkbxZgsNgz+Oo3u0bt2OZicOObDx6NePK2VRz4ru8ra0bjNUbZkT/4/NHS+DfgMzud6DarK8rkg+5lLg3mvML7tNVgX4yCTSg/IHkGKCSurYgQiQkqlgzepebe2meKyzlABiWjzGpLAap5adDk+RDWKE7cHQA9voQJoPm2Bbcj6+MePCDZnrYuhxg9/Vg0Tjezr4qSQrjr0t7aszGg0bCptDZZXeC+MMsNneHm5OadEWCnvR3HxbeE4ZzrRw/pvwswMi3HdsCd81pUxxOdDKWLWysiO89G0YP8FgsftmJF6SnG3OhFIDmmdQgC70QXBCesdyLBTjgmjCRfGTMBsAaoKwc36erAduSdbUfbbfFQYOYMfIWVK2H20SYnUDPS5Y2aEiulffZ+JSMbBWr+1lCu6wZKLx6BI3k9zbH9BgEETUWM6cj5F7fN1NbT2pxGYryoFW3srhC5RzgynX1FhHj8OSq5TfkeyZ6bEg+j2hkK7BxBuTAJmWWpcMGAaxVk8p6V4Fya0hl2IfmR3OBHFKhZ3r5kqXTbJR9fAJ+8I82X5L6+1S/yy+oDCkbNNd2osvB8V
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?y2lSr8bjb0cO6H1EdJWxDInnCPPPtT/Yzl/vUQxMYOFjwAwcBt0/k4i+0m?=
 =?iso-8859-1?Q?eHTUdxw5N7sMoxzn+40e14Osquzq7gbP/WldSne9BZas9k0xZODSO0oUU6?=
 =?iso-8859-1?Q?ZAMIcqY+GOCKe6HCC71cvaIXPYDzRI+ILnGFKIl2JKpzHcgYgtfwl6UOSU?=
 =?iso-8859-1?Q?5xTpXOvvDL2fORdJ7YzQLxoY6pFBxl1JBmjd4THz0cMsgp2gKOt1wqVbnV?=
 =?iso-8859-1?Q?fKubOTBKrIiV7dsVhRqIcB0v2v6iwxyXfeb58MLTI7E8kjooKfDkltcbDM?=
 =?iso-8859-1?Q?ATEoNxtMcTnK0yKRJ+rxc5HUVIlWYTFv7AFGYLZadpfxj0G560kNCwjCbB?=
 =?iso-8859-1?Q?E6T8jzlHYV3ey4qSyOuIsOvZC6sHSCUO5Fsrn7aNtk3QdariMcKKCOkf/n?=
 =?iso-8859-1?Q?YfA03iJGLf6nZEdvJgkRnjQHq7hlLh9jflFYcLeKmfbqSzyyciStjswDBB?=
 =?iso-8859-1?Q?4RS12D3SM39L4u36m19SsfFbwOmwBCTghWwgZ2uVkLGk4iPBSjZcbNyAXg?=
 =?iso-8859-1?Q?y2Z+u5RwWGROaDc1TqcVqT3eNHYveuww4rKB3Sa1SP8dEf7pMCaKFH6dZ+?=
 =?iso-8859-1?Q?Kkt7azHl4/MO1KWuSLJbM+/334C0Ke8FYbf7RlGCVNPQ8sEcw58SyjaZnd?=
 =?iso-8859-1?Q?2kOY9d9JSemGZ0ZGVOoPNm7VPGQmBjR4xTQaxviNL0hWq8IjLnY2Z/x3wR?=
 =?iso-8859-1?Q?IAWcD4P7OhHnnsMOvYVSFI1AJ5VDfesrpyPhQLfNl1jEG33OMrIOu6YWdi?=
 =?iso-8859-1?Q?nFNbNcWIFyITwwaNQ0N9EbP6YXxHa+bVOIU9oDD4I8NZjtKe+E2SxgbYzL?=
 =?iso-8859-1?Q?xb+qxpIB6QK7evp0VPebde5dDhCdU37TPbqZ4moOmICLpBCfeliUeTk9nz?=
 =?iso-8859-1?Q?rtFucTfxSAx6NXnuNlanfuEB0xyxOX4e1N9EopK0J8v70b9oVWJwI084V9?=
 =?iso-8859-1?Q?mVTzqQ86F30rmP9QNlYuC2kRsDJ9rlaiGB+P2yXR8/zUq0oIqKTq4bOXGM?=
 =?iso-8859-1?Q?/pnWuTvo7VZXVC8jcnYy+W/o7/9/5hXHliT2X7lUagN0efg5oZ/UxgLZ1b?=
 =?iso-8859-1?Q?v8uFnSyoUgjaOF/yM3/CA8rsT6hTdSF1M0FWeow1K1ECWd4t5lAuyy8tz/?=
 =?iso-8859-1?Q?ev5oERGI1QgKY6Vo2xQGRQuwB/vUewfTbHSOpU+Ee7SseKs/FfhIOcVibY?=
 =?iso-8859-1?Q?OmJuBbmkQtDBf2CSQknTBA8CUd23Z/VKxQm+Z+ageTz+e9+8T1GO7Ns/nK?=
 =?iso-8859-1?Q?tYb8J9EJlL0L7jCcrUHA=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR22MB2795A6612E85C6D7B2D5CAB7FAEA2SJ0PR22MB2795namp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c3c87.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR22MB2795.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8780db50-df2a-4041-f78d-08dc796ac543
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:51:06.2280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5391
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 May 2024 07:51:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16235

--_000_SJ0PR22MB2795A6612E85C6D7B2D5CAB7FAEA2SJ0PR22MB2795namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

There was bug in first fix of svn mirror fix for [YOCTO #15473]

svn to svn mirror fixed in first commit but it broke svn to other mirrors
This commit fix those other mirrors back to original way of working
---
 lib/bb/fetch2/__init__.py | 10 ++++++++++
 lib/bb/tests/fetch.py     |  5 +++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5bf2c4b8c..cfe6d5025 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -472,6 +472,16 @@ def uri_replace(ud, uri_find, uri_replace, replacement=
s, d, mirrortarball=3DNone):
                     uri_find_decoded[5] =3D {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
                     basename =3D os.path.basename(ud.localpath)
+                elif ud.localpath and uri_decoded[0] =3D=3D "svn" and uri_=
replace_decoded[0] !=3D "svn":
+                    #When added svn fetcher that supports_checksum return =
false
+                    #all mirrors for svn skip all basename sets. That is o=
k for svn -> svn  mirrors
+                    #but other mirrors not work anymore. Example you want =
use tar balls for svn from https server
+                    #This elif will catch cases where svn mirros gone befo=
re svn mirror fix
+                    #This is basically same than first if branch except no=
 mirrortarball set. Can it some how set for svn uris?
+                    basename =3D os.path.basename(ud.localpath)
+                    # Kill parameters, they make no sense for mirror tarba=
lls
+                    uri_decoded[5] =3D {}
+                    uri_find_decoded[5] =3D {}
                 if basename:
                     uri_basename =3D os.path.basename(uri_decoded[loc])
                     # Prefix with a slash as a sentinel in case
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ed7a39a72..934c19e0e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -512,7 +512,8 @@ class MirrorUriTest(FetcherTest):
                 "git://someserver.org/bitbake git://git.openembedded.org/b=
itbake " \
                 "https://.*/.* file:///someotherpath/downloads/ " \
                 "http://.*/.* file:///someotherpath/downloads/ " \
-                "svn://svn.server1.com/ svn://svn.server2.com/"
+                "svn://svn.server1.com/ svn://svn.server2.com/ " \
+                "svn://svn.server1.com/ file:///someotherpath/downloads/ "

     def test_urireplace(self):
         self.d.setVar("FILESPATH", ".")
@@ -541,7 +542,7 @@ class MirrorUriTest(FetcherTest):
         fetcher =3D bb.fetch.FetchData("svn://svn.server1.com/isource/svnr=
oot/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;r=
ev=3D2", self.d)
         mirrors =3D bb.fetch2.mirror_from_string(self.mirrorvar)
         uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
-        self.assertEqual(uris, ['svn://svn.server2.com/isource/svnroot/rep=
oname/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;rev=3D2'=
])
+        self.assertEqual(uris, ['svn://svn.server2.com/isource/svnroot/rep=
oname/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;rev=3D2'=
, 'file:///someotherpath/downloads/isource/svnroot/reponame/tags/path_in_ta=
gnamefolder_svn.server1.com_.isource.svnroot.reponame.tags.tagname_2_1.tar.=
gz'])

     def test_mirror_of_mirror(self):
         # Test if mirror of a mirror works
--
2.40.1

--_000_SJ0PR22MB2795A6612E85C6D7B2D5CAB7FAEA2SJ0PR22MB2795namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
There was bug in first fix of svn mirror fix for [YOCTO #15473]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
svn to svn mirror fixed in first commit but it broke svn to other mirrors</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
This commit fix those other mirrors back to original way of working</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
---</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;lib/bb/fetch2/__init__.py | 10 ++++++++++</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;lib/bb/tests/fetch.py &nbsp; &nbsp; | &nbsp;5 +++--</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;2 files changed, 13 insertions(+), 2 deletions(-)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
index 5bf2c4b8c..cfe6d5025 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--- a/lib/bb/fetch2/__init__.py</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+++ b/lib/bb/fetch2/__init__.py</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -472,6 +472,16 @@ def uri_replace(ud, uri_find, uri_replace, replacement=
s, d, mirrortarball=3DNone):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;uri_find_decoded[5] =3D {}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;elif ud.local=
path and ud.method.supports_checksum(ud):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;basename =3D os.path.basename(ud.localpath)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;elif ud.localpath =
and uri_decoded[0] =3D=3D &quot;svn&quot; and uri_replace_decoded[0] !=3D &=
quot;svn&quot;:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#Whe=
n added svn fetcher that supports_checksum return false</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#all=
 mirrors for svn skip all basename sets. That is ok for svn -&gt; svn &nbsp=
;mirrors</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#but=
 other mirrors not work anymore. Example you want use tar balls for svn fro=
m https server</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#Thi=
s elif will catch cases where svn mirros gone before svn mirror fix</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#Thi=
s is basically same than first if branch except no mirrortarball set. Can i=
t some how set for svn uris?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;base=
name =3D os.path.basename(ud.localpath)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# Ki=
ll parameters, they make no sense for mirror tarballs</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uri_=
decoded[5] =3D {}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uri_=
find_decoded[5] =3D {}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if basename:<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;uri_basename =3D os.path.basename(uri_decoded[loc])</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;# Prefix with a slash as a sentinel in case</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
index ed7a39a72..934c19e0e 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--- a/lib/bb/tests/fetch.py</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+++ b/lib/bb/tests/fetch.py</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -512,7 +512,8 @@ class MirrorUriTest(FetcherTest):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;git://s=
omeserver.org/bitbake git://git.openembedded.org/bitbake &quot; \</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;https:/=
/.*/.* file:///someotherpath/downloads/ &quot; \</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;http://=
.*/.* file:///someotherpath/downloads/ &quot; \</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;svn://svn.se=
rver1.com/ svn://svn.server2.com/&quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;svn://svn.se=
rver1.com/ svn://svn.server2.com/ &quot; \</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;svn://svn.se=
rver1.com/ file:///someotherpath/downloads/ &quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;def test_urireplace(self):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar(&quot;FILESPATH&quot;, &quo=
t;.&quot;)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
@@ -541,7 +542,7 @@ class MirrorUriTest(FetcherTest):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fetcher =3D bb.fetch.FetchData(&quot;svn:=
//svn.server1.com/isource/svnroot/reponame/tags/tagname;module=3Dpath_in_ta=
gnamefolder;protocol=3Dhttps;rev=3D2&quot;, self.d)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mirrors =3D bb.fetch2.mirror_from_string(=
self.mirrorvar)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uris, uds =3D bb.fetch2.build_mirroruris(=
fetcher, mirrors, self.d)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp; &nbsp; &nbsp;self.assertEqual(uris, ['svn://svn.server2.com=
/isource/svnroot/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;proto=
col=3Dhttps;rev=3D2'])</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp;self.assertEqual(uris, ['svn://svn.server2.com=
/isource/svnroot/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;proto=
col=3Dhttps;rev=3D2', 'file:///someotherpath/downloads/isource/svnroot/repo=
name/tags/path_in_tagnamefolder_svn.server1.com_.isource.svnroot.reponame.t=
ags.tagname_2_1.tar.gz'])</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;def test_mirror_of_mirror(self):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# Test if mirror of a mirror works</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
2.40.1</div>
</body>
</html>

--_000_SJ0PR22MB2795A6612E85C6D7B2D5CAB7FAEA2SJ0PR22MB2795namp_--

