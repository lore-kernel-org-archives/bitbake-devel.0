Return-Path: <eu@felipetonello.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id BF4AD75D65
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jul 2015 15:14:12 +0000 (UTC)
Received: by widjy10 with SMTP id jy10so163885598wid.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jul 2015 08:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=llLBxyFITo9jVWoYyOxwcnEiju2B4PU9D/vhscRlfiw=;
	b=MXXgGrK9lkphGNa1+w9nzKr/V8I8UdDrS2i03Qr4/0/n1iPCG2hntS+FdLJdVZUepG
	EPRtGjlq5j8WIM1vDISkxUw3vn8GfNdmMikQTgekI4fyQ55816hOi9pmm6AP1QgcfC9Y
	mda3nT1A4GVNEoyvRDxpgBRm3/ygTx/j5k1cu2MiRwBP1boIWdS+/RLe17RemRTPtmr+
	JptaqrlAoBFi/MFvkdlkhXaWAxql/b5kz0kTz6y7UbbrmyCsZiBb5Gq+Lqo1Ws8SDkBi
	2hILViid8uqw5eM9w9L+rNaFnkdRIfIOJqxp2r6deYNp19MsoT8kzjWeMhA82L4+B4Z0
	WnfQ==
X-Gm-Message-State: ALoCoQlGtaH+V4xZbHDnjhLOoYVkwgONDdZsBLdA2jy1ZhlTpop9z88514rBMOdHHPiECn3bInp6
X-Received: by 10.180.9.7 with SMTP id v7mr55152142wia.60.1436195651798;
	Mon, 06 Jul 2015 08:14:11 -0700 (PDT)
Received: from felipe-fedora.localdomain ([81.145.202.106])
	by mx.google.com with ESMTPSA id ee1sm47759429wic.8.2015.07.06.08.14.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 Jul 2015 08:14:10 -0700 (PDT)
From: eu@felipetonello.com
To: bitbake-devel@lists.openembedded.org
Date: Mon,  6 Jul 2015 16:13:58 +0100
Message-Id: <1436195638-24806-1-git-send-email-eu@felipetonello.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH] fetch2: Remove unecessary code for git submodules
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
X-List-Received-Date: Mon, 06 Jul 2015 15:14:14 -0000

From: "Felipe F. Tonello" <eu@felipetonello.com>

Only do git submodule update after upack, otherwise the branch and commit id
will be ignored, causing to run git submodules on a wrong ref.

Since .gitmodules file is used to check if there is any submodule, we don't
need to worry about copying .git/modules directory into the unpacked source
tree.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 lib/bb/fetch2/gitsm.py | 73 --------------------------------------------------
 1 file changed, 73 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c125cff..405cd87 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -31,10 +31,8 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your r
 
 import os
 import bb
-from   bb    import data
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
 
 class GitSM(Git):
     def supports(self, ud, d):
@@ -52,85 +50,14 @@ class GitSM(Git):
                 pass
         return False
 
-    def _set_relative_paths(self, repopath):
-        """
-        Fix submodule paths to be relative instead of absolute,
-        so that when we move the repo it doesn't break
-        (In Git 1.7.10+ this is done automatically)
-        """
-        submodules = []
-        with open(os.path.join(repopath, '.gitmodules'), 'r') as f:
-            for line in f.readlines():
-                if line.startswith('[submodule'):
-                    submodules.append(line.split('"')[1])
-
-        for module in submodules:
-            repo_conf = os.path.join(repopath, module, '.git')
-            if os.path.exists(repo_conf):
-                with open(repo_conf, 'r') as f:
-                    lines = f.readlines()
-                newpath = ''
-                for i, line in enumerate(lines):
-                    if line.startswith('gitdir:'):
-                        oldpath = line.split(': ')[-1].rstrip()
-                        if oldpath.startswith('/'):
-                            newpath = '../' * (module.count('/') + 1) + '.git/modules/' + module
-                            lines[i] = 'gitdir: %s\n' % newpath
-                            break
-                if newpath:
-                    with open(repo_conf, 'w') as f:
-                        for line in lines:
-                            f.write(line)
-
-            repo_conf2 = os.path.join(repopath, '.git', 'modules', module, 'config')
-            if os.path.exists(repo_conf2):
-                with open(repo_conf2, 'r') as f:
-                    lines = f.readlines()
-                newpath = ''
-                for i, line in enumerate(lines):
-                    if line.lstrip().startswith('worktree = '):
-                        oldpath = line.split(' = ')[-1].rstrip()
-                        if oldpath.startswith('/'):
-                            newpath = '../' * (module.count('/') + 3) + module
-                            lines[i] = '\tworktree = %s\n' % newpath
-                            break
-                if newpath:
-                    with open(repo_conf2, 'w') as f:
-                        for line in lines:
-                            f.write(line)
-
-    def update_submodules(self, ud, d):
-        # We have to convert bare -> full repo, do the submodule bit, then convert back
-        tmpclonedir = ud.clonedir + ".tmp"
-        gitdir = tmpclonedir + os.sep + ".git"
-        bb.utils.remove(tmpclonedir, True)
-        os.mkdir(tmpclonedir)
-        os.rename(ud.clonedir, gitdir)
-        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare = false/'", d)
-        os.chdir(tmpclonedir)
-        runfetchcmd(ud.basecmd + " reset --hard", d)
-        runfetchcmd(ud.basecmd + " submodule init", d)
-        runfetchcmd(ud.basecmd + " submodule update", d)
-        self._set_relative_paths(tmpclonedir)
-        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d)
-        os.rename(gitdir, ud.clonedir,)
-        bb.utils.remove(tmpclonedir, True)
-
     def download(self, ud, d):
         Git.download(self, ud, d)
 
-        os.chdir(ud.clonedir)
-        submodules = self.uses_submodules(ud, d)
-        if submodules:
-            self.update_submodules(ud, d)
-
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
-        
         os.chdir(ud.destdir)
         submodules = self.uses_submodules(ud, d)
         if submodules:
-            runfetchcmd("cp -r " + ud.clonedir + "/modules " + ud.destdir + "/.git/", d)
             runfetchcmd(ud.basecmd + " submodule init", d)
             runfetchcmd(ud.basecmd + " submodule update", d)
 
-- 
2.1.0


