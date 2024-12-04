Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B877E77171
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 17:31:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.69])
 by mx.groups.io with SMTP id smtpd.web10.20751.1733333480853553493
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 09:31:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=j8nzGmla;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.69, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FucSfOwOaY4R8b4DGshWDig22wsSXPavD38Z3f6HFZOcyQ5k5lhc+JFEXSlQEw2vRseANaIjHk87rgtsh1inIc2DrJaWcNXf28WD/4aHzW/2pm7gaj03ekHNnLrvuf1Ve7Afo99RSzgkrlETQcwl3uJA3sag8So3PvgH7J9SLuvsmugLKmliHmrRha0/fw5FhayHdRstZXpkR0yVp/ZJkzkirkjhG5871MHLc0hxSAZG66Urk8GxxvM3rUm0Ap3U7bNgs+Fb9tyn5/OdvbzvEEgT1K7McjET04HKlic0CzHkw7MKqdLDbr41xHQPog2kMw7XFMNMdgf2phfOGlNtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYEMkfdflMHYfxu2+is1dRQNPJnn7BXr/1O2vScMzOI=;
 b=AAbyiUQwv+p7gVwzSyDrf3ebmbJnmtCV44kmgKSIhQ6fAebQvwiV6OtDlaKsttyYyd6A93fzzZHYtl1df9NHQixmSVGjczK1MXdmFMpOWGozqF+2rPQolr4fiGZ+c+HZHdc6wsQ+ZczcdRAvgZx8ViEHOfUOzQ6UgdAIV88v8DXM6CfYhE/8p8djLJj0jyfw6HmEsNb0FHLniR1bSlf1Vwbsk1LmcI9Dk0XBr2u02h4nB7n90BI/ScPzrtwMBRnJQ1qP2Tu24NG0iIajR93oOPubQWdAeNAXYegvw248ND6NvLQgIEyp/SXWVoNuu4INapqAEBwqASbkTjacLNY/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYEMkfdflMHYfxu2+is1dRQNPJnn7BXr/1O2vScMzOI=;
 b=j8nzGmlaXNw1ZMaMzjEUy7ZndgKf6teDcufJAIAt2GJGUHUQ6L8hKeeN/mPdDlDXXGtoC1fcrmvnlnJuUJ688mzip5h2TQfZLc5QSmO2spqKWNiutyjRXreX2+118Djn0aaxCVbL6gllkew5RvgZorehTdJyVYl5xH1QgaBLv/LbOXuJqNeopSQ3LYe6Rh8fdydZ5c65h1rxSilXgEt5PA1cDhD/9giu0/GIfhKsMm1wAicHDQIsuksKIz9X4atr/+xakPQuxIiDNAccTV12bCgCOqdSJeZuP5jdzZMZ+X9sr0ZgXZxKXlndS8HiWQG2sRlhfh8zqHXGH5RzEs8J3Q==
Received: from CH3P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::34)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 17:31:14 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::6) by CH3P221CA0014.outlook.office365.com
 (2603:10b6:610:1e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 17:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 17:31:14 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 10:30:50 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/2] cooker: use enum for cooker state to improve readability
