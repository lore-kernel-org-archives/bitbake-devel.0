Return-Path: <Nicholas.Jackson@zii.aero>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0BCC433F5
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 17:55:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.42])
 by mx.groups.io with SMTP id smtpd.web09.302.1664560530847603543
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Sep 2022 10:55:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zodiacii.onmicrosoft.com
 header.s=selector2-zodiacii-onmicrosoft-com header.b=BPKKZpTP;
 spf=pass (domain: zii.aero, ip: 40.107.243.42,
 mailfrom: nicholas.jackson@zii.aero)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCkOQPEbk01zoKm32xLPLn+34PtlYRGj3tK/1gS/XkeqdC0Qc0B7BHE0aLAr8bJQcZXCRbA3UpOsmYcpwlYF/k+3Ug0jvN5KB9T9SfwBnkWqF/b3lvK9P72QKm7NOBeHiEd/4zNgnFNoQ7lH+0ge4kIflDvmParIHAKIlOKXHn1xmuyrCkm5Mdu1F8ysNTQuOOOhORvcGdVp5vjFFJ+xtNfxYVEIHLwtloGFLDppsntTzzBpQxtaFhCPU5xkD5NY7mzd6OYxPVN02/3HUSo0yElhcITYnUDGtcIkMN9mtnnsYD4QetZD6zxZCsGUbckzjKAZEdUiEqEdS83LNeaZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3fVLbtFvSaua2LcIdYmbntJ1N68rDKwi+fu3eLIphk=;
 b=Jzk51zCs3WUocHb6SIqTJCAgo2Dmmf2Lq2znP65oo52nWGlnglGUGolx8YbgH3AapYUqSLYRKHCR9fBrEWFYVkHhP2Vl/orJbWzwN9HGVqbN2qH4aDy7NPOcpz/+2+XT57aUxqskiMkSgNay8Xi+Nwu7ECjQ67tAEQpbxt8M46Q0229E5/nhPcGaB2HJssuuDgYDcjqUkkeL8jF9xuxv+I7LrBim3qhT9PTUA1PU8ihMSbFI4qnTEAb84uYG0qKGpLeb0Q7U90JGP8CNnxy7wmaz33eAyEb6jbw48PMIamrPRQP7X4Itp0noxTF8k0Lgf/NsZJjWt2DhEs2d0CqbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zii.aero; dmarc=pass action=none header.from=zii.aero;
 dkim=pass header.d=zii.aero; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zodiacii.onmicrosoft.com; s=selector2-zodiacii-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3fVLbtFvSaua2LcIdYmbntJ1N68rDKwi+fu3eLIphk=;
 b=BPKKZpTPt+bp4A4O8q4kFHFjhfLviR/dQq9R5J4ZCi2oxKWhCeja8ccgWd8XY0osd6kzv8Reoshx+WEgZS3kwxS2O212scze1aMaUxk8MncjjeDnngQo8tiJ92n7BTOgIRArNHunV2lg6URKFRYHTEExSbfmbuB2tuBNNqF10qo=
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11)
 by CH0PR12MB5268.namprd12.prod.outlook.com (2603:10b6:610:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 17:55:29 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::cc41:66fb:c5b4:b623]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::cc41:66fb:c5b4:b623%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 17:55:28 +0000
From: Nicholas Jackson <Nicholas.Jackson@zii.aero>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake: wget: fix netrc with pseudo
Thread-Topic: [PATCH] bitbake: wget: fix netrc with pseudo
Thread-Index: AQHY1PXAIuJAgPf0bUqYJXLo7cYeDA==
Date: Fri, 30 Sep 2022 17:55:28 +0000
Message-ID: 
 <BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zii.aero;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2710:EE_|CH0PR12MB5268:EE_
