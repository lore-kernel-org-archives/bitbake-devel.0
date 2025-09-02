Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1236CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:55 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.127])
 by mx.groups.io with SMTP id smtpd.web10.71239.1756795548727092388
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=z23P9PTc;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8XVOtVoDOwkWs9BUj9RFp55kTw0XkzhBlB48guSMZqKNXQFexry19oGzGO+eOKKTunqb9PoR2dZzwdKryWdHV4QY2C8cTGvKvSmmzdEWC6xH3X1JqiuFGW4AVxtkPxRawTa86wVZBnqo1y1vfZaFJnlTtY4CIjgM88PWz6KtQywcfGf7Nilpr857qERGVjvaAJ8UD+n1ILNbEUkmKMekS3GnegEqJxwGyu0OvrJOr49hCfndKqaucMeBscLjhYXu1gErQ8qAbFEI9jVpjLCGHxbHy0cgPpUJQLApYenjr/lnemP+8AKyWOecBaXXtJjTwo2pkcvG9YYsX42+2OE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMfe3hS6vB70UmKAfQ6Pt6VlEXcWApsQNejx10t8Aw8=;
 b=fJiY4VjgMosdcLXn2tmZ0cUffvNoatVYTpKnYEBKsFFasR6M+pkuTdlJdNd40p/D5gHeYCu8Qfzs78OfETx+wpaiMkUNenEMAIHsxryn2g1CtHObD5XPjySk3WRPGG1KrotmDGG8haMh+tkTUcg2PYkId/hbZekweS/C1eATr+MfFeDjrHhKCmG5A/jbsv9cAlDckrlsJWhJGaQotn6LYNnor9Z/jrc36eF9k5/5aj8rfGNDoNop4aku144aDWy4m0Afa7hGBNxf1NKs3zSk2IYv6fYZt+ZrbrcaikeYfU7MOavIC4OaIjaT+yeQrJTto/7In1T4YMCedORwEdjFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMfe3hS6vB70UmKAfQ6Pt6VlEXcWApsQNejx10t8Aw8=;
 b=z23P9PTcwVp9YLlsARAdVlyY+VxeDveAjTZTmHLl9guf9AvcFiw5JroK0ir19V9Obn9Ub27B/5Fsjlp1E5lp6lTm6kTMSRsq6AUyi/EdXxpitFqVabgRPoc/vZmlToCvyIn+q8JFZu5D9+LJt4XFCun3ZaGRZGUX1zCWcyAL4yrgMd1tLI7i3kW/dr4p4Qd52pCYxTCdTQrKCHFj8FCW5fot8QgN0/giyeqy4bFfXox8YugyR7krRH5nd1vvYxyx56OJximGSqqFDSth62SLais3fIFOQVnEcvo+W5AfWkmv1GANrLk+yyaqoEHI6EwdxGOL3JQaoqNx6AvZhnOAmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:48 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:48 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 15/15] fetch2: gitsm: remove indirection and nesting
