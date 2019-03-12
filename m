Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f194.google.com (mail-it1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id 904C97BEDF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:43 +0000 (UTC)
Received: by mail-it1-f194.google.com with SMTP id z131so7173669itf.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=8/lzXGLaV6ruXewjhnSgNi0UygAmNmpmDVuAIDY1px4=;
	b=oGGA8db0FeVOd701YZfSgBGcWJYvVgG6xiyJf5+Ea06XEWUIwhVV77GApEzDZ7qulm
	ml0OovfkUKAX6vAYTI60Y+HzQzsS7vPGg26D5zBxYrrwbIiyZ1hGm+kDFOnmMQFKbRwT
	FRTbVRwoE7EgKUcfmbSCcm0zwxI5aTu2tk6Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=8/lzXGLaV6ruXewjhnSgNi0UygAmNmpmDVuAIDY1px4=;
	b=Iy5RZppErt+I5jIGQrIAmo7jhIZ2g/8ypCqor4vu7biDyUxo50bOcSWU7vg+P5hEq6
	Y+3ovjk0nLsyjI0pefGXUUUI0z1MDeBW4INyg2yFNm65CmAeuvNdZM/q/Me06lXyu6sP
	RagE5qelkX9mOh7N+YI7/VbfAaoU44RCpk0XGOOLdk7ze7hm4J3KUn/vH8t//o928Bn8
	wQPqfPV6GefLKp7SUQ2Ciar1NdtmJffqNwE+XDSnnB8pnSqFyKkfxugTV5rTYBMiHTwW
	8dNoJ+WXQKJcRrxUGHScW4OgdWz+AZf+hHr5xJEV4xFYZNV9vvVdWFsdqqq3Psya7jf1
	TycQ==
X-Gm-Message-State: APjAAAWA8J5Qv7/Z2gZynwIjH2ziB0M6fjZYndTVXJVBmE7BsI3y5iom
	qCmUifJ1IDC4Lxrn++UHZSaeprwTzbA=
X-Google-Smtp-Source: APXvYqzCGY5zZCHptukSVKSVyjCCt6grOSPBktbk+CgBrfe1ULOxxSZAbRzSDUD1tIt73RBjE4fkeg==
X-Received: by 2002:a24:101:: with SMTP id 1mr107217itk.138.1552430563944;
	Tue, 12 Mar 2019 15:42:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:22 -0400
Message-Id: <20190312224627.12667-6-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 05/10] gitsm.py: revise unpack
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:43 -0000

From: Mark Hatle <mark.hatle@windriver.com>

Greatly simply the unpack rule by copying the general functionality of
update_submodules as unpack_submodules.  This will recursively construct
a set of urls and unpack them using the standard system behaviors.

The overall code may be slightly bigger, but this ensures that all of the
standard locks are inplace, ensuring the code doesn't change out from
under the unpack function.  (This could have happened before due to using
'cp' instead of further unpacks on submodules.  This may still happen in
shallow clones.)

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7d7ee630f1c65e7dd234f945edf5e3b3bcb0fc30)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 116 +++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 38 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 11bfa668..c172ab16 100644
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
2.17.2


