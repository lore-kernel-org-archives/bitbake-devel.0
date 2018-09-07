Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id BC39A60596
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Sep 2018 16:47:07 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id r1-v6so48808wmh.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Sep 2018 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=BiC/ESHXa0mKIVVkI/0kBluTm8iTioMJiSogLjHGrVk=;
	b=XntLdfJ/C5Kfac03YIl7rSEF4d+RyJ3InQYClGJI0pYH/oE0qlYHXGEUYPXYolZAiI
	4brrFCI6YxyDKzOEjxFtjiFe9c69H87TjAUecOYUhwQ8Kimd56SySZ81+dR3WAbG3PXr
	/OGkjR4UX+HU0XTeTo/cMvIeBtiFrfJ8/XYLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=BiC/ESHXa0mKIVVkI/0kBluTm8iTioMJiSogLjHGrVk=;
	b=kKJUGR1FO87TtqMY2l8QyOuyGpGD/nKOVVmx8/rVacH+eqKPe32aQZRtIABRNKC7PK
	v7MHjEbBVY8RVlNUERwQoP1+5SoEW+nrKpdU2ZlzxvSD456uIAONMnuGeqoevHWd6Qdq
	oAiEyVjUkGr6p3pFkwnEJfuL+Rs9fyJgKGG/2nSvoMq5Rdd0duuEzM5rIHcGDa8Z4//D
	8zFOdu1Cxoi6521JuM6cnifKiN4tuUW05RPPdYExTwgNp/FDAOUBPRjtOBuawVrGsrC0
	dFTYYK7YLfBdKJZ/jEVps1V3wKHWpHrEpLJYHkqR06Q8v0pJC8eN0fGIMzFLRYEcbfOK
	govw==
X-Gm-Message-State: APzg51DJpC23IhJqWL7eRHEC8q3UchYw8MSEZKzz/vFmHd9mYJFou7VT
	4GbNxj/60Qm39R8IoEBVUQFoSSqMsMI=
X-Google-Smtp-Source: ANB0VdZcGFl2C9f0qZ4prVPbsXHag0EC/irF8fMIhxZ4wqW7Yc/k3P7QqqGHLSa9k5Y32dda4Yu0gw==
X-Received: by 2002:a1c:be06:: with SMTP id o6-v6mr5768308wmf.65.1536338828214;
	Fri, 07 Sep 2018 09:47:08 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	200-v6sm13807989wmv.6.2018.09.07.09.47.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Sep 2018 09:47:07 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2018 17:47:06 +0100
Message-Id: <20180907164706.21663-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] runqueue: Ensure setscene tasks that aren't covered get built
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
X-List-Received-Date: Fri, 07 Sep 2018 16:47:08 -0000

Running "bitbake gconf-native -c cleansstate; bitbake core-image-sato:do_populate_sdk"

results in a build where it fails to find gconf-native and fails to build it,
merrily trying to build the SDK without gconf being present.

The issue is the missing setscene tasks are effectively ignored as the later
code in runqueue thinks that since other sstate tasks are present, these
'cover' the missing one. In reality we need to call BB_SETSCENE_DEPVALID
to make that decision. To do that we need a "reduced" setscene dependency
graph which we don't have in main task graph context.

Since that was already done in setscene, we should just assume anything
in the non-covered list needs to be built.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 91911aff89..d2e248b1b3 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1831,7 +1831,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             bb.build.del_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
             self.rq.scenequeue_covered.remove(tid)
 
-        toremove = covered_remove
+        toremove = covered_remove | self.rq.scenequeue_notcovered
         for task in toremove:
             logger.debug(1, 'Not skipping task %s due to setsceneverify', task)
         while toremove:
-- 
2.17.1


