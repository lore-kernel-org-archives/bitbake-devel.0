Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 895127F2B8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Aug 2019 20:37:19 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x71Kb0qq010798
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Aug 2019 13:37:10 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.468.0;
	Thu, 1 Aug 2019 13:36:54 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Aug 2019 16:36:54 -0400
Message-ID: <20190801203654.140427-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH] layerindexlib: Fix parsing of recursive layer dependencies
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
X-List-Received-Date: Thu, 01 Aug 2019 20:37:19 -0000
Content-Type: text/plain

[YOCTO #13447]

When running bitbake-layers layerindex-fetch from 'master', there is a
circular dependency between meta-oe and meta-python.  This triggered a maximum
recursion depth exception.

To fix the exception, as we walk down a branch (depth first search), we track
the layers we've already seen.  If we are about to recurse into a layer we've
already seen we report a warning and then stop recursion.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/layerindexlib/__init__.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index d231cf6a..77196b40 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -376,7 +376,7 @@ layerBranches set.  If not, they are effectively blank.'''
                 invalid.append(name)
 
 
-        def _resolve_dependencies(layerbranches, ignores, dependencies, invalid):
+        def _resolve_dependencies(layerbranches, ignores, dependencies, invalid, processed=None):
             for layerbranch in layerbranches:
                 if ignores and layerbranch.layer.name in ignores:
                     continue
@@ -388,6 +388,13 @@ layerBranches set.  If not, they are effectively blank.'''
                     if ignores and deplayerbranch.layer.name in ignores:
                         continue
 
+                    # Since this is depth first, we need to know what we're currently processing
+                    # in order to avoid infinite recursion on a loop.
+                    if processed and deplayerbranch.layer.name in processed:
+                        # We have found a recursion...
+                        logger.warning('Circular layer dependency found: %s -> %s' % (processed, deplayerbranch.layer.name))
+                        continue
+
                     # This little block is why we can't re-use the LayerIndexObj version,
                     # we must be able to satisfy each dependencies across layer indexes and
                     # use the layer index order for priority.  (r stands for replacement below)
@@ -411,7 +418,17 @@ layerBranches set.  If not, they are effectively blank.'''
 
                     # New dependency, we need to resolve it now... depth-first
                     if deplayerbranch.layer.name not in dependencies:
-                        (dependencies, invalid) = _resolve_dependencies([deplayerbranch], ignores, dependencies, invalid)
+                        # Avoid recursion on this branch.
+                        # We copy so we don't end up polluting the depth-first branch with other
+                        # branches.  Duplication between individual branches IS expected and
+                        # handled by 'dependencies' processing.
+                        if not processed:
+                            local_processed = []
+                        else:
+                            local_processed = processed.copy()
+                        local_processed.append(deplayerbranch.layer.name)
+
+                        (dependencies, invalid) = _resolve_dependencies([deplayerbranch], ignores, dependencies, invalid, local_processed)
 
                     if deplayerbranch.layer.name not in dependencies:
                         dependencies[deplayerbranch.layer.name] = [deplayerbranch, layerdependency]
-- 
2.16.0.rc2


