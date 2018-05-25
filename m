Return-Path: <matt.hoosier@gmail.com>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
	[209.85.214.44])
	by mail.openembedded.org (Postfix) with ESMTP id 3CFFF7198F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 May 2018 13:45:38 +0000 (UTC)
Received: by mail-it0-f44.google.com with SMTP id q4-v6so6885162ite.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 May 2018 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=3kUkli+a6RlQf2FkYE+tCsxsNIRGGpEVbs+fT/zrNmU=;
	b=p/T5yOTqmYu/8vKRyUvDaWlgP29eZh0vaubtuTPJHvAMpE3Z6lUSlPcGlLdx90EgKN
	5Q5D020WTyadNFamMrGwmXgeI24bs5yPnSB2OvWCHFVGnqmJGRt+vLDrC9BlIu26BwD8
	DodCfvFGvTj/WRzqe6UCa5wVViRoEWI6TFF7Tioc9x9+v2JWDqhAlXz2/T97csiae37S
	uv8foZ4UVvobBzNGB1BB0iMfPkl/4na14txzjggjxPVLBMV7fUMd1fe+RWkrPFFkgyBi
	HHr6Nv+mi7RSG5k53ePFmP7zbGJEcCYsZYak/iIPGyZ1509MRyP9T2ytOVIuaFCIGfx9
	Rahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3kUkli+a6RlQf2FkYE+tCsxsNIRGGpEVbs+fT/zrNmU=;
	b=ZlS6NVnB6FtjKtKn+I0hYsBm12tS+lOTfbdiZa3Gh5x5U735NBP3yD8uW/Vs12s9UG
	icTAc7/LSHUPzJmroQwUavpUpO63sAM58yhwJUkrdIvHrosK3U3WZzuSGdYUw7GW3S/d
	kLX41cBGrKyNCGw+Qu0PBjfFbbATNlg19PPoXFEzOk65XdU1dIgcUw3IlsDmpInUtz7b
	KB4bU62umPgamLnx/bvFWblTnVFWEb1IBvPf2P8J4JytG64p9mkLGPXYDREuDFIe7EQ3
	GY/A3x8UchdCFl/0jEQsthIsj7uMeUnXNPSVYn6aqd2KM8WEcp2jSuuh+ftlt8gLLvDf
	7mwQ==
X-Gm-Message-State: ALKqPwdJvklQaI9q8pizCVii7pwXJjp4cRRNEwD4D7OW+1boBw7V6cqd
	p8WRvtanC5F1yBc38IZqc2DDpxpi
X-Google-Smtp-Source: AB8JxZrEwjwpXTyouagGIVeeI858G2yDLpCUWduZ0r5QOErvrUhqRwc0BN3Ikxi5viDHH6tXDFfXSQ==
X-Received: by 2002:a24:b210:: with SMTP id
	u16-v6mr2125447ite.15.1527255939865; 
	Fri, 25 May 2018 06:45:39 -0700 (PDT)
Received: from localhost.localdomain ([204.77.163.42])
	by smtp.gmail.com with ESMTPSA id
	q11-v6sm126885ita.15.2018.05.25.06.45.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 25 May 2018 06:45:39 -0700 (PDT)
From: Matt Hoosier <matt.hoosier@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 May 2018 08:45:37 -0500
Message-Id: <20180525134537.27659-1-matt.hoosier@gmail.com>
X-Mailer: git-send-email 2.13.6
Subject: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 25 May 2018 13:45:39 -0000

Although the submodules' histories have been fetched during the
do_fetch() phase, the mechanics used to clone the workdir copy
of the repo haven't been transferring the actual .git/modules
directory from the repo fetched into downloads/ during the
fetch task.

Fix that, and for good measure also explicitly tell Git to avoid
hitting the network during do_unpack() of the submodules.

