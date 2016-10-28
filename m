Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f179.google.com (mail-pf0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 90B0F607A3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 16:53:08 +0000 (UTC)
Received: by mail-pf0-f179.google.com with SMTP id 197so40310909pfu.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=nqeBeHy+2rh40/UObf2rHdhly50+gtu3aqjjFHJrOjU=;
	b=aWu3vkcbqh/k489tx3zp8g5MOv2VGpjAXfwG8SIFX3Z6zI8xdhwgEcr1dakAND8rql
	FY0SnZmGuqrCKblLnVl5od3IAQ4yrbNf8F06stHTHqnVQXBaaUiHGIZ+esLqn5hu4Pv0
	I4wQNNSUmg15YdnAaStN8DXliZEAOsxwheJYv/utjFcIECJxS84X7Bt0YHxO4KZiUFlG
	mnwxboH7QB00lp/0dhkHC0S0eoJHBPbv9M985gsfCDOLwnll/FwUsI0YNq1+cxWXiMgo
	48Fw61VQsmqUp3Rd/KBzJRpyCmZZ4G9KUnxA1DNRWB27M0IkRbxemJXUTbOpSOnJ+y2j
	3eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=nqeBeHy+2rh40/UObf2rHdhly50+gtu3aqjjFHJrOjU=;
	b=LZFjeCGVv0JtLNuTeGuFQgDrVkfzYMAqMdfCQemndeMsV0gEsi57qBBSIWoMlDHQ/k
	GgYBTD3RtlWg35DoAn+hhbsSGtno73KS9aT++CH3vj9B5hh0uuEFv/FTCqN0bFw2BnZH
	FxfggIU+HlwyXOA5Jo2YiLV0aH5vvfTzR1pZWzfTcoFWsRtCyOiej99fyikl5YsTwPUc
	UPhSx214nD04H/iG+WbdwAulhmAhtSmOmLBzOxzR90dyWbP9wDvWySO66vKi0AhxDXQQ
	uBRHeuqYqv17OO8whNseyi9CFZA6WL6UM5CsGQQgoCR0Jffibcweuh6Ra+ScLG4md/aH
	8VCQ==
X-Gm-Message-State: ABUngvc5mMvMUk1EV3rYDJ6BPPy+rZT0gGM7n/PG8y02F1hW7gwm2Qsq9PxDXy1JZ0rhySm+
X-Received: by 10.98.8.130 with SMTP id 2mr26325979pfi.54.1477673590067;
	Fri, 28 Oct 2016 09:53:10 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.55.41])
	by smtp.gmail.com with ESMTPSA id
	x196sm1900396pfd.61.2016.10.28.09.53.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 28 Oct 2016 09:53:09 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 17:52:51 +0100
Message-Id: <1477673571-5503-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH] toaster: buildinfohelper Handle regex paths
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
X-List-Received-Date: Fri, 28 Oct 2016 16:53:10 -0000

From: brian avery <brian.avery@intel.com>

We were presuming that all the layer dependency information was of the
form "^/path/to/layer" to we were just stripping the leading "^" off of
the layer information when we were matching the layer priorities to the
toaster database.  This patch splits out the priorities layer match which
gets a  regex from the task/recipe match which is gets a path.

Signed-off-by: brian avery <brian.avery@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 5b69660..3ddcb2a 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -982,6 +982,31 @@ class BuildInfoHelper(object):
             pass
         return task_information
 
+    def _get_layer_version_for_dependency(self, pathRE):
+        """ Returns the layer in the toaster db that has a full regex match to the pathRE.
+        pathRE - the layer path passed as a regex in the event. It is created in
+          cooker.py as a collection for the layer priorities.
+        """
+        self._ensure_build()
+
+        def _sort_longest_path(layer_version):
+            assert isinstance(layer_version, Layer_Version)
+            return len(layer_version.local_path)
+
+        # we don't care if we match the trailing slashes
+        p = re.compile(re.sub("/[^/]*?$","",pathRE))
+        # Heuristics: we always match recipe to the deepest layer path in the discovered layers
+        for lvo in sorted(self.orm_wrapper.layer_version_objects, reverse=True, key=_sort_longest_path):
+            if p.fullmatch(lvo.local_path):
+                return lvo
+            if lvo.layer.local_source_dir:
+                if p.fullmatch(lvo.layer.local_source_dir):
+                    return lvo
+        #if we get here, we didn't read layers correctly; dump whatever information we have on the error log
+        logger.warning("Could not match layer dependency for path %s : %s", path, self.orm_wrapper.layer_version_objects)
+
+
+
     def _get_layer_version_for_path(self, path):
         self._ensure_build()
 
@@ -1372,7 +1397,7 @@ class BuildInfoHelper(object):
         if 'layer-priorities' in event._depgraph.keys():
             for lv in event._depgraph['layer-priorities']:
                 (_, path, _, priority) = lv
-                layer_version_obj = self._get_layer_version_for_path(path[1:]) # paths start with a ^
+                layer_version_obj = self._get_layer_version_for_dependency(path)
                 assert layer_version_obj is not None
                 layer_version_obj.priority = priority
                 layer_version_obj.save()
-- 
2.7.4