x-ms-office365-filtering-correlation-id: 6a890f00-e318-476a-b207-08daa30cf60b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Af2TnppAVD1crY/mCSH9cqxlO2jO1Nf+ndxxgKX4tRnpDFgbYm9rDVYqR9gIs3mEh/89J2+1Djhbj6T9EVJQgNlCalq1SCcTY6pte8dqbxVHuSymUb77PY1OOgARPWxXtdJkgAWpb11QFFoF1aIAXvVuh5Yd5S3a4Lh43Q3eC9W/JPmIqfJtaWSiUtcQ8uaDWyJU5hIKWvJIBQhUNKhTLulwOCWUun3EMjGssBhcuVMkNFMflOX8SV93wU0SpFqlHpC3cg745CCuyH7Ex+aX6bJZPFv7g3VVngWnf6S+HbndgILfakuAXjr9yhFDTrH8t4847qKqpVPbMaIXqw0bDR2VwL4jYxEcYqvBboJWBv90Ftw8h76C8EKfQyZwLMuDstWQf46uYAKkDb6Vza8bMPIwIKruWF8yEdNhA63TTzfO4LWgLZhFz3YYfLoQktJYuabFYfHqYezQ44JgFDKdMgLTtD7qVczWIvSsiFJtpfm5oh80hX8MU2U5T8Ll3ETh6Y1U7wLY5/GpKewSWIQFjTAlh0nkr0+A9N7mOBN1jDQbR154LQRWB5U+9mmAoMdZbZbYEuSJMoDgrBX/1i3kz/OKGabkdbl0UEfVxk3DHpOX7nlqspcVHkIbEQWD2aZM928zS5SJLGhhOoO54KZJ/7TqY3RITXYdKo4b4MAHPgYmDcx1JVjdnOmydvYsFRRmLedT65rHyXMSpWmUH8Oz3GNQ9AmiUOv5VG4IeYq/bf1PpHM0n4Y9kglS2le+ZSzXKYrcO8potDm/pYFhqpnOes3Kgb5yZbTLbXXbaJCgR3Xsn+YowaQcyWRXAPHsB1Ia6QmCjAi9Rec8cHCXmkQzdJH7MjOnptStQWFzubmc+oBhEm3qRUhz7UuGKYyMV4Ju
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2710.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39850400004)(346002)(376002)(136003)(366004)(451199015)(83380400001)(478600001)(55016003)(71200400001)(38070700005)(166002)(64756008)(26005)(52536014)(132210200001)(33656002)(8936002)(2906002)(86362001)(38100700002)(5660300002)(99936003)(40140700001)(186003)(316002)(41300700001)(19627405001)(66556008)(66946007)(66476007)(8676002)(66446008)(9686003)(76116006)(91956017)(6506007)(7696005)(122000001)(6916009)(19596365001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?kyRzodQd8rm4wpQ+xuThcI+ffN12hLviNo9MIqX7djIGjVKXDRwokKEJTd?=
 =?iso-8859-1?Q?wY35IJnzQFjJCod5iaU23TXebWJ983svPyKKWzkzsUiwNBnVo3cN4Qi+3o?=
 =?iso-8859-1?Q?rna2jkcdSClukHyJ9rLL0yZ2kZdnrEih5VR4EwiWZnGdm4DGN0+lQdBZIW?=
 =?iso-8859-1?Q?2d45l7Gzh1IdeKJo+z6pLajuTGYjxyRqtCHOyv7+HD+GbNopTxp97oQcAG?=
 =?iso-8859-1?Q?TzZdM423X5SXHnmrpKygkLWedHhF09kMkZN5x9Pmab8r1wWwgtO1KfwLHI?=
 =?iso-8859-1?Q?XPJnTyPvEZNX0Z/m5EA0z2WRRAZXnOKwOJH23xGnkoEeg383rjSxrXj1SL?=
 =?iso-8859-1?Q?EBCbnM3LuN8svdZAMl8wNWSBB0Unl4O17ryjdpGLA/aISfVq6Oiz/qYB7l?=
 =?iso-8859-1?Q?S5Eis3TQiS+l7FizUIE6DOxC+kcTLaTLN20H3QGF+ivJwX9p2RjzxpIE4L?=
 =?iso-8859-1?Q?YOieKvdkjzO7oTr2ERSW3J0XicGnDfBfhwY3Qq+dRnSjl2gMney563j+AV?=
 =?iso-8859-1?Q?oI8yzCKuagwD+X1JxIyJldKfrciC9yMWApycYfn4/e4bNx/l10ULSnvQKY?=
 =?iso-8859-1?Q?qi3SOJFff6dvzscTaISeMkJ0YbA42M5ULAKJC3ot+Lliy/AuUSk4+eRe/+?=
 =?iso-8859-1?Q?aa5eSsRNSznb8xqVoNDT+osqYFKV6W22mtqQ5OU77na2X/NEJ0Af7sNTps?=
 =?iso-8859-1?Q?sYCWkI0EaO3TegsM6AEgFj94MuQ0A5rGAopwcDS6pxaHJMsdJ9oLJDh5BW?=
 =?iso-8859-1?Q?0JM+IiVIX7CpO6kCnGYpZU+6CGFdWs51p+hHpinU8rGRoqDev4/9ivCmgS?=
 =?iso-8859-1?Q?On6xDU0T2Q4Ix0KrTrLaNmM6F93s76G7XUHnYlWiMM0EbRGwTwSD7uWP1s?=
 =?iso-8859-1?Q?cILqREjLR7UFoiFkQiv7t041Rz0FvcymJiPT1IPtq3HLd069oNVWccYhfq?=
 =?iso-8859-1?Q?qY4j+SJOBlRrPjtrxz1YFmzRZkLBiDQ9/CxAgVsYD+Q8Pkysq+HLmMSQZ3?=
 =?iso-8859-1?Q?ANL9mePwcDwC7GEMNoxsyh2LgOpO10h8Hd7OtAyYDN2v3laXKvs8wePiQ6?=
 =?iso-8859-1?Q?3sbG/CytsqDyVhm/S79rksJ7x30os6l9pdXvQtu1rkP5fGIV5h5rPAcZdR?=
 =?iso-8859-1?Q?3nZCbBk98q9bpXq92zrq70C923AvVP47RcMSICy/0qNXf4txcQlOHtpz+E?=
 =?iso-8859-1?Q?3nkqanUm7Zoac4HtFCg75AWRLaCjeebedViTUC0w914rG1BIZvSFHGEdc4?=
 =?iso-8859-1?Q?SWSfFjB/3teXG1mGfUb7JEEv+0ULUtx+E2k80nNGFNQ4j8U0Ud1nA/XtdL?=
 =?iso-8859-1?Q?RR5lWbC8bp5aFBo/68yloEZCVtuyK5Isazde8kPjazYMBCc6NSJ0eVPGV3?=
 =?iso-8859-1?Q?hy8+yi4wWFwSllTKzSFTxnCcq/anTaY2ogjHmORiwCvdxqxrGyKi18eI5D?=
 =?iso-8859-1?Q?KDGLvdrp4cgyzvAE2KAbSVDWHjKPij8eJv+upWOIP8QzuMo7U2x6Q1Y4nH?=
 =?iso-8859-1?Q?9Xbn1vnonBUhw3RhrIXuu5h41c8kWhQeWmCRJKLh5vcsUh9PpRA3oU7YQM?=
 =?iso-8859-1?Q?rqSIdX2RVc+h/zrqJC2VnAWa7GtNoygyoAImrr+wZyZwr7l2PRpy+qencL?=
 =?iso-8859-1?Q?oxiuI0i3+mroalCDXSlMqzCm8tBTHtT77o?=
Content-Type: multipart/related;
	boundary="_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_";
	type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: zii.aero
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2710.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6a890f00-e318-476a-b207-08daa30cf60b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 17:55:28.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe9eec6b-f00c-4ada-ad1a-58bc081dc237
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 nTRdTzll3XmI7YFbd6uu1cET+QoYe8JDPbcqZtzxdzZ7Yiiv9hFvr7X/kiAOtpXgtY5cw1jhKA8pbtxGNXmi9f37okdmNbICtypR0mD+G4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5268
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Sep 2022 17:55:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14001

--_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_"

--_000_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Nicholas Jackson <nicholas.jackson@zii.aero>

The netrc module will refuse to use a file that is not owned by the
current user. Psuedo can trigger this failure due to a reported uid of
0. To fix this, change ownership of the default netrc file to 0:0. This
has no permanent effect on the actual netrc file.

Note that while it is not possible to ask the netrc module what the
default netrc file is, the documentation explicitly mentions that
expanduser is used.

Signed-off-by: Nicholas Jackson <nicholas.jackson@zii.aero>
---
 bitbake/lib/bb/fetch2/wget.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 821afa5b58..0ce6e25c5c 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -360,10 +360,16 @@ class Wget(FetchMethod):

                 try:
                     import netrc
+                    # Pseudo can cause ownership mismatch issues with netr=
c, which is
+                    # required to be owned by the current user (root).
+                    if os.environ.get("PSEUDO_DISABLED") =3D=3D "0":
+                        os.chown(os.path.join(os.path.expanduser("~"), ".n=
etrc"), 0, 0)
                     n =3D netrc.netrc()
                     login, unused, password =3D n.authenticators(urllib.pa=
rse.urlparse(uri).hostname)
                     add_basic_auth("%s:%s" % (login, password), r)
-                except (TypeError, ImportError, IOError, netrc.NetrcParseE=
rror):
+                except netrc.NetrcParseError as e:
+                    logger.debug("netrc failed: %s" % e)
+                except (TypeError, ImportError, IOError) as e:
                     pass

                 with opener.open(r, timeout=3D30) as response:
--
2.37.2




Nicholas JACKSON
Software Engineer II

Safran Passenger Innovations

T +1 714 854 8600 ext 527

3151 East Imperial Hwy

Brea, Ca 92821 USA

www.safran-passenger-innovations.com<http://www.safran-passenger-innovation=
s.com/>



[cid:e940da09-3ffd-4243-a1be-90740bf07b55]

[cid:4965b635-fca1-4eb7-aac6-6354afdfa6b8]<http://www.safran-group.com/subs=
cription-account?utm_source=3Dsubscribemail&utm_medium=3Dmailpro&utm_campai=
gn=3DsubscribemailEN>[cid:bda2fb5a-eb92-44b3-a349-47b31f606076]<http://www.=
safran-group.com/subscription-account?utm_source=3Dsubscribemail&utm_medium=
=3Dmailpro&utm_campaign=3DsubscribemailEN>

[cid:8e4bfd42-7dfb-40e7-9249-5a84cbaa7d15]<http://twitter.com/SAFRAN>

[cid:1eb82668-d2af-4417-a928-1c672824ea6f]<http://www.facebook.com/GroupeSa=
fran>

[cid:0cb4a8d9-39c9-450b-998d-eecd5a47d786]<http://fr.linkedin.com/company/s=
afran>

________________________________

This email and any files transmitted with it are confidential & proprietary=
 to Safran Passenger Innovations. This information is intended solely for t=
he use of the individual or entity to which it is addressed. Access or tran=
smittal of the information contained in this e-mail, in full or in part, to=
 any other organization or persons is not authorized.

--_000_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt;margin:0px;color:black;background-color:white=
">From: Nicholas Jackson &lt;nicholas.jackson@zii.aero&gt;</span><span styl=
e=3D"background-color:rgb(255, 255, 255);display:inline !important"></span>
<div style=3D"font-size:12pt;margin:0px;color:black;background-color:white"=
><br>
</div>
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">The netrc module will refuse to use a file that is not owned by the</spa=
n>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">current user.=
 Psuedo can trigger this failure due to a reported uid of</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">0. To fix thi=
s, change ownership of the default netrc file to 0:0. This</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">has no perman=
ent effect on the actual netrc file.</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)"><br>
</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">Note that whi=
le it is not possible to ask the netrc module what the</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">default netrc=
 file is, the documentation explicitly mentions that</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">expanduser is=
 used.</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)"><br>
</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">Signed-off-by=
: Nicholas Jackson &lt;nicholas.jackson@zii.aero&gt;</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">---</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp;bitbake=
/lib/bb/fetch2/wget.py | 8 +++++++-</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp;1 file =
changed, 7 insertions(+), 1 deletion(-)</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)"><br>
</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">diff --git a/=
bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">index 821afa5=
b58..0ce6e25c5c 100644</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">--- a/bitbake=
/lib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">+++ b/bitbake=
/lib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">@@ -360,10 +3=
60,16 @@ class Wget(FetchMethod):</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp;</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;try:</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;import netrc=
</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">+ &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# Pseudo can caus=
e ownership mismatch issues with netrc, which is</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">+ &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# required to be =
owned by the current user (root).</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">+ &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if os.environ.get=
(&quot;PSEUDO_DISABLED&quot;) =3D=3D &quot;0&quot;:</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">+ &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;os.=
chown(os.path.join(os.path.expanduser(&quot;~&quot;), &quot;.netrc&quot;), =
0, 0)</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;n =3D netrc.=
netrc()</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;login, unuse=
d, password =3D n.authenticators(urllib.parse.urlparse(uri).hostname)</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;add_basic_au=
th(&quot;%s:%s&quot; % (login, password), r)</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">- &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;except (TypeError, ImportError,=
 IOError, netrc.NetrcParseError):</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">+ &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;except netrc.NetrcParseError as=
 e:</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">+ &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;logger.debug(&quo=
