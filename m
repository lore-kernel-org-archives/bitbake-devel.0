Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 8F6D2601F6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 16:55:37 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id p190so23771400wmp.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=nqeBeHy+2rh40/UObf2rHdhly50+gtu3aqjjFHJrOjU=;
	b=z9NtcfxZPbAOfPUZoPRW3WLT7qi7vxt6GmPYRvZbSSxUVs1pnH6uUuUTlboUSRc/7G
	pGS+QaBqnMYi8bgaOjXrfNHq0iUFitaCU/8vWC/GJMdJBtgEGtXFQEu+v36vfGTprPJg
	pje1+/zv12zQwqY8IskYfKog7S7kAf0w+E04ea5wgLMw7B5MOZ5Fap4YS8ENFDYmWTAI
	xUVJsd5T8YqJms6wNcIcS+Kft9myV1N6YUjHwjw8kaJmqK2zoE/9TPs4ul4x5wYIN/h+
	HdvzUsDSYs8d/APReoQFitvivoKWH48F1iYndZ2On+9yDsnkwaDjnmtfZAm1UoqDVVph
	XLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=nqeBeHy+2rh40/UObf2rHdhly50+gtu3aqjjFHJrOjU=;
	b=Jeb/LomLKAZAq8C1MuZ0p/bRRdAb5XSUaFamjIwNYc6ptP8WZ7rUhHreYTEK+t94xd
	l1Dj4v08bLxX0/JYBu0Zm7CMamuSPjLMAfWrjEyueXN1JoDa1u9fhsvutXlPJjc9zjM1
	hAvPSJ5Bk8aFCcFOuDycS9b+irr+O9uDNxcBp7h5vnWMQk34Ugho0YeSyKsQ8W85hJGy
	37SZBo4huXwcnw0jMvFnfnGWYfyCQLJSTLYqcAYQ4/D0oPpas+psidLCw4NbtXOP2IRI
	oeGQdgN4iEj+SoUyxEGtQMcXAK/PESQa3+fFrlJ5hfZdweb6AGTAPDu4K0wLpthoCp+u
	XiFA==
X-Gm-Message-State: ABUngvehJM07/q4UoQcbFY/TBriiupuwgRep+lgb64yywL+nqLTD2XEIsyXgh8A/lPWH0reO
X-Received: by 10.28.152.78 with SMTP id a75mr4272097wme.56.1477673737571;
	Fri, 28 Oct 2016 09:55:37 -0700 (PDT)
Received: from orion.ger.corp.intel.com
	(host31-48-249-102.range31-48.btcentralplus.com. [31.48.249.102])
	by smtp.gmail.com with ESMTPSA id
	194sm9752470wmj.20.2016.10.28.09.55.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 28 Oct 2016 09:55:37 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 17:55:34 +0100
Message-Id: <1477673734-5681-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH][1.32/morty] toaster: buildinfohelper Handle regex paths
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
X-List-Received-Date: Fri, 28 Oct 2016 16:55:42 -0000

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


