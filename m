Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id B1A6D6013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:34 +0000 (UTC)
Received: by pabxg6 with SMTP id xg6so92231145pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=cqHe94KUvns3+6B37S08yh5I8eo77sFW4vE1M8yag50=;
	b=FNBY8U6GdD4OhhWTQd97N+C05gs/TBg8NnxuwBGOjfxQfMC4bXaxbBXs1tUiyjLlHs
	lBzaKNgJKKXrMT3iiHM8n2d9kG5KiTeTYUBWsEc/pQfFRf68+BmXSPe0mmsRMZwU+8hX
	oyU+QM4IAl9oiA2OjRlawXWEU2/Mc6HV7/PHvWNAQAP5GatUSJZRjSMvJmGUTP/NRZ9r
	f2wxG3kAd6pyLkl8uNy8cy7+e/umnV4wkEvnIP3Mduh5Wq/HjugnqmXW41Nrql91SwPB
	h8pnFkRpVWscKNA6veGktNpMoOCB61HfQPDa/swXM7aHi+VukEj0FgCsQAyhyruz9cuT
	D65g==
X-Gm-Message-State: ALoCoQn4eWO7sTO9AOQqZbQ13Bz8Kb8qeFQWdhzHFlEtIjykaj3DPwc9JV81pkVINTQl2Jw2LeJi
X-Received: by 10.66.66.196 with SMTP id h4mr183807794pat.127.1426847135772;
	Fri, 20 Mar 2015 03:25:35 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id y5sm7429560pdh.21.2015.03.20.03.25.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:35 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id AE152564109; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:20 +0000
Message-Id: <d59c8e5c880478fe9e0e4418955ce9d36439a32d.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 03/14] toaster: display bitbake output after process start
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:35 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

If the bitbake server exists after the initial process start,
the only output displayed shows proper server start, with
no debug info.

This patch also brings the server log into the error message,
so the user has better info about what's going on.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 14 +++++++++-----
 lib/toaster/orm/models.py                       | 12 +++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 374991b..1bd5143 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -82,6 +82,8 @@ class LocalhostBEController(BuildEnvironmentController):
         assert self.pokydirname and os.path.exists(self.pokydirname)
         self._createdirpath(self.be.builddir)
         self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
+        # delete the templateconf.cfg; it may come from an unsupported layer configuration
+        os.remove(os.path.join(self.be.builddir, "conf/templateconf.cfg"))
 
 
     def writeConfFile(self, file_name, variable_list = None, raw = None):
@@ -115,9 +117,10 @@ class LocalhostBEController(BuildEnvironmentController):
                 f.seek(0, 2)    # jump to the end
                 toaster_ui_log_filelength = f.tell()
 
-        cmd = "bash -c \"source %s/oe-init-build-env %s && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 >toaster_server.log && DATABASE_URL=%s BBSERVER=0.0.0.0:-1 daemon -d -i -D %s -o toaster_ui.log -- %s --observe-only -u toasterui &\"" % (self.pokydirname, self.be.builddir,
+        cmd = "bash -c \"source %s/oe-init-build-env %s 2>&1 >toaster_server.log && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 2>&1 >toaster_server.log && DATABASE_URL=%s BBSERVER=0.0.0.0:-1 daemon -d -i -D %s -o toaster_ui.log -- %s --observe-only -u toasterui &\"" % (self.pokydirname, self.be.builddir,
                 self.dburl, self.be.builddir, own_bitbake)
         port = "-1"
+        logger.debug("localhostbecontroller: starting builder \n%s\n" % cmd)
         cmdoutput = self._shellcmd(cmd)
         for i in cmdoutput.split("\n"):
             if i.startswith("Bitbake server address"):
@@ -136,7 +139,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
         retries = 0
         started = False
-        while not started and retries < 30:
+        while not started and retries < 10:
             started = _toaster_ui_started(toaster_ui_log_filepath, toaster_ui_log_filelength)
             import time
             logger.debug("localhostbecontroller: Waiting bitbake server to start")
@@ -144,7 +147,8 @@ class LocalhostBEController(BuildEnvironmentController):
             retries += 1
 
         if not started:
-            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 15 seconds, aborting (Error: '%s')" % (cmdoutput))
+            toaster_server_log = open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
+            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 5 seconds, aborting (Error: '%s' '%s')" % (cmdoutput, toaster_server_log))
 
         logger.debug("localhostbecontroller: Started bitbake server")
 
@@ -180,7 +184,7 @@ class LocalhostBEController(BuildEnvironmentController):
         base = components[-2] if components[-1] == "git" else components[-1]
 
         if branch != "HEAD":
-            return os.path.join(self.be.sourcedir, "_%s_%s.toaster_cloned" % (base, branch))
+            return "_%s_%s.toaster_cloned" % (base, branch)
 
 
         # word of attention; this is a localhost-specific issue; only on the localhost we expect to have "HEAD" releases
@@ -239,7 +243,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
         # 3. checkout the repositories
         for giturl, commit in gitrepos.keys():
-            localdirname = self.getGitCloneDirectory(giturl, commit)
+            localdirname = os.path.join(self.be.sourcedir, self.getGitCloneDirectory(giturl, commit))
             logger.debug("localhostbecontroller: giturl %s:%s checking out in current directory %s" % (giturl, commit, localdirname))
 
             # make sure our directory is a git repository
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 2132f87..eea98b5 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -52,7 +52,7 @@ class ToasterSetting(models.Model):
     value = models.CharField(max_length=255)
 
     def __unicode__(self):
-        return "Setting %s" % self.name
+        return "Setting %s = " % (self.name, self.value)
 
 class ProjectManager(models.Manager):
     def create_project(self, name, release):
@@ -100,7 +100,7 @@ class Project(models.Model):
     objects     = ProjectManager()
 
     def __unicode__(self):
-        return "%s (%s, %s)" % (self.name, self.release, self.bitbake_version)
+        return "%s (Release %s, BBV %s)" % (self.name, self.release, self.bitbake_version)
 
     def get_current_machine_name(self):
         try:
@@ -896,7 +896,7 @@ class BitbakeVersion(models.Model):
     dirpath = models.CharField(max_length=255)
 
     def __unicode__(self):
-        return "%s (%s)" % (self.name, self.branch)
+        return "%s (Branch: %s)" % (self.name, self.branch)
 
 
 class Release(models.Model):
@@ -1055,8 +1055,10 @@ class Layer_Version(models.Model):
 
 #        raise Exception(candidate_layer_versions)
 
-        release_priorities = map(lambda x: (x.layer_source_id, x.priority), project.release.releaselayersourcepriority_set.all().order_by("-priority"))
+        release_priorities = {}
 
+        for ls_id, prio in map(lambda x: (x.layer_source_id, x.priority), project.release.releaselayersourcepriority_set.all().order_by("-priority")):
+            release_priorities[ls_id] = prio
 
         def _get_ls_priority(ls):
             # if there is no layer source, we have minus infinite priority, as we don't want this layer selected
@@ -1081,7 +1083,7 @@ class Layer_Version(models.Model):
         raise Exception("Cannot determine the vcs_reference for layer version %s" % vars(self))
 
     def __unicode__(self):
-        return  str(self.layer) + "(%s,%s)" % (self.get_vcs_reference(), self.build.project if self.build is not None else "None")
+        return "%d %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
 
     class Meta:
         unique_together = ("layer_source", "up_id")
-- 
1.9.1