[YOCTO #12739]

Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 84 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0aff1008..7ac0dbb1 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -98,7 +98,7 @@ class GitSM(Git):
                         for line in lines:
                             f.write(line)
 
-    def update_submodules(self, ud, d):
+    def update_submodules(self, ud, d, allow_network):
         # We have to convert bare -> full repo, do the submodule bit, then convert back
         tmpclonedir = ud.clonedir + ".tmp"
         gitdir = tmpclonedir + os.sep + ".git"
@@ -108,11 +108,47 @@ class GitSM(Git):
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare = false/'", d)
         runfetchcmd(ud.basecmd + " reset --hard", d, workdir=tmpclonedir)
         runfetchcmd(ud.basecmd + " checkout -f " + ud.revisions[ud.names[0]], d, workdir=tmpclonedir)
-        runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=tmpclonedir)
-        self._set_relative_paths(tmpclonedir)
-        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d, workdir=tmpclonedir)
-        os.rename(gitdir, ud.clonedir,)
-        bb.utils.remove(tmpclonedir, True)
+
+        try:
+            if allow_network:
+                fetch_flags = ""
+            else:
+                fetch_flags = "--no-fetch"
+
+            # The 'git submodule sync' sandwiched between two successive 'git submodule update' commands is
+            # intentional. See the notes on the similar construction in download() for an explanation.
+            runfetchcmd("%(basecmd)s submodule update --init --recursive %(fetch_flags)s || (%(basecmd)s submodule sync --recursive && %(basecmd)s submodule update --init --recursive %(fetch_flags)s)" % {'basecmd': ud.basecmd, 'fetch_flags' : fetch_flags}, d, workdir=tmpclonedir)
+        except bb.fetch.FetchError:
+            if allow_network:
+                raise
+            else:
+                # This method was called as a probe to see whether the submodule history
+                # is complete enough to allow the current working copy to have its
+                # modules filled in. It's not, so swallow up the exception and report
+                # the negative result.
+                return False
+        finally:
+            self._set_relative_paths(tmpclonedir)
+            runfetchcmd(ud.basecmd + " submodule deinit -f --all", d, workdir=tmpclonedir)
+            runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d, workdir=tmpclonedir)
+            os.rename(gitdir, ud.clonedir,)
+            bb.utils.remove(tmpclonedir, True)
+
+        return True
+
+    def need_update(self, ud, d):
+        main_repo_needs_update = Git.need_update(self, ud, d)
+
+        # First check that the main repository has enough history fetched. If it doesn't, then we don't
+        # even have the .gitmodules and gitlinks for the submodules to attempt asking whether the
+        # submodules' histories are recent enough.
+        if main_repo_needs_update:
+            return True
+
+        # Now check that the submodule histories are new enough. The git-submodule command doesn't have
+        # any clean interface for doing this aside from just attempting the checkout (with network
+        # fetched disabled).
+        return not self.update_submodules(ud, d, allow_network=False)
 
     def download(self, ud, d):
         Git.download(self, ud, d)
@@ -120,7 +156,7 @@ class GitSM(Git):
         if not ud.shallow or ud.localpath != ud.fullshallow:
             submodules = self.uses_submodules(ud, d, ud.clonedir)
             if submodules:
-                self.update_submodules(ud, d)
+                self.update_submodules(ud, d, allow_network=True)
 
     def clone_shallow_local(self, ud, dest, d):
         super(GitSM, self).clone_shallow_local(ud, dest, d)
@@ -132,4 +168,36 @@ class GitSM(Git):
 
         if self.uses_submodules(ud, d, ud.destdir):
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
-            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
+
+            # Copy over the submodules' fetched histories too.
+            if ud.bareclone:
+                repo_conf = ud.destdir
+            else:
+                repo_conf = os.path.join(ud.destdir, '.git')
+
+            if os.path.exists(ud.clonedir):
+                # This is not a copy unpacked from a shallow mirror clone. So
+                # the manual intervention to populate the .git/modules done
+                # in clone_shallow_local() won't have been done yet.
+                runfetchcmd("cp -fpPRH %s %s" % (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
+                fetch_flags = "--no-fetch"
+            elif os.path.exists(os.path.join(repo_conf, 'modules')):
+                # Unpacked from a shallow mirror clone. Manual population of
+                # .git/modules is already done.
+                fetch_flags = "--no-fetch"
+            else:
+                # This isn't fatal; git-submodule will just fetch it
+                # during do_unpack().
+                fetch_flags = ""
+                bb.error("submodule history not retrieved during do_fetch()")
+
+            # Careful not to hit the network during unpacking; all history should already
+            # be fetched.
+            #
+            # The repeated attempts to do the submodule initialization sandwiched around a sync to
+            # install the correct remote URLs into the submodules' .git/config metadata are deliberate.
+            # Bad remote URLs are leftover in the modules' .git/config files from the unpack of bare
+            # clone tarballs and an initial 'git submodule update' is necessary to prod them back to
+            # enough life so that the 'git submodule sync' realizes the existing module .git/config
+            # files exist to be updated.
+            runfetchcmd("%(basecmd)s submodule update --init --recursive %(fetch_flags)s || (%(basecmd)s submodule sync --recursive && %(basecmd)s submodule update --init --recursive %(fetch_flags)s)" % {'basecmd': ud.basecmd, 'fetch_flags': fetch_flags}, d, workdir=ud.destdir)
-- 
2.13.6


