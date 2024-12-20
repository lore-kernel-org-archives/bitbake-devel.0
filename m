Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB34E77198
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.106])
 by mx.groups.io with SMTP id smtpd.web11.149743.1734693991344736713
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=5a2KgGS2;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.106, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO9FckC4/+pjvSl85FXCvNz8zxqy9GwgNS1P7E3RRBAgva7AHCR5Jy2QJyvpFe5Oss12H3nzSTs3E3+93XoUApuYucvu3DabJstoPsQuk8Yy2rDJTsqzn/JViFbs7LoOe74Q+qZBb2EPsRsRu/s1dn6PHWJkOoZ8kZTmwraD7qNiWNjpUYmqFsB3wyUPpeCj/MME1uxxwyj0VvavZK5xjeWhNwIsFdsyKE4LzFIfaobnp+5ZYLye746OTUxziaIXSoZ/13aefrnaMCwOp8xBVMeJPBjCXAHcMAK0tYkIPe5iyWu3SXLdrz/qoRDsWDrdJLRYLQO+tCs9pXft+uWRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP6PRAT6tlYMnq9DSnjr6qPmKll6BATeTNlR+i/5Rnc=;
 b=VG5eNNUX8/dXRUEDorGOI8LzTIy6Yi4crClecA9xIyKIPbb9KpRRJz1ZMm+9w+Rcy6SFAId7b2Q2u2XrCcZIa810exPEMamaLSyUTGwL0rWFDS1oxqOWF4BsPcgCZ8ASK3qZHev0q7K3bq3074gk5pIIcOjmpveHoiwmLz12JL1e5LLxBSB0MsutKnLzHN1kr1Np8yXsoX90jdVbkpwiUFw+XHQrm0DJSC+a0g87F5mUBY20qvieG06AgpRuwjD6eYjDs0xlq0o2zqkzLODWKQhAg+DaRxug0fWIUwUPHjiZC4r/H7N+nntxGiw10URB7RyU+f0m9tRqep/PxjcuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP6PRAT6tlYMnq9DSnjr6qPmKll6BATeTNlR+i/5Rnc=;
 b=5a2KgGS2yCIIi34IhlL2817a2MP40dPaYpHe1hNUY4/h+gP+duKnbXCK6sYE5M96J/IhUWjZ6c7M34UJ1sv2AQ9l5Qy9gBSfMRyrVqTvOr1W/gTLxdBGYVdXRFjgNAIu30WwsWbaQKLaBiQ3mm/FmhWTxQpgu90bAG7CKq8Wb+M4EEvMnZo9cXJxHLKxHIFdNkEmgSZQE3bjSL6fnOacLdzjNTviD3XcXXbanmrc+63CZm3V/XUVsDP1MSy6qI8l/EO0ovywiJiKMNdvqGYPFRuhlAcImpfche+jQBE8/uqsJ2WhcJtT+CeyFn90lH6VoatCdJQ7HeRASkuGsGXDVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:28 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:28 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 11/21] tests: fetch: adapt style in npm(sw) class
