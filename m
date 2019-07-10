Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id CC0B17F023
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:38 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c2so1024185wrm.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=hJ8FoA7SIPvHM9Oft1GU218yEZW785lg7/OIhVVvHTs=;
	b=T8tM91/2c2lrS6Vxx8GLDzeg+5VUubs0GbOy22VgA8Iqcj+W8U8SzcD/SvhOqzBOx6
	0zbJ79j5cm0ouvCuXMCzQJizfu5Z/hgktKHByAV3PzbUlA71K0Q1iVMgLcgf5pkNHuuw
	k/JmlfF6E3ML1sMZNQvB2xCtvYrGlXSoP0sfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hJ8FoA7SIPvHM9Oft1GU218yEZW785lg7/OIhVVvHTs=;
	b=VNAM/dZRaogqcZGxrdhcZPhooKZnVSrVkC5O6iz1igndbKMVGsAUH2fu6quNX/au9e
	OBLZQ1ani5vQegvtgv0Ulm3W7m9UHC1xfqRHkYNuS5zmVecllvPoP8ms8f5slZ06TWdS
	max8X3mS9uKxgm2uVviSl3Ju20LtL4VMGdJpXSYp72s6Mh+v5mXn7y+MzKfLWHo0rM5A
	QJz7gkfF847S/IAZYU0wSpjG6JJQILcrwbWjUw73PL86gmT0RXUFjvsZJnA1k+RADxDD
	Q+V99xoD8HBIbXp6XJ0BWzvcjR2X/jNM3BCYhH5u5JvFCveJP4Md6LIgOIFUrglKYmb2
	E7yA==
X-Gm-Message-State: APjAAAWzVthmdcf1xf9bbwy468z67fXMiy1zcMWGNB84PysdxVEs0RhE
	hjWuiVH8NdcAWeWyt72H6lF6o7mF8JY=
X-Google-Smtp-Source: APXvYqz13bdmuzATluBo5aIJ0zSPKdRY3inDYfbiRmUhIxpg3cbTXXirsv+Kk4sGGdqrpISHriEBSA==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr252159wrw.138.1562802879198; 
	Wed, 10 Jul 2019 16:54:39 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:13 +0100
Message-Id: <20190710235420.23825-19-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 19/26] runqueue: Remove pointless variable
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:39 -0000
Content-Transfer-Encoding: 8bit

Its now clear a variable is pointless, remove it and tweak the logic
so the data structure of the existing variable matches what we need.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 13e90e709a..97c825a546 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2276,7 +2276,6 @@ class SQData(object):
 def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     sq_revdeps = {}
-    sq_revdeps_new = {}
     sq_revdeps_squash = {}
     sq_collated_deps = {}
 
@@ -2291,7 +2290,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     endpoints = {}
     for tid in rqdata.runtaskentries:
         sq_revdeps[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
-        sq_revdeps_new[tid] = set()
+        sq_revdeps_squash[tid] = set()
         if (len(sq_revdeps[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
             #bb.warn("Added endpoint %s" % (tid))
             endpoints[tid] = set()
@@ -2318,21 +2317,21 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
             tasks = set()
             if task:
                 tasks |= task
-            if sq_revdeps_new[point]:
-                tasks |= sq_revdeps_new[point]
+            if sq_revdeps_squash[point]:
+                tasks |= sq_revdeps_squash[point]
             if point not in rqdata.runq_setscene_tids:
                 for t in tasks:
                     sq_collated_deps[t].add(point)
-            sq_revdeps_new[point] = set()
+            sq_revdeps_squash[point] = set()
             if point in rqdata.runq_setscene_tids:
-                sq_revdeps_new[point] = tasks
+                sq_revdeps_squash[point] = tasks
                 tasks = set()
                 continue
             for dep in rqdata.runtaskentries[point].depends:
                 if point in sq_revdeps[dep]:
                     sq_revdeps[dep].remove(point)
                 if tasks:
-                    sq_revdeps_new[dep] |= tasks
+                    sq_revdeps_squash[dep] |= tasks
                 if len(sq_revdeps[dep]) == 0 and dep not in rqdata.runq_setscene_tids:
                     newendpoints[dep] = task
         if len(newendpoints) != 0:
@@ -2363,9 +2362,11 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     # Sanity check all dependencies could be changed to setscene task references
     for taskcounter, tid in enumerate(rqdata.runtaskentries):
         if tid in rqdata.runq_setscene_tids:
-            sq_revdeps_squash[tid] = set(sq_revdeps_new[tid])
-        elif len(sq_revdeps_new[tid]) != 0:
+            pass
+        elif len(sq_revdeps_squash[tid]) != 0:
             bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
+        else:
+            del sq_revdeps_squash[tid]
         rqdata.init_progress_reporter.update(taskcounter)
 
     rqdata.init_progress_reporter.next_stage()
-- 
2.20.1


