Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id 8A014739C7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:38 +0000 (UTC)
Received: by pdbni2 with SMTP id ni2so105050633pdb.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=TGV8zM1rog+pZwrQawYqTI7mfcRT8L/meBvL/i8+dSw=;
	b=JJ6h3O3bvJomaX++k4CnZOuhIM24xKYdCDERDIUHXVEdceW+WZu/IA67xoOjkE4zLi
	ZQgOz5m9MsAWuNJmGV0JYKP2nPrPBuKMWaHdHUJYj+eZNkwTgEXwlWa2cuFtduQbAki/
	S/zpXSPEfVDvFbC0uumtX5WlsbunwRdy3p6v4xHiCxKQNsDb+PXxqdVBmaor63e+jJXD
	1Xws86m0KyMtlNqwtP8w3Sabxot7GuaLm5W4GQjr0JyvQNfQZ/IG4t7YFziEXHY1bpk9
	8Kh+me6dXEuUoYaR9uUsoeirZbmzRctljp7WFwV0/Q7B2x5YFSCd7ZGOfxs3gNSS3+6V
	KUyw==
X-Gm-Message-State: ALoCoQlEAAfQVjeLkUh05HH10F0En1Ovav+F6rPmrBsE7W5yL/C34Ax6A3LLBC9FwjiXweMWcIjw
X-Received: by 10.70.103.230 with SMTP id fz6mr146476471pdb.45.1426847139807; 
	Fri, 20 Mar 2015 03:25:39 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dl1sm7352169pdb.75.2015.03.20.03.25.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:38 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B56FE56436F; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:25 +0000
Message-Id: <6602c1b21fe5a8c0f4da8afdf904f8afb3057c9c.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 08/14] toastergui: recipe and layer identification
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the recipe and layer identification by path
when Toaster uses relative paths.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 06a4490..64bd94e 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -287,9 +287,13 @@ class ORMWrapper(object):
             buildrequest = BuildRequest.objects.get(pk = br_id)
             for brl in buildrequest.brlayer_set.all():
                 localdirname = os.path.join(bc.getGitCloneDirectory(brl.giturl, brl.commit), brl.dirpath)
-                logger.warn("Matched %s to BRlayer %s" % (pformat(layer_information["local_path"]), localdirname))
+                # we get a relative path, unless running in HEAD mode where the path is absolute
+                if not localdirname.startswith("/"):
+                    localdirname = os.path.join(bc.be.sourcedir, localdirname)
+                #logger.debug(1, "Localdirname %s lcal_path %s" % (localdirname, layer_information['local_path']))
                 if localdirname.startswith(layer_information['local_path']):
                     # we matched the BRLayer, but we need the layer_version that generated this BR; reverse of the Project.schedule_build()
+                    #logger.debug(1, "Matched %s to BRlayer %s" % (pformat(layer_information["local_path"]), localdirname))
                     for pl in buildrequest.project.projectlayer_set.filter(layercommit__layer__name = brl.name):
                         if pl.layercommit.layer.vcs_url == brl.giturl :
                             layer = pl.layercommit.layer
@@ -297,7 +301,7 @@ class ORMWrapper(object):
                             layer.save()
                             return layer
 
-            raise Exception("Unidentified layer %s" % pformat(layer_information))
+            raise NotExisting("Unidentified layer %s" % pformat(layer_information))
 
 
     def save_target_file_information(self, build_obj, target_obj, filedata):
@@ -703,6 +707,9 @@ class BuildInfoHelper(object):
             # Heuristics: we match the path to where the layers have been checked out
             for brl in sorted(BuildRequest.objects.get(pk = br_id).brlayer_set.all(), reverse = True, key = _slkey_managed):
                 localdirname = os.path.join(bc.getGitCloneDirectory(brl.giturl, brl.commit), brl.dirpath)
+                # we get a relative path, unless running in HEAD mode where the path is absolute
+                if not localdirname.startswith("/"):
+                    localdirname = os.path.join(bc.be.sourcedir, localdirname)
                 if path.startswith(localdirname):
                     #logger.warn("-- managed: matched path %s with layer %s " % (path, localdirname))
                     # we matched the BRLayer, but we need the layer_version that generated this br
@@ -775,7 +782,10 @@ class BuildInfoHelper(object):
         layerinfos = BuildInfoHelper._get_data_from_event(event)
         self.internal_state['lvs'] = {}
         for layer in layerinfos:
-            self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)] = layerinfos[layer]['version']
+            try:
+                self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)] = layerinfos[layer]['version']
+            except NotExisting as nee:
+                logger.warn("buildinfohelper: cannot identify layer exception:%s " % nee)
 
 
     def store_started_build(self, event):
@@ -886,6 +896,9 @@ class BuildInfoHelper(object):
 
             recipe_information = self._get_recipe_information_from_taskfile(taskfile)
             try:
+                if recipe_information['file_path'].startswith(recipe_information['layer_version'].layer.local_path):
+                    recipe_information['file_path'] = recipe_information['file_path'][len(recipe_information['layer_version'].layer.local_path):].lstrip("/")
+
                 recipe_object = Recipe.objects.get(layer_version = recipe_information['layer_version'],
                             file_path__endswith = recipe_information['file_path'],
                             name = recipename)
-- 
1.9.1


