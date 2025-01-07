Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68133E77199
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 21:56:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.45])
 by mx.groups.io with SMTP id smtpd.web11.4664.1736286999935278667
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 13:56:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=LLAf3zq8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.212.45, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXvL5z5LGsqIv7fGmjfNcAjbtjaCc/ACfDpB7sYWTyeBvTZWaekMCD2WD73bNIeR6n/eMuMMPfbsX45vtowlP8un14SJtrhfIKRg8V6yNemnkpGcaD7DTnM55c6sDd72oPx+lKZvxYVfor3WxiwCK1io0yJtGQYM/hNvjRSwF3kr7wPTJ/IzaNIQmwhjWlak1uGw8cP4wrrq9hW1c8FHKxshyPuaSB81IPuY2eMvD8xAeWDpAtDJ/FvMNfgsVHE1bUGiTu9nNsnWDaO/dYLaG20jWawxLj+xOdi34i5aL7fUIYJvfo99TMs+pnFJE105G+sMAJvTv2wEoyKj63mR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDR0Y22Z5ZCIX9e1lmfzR7rbhGygFhHav9G7ca/BoIc=;
 b=g1od7H6DrIwCZmFRaDMUHN2ffm2dVmbTq+JW3+n4xgBF4x497SHHi7wnhtF14HsBg7lyJyITWfNxDD2uk9JsV2oWCCJ0lGpj8iwk/6xOr2z3kF6WvoNmzAi+TwjFJ+gUAIzAdxLs+qRKsKLfRWRtOjgVOdG1M+ekyLDmlMVzXd76HleIQJe7xNatbqaKizeoJDPt+b/Md4nAD8UGj9m0C7oCwtLax93rOc17SkLb7dRy1eDQYijYoH+dqEyy+8keEI7hp7mkq1p1peFysJ60Qw53QxCcZ4A6cdI2bNTuLrcKx9lofIYPdD4ce/UTr/At4qxABQnov/leh8tcFaKLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDR0Y22Z5ZCIX9e1lmfzR7rbhGygFhHav9G7ca/BoIc=;
 b=LLAf3zq8u+6zakOZdhSZUS0WHR0UVnFTrmADqa8aYc24XPHbq8wIrWKpSmHakdMYA/kN+k2v0x+wqYfB3PYcNMwOVP4pPCDhEADVPcjBVQT9owLe/THfRFDOVOzwAS4QSrZ/AgwyjgFtlXVdrU43JDaQIBFjjHnDLs0K+UtPjhOQ7+Cw6MEevjj+zfuuveJmlJiuiPvXVXCL0plCjTrPtENa+2EC8hrwt2DtjZTtwMM33IRfd9YNSqYRhOi3vIcrEMWRx12lvcrP8YNAxlNAHpKnX4Nm73orKwabx0ZULUer4NfYG3yBfzpC4uIAL0XCX74tuyef6ujL4xkMAjzitQ==
Received: from SJ0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:a03:3a0::20)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 21:56:35 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::18) by SJ0PR03CA0255.outlook.office365.com
 (2603:10b6:a03:3a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 21:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 21:56:35 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 Jan 2025 14:56:30 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Chris Laplante <chris.laplante@agilent.com>, Richard
 Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][2.8][PATCH 3/3] cooker: Make cooker 'skiplist' per-multiconfig/mc
