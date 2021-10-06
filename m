Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F3EC433F5
	for <webhook@archiver.kernel.org>; Wed,  6 Oct 2021 14:36:18 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.65])
 by mx.groups.io with SMTP id smtpd.web12.12839.1633530974766513842
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Oct 2021 07:36:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=rCcBVMZH;
 spf=pass (domain: weidmueller.com, ip: 40.107.6.65,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAOTMxmByhjuTHp32cm6EDbIRJIiTMD+YtmQwIAY2utJY5OMrDjvyQW/n4QWpvHC5FM4A2dI7x0XoR7cs96eLKc8R5ZneuKQE00CnkMKS2MX4HsN9L+IbHR00ijWv0ytnwQZ/2/GlnmBKnkUqRrdiz4zE0Ga6+nmzF8c6HlDo2rDKKfq2Tm80H/H2qJotxjSpPP3U5P2pG1RFjbdBBUXupbm/TXPqFHmVM2OqSoxtBH+a8ZkBgep92j0WfETOSeETmu8BoLYDfigbNZ2A+Ny33lIhQThksLRPJ6rBWjRAIj8ieAmdRBbhUG+gqWjuIU0K5ImStst6U7mq2qTZO0z/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utubqX5OaIpTU+ImkyvgrdMSBZojJjVMeJqorQlRSdk=;
 b=WJDF0+gKDxPs0IhF9SnPHqUQcJRF4KjdWtHBc+etob4KtuA5su3ElPSlH8fLChN7m+8NYPzkeU3GLeix5V1ny+ihyeMy/pMApbWekcgIwNG+tzurfPjNoloIEfMgJVASSvyNMiSo0NmCs5Jcdaj6lE8tWrazS/lNgOUpgFA/88z+U/+huJkUcZY9vohw/0JOrC32awluZ/DJ3EsEmoLLuRglqTORbSOjENYtxOYyC3tOmepmJg8IhrvRDoxincanz5d7rZZWWB8tVgsf/g4NYNTjD/GjbFiDQ0fLVrNe7nNxfpPQG07/qgSypwP7nRnPNREJvD9I/Gr4SbakwF0x4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utubqX5OaIpTU+ImkyvgrdMSBZojJjVMeJqorQlRSdk=;
 b=rCcBVMZHHlRUks4XXK7BPJms5zzJAl80+G1PeEcGWzdc2nEDraiwjzf0AJTjKWSW8d2POWp4o8SyShvbaNr0m3g00jJGHC7lmIgjp6lHCpKMV1aJndHVdMrUGNsWWW/SCi9i1/nWHsDhqVDg6xg4SRb2W/80C4fgFZT5w4SuWZQ=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PA4PR08MB6206.eurprd08.prod.outlook.com (2603:10a6:102:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 14:36:12 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::8034:af5f:f101:d1f0%4]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 14:36:12 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 2/3] fetch2: npm: Create config npmrc in environment
 instantiation
Date: Wed,  6 Oct 2021 16:35:53 +0200
Message-ID: <20211006143554.3734-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: 
 <20211006143554.3734-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20211006143554.3734-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0073.eurprd06.prod.outlook.com
 (2603:10a6:206::38) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (87.129.248.106) by
 AM5PR0601CA0073.eurprd06.prod.outlook.com (2603:10a6:206::38) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 6 Oct 2021 14:36:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b69d5422-f1af-4ae6-2dec-08d988d6a502