Date: Fri, 20 Dec 2024 12:26:02 +0100
Message-ID: <20241220112613.22647-12-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: e76333fe-02b8-4f37-5e14-08dd20e924f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BrulRto5BH+XqfiYhocXcdWli1bp9ch1lKuMRhENo/c4Yh+goYSLPKBkrfIO?=
 =?us-ascii?Q?Xvui6lGZhlygFjkg9PXjskegqUVXxKDSQeTo9SJ+Auwi1xLhJ+vGuE/l1bOt?=
 =?us-ascii?Q?HKKUoOp+ClncG1/s4l/CSZ4eC3reH+c8YqU17BdKD67WTfXuYUSLU7IRn/XO?=
 =?us-ascii?Q?PC0qedotWE/NXzirdPrd9vs86EutnAsz58f2qy19tZU9lAP3w+TCKqZuQx0e?=
 =?us-ascii?Q?e9IxcfrK2KoOaOqNul1E0UkM0Q/JSEOveHECYzoUWp+ZU74vV6lAbtb8CzG4?=
 =?us-ascii?Q?I4nZrPwhJr5vPD3WTWTu1haT+V1D01qFLc0kY0ew8wkp6Sjrte89KW6zWy7q?=
 =?us-ascii?Q?e+Rf7RFLBMJcYuc6ypstifScU8M6F1KYQHuFg7baFkYtdXOkqOoa1L4oSBY7?=
 =?us-ascii?Q?WH22MnA35oUh5b/4oSdRZDIwNGIOdAOoz0TMcN/OHvwDef9hmZgT/NCZutot?=
 =?us-ascii?Q?R2YOv5bwZd6+Ke7TZnEZhSqAFCiebVGPji7SDAu+V1cX4xdJkexf3W3we94J?=
 =?us-ascii?Q?vNglcxuskup99vJ/jofi/HZ8Kev/ajUTFlkP5VkMeip3rv9rjsxGKDbKfXeS?=
 =?us-ascii?Q?Hc1JNx4R74ufYPe6YcvrbQhdHcPJfDiwjLX+Ng6vH20FAbxw/zPBKXThnElE?=
 =?us-ascii?Q?5WvZ0e6Jjk3QldRhq7r7sgjxD2pqECINCECbKqIpZdGOLZZoaMfOWELQVSof?=
 =?us-ascii?Q?NUbkGKNNLZesv+brULC8wTbFh0jIvMoDwL5MBl00IlaBRR3CBgPQJOOAmAg5?=
 =?us-ascii?Q?QT2HhyEPUCD2ZFPND8NtrzH83PJYWkm5OBqC/V0Ydr6UwvMdTaR07AAvs/Av?=
 =?us-ascii?Q?QHfBAnSESD/MYPPORIz7y9rORSpklaEiD2g3rJQPr7y5Wpwy2RPsqbMgrXaK?=
 =?us-ascii?Q?6SB6GSb3gLKFRbK65o+DyBqTeXPWX1LUVJ7KqbkXxrumzswZlDdP3mTVGRuQ?=
 =?us-ascii?Q?Yekqtzwvu9kuMLpEYlhVIbjNxChI6r3cI/kkWBpiHkP89xTqBqvPWlVSpY2S?=
 =?us-ascii?Q?wHvbMBqBLI+e8nTsTct5pxL9n3/jGokrR3J1KkH94v6KNVS2NC0jwkNwB/TS?=
 =?us-ascii?Q?Wcs+JxtqpizebP7Wa5sQrw6wX424BAeH7hDSxFFNDxnGz3ztfG/ywhO6RvBk?=
 =?us-ascii?Q?wnBpbQD3szIutdMwniSyIgaqESFs58slfoCYW0ogDRn3rt5T3CN47TmKWCfD?=
 =?us-ascii?Q?Mca1z/iPY3cIcAK2hFXuB+tkScxok4RNktlXK652VqISw/5RRbJpNZtzlVgv?=
 =?us-ascii?Q?hGzbPdkzv064L4ZdG1tD5cxHF9bqcISQxOFOiXsid0EjZ7nsA+o13RdlAyq3?=
 =?us-ascii?Q?FdIoCmn2fGfmVTPbAMdcrx8nxbrpiv/Brav15QqWJSJKO7utZTv/onAFROIG?=
 =?us-ascii?Q?MKOmGc36OEYrw0vd+QMdx7UY7btJtafdaertXndMNQX7DZ9jIQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TOr71IKYxZU8n0nlkIMK+DN8XlMu8LCxqKCVIXpahF9OBjGZGXrMRgJwoftb?=
 =?us-ascii?Q?1ovPbe9xLlQYBlrFemwbEE3YJZfDy/ktTq3qULKuMB+XwaRva+hQDBzQz/bQ?=
 =?us-ascii?Q?GLKC2/rpm9LPrqv5Cws5TZkySo8wsJXB+NUDBr35oodhohM4z6RgX03QoesO?=
 =?us-ascii?Q?km4EnA+kdYjK+T0eaYAHvSd6WMI/2N7SbLTcZ67JrejC8CsH/1pfB1cyOt48?=
 =?us-ascii?Q?QCuhzbRYHEWY1j+uz0gfZae90HPSIiDucYtNuUdo+O1w/FfO46BRn4r1NuGL?=
 =?us-ascii?Q?PANBDKbrPzx5NbLTXcwa+ZDKxHGUGVCTPgNkkKeFrapDk46FsSDGlhGeXoJk?=
 =?us-ascii?Q?fSYtTgpFX90Q5pTVQLran5hk9pX8NBqr7zV1rtGNwgPERYzjKRZzutEUTt19?=
 =?us-ascii?Q?z8AvN+Fgc90vUAlVH/7nr1lVUGVb96AZHc6w46TeTJGozcELRmH5XwTbTMEs?=
 =?us-ascii?Q?DzYOOeCdiDeEsrNeaH4HHYO7ELKdxMa14+QmFFB8VJAaptJpDBpW0fg+1C/h?=
 =?us-ascii?Q?vIu2gg/D5hRIzcXHQVvR4SSa2WVe3GXoQIMb0oTDiM05vuUqm9IDj3QigCcB?=
 =?us-ascii?Q?Yfndzsj7Rh7BhmNwimR7byVTWXAsIOLcw4p1tymEGY27IqRe3cTf/4bRtlO1?=
 =?us-ascii?Q?SstGuJSCQLpZCDbGKFupZ84t7pu7WBUA/Pg6LuCRdFeBHS5IYRAyo3lZodBs?=
 =?us-ascii?Q?h0jBo/nF2m8aTfKl+K8Y5H70ZT5WDeWJvkjywgEldpGIQ7AukZG5nki5e8bD?=
 =?us-ascii?Q?uHpP91z8OXsUawLe29sovvKtD9eTLU/T+aSNeWuzmadLFwNt6YfjZlvFM9eN?=
 =?us-ascii?Q?QdVMRysv/JWykJybID1UwJNUgUqU4JGzd3jEPlRTSRgxh7Zt/SR4dE9xjwuH?=
 =?us-ascii?Q?7mJ+PgjoxPsmcuAkajJgd0R06PxxpXQkI8oK0S/1yw9sKFTkQeR3sfd+0goR?=
 =?us-ascii?Q?yo08D7J5DQBxYrkXxiXQHnFxM9cOTFbM97g2h7RIm1Z/quTw8dQBxQV1OkuZ?=
 =?us-ascii?Q?di7XRlYA9W9DGU8U3KJ5AbgliMojzi5ByfrDO3rU2D8Ojn5eTeIsFA/K87Ka?=
 =?us-ascii?Q?MbMWtQaWNIjnoeDja/q3I607QzpJRJy82HfFqBHigHsFTtsHxp+aLv+cKlIO?=
 =?us-ascii?Q?LICGbadHOASBXS2T/2uxi59fdhDi7y8egJqLRy81taJXJl/8sFpKm4Is2HYc?=
 =?us-ascii?Q?fpY6Gsh1d9xzJvQvk4kc6WvP7b+B13skunwLSQfetcJKuvcnmgo/fXpTgCpM?=
 =?us-ascii?Q?rFVB4SQsjeVGtGlCFTP3EaUk0Q5pJETA2fbb5Xk1WfbLLwQ/sup7eHNaBX8m?=
 =?us-ascii?Q?/uKiBAqRfELJByXogICMhzL0uORVVIjTWjHHau0ZKbmzIwZEqPLADaLe+n0n?=
 =?us-ascii?Q?eGFGtAs6POIUs0/qaWiO5bshTDVn6fC760aAWNb7zO8xaAPRsVZPa7JDUxR8?=
 =?us-ascii?Q?My/K5y/xR/ahSyizl1/HpQ/isDOMwhOSnlJtMpLqjU7kHwLexeGYJMxndg01?=
 =?us-ascii?Q?iiKmPxEkloDSHuvIB0Gw5pZ9Ssfy09wjOGX2DZTqodcczscuz77MKBEHWRau?=
 =?us-ascii?Q?BvRvnVe/aQe+RdXD6qfePFxqamitIe+GAV6b4ydYCAGhWmoUvAgV6XE9lHrG?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76333fe-02b8-4f37-5e14-08dd20e924f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:27.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TinhaW4g8wcAujuxZh44lt/LmiTPcBTEOHj/8M+N/hg1c8SL5o5jNH6JMrTfHXup3BhP+BGFMdrlSIrgYe3ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16935

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 348 +++++++++++++++++++++---------------------
 1 file changed, 174 insertions(+), 174 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6b8e3e060..934b96cac 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2620,47 +2620,47 @@ class CrateTest(FetcherTest):
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
         import shutil
