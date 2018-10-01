Return-Path: <laurent.bonnans@here.com>
X-Greylist: delayed 861 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 01 Oct 2018 15:06:55 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0097.outbound.protection.outlook.com [104.47.2.97])
	by mail.openembedded.org (Postfix) with ESMTP id 4021A745F1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmcs.onmicrosoft.com; 
	s=selector1-here-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=g2ZZH6cmMxbGGgN8ZDItzAMEM24FWzpQQpYq7jM0S3s=;
	b=UvQrvePKniCAspPMlK3EuKYxjMiOUcMVRS+JtMKlmEU+NONEqngkqIjEkzMuCRsvxiX3fsvotH5ZeHMDnJv+g/wNkzAShXzY/g862I7E25xOIRGRbkHpNeCNKumYpV8TgPvnrq3Pjc1lXtWN1EVcz1/pwDA7j5Y8VkBlxRwhf4c=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=laurent.bonnans@here.com; 
Received: from herelb.internal.advancedtelematic.com (87.191.159.149) by
	AM5PR04MB3283.eurprd04.prod.outlook.com (2603:10a6:206:d::26) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1185.22; Mon, 1 Oct 2018 14:52:45 +0000
From: Laurent Bonnans <laurent.bonnans@here.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Oct 2018 16:52:14 +0200
Message-Id: <20181001145214.19329-3-laurent.bonnans@here.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001145214.19329-1-laurent.bonnans@here.com>
References: <20181001145214.19329-1-laurent.bonnans@here.com>
MIME-Version: 1.0
X-Originating-IP: [87.191.159.149]
X-ClientProxiedBy: HE1PR09CA0080.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::24) To AM5PR04MB3283.eurprd04.prod.outlook.com
	(2603:10a6:206:d::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bc7fc91-ac75-472f-86ba-08d627ad8c25
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
	SRVR:AM5PR04MB3283; 
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	3:S1I6Unh7GEKvJadqqmAKZ6o+R83jmirdmulB0Er/VTBTjLbjXNOE2nQ/fZRuqzkHQHrCTWcgnjjBjtUoeEVb8yWKysaW8idS0SncozJoT+NyEA05j2l5kE0svwKzNhR457o3FROYhCLGH5I1KBRKUr+MMeMre/pIWcc7YD+J9KV05dWRd7Qty7tWgXIQKeYjPAFfCCaPFqVZHKH1+BgqAtRHRdwUIK8CccpuCrlDIgcWQXhG5y2Cbo++yLrun4A9;
	25:4sVraroj5y/lCaOo1zLwFBME7lMA411sWEX5C2JkMbfHxMe3JqxArzcFFyaHBRUDYOevraNoiPBYLKzOVhJDPra7+JC09xyw5kYJKhyGrPvFXEdoeRU19Vot/4BVbuwo6fU1iVIwLeIXKOwIx+VRwFClddtpt8bzer+9uBvri4TbjJXkQqQFqF72d+8u8QTxd42SnCTkXAemnnRx3ycj4J8uBSLd8MKg+rQ7leUPup0cFZ9EFYy3/XBBbngcKFbI8kp2hIdZhOyzVFIOO32MxdliTRLdsO/hqLaWuYAehHcvWWthwMjXUegaHyGEt6FLbEAeHu0Jj+wT9uXKA/kuzQ==;
	31:LgIjYal3GIMRoXRrfLCFzNLSKofDZU6IGO7SEwvO6dxhocfXIkn1FeMWy3ox+iKz3j8ZsaQrA6GBhKhA9GoKscid4FsQpbVYy/74/hI49fFrCwLzi8y17M37lsl3NavdjERJ1k+ET+rIDIRyYacNKnuK+f3UeIrHkJkMkJ46Z1AnYMT/F0/tp3szv6EaOx6E3fNwuK64uYQKO7cuQK0fswVAmgKo1q69mJp5jLAf2uw=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3283:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	20:Lgju9LAW1t8dxL8VDvUH/dSwpChKHZXy0RWXF3Jcb6q/GVDAEkugnaw9vhYyc/Z4PtGn9ae7nen2A5aWkL6ha37/FvNF4YAI58t4FTL5gzme5Qnu43R1mOMFeQbWULF2v8oJSdaIdk2iig3uBJhpPrJBXD6j3Kkmc/c1W/QT4GEe/iAWZe7DGnqwVRANM0HGR77QQv5RnEgVY6bLOnponFPtWTSs2DwZHIWaCcZE/cuSB+DgrabHbTz2M8tMvXfVppcHLzrqlAntOH0A8ssgxV/2KUnm/j6FtI1OQlkUlHh7qdd0GCzmRoQtQ2mUIIlyARbTH3hK4UoCsTIRkCTRjFZ75oxR1d06xRzTF0XQvXyuhpRImH2CXx28iYON8I8anM/QuybcILfYO9XbndnFK3D301px5GDBjaRqXW67P+Fxh5sFNXOOjFRoXbZxS3Ryk0uhMdcxtFGbjAK/S5felHwDM6JtW0s+LfLcAEto85gw59VY9qDfHaIWZta3GRHB;
	4:QRsnVgDtZUA8ZakYSMElgsLUrxTqMMg4TMtq/bHcsAC444UwTK7kHVtr8U48iOl9yLKoCdn1ZxJio33RYlVmga6G8dDfJi8XtdfmnnVxLeXKk0u+5Ks2qXYWIpz7zj+8xn4djfJ8qF9UoBwuakUvYPqpVnMKYAwrg3zr38hj3/8wORdN55p8cAE6JYQK8xSxSt8Ht789eNAohp8EK2gi6CqsfqPG9O9+qzdnMJaGOP/AtnFar0VVhlbjcR4LdX+enlPn30bxbqnespAIKkPSxOoNgOR0uChlOoLMCT2pgerHTxnlcF788YmglcuBS1RK
X-Microsoft-Antispam-PRVS: <AM5PR04MB3283CA7DC18686BEEBBDDEE285EF0@AM5PR04MB3283.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(87047540314649);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);
	SRVR:AM5PR04MB3283; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB3283; 
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(7736002)(76176011)(2870700001)(52116002)(86362001)(68736007)(2361001)(486006)(2906002)(6116002)(3846002)(6506007)(386003)(51416003)(50466002)(48376002)(446003)(105586002)(11346002)(106356001)(6512007)(2616005)(6916009)(66066001)(1076002)(956004)(47776003)(44832011)(5660300001)(476003)(2351001)(316002)(34290500001)(107886003)(53936002)(25786009)(6486002)(305945005)(186003)(26005)(97736004)(50226002)(81156014)(81166006)(16526019)(4326008)(478600001)(8936002)(8676002)(14444005)(36756003)(6666003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB3283;
	H:herelb.internal.advancedtelematic.com; FPR:; SPF:None; LANG:en;
	PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: here.com does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB3283;
	23:IVilkl+OUhSh+fIziyvrcQ2Q7FT2OeyPTOPvpQ5rD?=
	=?us-ascii?Q?Fv/Y2Qo2EYTuaVKLTNJXJMaPvUqKKQL815nBJYHPkAHzZgEXj+LVVUZboMsm?=
	=?us-ascii?Q?N6UtGbmxIMPB98hIsDK8Pbn7L86PtoBTjjXcrbTFA/8d5VVgLdqFaBghE049?=
	=?us-ascii?Q?MY8bMiUqPW43pVo9vg5SxZcPpWFRbzQ5EXPcJ4HzhgCGjCFPf3RIdj4YxztB?=
	=?us-ascii?Q?OCwwSKiBvviXM2kSBo6mNNMYg/O50gc5kD6E3tZ7rVkq5dhSxhR//VLESVJu?=
	=?us-ascii?Q?SCvrZeqA4fNgSIhDcTzCOjICyUyju1+AI3vUVzYGYvYEfn5TZ7iXIxbB07Hw?=
	=?us-ascii?Q?qHrXv3wj4qvsEMTI4zMe5GZ1lBlnSQF+bSBYmsdn31zcnOXRa7kgLkKnM+zq?=
	=?us-ascii?Q?o6Cguxak6M8KaLoaLN2PUt79wF7JFpgiQUo4q/UcE5nr+qdUfb077RKvS4m7?=
	=?us-ascii?Q?/rHSuAaxyVIOXVCuTw1NWQZ56Gsdsq26m/DjV6Zte6L77r8PKPnuxKAPC5v4?=
	=?us-ascii?Q?+56j/K0cI4h6tF8MiDxUT3RGl38tZkqkdNGIhV7ac4rieUQBl0EcavtPVESO?=
	=?us-ascii?Q?vqn2ndzOZ4IMtBaftMTn2tGhJd5pf0ExbvZ7DiQjZK2l1RvBdis3dXXwbMeI?=
	=?us-ascii?Q?mp5Bw01FuAX8XPeHlGpiG35j5kAAzQ57Ib0QoVf9WMVZKycXbsyxd/4eOwB+?=
	=?us-ascii?Q?TOzanXs0Qw3JSsStrKaUDZ2MRU3yNjMESIkzwklw8WlN/bON8xyThn5SGvo2?=
	=?us-ascii?Q?+wE8Ios3hgr0Xdehz4fQwDKOCLwblvsEJnqycNaoOiikAd6caMP6tHZsMYxA?=
	=?us-ascii?Q?kLYC5lVO5pPeg4aR4kYFcyba8px8VncdtXgHobvuZA3RnGbyByolhGdN/DP5?=
	=?us-ascii?Q?Wm6+POhTI9k8SBogXTZpqXCqdRNAMRIBjQKzWNVzy2AiKq1nU0PjtmF6WR4v?=
	=?us-ascii?Q?GGEPcwzt/VI1U9Szv1wbcjGZnvn+QqbxhPFYN9THC5v+8m53lm/oddkrTsWw?=
	=?us-ascii?Q?Nle6u46AVvnOrbScHKlQKATAjEBW27yNEs7Djj21CkeMh6P/YoWHFxW4H2ik?=
	=?us-ascii?Q?4K8ZTRIN9O1jFN89iDNQT5aLyGzUATiPyOnnZpZpeM46huENBNWdi9ey+N1v?=
	=?us-ascii?Q?aemxlmYHkY7n8vWY8g6SwTiTmSxtp9MLJ/cA78wQUTPjkJwUq/dNo12ZTgso?=
	=?us-ascii?Q?u6mKvWZzKkt+/S8n7ILRO3r6EQW0c05xnC2MVkOaFfp7P0alm8bVGM2ENmYf?=
	=?us-ascii?Q?KSESGP5rm7itIfL3m4f7oH/w2nOw6MkJXUYlhaPtxVgfhXjh6Nt65d2l+foR?=
	=?us-ascii?Q?9WkgrVpakNZl3pDpRa5P3U=3D?=
X-Microsoft-Antispam-Message-Info: 0oH9MjjAI3zlziAp6a2i+ISDIf/hd2NqpDZQKLBAFelP2m5VpTVJbMx0CL7iKnfkRDdcJ2wsQU5W+GjxPuhCzpqL8940woiPNp1hx9uWZOXZARQ+aR9jjgfuTqCCCGiWIfT35+/jsx5TyjV7NWQv0B3vTXznk1VEmADZOTkNytzYnrSZDZStkuKG3tm2m5BrqPylOxf5RnDqs1bZQ5BJKT7JFhSF8l2tigD0js9tHtGXe+pmgcF3hqth2LxkVoFrIfTe3KXDXTaIUaFp5xibpnZFTcj6TjnUFLhrlrIGFAJ3S2tW6zCGlMXzVDdsKbAC4qS1NMmEtuTmPdMLgZItIiJTsX0YdbmmvKnI26y0jlc=
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB3283;
	6:TVu7w/mUPI5pqRLiGaIRewFk3/ANsPQNjVmqCma3I0GZw5PmGsw657U0/L2RtcPDYCnPnbqkIwMaLHU8GEeFoo8P0+uJxLIQoPtwE4BZHAd+KzKxmOxCPEuuVGc3U3tqRtpirNlriok3lal4WuPOFQwueDMcBV/oXXA1Ewf63FFWhTXWidlt+2arrETvZEoczolbpyQXiarFQ6OMTHJmPREIVLTZtsieroZYxOXcaHnFvF9L6sQy17ZK46HkTmhvAopwfxTrdKxKqV3I+nIZ9G7bQAeXHp7DydC3vvdWXXQpL5NrlCHJ8qZDK9ivXrPBjOV/a0gL8KMbY39yic7xzKnywa9Czb2M6uGNcKU6HXZ2oDWm+TfodL5DLQqjweRG4ONJsDHpDzN1zdFLUUd7RixYP41BV+rDgGiFJyztuX3n21lNXTofMD8WB3zYahtkIaMNogvW0GKGIsJrW88NtA==;
	5:4MKqdz8c1NY0Eg/gATJi3xJ5JwKqGa1mYpSPSdg319BGJCVMZNtc7hp4GFNBTpa3WaujNwW44zyJYy6IUbosnAQAxr9COKu3eA+zEn8oPzwPcDjhacA0ZFYvyw18lnplpGX/0eryurDqMaEunZ0by1i0PSUbx3enj1PslGz0lbA=;
	7:s2/cxsiorUBdAJ6VuC7jy6NgePjjc07uZBzh4XnRJKO6i4gtXPaaPRSxmBGqCy2eSAyhbcF9GAL1j4Fh0rf0xbBHLZaG2qFNkwkiNWPYLKWdbr+ha3qVKjylI74lHRMJvWHzgfKOGr7QZWKAyxVDBDpiF04FLR3zIsTkyA7pXOpVKVudmrUOOQ2ABW4r1iXgNx1XDq7ZCU7BY9CVJxgijMLfyj6U6nxCPRKccJNXR2k6LsmBT6kgujZdARaBIm+o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 14:52:45.0366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc7fc91-ac75-472f-86ba-08d627ad8c25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3283
Subject: [PATCH 3/3] fetch2/gitsm: checkout submodules recursively
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 01 Oct 2018 15:06:55 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The new fetcher did not run 'git submodule update' recursively.

Signed-off-by: Laurent Bonnans <laurent.bonnans@here.com>
---
 lib/bb/fetch2/gitsm.py | 68 +++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index fd5089c0..4d3805a1 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -44,6 +44,22 @@ class GitSM(Git):
         """
         return ud.type in ['gitsm']
 
+    @staticmethod
+    def parse_gitmodules(gitmodules):
+        modules = {}
+        module = ""
+        for line in gitmodules.splitlines():
+            if line.startswith('[submodule'):
+                module = line.split('"')[1]
+                modules[module] = {}
+            elif module and line.strip().startswith('path'):
+                path = line.split('=')[1].strip()
+                modules[module]['path'] = path
+            elif module and line.strip().startswith('url'):
+                url = line.split('=')[1].strip()
+                modules[module]['url'] = url
+        return modules
+
     def update_submodules(self, ud, d):
         submodules = []
         paths = {}
@@ -57,17 +73,10 @@ class GitSM(Git):
                 # No submodules to update
                 continue
 
-            module = ""
-            for line in gitmodules.splitlines():
-                if line.startswith('[submodule'):
-                    module = line.split('"')[1]
-                    submodules.append(module)
-                elif module and line.strip().startswith('path'):
-                    path = line.split('=')[1].strip()
-                    paths[module] = path
-                elif module and line.strip().startswith('url'):
-                    url = line.split('=')[1].strip()
-                    uris[module] = url
+            for m, md in self.parse_gitmodules(gitmodules).items():
+                submodules.append(m)
+                paths[m] = md['path']
+                uris[m] = md['url']
 
         for module in submodules:
             module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=True, workdir=ud.clonedir)
@@ -173,10 +182,7 @@ class GitSM(Git):
                 # No submodules to update
                 continue
 
-            for line in gitmodules.splitlines():
-                if line.startswith('[submodule'):
-                    module = line.split('"')[1]
-                    submodules.append(module)
+            submodules = list(self.parse_gitmodules(gitmodules).keys())
 
         self.copy_submodules(submodules, ud, dest, d)
 
@@ -200,23 +206,25 @@ class GitSM(Git):
                 # No submodules to update
                 continue
 
-            module = ""
-            for line in gitmodules.splitlines():
-                if line.startswith('[submodule'):
-                    module = line.split('"')[1]
-                    submodules.append(module)
-                elif module and line.strip().startswith('path'):
-                    path = line.split('=')[1].strip()
-                    paths[module] = path
-                elif module and line.strip().startswith('url'):
-                    url = line.split('=')[1].strip()
-                    uris[module] = url
+            for m, md in self.parse_gitmodules(gitmodules).items():
+                submodules.append(m)
+                paths[m] = md['path']
+                uris[m] = md['url']
 
         self.copy_submodules(submodules, ud, ud.destdir, d)
 
-        for module in submodules:
-            srcpath = os.path.join(ud.clonedir, 'modules', module)
-            modpath = os.path.join(repo_conf, 'modules', module)
+        submodules_queue = [(module, os.path.join(repo_conf, 'modules', module)) for module in submodules]
+        while len(submodules_queue) != 0:
+            module, modpath = submodules_queue.pop()
+
+            # add submodule children recursively
+            try:
+                gitmodules = runfetchcmd("%s show HEAD:.gitmodules" % (ud.basecmd), d, quiet=True, workdir=modpath)
+                for m, md in self.parse_gitmodules(gitmodules).items():
+                    submodules_queue.append([m, os.path.join(modpath, 'modules', m)])
+            except:
+                # no children
+                pass
 
             # Determine (from the submodule) the correct url to reference
             try:
@@ -235,4 +243,4 @@ class GitSM(Git):
 
         if submodules:
             # Run submodule update, this sets up the directories -- without touching the config
-            runfetchcmd("%s submodule update --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+            runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
-- 
2.19.0