t;netrc failed: %s&quot; % e)</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">+ &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;except (TypeError, ImportError,=
 IOError) as e:</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pass</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp;</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;with opener.open(r, timeou=
t=3D30) as response:</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">--</div>
<div style=3D"margin:0px;background-color:rgb(255, 255, 255)">2.37.2</div>
<div style=3D"font-size:12pt;margin:0px;color:black;background-color:white"=
><span style=3D"margin:0px"></span></div>
<br class=3D"Apple-interchange-newline">
<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div></div>
<div></div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0px; margin-bottom:0px; margin-top:0; margin-bottom:=
0"></p>
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"color:rgb(=
33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe =
WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:15px; table-lay=
out:fixed">
<tbody>
<tr style=3D"height:83.45pt">
<td style=3D"width:311px; height:83.45pt; padding:10.5pt 0px; border-style:=
solid none none; border-top-width:1pt; border-top-color:rgb(0,67,145)">
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-left:0px">
<b><span style=3D"color:rgb(82,86,104); font-size:9pt; font-family:Arial,sa=
ns-serif,serif,EmojiFont">Nicholas JACKSON</span></b><span style=3D"color:r=
gb(82,86,104); font-size:9pt; font-family:Arial,sans-serif,serif,EmojiFont"=
>&nbsp;<br>
Software Engineer II</span></p>
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-bottom:12pt; m=
argin-left:0px">
<span style=3D"color:rgb(82,86,104); font-size:9pt; font-family:Arial,sans-=
serif,serif,EmojiFont"><span style=3D"font-family:Arial,sans-serif; text-al=
ign:start; background-color:rgb(255,255,255); display:inline!important">Saf=
ran Passenger Innovations</span></span></p>
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-bottom:12pt; m=
argin-left:0px">
<span style=3D"color:rgb(82,86,104); font-size:9pt; font-family:Arial,sans-=
serif,serif,EmojiFont"><span style=3D"color:rgb(128,128,128); font-family:A=
rial,sans-serif,serif,EmojiFont; font-size:10.6667px"><span style=3D"color:=
rgb(82,86,104); font-family:Arial,sans-serif; font-size:12px; text-align:st=
art; background-color:rgb(255,255,255); display:inline!important">T</span><=
/span><span style=3D"color:rgb(82,86,104); font-family:arial,sans-serif; fo=
nt-size:9pt; background-color:rgb(255,255,255)">&nbsp;+1
 714 854 8600 ext 527</span></span></p>
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-left:0px">
<span style=3D"color:rgb(82,86,104); font-size:9pt; font-family:Arial,sans-=
serif,serif,EmojiFont"></span></p>
<p style=3D"margin:0in; font-size:11pt; font-family:Calibri,sans-serif; col=
or:rgb(32,31,30); text-align:start; background-color:rgb(255,255,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:rgb(82,86,104)">3151 East Imperial Hwy</span></p>
<p></p>
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-left:0px">
<span style=3D"color:rgb(82,86,104); font-size:9pt; font-family:Arial,sans-=
serif,serif,EmojiFont">Brea, Ca 92821 USA</span></p>
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-left:0px">
<span style=3D"color:rgb(82,86,104); font-size:9pt; font-family:Arial,sans-=
serif,serif,EmojiFont"><a href=3D"http://www.safran-passenger-innovations.c=
om/" target=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApplicab=
le" data-linkindex=3D"2" style=3D"margin: 0px; font-size: 14.6667px; font-f=
amily: Calibri, sans-serif; text-align: start; background-color: rgb(255, 2=
55, 255);"><span style=3D"font-family: Arial; font-size: 9pt;"><b>www.safra=
n-passenger-innovations.com</b></span></a></span></p>
</td>
<td style=3D"padding:0px; border-style:none; width:2px">
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-left:0px">
&nbsp;</p>
</td>
</tr>
<tr>
<td colspan=3D"2" style=3D"padding:0px 0px 12.75pt; border-style:none none =
solid; border-bottom-width:1pt; border-bottom-color:rgb(0,67,145)">
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-left:0px">
<span style=3D"color:rgb(82,86,104); font-size:12pt; font-family:Arial,sans=
-serif,serif,EmojiFont"><img class=3D"EmojiInsert" style=3D"" data-outlook-=
trace=3D"F:1|T:1" src=3D"cid:e940da09-3ffd-4243-a1be-90740bf07b55"></span><=
span lang=3D"fr" style=3D"color:rgb(82,86,104); font-size:12pt; font-family=
:Arial,sans-serif,serif,EmojiFont"></span></p>
</td>
</tr>
<tr>
<td colspan=3D"2" style=3D"padding:3pt 0px; border-style:none none solid; b=
order-bottom-width:1pt; border-bottom-color:rgb(0,67,145)">
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"width:315p=
x">
<tbody>
<tr>
<td style=3D"width:180pt; padding:0px">
<p style=3D"margin-top:0px; margin-bottom:0px; font-size:11pt; font-family:=
Calibri,sans-serif,serif,EmojiFont; margin-right:0px; margin-left:0px">
<a href=3D"http://www.safran-group.com/subscription-account?utm_source=3Dsu=
bscribemail&amp;utm_medium=3Dmailpro&amp;utm_campaign=3DsubscribemailEN" ta=
rget=3D"_blank" rel=3D"noopener noreferrer"><span style=3D"color:rgb(1,68,1=
45); font-size:9pt; font-family:&quot;Times New Roman&quot;,serif,serif,Emo=
jiFont; text-decoration-line:none"><img class=3D"EmojiInsert" style=3D"" da=
ta-outlook-trace=3D"F:1|T:1" src=3D"cid:4965b635-fca1-4eb7-aac6-6354afdfa6b=
8"></span></a><a href=3D"http://www.safran-group.com/subscription-account?u=
tm_source=3Dsubscribemail&amp;utm_medium=3Dmailpro&amp;utm_campaign=3Dsubsc=
ribemailEN" target=3D"_blank" rel=3D"noopener noreferrer"><span style=3D"co=
lor:rgb(78,193,224); font-size:9pt; font-family:&quot;Times New Roman&quot;=
,serif,serif,EmojiFont; text-decoration-line:none"><img class=3D"EmojiInser=
t" style=3D"" data-outlook-trace=3D"F:1|T:1" src=3D"cid:bda2fb5a-eb92-44b3-=
a349-47b31f606076"></span></a><span style=3D"font-size:1pt; font-family:&qu=
ot;Times New Roman&quot;,serif,serif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt; padding:0px">
<p align=3D"right" style=3D"margin-top:0px; margin-bottom:0px; font-size:11=
pt; font-family:Calibri,sans-serif,serif,EmojiFont; text-align:right; margi=
n-right:0px; margin-left:0px">
<a href=3D"http://twitter.com/SAFRAN" target=3D"_blank" rel=3D"noopener nor=
eferrer" title=3D"&quot;Twitter&quot;"><span style=3D"color:blue; font-size=
:9pt; font-family:&quot;Times New Roman&quot;,serif,serif,EmojiFont; text-d=
ecoration-line:none"><img class=3D"EmojiInsert" style=3D"" data-outlook-tra=
ce=3D"F:1|T:1" src=3D"cid:8e4bfd42-7dfb-40e7-9249-5a84cbaa7d15"></span></a>=
<span style=3D"font-size:1pt; font-family:&quot;Times New Roman&quot;,serif=
,serif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt; padding:0px">
<p align=3D"right" style=3D"margin-top:0px; margin-bottom:0px; font-size:11=
pt; font-family:Calibri,sans-serif,serif,EmojiFont; text-align:right; margi=
n-right:0px; margin-left:0px">
<a href=3D"http://www.facebook.com/GroupeSafran" target=3D"_blank" rel=3D"n=
oopener noreferrer" title=3D"&quot;Facebook&quot;"><span style=3D"color:blu=
e; font-size:9pt; font-family:&quot;Times New Roman&quot;,serif,serif,Emoji=
Font; text-decoration-line:none"><img class=3D"EmojiInsert" style=3D"" data=
-outlook-trace=3D"F:1|T:1" src=3D"cid:1eb82668-d2af-4417-a928-1c672824ea6f"=
></span></a><span style=3D"font-size:1pt; font-family:&quot;Times New Roman=
&quot;,serif,serif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt; padding:0px">
<p align=3D"right" style=3D"margin-top:0px; margin-bottom:0px; font-size:11=
pt; font-family:Calibri,sans-serif,serif,EmojiFont; text-align:right; margi=
n-right:0px; margin-left:0px">
<span style=3D"color:blue; font-size:9pt; font-family:&quot;Times New Roman=
&quot;,serif,serif,EmojiFont; text-decoration-line:none"><a href=3D"http://=
fr.linkedin.com/company/safran" target=3D"_blank" rel=3D"noopener noreferre=
r" title=3D"&quot;LinkedIn&quot;"><img class=3D"EmojiInsert" style=3D"" dat=
a-outlook-trace=3D"F:1|T:1" src=3D"cid:0cb4a8d9-39c9-450b-998d-eecd5a47d786=
"></a></span></p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<p style=3D"margin-top:0px; margin-bottom:0px"></p>
</div>
</div>
</div>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1"><br>
This email and any files transmitted with it are confidential &amp; proprie=
tary to Safran Passenger Innovations. This information is intended solely f=
or the use of the individual or entity to which it is addressed. Access or =
transmittal of the information contained
 in this e-mail, in full or in part, to any other organization or persons i=
