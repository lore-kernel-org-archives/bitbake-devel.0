Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id AE9027F338
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:53 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id g17so77579703wrr.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=ZbrtOqyH1A79RMWwZNvv4amcsns5a1Ha9odYdWNZllY=;
	b=OVmAq5LiECgAorfh9md4/85CQ/jJkYXK8aQjDz7Sbr/tlumUAXzSmHlf5pxadkNKdm
	JJeJrE3hplsltCjwpry8R9OFx6aSf6TLEaxYYZCcAcAk4SXFCnyQwrTnYVGPsrw7Duv7
	lbhZa43qviw1hUxKmuy9f+0Wies+HSG52RWuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZbrtOqyH1A79RMWwZNvv4amcsns5a1Ha9odYdWNZllY=;
	b=QA7bIC0zt0ztMWCMj18VMlr6f5kMkjrrz7B0IyJYjJgxj+BI3f7V4mFWM234dUY2UH
	faJY8zcNe2UJ8PCitbBUv8Ncg9coohXSP6pEI+9uw66wrwNA2Nim1bjloYkvAw1Cn5f8
	AihhJfk2rvqugMK5L39GcFWk0V28asuhI8Wo46rZk4AImNUSB7HzdRYZiS2dSSwuxn9W
	cwzdJyn1B0V0CYZUONAAP51mLYBwOfgfEwkpJyA66dOqzUQgdROusuubwTVIgvwQ1R2m
	CWg+b6VRKTauvkMEXSXQO/0ccaHBfEmCBi38cMf9VS7w0RwMkCU+k7BeRfRQTNtMEeuU
	KgRA==
X-Gm-Message-State: APjAAAUre3heqQm90CTsSbnPpQqGhk1rMznLWqslNA9nISSj+INUz/3Q
	wjdBeWJBAYjZJY56ehWjS6j3vJBkAA4=
X-Google-Smtp-Source: APXvYqzaAmzgaY/3tPyANdsv/fumRdyu2DyfQ3msxzTdFP37SrRNrcQaCSSw3nGQZdjvCzHuEoVqbw==
X-Received: by 2002:adf:fa49:: with SMTP id y9mr19201462wrr.6.1564759253078;
	Fri, 02 Aug 2019 08:20:53 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:36 +0100
Message-Id: <20190802152049.16529-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 03/16] runqueue: Improve scenequeue processing logic
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
X-List-Received-Date: Fri, 02 Aug 2019 15:20:54 -0000
Content-Transfer-Encoding: 8bit

Rather than a special copy of the data structure which we change, compute
the logic using set operations from other data we have. This means
we can add tasks back into the scenequeue without having to worry about
reversing operations on this variable with all the potential bugs that
might involve.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6a2de240cc..9883a982c2 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2206,12 +2206,9 @@ class RunQueueExecute:
                 logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
-            if task not in self.sqdata.sq_revdeps2[dep]:
-                # May already have been removed by the fail case above
-                continue
-            self.sqdata.sq_revdeps2[dep].remove(task)
-            if len(self.sqdata.sq_revdeps2[dep]) == 0:
-                self.sq_buildable.add(dep)
+            if self.sqdata.sq_revdeps[dep].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+                if dep not in self.sq_buildable:
+                    self.sq_buildable.add(dep)
 
         next = set([task])
         while next:
@@ -2377,8 +2374,6 @@ class SQData(object):
         self.sq_deps = {}
         # SceneQueue reverse dependencies
         self.sq_revdeps = {}
-        # Copy of reverse dependencies used by sq processing code
-        self.sq_revdeps2 = {}
         # Injected inter-setscene task dependencies
         self.sq_harddeps = {}
         # Cache of stamp files so duplicates can't run in parallel
@@ -2537,7 +2532,6 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     #    bb.warn("Task %s_setscene: is %s " % (tid, data))
 
     sqdata.sq_revdeps = sq_revdeps_squash
-    sqdata.sq_revdeps2 = copy.deepcopy(sqdata.sq_revdeps)
     sqdata.sq_covered_tasks = sq_collated_deps
 
     # Build reverse version of revdeps to populate deps structure
-- 
2.20.1


