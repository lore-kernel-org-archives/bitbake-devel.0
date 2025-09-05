Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B162CA1015
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.84])
 by mx.groups.io with SMTP id smtpd.web10.14988.1757053280733913428
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=1UvhUee4;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.84, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g84yOtDmtl0xpjb/CHSepV4Ws2A4Fd94dYNaw6mGazorD3vcAffkysPYLmGekGrB3M7xek8MMVemmfuCTgakbcMvWo95h6SGinzrwpdo3VJFW0kuEpcI1bocQ/6i6ec5UYmS+bgz9P1bPO2UO95h7OKErJN9mvQP+AoU1tOqS7Tu57Eke73vOPMAH3Cf/E0XLVvzi89/sxWFIbb0YKnz4kvAVHrcTkRVG7hlN1rLW0VYZykDI/GikxBdV7tcuZ91wYSIHZN19ZpV1UiQWPWeOxtzZ6kVnhNu9+rGqTRcIbzup9Z3MhVMQd/Kov8tj/on1q/xxETZFX0HtPJ52rw5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BYOfzCZEnDeicVH5gylifvft4s0qoNVgkS+Ec8hDrs=;
 b=q1DSd1vZPWrkLQaeGPPPWlyAE5ketkEkgz0EL1yW1LjHUmiPYrof13DwP//HABPUCzrGJkGY0o0T6HyG65SQOVn1wJwxKGKna8k9WP6X9D2a7w208KB0X1igReCShq5FoHlSd96TKHa8PbqdXvjCOCoKGwnmBSY4aWmQhgVZSd9TnwnN5M33MONvVFMjy25lHbGgVJH8XDIn2Z3GanFg+rD6UCL9z61F7OpJaqxr2u/vkAN89J0lB1CzXHqURWrGuUCfXGC2g/3aI9njHnTH/iOB48W/IzamxWhxNn80Qnvrsgy/Vi7FddBOtgAdYdyQODsyl/Mii4DHAJLR52EkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BYOfzCZEnDeicVH5gylifvft4s0qoNVgkS+Ec8hDrs=;
 b=1UvhUee4oBAC5XYimRROy4g6rO8nId/0DKaCTdZoz+reL3UdEYA2KWurxJHHLXgjtY6q2jyGSrM8jwgYWe3y/kbzBRcAFjiUqppzyPJkMG5MTLntHbVdbDOD/tJCmA9VmGDvcxpN+xVT814uZR16GHOqnKgBqLFHGS17b7zVe31MMnyvaq67ai9ZShlttNujVzqLgihfIK8IpIdV9jf6+kaBamS7qCpzR6HerZLgt0BBuvNKA6D3v72p4yOfO4BegTrVHB+xQR2sMKJCalVi2p0pfSy3RI4fD1qPmH3lDZj+WaiyCOid9mBrmP1WmpkjwkeuaR+5ISIfR9aiD8MzCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:16 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:16 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 15/15] fetch2: gitsm: remove indirection and nesting
