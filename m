Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A6C61DD6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:58:13 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9220.1788343084568114915
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 02:58:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=STBf6K46;
 spf=pass (domain: ericsson.com, ip: 52.101.66.59, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJWcA6VJ9CSouHgQygoXXSZ9cm1iZxOheObjFiCBokbGsshG2GSMiRnmRF4TLb2soqS8tGsKXNzCSnIWQgBg5/BoHbFqfbs+mn1kgArWsimGhwusCy0IqnfziPXrHGsuNISkXGM+paGFW+mWdAGLQe4Oombysw6A/v4Adfmf1QNvWRQUwAbNeA6T0x52a54bRnd6+zMkkvqd56O8jxOgwx08dph2Jl/6F4sQNPnEeNR0R4X+30Reeas+ubKR0R46irKC9j1A/QsBHjIE4cJJnVftCYyWvR5fnAoGnhoUhQjCmM9z8rmquhY6BoTcfaIyGXRWevPs9zETFOrDJpr49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+jPJC12zteicU84Gsr1cTmvXhnnVXpCrrs/WjZxnA4=;
 b=xQAURqGVNHna+NxWIFBvymFtrZYYxPdkXQcjEGUBIywMyifZ8JC2uu9KDFDDyVW00gBC08Fls5zGTOvFRlmhI8/Ye8RuS2CQMQdnV2zZ+/GzzSfGHCI/XkV//DIs5c0PItLRtvqxrePOIb33kMpxMQlxpUS77H+axSoH1oFBPOu/POTh7AvZILKestnIAd89o1YttWGMkq6cdr+VqoC+eNa19ZcPnHEnMt6krtk2n1SQihTctDq4+F6mok5WTRXF5WUiEU0+7KWGlBjG7dSMjk9T4SLyZaHl0214Dzq1y900cFOeTnr3WgSaNCNIl9YfJt8PLs5yIvmvEKcVuDoxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+jPJC12zteicU84Gsr1cTmvXhnnVXpCrrs/WjZxnA4=;
 b=STBf6K46R/BlgsAY0vDYHEFq6oJSy3Z2Et3RQ+yBz2zqL/Q2B5ZbDzuSa4yDRSIMmo57q5r5QQLKb0APYIAAgsWewzUvXPPSZniehH8/fh0uKEkI9q39BQzpDWsL2ciFggCB/XWSezMT2CxkGEyuxgHeYiofUI0nFauQIxtwCsFpIh7bceTt7pa+dae2ss9YIIi1cXL+OA63fT7/Be/PugyRrlt1ioR5BEGW+rIBNMma15C1NX/wMDNMyOcks3QrcNYqzFDDY0uBJdbMlp1U7IKzqihoxZh8T1U1MnchloX7nQAiOgHUB6Eu+HVRzNX1QBretzqMDWXThgOAQR72Iw==
Received: from AS4P251CA0021.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::11)
 by DBAPR07MB6839.eurprd07.prod.outlook.com (2603:10a6:10:19e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:57:57 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::97) by AS4P251CA0021.outlook.office365.com
 (2603:10a6:20b:5d3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:57:57 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 2 Sep 2026 11:57:54 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 09D154020B43;
	Wed,  2 Sep 2026 11:57:52 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id CEAF5700CF25; Wed,  2 Sep 2026 11:57:52 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chen Qi <Qi.Chen@windriver.com>, Mathieu Dubois-Briand
	<mathieu.dubois-briand@bootlin.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, Daniel Turull
	<daniel.turull@ericsson.com>
Subject: [2.18][PATCH 2/5] fetch2/wget.py: add filter_regex parameter to latest_versionstring
Date: Wed, 2 Sep 2026 11:57:35 +0200
Message-ID: <20260902095738.2840120-3-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902095738.2840120-1-daniel.turull@ericsson.com>
References: <20260902095738.2840120-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|DBAPR07MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: cad4817e-7a92-4e91-53ee-08df08d8aa7e
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	hSa7NDB1IlUVLPNT01KCovFBPj7Jx1WijBGdTokYKaCzH5LMBY0nDy8r46mCSL0tQ6N/xDMFAjeZMxw7oq1nFlvknjUJ7MPwhNj5NFzU7OJLbBjwG1FIB/rp1cxiPnSlGiHnDzcDkzCg79vgWQIczmd8E1iUFem7uzfcrEdyOHrFbY4nNEia7RUmt8l1OhLIvBDMyANTe61oc7ArdEUc7TdfjVcf1L3CO0BsaIO7WTppoXRcfvfEhYU/mIfPr6c1lu5ss1cabG1BTG7pyYl8iDZVrCDD3/LBvm1XazeZaTTsEH0oqjx+zc015zSES1w/6uDScO3uVuHX2f4QxUsUmmtTebnwNhqslPS6uWnynrwo0C8m4RCRisgp38OR7kJ0s9BIC7aAYtFKd/tsWH+ka9Mz4kOk9FpBotST/YkAdQQjZJxQhR1aElCN0+NrK88R5iDmMU7uKog24f2O4qBEPJz7vhecxZTudLLMWCq+H/5EGxq6bjKTTtcP+czCDMUr5HEbSrag6Se4cuzal0l7IFdtdNJrwpM08fuIiWXG50UVo+vGP6xA/PBNSNRP/nGMAwuiss0B8uW+mp+uRRWsJP7TsW6ZfzznddXmDiFTSAfLD1gxRvwvXJvAVZXGQGWAfyR5MXS9ymwGpUTdPt/CY/kRV3UCSbsqJYklUQ4y40AJvK7sezVCfEgC9vb5/qpMNf2A59rudoa6IRl+P1QGCg==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	yqx0/rCunecVRkDCl2/E+TzmM/YOFB62U4Pm9d66u69gtAFLd/d8O1WL+k3HpOB8+JKVT4+EBr7VyzTrDQB+LDSWdYWcVEyudFI701swGpdoqQIaMkjh9o+/VIQHSAnS00D0WEazlUr22OE6R8CltiCMvXWas1pTSGOvDPoMfojiItr1bPFLWiMBWEXS/OOoslbKerHJ2lA9ON09uY/fvqykZPHT8bC75pZO9NmcOyZwmpRRYRC41+BpUluW3pYlClhZ6toPmnjz56wS5ta70erFRoZi+23oJcGBrG3cpYb7R2ZDFkzk5YMrQm+uW27/oluzvWDr6fqmEz/ZPPKBLVnvj9TuZ2noHNRubHJo0iiBlnGEG6ikNTgFbqWWGk7ziS4eFDZ20dH3zVTSPKiELdzggSY59TVpCVoN/d2rmY68zHB5ZR2NyFdil0t60f+I
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:57:57.5646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad4817e-7a92-4e91-53ee-08df08d8aa7e
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6839
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 09:58:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20153

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b1c4a431b080ee328fbf21543258e226a464c118)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 lib/bb/fetch2/wget.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index fc83b301a..c292dfe7e 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -515,7 +515,7 @@ class Wget(FetchMethod):
=20
         return fetchresult
