Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id B838C7C144
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 21:34:28 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0FLWnbu010207
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 15 Jan 2019 13:32:59 -0800
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 15 Jan 2019 13:32:38 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Jan 2019 16:31:35 -0500
Message-ID: <20190115213137.113956-6-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190115213137.113956-1-mark.hatle@windriver.com>
References: <20190115213137.113956-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 5/7] gitsm.py: revise unpack
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
X-List-Received-Date: Tue, 15 Jan 2019 21:34:28 -0000
Content-Type: text/plain

Greatly simply the unpack rule by copying the general functionality of
update_submodules as unpack_submodules.  This will recursively construct
a set of urls and unpack them using the standard system behaviors.

The overall code may be slightly bigger, but this ensures that all of the
standard locks are inplace, ensuring the code doesn't change out from
under the unpack function.  (This could have happened before due to using
'cp' instead of further unpacks on submodules.  This may still happen in
shallow clones.)

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 116 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 78 insertions(+), 38 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 11bfa66..c172ab1 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -213,61 +213,101 @@ class GitSM(Git):
             submodules = self.parse_gitmodules(gitmodules)
             self.copy_submodules(submodules, ud, name, dest, d)
 
-    def unpack(self, ud, destdir, d):
-        Git.unpack(self, ud, destdir, d)
-
-        # Copy over the submodules' fetched histories too.
-        if ud.bareclone:
-            repo_conf = ud.destdir
-        else:
-            repo_conf = os.path.join(ud.destdir, '.git')
-
-        update_submodules = False
+    def unpack_submodules(self, repo_conf, ud, d):
+        submodules = []
         paths = {}
+        revision = {}
         uris = {}
         local_paths = {}
+
         for name in ud.names:
             try:
-                gitmodules = runfetchcmd("%s show HEAD:.gitmodules" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+                gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=ud.destdir)
             except:
                 # No submodules to update
                 continue
 
-            submodules = self.parse_gitmodules(gitmodules)
-            self.copy_submodules(submodules, ud, name, ud.destdir, d)
+            for m, md in self.parse_gitmodules(gitmodules).items():
+                submodules.append(m)
+                paths[m] = md['path']
+                revision[m] = ud.revisions[name]
+                uris[m] = md['url']
+                if uris[m].startswith('..'):
+                    newud = copy.copy(ud)
+                    newud.path = os.path.realpath(os.path.join(newud.path, md['url']))
+                    uris[m] = Git._get_repo_url(self, newud)
 
-            submodules_queue = [(module, os.path.join(repo_conf, 'modules', md['path'])) for module, md in submodules.items()]
-            while len(submodules_queue) != 0:
-                module, modpath = submodules_queue.pop()
+        modules_updated = False
 
-                # add submodule children recursively
-                try:
-                    gitmodules = runfetchcmd("%s show HEAD:.gitmodules" % (ud.basecmd), d, quiet=True, workdir=modpath)
-                    for m, md in self.parse_gitmodules(gitmodules).items():
-                        submodules_queue.append([m, os.path.join(modpath, 'modules', md['path'])])
-                except:
-                    # no children
-                    pass
+        for module in submodules:
+            try:
+                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=True, workdir=ud.destdir)
+            except:
+                # If the command fails, we don't have a valid file to check.  If it doesn't
+                # fail -- it still might be a failure, see next check...
+                module_hash = ""
 
+            if not module_hash:
+                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
+                continue
 
-                # There are submodules to update
-                update_submodules = True
+            modules_updated = True
 
-                # Determine (from the submodule) the correct url to reference
-                try:
-                    output = runfetchcmd("%(basecmd)s config remote.origin.url" % {'basecmd': ud.basecmd}, d, workdir=modpath)
-                except bb.fetch2.FetchError as e:
-                    # No remote url defined in this submodule
-                    continue
+            module_hash = module_hash.split()[2]
 
-                local_paths[module] = output
+            # Build new SRC_URI
+            if "://" not in uris[module]:
+                # It's ssh if the format does NOT have "://", but has a ':'
+                if ":" in uris[module]:
+                    proto = "ssh"
+                    if ":/" in uris[module]:
+                        url = "gitsm://" + uris[module].replace(':/', '/', 1)
+                    else:
+                        url = "gitsm://" + uris[module].replace(':', '/', 1)
+                else: # Fall back to 'file' if there is no ':'
+                    proto = "file"
+                    url = "gitsm://" + uris[module]
+            else:
+                proto = uris[module].split(':', 1)[0]
+                url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
 
-                # Setup the local URL properly (like git submodule init or sync would do...)
-                runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.destdir)
+            url += ';protocol=%s' % proto
+            url += ";name=%s" % module
+            url += ";bareclone=1;nobranch=1;subpath=%s" % paths[module]
+
+            ld = d.createCopy()
+            # Not necessary to set SRC_URI, since we're passing the URI to
+            # Fetch.
+            #ld.setVar('SRC_URI', url)
+            ld.setVar('SRCREV_%s' % module, module_hash)
 
-                # Ensure the submodule repository is NOT set to bare, since we're checking it out...
-                runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=modpath)
+            # Workaround for issues with SRCPV/SRCREV_FORMAT errors
+            # error refer to 'multiple' repositories.  Only the repository
+            # in the original SRC_URI actually matters...
+            ld.setVar('SRCPV', d.getVar('SRCPV'))
+            ld.setVar('SRCREV_FORMAT', module)
+
+            newfetch = Fetch([url], ld, cache=False)
+            newfetch.unpack(root=os.path.join(repo_conf, 'modules'))
+            local_paths[module] = newfetch.localpath(url)
+
+            # Correct the submodule references to the local download version...
+            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.destdir)
+
+            # Ensure the submodule repository is NOT set to bare, since we're checking it out...
+            runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', paths[module]))
+
+        return modules_updated
+
+    def unpack(self, ud, destdir, d):
+        Git.unpack(self, ud, destdir, d)
+
+        # Copy over the submodules' fetched histories too.
+        if ud.bareclone:
+            repo_conf = ud.destdir
+        else:
+            repo_conf = os.path.join(ud.destdir, '.git')
 
-        if update_submodules:
+        if self.unpack_submodules(repo_conf, ud, d):
             # Run submodule update, this sets up the directories -- without touching the config
             runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
-- 
1.8.3.1