Date: Wed, 4 Dec 2024 12:30:11 -0500
Message-ID: <20241204173011.1415479-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204173011.1415479-1-chris.laplante@agilent.com>
References: <20241204173011.1415479-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fb5797-3a32-4c7f-f7d5-08dd148973ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f4tNiMcm0t/9CRMNj9mM/Wxs3U4vF9iYyEWYpN01W0d+ydyh/uqZoHLFH7Td?=
 =?us-ascii?Q?wnZBX331WrK22cAul/E/Kpg6vfpjimASizcimKcMDu2QiNXSpIm4P5gpVfM+?=
 =?us-ascii?Q?1fBIQUEDBgmCmh5hSxdt9uT8Et0cXq1CQ2i9CugeMeBsogLJrHZrZCqDXWd2?=
 =?us-ascii?Q?I0y6d73riaL7Fi4MTqkvNhnzMdPPCjKoRnUR+rLTdmCXc9vfGC5+OrqaNNWu?=
 =?us-ascii?Q?nygjOSwB2xMu8Cvuowj+Tvul+5na8Vkyt6BLMct/F/jbdPIJZw1mlXMMUg6r?=
 =?us-ascii?Q?zS/1haETh0EDQZ/6lYpxIp/loRhsILah7qwuwiX3sP25sE76Iu1+Z+p35PfY?=
 =?us-ascii?Q?Xecy3WdneUwe4OVwxd9k/x+9TKEhlAAhb4WtYWpp4erP/4sH4L0k1lJoC/ch?=
 =?us-ascii?Q?xcL+635bnLAePdtUWt8J59t5hUDDsEh7retn9ge2k7u5tlk5SYld/6I2T2Ak?=
 =?us-ascii?Q?///zqV7BXoGDweVyCXlDf/8g+qcfc7JrVVCF0mmmYKUDxedhs7pR0WGb0vQA?=
 =?us-ascii?Q?NFW0vZxTJNmrA0v+oiZnUPYMFG+OM99GZNG4mzul44otpzaH77fzPT8DFgju?=
 =?us-ascii?Q?heV7x9zdOsdWuxd06x8FIP41kk36UazSPTZ/7tN1YQNZbwJXXpMRNF2MvHi8?=
 =?us-ascii?Q?1Gs/fclQxWMHRB9oFSurJcPvESssZueplYjmePBlOUhT9QziaWjGDqw26ipH?=
 =?us-ascii?Q?Vcmb5qBgS2XDLowhcUQgIAsiXVSTeInvYhyjWk4NIH0D0sFRF84gzAqEykxE?=
 =?us-ascii?Q?rJR9/kLqPbAHYGu0Yr6Qj3K6IQuofpwDm+oogNPpWd9/LBQHs/hHM1RJqALS?=
 =?us-ascii?Q?4rUoz6sX2hkuafuKwdgsK5bJhy0fHOjcgIfTVPdHcsv3iZufktVsBs7Uyeug?=
 =?us-ascii?Q?q/6+w6bfrMmTPDa4UlRJiUdT3/auMLpUbhGA08zOaB3rE9vBoFeZS6gWWcdY?=
 =?us-ascii?Q?IMv65kcANsFvFYy01yDDwq3M8IWPr3ULBN0dz0CyNEafCrnkJFucx3e8Kust?=
 =?us-ascii?Q?Wo897+dOxR4w2wWj0g4xLQiON8BIpwLKK5sDMFwr/8K0sARb0w6yL2eLjI6P?=
 =?us-ascii?Q?BLLe+cUDlD1Ny4orlJap7tEJ98sOf0I+zqxyKoW7ECTwFo2NyU4doFqcOLsi?=
 =?us-ascii?Q?w9kXBp+jU337BBa4Lpkcxzslw9QA/lQtOAfSbQIYciWgvmN7L6V5XSyIz9il?=
 =?us-ascii?Q?ZGPgF3ZFJY4imdoBfCDXqg0PLdkAjEAZtOsem/wX1OG20yeJlzdxnbzeBApd?=
 =?us-ascii?Q?pJj4V2/fCGbP8eNc4Rm0a8ADDkPDTQQ9wbiuCdSCMr37REYXuw1S7F4XkXt7?=
 =?us-ascii?Q?e8L6D8F9M4BLZHFauERAhx7pahiXAaIqR/XQeUMzDQ8mh3LtaE73yDGiM8uu?=
 =?us-ascii?Q?NpvNSpuI8D99OaKz+lzNU/PJMX1aHG1y3ase1YCWjIFh8OxdRVDvshs0ra0i?=
 =?us-ascii?Q?Xk9EAcuJrRLtZZZQBKGGubPD/fqeCiwF?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:31:14.3213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fb5797-3a32-4c7f-f7d5-08dd148973ec
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 17:31:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16867

From: Chris Laplante <chris.laplante@agilent.com>

enum was introduced in Python 3.4

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/command.py             |  4 +--
 lib/bb/cooker.py              | 58 +++++++++++++++++------------------
 lib/bb/server/xmlrpcserver.py |  4 +--
 3 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index a63427660..7944faf98 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -109,7 +109,7 @@ class Command:
=20
     def runAsyncCommand(self, _, process_server, halt):
         try:
