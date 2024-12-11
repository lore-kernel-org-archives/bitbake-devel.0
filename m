Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C77E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 17:41:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.68])
 by mx.groups.io with SMTP id smtpd.web10.810.1733938902166612255
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Dec 2024 09:41:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=tS4tBLns;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.68, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKa1m4HRZXciQaSavo7+S4sMjB3B5OoUXzYkfafpj7HFWsO147KNvcVgfC5z9mjw5fcEQSu3JZGJ7hMdQKSifUMWE+qV+07MoLxCIjErRiWLo2CuLP03WYX6v8MNle0t1UxotabWN/LUDSj0SXMKvA/y+3zX6cIvmOMvgd9xD6tgFugGjfd2cWIa+WKJNJxqvXZLW+YvYCIqk5pEmivIAGqqfJ2CPrcYevQPEYDqkQtYf7eoH+PHxGXOUGCCUaoYOszp96ZnNVZYvqBIGtV4911ohBNruUdi1TaoJDtrVmdiWrBh2M66e0sbbEBaH4V+irlD12NdHtfXKs4LF8nSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtLcYY7FQ2+svxc21upBP3qDHO6vg0zmnFzIibKU5N4=;
 b=YxJBXrfn3XJAQTQt4KoQS63Jhg3gVHVwkfmRTHcX65ZOKE9V9YmvmUvr4YVYbFgp+Jhv6+MNkG+BHi5MzWXjQ+XqKGFOWjkGTwiKXbfB/VLCYaVlNB9jbSvBojmEwOPChWppmvW/UArdPqBf7E1Zp5usYGtLC8cZvZZsSpMaZBaAUDJJkI61GbYFfZrDq80NBsvSsTBdhzZ5H7KoYMr3qjpE8at8MbvL/dwPJd96SM2olP6ysiOgKPPHj7aeIHoq6cFIbJ6dYTZyjYHczdDMIrpEE9ovhSs3u2pWftjL1xLx8eeFbxx0VgqwjM6H/fi4/V29GoSoOpvUWWZF/lMb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtLcYY7FQ2+svxc21upBP3qDHO6vg0zmnFzIibKU5N4=;
 b=tS4tBLns/9uzRbbVjdFbQM58CqXJ1uEfoFamuxTJ9RqdDyj5xLIPf+uXqyXAy0pxaHB3DhB0OupR/3Jpk82H/7J23EYrSpApuQ3sVnlh7OZSgYzMUnChAEx0LW50j2yzuKbpWosZ1BLJ3XGdeG6jC5c6LUro6U8oSZA89L4zfMKa558ylRb5Q5yYyqWalyI/9Vp2Ic8Oj+fBwNqgAjlhQb50AMf9uXjHhLVlcvXIL7nLg1Iq4Kux1W8iX0qPyKqKUHFDGRnfNJOOpS4uqb8qESDbZ2HEOgY0zlelts1BrcyMhL2hKQdQ4UDF/Hbl66ThiEWLSuhz89Rqsr9t8Nl3hw==
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 17:41:35 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::19) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend Transport; Wed,
 11 Dec 2024 17:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 17:41:35 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 10:41:17 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] Make cooker 'skiplist' per-multiconfig/mc