s not authorized.<br>
</font>
</body>
</html>

--_000_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_--

--_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
Content-Type: image/png; name="Outlook-1h4phv2m.png"
Content-Description: Outlook-1h4phv2m.png
Content-Disposition: inline; filename="Outlook-1h4phv2m.png"; size=3864;
	creation-date="Fri, 30 Sep 2022 17:55:28 GMT";
	modification-date="Fri, 30 Sep 2022 17:55:28 GMT"
Content-ID: <e940da09-3ffd-4243-a1be-90740bf07b55>
Content-Transfer-Encoding: base64

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

--_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
Content-Type: image/png; name="Outlook-1pkwad4d.png"
Content-Description: Outlook-1pkwad4d.png
Content-Disposition: inline; filename="Outlook-1pkwad4d.png"; size=1029;
	creation-date="Fri, 30 Sep 2022 17:55:28 GMT";
	modification-date="Fri, 30 Sep 2022 17:55:28 GMT"
Content-ID: <4965b635-fca1-4eb7-aac6-6354afdfa6b8>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAEMAAAAVCAIAAACSf8TOAAADzElEQVRYCe1XUWiaVxT+OuYWKXGN
sUWSdBVlUQikloCsIaiDH8K6rg8ujLXbkFCqDKSFDCpCG1hokf/FhyIM14VMRjaI4lNo6PhhUaQZ
+lCxLTUpOm3T4kxMbKTENQ8Zf284/GiUsTIIJT8+nHvO+b7vnnvPvRcPbG9v44343nojqhCL2K9k
723l/p7szT0plaucY1pm9Y/fEAD4puIyq59NVWb1+6biAGRWP/txjun04jMApXL17OWwzOo/ezmc
e1IG8GLzJXlK5aoU5bo2+2LzJfM0I2S6TCU0l2YTCM2lSVpm9acXn0lVGCfLFLvrEn97ea3m5DTe
SOZ2bLHZclt6Ozw2Q3Rp3Tt5h6Hu5p7zduPd3HNfcAEAfzMWThQ9NkM4UZz4Psp4GCog5OPJP+uY
6whZlLcbebtRr1WxoV6r4u1GAJbeDt5uVKvapSr8zRhxvg0gnCjydqPzC1PmcYgCjcapk8fGRocA
eCOZX1+hPDbD2OhQpVpb26gBmIkVnJxm4iIH4M79vxgDQ3kjmQfZlWGzXkpbR8hCTILS+vVd/fou
dzBFyaSytlGbiRUmLu7kipXoVPLkw6ITEH74EsCD7AoRtTB0Kvmj5UqpXGVTB5Bd3XR0HwJAnhbw
/xwiFW33oayQJx6xuxyf6MOJ4sDXP1N3UlhqJB8WJ0NJbyTj5DSE6v4sSGdAmkz2rYWC69osgD7d
YXIyo46QOX1Tcd9UXHoA6lDNhuKejI0O9ekO/zR77xwfUxx8t1lqOFEMJ4piyw68z1Af9vf8Mnc/
IC7Mb/4rp3cFRpfWo0vrIyZ1XWuxrpYSMrg7mALw1ZnjB+Xv7ErYzLnzngyb9T9+d6Z1a/F249a8
y8lprk4mGd3ggMZ/5bST07wqZncJ8QRympXK343hRkIAW/OurXnXkc72xvzWHrESzjEdmkv/yzVQ
Ktqyq5uEAqBUtDENnUqee1oBMH5D4BzTJPyp+YPo0jq7qclJBhGSp7VBKrmnFZ1KTslidy2v1a5O
Ju89KgE4qlawBmPNLe3vWwuFSlW8Liy9HYR6UtyYiRVGTGoAn5uPeSMZpUKgs8RkTvR1Afj9j5z2
aCcJA6gjZCH22nCD2n69iGr8SCUg5D02AyWIezJz/eMeZZs3kvHYDKeshmGznrcbA0I+IOR5u5H6
W3xJIpkeZZvv248I5Q6mTmjf85wfBOC+YB4xqb2RzIhJPf6NhTSOdLZbejuEZIE8zKgjZE53MOUO
phZzq3XJNJSquC+YyX9g//8JrcVeMXburr0yndeYx34lr7F4/xP0HznQ1fmW5FX0AAAAAElFTkSu
QmCC

