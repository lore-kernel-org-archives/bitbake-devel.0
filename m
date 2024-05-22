Return-Path: <kari.sivonen@live.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659FC25B78
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 15:42:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.92.21.37])
 by mx.groups.io with SMTP id smtpd.web10.693.1716392528040616233
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 May 2024 08:42:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@live.com header.s=selector1 header.b=N9k+bkzE;
 spf=pass (domain: live.com, ip: 40.92.21.37, mailfrom: kari.sivonen@live.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntxfpo+3ask4E/iwAdcPEuBoBmL5STzYTuX8dTqjjOqQw/mnRyLGYMCeai8wrgJjGYkCGJCT2hg7weUq78J0eY2hidlvVfUD8w+AgCvOwF9EMzDc/SmIS1frV0B8BBHL6Jc6OBgYlPQ4SSobCX2aJQQ/faEoH4kp9a4L5eE/Mtngw2Z9LEEqIvWuElCt1YvdjsUyjPQZI2C6QfRbXkVjeQdLGxeDaWsAaOUtWVGhTS/oRgL0p43fURyQ6mY9obhSS7Cr2oIWHp4EDmmq8OKN00w24kA1IxL5r/affxLFLPdj3J6r3MSNmp7wl/yijd642QVQ4GsqCpgRTWYkpofq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUGnVAl5N3hP8TnvpxoxZ9lACbOyunVA5qI8ACa66Ic=;
 b=TgnHLs1mlNooxy7f5LvytDFesXgAs/7rEf584ykE6U5LIKH0jMRVcOWlvcaZ/kG4miQjR+ynnBNUfP6TAWRcMFoGrkfO4IIRdrBSjQvvJJLDUbd4Os7TljGpWy5s5ZLSsUxgaYq91pE5TEDoWUGl88hBaVv4lWqtkqLXk7fMRRSsR6NSmxmIz5SsuBnbVslhCGklTdqrCNdMcn2F5smfoh01aIwLpaeTTWr9AnicTYgt7YbGbwC13KQlFc8nZN+wgXP9pJ6y7xMm7Z0wY3d/mCSzloHgrZHbc/0WklH5RmWTRE36FlRa+PFA+Ayp+4sPntSmNW0xlCG+VYlrKyw8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUGnVAl5N3hP8TnvpxoxZ9lACbOyunVA5qI8ACa66Ic=;
 b=N9k+bkzEUbiMMBfDmn7j6tgxD+MgbZlRId1YwPRWtKEX8jfSfc0VLTmUGdg/lwAPXTvKwR9qQiuIW8W+iCCEFwOjjC+n/kYXfKTxQ5IHomo/E83DeeFYpgMCv5ZlrPMZ59VH0P+c3WTPciuetR7B7lNa8j5a7tNsgXJ3T0IPq76nfms/aOa/yUPqDdXXfJvwnZRNuFssmoD1q+YOMQMElckqOXgGKVHH2gPPHNt+NeRkKQdRM+mvSPJhzQoruw/Gp1SO+bk3x9r7spAWCdt0hX6lGZbKdx2xbOLcC7b5vdJLsR//gOZAEgZJukOY1V29oIPWFKd+q31D9NveIkW9aw==
Received: from SJ0PR22MB2795.namprd22.prod.outlook.com (2603:10b6:a03:3e7::10)
 by PH0PR22MB3810.namprd22.prod.outlook.com (2603:10b6:510:293::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 15:42:04 +0000
Received: from SJ0PR22MB2795.namprd22.prod.outlook.com
 ([fe80::2ffe:8aca:ae2e:3a85]) by SJ0PR22MB2795.namprd22.prod.outlook.com
 ([fe80::2ffe:8aca:ae2e:3a85%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 15:42:04 +0000
From: Kari Sivonen <kari.sivonen@live.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/svn: Fix mirroring issue with svn
Thread-Topic: [bitbake-devel] [PATCH] fetch2/svn: Fix mirroring issue with svn
Thread-Index: AQHaq1N0kHy18PghjEysR+P2RdMWRLGha/CAgAH4r1Q=
Date: Wed, 22 May 2024 15:42:03 +0000
Message-ID: 
 <SJ0PR22MB2795FD04B582271532772B29FAEB2@SJ0PR22MB2795.namprd22.prod.outlook.com>
References: 
 <SJ0PR22MB2795A6612E85C6D7B2D5CAB7FAEA2@SJ0PR22MB2795.namprd22.prod.outlook.com>
 <3ba09bcb4470474afe149153ad7b2571f2451e38.camel@linuxfoundation.org>
In-Reply-To: 
 <3ba09bcb4470474afe149153ad7b2571f2451e38.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [9j3wuTSLesRTuK0a+kTJABwFhzTG1Y75]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR22MB2795:EE_|PH0PR22MB3810:EE_
x-ms-office365-filtering-correlation-id: 332dad9c-4dca-4584-e9a8-08dc7a75ba8d
x-microsoft-antispam: 
 BCL:0;ARA:14566002|461199019|440099019|3412199016|3430499023|102099023;
x-microsoft-antispam-message-info: 
 +9qJvvIS+JwkByRqET+Sr7b0Zi3O1MtdwjVWhLeLduHVaTx3xuOhXtHnl172BNejXe8dENtmHgXB8In0Tu0FS6UmIhleGa1hXfDY2a5FibuZ97P2wtTUpwlzoYsTynz89gqMUWx7n4tNqGdMKcaBb92Dmn6A0ek7L0AAfuY10GrBoVRDXYoDSY/gIzDcwqDAFXX6FJEjCfP3FmsUTcL8LbTHzFDFdfEhGJP33A9Sg5hnPtLCyllNEUBWFrCAHCgy1QVOjrV7BoEqcfna8EaGnwCfJZiBq16yn/JTrbdT6AODedxveyKYHqppYi1NeSlojIl5+uq2AzxDhR+YfZSyFqRulzat5SimvHVDQbVghMCTPGtSGFw3ndYu65rbtoLIpEcbjqFEmxDkPapehKMCzg3d60Exzm6za8f/CDb7r0Xvrk0en/P3oQFUVpzLZTqgF/eZF+xfeE+/WAhjyxNT8fOltIXlMEgcW4vwtoyIHeFGSFeAvvEJVf0Mb402DhSY8ZY2Ns2W3ZGqfG8k9OhWLbt+SCnbzLE/cfpUULVf2gCw9cUuDd6bnmiqx5yunzpg
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0G/Zoj/+pSwziF8ExxIuleXWntoymG1Yzk13QpFRdsLsWiWa1daj5WplOa/Y?=
 =?us-ascii?Q?yQPRo3JVNJmzwQsY+I60nqJRHkTKGuMY2dmJ20+kfO94cSEYF4fPiu9A5tD7?=
 =?us-ascii?Q?CUeNYiZzspmLnBHQR51/nJoX9FOoobH//UxhbIpPnT1z0UkY47xC8tPVmP3n?=
 =?us-ascii?Q?tcO1xbdyEgN+oc2BlEHVCSTLfkojUkyeDFzrVXV0oVRaz+/diqsz67c4fzDq?=
 =?us-ascii?Q?IW0VRtCiGfupFZoLlwrcN5CdrL4XBMxjIVua20o/zHdYg1GuFAuV7mcOrVqS?=
 =?us-ascii?Q?5UxHAcDQdj2sVek9mpRctnZaRBrtWle2ok3DhZi8weCZss6pl9fGuJpYKK5n?=
 =?us-ascii?Q?Ysm8VZf1VpOWLFQMMlHNeW0zIbQx1f8ZtEEFD0l5GDMca7bEu8qQC7kc6KEn?=
 =?us-ascii?Q?brpwUlH98mqiimFCzhuPFIHDNFWkL2WJ/+5Nt3D7BU1JD6dH98wGISLIEe4f?=
 =?us-ascii?Q?ocOOLdHsz9q72NfMM9VBPf/chDnRogRVnKr/BCLc54aUAF92irMWEOfm2qQI?=
 =?us-ascii?Q?VUqPZr1o+8nyVLNHC5zXepBSVTogM2U60U3Bwq2K13P6vP1tnQuaSyM9jEEf?=
 =?us-ascii?Q?f2YD/Z8cz9rJ9MijwWBBp61663OiIrwNDRM9jxn+SIeVBg8xVOyg30769yJn?=
 =?us-ascii?Q?0zoSRFkNTOW8D8f6zU8l6LwoEdbrkh4vIw0828nvdw2nc6UBd5v4yMX2E8Xq?=
 =?us-ascii?Q?TRBrmsbddCn0WeASDCowZlWLEPVzwv+gxd2AzlBi9ASkqIwCnXkwX5QwhIlw?=
 =?us-ascii?Q?YV85huC6A5KWXuK5Gswc5biEIgJtIWust/mbEcmPNJTtEyLM2HWfz3zTKYGd?=
 =?us-ascii?Q?3NGttVSsle4cwYOrGBa5sLRbz0dlCGEWkiXA4A/gTTH/DoWmfC69VdBEjQNP?=
 =?us-ascii?Q?z+YQDHIU/LdqrW6l0WOiE7LZQLlzOsOcaSwPh8QClw8Z0u4KBfRsuVwLmCQS?=
 =?us-ascii?Q?6YkVNnXh8or4sQASYWT0FnkXzLeqCW8JI3dRp6xoJA6liSE/3L8Wc5rqVFzf?=
 =?us-ascii?Q?ZAbf1AwLCIkRpsp99sHpqcOG8SDYqi7Xzfg5jBPwurY0lSzZ/XhQPgyGb/WW?=
 =?us-ascii?Q?Yjg4cxshfnicaOqMc2I3npU8oomkf5addHH7sCqaDWKIO45LjPKYyW7EVp12?=
 =?us-ascii?Q?zeN0dpBeq/2aGUHKnVYFk6bHbXg8TI4SYQ+X4oWq/i7W/qxp5v8urIq+2V2T?=
 =?us-ascii?Q?1JCUnV3ox9MXsl5yw5RZcjLUIMeczPDPDiH0Dg=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR22MB2795FD04B582271532772B29FAEB2SJ0PR22MB2795namp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c3c87.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR22MB2795.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 332dad9c-4dca-4584-e9a8-08dc7a75ba8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 15:42:03.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3810
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 15:42:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16239

--_000_SJ0PR22MB2795FD04B582271532772B29FAEB2SJ0PR22MB2795namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think original change was correct in way that it fix svn to svn mirroring=
. Now I also added handling of svn to other mirroring. I saw there is alrea=
dy if clause which would do the correct thing if mirrortarball is set. But =
I am not sure where it can set and what all and where it will affect if is =
set. That why I set svn specific if else there that no any other place need=
 to change. I also added test case for svn to file mirroring. Maybe it can =
be tested with this new test without any svn changes if svn to file mirrori=
ng works like with this change.

-Kari
________________________________
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Sent: Tuesday, May 21, 2024 12:28 PM
To: kari.sivonen@live.com <kari.sivonen@live.com>; bitbake-devel@lists.open=
embedded.org <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/svn: Fix mirroring issue with s=
vn

On Tue, 2024-05-21 at 07:51 +0000, Kari Sivonen via lists.openembedded.org =
wrote:
>
> There was bug in first fix of svn mirror fix for [YOCTO #15473]
>
>
> svn to svn mirror fixed in first commit but it broke svn to other mirrors
> This commit fix those other mirrors back to original way of working
> ---
>  lib/bb/fetch2/__init__.py | 10 ++++++++++
>  lib/bb/tests/fetch.py     |  5 +++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 5bf2c4b8c..cfe6d5025 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -472,6 +472,16 @@ def uri_replace(ud, uri_find, uri_replace, replaceme=
nts, d, mirrortarball=3DNone):
>                      uri_find_decoded[5] =3D {}
>                  elif ud.localpath and ud.method.supports_checksum(ud):
>                      basename =3D os.path.basename(ud.localpath)
> +                elif ud.localpath and uri_decoded[0] =3D=3D "svn" and ur=
i_replace_decoded[0] !=3D "svn":
> +                    #When added svn fetcher that supports_checksum retur=
n false
> +                    #all mirrors for svn skip all basename sets. That is=
 ok for svn -> svn  mirrors
> +                    #but other mirrors not work anymore. Example you wan=
t use tar balls for svn from https server
> +                    #This elif will catch cases where svn mirros gone be=
fore svn mirror fix
> +                    #This is basically same than first if branch except =
no mirrortarball set. Can it some how set for svn uris?
> +                    basename =3D os.path.basename(ud.localpath)
> +                    # Kill parameters, they make no sense for mirror tar=
balls
> +                    uri_decoded[5] =3D {}
> +                    uri_find_decoded[5] =3D {}
>                  if basename:
>                      uri_basename =3D os.path.basename(uri_decoded[loc])
>                      # Prefix with a slash as a sentinel in case
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index ed7a39a72..934c19e0e 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -512,7 +512,8 @@ class MirrorUriTest(FetcherTest):
>                  "git://someserver.org/bitbake git://git.openembedded.org=
/bitbake " \
>                  "https://.*/.* file:///someotherpath/downloads/ " \
>                  "http://.*/.* file:///someotherpath/downloads/ " \
> -                "svn://svn.server1.com/ svn://svn.server2.com/"
> +                "svn://svn.server1.com/ svn://svn.server2.com/ " \
> +                "svn://svn.server1.com/ file:///someotherpath/downloads/=
 "
>
>      def test_urireplace(self):
>          self.d.setVar("FILESPATH", ".")
> @@ -541,7 +542,7 @@ class MirrorUriTest(FetcherTest):
>          fetcher =3D bb.fetch.FetchData("svn://svn.server1.com/isource/sv=
nroot/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps=
;rev=3D2", self.d)
>          mirrors =3D bb.fetch2.mirror_from_string(self.mirrorvar)
>          uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.=
d)
> -        self.assertEqual(uris, ['svn://svn.server2.com/isource/svnroot/r=
eponame/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;rev=3D=
2'])
> +        self.assertEqual(uris, ['svn://svn.server2.com/isource/svnroot/r=
eponame/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;rev=3D=
2', 'file:///someotherpath/downloads/isource/svnroot/reponame/tags/path_in_=
tagnamefolder_svn.server1.com_.isource.svnroot.reponame.tags.tagname_2_1.ta=
r.gz'])
>
>      def test_mirror_of_mirror(self):
>          # Test if mirror of a mirror works


I took the original patch since it seemed to make sense and was simple
with a test case.

This patch is adding fetcher specific conditionals into the core code
and this always worries me. You'll note we don't have many, if any of
these cases currently.

That makes me wonder if there isn't a better way to solve this somehow.
It also makes me wonder if the original change was correct :/. I
certainly don't like the if block above being added.

Cheers,

Richard


--_000_SJ0PR22MB2795FD04B582271532772B29FAEB2SJ0PR22MB2795namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think original change was correct in way that it fix svn to svn mirroring=
. Now I also added handling of svn to other mirroring. I saw there is alrea=
dy if clause which would do the correct thing if mirrortarball is set. But =
I am not sure where it can set and
 what all and where it will affect if is set. That why I set svn specific i=
f else there that no any other place need to change. I also added test case=
 for svn to file mirroring. Maybe it can be tested with this new test witho=
ut any svn changes if svn to file
 mirroring works like with this change.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
-Kari</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Richard Purdie &lt;ri=
chard.purdie@linuxfoundation.org&gt;<br>
<b>Sent:</b> Tuesday, May 21, 2024 12:28 PM<br>
<b>To:</b> kari.sivonen@live.com &lt;kari.sivonen@live.com&gt;; bitbake-dev=
el@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH] fetch2/svn: Fix mirroring issue=
 with svn</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, 2024-05-21 at 07:51 +0000, Kari Sivonen vi=
a lists.openembedded.org wrote:<br>
&gt; <br>
&gt; There was bug in first fix of svn mirror fix for [YOCTO #15473]<br>
&gt; <br>
&gt; <br>
&gt; svn to svn mirror fixed in first commit but it broke svn to other mirr=
ors<br>
&gt; This commit fix those other mirrors back to original way of working<br=
>
&gt; ---<br>
&gt; &nbsp;lib/bb/fetch2/__init__.py | 10 ++++++++++<br>
&gt; &nbsp;lib/bb/tests/fetch.py &nbsp; &nbsp; | &nbsp;5 +++--<br>
&gt; &nbsp;2 files changed, 13 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
&gt; index 5bf2c4b8c..cfe6d5025 100644<br>
&gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; @@ -472,6 +472,16 @@ def uri_replace(ud, uri_find, uri_replace, replac=
ements, d, mirrortarball=3DNone):<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;uri_find_decoded[5] =3D {}<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;elif ud.=
localpath and ud.method.supports_checksum(ud):<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;basename =3D os.path.basename(ud.localpath)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;elif ud.local=
path and uri_decoded[0] =3D=3D &quot;svn&quot; and uri_replace_decoded[0] !=
=3D &quot;svn&quot;:<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;#When added svn fetcher that supports_checksum return false<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;#all mirrors for svn skip all basename sets. That is ok for svn -&gt; svn =
&nbsp;mirrors<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;#but other mirrors not work anymore. Example you want use tar balls for sv=
n from https server<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;#This elif will catch cases where svn mirros gone before svn mirror fix<br=
>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;#This is basically same than first if branch except no mirrortarball set. =
Can it some how set for svn uris?<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;basename =3D os.path.basename(ud.localpath)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;# Kill parameters, they make no sense for mirror tarballs<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;uri_decoded[5] =3D {}<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;uri_find_decoded[5] =3D {}<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if basen=
ame:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;uri_basename =3D os.path.basename(uri_decoded[loc])<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;# Prefix with a slash as a sentinel in case<br>
&gt; diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br>
&gt; index ed7a39a72..934c19e0e 100644<br>
&gt; --- a/lib/bb/tests/fetch.py<br>
&gt; +++ b/lib/bb/tests/fetch.py<br>
&gt; @@ -512,7 +512,8 @@ class MirrorUriTest(FetcherTest):<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;gi=
t://someserver.org/bitbake git://git.openembedded.org/bitbake &quot; \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;<a=
 href=3D""></a>https://.*/.* <a href=3D"file:///someotherpath/downloads/">
file:///someotherpath/downloads/</a> &quot; \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;<a=
 href=3D""></a>http://.*/.* <a href=3D"file:///someotherpath/downloads/">
file:///someotherpath/downloads/</a> &quot; \<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;svn://s=
vn.server1.com/ svn://svn.server2.com/&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;svn://s=
vn.server1.com/ svn://svn.server2.com/ &quot; \<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;svn://s=
vn.server1.com/ <a href=3D"file:///someotherpath/downloads/">
file:///someotherpath/downloads/</a> &quot;<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; &nbsp;def test_urireplace(self):<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar(&quot;FILESPATH&quot;,=
 &quot;.&quot;)<br>
&gt; @@ -541,7 +542,7 @@ class MirrorUriTest(FetcherTest):<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fetcher =3D bb.fetch.FetchData(&quot=
;svn://svn.server1.com/isource/svnroot/reponame/tags/tagname;module=3Dpath_=
in_tagnamefolder;protocol=3Dhttps;rev=3D2&quot;, self.d)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mirrors =3D bb.fetch2.mirror_from_st=
ring(self.mirrorvar)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uris, uds =3D bb.fetch2.build_mirror=
uris(fetcher, mirrors, self.d)<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;self.assertEqual(uris, ['svn://svn.server=
2.com/isource/svnroot/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;=
protocol=3Dhttps;rev=3D2'])<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;self.assertEqual(uris, ['svn://svn.server=
2.com/isource/svnroot/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;=
protocol=3Dhttps;rev=3D2', '<a href=3D"file:///someotherpath/downloads/isou=
rce/svnroot/reponame/tags/path_in_tagnamefolder_svn.server1.com_.isource.sv=
nroot.reponame.tags.tagname_2_1.tar.gz">file:///someotherpath/downloads/iso=
urce/svnroot/reponame/tags/path_in_tagnamefolder_svn.server1.com_.isource.s=
vnroot.reponame.tags.tagname_2_1.tar.gz</a>'])<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; &nbsp;def test_mirror_of_mirror(self):<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# Test if mirror of a mirror works<b=
r>
<br>
<br>
I took the original patch since it seemed to make sense and was simple<br>
with a test case.<br>
<br>
This patch is adding fetcher specific conditionals into the core code<br>
and this always worries me. You'll note we don't have many, if any of<br>
these cases currently.<br>
<br>
That makes me wonder if there isn't a better way to solve this somehow.<br>
It also makes me wonder if the original change was correct :/. I<br>
certainly don't like the if block above being added.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR22MB2795FD04B582271532772B29FAEB2SJ0PR22MB2795namp_--