Date: Fri,  5 Sep 2025 08:20:58 +0200
Message-ID: <20250905062058.2563806-16-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea73753-869f-453c-a7b3-08ddec446b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TovQo07o2MahrExpuKUWRkPIw47565b3OTo4jDOupsXmMoB5dC8TphPZ9qNL?=
 =?us-ascii?Q?wXabCS8pSNWVVgAQ/HTGUseK3jN/TxqEooDm+GStesbziVHAxRtp4v8KuCek?=
 =?us-ascii?Q?NS1TsI/ItS0ZR17/tNG2oxAkdct+9Ns4SCIPRYT0IA9D15g2wkNA/0bZVyOC?=
 =?us-ascii?Q?l+hOtZElpNl+apEHjPPZeLiFJsfJfLjSEC69x1/bAqI+OARpDYb4d8Y63DEs?=
 =?us-ascii?Q?vmMbzGvQZwQ6iTwYrQDND6FTz0prsHjxIBdldGRP880KgBuTBEOj0AJ0nBUs?=
 =?us-ascii?Q?FDKqThtuq5QPRnLQMeRh0KAmuwW7kIBKVy1cxkwBmgflYBFnyjdlQUGFxvnt?=
 =?us-ascii?Q?NNisvZCyu0EGi/BL8aZt4+WSzMiTHGn5yqBanO+VUedQXMGOQi89stu6hjvB?=
 =?us-ascii?Q?LMg0HIwR722LR96UDqTRZuqFi8hs7ztD7epHLfKsibJ3GxRIpLqQP3xOaNjR?=
 =?us-ascii?Q?+4xmPwMOvKCCzjJtFiHGyxYKb7k10dM7/+LU4yzxyhgpnmxURnRS9ahO8LQ7?=
 =?us-ascii?Q?if74bEH3YzGPXUDV+j5jSKF4OV9Zpdy9SSF7bsPlwReBTCTpJ0a94YiXHQ+N?=
 =?us-ascii?Q?HvAfJUjNsQJDpxDONPlabH5ZsDtkX8LT44reTbmGrrLFu9bHyL4FGO/WxKK/?=
 =?us-ascii?Q?eqN9Qje8UBr8D1qvDDoZZhMgW7XOZ1IfJ41sPayMJjCnswhDVjPQAI9+4LNY?=
 =?us-ascii?Q?/Ghm1VpBOFCfBjZRyhWKopiSNOTt2fDJHsUf2LFmQbpWpNBV6lQXZZ53FjFY?=
 =?us-ascii?Q?UvlpnUknYoVPqwHIBwdenQfMtoRzCVlXZsz4UZF7AOleiSuOCgfdqEMh5Z2R?=
 =?us-ascii?Q?/YBK9PBmHVTMujpFODGYLGm2Ftys6WCBTbduCIUwIR8GFN/xolqvGKrJrrOq?=
 =?us-ascii?Q?6oP0FMkLVQ44CdDEErHd8CDqd5ilhMAG6gSgkz6R5Hp6PObkS9UbotfC47kh?=
 =?us-ascii?Q?pMe90hX9qUhxYFjhjVnx7PaFsk78ocompendB0YCYAzlm3hF6dAPwOMAbSxq?=
 =?us-ascii?Q?o9eRyEa3DIgyGV1Adh+ekKbh/3ngawBQ4cjY012Hu7V+27eeHw8EB+ajLvjy?=
 =?us-ascii?Q?2q+UCL44TKVIxGIFjKVO6F7HQTNGzJQj8eJxfbDsCnHYEnPsV8vSBRHUgeXn?=
 =?us-ascii?Q?8wEJkxm5F9X2imc9sTBaL3BqCzPYTWYgBCL4qSYsSRUh4kY81oa65G8G1wHS?=
 =?us-ascii?Q?+Vo1aJba8Psi8PJt4wNySO96hxeMwkvj3rJCnPURU8qjzLN4AZad/G1uEDiQ?=
 =?us-ascii?Q?r5bgOLYI/uv/ANqiqK+4JCcSViXJuTbV9kHP5iNiTSaF8Wxf/oLUJ3/T48fS?=
 =?us-ascii?Q?Z6wzOPzSkkNCFKm/MItrqyxuHBtZa48SO049EQQt1f4xvYkAisslgU5zwrmF?=
 =?us-ascii?Q?FK2qtc0Igsw0PkxbLklbCJygQzYhp5eKm+DbyocGV2emypNBNtg39yw38N3m?=
 =?us-ascii?Q?lBU09F4awM6AK+OXujo/qyclUaFOqsC9nyW7iGgKN9/puXby2fmYhA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2d1tfC1XX7EEriN85elKWeUAy6tjc65qV95m2D09jeXSTm6wglnEV0uqYhSi?=
 =?us-ascii?Q?80XhjflYgp23Htq+OyOnJSQzCWo5saD7zbdOSpRFFwe3Pb10aDxjibXiypOS?=
 =?us-ascii?Q?tB61marAe3TpaUd42qCJWK4/OAFshc027HIWFvUPMnaXKl+QBfYvsF1QfpO1?=
 =?us-ascii?Q?xUh/0czpTWUDMrofHiQAfkyqohsyic1Ja4R4cjs1kyyscDBWGYEuWwIj+Eth?=
 =?us-ascii?Q?hBc4uWLzbibMetNGLx5eFamSPod2XX2LG3aUoVGdhG7G9LIXz0UL+mivROdL?=
 =?us-ascii?Q?ZGvuFd3GaCAJMWn1t7MR5zpA0kMddyFtXL/YImMkVjfQahTyn2LaQxNesUkT?=
 =?us-ascii?Q?4FFCkPqAzO0BCotrL09HIouVC4FEd4J+AlxLN2NvnR8Ks5oKCIRVAPB0NvE6?=
 =?us-ascii?Q?CzknVlVK6PRKrQ8mtXJwE6+r6RZkuXRgFRE3cgrAFmCfytz0GYqvZcY5hQh9?=
 =?us-ascii?Q?hQVGrsyqX2drnsiHHRTniR09S2HSCYoZttMy1lquvjQNJjHknCUUMAib7kqU?=
 =?us-ascii?Q?Inbk3LUj2LlWxICCWuJqthAJ/hS/ltTkYUTtnbZBBlk0m4EaMG5nEoEgXZ+0?=
 =?us-ascii?Q?f4Gg0ZkybWc5RPlpMFy70iWkyyZILak1OCKvH+vxWIJR59ZSXDU91f4KM6Po?=
 =?us-ascii?Q?t+SUCUgPzJq7RQ6NfhHh0QQtLiQDQxEh6iQTrhrFA37jjgzwvd6gWou2s0XA?=
 =?us-ascii?Q?+6GhEfsUG9PA1CA4K8XLMEjHv3ZO0d+oaAykpjwHdHfHT2H5l5IE1/GhtMTc?=
 =?us-ascii?Q?zJwhdLk09SMFAH2CZbJDCDoUboPO0t/GhnrPNjfaoczQgOhh4elQJBqi84ua?=
 =?us-ascii?Q?zL50gdgZI9maSD3sedA/Akg98TxWMaSG3c9fBf6GmN4/ZqfoRgQdamHyhg7E?=
 =?us-ascii?Q?K06k1GBs2J3BlzyPeeVH29hjw7ZHnT7FJpnFvaAr4r/2G6lnIcmiSIvEBOs9?=
 =?us-ascii?Q?WYSxiW+l39MapFesFf8m+PEBlZG0A2ge/zg5ICfAY/z8YBvDXjWILBCd1w5t?=
 =?us-ascii?Q?DOGIt3PnEbfmJ4F768BCAnE5fbJEMdUuBgClOEvlu3uiZv8C9YvR21ETTyPV?=
 =?us-ascii?Q?Z1TtcocqQAy358FODhU1OD2cSTBXBJz3iO5C7cq4234ljl1fB+dUqaro/gow?=
 =?us-ascii?Q?uVD8n7Fxjx0r0qetNOL+0eV5USul4k69YU9CAh9WVy2iDOk/efB9gCMlsWYi?=
 =?us-ascii?Q?YEfIy75R4RuOliVVQOgkYATYNcW19KjV/K63bPdm8y0cwn0ESWrdi/1+m7TT?=
 =?us-ascii?Q?05WC2jgFT423OQ8PZK5dRAg7SL/jBUqY8J1JeG3oIqDDnfLa6GLsSltn+iXm?=
 =?us-ascii?Q?+86BPu1c85F6XchqEeUo2hbHdkoWmc0LFlVaKjLC/9+Vvu231HkZY9Ye9lS0?=
 =?us-ascii?Q?nMsiIjps0TYlQlAmvOD8aFAZ8tqZeMZ4LT7Mox4HOI4vRa3zOGQ1XWLQ5Jed?=
 =?us-ascii?Q?4YCQ4YJz/KWbaH7ors0koIJxwxV/4zeqHF88YKtjXiANYm4nlPKbd9sU+HrB?=
 =?us-ascii?Q?B2tsgMFHHXd+k4BCZjgHjluIA5rN+zcn/C0FQ12EpTv8bkAy6ViEI1/vxcDn?=
 =?us-ascii?Q?KzNHGjaeaknXmuGmB4nkNL5cP8euXK0195Bb+AsPepV42qg/YCywGJgkaopt?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea73753-869f-453c-a7b3-08ddec446b4c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:16.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67giG2g+EKjPmvARn+6TNF45LFyBCcOPVeAXXlN5UJsbhas3Aool0V2xerxQociqk0f5cbl4sC5vKwooH3u5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17972

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use a single fetch object to reuse the fetch functionality. Remove
indirection, nesting and duplicate code.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

(no changes since v1)

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