--_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
Content-Type: image/png; name="Outlook-kybjmhvy.png"
Content-Description: Outlook-kybjmhvy.png
Content-Disposition: inline; filename="Outlook-kybjmhvy.png"; size=1327;
	creation-date="Fri, 30 Sep 2022 17:55:28 GMT";
	modification-date="Fri, 30 Sep 2022 17:55:28 GMT"
Content-ID: <bda2fb5a-eb92-44b3-a349-47b31f606076>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAGAAAAAVCAIAAAA2FXwdAAAE9klEQVRYCe1YT2zbVBj/ZpzYru21
NUmWZP1D2QIq60bG2JAi1IIoAvVQISGVS6VVO40Tlx1AaEjAAY4gpMERpHDJCfVQIW1ItIhoMKlL
u5ZuS9eoTZeGNHNaXlLbjXGR/drHU+y2g3N8qL7v+ft9v/f9/N73XnpkZ2cHms/+CjD7v2q+sRVo
CnTIOmgK1BToEAUOed1cQYcIxAJAMqumCggAhkLi5d4ARoyl8wDwbaKTDgCAT08F71R0HH8w5MZ6
7esLxwWWGZ5cHonKozFleHK5XxGunA6puvnx7J85zaQZAYBE4imND3STuWHqq/PrcZn75IVwulj7
/F75UlfrWz1tOObaucjPa1V3ITgtkWF8oHt4cvlx3LjMfXAmxKaLtVQB9SsCAEyUamfahURYVHVT
rVsAoOqmwtsiAsBIVAaAJym3qJsHQNS6dbusJcIimQ0xvvijvGla/YpA4OTVjfXaaEwhLjYIdVzm
VvQ6AJQ0++9idRsAiroJACvVursQkqdHYM+32zXi51C3V+YmSrXvsiq7hAwAuHI6pJlWfnoN4/MO
MQDc3TAS4V2BGuaN3anJ5SVkJMKiJ+THAqIFGgqJF53iM8gYicpv97QRxr2Zg1q3ZspbxMUGoY4K
bAYZmmlhaeacyee1elzmPAshec63CyQJADyOWzWtmxWNkVi7Dc2UtwSW+fLCcVzPnYqu+BjFx2BW
QtNgaKa9yvDjCckgI7uh74XA5d6A4NApPuY+sj8+YSQxAHB9rUq7tH1C9gPAI92cQ0aPwKp1SzOt
nGZGBdazEBr7X+0wb+dnTrXzAHB1fn0snb+++hfOch9t98lcn8zdqmgkbzKrJrMqESWZVT+bLQHA
0zIHAJ4QAPjJq9rBoJhBxru/PySMhAUAplQN7xoySKifkmyBVqp1tW69GrQ37+2yPcMTst+zEJLh
VkVLZlVCd7BLUPZFMdbGXzsXudTVCgBfPaikizXNtDLIOCn5T0r+nGYSRVIFlCog2s0gIy5zibC4
H2QoJE6UajQftkdjyvvPBrp4H2akA3A3nFL//TAAQKhxB5x1PtuLwRYAwHaIZ92F0GlzmpkqoJnK
7nI+2KWBdn/pkPwdkr8/Io399nAJGUH+CQCYruhHffbuW93rR+MD3TRyfKB7LJ3fNP8mMW7IaxHJ
UyAASITFswHhnV/zuIWRzGGe7VeEBoFoasXH3HQE6pD8cZnDdqezshoKodsfPkYJy8EuCbNX0A+5
jY+miwBATqt5R+YMMvAssUtjiD0YFHOauVrd3g8Sa+PjzgYkEGy852wu3I8aXgHA6xHJPUhG+mRO
rVs4bdRpQ3a75Fl3IQTy/4yibio+xl5BGWR8s1CuOh33mMDOOB0a34DG0vnF6nZ472hvYHop2JIq
oIUNfbG6rfgYT8ibUTlzzz4o6WfTtL5f2Xzg9Oljwu4pSQKeD7QoPgbfM/BgMqsCwCsRqUPy48lE
HZTds0u1Lt6HwxoKIQndht1bnZz4aHO71YXylKoNhUTmjc6j+D4yh4yhkPhyWJpDRt/eZ++TuYbV
TpPF2vgegf2ltHUA5GxAUJytSgM/fC7YyjITpRpmpF9he9BpwGQc96BHzn0Hnwn4OMM9+xnnaHMX
QuBuA/cgct11uxOlWlzmLsaUI83/B7nlo0eav8VoNTzspkAeotBDTYFoNTzspkAeotBD/wDHO/NC
zFjfiwAAAABJRU5ErkJggg==