-        if not shutil.which('npm'):
-            return unittest.skip('npm not installed')
+        if not shutil.which("npm"):
+            return unittest.skip("npm not installed")
         return lambda f: f
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
-        self.assertTrue(os.path.exists(ud.localpath + '.done'))
+        self.assertTrue(os.path.exists(ud.localpath + ".done"))
         self.assertTrue(os.path.exists(ud.resolvefile))
         fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, 'npm')
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.js=
on')))
+        unpackdir =3D os.path.join(self.unpackdir, "npm")
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_bad_checksum(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
         # Fetch once to get a tarball
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
         # Modify the tarball
-        bad =3D b'bad checksum'
-        with open(ud.localpath, 'wb') as f:
+        bad =3D b"bad checksum"
+        with open(ud.localpath, "wb") as f:
             f.write(bad)
         # Verify that the tarball is fetched again
         fetcher.download()
         badsum =3D hashlib.sha512(bad).hexdigest()
-        self.assertTrue(os.path.exists(ud.localpath + '_bad-checksum_' + b=
adsum))
+        self.assertTrue(os.path.exists(ud.localpath + "_bad-checksum_" + b=
adsum))
         self.assertTrue(os.path.exists(ud.localpath))
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
         # Fetch once to get a tarball
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
@@ -2668,17 +2668,17 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(ud.localpath))
=20
         # Setup the mirror by renaming the download directory
