Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.215.1588040248985033294
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2020 19:17:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Re+diRJg;
 spf=pass (domain: gmail.com, ip: 209.85.210.172, mailfrom: akuster808@gmail.com)
Received: by mail-pf1-f172.google.com with SMTP id r14so9946834pfg.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2020 19:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hPBpYFzaOvLQFct76DUXmvAZEzodWNkAIz8cHX2nYfU=;
        b=Re+diRJg3PriaXg9cZ1yPAxKRyjAs4/OSEdNZL0MO2rPupcco3rdRpbbNsB51fhgT4
         arTjE4V9BzkKvIzKGg53wyqagfCr1rW902rMq8X3oJrE8b6TQyCLV+0epxOjy5xQNvF5
         luaYNP1Sg1eYgxwwWrjPr6Pm/hOoM6oxJjYalTpewq5aR6+aB8nZNLOF5TBeplWHvOrF
         lylZhnNrKgVRmsyyTFfjmAK2D+7CXhtD49STUa8iodgyL6poWGJ8I6aLjPdeQBueo0ia
         593j9TeZFiYiy2VtdmBqgr2NhvqE+z4gQMoxVOdf7YmUQcfz4SJiBTfQbaFh1t1lY3Gg
         N5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hPBpYFzaOvLQFct76DUXmvAZEzodWNkAIz8cHX2nYfU=;
        b=VplA+eGK5hmOZmN/ebglX2TyLqOTy0jXPvk2NZf29bXQpDsLSobZ5+RDkPjEOqZ+mz
         q5vaCO5wgJ9ViBCcqbZ8rBVJXJt6PNqp8i/L7zMO2TmRl3aqjkwBwP1CgWUo4LqbLoEF
         c6emJrVMGBFWRgiTx/igkKxDAtts/5iv21OTFQxAMNIshk7RJQDI4Nw3kY+4qDGhTvRu
         hBR8s4J8j3Vbpxp57h87wa6ZUkzGjp5scn1EUdLNDXd46G/Q5wuiPcieL+hiRiwgOgMH
         hdr9PDHC+0J6XBzzMGDGmWUinJ971dKQs1+Dkz+ESLTAFFD+/PM7iW5stLoOFcRh+uZL
         frZA==
X-Gm-Message-State: AGi0PubF3ud4yc7SJvYEGec2zG/H12Ae38YSpRi0vpk4wt+6V6eCLGwt
	lIKnRU3dVB4RX0Jc8qlgcvUatBPE
X-Google-Smtp-Source: APiQypLMhAUJPTPFQzsNnCxIPwOZTQWvViMt1GKNaqt5622UK4CvdZxewpqWGIwKajPBi6kFak2EiA==
X-Received: by 2002:aa7:991e:: with SMTP id z30mr28109259pff.243.1588040248128;
        Mon, 27 Apr 2020 19:17:28 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:f1bf:759e:e8cd:49cd])
        by smtp.gmail.com with ESMTPSA id c63sm9820866pfc.2.2020.04.27.19.17.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 19:17:27 -0700 (PDT)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.44 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
Date: Mon, 27 Apr 2020 19:17:22 -0700
Message-Id: <282920d985d63db6f2284718dc3db2196c6fbf6f.1587931627.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587931627.git.akuster808@gmail.com>
References: <cover.1587931627.git.akuster808@gmail.com>

From: Peter Kjellerstedt <pkj@axis.com>

Mark any keys used to cache the srcrevs for a recipe as "dontcache" if
BB_DONT_CACHE is set for the recipe. Remove any such keys upon the
next bitbake run even if BB_SRCREV_POLICY is set to "cache". This will
make sure the srcrev is updated as expected if ${AUTOREV} is used.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ba093a38539960e645e994a66ed7872a604c00a9)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/__init__.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 14005492..397367f3 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -498,6 +498,11 @@ def fetcher_init(d):
     srcrev_policy = d.getVar('BB_SRCREV_POLICY') or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
+        # We still need to remove keys that are marked with "dontcache".
+        for key in list(revs.keys()):
+            if key.startswith("dontcache-"):
+                logger.debug(1, "Removing SRCREV key: %s" % key)
+                revs.pop(key)
     elif srcrev_policy == "clear":
         logger.debug(1, "Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
         revs.clear()
@@ -717,9 +722,8 @@ def subprocess_setup():
     signal.signal(signal.SIGPIPE, signal.SIG_DFL)
 
 def get_autorev(d):
-    #  only not cache src rev in autorev case
-    if d.getVar('BB_SRCREV_POLICY') != "cache":
-        d.setVar('BB_DONT_CACHE', '1')
+    # Do not cache the srcrev in the autorev case
+    d.setVar('BB_DONT_CACHE', '1')
     return "AUTOINC"
 
 def get_srcrev(d, method_name='sortable_revision'):
@@ -1562,7 +1566,13 @@ class FetchMethod(object):
         return True, str(latest_rev)
 
     def generate_revision_key(self, ud, d, name):
-        return self._revision_key(ud, d, name)
+        key = self._revision_key(ud, d, name)
+        if d.getVar('BB_DONT_CACHE'):
+            # Mark the key so it can be removed on the next bitbake run even if
+            # BB_SRCREV_POLICY is "cache".
+            return "dontcache-%s" % key
+        else:
+            return key
 
     def latest_versionstring(self, ud, d):
         """
-- 
2.17.1