--_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
Content-Type: image/png; name="Outlook-1z2l04w5.png"
Content-Description: Outlook-1z2l04w5.png
Content-Disposition: inline; filename="Outlook-1z2l04w5.png"; size=656;
	creation-date="Fri, 30 Sep 2022 17:55:28 GMT";
	modification-date="Fri, 30 Sep 2022 17:55:28 GMT"
Content-ID: <8e4bfd42-7dfb-40e7-9249-5a84cbaa7d15>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAIAAAAmdTLBAAACV0lEQVQ4EaWTS2sTURTH/3ceyQxJ
2tgisaS2QUttUQhYbUAxG2lB7aYUN7rQhd9AQRf6CVyI26D4AHdCFykurIsaaqRIF8U0gWigkZYk
0iYxDzOZR0Ym6czcxrqQ3M09997zO+dw/ucSXH6KHhbTA2ugvfLcgfy6DkIO3ABo6ZBVKBpEB1gC
HWBsH4rv+AEQeDuEpAC4MDUCIL6ZQ1WC22m/Aibf0gFcDY/FNnZquzV4BMNJUniBf/5gduHSGMeS
9fTPxdUMgGfRr6Vq06iFEBYnrhiutabP17fyZOH85FD0S1bO/QLLoKHcvRW6d/0szzEswxw/6pmZ
GnGL/Kv3Kbkhg2ep/omOwl49mS3OhQLrkRu3b077fH0Q+dlzo3S1sqpFoolaXYZjv3CzfoYIira4
mpmeODbu9764P1OsSvFkfnL0CM3XGsrL5RRUzeqRycsq1y+Gg8Os2dsBjzAXCtAwgN2KZNxwRuWd
Zerv5Gr5Smxju1hte5jPXfunRA6SQutn8oTAIzx+vRZP5rsY+vj2YxqNQ3nA0EPRNrf2aIC2l9a2
3sW+Q6SmAzD1A6DpkJQPK9+ylWY46BedZmvaMdI75fmH0Xr5N1yHzo/a8g26Tgb9XpdjIjAgmPJ0
8n9O5uYfLRW2S/tzRVVlJ6lLysXTQ3eunRn3ewHIqtZoqslsMRJNvFlOKX9NbicIsf+/2gJD3CLv
G3SfGu4v1+VCqZH5UTRmXuQtwanchknxAHTd6IKqGb8NMCaUYztz3oVZR7v+djQCjoBj/pXNwizD
1N+6+E+jV/4PYgbPhuN5GeEAAAAASUVORK5CYII=

