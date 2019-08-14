Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id C73397E963
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:22 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id 207so4682713wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=JNba+yyJV+szokJYhm0wGw80wi8QfLYKbRLLSLYLTj8=;
	b=WbMYmi7sOrykkxO11MolKIgzU7ouQ3WUCg2FW4MATHTBeQVjpZ9BjAjAlSCZdXA/V1
	hATgsl+Y+I1jMAmappXgtks5CnHFTd1qr6NjeaTmhj+WE1D1Cp01Jn+wT7Q5d2iAdeGe
	5/AfLg/lnxSnXHSn9qSk1JhM2zUPqnJKZulUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JNba+yyJV+szokJYhm0wGw80wi8QfLYKbRLLSLYLTj8=;
	b=bcAMhDcHv4GzeLzUdv5SZUhPTayDT8yoIRR8TnwmDAuAUtdxeYzulQWe/8E2iLfkaE
	+Wc7J3AeE4k0itRgEHT3NaXz4pdMYcCNwofqfvt+ZGZKD7qvEwctgj/mU8rcjck5tbfn
	YMietHAfMzbhLrHxd0Fu2TSisLEBVSC2uaX99uWAPJWMg2UMISRs63DUiBQtzBCrw5MH
	aEJPuA5gZD5pbQgJwQwhe0Y/OR/4ZabfozG8Gf+tENjTxukLDIkXPDeLpIFyYMLsVkrx
	/UOMKlslugZq+aR53SDp68wfhY8STwe9qEWXOSagoXA/e+N98McVMg/TsQXv8Z8l6cOt
	U86g==
X-Gm-Message-State: APjAAAVJOjp4FFnEPMUOjx0sKodp81R1ZF1gzv8dqIOW2VNGfNfvU0Zt
	4UiQaPOPHUchqxzoUTr011miHoNfFL8nYQ==
X-Google-Smtp-Source: APXvYqxCwNsRLNUfzfAlh+KIzg2mStgjpB+C3UebJK09r8a4XtdVj3tdDwZs0PIwVgREufuK6pmhiA==
X-Received: by 2002:a1c:a957:: with SMTP id s84mr8788063wme.65.1565790803357; 
	Wed, 14 Aug 2019 06:53:23 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.22
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:22 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:13 +0100
Message-Id: <20190814135317.28887-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
References: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 06/10] runqueue: Fix next_buildable_task performance problem
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:23 -0000
Content-Transfer-Encoding: 8bit

Looking at the profile information, a lot of time is being spent in
next_buildable_task. This is probably due to the generator expressions
not working well with the empty test.

The easiest way to improve things is to switch to using set manipulations.
We also don't need to update self.buildable the way the original code did
as we don't rely on that anywhere.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9acad7af8e..3bcbaee12a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -133,7 +133,7 @@ class RunQueueScheduler(object):
 
         self.prio_map = [self.rqdata.runtaskentries.keys()]
 
-        self.buildable = []
+        self.buildable = set()
         self.skip_maxthread = {}
         self.stamps = {}
         for tid in self.rqdata.runtaskentries:
@@ -148,8 +148,10 @@ class RunQueueScheduler(object):
         """
         Return the id of the first task we find that is buildable
         """
-        self.buildable = [x for x in self.buildable if x not in self.rq.runq_running]
-        buildable = [x for x in self.buildable if (x in self.rq.tasks_covered or x in self.rq.tasks_notcovered) and x not in self.rq.holdoff_tasks]
+        buildable = set(self.buildable)
+        buildable.difference_update(self.rq.runq_running)
+        buildable.difference_update(self.rq.holdoff_tasks)
+        buildable.intersection_update(self.rq.tasks_covered | self.rq.tasks_notcovered)
         if not buildable:
             return None
 
@@ -167,7 +169,7 @@ class RunQueueScheduler(object):
                 skip_buildable[rtaskname] = 1
 
         if len(buildable) == 1:
-            tid = buildable[0]
+            tid = buildable.pop()
             taskname = taskname_from_tid(tid)
             if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
                 return None
@@ -204,7 +206,7 @@ class RunQueueScheduler(object):
             return self.next_buildable_task()
 
     def newbuildable(self, task):
-        self.buildable.append(task)
+        self.buildable.add(task)
 
     def removebuildable(self, task):
         self.buildable.remove(task)
-- 
2.20.1


