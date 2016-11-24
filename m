Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id D6D1E71ABB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:33 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id f82so57232106wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ENY8BilAVxKjY0ogf5iPa7IYO55j0W1e5i2OYEzelug=;
	b=KAU0gzRVxJSFE6DBarWxOwlGEywvVAzGRy3oMmcoC3e2qa4cWbSY0lpEFPPBOdDYFx
	e3LnqZ6elY+XOiSUSF+okyUPFry8nXy5XGbHkE7OnNSuaqVBrpfDqq8a/xMv4MPuJVJt
	TGrkPaNWY2W0njA7OdbqKplS2tzFTHEuRza7zsdZFUd/O1QIo62CUdJNoHBFkqRCNBHM
	Q/fdl6k8GXKeqQCj/hctYBiMMk0dDyEZAOseYmBX+bu8cDBkpRxnwpUvDQDlSjlEdtxN
	kHW9WZ8QMVDgvJnYaoKCZmOHl+sXIAPP3K+vCSJWtjdcn3nH1tCqLBkkEfLsdPUiShv4
	dHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ENY8BilAVxKjY0ogf5iPa7IYO55j0W1e5i2OYEzelug=;
	b=NyXphhWTt03hhMU6abcS7EgS1k1pJ3+e5/Z61PxC8IS8GBZMBZ+QornJZCRJiuuITP
	gy8Ut446nYJaZ+yp1Eixon/b6YSvZEs3gYkD9ZkFTz7ZuiPfPhs/HnLiOdsWnxqXJCoM
	HlGcEptAA/wM07FjmIqILPeo0aqB+fihy33nJ/DW/brVU+FR6akn0i8Bv2vLXiaIGP6i
	JLpyyzJK/w4LeOIc2iwbse/C+DwbD6HQllTY3AM0FH3fq+qXWPz5fSdcViFHewcNYeFI
	nSQHGCGcpaZ0SomdRF2z+TtBmqbaz+NpAgiUq3JxV22hNNU1C374cEmVN7bHaUWW28wo
	p4+Q==
X-Gm-Message-State: AKaTC01GySUiEnZhC0qtfIgkEhe8BlT+xgDzyT/87hU++620x+/63kb21sz/iu6MCAwKJu9H
X-Received: by 10.28.232.85 with SMTP id f82mr1798509wmh.127.1479986434660;
	Thu, 24 Nov 2016 03:20:34 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:33 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:20:04 +0000
Message-Id: <1479986406-4657-14-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 13/15] toaster: buildinfohelper Simplify layer event to toaster layer function
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:35 -0000

Simplify the layer event information to layer version object in toaster
function. Previously this attempted many different methods of trying to
obtain the correct layer from toaster by manipulating the data from the
event or the data from the known layers to try and match them together.

We speed up and simplify this process by making better use of django's
orm methods and by working down the most likely matching methods in order
of accuracy.

[YOCTO #10220]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 69 ++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e96e934..43a1411 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -46,6 +46,8 @@ from orm.models import Project, CustomImagePackage
 from orm.models import signal_runbuilds
 
 from bldcontrol.models import BuildEnvironment, BuildRequest
+from bldcontrol.models import BRLayer
+from bldcontrol import bbcontroller
 
 from bb.msg import BBLogFormatter as formatter
 from django.db import models
@@ -436,48 +438,33 @@ class ORMWrapper(object):
         else:
             br_id, be_id = brbe.split(":")
 
-            # find layer by checkout path;
-            from bldcontrol import bbcontroller
-            bc = bbcontroller.getBuildEnvironmentController(pk = be_id)
-
-            # we might have a race condition here, as the project layers may change between the build trigger and the actual build execution
-            # but we can only match on the layer name, so the worst thing can happen is a mis-identification of the layer, not a total failure
-
-            # note that this is different
-            buildrequest = BuildRequest.objects.get(pk = br_id)
-            for brl in buildrequest.brlayer_set.all():
-                if brl.local_source_dir:
-                    localdirname = os.path.join(brl.local_source_dir,
-                                                brl.dirpath)
-                else:
-                    localdirname = os.path.join(bc.getGitCloneDirectory(brl.giturl, brl.commit), brl.dirpath)
-                # we get a relative path, unless running in HEAD mode where the path is absolute
-                if not localdirname.startswith("/"):
-                    localdirname = os.path.join(bc.be.sourcedir, localdirname)
-                #logger.debug(1, "Localdirname %s lcal_path %s" % (localdirname, layer_information['local_path']))
-                if localdirname.startswith(layer_information['local_path']):
-                  # If the build request came from toaster this field
-                  # should contain the information from the layer_version
-                  # That created this build request.
-                    if brl.layer_version:
-                        return brl.layer_version
-
-                # This might be a local layer (i.e. no git info) so try
-                # matching local_source_dir
-                if brl.local_source_dir and brl.local_source_dir == layer_information["local_path"]:
-                    return brl.layer_version
-
-                    # we matched the BRLayer, but we need the layer_version that generated this BR; reverse of the Project.schedule_build()
-                    #logger.debug(1, "Matched %s to BRlayer %s" % (pformat(layer_information["local_path"]), localdirname))
-
-                    for pl in buildrequest.project.projectlayer_set.filter(layercommit__layer__name = brl.name):
-                        if pl.layercommit.layer.vcs_url == brl.giturl :
-                            layer = pl.layercommit.layer
-                            layer.save()
-                            return layer
-
-            raise NotExisting("Unidentified layer %s" % pformat(layer_information))
+            # Find the layer version by matching the layer event information
+            # against the metadata we have in Toaster
 
+            try:
+                br_layer = BRLayer.objects.get(req=br_id,
+                                               name=layer_information['name'])
+                return br_layer.layer_version
+            except (BRLayer.MultipleObjectsReturned, BRLayer.DoesNotExist):
+                # There are multiple of the same layer name or the name
+                # hasn't been determined by the toaster.bbclass layer
+                # so let's filter by the local_path
+                bc = bbcontroller.getBuildEnvironmentController(pk=be_id)
+                for br_layer in BRLayer.objects.filter(req=br_id):
+                    if br_layer.giturl and \
+                       layer_information['local_path'].endswith(
+                           bc.getGitCloneDirectory(br_layer.giturl,
+                                                   br_layer.commit)):
+                            return br_layer.layer_version
+
+                    if br_layer.local_source_dir == \
+                            layer_information['local_path']:
+                        return br_layer.layer_version
+
+        # We've reached the end of our search and couldn't find the layer
+        # we can continue but some data may be missing
+        raise NotExisting("Unidentified layer %s" %
+                          pformat(layer_information))
 
     def save_target_file_information(self, build_obj, target_obj, filedata):
         assert isinstance(build_obj, Build)
-- 
2.7.4