--_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
Content-Type: image/png; name="Outlook-w1u0235i.png"
Content-Description: Outlook-w1u0235i.png
Content-Disposition: inline; filename="Outlook-w1u0235i.png"; size=500;
	creation-date="Fri, 30 Sep 2022 17:55:28 GMT";
	modification-date="Fri, 30 Sep 2022 17:55:28 GMT"
Content-ID: <1eb82668-d2af-4417-a928-1c672824ea6f>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAIAAAAmdTLBAAABu0lEQVQ4EbWSPUvDUBSG35g2ja2t
pTjUD4qKIgq6CEUF6+AgIjq4OPUnuLoKurg6+At0UhedRJy6FJwEFRSkFgx+YAz9SNKkTRtJEzGJ
NyqId8m9J+c559z3vhRmt/GH1fIrtqGjoRMzfcToZ7CsQKqCoY1IkAHr//zV3H3Ll5VYvH05NRAN
BwAcZu7y+TdXCW++rIyNdO5vLg71RM2ez4Kcv+AQd4zgwWsN1Opr6aQJ33KFoqTmnooIMb+bX6sj
FhrsNjpnLh9nVvdRqiDSijDr4j30l6sQpJJcBfDwWsb9G6p1aHUXDIBG/7w7qtSmJvrmpgfmk70d
ERY6xCCTHE8ISq3Ai/A13+KDoQj+EaSjnZWlyf6PHOub3jrd2ztHPGKPk+b301d5geNFtWYMXFE1
jhc5XjT0M41gK0Dqr+usj46EAwfrC6nRruNsLr1x4mNoQVJtoLUlvR9FKQVZsWWXXorw02gLgKJc
JUjzA0a23ap+Gq3MVxiAB+/q4n38Tz7adGu0ze05+zQk/QDTJLtnN8OJWPb6ybi8xyK9n5mq61A1
i7Jr6Szk0R8w1HZa1QlaJ2/euMXP6r4D45GH2XAQI60AAAAASUVORK5CYII=