-        mirrordir =3D os.path.join(self.tempdir, 'mirror')
+        mirrordir =3D os.path.join(self.tempdir, "mirror")
         bb.utils.rename(self.dldir, mirrordir)
         os.mkdir(self.dldir)
=20
         # Configure the premirror to be used
-        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/npm2' % mir=
rordir)
-        self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
+        self.d.setVar("PREMIRRORS", "https?$://.*/.* file://%s/npm2" % mir=
rordir)
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
=20
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
-        # The npm fetcher doesn't handle that the .resolved file disappear=
s
+        # The npm fetcher doesn"t handle that the .resolved file disappear=
s
         # while the fetcher object exists, which it does when we rename th=
e
         # download directory to "mirror" above. Thus we need a new fetcher=
 to go
         # with the now empty download directory.
@@ -2690,19 +2690,19 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors_with_specified_filename(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
         # Fetch once to get a tarball
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
         # Setup the mirror
-        mirrordir =3D os.path.join(self.tempdir, 'mirror')
+        mirrordir =3D os.path.join(self.tempdir, "mirror")
         bb.utils.mkdirhier(mirrordir)
         mirrorfilename =3D os.path.join(mirrordir, os.path.basename(ud.loc=
alpath))
         os.replace(ud.localpath, mirrorfilename)
-        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s' % mirrorfi=
lename)
-        self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
+        self.d.setVar("PREMIRRORS", "https?$://.*/.* file://%s" % mirrorfi=
lename)
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
         fetcher.download()
@@ -2712,22 +2712,22 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npm_mirrors(self):
         # Fetch once to get a tarball
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
         # Setup the mirror
-        mirrordir =3D os.path.join(self.tempdir, 'mirror')
+        mirrordir =3D os.path.join(self.tempdir, "mirror")
         bb.utils.mkdirhier(mirrordir)
         os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(=
ud.localpath)))
-        self.d.setVar('MIRRORS', 'https?$://.*/.* file://%s/' % mirrordir)
+        self.d.setVar("MIRRORS", "https?$://.*/.* file://%s/" % mirrordir)
         # Update the resolved url to an invalid url
