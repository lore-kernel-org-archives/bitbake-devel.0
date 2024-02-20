Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93ADC48BC4
	for <webhook@archiver.kernel.org>; Tue, 20 Feb 2024 08:07:32 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.74])
 by mx.groups.io with SMTP id smtpd.web11.8894.1708416450412125250
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Feb 2024 00:07:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o2N0QW5/;
 spf=pass (domain: siemens.com, ip: 40.107.104.74, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4Xa6Ahki6AAxIIvozuscP+zwFJR+LLPFZyx7V2xcQfQl7UqBknRYzDx3ng/pMUtHiWpbAF5pX489pkpLF/7V8YCqLoHV5cHhxTLBBJjhx7sKt7hbD1assG8XVYDPh6eLBQJC40BJZec9onXmhg9rBivGjw9aG/pNXvtGW+wJpTNjB+JKgP/sfvwUQXzCDM5Zq4BFkRBTtrIux3Q26/VXDKtJSYilPqnpRe2xPWmKE/ZYUngixocamU92lAr2YKPLL03+EwrjvfBKA+XB15/Z7U5yHWy3xSymXmUYeoP1k9jck3IZNlsZkCAu1+BlhfnQGpd/PsYa48zT+uO5WS9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPRWWeB/DflRw9je0WYfD2L4LhihhqGdij5qLiNDbP4=;
 b=dxVTE82bGuJSUoCDs97zVmpDg68MEeb/AW+hDbf5ZODbvcCh/yQfxroEUxYyyHg0n+4Nz/hOZu24FBy8gZP8AxW53NbJaruyKcXbXjbAJMXrJOChuQbvxcO2GOpN74w6/knKbOthpcqCm0y065rF9xktQTqCWw3PRaskcBu1MSvRWoiK9RLRE249hLs2qmFBDUE3g6tM70mTZzUPubYGg9noZNAn620RA5FNRxpTZsECjA+tTBEW10fgKGiYI7/qvdkIY0sugOBlSPG8Y0qMFfYd/Q4dkQ75QAgX2+V0+vjVA0HFC0jMbAhgOhq1cnZj8yUtubDsvDm4fEAwa/19wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPRWWeB/DflRw9je0WYfD2L4LhihhqGdij5qLiNDbP4=;
 b=o2N0QW5/bNp4K9qEotNqK0D+oG7ibfqR+9nV8uSZQ3ypirm4dTNctCWTyhDiMUVl9JEzus4cXJnGM261wU5cnwrOy2pNUQZ2gFwNzQnofN4kALzOy32vxVC5QpJnKpLVwk1xVvI6kHbPlJBumvg8bUsXo+/KT9jk38WlSTuOFJYozYjeySA18Jemi6JU8aqAHcS2O8cSuPQYRygb8HPvXSzOSBkFvH0Q4LZ9YbHDPR/dqIPGQa6Njvd+I4xrzRyEX0GgPt2Dia7FFexP5NJQbbpAe4WlKz2dLvOUHXDYhor/ZCv03BMHO7Y4NNl4lAufJApuRn8CE5E5YfalZ5iLsA==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by DB9PR10MB5596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 08:07:26 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c496:afda:bc34:6b5e]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c496:afda:bc34:6b5e%7]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 08:07:26 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "thomas.perrot@bootlin.com" <thomas.perrot@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH v2] wget.py: always use the custom user
 agent
Thread-Topic: [bitbake-devel][PATCH v2] wget.py: always use the custom user
 agent
Thread-Index: AQHaW3Hzk0FFBjDcnEWBZiwo1uWKAbES7TQQ
Date: Tue, 20 Feb 2024 08:07:26 +0000
Message-ID: 
 <AS1PR10MB5697CC681B5757062953B279FD502@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20240209160450.2871718-1-thomas.perrot@bootlin.com>