Date: Tue, 7 Jan 2025 16:54:03 -0500
Message-ID: <20250107215403.251838-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107215403.251838-1-chris.laplante@agilent.com>
References: <20250107215403.251838-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 157cb87c-2c50-414c-8a00-08dd2f66277d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UBox++GxCnyaBf69jOBIaD6TF+w4jREQMT33V7wacdmc3/bAnh2F3Yu10dBF?=
 =?us-ascii?Q?HLNtsoXm7sM8CWgkf5i8eRVOtPEuUmcvTXdrTE8nYTpq2iFQXbAQ1Q554oXa?=
 =?us-ascii?Q?ozkBkjeFkZTDEoICDpQLVfZps21w5zX/W2XycUuZLgcQOKCsN4T1ibITHsIC?=
 =?us-ascii?Q?J7MdNI9E1nNkJ2NWnaJwU/RNsG5Cb28hC8rDWg5CcOrO3Lqh8qYuri8Dr7jh?=
 =?us-ascii?Q?pKPAG98tsfBQTSXnwpaFJg+0FCcg1lgZ/04Y6rmaM/KpJjKKctgXwpsVYOQp?=
 =?us-ascii?Q?11fSGoGAnrQWcxgXp8qPtLVe8WmI4nnJQbYO21s7/AZytzztFCft5ywYlg87?=
 =?us-ascii?Q?yKh/j72RdlSVQoWivOiSN9NxSgDPPdJWLdh1KLsDEVGbY6T2G+58sNVsKTji?=
 =?us-ascii?Q?9Ggth5Jv/5D1NVSwUI+N7GDpdfklLxN7WCRUMvgCkm108aYM/lJCS348ytRF?=
 =?us-ascii?Q?G6YvtdquQbT2fxE6F/F33Le6lfIIEyLbwhD+LN79mzBUnRJFt6Uub/4wyBUt?=
 =?us-ascii?Q?ROaR4eWZy3i9gYaYCN2X5EHmOFDsYq7ncAaf6tgQk9bnYoCo/WLLzGyka/gx?=
 =?us-ascii?Q?HZ+aoWRFn3wZUrYw62yphLLMUUEMaRr/U8SJKACiUKLIFV0T7Hz85Cn3fbSw?=
 =?us-ascii?Q?09h5lJldO/1WcEepmrZoxK9H3/MqXB5heZq0apyFC9Ya0XvImW8p/Xk73UBH?=
 =?us-ascii?Q?KKmVUdM+fkZyQqloI1967iwva+8SIflSZGrqwXdgy9h/FxM9vK8kzbodFhq3?=
 =?us-ascii?Q?ANYvUkcl0+u/R4O81PFvZNig3zbjJqy9QtYWK/Th1b65XDHREeY08lOI92C6?=
 =?us-ascii?Q?25PO3KLFDPCFIcVOJeJKUhMD4L9p5ZyIMdKKdCmyAw8ohC8KZ1iIsMEIZ7cb?=
 =?us-ascii?Q?k3j/kRFW645gs27SPk7SBRJKIbzGKeBeJPPKB328uVJu/Uhf13ZDEDg0l+a6?=
 =?us-ascii?Q?Egh9q5nfg52tNhsunlhNFqmeo6BUmbrXzOeat6IA1h6Rqcvdcd4EFzKuBBNS?=
 =?us-ascii?Q?hutCDx0J7mpUWdhuWmFxWRRU/ZHEkIbL53S8BhsODyaEkuUSE0mX+H6uveZ7?=
 =?us-ascii?Q?laUoxhU6T+9q3xHsLbdJxboH2uJzpho3ALE0iHnDRVhOhHOkaNmFTdrLKWwV?=
 =?us-ascii?Q?jMHiJu0hrICVEjQlUwJx3bbnhYfeAghIAb7K8ECnPJVd6Bhn5r267NAuNjAs?=
 =?us-ascii?Q?8/G4GtP/9S2kWbNX0SQf5Qz3eaiv30/7KEG1SGdmXgPJ1R3ebv+wP5fvleBr?=
 =?us-ascii?Q?h6iUFbC957G+bTvoFqDBxZJvrSpvf03TnGMBbRItOYncuNZcvoR8OoWQcumY?=
 =?us-ascii?Q?w9tHr6qFrlQf2d/bZ+291c2YY1yrowGYOC8kZQwi0J9mmpWcCZpTK4/GncKH?=
 =?us-ascii?Q?l2/dsGMhbTn/ba1G0loxwHtF4mapW3+ZldX08TSUDg9IPTIGrQ+LAI3Y45ww?=
 =?us-ascii?Q?d61vcxyoeY+MpKKGNmVyP+RNOwE3AOBvLauBfc9DZMPAqt7SWXj41eqZKGDR?=
 =?us-ascii?Q?gTTnWyPe3ud7GTo=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 21:56:35.0468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 157cb87c-2c50-414c-8a00-08dd2f66277d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 21:56:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16986

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py     | 21 ++++++++++++++++++---
 lib/bb/cooker.py      | 11 ++++++-----
 lib/bb/tinfoil.py     | 16 ++++++++++++----
 lib/bblayers/query.py | 14 +++++++-------
 4 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1fcb9bf14..5e166fe45 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -420,15 +420,30 @@ class CommandsSync:
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
index 1cb3e189f..6fce19b46 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -134,7 +134,8 @@ class BBCooker:
         self.baseconfig_valid =3D False
         self.parsecache_valid =3D False
         self.eventlog =3D None
-        self.skiplist =3D {}
+        # The skiplists, one per multiconfig
+        self.skiplist_by_mc =3D defaultdict(dict)
         self.featureset =3D CookerFeatures()
         if featureSet:
             for f in featureSet:
@@ -612,8 +613,8 @@ class BBCooker:
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
@@ -933,7 +934,7 @@ class BBCooker:
         for mc in self.multiconfigs:
             # First get list of recipes, including skipped
             recipefns =3D list(self.recipecaches[mc].pkg_fn.keys())
-            recipefns.extend(self.skiplist.keys())
+            recipefns.extend(self.skiplist_by_mc[mc].keys())
=20
             # Work out list of bbappends that have been applied
             applied_appends =3D []
@@ -2358,7 +2359,7 @@ class CookerParser(object):
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
index dcd3910cc..4dc4590c3 100644
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
index bfc18a759..eb7cb465b 100644
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


