Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
	[209.85.128.47])
	by mail.openembedded.org (Postfix) with ESMTP id 73F0D7F04B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:39 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id v15so3917599wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=8DUvxjmeY8+5eLuJ3LY7KHghTkBL8MhSkITijox7AqY=;
	b=BmPkV7Ygm2O/VkiufmzPSyvd5YqOt9k3jit9DwXNpwJMXgvC4K0rtz/+uO3WolFtnT
	dO/xSxZQNzSHHK/rQDTsc7POU+YNgbeacOcgxljziZ7aD9Xvs1TE1om9DSkfkmjQeQcS
	rXN4/nt4ugO4og9l1tBYDGDxShbvDsoV6ot5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8DUvxjmeY8+5eLuJ3LY7KHghTkBL8MhSkITijox7AqY=;
	b=jpej5zCMhcyuhcY1Ef8JdJUHjukfTYHpAOsx+CmPFvlwRUskseDkSKrjg65/dLDu7v
	4pT0TY4iVjOaMcGOWlw9cAUNL6Kz3ZYdGbMu419hmAa8Kdcpw3WnntYJIH9kGPMyFFK3
	QSgHxRBcVkaxne2MtTAqhk6+22EzEr9JUiFSvjzFaZggRdTO+QqPVzMbfFr4swi0MrWq
	iHilyklr7BIYl0xXgPzpPVZ8McNFonQMUPA9wyyczpPCDLsl8Y5Fe/gorGUcKWsoxVCq
	Er203C52HY5vXuubPbp1mcGk2nxWxLO1xzBSZ6xGjTy+r1aZ0MaQZIY558gsaJ0NzZ9Y
	SzXQ==
X-Gm-Message-State: APjAAAWj7MsEX3V1+i8uzB3KyIE6Lf0R6MFeDDTCcETViNESB4d/5OBa
	kyqez5GUBPiJXIiiRnBz9SPcct7l74I=
X-Google-Smtp-Source: APXvYqx+AL9EDxYMhBjBYQJLoINLluzrfan2M3bnUxjNHqaG8G1/zyEGmj0juSiEfyrzHrHAnlGndA==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr313634wmh.68.1562802880021;
	Wed, 10 Jul 2019 16:54:40 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:14 +0100
Message-Id: <20190710235420.23825-20-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 20/26] runqueue: Further scheduler buildable tasks cleanup
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

The code for setting up buildable tasks can be simplified.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 97c825a546..580323f285 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -196,11 +196,6 @@ class RunQueueScheduler(object):
         if self.rq.can_start_task():
             return self.next_buildable_task()
 
-    def initbuildable(self):
-        for tid in self.rqdata.runtaskentries:
-            if tid in self.rq.runq_buildable:
-                self.buildable.append(tid)
-
     def newbuildable(self, task):
         self.buildable.append(task)
 
@@ -2493,7 +2488,7 @@ def start_runqueue_tasks(rqexec):
         # Mark initial buildable tasks
         for tid in rqexec.rqdata.runtaskentries:
             if len(rqexec.rqdata.runtaskentries[tid].depends) == 0:
-                rqexec.runq_buildable.add(tid)
+                rqexec.setbuildable(tid)
             if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.scenequeue_covered):
                 rqexec.scenequeue_covered.add(tid)
 
@@ -2516,8 +2511,6 @@ def start_runqueue_tasks(rqexec):
         for task in self.rq.scenequeue_notcovered:
             logger.debug(1, 'Not skipping task %s', task)
 
-        rqexec.sched.initbuildable()
-
 class TaskFailure(Exception):
     """
     Exception raised when a task in a runqueue fails
-- 
2.20.1