In-Reply-To: <20240209160450.2871718-1-thomas.perrot@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2e236f63-17e5-4e54-a0cd-2d60acd9b618;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-02-20T07:54:37Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|DB9PR10MB5596:EE_
x-ms-office365-filtering-correlation-id: 8e46e253-92fe-436c-13fb-08dc31eafa08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 94xAsZqnvKXTgH2fchHiW2ShhjJWZUWS3X2KkG5zI1TtN21UY5A8mdjZezcvC3HOrNWbf1aMAaZvFsgWuMnT5FowrMT7HG4yBwn6SN/PUK2iFzH4qe27KA/nBhiI5yV9JwrI8bqatzU7RdIWNRD2YFr3EweiKy/9XOtssseVP4T+36LUniWxLi851RE0EqtHBGCa/bvdxZ/Wy1WtOhnYkfrD3Px51lXQiOR1UNFIdmSTvErKM3k5ZxrA/C1n6Vl+loJYoYZcfFFSdpqnfVvn5iVlEdhs0SVaxbMdI44b0ZRq7g+Tuz3Oeq81Wtlj6WVq9tPsBku0rFjMo1F5u5zb3JKYzkJITOGFGzhbwAjM5NrQPnddRw3eatkfNwBM07DWCzUD7mafxlWcJ/DehozUyMXYOglnMalUmM4gvkptyaVnUthQpgCcjov6DAt4DPkI/GwbJMKYpr8sUJOqDujHYN/5+sCZXCw6QqDPehJOlScbZgk7WtLDMxCzgsn6iKb//bT2XCo8Wwcz7YITSZPsCwZNbwPdjYjHo1p9RuerFWCg25DaMYI0XTxabrhbGLd3ntYsaoukfWONsoBdDUBuhCFQ/kPMgtkJ7Bpc6eHpU70=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0/+9gBTwK9iuZy2hDxsywsdx+ERNVJcK/wEPPx5W6hOteAh9GcLsMZ3KIfcl?=
 =?us-ascii?Q?uO5qBu0EesDvU26DnmTf8iNFWRp+NDXKrrMAqnkrfcyCJlANX0OIw3sFxLOS?=
 =?us-ascii?Q?bKVUnDhaHStkO5RLT0APecdsE9IAU2jEhbsJMHEi2MoRVyMbf5DfNKxusdKn?=
 =?us-ascii?Q?zu15x1/bZmqYxeH73yHkmGnfxXmXopXzPKmjtv1Kl9EPLQKvIbvuEqVBcKOI?=
 =?us-ascii?Q?GcyUm3WwrTY4KuyTrV0syhvHLg2LS1jlJgB01AUsVGVI9+8ybWe4baRHqRXH?=
 =?us-ascii?Q?odXqm7j+zDob7tE9gbojO4iNjWTJD8NZ2A+N0lEpVeFElJ7AysAvtecX0yAF?=
 =?us-ascii?Q?qdHnr4ZJVAtS21tVmjIqeVLURDYOwcr6u9d6VikxR36a+UDMnrrd3Grwjk2O?=
 =?us-ascii?Q?YYD5kl0D1gZMlp3qJ3YgkVDjQ/lM4zwdO4vda/lOOGO7xihu61rIppeAwQh6?=
 =?us-ascii?Q?fc3zUhDYNj4n62mXMuxuPZvuIaWDc8ZdW0WAS1QxO+SZa6ZuHmJd5OFor+jt?=
 =?us-ascii?Q?ErlUHtCvWXuC/X8a+hbmrw4S/UDhqQipNTolDxf/S9VSEoZrPo6GjBEq/vDM?=
 =?us-ascii?Q?+9zuRKb9f644OBFeDGhwJWmsN75pPJWryAp3scOeXgQ3EAy1vPjimXumnCb2?=
 =?us-ascii?Q?eR3GKSBYNiV37oI3H4MKlVuiltvsPegHbZYhiHNc4ohZwLOuQY6ATGdtqaRB?=
 =?us-ascii?Q?wpcm5dNSzyMrhzVK9t/2wlKPf6K61u2GsdaWGOztQuZvq0j4BB93jKdmPJu1?=
 =?us-ascii?Q?TL95qZ7xW3rG4Jqa9U/66BSFvFCJOUtf2xHbUVubkvHq6BM/mTfMkN0P64g9?=
 =?us-ascii?Q?KioRSSk5hBHgziZaxeO4qvP+DfwPdWKD2yqot/aW4hnAGApvgO+yREJx+oyB?=
 =?us-ascii?Q?aKDt6FazyCz9vx14XUF2uwintmzm5x3YWhsRsUKrby0gGmHN8JIBpVeyzl+5?=
 =?us-ascii?Q?VU3oMvrEsjMUo2o0Y30Nng/hx6E4p9/d3JYm9vI2LGwIzvyrfqRTU8/lWKP8?=
 =?us-ascii?Q?uylU9Q+QzdEQBYAokCTsgDZ7zlpQ0izQOc6PLxDIdYSVeykvl+rIWolOBn5Y?=
 =?us-ascii?Q?cR/BNVv5HvATf2F2ihXuNRvhyThFHObpvjdeKqYX1dKOT6PBlyRiLMF1E8kO?=
 =?us-ascii?Q?jUo6BSBJ0IybuvQi1X4ZHBd3mZ3t8vJ8vLwYUBk/mPliSidOLdfA95JwAdYE?=
 =?us-ascii?Q?3Cr+9DXYxYeK4QXGsLRr58L0UdMDcCP5VMo7q3WlrXAZu9w9WJNC8chJJsOf?=
 =?us-ascii?Q?xyKyjiXpKUPXa1YOexIWFnU9oGmoDtqY4KE/gNlqrxbBMsCPLMxlbFBIT34A?=
 =?us-ascii?Q?vo0RKksR+z9TYjJrZaPqAh9qecaTKqYvtNx8UjjrZ3mrFqcFs0EMALcgEido?=
 =?us-ascii?Q?/YXdE6wwNIJo6+rP1U0n8Ftp8ZhyF5NrA/3SVMRIdzdLpiK8tUZ4FfT2kQGg?=
 =?us-ascii?Q?Pvss3NgxjWGV/vybA9UsMrQOvfOmHd5sbKrfPB+msdrUWBxE8IzOrUgOJFvN?=
 =?us-ascii?Q?gGynkl65P5nlxteeGhoTL99l5Dk4YABW0JFu+N76DNoFAhRhr0ymS1NYNMaG?=
 =?us-ascii?Q?bDHzfRnwlNSDafCm+rDRqYHyvudKilPXDhJuq5yh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e46e253-92fe-436c-13fb-08dc31eafa08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 08:07:26.6604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SLzUex48DOgEVv1jcrK6gflfpGnvxEiC6I1KBB4leRjCr1JphP2XE8g7+2FRK1pjO2z3N1hld1x1j/xttsjgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5596
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 08:07:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15945

