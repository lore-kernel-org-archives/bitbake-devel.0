Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com
	[209.85.166.178])
	by mail.openembedded.org (Postfix) with ESMTP id 0D2837BEDF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:38 +0000 (UTC)
Received: by mail-it1-f178.google.com with SMTP id v83so7232969itf.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=DF/ASmKDC9MFVZGu2PPY+XTr40S0lxNXklHmcbvQEQo=;
	b=Wb2EQZ3i2iyMkqWylTuk3WJIWaNbwTmGfnKOcrNEc94CbUr8W/esz+91Ipay5ZQUFo
	RhGw6sDLz4pHg0TThsIZ/RTNBhHvC8B3x9FnU7CxPm9wTuWzfYS8vRFz+7tIdsP2A5bR
	4oP1J6Jju459rMIG/0u5hGtlCv4cGZ8p8pHPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=DF/ASmKDC9MFVZGu2PPY+XTr40S0lxNXklHmcbvQEQo=;
	b=dwoOtmZ/uEcxH7MTE+4d7TP3a/oqWPgZpFEXEEh0da7avDw70EEW0/biQ71QN2uMTR
	Pk9YgR2b28LVn9jgCsJuNEOvq5FP5liYSGNy8z+uL9PvHpXYwNqoLwCteS5uqMWeRefQ
	ksUA7a0Cuodx5UHybfe0FlYcGRWA3FfhxyuhwPPkTB/M/dEGjnc3WhdhugVm8Gl022aC
	Yh9skjPXRjX7OK6rdSqxQYBpQPPaUYJepse3tZcF1sDKwiwz93NnufqTR9slToy8aHeg
	Uw9+6u48l29OaaQLTR3lYacSO4ibLhvbzMvEhUhzfXmAMB+5c55LFSve55bsS2kQAwHr
	cGFw==
X-Gm-Message-State: APjAAAXJgUqZf/zjqNgpoceQDj7qWL23/MqsWRsI03JeF65sRAo/0tHj
	yAYXVc6p+az6ewBnQ3BYHX1ijbAIA98=
X-Google-Smtp-Source: APXvYqxDSw/fCNmJOvyJjHSevt+Du62Wg9LfKSBYE3PR1EkCnmZkwmzH8wL7QwP/rr+IOVVOcXdQsQ==
X-Received: by 2002:a02:1783:: with SMTP id 125mr7146421jah.31.1552430559565; 
	Tue, 12 Mar 2019 15:42:39 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:38 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:18 -0400
Message-Id: <20190312224627.12667-2-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 01/10] gitsm.py: Fix when a submodule is defined, but not initialized
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:39 -0000

From: Mark Hatle <mark.hatle@windriver.com>

It is possible for a submodule to be defined in the .gitmodules file, but
never initialized in the repository itself.  This shows itself when searching
for the defined module hash you will get back a empty value.

Similarly we need to identify and skip defined but not initialized submodules
during the unpack stages as well.

Thanks to raphael.lisicki@siemens.com for their help is figuring out how
to resolve this issue.

Additionally a problem was found where, while unlikely, it may be possible
for the wrong revision to have been searched using ls-tree.  This has been
resolved in the update_submodules function by keeping the correct revision
along with the submodule path.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 49e1ff920143dcd4e7f73933d7ab8a84b8ffa1a3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 35729dbc..b7959ff5 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -64,6 +64,7 @@ class GitSM(Git):
     def update_submodules(self, ud, d):
         submodules = []
         paths = {}
+        revision = {}
         uris = {}
         local_paths = {}
 
@@ -77,6 +78,7 @@ class GitSM(Git):
             for m, md in self.parse_gitmodules(gitmodules).items():
                 submodules.append(m)
                 paths[m] = md['path']
+                revision[m] = ud.revisions[name]
                 uris[m] = md['url']
                 if uris[m].startswith('..'):
                     newud = copy.copy(ud)
@@ -84,7 +86,17 @@ class GitSM(Git):
                     uris[m] = Git._get_repo_url(self, newud)
 
         for module in submodules:
-            module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=True, workdir=ud.clonedir)
+            try:
+                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=True, workdir=ud.clonedir)
+            except:
+                # If the command fails, we don't have a valid file to check.  If it doesn't
+                # fail -- it still might be a failure, see next check...
+                module_hash = ""
+
+            if not module_hash:
+                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
+                continue
+
             module_hash = module_hash.split()[2]
 
             # Build new SRC_URI
@@ -143,7 +155,7 @@ class GitSM(Git):
         if not ud.shallow or ud.localpath != ud.fullshallow:
             self.update_submodules(ud, d)
 
-    def copy_submodules(self, submodules, ud, destdir, d):
+    def copy_submodules(self, submodules, ud, name, destdir, d):
         if ud.bareclone:
             repo_conf = destdir
         else:
@@ -156,6 +168,18 @@ class GitSM(Git):
             srcpath = os.path.join(ud.clonedir, 'modules', md['path'])
             modpath = os.path.join(repo_conf, 'modules', md['path'])
 
+            # Check if the module is initialized
+            try:
+                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=True, workdir=ud.clonedir)
+            except:
+                # If the command fails, we don't have a valid file to check.  If it doesn't
+                # fail -- it still might be a failure, see next check...
+                module_hash = ""
+
+            if not module_hash:
+                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
+                continue
+
             if os.path.exists(srcpath):
                 if os.path.exists(os.path.join(srcpath, '.git')):
                     srcpath = os.path.join(srcpath, '.git')
@@ -188,7 +212,7 @@ class GitSM(Git):
                 continue
 
             submodules = self.parse_gitmodules(gitmodules)
-            self.copy_submodules(submodules, ud, dest, d)
+            self.copy_submodules(submodules, ud, name, dest, d)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
@@ -211,7 +235,7 @@ class GitSM(Git):
                 continue
 
             submodules = self.parse_gitmodules(gitmodules)
-            self.copy_submodules(submodules, ud, ud.destdir, d)
+            self.copy_submodules(submodules, ud, name, ud.destdir, d)
 
             submodules_queue = [(module, os.path.join(repo_conf, 'modules', md['path'])) for module, md in submodules.items()]
             while len(submodules_queue) != 0:
-- 
2.17.2


