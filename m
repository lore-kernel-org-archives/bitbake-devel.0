Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 698F17F02A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:35 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id x15so3902264wmj.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=uvTg+LlqShvI89ZcKy58gwFKy386mARGe0BcPPVhjH8=;
	b=Y/yfET3k0vTh80Lgkv8QPFrptivBb9+/1+gj+PuhVupCpMBn6e4bEV81totViLDhM3
	H/C4AXgRpNP+brbQGxYw+fOXnhD2p0uJ1H3GgJlw2JfhkdWKB8jePXFuJgN5dhtXVctN
	NSGidDCxXmPUcjqWZj/LfmctyHhuY8sHIyquA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uvTg+LlqShvI89ZcKy58gwFKy386mARGe0BcPPVhjH8=;
	b=CzGlv/BYHS3mpmq86bMFE/a4re5ujvh6cZ9k6f33Ovm2rpYi+dmzAvzYjDJTwspf+i
	dGJR6Bwe4XfO3baKmWaZsL3iSBgOV7ysxH7p7XA1IYwvz7Y3PNBo0gp2TLUP4CYgQIVA
	oRcA9AS4nhgiq8zpFBGskz3HwCpILIbw2ZIWIYJFUw7cwkmYGugPok4KNBinzJB9hPS1
	Y+5rUYqvDZIOACsMvKVoj8TxYmlDYoEfaw9+gcpGu1K420X36UQR247RBoeOx1IHYL6K
	DxVW2MEaTA6NRjz5VN4PLQW7D/q7OoFhSml7uVU0QzOEUHdiE301LK4JHJqe9lvPiWC1
	yRsg==
X-Gm-Message-State: APjAAAXX84w2PPevq/Q+lE+LFUpjv0EwjPj65zcbYst5HF6unJadeeaA
	Y5dLQGGQy5JWF1bJlDVfxpcZpTJGLvA=
X-Google-Smtp-Source: APXvYqxHh/DHifcwOBAqRTcFCRgjWaiIHtBQjspzpNh4bM3OIb6ZSinyWfYCG7q3jd4tYSZU4q0xTw==
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr273019wmd.131.1562802875810; 
	Wed, 10 Jul 2019 16:54:35 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:09 +0100
Message-Id: <20190710235420.23825-15-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 15/26] runqueue: Add covered_tasks (or 'collated_deps') to scenequeue data
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:35 -0000
Content-Transfer-Encoding: 8bit

Its useful to have a list of all the tasks a given setscene task covers
and we can easily generate this data whilst doing other data processing.

This is used in later changes to runqueue rather than trying to compute it
on the fly which is difficult.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 30b13d54a8..1d7706a219 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2278,6 +2278,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     sq_revdeps = {}
     sq_revdeps_new = {}
     sq_revdeps_squash = {}
+    sq_collated_deps = {}
 
     # We need to construct a dependency graph for the setscene functions. Intermediate
     # dependencies between the setscene tasks only complicate the code. This code
@@ -2299,6 +2300,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     # Secondly process the chains between setscene tasks.
     for tid in rqdata.runq_setscene_tids:
+        sq_collated_deps[tid] = set()
         #bb.warn("Added endpoint 2 %s" % (tid))
         for dep in rqdata.runtaskentries[tid].depends:
                 if tid in sq_revdeps[dep]:
@@ -2318,6 +2320,9 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 tasks |= task
             if sq_revdeps_new[point]:
                 tasks |= sq_revdeps_new[point]
+            if point not in rqdata.runq_setscene_tids:
+                for t in tasks:
+                    sq_collated_deps[t].add(point)
             sq_revdeps_new[point] = set()
             if point in rqdata.runq_setscene_tids:
                 sq_revdeps_new[point] = tasks
@@ -2430,6 +2435,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     sqdata.sq_deps = {}
     sqdata.sq_revdeps = sq_revdeps_squash
     sqdata.sq_revdeps2 = copy.deepcopy(sqdata.sq_revdeps)
+    sqdata.sq_covered_tasks = sq_collated_deps
 
     for tid in sqdata.sq_revdeps:
         sqdata.sq_deps[tid] = set()
-- 
2.20.1


