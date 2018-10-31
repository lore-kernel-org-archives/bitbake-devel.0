Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 90AC579CCC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 19:22:31 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w9VJLvAF002337
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 12:22:22 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.408.0;
	Wed, 31 Oct 2018 12:22:07 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 31 Oct 2018 15:21:44 -0400
Message-ID: <20181031192144.35366-3-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20181031192144.35366-1-mark.hatle@windriver.com>
References: <20181031192144.35366-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] fetch2/gitsm.py: Fix the references when the module and path are different
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
X-List-Received-Date: Wed, 31 Oct 2018 19:22:31 -0000
Content-Type: text/plain

Git does not require the module and target path to be the same in the
.gitmodules file.  This incorrect assumption was being made previously
causing various unpack failures.

An example .gitmodule showing this issue:

   [submodule "plugins/WaveShaper/Libs/inih"]
        path = plugins/wolf-shaper/Libs/inih
        url = https://github.com/pdesaulniers/inih.git

The unpack function also needed to work in a loop on the overall
submodules_queue.  Before it could have missed items that were not in the
primary repository.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 69 +++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index dbfa3a4..35729db 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -152,9 +152,9 @@ class GitSM(Git):
         if submodules and not os.path.exists(os.path.join(repo_conf, 'modules')):
             os.mkdir(os.path.join(repo_conf, 'modules'))
 
-        for module in submodules:
-            srcpath = os.path.join(ud.clonedir, 'modules', module)
-            modpath = os.path.join(repo_conf, 'modules', module)
+        for module, md in submodules.items():
+            srcpath = os.path.join(ud.clonedir, 'modules', md['path'])
+            modpath = os.path.join(repo_conf, 'modules', md['path'])
 
             if os.path.exists(srcpath):
                 if os.path.exists(os.path.join(srcpath, '.git')):
@@ -187,9 +187,8 @@ class GitSM(Git):
                 # No submodules to update
                 continue
 
-            submodules = list(self.parse_gitmodules(gitmodules).keys())
-
-        self.copy_submodules(submodules, ud, dest, d)
+            submodules = self.parse_gitmodules(gitmodules)
+            self.copy_submodules(submodules, ud, dest, d)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
@@ -200,7 +199,7 @@ class GitSM(Git):
         else:
             repo_conf = os.path.join(ud.destdir, '.git')
 
-        submodules = []
+        update_submodules = False
         paths = {}
         uris = {}
         local_paths = {}
@@ -211,41 +210,41 @@ class GitSM(Git):
                 # No submodules to update
                 continue
 
-            for m, md in self.parse_gitmodules(gitmodules).items():
-                submodules.append(m)
-                paths[m] = md['path']
-                uris[m] = md['url']
+            submodules = self.parse_gitmodules(gitmodules)
+            self.copy_submodules(submodules, ud, ud.destdir, d)
+
+            submodules_queue = [(module, os.path.join(repo_conf, 'modules', md['path'])) for module, md in submodules.items()]
+            while len(submodules_queue) != 0:
+                module, modpath = submodules_queue.pop()
 
-        self.copy_submodules(submodules, ud, ud.destdir, d)
+                # add submodule children recursively
+                try:
+                    gitmodules = runfetchcmd("%s show HEAD:.gitmodules" % (ud.basecmd), d, quiet=True, workdir=modpath)
+                    for m, md in self.parse_gitmodules(gitmodules).items():
+                        submodules_queue.append([m, os.path.join(modpath, 'modules', md['path'])])
+                except:
+                    # no children
+                    pass
 
-        submodules_queue = [(module, os.path.join(repo_conf, 'modules', module)) for module in submodules]
-        while len(submodules_queue) != 0:
-            module, modpath = submodules_queue.pop()
 
-            # add submodule children recursively
-            try:
-                gitmodules = runfetchcmd("%s show HEAD:.gitmodules" % (ud.basecmd), d, quiet=True, workdir=modpath)
-                for m, md in self.parse_gitmodules(gitmodules).items():
-                    submodules_queue.append([m, os.path.join(modpath, 'modules', m)])
-            except:
-                # no children
-                pass
+                # There are submodules to update
+                update_submodules = True
 
-            # Determine (from the submodule) the correct url to reference
-            try:
-                output = runfetchcmd("%(basecmd)s config remote.origin.url" % {'basecmd': ud.basecmd}, d, workdir=modpath)
-            except bb.fetch2.FetchError as e:
-                # No remote url defined in this submodule
-                continue
+                # Determine (from the submodule) the correct url to reference
+                try:
+                    output = runfetchcmd("%(basecmd)s config remote.origin.url" % {'basecmd': ud.basecmd}, d, workdir=modpath)
+                except bb.fetch2.FetchError as e:
+                    # No remote url defined in this submodule
+                    continue
 
-            local_paths[module] = output
+                local_paths[module] = output
 
-            # Setup the local URL properly (like git submodule init or sync would do...)
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.destdir)
+                # Setup the local URL properly (like git submodule init or sync would do...)
+                runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.destdir)
 
-            # Ensure the submodule repository is NOT set to bare, since we're checking it out...
-            runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=modpath)
+                # Ensure the submodule repository is NOT set to bare, since we're checking it out...
+                runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=modpath)
 
-        if submodules:
+        if update_submodules:
             # Run submodule update, this sets up the directories -- without touching the config
             runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
-- 
1.8.3.1