Date: Wed, 11 Dec 2024 12:41:27 -0500
Message-ID: <20241211174127.609537-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 1852cbef-ac30-45a2-05b3-08dd1a0b0ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5Tlk+MhmcIHYhXYoMQ6g/GvDXcy3Ay9xtQ2vuPpjnhBbm5kfZPjt6xZjfkdQ?=
 =?us-ascii?Q?GzV8xHRKvZf6+thCDR5GLE1+DlBz+i4KspI+169O7FgDVOiRu46yt2fqpN5M?=
 =?us-ascii?Q?P9mi6eNrjikDcb4o/GNsjEYLTdBjS+UlxUK+5cJLpHCl7o9IKAyCXic59jNk?=
 =?us-ascii?Q?6utYqJZPdfaYPraZo3IyE+yH6tk4L/ZJU4DCTudqbg852mszw4POHy1r/ok4?=
 =?us-ascii?Q?+Edg9yREQYOBpdmfiIM+orXXvR7oZLKJAmGkAIXtpX4lsZT0uBraCZsA6DlY?=
 =?us-ascii?Q?4hKWPrBtjmux4UG/Kk1yrkvwlFhSW0ZNRsORD5WlG7q9DYwhaTQuKqoxw5KF?=
 =?us-ascii?Q?kFf6O1cnn+GY6hS4kQEEvEXgFVGz4mM0qCpSQQykIxglNYdvZQr/1CAO0TXH?=
 =?us-ascii?Q?PVJMNH51z0zzYv06FOhp4vuqcaOEajTuVOjQbYkTRE7fUWgj5dwhfEGug4uz?=
 =?us-ascii?Q?5KBk0JTNi0aSVahldlO+TlhG/zzAILH4XHnVUGt7R8WLtFJumgRxZxNQfpxF?=
 =?us-ascii?Q?EfL6bZqH04ZCwhswFLBvydnitaGkuj8/M2rIwcFyqkkowJMClToXUm+iaqOK?=
 =?us-ascii?Q?ksBpzFiN8l/+6xAkYU9FcTdX5WTzK6kfwqUpdrFTCCIJmkvxXNbnmINN4GYU?=
 =?us-ascii?Q?0X0ZksIYi1HW7FAy3Q7yEXkIxpiY7J6S11A3SBHF//GOjvl0k8Cq2fQBGla3?=
 =?us-ascii?Q?WgxvMyRK/k2Okbz1/JJ4PlE3NlRoc+V8/1+ym6/TXo5gN0pFWiajjJceDdLs?=
 =?us-ascii?Q?7e0UV7Uyo7yba5/W78cSRdTYz/HPeh+znJBu6WQ8sffu8vRD0X6n61MI4rw/?=
 =?us-ascii?Q?XyOXfvBVcaX0clSbzn8bl9GfDhmL0dIkqY6D4fKMQh4jWXh/XIR+bCK85iGE?=
 =?us-ascii?Q?W6cqN2IFE52MEvbXZpZpjgDLOe6A/t4QGTdvdgrFfASTTBLA5SpQJOKiOubM?=
 =?us-ascii?Q?LMHBRfuarkKPMjjUc46Ec28Yl4SG7jFtmlOBmPYH8x4j7FzKkFUuAz7A7SL6?=
 =?us-ascii?Q?uTgwVggiWo/yfh0pWFH9rM2U1dnS5sEG1uLFgk7+lyx/N2VadVhFsxTtx9W7?=
 =?us-ascii?Q?4v8AJCOw1tTZ7tuwxkKJh04usT83cavYowGW3whORQ7zrRXOSSFJA2hc5SC8?=
 =?us-ascii?Q?1vTYF0FLI/Nci4ztu/IGdDxuuRfyTRXMcRbM1fUL2SVSnHFOmco4KIfSTOgc?=
 =?us-ascii?Q?LYEMlf1LYn+bowwO/q6Zr16XL8yy6HMoVth53GhxHuqSALCp1wNkj212ixrZ?=
 =?us-ascii?Q?6aL45qWRIteFPZRfc2fthJUyOKnsI2G/p2jsf7x6vpMTIo4ZyZt3u8+U8TBG?=
 =?us-ascii?Q?FdVIxO7EFwhE99HCbmWKDBEjyzfVa8D7X3ZqtUMvMrdLZwOrgyaU+xgIEaxz?=
 =?us-ascii?Q?S1KJ87eQ2Wq4AdR3Y9uIKpl8kfYmBWrDOI9yM8c3+8NfF7ERDUUAle5RNxYM?=
 =?us-ascii?Q?mZYdTRmLMdKrQMrx3VhBDG0FoiQXCWyv?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:41:35.0926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1852cbef-ac30-45a2-05b3-08dd1a0b0ed1
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 17:41:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16910

From: Chris Laplante <chris.laplante@agilent.com>

Previously, the cooker skiplist was shared across multiconfigs
(including default ''). If you had a recipe that was incompatible with
several multiconfigs for different reasons, then the displayed reason
(i.e. the "ERROR: Nothing PROVIDES" and "* was skipped" messages) might
vary across invocations of bitbake. This was caused by the random order
in which recipes are parsed under different multiconfig contexts, with
each skip reason overwriting the previously assigned reason.

I hit this specificially when using COMPATIBLE_MACHINE, but
COMPATIBLE_HOST (or anything using bb.parse.SkipRecipe) would have done it =
too.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/command.py     | 21 ++++++++++++++++++---
 lib/bb/cooker.py      | 11 ++++++-----
 lib/bb/tinfoil.py     | 16 ++++++++++++----
 lib/bblayers/query.py | 14 +++++++-------
 4 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 7944faf981..baa7cbade1 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -421,15 +421,30 @@ class CommandsSync:
         return command.cooker.recipecaches[mc].pkg_dp
     getDefaultPreference.readonly =3D True
=20
+
     def getSkippedRecipes(self, command, params):
