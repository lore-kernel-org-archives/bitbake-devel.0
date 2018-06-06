Return-Path: <matt.hoosier@gmail.com>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
	[209.85.214.47])
	by mail.openembedded.org (Postfix) with ESMTP id BDC407714D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jun 2018 16:56:02 +0000 (UTC)
Received: by mail-it0-f47.google.com with SMTP id l6-v6so8959735iti.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Jun 2018 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=ZV9Gg19Ql5rz+QVMOVg0bwe8+3stGUbF8hqEs5GA9Gc=;
	b=rVS/bXf1pmeGMR8fs2WTBFi6GTYMMqlQsZOFmu179bBVSWmUqKTGg2i+DYzjlwDeYk
	JKyw7rPLHeKNXxji+wxXgFr3/i22NQwAF5BQ9VnY0eDQ7kCI/wWTOjE+2Y394dciCxKV
	WyhS3+Of/43Paue1sAvXnC64+NrXznRoRkU5nKLBxOH/P0RqDY7V/+cjl+zsQkVnMNOL
	WYI02md8l6zdn0qlhgXkMMSOjnRBcTi9OjURZsUnY3ipzHZQYyRxR6OGcY7+Cm0WfGQg
	bR4jcqIAC0uvP5vukjmuh9vmorO+CCNRDdLeZ0Qm7jY7JM9CBanLMgLQWvBuc8JFi18f
	//pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ZV9Gg19Ql5rz+QVMOVg0bwe8+3stGUbF8hqEs5GA9Gc=;
	b=SRPbF302BOWnnxW3yr/Ts1cCe8+8ERJI2bSZG4orKelxN95yGLvi5gB1uT34+dKDDV
	OHks4PydrNMVmC86o/jncNWzG72xDe9GC05XUHTLtPGvAxO+jZCL3P2M/iiTNRbDjef9
	9lakE8ZvyhNPzr59sJ7gMMeJ0S93U/yb+42aWKR0R2PuKYPY8dSjSxJjea8YOKMed3Fc
	EPAEdt/fHZiaQylU0DD2iqSyNaSJ3JIuQKU/rMXv887GJTc76RuyQbF5HVA9MwWpXuf/
	MFbyoL/uS8Xpcg/TENWtbPI5TH8VqS/L1f7NtcNuc7MD8OSbS1hvejzYBwk1+ly6NjJU
	6zqA==
X-Gm-Message-State: APt69E1D32Q2dxN/Lf46RLwQumjsbdVSqG1HREvWTKDlyx8vYJTtWwyy
	qbhniKwrpjeChpr6tqP92lqVaBap
X-Google-Smtp-Source: ADUXVKJYzPOwilZ9ZPoZl6RzPVvPzgBZO/Vs8tuJT8Fz6zXkX4SCxA4TW3yQGe3OnYcjERy4RP8h0w==
X-Received: by 2002:a24:70d0:: with SMTP id
	f199-v6mr3470888itc.2.1528304163394; 
	Wed, 06 Jun 2018 09:56:03 -0700 (PDT)
Received: from localhost.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	y20-v6sm4631918iod.39.2018.06.06.09.56.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 06 Jun 2018 09:56:02 -0700 (PDT)
From: Matt Hoosier <matt.hoosier@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jun 2018 11:55:54 -0500
Message-Id: <20180606165554.15111-1-matt.hoosier@gmail.com>
X-Mailer: git-send-email 2.17.0
Subject: [PATCH v6] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Wed, 06 Jun 2018 16:56:03 -0000

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
 lib/bb/fetch2/gitsm.py | 83 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0aff1008..86773094 100644
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
@@ -108,11 +108,46 @@ class GitSM(Git):
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
@@ -120,7 +155,7 @@ class GitSM(Git):
         if not ud.shallow or ud.localpath != ud.fullshallow:
             submodules = self.uses_submodules(ud, d, ud.clonedir)
             if submodules:
-                self.update_submodules(ud, d)
+                self.update_submodules(ud, d, allow_network=True)
 
     def clone_shallow_local(self, ud, dest, d):
         super(GitSM, self).clone_shallow_local(ud, dest, d)
@@ -132,4 +167,36 @@ class GitSM(Git):
 
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
2.17.0