=20
-    def _check_latest_version(self, url, package, package_regex, current_v=
ersion, ud, d):
+    def _check_latest_version(self, url, package, package_regex, current_v=
ersion, ud, d, filter_regex=3DNone):
         """
         Return the latest version of a package inside a given directory pa=
th
         If error or no version, return ""
@@ -538,6 +538,11 @@ class Wget(FetchMethod):
                 newver =3D self._parse_path(package_regex, str(line))
=20
             if newver:
+                if filter_regex:
+                    # filter_regex is derived from PV, and uses . as separ=
ator
+                    # while upstream may be using _ as separator
+                    if not re.match(filter_regex, re.sub('_', '.', newver[=
1])):
+                        continue
                 bb.debug(3, "Upstream version found: %s" % newver[1])
                 if valid =3D=3D 0:
                     version =3D newver
@@ -555,7 +560,7 @@ class Wget(FetchMethod):
=20
         return ""
=20
-    def _check_latest_version_by_dir(self, dirver, package, package_regex,=
 current_version, ud, d):
+    def _check_latest_version_by_dir(self, dirver, package, package_regex,=
 current_version, ud, d, filter_regex=3DNone):
         """
         Scan every directory in order to get upstream version.
         """
@@ -599,7 +604,7 @@ class Wget(FetchMethod):
                         ud.user, ud.pswd, {}])
=20
                     pupver =3D self._check_latest_version(uri,
-                            package, package_regex, current_version, ud, d=
)
+                            package, package_regex, current_version, ud, d=
, filter_regex)
                     if pupver:
                         version[1] =3D pupver
=20
@@ -660,7 +665,7 @@ class Wget(FetchMethod):
=20
         return package_custom_regex_comp
=20
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=3DNone):
         """
         Manipulate the URL and try to obtain the latest package version
=20
@@ -701,11 +706,11 @@ class Wget(FetchMethod):
                 dirver_pn_regex =3D re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
                     return (self._check_latest_version_by_dir(dirver,
-                        package, package_regex, current_version, ud, d), '=
')
+                        package, package_regex, current_version, ud, d, fi=
lter_regex), '')
=20
             uri =3D bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, u=
d.pswd, {}])
         else:
             uri =3D regex_uri
=20
         return (self._check_latest_version(uri, package, package_regex,
-                current_version, ud, d), '')
+                current_version, ud, d, filter_regex), '')