+        """
+        Get the map of skipped recipes for the specified multiconfig/mc na=
me (`params[0]`).
+
+        Invoked by `bb.tinfoil.Tinfoil.get_skipped_recipes`
+
+        :param command: Internally used parameter.
+        :param params: Parameter array. params[0] is multiconfig/mc name. =
If not given, then default mc '' is assumed.
+        :return: Dict whose keys are virtualfns and values are `bb.cooker.=
SkippedPackage`
+        """
+        try:
+            mc =3D params[0]
+        except IndexError:
+            mc =3D ''
+
         # Return list sorted by reverse priority order
         import bb.cache
         def sortkey(x):
             vfn, _ =3D x
-            realfn, _, mc =3D bb.cache.virtualfn2realfn(vfn)
-            return (-command.cooker.collections[mc].calc_bbfile_priority(r=
ealfn)[0], vfn)
+            realfn, _, item_mc =3D bb.cache.virtualfn2realfn(vfn)
+            return -command.cooker.collections[item_mc].calc_bbfile_priori=
ty(realfn)[0], vfn
=20
-        skipdict =3D OrderedDict(sorted(command.cooker.skiplist.items(), k=
ey=3Dsortkey))
+        skipdict =3D OrderedDict(sorted(command.cooker.skiplist_by_mc[mc].=
items(), key=3Dsortkey))
         return list(skipdict.items())
     getSkippedRecipes.readonly =3D True
=20
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ceaaac11ee..5b885cddd7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -133,7 +133,8 @@ class BBCooker:
         self.baseconfig_valid =3D False
         self.parsecache_valid =3D False
         self.eventlog =3D None
-        self.skiplist =3D {}
+        # The skiplists, one per multiconfig
+        self.skiplist_by_mc =3D defaultdict(dict)
         self.featureset =3D CookerFeatures()
         if featureSet:
             for f in featureSet:
@@ -614,8 +615,8 @@ class BBCooker:
         localdata =3D {}
=20
         for mc in self.multiconfigs:
-            taskdata[mc] =3D bb.taskdata.TaskData(halt, skiplist=3Dself.sk=
iplist, allowincomplete=3Dallowincomplete)
-            localdata[mc] =3D data.createCopy(self.databuilder.mcdata[mc])
+            taskdata[mc] =3D bb.taskdata.TaskData(halt, skiplist=3Dself.sk=
iplist_by_mc[mc], allowincomplete=3Dallowincomplete)
+            localdata[mc] =3D bb.data.createCopy(self.databuilder.mcdata[m=
c])
             bb.data.expandKeys(localdata[mc])
=20
         current =3D 0
@@ -936,7 +937,7 @@ class BBCooker:
         for mc in self.multiconfigs:
             # First get list of recipes, including skipped
             recipefns =3D list(self.recipecaches[mc].pkg_fn.keys())
-            recipefns.extend(self.skiplist.keys())
+            recipefns.extend(self.skiplist_by_mc[mc].keys())
=20
             # Work out list of bbappends that have been applied
             applied_appends =3D []
@@ -2355,7 +2356,7 @@ class CookerParser(object):
         for virtualfn, info_array in result:
             if info_array[0].skipped:
                 self.skipped +=3D 1
-                self.cooker.skiplist[virtualfn] =3D SkippedPackage(info_ar=
ray[0])
+                self.cooker.skiplist_by_mc[mc][virtualfn] =3D SkippedPacka=
ge(info_array[0])
             self.bb_caches[mc].add_info(virtualfn, info_array, self.cooker=
.recipecaches[mc],
                                         parsed=3Dparsed, watcher =3D self.=
cooker.add_filewatch)
         return True
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 0e937fba36..13b05cec2d 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -188,11 +188,19 @@ class TinfoilCookerAdapter:
             self._cache[name] =3D attrvalue
             return attrvalue
