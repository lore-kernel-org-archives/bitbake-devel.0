Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id D79CE71B49
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:34 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id g23so110525480wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=QzzY8knFTmioedhFTLNG0P7rZMoJzv3su6ofYBLf/m4=;
	b=wy5ypIrIyrYN3uJbzoOh10Dum0DRrfoi+RHl4n4B58qu3JEWS7qUfVyM+9o/3zqoi4
	FnWYQuh7HB9IK/K6nQE9C9KY2qem6kZLZWyhnwuyfRahmmHr83FTp8t8XEDJ6OGbBXQn
	LHlXfhWptIp4MHeCGVazPoQTpXQPSOAMpiPPzNDj9sV3Sb/QkN28r4N97lEWhqwNhL0g
	P70PsoKmyDS7ckk0mJkwVed0490i5gym5Vqx6haVqq9LAAi2QSm+mgOjLC9Ur09WGzwV
	K/SHoOn055nM275dAtvSADa/uG8yTie4ueKCsi6VUhcJKKJp/qKZBgv4f6H6fnRH1PC2
	GeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QzzY8knFTmioedhFTLNG0P7rZMoJzv3su6ofYBLf/m4=;
	b=XKWaugYCgKox0ewuI/URFRoXPsZh/9g3XKLDChmSaVeb5omEYZgvn9YXvSYLuJv2cS
	R0xdK+lobML8IVr2q1ZMkry8tBx+WE44XU1BkZ5ReGbMpfm+6udH9dOZzGazaiI13WA5
	I4qZqZPQUqCsNeFc1ZkLRPRFn5IBFbk22O852FLFvxQIUtcHfc9AjC6jVeEpMJTQBMl/
	STlEwE9Nl9RzQWL7STGMd91ls5ahG6ddMBENXDmLIB74jU7eBb1xEPHz3u2EuRiSsOvA
	UoFPChX0TvL9HiSnmUHMgRElkRs/yQnudadys18Hyxqaw+d/h3vY6dMMcH6BaZ4B00I6
	ODhA==
X-Gm-Message-State: AKaTC01piuDaNorKoE/feGPkbG0adfRV2thiYrVqYVReXN/ouLcYduFZ7TuSOcJSgQ9VzEzF
X-Received: by 10.28.103.134 with SMTP id b128mr1758988wmc.54.1479986435601;
	Thu, 24 Nov 2016 03:20:35 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:35 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:20:05 +0000
Message-Id: <1479986406-4657-15-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 14/15] toaster: buildinfohelper fix _get_layer_version_for_dependency
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

This function is simplified by not trying to handle replacing the regex
and just compiling and using it for matching.

- Fix typo in logger output with undefined variable
- Fix pyflake errors

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 43a1411..63c779e 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -965,9 +965,10 @@ class BuildInfoHelper(object):
         return task_information
 
     def _get_layer_version_for_dependency(self, pathRE):
-        """ Returns the layer in the toaster db that has a full regex match to the pathRE.
-        pathRE - the layer path passed as a regex in the event. It is created in
-          cooker.py as a collection for the layer priorities.
+        """ Returns the layer in the toaster db that has a full regex
+        match to the pathRE. pathRE - the layer path passed as a regex in the
+        event. It is created in cooker.py as a collection for the layer
+        priorities.
         """
         self._ensure_build()
 
@@ -975,19 +976,26 @@ class BuildInfoHelper(object):
             assert isinstance(layer_version, Layer_Version)
             return len(layer_version.local_path)
 
-        # we don't care if we match the trailing slashes
-        p = re.compile(re.sub("/[^/]*?$","",pathRE))
-        # Heuristics: we always match recipe to the deepest layer path in the discovered layers
-        for lvo in sorted(self.orm_wrapper.layer_version_objects, reverse=True, key=_sort_longest_path):
-            if p.fullmatch(lvo.local_path):
+        # Our paths don't append a trailing slash
+        if pathRE.endswith("/"):
+            pathRE = pathRE[:-1]
+
+        p = re.compile(pathRE)
+        # Heuristics: we always match recipe to the deepest layer path in
+        # the discovered layers
+        for lvo in sorted(self.orm_wrapper.layer_version_objects,
+                          reverse=True, key=_sort_longest_path):
+            if p.fullmatch(os.path.abspath(lvo.local_path)):
                 return lvo
             if lvo.layer.local_source_dir:
-                if p.fullmatch(lvo.layer.local_source_dir):
+                if p.fullmatch(os.path.abspath(lvo.layer.local_source_dir)):
                     return lvo
-        #if we get here, we didn't read layers correctly; dump whatever information we have on the error log
-        logger.warning("Could not match layer dependency for path %s : %s", path, self.orm_wrapper.layer_version_objects)
-
 
+        # if we get here, we didn't read layers correctly;
+        # dump whatever information we have on the error log
+        logger.warning("Could not match layer dependency for path %s : %s",
+                       pathRE,
+                       self.orm_wrapper.layer_version_objects)
 
     def _get_layer_version_for_path(self, path):
         self._ensure_build()
-- 
2.7.4