X-MS-TrafficTypeDiagnostic: PA4PR08MB6206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<PA4PR08MB6206D34D24A186370DF8B661D7B09@PA4PR08MB6206.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ii+mQrT7HLVZzPWesdYL/HXpLWR/Y5Q5cR7WsUqGBH8qXuRY6MVhqbldD2N1SSSjUyX/Nu+YkEC7falhVd6C8l7fXfVHzaFiqs3Eg3SmROcI04mUJP97pFZ91hmWIQJ45DU+2yoxz4hQYoZ47BLR/TX3paYm/G+pcWFsFoWQ469P3KW4Xjlk8YXfnuVfHDd7TM4YjuODr1x16OGSbglsDmuQI6udGCy5f3Qi2Sv+AN91aX6L0rcrTQ/s7mPQR1aK8S4zAxN5xedKzrz0N2uGCBvtVGPfeNdGz18CO3o5TV7+NCWcUZS2ne6Eqt+GqkhtQZLRcT/peVDAYsC7QKBy+17C4jm1sKp3SJIBX8SUDuDtC2ootPnwHXorieGaUOpbMT1chEMUFlWwGh5t9G4bCHZFEUG06RuoPcK1/DWTEjrUILHHtNL6V9WuqSYDYbz55I2CtNd/FoZ6eifOknrNSRzmA/aNgSV/qGEA7wKfipyHZKXOIXs0lJQSWNCkThYgA5xMiX7vRGHjPuV0bxGCBp/9Ez0wHrGGC6iFBUkDrUtEghRGtk2I1Qjo7yLisPHgP6Y7QaNW0MhnNcUeE0wmd3G3uXfXYY0BlXvfkIRKnQrX9/9cryy+Yygr4v6POG09vg/Szpmmn+mcGiL1ebuygxt0D17NCFLrfjKKME50rUvRa5Z/eU7bhOmpKNgrwAkT3g9fmIQ2v5ELHgAr1Vi+Uw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(2906002)(83380400001)(5660300002)(6666004)(6486002)(316002)(107886003)(52116002)(956004)(2616005)(38100700002)(38350700002)(186003)(1076003)(6916009)(4326008)(36756003)(508600001)(86362001)(66946007)(66476007)(66556008)(8676002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ha2x8yW8PtYvsFKijAvEt3d/AyWMl1GbMm86+UR8OsS90TZxBrDQeakHOhTu?=
 =?us-ascii?Q?lx+S+kZbEEk2/IFRydQyjvVLMhic7BXcYoZKJBnX35VJG3NJ2i3gmzx89qdn?=
 =?us-ascii?Q?zVYUqutzjO+62/TlpgHtpNSDQfnbXcZLC91BNZE3DEUTZXxL+vppC8h6SrJL?=
 =?us-ascii?Q?7B/2SAkMI5OwyU374k1TbbXeoY6ZS3fN18FA3XWqyDcotAboiELRv0UNlHxk?=
 =?us-ascii?Q?RLJsnhrMCnAgK+VSSRw75rOAhiYJWyAreeuHolb2HD5S0BZxyJhtci0VIrt9?=
 =?us-ascii?Q?IME5tSqPHNJQELgj0qljbv23vpPnwxh5y1HliG7DT2I/UyXIIZaL4zBorBJV?=
 =?us-ascii?Q?qbXEPzWoefo9GMjYmvxuPzLN1h88XAbRNiUMXoibFCWe9dC4ig5seYGm2bqm?=
 =?us-ascii?Q?GznUMgfalJ3wfJxDNvkb3cnmWl9wEI82SxSVYz2WR05TpTAOLpLgy8W+g9xG?=
 =?us-ascii?Q?EHgSUZ+3oaRId3fd0i6MMLMMrjQNbYgTVnCtIRm/AcekCZxDXcMWaNgMr4gj?=
 =?us-ascii?Q?PJH09gvBlOlsr7LSnVONF6lTtx4sFqd464MUYR5nACDAdQ/iZ/8I34rJ/1a5?=
 =?us-ascii?Q?PdvLa0cm9pTFO5hZgPtXh0IwrMayQjTLHvFEG1IcHCtdJIUkdAMTAS7D0wu0?=
 =?us-ascii?Q?WXcwfSFDmlGdwe1JPVaSu175L+7w6BLgH8yK1vlBbect3s0weuaHL/JUqiBz?=
 =?us-ascii?Q?nl+yNmPMnp4bEXBW44Tnr9qC7yqlmZgmg+xq4XdGWxsthYKiq+Kdv3kfBbM6?=
 =?us-ascii?Q?+/DgFIe23DLd9QFXCVeDm761rlghNNRvT8iKdPMm+Y6u0Sjxs7czLx5CGKD3?=
 =?us-ascii?Q?hC+IUlPBDAFAxZ0dx2+XRAKIMw7f/pqUCasrSDYgmj/rgHPuCzi4ILY/C/of?=
 =?us-ascii?Q?oTX5kDlzmrjx+5uZ6Ze4djXZDUMdV6XocuvtSHCj9s28xbeh8Nb4DIUA1Pft?=
 =?us-ascii?Q?Z9/fecPYNaYr3NBHN3sznXOLhGbUDAZkV9fCyersoI6AatNE3zWHfU2k2/w2?=
 =?us-ascii?Q?+qF8ZiHE3H+zWIi4A4BK+c41hT2qSGf2+HPG6meOCZLY1yrYeM3LhGvUaGEI?=
 =?us-ascii?Q?f/QQ1ZB7zI/GtbVcaPWFazyACeVMJ9i3rD1gmwaNkbN0nuNT/Xln8QxDOTL4?=
 =?us-ascii?Q?SVTRtZXxFZiVN5yqUbgYUVlH9YRsxME4WZjbf3kTPI6TkyAMVandpAVV2/5c?=
 =?us-ascii?Q?1Kp4EBVpaI9mZdZd6N1IO9PXIbBDXEmH+wkzTv8V2sM33dsz108nSQyv7RgY?=
 =?us-ascii?Q?uFzKhD11isymUh6EMic4bcqHiHI71/5a+NHMBMoegXpLGHsDwQhZhA2ezm69?=
 =?us-ascii?Q?leHWGCJe+7/3/Z38cUrkOZwE?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b69d5422-f1af-4ae6-2dec-08d988d6a502
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:36:12.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 GzgS4Mms1HSMeidhKZii9v6XttYmKD0XGsSLP0H6nnmvBpalwYtXZLPmdm9VFJH1h/NBZLwh8Cn4fKFBqvi10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6206
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Oct 2021 14:36:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12730

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Create a configuration npmrc per npm environment to avoid repeated
creation of the same configuration file. Create the file via python to
avoid multiple npm config calls and add the ability to pass a file
path instead of a temporary file.

Deprecate the npm configs argument of the run function. The configs
should be passed to npm environment or as command specific arguments.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/npm.py | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index a39f1c19..e497c38d 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -79,9 +79,25 @@ class NpmEnvironment(object):
     Using a npm config file seems more reliable than using cli arguments.
     This class allows to create a controlled environment for npm commands.
     """
-    def __init__(self, d, configs=3DNone):
+    def __init__(self, d, configs=3DNone, npmrc=3DNone):
         self.d =3D d
-        self.configs =3D configs
+
+        if configs:
+            self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w", b=
uffering=3D1)
+            self.user_config_name =3D self.user_config.name
+            for key, value in configs:
+                self.user_config.write("%s=3D%s\n" % (key, value))
+        else:
+            self.user_config_name =3D "/dev/null"
+
+        if npmrc:
+            self.global_config_name =3D npmrc
+        else:
+            self.global_config_name =3D "/dev/null"
+
+    def __del__(self):
+        if self.user_config:
+            self.user_config.close()
=20
     def run(self, cmd, args=3DNone, configs=3DNone, workdir=3DNone):
         """Run npm command in a controlled environment"""
@@ -89,23 +105,19 @@ class NpmEnvironment(object):
             d =3D bb.data.createCopy(self.d)
             d.setVar("HOME", tmpdir)
=20
-            cfgfile =3D os.path.join(tmpdir, "npmrc")
-
             if not workdir:
                 workdir =3D tmpdir
=20
             def _run(cmd):
-                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " % cfgfile + cmd
-                cmd =3D "NPM_CONFIG_GLOBALCONFIG=3D%s " % cfgfile + cmd
+                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " % (self.user_config_=
name) + cmd
+                cmd =3D "NPM_CONFIG_GLOBALCONFIG=3D%s " % (self.global_con=
fig_name) + cmd
                 return runfetchcmd(cmd, d, workdir=3Dworkdir)
=20
-            if self.configs:
-                for key, value in self.configs:
-                    _run("npm config set %s %s" % (key, shlex.quote(value)=
))
-
             if configs:
+                bb.warn("Use of configs argument of NpmEnvironment.run() f=
unction"
+                    " is deprecated. Please use args argument instead.")
                 for key, value in configs:
-                    _run("npm config set %s %s" % (key, shlex.quote(value)=
))
+                    cmd +=3D " --%s=3D%s" % (key, shlex.quote(value))
=20
             if args:
                 for key, value in args:
@@ -167,14 +179,14 @@ class Npm(FetchMethod):
=20
     def _resolve_proxy_url(self, ud, d):
         def _npm_view():
-            configs =3D []
-            configs.append(("json", "true"))
-            configs.append(("registry", ud.registry))
+            args =3D []
+            args.append(("json", "true"))
+            args.append(("registry", ud.registry))
             pkgver =3D shlex.quote(ud.package + "@" + ud.version)
             cmd =3D ud.basecmd + " view %s" % pkgver
             env =3D NpmEnvironment(d)
             check_network_access(d, cmd, ud.registry)
-            view_string =3D env.run(cmd, configs=3Dconfigs)
+            view_string =3D env.run(cmd, args=3Dargs)
=20
             if not view_string:
                 raise FetchError("Unavailable package %s" % pkgver, ud.url=
)
--=20
2.20.1