-            if self.cooker.state in (bb.cooker.state.error, bb.cooker.stat=
e.shutdown, bb.cooker.state.forceshutdown):
+            if self.cooker.state in (bb.cooker.State.ERROR, bb.cooker.Stat=
e.SHUTDOWN, bb.cooker.State.FORCE_SHUTDOWN):
                 # updateCache will trigger a shutdown of the parser
                 # and then raise BBHandledException triggering an exit
                 self.cooker.updateCache()
@@ -119,7 +119,7 @@ class Command:
                 (command, options) =3D cmd
                 commandmethod =3D getattr(CommandsAsync, command)
                 needcache =3D getattr( commandmethod, "needcache" )
-                if needcache and self.cooker.state !=3D bb.cooker.state.ru=
nning:
+                if needcache and self.cooker.state !=3D bb.cooker.State.RU=
NNING:
                     self.cooker.updateCache()
                     return True
                 else:
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ca37cfea9..ceaaac11e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -8,7 +8,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-
+import enum
 import sys, os, glob, os.path, re, time
 import itertools
 import logging
@@ -48,16 +48,15 @@ class CollectionError(bb.BBHandledException):
     Exception raised when layer configuration is incorrect
     """
=20
-class state:
-    initial, parsing, running, shutdown, forceshutdown, stopped, error =3D=
 list(range(7))
=20
-    @classmethod
-    def get_name(cls, code):
-        for name in dir(cls):
-            value =3D getattr(cls, name)
-            if type(value) =3D=3D type(cls.initial) and value =3D=3D code:
-                return name
-        raise ValueError("Invalid status code: %s" % code)
+class State(enum.Enum):
+    INITIAL =3D 0,
+    PARSING =3D 1,
+    RUNNING =3D 2,
+    SHUTDOWN =3D 3,
+    FORCE_SHUTDOWN =3D 4,
+    STOPPED =3D 5,
+    ERROR =3D 6
=20
=20
 class SkippedPackage:
@@ -180,7 +179,7 @@ class BBCooker:
             pass
=20
         self.command =3D bb.command.Command(self, self.process_server)
-        self.state =3D state.initial
+        self.state =3D State.INITIAL
=20
         self.parser =3D None
=20
@@ -226,23 +225,22 @@ class BBCooker:
             bb.warn("Cooker received SIGTERM, shutting down...")
         elif signum =3D=3D signal.SIGHUP:
             bb.warn("Cooker received SIGHUP, shutting down...")
-        self.state =3D state.forceshutdown
+        self.state =3D State.FORCE_SHUTDOWN
         bb.event._should_exit.set()
=20
     def setFeatures(self, features):
         # we only accept a new feature set if we're in state initial, so w=
e can reset without problems
-        if not self.state in [state.initial, state.shutdown, state.forcesh=
utdown, state.stopped, state.error]:
+        if not self.state in [State.INITIAL, State.SHUTDOWN, State.FORCE_S=
HUTDOWN, State.STOPPED, State.ERROR]:
             raise Exception("Illegal state for feature set change")
         original_featureset =3D list(self.featureset)
         for feature in features:
             self.featureset.setFeature(feature)
         bb.debug(1, "Features set %s (was %s)" % (original_featureset, lis=
t(self.featureset)))
-        if (original_featureset !=3D list(self.featureset)) and self.state=
 !=3D state.error and hasattr(self, "data"):
+        if (original_featureset !=3D list(self.featureset)) and self.state=
 !=3D State.ERROR and hasattr(self, "data"):
             self.reset()
=20
     def initConfigurationData(self):
-
-        self.state =3D state.initial
+        self.state =3D State.INITIAL
         self.caches_array =3D []
=20
         sys.path =3D self.orig_syspath.copy()
@@ -1398,11 +1396,11 @@ class BBCooker:
=20
             msg =3D None
             interrupted =3D 0
-            if halt or self.state =3D=3D state.forceshutdown:
+            if halt or self.state =3D=3D State.FORCE_SHUTDOWN:
                 rq.finish_runqueue(True)
                 msg =3D "Forced shutdown"
                 interrupted =3D 2
-            elif self.state =3D=3D state.shutdown:
+            elif self.state =3D=3D State.SHUTDOWN:
                 rq.finish_runqueue(False)
                 msg =3D "Stopped build"
                 interrupted =3D 1
@@ -1472,12 +1470,12 @@ class BBCooker:
         def buildTargetsIdle(server, rq, halt):
             msg =3D None
             interrupted =3D 0
-            if halt or self.state =3D=3D state.forceshutdown:
+            if halt or self.state =3D=3D State.FORCE_SHUTDOWN:
                 bb.event._should_exit.set()
                 rq.finish_runqueue(True)
                 msg =3D "Forced shutdown"
                 interrupted =3D 2
-            elif self.state =3D=3D state.shutdown:
+            elif self.state =3D=3D State.SHUTDOWN:
                 rq.finish_runqueue(False)
                 msg =3D "Stopped build"
                 interrupted =3D 1
@@ -1572,7 +1570,7 @@ class BBCooker:
=20
=20
     def updateCacheSync(self):
-        if self.state =3D=3D state.running:
+        if self.state =3D=3D State.RUNNING:
             return
=20
         if not self.baseconfig_valid:
@@ -1582,19 +1580,19 @@ class BBCooker:
=20
     # This is called for all async commands when self.state !=3D running
     def updateCache(self):
-        if self.state =3D=3D state.running:
+        if self.state =3D=3D State.RUNNING:
             return
=20
-        if self.state in (state.shutdown, state.forceshutdown, state.error=
):
+        if self.state in (State.SHUTDOWN, State.FORCE_SHUTDOWN, State.ERRO=
R):
             if hasattr(self.parser, 'shutdown'):
                 self.parser.shutdown(clean=3DFalse)
                 self.parser.final_cleanup()
             raise bb.BBHandledException()
=20
-        if self.state !=3D state.parsing:
+        if self.state !=3D State.PARSING:
             self.updateCacheSync()
=20
-        if self.state !=3D state.parsing and not self.parsecache_valid:
+        if self.state !=3D State.PARSING and not self.parsecache_valid:
             bb.server.process.serverlog("Parsing started")
             self.parsewatched =3D {}
=20
@@ -1628,7 +1626,7 @@ class BBCooker:
             self.parser =3D CookerParser(self, mcfilelist, total_masked)
             self._parsecache_set(True)
=20
-        self.state =3D state.parsing
+        self.state =3D State.PARSING
=20
         if not self.parser.parse_next():
             collectlog.debug("parsing complete")
@@ -1638,7 +1636,7 @@ class BBCooker:
             self.handlePrefProviders()
             for mc in self.multiconfigs:
                 self.recipecaches[mc].bbfile_priority =3D self.collections=
[mc].collection_priorities(self.recipecaches[mc].pkg_fn, self.parser.mcfile=
list[mc], self.data)
-            self.state =3D state.running
+            self.state =3D State.RUNNING
=20
             # Send an event listing all stamps reachable after parsing
             # which the metadata may use to clean up stale data
@@ -1711,10 +1709,10 @@ class BBCooker:
=20
     def shutdown(self, force=3DFalse):
         if force:
-            self.state =3D state.forceshutdown
+            self.state =3D State.FORCE_SHUTDOWN
             bb.event._should_exit.set()
         else:
-            self.state =3D state.shutdown
+            self.state =3D State.SHUTDOWN
=20
         if self.parser:
             self.parser.shutdown(clean=3DFalse)
@@ -1724,7 +1722,7 @@ class BBCooker:
         if hasattr(self.parser, 'shutdown'):
             self.parser.shutdown(clean=3DFalse)
             self.parser.final_cleanup()
-        self.state =3D state.initial
+        self.state =3D State.INITIAL
         bb.event._should_exit.clear()
=20
     def reset(self):
diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index fd4245a51..ebc271aca 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -103,8 +103,8 @@ class BitBakeXMLRPCServerCommands:
         s, t =3D bb.server.xmlrpcclient._create_server(host, port)
=20
         # we don't allow connections if the cooker is running
-        if (self.server.cooker.state in [bb.cooker.state.parsing, bb.cooke=
r.state.running]):
-            return None, "Cooker is busy: %s" % bb.cooker.state.get_name(s=
elf.server.cooker.state)
+        if self.server.cooker.state in [bb.cooker.State.PARSING, bb.cooker=
.State.RUNNING]:
+            return None, f"Cooker is busy: {self.server.cooker.state.name}=
"
=20
         self.event_handle =3D bb.event.register_UIHhandler(s, True)
         return self.event_handle, 'OK'
--=20
2.43.0