-        with open(ud.resolvefile, 'r') as f:
+        with open(ud.resolvefile, "r") as f:
             url =3D f.read()
         uri =3D URI(url)
-        uri.path =3D '/invalid'
-        with open(ud.resolvefile, 'w') as f:
+        uri.path =3D "/invalid"
+        with open(ud.resolvefile, "w") as f:
             f.write(str(uri))
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
@@ -2737,17 +2737,17 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_destsuffix_downloadfilename(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0;destsuffix=3Dfoo/bar;downloadfilename=3Df=
oo-bar.tgz']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0;destsuffix=3Dfoo/bar;downloadfilename=3Df=
oo-bar.tgz"]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'f=
oo-bar.tgz')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/foo-=
bar.tgz")))
         fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, 'foo', 'bar')
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.js=
on')))
+        unpackdir =3D os.path.join(self.unpackdir, "foo", "bar")
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
=20
     def test_npm_no_network_no_tarball(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
-        self.d.setVar('BB_NO_NETWORK', '1')
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
+        self.d.setVar("BB_NO_NETWORK", "1")
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
@@ -2755,42 +2755,42 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_no_network_with_tarball(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
         # Fetch once to get a tarball
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         # Disable network access
-        self.d.setVar('BB_NO_NETWORK', '1')
+        self.d.setVar("BB_NO_NETWORK", "1")
         # Fetch again
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, 'npm')
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.js=
on')))
+        unpackdir =3D os.path.join(self.unpackdir, "npm")
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_alternate(self):
-        urls =3D ['npm://skimdb.npmjs.com;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0']
+        urls =3D ["npm://skimdb.npmjs.com;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0"]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, 'npm')
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.js=
on')))
+        unpackdir =3D os.path.join(self.unpackdir, "npm")
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_latest(self):
-        url =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/nod=
e-server-example;version=3Dlatest']
+        url =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/nod=
e-server-example;version=3Dlatest"]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, 'npm')
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.js=
on')))
+        unpackdir =3D os.path.join(self.unpackdir, "npm")
+        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_invalid(self):
-        urls =3D ['npm://registry.invalid.org;package=3D@savoirfairelinux/=
node-server-example;version=3D1.0.0']
+        urls =3D ["npm://registry.invalid.org;package=3D@savoirfairelinux/=
node-server-example;version=3D1.0.0"]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
@@ -2798,7 +2798,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_invalid(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/in=
valid;version=3D1.0.0']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/in=
valid;version=3D1.0.0"]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
@@ -2806,145 +2806,145 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_invalid(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dinvalid']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dinvalid"]
         with self.assertRaises(bb.fetch2.ParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_none(self):
-        urls =3D ['npm://;package=3D@savoirfairelinux/node-server-example;=
version=3D1.0.0']
+        urls =3D ["npm://;package=3D@savoirfairelinux/node-server-example;=
version=3D1.0.0"]
         with self.assertRaises(bb.fetch2.MalformedUrl):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_none(self):
-        urls =3D ['npm://registry.npmjs.org;version=3D1.0.0']
+        urls =3D ["npm://registry.npmjs.org;version=3D1.0.0"]
         with self.assertRaises(bb.fetch2.MissingParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_none(self):
-        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example']
+        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example"]
         with self.assertRaises(bb.fetch2.MissingParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     def create_shrinkwrap_file(self, data):
         import json
-        datadir =3D os.path.join(self.tempdir, 'data')
-        swfile =3D os.path.join(datadir, 'npm-shrinkwrap.json')
+        datadir =3D os.path.join(self.tempdir, "data")
+        swfile =3D os.path.join(datadir, "npm-shrinkwrap.json")
         bb.utils.mkdirhier(datadir)
-        with open(swfile, 'w') as f:
+        with open(swfile, "w") as f:
             json.dump(data, f)
         return swfile
=20
     @skipIfNoNetwork()
     def test_npmsw(self):
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D',
-                    'dependencies': {
-                        'content-type': "1.0.4"
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D",
+                    "dependencies": {
+                        "content-type": "1.0.4"
                     }
                 },
-                'node_modules/array-flatten/node_modules/content-type': {
-                    'version': '1.0.4',
-                    'resolved': 'https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz',
-                    'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
-                    'dependencies': {
-                        'cookie': 'git+https://github.com/jshttp/cookie.gi=
t#aec1177c7da67e3b3273df96cf476824dbc9ae09'
+                "node_modules/array-flatten/node_modules/content-type": {
+                    "version": "1.0.4",
+                    "resolved": "https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz",
+                    "integrity": "sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D",
+                    "dependencies": {
+                        "cookie": "git+https://github.com/jshttp/cookie.gi=
t#aec1177c7da67e3b3273df96cf476824dbc9ae09"
                     }
                 },
-                'node_modules/array-flatten/node_modules/content-type/node=
_modules/cookie': {
-                    'resolved': 'git+https://github.com/jshttp/cookie.git#=
aec1177c7da67e3b3273df96cf476824dbc9ae09'
+                "node_modules/array-flatten/node_modules/content-type/node=
_modules/cookie": {
+                    "resolved": "git+https://github.com/jshttp/cookie.git#=
aec1177c7da67e3b3273df96cf476824dbc9ae09"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'c=
ontent-type-1.0.4.tgz')))
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'g=
ithub.com.jshttp.cookie.git')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/cont=
ent-type-1.0.4.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/gith=
ub.com.jshttp.cookie.git")))
         fetcher.unpack(self.unpackdir)
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm-s=
hrinkwrap.json')))
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'package.json')))
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'node_modules', 'content-type', 'package.json'))=
)
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'node_modules', 'content-type', 'node_modules', =
'cookie', 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "npm-s=
hrinkwrap.json")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "node_=
modules/array-flatten/package.json")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "node_=
modules/array-flatten/node_modules/content-type/package.json")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "node_=
modules/array-flatten/node_modules/content-type/node_modules/cookie/package=
.json")))
=20
     @skipIfNoNetwork()
     def test_npmsw_git(self):
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/cookie': {
-                    'resolved': 'git+https://github.com/jshttp/cookie.git#=
aec1177c7da67e3b3273df96cf476824dbc9ae09'
+            "packages": {
+                "node_modules/cookie": {
+                    "resolved": "git+https://github.com/jshttp/cookie.git#=
aec1177c7da67e3b3273df96cf476824dbc9ae09"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'g=
ithub.com.jshttp.cookie.git')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/gith=
ub.com.jshttp.cookie.git")))
=20
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 },
-                'node_modules/content-type': {
-                    'version': '1.0.4',
-                    'resolved': 'https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz',
-                    'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
-                    'dev': True
+                "node_modules/content-type": {
+                    "version": "1.0.4",
+                    "resolved": "https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz",
+                    "integrity": "sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D",
+                    "dev": True
                 }
             }
         })
         # Fetch with dev disabled
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
-        self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2', '=
content-type-1.0.4.tgz')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "npm2/con=
tent-type-1.0.4.tgz")))
         # Fetch with dev enabled
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile + ';dev=3D1'], sel=
f.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile + ";dev=3D1"], sel=
f.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'c=
ontent-type-1.0.4.tgz')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/cont=
ent-type-1.0.4.tgz")))
=20
     @skipIfNoNetwork()
     def test_npmsw_destsuffix(self):
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile + ';destsuffix=3Df=
oo/bar'], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile + ";destsuffix=3Df=
oo/bar"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'foo',=
 'bar', 'node_modules', 'array-flatten', 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "foo/b=
ar/node_modules/array-flatten/package.json")))
=20
     def test_npmsw_no_network_no_tarball(self):
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 }
             }
         })