--_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_
Content-Type: image/png; name="Outlook-vuq5al0t.png"
Content-Description: Outlook-vuq5al0t.png
Content-Disposition: inline; filename="Outlook-vuq5al0t.png"; size=611;
	creation-date="Fri, 30 Sep 2022 17:55:28 GMT";
	modification-date="Fri, 30 Sep 2022 17:55:28 GMT"
Content-ID: <0cb4a8d9-39c9-450b-998d-eecd5a47d786>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAIAAAAmdTLBAAACKklEQVQ4EaWTwWsTQRTGv8ns7Cab
KjGoYBW1JWItUqQGKSiIrNB6UpCARfDSv0CqIAjiyWsoCF68Kii2KPRQBMVGVFCxWqgIkRrBEMS2
pkmM2c1OVmY2u+56aWrn9Oa9+X3zZr4ZAmMCGxiRDbACDfNLNVTNdSl6PG/B4oNDPam+7Wg0O5eQ
PG/BtMdODzyfyOSymcxwf+ddSL7JYwn9ymha15QdSX3sVL/Y3+KddCF5Rn8v/7r/LO8CM2++wmyC
khDPW+CtUEZOSNs/i8PmgwM7AbybL0JXxRFMeRFdGmomNCYU65Yo6aovpLQjlaZ6klviopDat+1z
/odxrDeZ0AFMv/py4GD3yJG98ShbLK3eefyxUTV9CcnL+7t+Yei8sR/Ajbtvr84+ujyaNg7vVgh5
+GLxzNFef8PM8dS5a9PlSgNRFvL/p+d8uWZCVZZWGwohtuO4sO04rsRwes9Zo0+cSA7Pf18/HCiE
lFbqJ8cnRy5NLRSW3eKJQ7vQpbkGeecPY8FZ9sHck8n3ALLdidvjhu048SgDo+Cio7X5lWoDiRiA
St0SAJG+0gi4eCBr9B9sZHPANj+/Dt5ngsH/8DGN+hJ/eY21s0wRSXFJcmzS24HPBAPv/jTl3tNP
+WKZKZGZ1wVsjd+cmnu5UGpynvtQFG4Bs/PfLt7KMUoL3ytCQn4Q7/27H860RUFToFJhr82FSe40
uICS8Pt1G1KpwPzxzxQQ1eACufIPfBi14pXIw4kAAAAASUVORK5CYII=

--_009_BYAPR12MB2710069E5D018DBB8F800AECF5569BYAPR12MB2710namp_--

