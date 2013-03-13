Received: from mail-ea0-f179.google.com ([209.85.215.179])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UFs8A-0007Ny-Fd
	for bitbake-devel@lists.openembedded.org;
	Wed, 13 Mar 2013 21:18:49 +0100
Received: by mail-ea0-f179.google.com with SMTP id f15so618744eak.38
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Mar 2013 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=J1fJIFmzZ3xioXBwK5bTTu3YLFxBIARd1RaHQEI+QtU=;
	b=Ve4td3xOZtxfCCjFIhx20C5fD35ft8TkheJz+hNpop6NBHg8/4uvDdwPdjdvUSpCsL
	c6aEuUlNqXR5hwSbx5WMZrM+Ont8hG7L1V+xOPLJ6hflDVf0dorAMRMDnLCNtV38GVJV
	+KgisbI7S2u0q4PSerqZ02PDodCwCpYd6dh58D1WfW8PS//LDqoJc8rb1uobPfSuTK+p
	bcHHnpFmjQnHuc9BBUE+uNQNSHL6LuBqLVyMeyYUecudeU2jSyWe1Za9R5uqvXunNT6B
	WnyWi4+DjqDvgxfsObRLAqiPVHwPyvoWBRkfanXI04nhq8oPi++SGN7T0Xu0CbU8g/oI
	gAeA==
X-Received: by 10.14.173.67 with SMTP id u43mr62895877eel.22.1363204913384;
	Wed, 13 Mar 2013 13:01:53 -0700 (PDT)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id 3sm38069750eej.6.2013.03.13.13.01.51
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 13 Mar 2013 13:01:52 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 13 Mar 2013 21:01:51 +0100
Message-Id: <1363204911-5012-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.5
Subject: [PATCH] runqueue: Use taskData.fn_index[depdata] instead of uninitialized dep
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 13 Mar 2013 20:18:53 -0000

* dep variable was removed in
  commit 3190cb83e2af195a464f669c5aa8aedbf795160e
  Author: Richard Purdie <richard.purdie@linuxfoundation.org>
  Date:   Wed Jun 27 11:04:06 2012 +0100

    taskdata: Add gettask_id_fromfnid helper function

    This is like gettask_id but doesn't require translation of fnid -> fn
    first which the function then translates back. This gives a sizeable
    performance improvement since a significant number of lookups are avoided.

* now it fails completely instead of showing which task is missing

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1bbe791..872bb78 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -472,7 +472,7 @@ class RunQueueData:
                         if depdata is not None:
                             taskid = taskData.gettask_id_fromfnid(depdata, idependtask)
                             if taskid is None:
-                                bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
+                                bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, taskData.fn_index[depdata]))
                             depends.add(taskid)
                 irdepends = taskData.tasks_irdepends[task]
                 for (depid, idependtask) in irdepends:
@@ -482,7 +482,7 @@ class RunQueueData:
                         if depdata is not None:
                             taskid = taskData.gettask_id_fromfnid(depdata, idependtask)
                             if taskid is None:
-                                bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
+                                bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, taskData.fn_index[depdata]))
                             depends.add(taskid)
 
                 # Resolve recursive 'recrdeptask' dependencies (Part A)
-- 
1.8.1.5