Date: Tue,  2 Sep 2025 08:45:14 +0200
Message-ID: <20250902064515.30879-16-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 574bd6ae-e029-407b-eeaa-08dde9ec56c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LROVNs1ttBtWArBHjsuIOKpgGX2vUJszE698qu3dnUW7sWn0eNWzFaX34KJj?=
 =?us-ascii?Q?f79Xbq95DllH5QnxS3A3sSgp+q84X27nJM3paJ74Qn0Vwpp+lOyXRi2bDgUo?=
 =?us-ascii?Q?L+9Qqf/jWiK1Y3YFNprKDjg68bdSbNXAxP3Jc/Fx3r12AS+k5X1yh3k4PJ2Y?=
 =?us-ascii?Q?bJzyQ6bRAkOEatY1kFr4wWYWWglkIfx2jIY+GYBxf04e4/6hPBLAWYLvn2n8?=
 =?us-ascii?Q?OZkGZaCHJ+tFYsHDnGv6UmDCaH+tDXCM6grGTk3hmKT1fnzVlolPhw51h13m?=
 =?us-ascii?Q?/lNQm81t5MM7eg/epe4E8ARU+p/jYsq1BW1nvLJDjXTqylFrwvhfWS9l0dXZ?=
 =?us-ascii?Q?JzsPKryvRmY2RvYTV6XYXXNUbGFin3h9TG98xx6PwWL1yrAbRSvbbZUrjaO9?=
 =?us-ascii?Q?qfK+3Nq0F7P3WkjNmz30ChvmiqEbR0UGwS3SmqCHfDVwtcGKSzrD6xc/e44x?=
 =?us-ascii?Q?eqz2LMmYPjlw/ItkHsNq9z4vN+7Omy/qidzwXrp+jpYp2Az0FTEH1hB8scFj?=
 =?us-ascii?Q?HGzHTQZ7A2pTdxC/rgO8idklEw5Y4ZvfZRfeQ/1V5upUGlp/nub/6uMzaqqB?=
 =?us-ascii?Q?/k0noQhgqohQ/iYYNG00ln3gLihv7dyzUVnqPiIKrkdpgpj9K3MWUx09CiwC?=
 =?us-ascii?Q?96vQ4cPN7b0QA+NoZVD017S5xS6oSP6RYxGHm5OvHIY2/hG3sGSmLAFha5fC?=
 =?us-ascii?Q?OORAQzcaG6kdrHuNMnklMGGWFh/WieKC9FnIwUzg+E2AolPI4kHtY0OtCfRq?=
 =?us-ascii?Q?bWowPARmizKTrED7mwOAzGn9oF2AlKVeBvQ4AtQvbZH0w/Dp/uADTqS9XKyr?=
 =?us-ascii?Q?YVkw9K6df8gCvXVVN1F5QG/x93PQ9f2/5E32U6kHLSUfJHJt1hA0ksJs7NTA?=
 =?us-ascii?Q?3QjyAU9UVjlXhMhCzg8/Z3d38/Osyxm8Dd02cQMfgVQuKCOpY8D11JWxOubn?=
 =?us-ascii?Q?fO44Xss7PjsrsmvKMPCGplCE6Qvs3X5bpfSF1K1sRwb7cmpcCO8XXOuwxncR?=
 =?us-ascii?Q?l6NL7UA3obAcmTMdAX1cOyY+4U+83tk1mwGTumGwjWRyZxbjzQf+Z4SKoJ4i?=
 =?us-ascii?Q?OR+m1cJ9EdR+XnPdVAoMeFKFgxDR/x7ps6StlvnuDj4Me84JK5yCXjImHi/t?=
 =?us-ascii?Q?CYgXBIEDq8ubrAh7vEBfysJndbWr/VDs34lE70KF+F1O1UVOV/ZjPTycsFUn?=
 =?us-ascii?Q?XidYtfzGXlg6dpjYpPwHcFtXKOhHXyVPuMRdP+o3fHMwcaB8kcYtLgJnOuip?=
 =?us-ascii?Q?+MfiHNFiGBFPcwAGLystberur3z7WTeoXELbTLWsl3v72WnqpS3t3dcwoO9B?=
 =?us-ascii?Q?SqilGrXxV8+b3hxxMCsH8BFH+k/ofayULrW57uxL5Lz8JiwTuBJDuOFI4LjF?=
 =?us-ascii?Q?tXMfVS3rR5io/R0u/rWSL0JWSTwJuyDozuEw8zBwD8dANjLbeq9Wwis/jUJ8?=
 =?us-ascii?Q?zY5NTfB4lpxm52/U4BSCxqa4zSmu0M/ueO6vDCtxfPBTCTaJtFV7Cw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X/YndPymLHpRgCNiDjnthAhxGvTSMKr1xtWyesRHtVrrTw/wfRt4XZuWgneH?=
 =?us-ascii?Q?bnFgx+ByFwRq5Wt2hoEsldLOQ2+HIYrJs6zNmcILMrcPjns4FPh/chij662N?=
 =?us-ascii?Q?4OaOo+ZwjJ4ZRVtNGPD3uDMID176s/zBsKNJLYaUYM0+Ijae1Z9JKc/69gq/?=
 =?us-ascii?Q?pTqfnSxmSW0hYVpEru2yNinhjhx+ZRmQdLTXMbXviVK24whwk3q05tAVx17L?=
 =?us-ascii?Q?V6w65GN8uVq0Izcc5gEsllCJN2ep0/YKJ/BSj+GFih8STpqGw3yKZyVXAe9X?=
 =?us-ascii?Q?h82lIqxXwcrWe4DAS960MP1Eo+bvOx4G52XDyBCFVZiHqUM1hEoEGtXzSxCE?=
 =?us-ascii?Q?R5uhDvovW71LeirgwVdzsUzsANOee0DYSLWw2qYek9bYyZ3z7MSmzxddklSY?=
 =?us-ascii?Q?TJ4Bk7xQHul2P5/mbFerQe4/pZef3IPDPHe+22RGwVnL1/Vt3ZfWergkemtS?=
 =?us-ascii?Q?/ZI/KRQvjt9La+7Kvw9o4+iJ1Ofi9LoxBBnCQLVqdGwd0HN2iHcXVpw9buXB?=
 =?us-ascii?Q?hMIJZiZPXj93muKlcOIDg0jVSZTYT2BOz9hMGpuH5YXqDAzkT1ZFpYt7U4wz?=
 =?us-ascii?Q?z3Gv7uhxqM5vj7JmgxKwZdZ4gFl7M9bHWEfZr2UQbegXDJB/BD+5UgPrRFJh?=
 =?us-ascii?Q?PBQrnfOipM32lnJJFySdD9PiISKrezw346SOfZerwTXhVzzEKQNYgXFy3Gv1?=
 =?us-ascii?Q?sau7+Re3wMszY825S6+acjOOO3JAZ+iZCSQy23UjKyx/semPeZVsBfBpbN1h?=
 =?us-ascii?Q?52zrwCqbqoPwkEwprcK/rhEk9PDzc9TJT0wjULhkfEKWUxh8tZw6QNuHhJgK?=
 =?us-ascii?Q?e6h7olCbpjqbsVsGr2dReOAaCNK6vhtoctzZdwFIAYa/GpCF08CXmQATB7L6?=
 =?us-ascii?Q?MCbg81Iaa3IQ88ok0/cSNImIp6EkfJfcfQQspTqpSCHOcySSpjH0Dd3LhpFl?=
 =?us-ascii?Q?XQuQC9I31bMIMFotkfnsXZXwD7QyUbCP1vhvwryU4Ar0Eiw2BBRmeLBLi8Hp?=
 =?us-ascii?Q?2WDEvOuGEHbxW//YU54iaKcnueEQPXZMOCf8zQKS06v3jOry2+R+WqAufWcY?=
 =?us-ascii?Q?SVYiDgI4xTnt2QxQOA6ofQ3NLc1JNvLNNVXN6thkFBuf5ujguzU8lNApaleA?=
 =?us-ascii?Q?dug9seJGGadRsrv+PpD9otoFsyFb3ZMb6EXkmgkZ492Cotm7P8LMffknOBmT?=
 =?us-ascii?Q?zZcTu2rcIAWCCwrxsBoU3IqTzvIvhwtkttNR2k2YvSOzotDe77mfJfKT++ig?=
 =?us-ascii?Q?tJs4oq9FGn9u9gVpd3iW3+fBQzJvjdDxnZSlDcOZd7bG4RnpYwBAAy/ELYfH?=
 =?us-ascii?Q?BoW0Oj+qTH7y6p9VuFChHZHFbmNbrm+rpZMZe5K4XAKJzey+fugtkXBVKLMi?=
 =?us-ascii?Q?jYfld3UtYeYSlYLBy1yRPrRmtiwnVsgmxLFbMWYhrjtc7I5+Uq0VEqbT+jxr?=
 =?us-ascii?Q?JApWryEsSnjyooaqwiwQnDjA0ZQKhW/3kPUZyBDS+DfBqCzWN4H8K6nWXG2I?=
 =?us-ascii?Q?4uLVKGHyCbEKSp3oK/xbo6wRVjuSoWtadRppqWZdS29/lg4Ug/pmO4gKgAa1?=
 =?us-ascii?Q?KTOSCeA7uV96ovFm6m9M1VRtM36ffn4Jgh/DrgdT5s3Ex9T/Hf7E47EoHudb?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574bd6ae-e029-407b-eeaa-08dde9ec56c0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:43.6065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9ZJvP2dDX9EhnPCi2S4TMXDgy2LL3DC1wafhuNAC7ACX4cYZIHbXRsS7d2n2SAWd3EOdsbv3FPeJIIka7eZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17934

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use a single fetch object to reuse the fetch functionality. Remove
indirection, nesting and duplicate code.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/fetch2/gitsm.py | 98 ++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 66 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 4b6c88baa..5ddc81f86 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -33,10 +33,10 @@ class GitSM(Git):
         """
         return ud.type in ['gitsm']
=20
-    def process_submodules(self, ud, workdir, function, d):
+    def process_submodules(self, ud, workdir, d):
         """
