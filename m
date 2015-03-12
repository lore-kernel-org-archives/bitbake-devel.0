Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 4A91F73ADD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:49 +0000 (UTC)
Received: by wggy19 with SMTP id y19so15408184wgg.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=mMigvaN2j1w/zmcuc1rFDRePTYN+LkaJgiwHkap4MK4=;
	b=a6Yv9epSYs0YZA144zKzzB1qt3BgSdfvcoIxi0EKKW7LAUaXKXoMUVmI7ZshGODH0b
	h5yo/GhkNGgXR8JwVf3CGM3VebxWKPHEw3SAGzdSdwGRZdamwti/ALQdwf+ChxuEK2L7
	SgUBTNxXZkfTvx9kZ3/1a/8DWgHfwNiydPtAY/x9RPU2qD1HQxnBv1D8nzpmf9aMcX5s
	Tza58bcGzeqc8BakTqSDhoS34wWAVUd1sqcb/9gWOs6He0uwfJk4dDsnu+cl0y3P2Ler
	GzxJuH0LgW+DTV9r/vLqfvKboyacIpFC8BvJ8T9WgV7MS5xjdgEothuBIV3tsjEoJwd9
	6X5A==
X-Gm-Message-State: ALoCoQlpY4bdBBgZ+Co+tSusIO+Su23eiRDapLHXyoC2+X35T5Rm6y0JKtozm9mB2ORMp4btWJYI
X-Received: by 10.194.6.70 with SMTP id y6mr83961111wjy.97.1426157210909;
	Thu, 12 Mar 2015 03:46:50 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dc9sm28558461wib.9.2015.03.12.03.46.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:50 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 699DC561DB0; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:39 +0000
Message-Id: <93b33f1f028129f1efd61c35219e44d3cd551de9.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 06/17] toasterui: identify proper layer in build mode
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:50 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In build mode, instead of creating our own layer objects,
we identify the layer objects that the build system set up.

[YOCTO #7378]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                    | 23 ++++++++++++++++++-----
 lib/toaster/bldcontrol/localhostbecontroller.py |  4 ++--
 lib/toaster/orm/models.py                       | 10 ++--------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 19ddd8e..ae2ac9f 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -270,15 +270,28 @@ class ORMWrapper(object):
         else:
             # we are under managed mode; we must match the layer used in the Project Layer
             from bldcontrol.models import BuildEnvironment, BuildRequest
-            br, be = brbe.split(":")
+            br_id, be_id = brbe.split(":")
 
-            buildrequest = BuildRequest.objects.get(pk = br)
+            # find layer by checkout path;
+            from bldcontrol import bbcontroller
+            bc = bbcontroller.getBuildEnvironmentController(pk = be_id)
 
             # we might have a race condition here, as the project layers may change between the build trigger and the actual build execution
             # but we can only match on the layer name, so the worst thing can happen is a mis-identification of the layer, not a total failure
-            layer_object = buildrequest.project.projectlayer_set.get(layercommit__layer__name=layer_information['name']).layercommit.layer
 
-            return layer_object
+            from pprint import pformat
+            # note that this is different
+            buildrequest = BuildRequest.objects.get(pk = br_id)
+            for brl in buildrequest.brlayer_set.all():
+                localdirname = os.path.join(bc.getGitCloneDirectory(brl.giturl, brl.commit), brl.dirpath)
+                logger.warn("Matched %s to BRlayer %s" % (pformat(layer_information["local_path"]), localdirname))
+                if localdirname.startswith(layer_information['local_path']):
+                    # we matched the BRLayer, but we need the layer_version that generated this BR; reverse of the Project.schedule_build()
+                    for pl in buildrequest.project.projectlayer_set.filter(layercommit__layer__name = brl.name):
+                        if pl.layercommit.layer.vcs_url == brl.giturl :
+                            return pl.layercommit.layer
+
+            raise Exception("Unidentified layer %s" % pformat(layer_information))
 
 
     def save_target_file_information(self, build_obj, target_obj, filedata):
@@ -683,7 +696,7 @@ class BuildInfoHelper(object):
 
             # Heuristics: we match the path to where the layers have been checked out
             for brl in sorted(BuildRequest.objects.get(pk = br_id).brlayer_set.all(), reverse = True, key = _slkey_managed):
-                localdirname = os.path.join(os.path.join(bc.be.sourcedir, bc.getGitCloneDirectory(brl.giturl, brl.commit)), brl.dirpath)
+                localdirname = os.path.join(bc.getGitCloneDirectory(brl.giturl, brl.commit), brl.dirpath)
                 if path.startswith(localdirname):
                     #logger.warn("-- managed: matched path %s with layer %s " % (path, localdirname))
                     # we matched the BRLayer, but we need the layer_version that generated this br
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 25ce052..aef9b60 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -180,7 +180,7 @@ class LocalhostBEController(BuildEnvironmentController):
         base = components[-2] if components[-1] == "git" else components[-1]
 
         if branch != "HEAD":
-            return "_%s_%s.toaster_cloned" % (base, branch)
+            return os.path.join(self.be.sourcedir, "_%s_%s.toaster_cloned" % (base, branch))
 
 
         # word of attention; this is a localhost-specific issue; only on the localhost we expect to have "HEAD" releases
@@ -239,7 +239,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
         # 3. checkout the repositories
         for giturl, commit in gitrepos.keys():
-            localdirname = os.path.join(self.be.sourcedir, self.getGitCloneDirectory(giturl, commit))
+            localdirname = self.getGitCloneDirectory(giturl, commit)
             logger.debug("localhostbecontroller: giturl %s:%s checking out in current directory %s" % (giturl, commit, localdirname))
 
             # make sure our directory is a git repository
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4d1dcbc..80e6d92 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -195,14 +195,8 @@ class Project(models.Model):
                 dirpath = self.bitbake_version.dirpath)
 
             for l in self.projectlayer_set.all().order_by("pk"):
-                commit = l.layercommit.commit
-                print("ii Building layer ", l.layercommit.layer.name, " at commit ", commit)
-                if l.layercommit.up_branch:
-                    commit = l.layercommit.up_branch.name
-                    print("ii Building layer ", l.layercommit.layer.name, " at upbranch ", commit)
-                if l.layercommit.branch:
-                    commit = l.layercommit.branch
-                    print("ii Building layer ", l.layercommit.layer.name, " at actual_branch ", commit)
+                commit = l.layercommit.get_vcs_reference()
+                print("ii Building layer ", l.layercommit.layer.name, " at vcs point ", commit)
                 BRLayer.objects.create(req = br, name = l.layercommit.layer.name, giturl = l.layercommit.layer.vcs_url, commit = commit, dirpath = l.layercommit.dirpath)
             for t in self.projecttarget_set.all():
                 BRTarget.objects.create(req = br, target = t.target, task = t.task)
-- 
1.9.1


