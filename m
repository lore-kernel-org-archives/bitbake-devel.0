Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id E77E67FDB8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 17:39:13 +0000 (UTC)
Received: from lons-builder.int.hatle.net ([192.40.192.88])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xBJHd9Y9018187;
	Thu, 19 Dec 2019 11:39:09 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: jdmason@kudzu.us, bitbake-devel@lists.openembedded.org
Date: Thu, 19 Dec 2019 11:39:08 -0600
Message-Id: <20191219173908.46461-1-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH v2] bitbake: layerindex: use branch when specified
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
X-List-Received-Date: Thu, 19 Dec 2019 17:39:14 -0000

From: Jon Mason <jdmason@kudzu.us>

When currently specified, the branch is used to verify the versioning of
the meta layer, but the master branch is checked out.  This change
allows for the branch to be specified.  Now it is easy to specify all
of the meta layers being added are of the same version, without having
to do it in each individual git tree.  Also, it will error if there are
branches without a matching version.  Finally, this allows for meta
layer git trees without a master branch.

Signed-off-by: Jon Mason <jdmason@kudzu.us>

Minor rework of the patch to use the layerBranch actual_branch since
the layerindex referenced branch may be different then the overall
release branch.

Also adjust the patch to use the default git checkout branch instead of
master if no branch was specified.  (Some repositories don't have a
master branch.)

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 lib/bblayers/layerindex.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 57cd9027..aa3b682d 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -24,7 +24,7 @@ class LayerIndexPlugin(ActionPlugin):
     This class inherits ActionPlugin to get do_add_layer.
     """
 
-    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
+    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch):
         layername = self.get_layer_name(url)
         if os.path.splitext(layername)[1] == '.git':
             layername = os.path.splitext(layername)[0]
@@ -32,9 +32,13 @@ class LayerIndexPlugin(ActionPlugin):
         layerdir = os.path.join(repodir, subdir)
         if not os.path.exists(repodir):
             if fetch_layer:
-                result = subprocess.call(['git', 'clone', url, repodir])
+                cmd = ['git', 'clone', '-b' , branch, url, repodir]
+                if not branch:
+                    # Branch really shouldn't be empty, but use the repo default if it is
+                    cmd = ['git', 'clone', url, repodir]
+                result = subprocess.call(cmd)
                 if result:
-                    logger.error("Failed to download %s" % url)
+                    logger.error("Failed to download %s (%s)" % (url, branch))
                     return None, None, None
                 else:
                     return subdir, layername, layerdir
@@ -171,7 +175,8 @@ class LayerIndexPlugin(ActionPlugin):
                 subdir, name, layerdir = self.get_fetch_layer(fetchdir,
                                                       layerBranch.layer.vcs_url,
                                                       layerBranch.vcs_subdir,
-                                                      not args.show_only)
+                                                      not args.show_only,
+                                                      layerBranch.actual_branch)
                 if not name:
                     # Error already shown
                     return 1
-- 
2.17.1