-        Iterate over all of the submodules in this repository and execute
-        the 'function' for each of them.
+        Iterate over all of the submodules in this repository and generate=
 a
+        fetch object for all of them.
         """
=20
         submodules =3D []
@@ -91,6 +91,7 @@ class GitSM(Git):
                 newud.path =3D os.path.normpath(os.path.join(newud.path, u=
ris[m]))
                 uris[m] =3D Git._get_repo_url(self, newud)
=20
+        urls =3D []
         for module in submodules:
             # Translate the module url into a SRC_URI
=20
@@ -138,21 +139,21 @@ class GitSM(Git):
             # the user (See comment in git.py).
             # So, we will not take patches adding "user=3D" support here.
=20
-            function(ud, url, module, paths[module], workdir, d)
+            urls.append(url)
=20
-        return submodules !=3D []
+        return Fetch(urls, d, cache=3DFalse) if urls else None
=20
-    def call_process_submodules(self, ud, d, subfunc):
+    def call_process_submodules(self, ud, d):
         # If we're using a shallow mirror tarball it needs to be
         # unpacked temporarily so that we can examine the .gitmodules file
         # Unpack even when ud.clonedir is not available,
         # which may occur during a fast shallow clone
         if os.path.exists(ud.clonedir):
-            self.process_submodules(ud, ud.clonedir, subfunc, d)
+            return self.process_submodules(ud, ud.clonedir, d)
         elif ud.shallow and os.path.exists(ud.fullshallow):
             with tempfile.TemporaryDirectory(dir=3Dd.getVar("DL_DIR")) as =
tmpdir:
                 runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=3Dt=
mpdir)
-                self.process_submodules(ud, tmpdir, subfunc, d)
+                return self.process_submodules(ud, tmpdir, d)
         else:
             raise bb.fetch2.FetchError("Submodule source not available.")
=20
@@ -160,51 +161,26 @@ class GitSM(Git):
         if Git.need_update(self, ud, d):
             return True
=20
-        need_update_list =3D []
-        def need_update_submodule(ud, url, module, modpath, workdir, d):
-            try:
-                newfetch =3D Fetch([url], d, cache=3DFalse)
-                new_ud =3D newfetch.ud[url]
-                if new_ud.method.need_update(new_ud, d):
-                    need_update_list.append(modpath)
-            except Exception as e:
-                logger.error('gitsm: submodule update check failed: %s %s'=
 % (type(e).__name__, str(e)))
-                need_update_result =3D True
-
-        self.call_process_submodules(ud, d, need_update_submodule)
-
-        if need_update_list:
-            logger.debug('gitsm: Submodules requiring update: %s' % (' '.j=
oin(need_update_list)))
-            return True
+        need_update =3D False
+        fetch =3D self.call_process_submodules(ud, d)
+        if fetch:
+            for url in fetch.urls:
+                urldata =3D fetch.ud[url]
+                if urldata.method.need_update(urldata, d):
+                    need_update =3D True
=20
-        return False
+        return need_update
=20
     def download(self, ud, d):
-        def download_submodule(ud, url, module, modpath, workdir, d):
-            # Is the following still needed?
-            #url +=3D ";nocheckout=3D1"
-
-            try:
-                newfetch =3D Fetch([url], d, cache=3DFalse)
-                newfetch.download()
-            except Exception as e:
-                logger.error('gitsm: submodule download failed: %s %s' % (=
type(e).__name__, str(e)))
-                raise
-
         Git.download(self, ud, d)
-        self.call_process_submodules(ud, d, download_submodule)
+
+        fetch =3D self.call_process_submodules(ud, d)
+        if fetch:
+            fetch.download()
=20
     def unpack(self, ud, destdir, d):
         fulldestdir =3D self.destdir(ud, destdir, d)
=20
-        def unpack_submodules(ud, url, module, modpath, workdir, d):
-            try:
-                newfetch =3D Fetch([url], d, cache=3DFalse)
-                newfetch.unpack(root=3Ddestdir)
-            except Exception as e:
-                logger.error('gitsm: submodule unpack failed: %s %s' % (ty=
pe(e).__name__, str(e)))
-                raise
-
         Git.unpack(self, ud, destdir, d)
=20
         parentdir =3D ud.parm.get('parentdir')
@@ -228,35 +204,25 @@ class GitSM(Git):
                 logger.error("Unable to set git config core.bare to false =
for %s" % fulldestdir)
                 raise
=20
-        ret =3D self.process_submodules(ud, fulldestdir, unpack_submodules=
, d)
+        fetch =3D self.process_submodules(ud, fulldestdir, d)
+        if fetch:
+            fetch.unpack(destdir)
=20
-        if not ud.bareclone and ret:
+        if not ud.bareclone and fetch:
             cmdprefix =3D ""
             # Avoid LFS smudging (replacing the LFS pointers with the actu=
al content) when LFS shouldn't be used but git-lfs is installed.
             if not self._need_lfs(ud):
                 cmdprefix =3D "GIT_LFS_SKIP_SMUDGE=3D1 "
             runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dfulldestdir)
     def clean(self, ud, d):
-        def clean_submodule(ud, url, module, modpath, workdir, d):
-            try:
-                newfetch =3D Fetch([url], d, cache=3DFalse)
-                newfetch.clean()
-            except Exception as e:
-                logger.warning('gitsm: submodule clean failed: %s %s' % (t=
ype(e).__name__, str(e)))
-
-        self.call_process_submodules(ud, d, clean_submodule)
-
-        # Clean top git dir
+        fetch =3D self.call_process_submodules(ud, d)
+        if fetch:
+            fetch.clean()
         Git.clean(self, ud, d)
=20
     def implicit_urldata(self, ud, d):
-        import subprocess
-
-        urldata =3D []
-        def add_submodule(ud, url, module, modpath, workdir, d):
-            newfetch =3D Fetch([url], d, cache=3DFalse)
-            urldata.extend(newfetch.expanded_urldata())
-
-        self.call_process_submodules(ud, d, add_submodule)
+        fetch =3D self.call_process_submodules(ud, d)
+        if fetch:
+            return fetch.expanded_urldata()
=20
-        return urldata
+        return []
--=20
2.39.5