=20
+    class TinfoilSkiplistByMcAdapter:
+        def __init__(self, tinfoil):
+            self.tinfoil =3D tinfoil
+
+        def __getitem__(self, mc):
+            return self.tinfoil.get_skipped_recipes(mc)
+
     def __init__(self, tinfoil):
         self.tinfoil =3D tinfoil
         self.multiconfigs =3D [''] + (tinfoil.config_data.getVar('BBMULTIC=
ONFIG') or '').split()
         self.collections =3D {}
         self.recipecaches =3D {}
+        self.skiplist_by_mc =3D self.TinfoilSkiplistByMcAdapter(tinfoil)
         for mc in self.multiconfigs:
             self.collections[mc] =3D self.TinfoilCookerCollectionAdapter(t=
infoil, mc)
             self.recipecaches[mc] =3D self.TinfoilRecipeCacheAdapter(tinfo=
il, mc)
@@ -201,8 +209,6 @@ class TinfoilCookerAdapter:
         # Grab these only when they are requested since they aren't always=
 used
         if name in self._cache:
             return self._cache[name]
-        elif name =3D=3D 'skiplist':
-            attrvalue =3D self.tinfoil.get_skipped_recipes()
         elif name =3D=3D 'bbfile_config_priorities':
             ret =3D self.tinfoil.run_command('getLayerPriorities')
             bbfile_config_priorities =3D []
@@ -514,12 +520,12 @@ class Tinfoil:
         """
         return defaultdict(list, self.run_command('getOverlayedRecipes', m=
c))
=20
-    def get_skipped_recipes(self):
+    def get_skipped_recipes(self, mc=3D''):
         """
         Find recipes which were skipped (i.e. SkipRecipe was raised
         during parsing).
         """
-        return OrderedDict(self.run_command('getSkippedRecipes'))
+        return OrderedDict(self.run_command('getSkippedRecipes', mc))
=20
     def get_all_providers(self, mc=3D''):
         return defaultdict(list, self.run_command('allProviders', mc))
@@ -533,6 +539,7 @@ class Tinfoil:
     def get_runtime_providers(self, rdep):
         return self.run_command('getRuntimeProviders', rdep)
=20
+    # TODO: teach this method about mc
     def get_recipe_file(self, pn):
         """
         Get the file name for the specified recipe/target. Raises
@@ -541,6 +548,7 @@ class Tinfoil:
         """
         best =3D self.find_best_provider(pn)
         if not best or (len(best) > 3 and not best[3]):
+            # TODO: pass down mc
             skiplist =3D self.get_skipped_recipes()
             taskdata =3D bb.taskdata.TaskData(None, skiplist=3Dskiplist)
             skipreasons =3D taskdata.get_reasons(pn)
diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index bfc18a7593..eb7cb465b4 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -142,10 +142,10 @@ skipped recipes will also be listed, with a " (skippe=
d)" suffix.
         # Ensure we list skipped recipes
         # We are largely guessing about PN, PV and the preferred version h=
ere,
         # but we have no choice since skipped recipes are not fully parsed
-        skiplist =3D list(self.tinfoil.cooker.skiplist.keys())
-        mcspec =3D 'mc:%s:' % mc
+        skiplist =3D list(self.tinfoil.cooker.skiplist_by_mc[mc].keys())
+
         if mc:
-            skiplist =3D [s[len(mcspec):] for s in skiplist if s.startswit=
h(mcspec)]
+            skiplist =3D [s.removeprefix(f'mc:{mc}:') for s in skiplist]
=20
         for fn in skiplist:
             recipe_parts =3D os.path.splitext(os.path.basename(fn))[0].spl=
it('_')
@@ -162,7 +162,7 @@ skipped recipes will also be listed, with a " (skipped)=
" suffix.
         def print_item(f, pn, ver, layer, ispref):
             if not selected_layer or layer =3D=3D selected_layer:
                 if not bare and f in skiplist:
-                    skipped =3D ' (skipped: %s)' % self.tinfoil.cooker.ski=
plist[f].skipreason
+                    skipped =3D ' (skipped: %s)' % self.tinfoil.cooker.ski=
plist_by_mc[mc][f].skipreason
                 else:
                     skipped =3D ''
                 if show_filenames:
@@ -301,7 +301,7 @@ Lists recipes with the bbappends that apply to them as =
subitems.
             if self.show_appends_for_pn(pn, cooker_data, args.mc):
                 appends =3D True
=20
-        if not args.pnspec and self.show_appends_for_skipped():
+        if not args.pnspec and self.show_appends_for_skipped(args.mc):
             appends =3D True
=20
         if not appends:
@@ -317,9 +317,9 @@ Lists recipes with the bbappends that apply to them as =
subitems.
=20
         return self.show_appends_output(filenames, best_filename)
=20
-    def show_appends_for_skipped(self):
+    def show_appends_for_skipped(self, mc):
         filenames =3D [os.path.basename(f)
-                    for f in self.tinfoil.cooker.skiplist.keys()]
+                    for f in self.tinfoil.cooker.skiplist_by_mc[mc].keys()=
]
         return self.show_appends_output(filenames, None, " (skipped)")
=20
     def show_appends_output(self, filenames, best_filename, name_suffix =
=3D ''):
--=20
2.43.0