Dear maintainers,

Could we please revert this commit?
I'd propose to enable this via variable on per-recipe basis for those which=
 point their SRC_URI to misbehaving servers.

Sending browser user-agent causes Jfrog Artifactory to present a GUI as res=
ult and not directly the file itself.
I think that in corporate environment using Artifactory for storing binary =
files is not that uncommon.
And I think that there may be also other servers which try to beautify down=
loads for browsers.

Thanks for considering this.
  Peter

-----Original Message-----
From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org> On Behalf Of Thomas Perrot via lists.openembedded.org
Sent: Friday, February 9, 2024 17:05
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [bitbake-devel][PATCH v2] wget.py: always use the custom user agen=
t

From: Thomas Perrot <thomas.perrot@bootlin.com>

Add the "--user-agent" paramater in the wget base command to perform all wg=
et commands with this parameter, because a few HTTP servers block requests =
with the default wget user agent.

For example, "hg.openjdk.org" never send a response to requests have been s=
ent with wget:
wget https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
Resolving hg.openjdk.org (hg.openjdk.org)... 23.54.129.73 Connecting to hg.=
openjdk.org (hg.openjdk.org)|23.54.129.73|:443... connected.
HTTP request sent, awaiting response...

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/fetch2/wget.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py index dc025800e6=
59..bb38dd435827 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -87,7 +87,8 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile =3D d.expand(urllib.parse.unquote(ud.host + ud.pa=
th).replace("/", "."))
=20
-        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -=
t 2 -T 30 --passive-ftp"
+        self.basecmd =3D d.getVar("FETCHCMD_wget") \
+            or "/usr/bin/env wget -t 2 -T 30 --passive-ftp=20
+ --user-agent=3D'%s'" % (self.user_agent)
=20
         if not self.check_certs(d):
             self.basecmd +=3D " --no-check-certificate"
@@ -454,7 +455,7 @@ class Wget(FetchMethod):
         f =3D tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix=3D"wget-index-") as workdi=
r, tempfile.NamedTemporaryFile(dir=3Dworkdir, prefix=3D"wget-listing-") as =
f:
             fetchcmd =3D self.basecmd
-            fetchcmd +=3D " -O " + f.name + " --user-agent=3D'" + self.use=
r_agent + "' '" + uri + "'"
+            fetchcmd +=3D " -O " + f.name + " '" + uri + "'"
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=3Dworkdir)
                 fetchresult =3D f.read()
@@ -492,7 +493,7 @@ class Wget(FetchMethod):
                     valid =3D 1
                 elif self._vercmp(version, newver) < 0:
                     version =3D newver
-               =20
+
         pupver =3D re.sub('_', '.', version[1])
=20
         bb.debug(3, "*** %s -> UpstreamVersion =3D %s (CurrentVersion =3D =
%s)" %
--
2.43.0


