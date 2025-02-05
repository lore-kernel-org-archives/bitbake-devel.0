Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27877C021A0
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.128])
 by mx.groups.io with SMTP id smtpd.web10.6665.1738739756512032404
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=Mu9RhAAx;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stApKPUZddN6gknD+oBcYkB7gGkg8mXnpudoTs5qGgwPfFP7k4XytZ2pjHi/aysvhM6MA0dWdiMHltxcBJMOxuLcCDQ3WbJpEykCJ5m0qb1W1yKZOmtWtJELLXeV8+Y+sD6HntJw+t+dt+zxiszxKncks6MQanGJQtIbJ0/rKHmSW3pbUBVEeUz1898gSo1aMcvRH2R1IMRKqF+q6/ARtTlKUIaauUbF1anznfsu7Fjm0nve8wflxYeoWIiZzUbpU08Sd4IZerudimi/u10OqWy8UAPY9FdB1kuXvdLguJTG58SRAbzF1Q3aVe+4CZgLE7nLa5JE3nqzqrD1FsFuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8etdPKbcLYyoAHOtdrw23JDPxnOh5bDZZRVDpfXUYk=;
 b=GBKnxAeLtisiGzUNDPad1puggDcjVJndUaE8Nb8eejWyan5SLrxhq0uLehXU+SNzPtIKnRrEl7UpU3ihG9idYNgM36QD3Yyz1qCF3A0FF3sjA+Sqxru/E2AbOhr3k0C5lznu5KWlEESBRxvCmGeiGTJyiDw+ktuRwGrgDAirybMdNo3Sj1Y2h+OwpoUI9D2RdsrIjpocOCFLKc7eo2pqFHCdj2RP4196DwaxwY/7AfOX2TgDeWztySWjW3onaqsECYISAtjyGcGG4u9whylqLyz2SE2XrTUaA5owE7FQRKFkurANoEVoYtkJxcNPtcKNzLQVXR/ugYeaUTsOfixFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8etdPKbcLYyoAHOtdrw23JDPxnOh5bDZZRVDpfXUYk=;
 b=Mu9RhAAxrkMLRQA2b9/luw93n69iYxBbocsA+YA93NOkcItrqpdaU3gVPxUS5kGj3k6G590u06OUKOHslXn0k3dohXCx/rApkZwQp4Fbx2TXDyLHBs5FbCNWZcrlCJ+GxUnjdpzdEzPomUxF0i8mTZZwqVfX+jdPuD59IpoL8mCo2gyD9kDIGVAZDGmk3tMoTWlU0sACgv6o2fjDhKps6zx3f8cwk1GkvZQReAFCcUJxkycEX+31X9jz1UGXYmWr8OJgVJzKpmnRb/e5XLwuVfrt8iKg2PsK1j0cuYvRy7NLWWl012dt2DCxAIheccYBc265ePaEtd6HAdzj/o/amg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:51 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:51 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 03/15] fetch2: remove unnecessary unquote