-        self.d.setVar('BB_NO_NETWORK', '1')
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        self.d.setVar("BB_NO_NETWORK", "1")
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
@@ -2952,112 +2952,112 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_no_network_with_tarball(self):
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1'], self.d)
+        fetcher =3D bb.fetch.Fetch(["npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1"], self.d)
         fetcher.download()
         # Disable network access
-        self.d.setVar('BB_NO_NETWORK', '1')
+        self.d.setVar("BB_NO_NETWORK", "1")
         # Fetch again
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "node_=
modules/array-flatten/package.json")))
=20
     @skipIfNoNetwork()
     def test_npmsw_npm_reusability(self):
         # Fetch once with npmsw
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
         # Disable network access
-        self.d.setVar('BB_NO_NETWORK', '1')
+        self.d.setVar("BB_NO_NETWORK", "1")
         # Fetch again with npm
-        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1'], self.d)
+        fetcher =3D bb.fetch.Fetch(["npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm',=
 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "npm/p=
ackage.json")))
=20
     @skipIfNoNetwork()
     def test_npmsw_bad_checksum(self):
         # Try to fetch with bad checksum
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-gfNEp2hqgLTFKT6P3AsBYMgsBqg=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-gfNEp2hqgLTFKT6P3AsBYMgsBqg=3D"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
         # Fetch correctly to get a tarball
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
-        localpath =3D os.path.join(self.dldir, 'npm2', 'array-flatten-1.1.=
1.tgz')
+        localpath =3D os.path.join(self.dldir, "npm2/array-flatten-1.1.1.t=
gz")
         self.assertTrue(os.path.exists(localpath))
         # Modify the tarball
-        bad =3D b'bad checksum'
-        with open(localpath, 'wb') as f:
+        bad =3D b"bad checksum"
+        with open(localpath, "wb") as f:
             f.write(bad)
         # Verify that the tarball is fetched again
         fetcher.download()
         badsum =3D hashlib.sha1(bad).hexdigest()
-        self.assertTrue(os.path.exists(localpath + '_bad-checksum_' + bads=
um))
+        self.assertTrue(os.path.exists(localpath + "_bad-checksum_" + bads=
um))
         self.assertTrue(os.path.exists(localpath))
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_premirrors(self):
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1'], self.d)
+        fetcher =3D bb.fetch.Fetch(["npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1"], self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
         # Setup the mirror
-        mirrordir =3D os.path.join(self.tempdir, 'mirror')
+        mirrordir =3D os.path.join(self.tempdir, "mirror")
         bb.utils.mkdirhier(mirrordir)
         os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(=
ud.localpath)))
-        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/' % mirrord=
ir)
-        self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
+        self.d.setVar("PREMIRRORS", "https?$://.*/.* file://%s/" % mirrord=
ir)
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
=20
@@ -3065,51 +3065,51 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_mirrors(self):
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(['npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1'], self.d)
+        fetcher =3D bb.fetch.Fetch(["npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1"], self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
         # Setup the mirror
-        mirrordir =3D os.path.join(self.tempdir, 'mirror')
+        mirrordir =3D os.path.join(self.tempdir, "mirror")
         bb.utils.mkdirhier(mirrordir)
         os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(=
ud.localpath)))
-        self.d.setVar('MIRRORS', 'https?$://.*/.* file://%s/' % mirrordir)
+        self.d.setVar("MIRRORS", "https?$://.*/.* file://%s/" % mirrordir)
         # Fetch again with invalid url
         self.assertFalse(os.path.exists(ud.localpath))
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://invalid',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://invalid",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
=20
     @skipIfNoNetwork()
     def test_npmsw_bundled(self):
         swfile =3D self.create_shrinkwrap_file({
-            'packages': {
-                'node_modules/array-flatten': {
-                    'version': '1.1.1',
-                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
-                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+            "packages": {
+                "node_modules/array-flatten": {
+                    "version": "1.1.1",
+                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
+                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
                 },
-                'node_modules/content-type': {
-                    'version': '1.0.4',
-                    'resolved': 'https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz',
-                    'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
-                    'inBundle': True
+                "node_modules/content-type": {
+                    "version": "1.0.4",
+                    "resolved": "https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz",
+                    "integrity": "sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D",
+                    "inBundle": True
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
-        self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2', '=
content-type-1.0.4.tgz')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "npm2/con=
tent-type-1.0.4.tgz")))
=20
 class GitSharedTest(FetcherTest):
     def setUp(self):
--=20
2.39.5