Date: Wed,  5 Feb 2025 08:15:26 +0100
Message-ID: <20250205071538.2681-4-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f4f1c7-a5ba-478e-4ae8-08dd45b4ebca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LkVeTrXwnhL1c17C2PQ8jRHIvrR6tPEVSYtzainTc2jsDreObPMXlZFlNIT6?=
 =?us-ascii?Q?l/b2GzVtGHjr3AkGskEOLvuUNKCsdleN/A1iXPoa3jgykm8lUCyqtrQ00jGj?=
 =?us-ascii?Q?m1q11tLusfFWemq08b+ytPDPKXhC2gFB/iCUGPc9ZR71z+sIS9aZIQuK8qyC?=
 =?us-ascii?Q?TCAk/mT2eKVaLFZXz4kyl+TOHrydWG51VfXKTVZd8MAObwY/oPlnSx2JTJOP?=
 =?us-ascii?Q?gCGo00KBtOFSZyhG2kpdDTBrX14qfTCWniDHT7kc51p2Yi3ZWfTDUJTNpi9B?=
 =?us-ascii?Q?NeAaplxUgYVVB0mGY/pn7WSyukEbdKaq0uX+u59v5ggiImwhDSbT9KAaQYbB?=
 =?us-ascii?Q?wq24z0hUla424jKBWQ0WivYhiqMq6bJvQQj1PxO/Tdh3SCAaPNaXrt2VhbQ/?=
 =?us-ascii?Q?F5tsPhD2/TrEPr4ZJMKl0+wF4HyTt7yFkoS+95c9NW0ZIT8pPuTP4d3emOkN?=
 =?us-ascii?Q?8cl/xIB40QZCkWgA9108lKL6oObvXBPVGIm2vgUqbknHAAOfuOPJu+PTB2l9?=
 =?us-ascii?Q?yPbtUXHqDHaB29+UDPSRK+4Eef1xALWnlII2ic/Web7qWGZnYe6bbz79pF+J?=
 =?us-ascii?Q?3kwaCjWOpQ+YVyF5ItEK2gJ9LsSO/uuZXpzRoIrKWUfyWRCmf8/uAFmh+Yy4?=
 =?us-ascii?Q?wp7RvPl5ZTdxMguXTxiJ2N+7ipzVRTCtfO2NpguI9eGeSx/Pqy+m4uPQkbac?=
 =?us-ascii?Q?NT2XVsnJsJ7Nt1NKCSzwhSfNznJ1CHgMp5BMmKRB06swLQnlVSpH2yquXxmL?=
 =?us-ascii?Q?sp0kRsQ6zz+V6I9bZisesAdu6p/FnfBpotd2ye5BpFyYFCNGfnzoe5XhoiQb?=
 =?us-ascii?Q?fHRD/z39zcngSW/tyNEfBEFnrtfst3V3ygFWaV4e9fTUfpSBAIU5ApCZEdDh?=
 =?us-ascii?Q?DriQ9V8Z+qP5k0MjhSqt4jf+FpQLzuifNtzJd0k4//27fOwSX5KeCn09/M5j?=
 =?us-ascii?Q?GnwXzyNS67b/978jyVA+68RfcAPzDgMTGvGDQIBK9Ltkk8B59LB6CRrASRKS?=
 =?us-ascii?Q?1yyFCwsaJlpTpABFHoxPDHsMtlDMhzuLAciap2ZfvlglejDYDYiEqTW2taXT?=
 =?us-ascii?Q?lthbpiJ8lt/T0L3/xvtxRm8yO4xlHbwGWErhhfcHoiXVaKOQgwYk7TGB31dA?=
 =?us-ascii?Q?xyWSwZy7gX6UVESuW5HpdvC+/D244w//JKmvtku0D2oWupTrqHA4zIsvsZ6s?=
 =?us-ascii?Q?BqwBqO72uSLUV5Jao4qRZDB1ninccR49XYvvINpYB76K72RHBRBWjXMKdPv5?=
 =?us-ascii?Q?H1iTVhz45iVgMjY+44Z8E36Nut/pTsVBsl8ec4fmGbrMNWCg4zoz/8vNEC7H?=
 =?us-ascii?Q?SOGcvGifav8GFMGSPj/7pHwYIYqvPg1J4i3K9nAJkKfzNvKjWP3GJjBxzJT9?=
 =?us-ascii?Q?u0Tpo+j7rL1ST2CRuP0WcR2tb12HZVEkKR8OgoIxtfnui0qiHvOfjd/pBNym?=
 =?us-ascii?Q?+N73FI2rut3zgwZ+1dcfjGVgdrA4+gdl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:da;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R+aHlWkwgsJdyCtobdxr+ZITViXS8OY8StYgWgQT6EboL0TOVIweQ8YmeQrH?=
 =?us-ascii?Q?DjDcEHq5LjVS08EfF0NaV6y07ZYZaEKaIZ31xDms+ZdFW1mS4Ax0pvfpSWYN?=
 =?us-ascii?Q?xo7Dt3cUGEx8QQwqm6InMD+UK+TZaGAgBh6TvzNencMJznkf2Tc+vsd/Y6qv?=
 =?us-ascii?Q?XGFynqLA4z8o+lYYeFvsPySQQE96sHDnNgDpbi0w6npI3SjqamTHu+a3DOoX?=
 =?us-ascii?Q?GwO+Z9++MCXwr0FnqbWAZ5O5jMsAc6PYxIlezxlQCqhkN1KvnBYiI9QY0Pqz?=
 =?us-ascii?Q?Euvuk7+CJP/R1e16gJtS0cCzWuGFaUuqfTxIDH4HmB8mltHwueQJ/WKzvEyx?=
 =?us-ascii?Q?GgqRUeaq8Am3xdHmQ/k3KAj24PpS3OxpJouiscWeAV6W0CEOpp041IbxwbiI?=
 =?us-ascii?Q?SYeeMwqfLS8ByjS9aNdFoRbBI0njUs884mXXrUKTwxu4CaARKC16qKWttKOH?=
 =?us-ascii?Q?U77MwICKZwoRiLyfoiXkBhX4bKtA9pD1gYMVK55ITMtZ0wS3O20pXjZF3yCw?=
 =?us-ascii?Q?F6FEYg9f65ojjPrNUFUcjg9QGeiqg0+dox2vExktCAeXsDQOCCljBOhbPm0x?=
 =?us-ascii?Q?3Yv7TUvtkgu6JpTUmwRZ1WigEb+m6Axyzy6kiLW8vcK5fqtr6YD3mQzZR35Y?=
 =?us-ascii?Q?+n+r6iLdvxw93l1v/Dbb90EFWynWWBTjB5hH0w58dtGbbYW2DohbUxDiuwsh?=
 =?us-ascii?Q?lEjD4rshzA5uCNDVwCcCyrM8szxjStd/Uan9uRT9YElWQslawPA8clcXw1kT?=
 =?us-ascii?Q?7XBnfyFKdKoaJUsHlvJbusbRxmPs/3rHbMewTLkydqWxULmcU0Zj+3ekg1JX?=
 =?us-ascii?Q?o0Jvw15Il+kxqVaQZhqblnqr8iYA/sSSu4ZANN7YyHIrhq8/vEZWWSrlxdkg?=
 =?us-ascii?Q?M214PSM+Nfpqr6b7bi8JGkHTrREvpfDgIpDMNd655952tHIzGoM/Sgz42OWJ?=
 =?us-ascii?Q?4uXCApXfMYt0DRJN4t1rKH578XIVhBrpkKtiC8IpuCMFypslpajI2XimLibO?=
 =?us-ascii?Q?eUzmn0pnUEcaGIgvm5y3ZyuB61mFTgFa9Ub0dpSjl5epbZaPfke0rsGK6YGN?=
 =?us-ascii?Q?mz6nS8a4RCRETCoK/QEv3oxbqLpO6unmbUFANnBNfKkwl7VIM0dPeMQet2mW?=
 =?us-ascii?Q?fWccQB16KNcERny0gCfA4U0lkeIiyBWl3M5i26fPaNA508oczdXoNELJooIG?=
 =?us-ascii?Q?79prVhHG7xmsr9Ma2rI5i3z0W7a9r8+VzDDfy2N7jcHRg5ThEcAxAiJNuGT/?=
 =?us-ascii?Q?H1GuN4Rz7fXt6fPa7MMCQCjE49yHXOC2wOhnpFpe18DOk2houW00il6T9OT5?=
 =?us-ascii?Q?AbZm8G1rXayXU0Vm2LcanUf2G74Xw97YqBDeTf8JZSbFVmrAhdl/l3vh9lpw?=
 =?us-ascii?Q?uhRrUx0wgQs+UhlzsPu/Oi6gT5+2JNORgjELwexi4LH0RQYbN/MDCAj4aftJ?=
 =?us-ascii?Q?XunT0XnUaIMdhJAhNV6JVOfRvAnKblZcY0xY4+74o2d6rN+SDLWQEUPqQ+1J?=
 =?us-ascii?Q?JjQCZVX8wrPhMd6QuegI7nKlRWLKPVx69hgKKfepImrzYkmoBw5h1Kj1h6I9?=
 =?us-ascii?Q?lusCVcjj+bKDK14hPKSP7yEQ5EF+JHqgSHp3iMI5AWUjsR5JNGT3HkIKOePz?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f4f1c7-a5ba-478e-4ae8-08dd45b4ebca
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:51.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OsG3D7YLCOBytcTGRILnM4YnkDppXtGtaPuvxV6oxvrG+5k8PPxrdYqL3eBHsAUgSG0sfrWqceepbzfkIy1Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17135

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The URI path is already unquoted. Remove the unnecessary unquote
function calls for URI path values.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gcp.py  | 2 +-
 lib/bb/fetch2/s3.py   | 2 +-
 lib/bb/fetch2/sftp.py | 2 +-
 lib/bb/fetch2/wget.py | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index 268267b7a..86546d40b 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -46,7 +46,7 @@ class GCP(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D urllib.parse.unquote(ud.basename)
+        ud.localfile =3D ud.basename
=20
     def get_gcp_client(self):
         from google.cloud import storage
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index fa5292dfd..22c053813 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -77,7 +77,7 @@ class S3(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D urllib.parse.unquote(ud.basename)
+        ud.localfile =3D ud.basename
=20
         ud.basecmd =3D d.getVar("FETCHCMD_s3") or "/usr/bin/env aws s3"
=20
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 45b6afb4a..bee71a0d0 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -77,7 +77,7 @@ class SFTP(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D urllib.parse.unquote(ud.basename)
+        ud.localfile =3D ud.basename
=20
     def download(self, ud, d):
         """Fetch urls"""
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 7066d5e2c..6cb728ab4 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -78,9 +78,9 @@ class Wget(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D urllib.parse.unquote(ud.basename)
+        ud.localfile =3D ud.basename
         if not ud.localfile:
-            ud.localfile =3D urllib.parse.unquote(ud.host + ud.path).repla=
ce("/", ".")
+            ud.localfile =3D ud.host + ud.path.replace("/", ".")
=20
         self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -=
t 2 -T 100"
=20
--=20
2.39.5


