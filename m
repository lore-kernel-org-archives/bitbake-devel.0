Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 442997EF50
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 16:12:25 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id n9so6944899wrr.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=kvTULf1BPhncWc6SIlTWQe6H9HG/0HabcBPG1GLMxII=;
	b=OrXW8D6tThR4xw4UNyI9LjAFwmjoEbVnGqlBSo2hLb60FfsnN9THPeTZ/pKSwFXSsL
	8l1VMxIVOUVw/At2wIL+Vyrg3ULfBQLTr5j9PtwzXxDjXuz4EHbcItupnWwetmRif3gp
	kKIcDTAsFGRvNfKMPOcOvQbOyWtEivybB4lws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kvTULf1BPhncWc6SIlTWQe6H9HG/0HabcBPG1GLMxII=;
	b=HH+4TAAcoVS3wTTSsPiQOmt9OO5FGb++TlmaezOHt2JHHQyBMtggdxlc1/lKPdbokc
	6lwe71wNmONCHCL9l5dPBZ8nG4kqJqQAzdXurb4kC7Gk60gytq3yv2hyRj9iHZ1oa/Jx
	3XFZ6cZQyF+qBVM/AxSwLsEyECpfuTTfZj4S4Q0m05ZPCWbvinNsbiRLJWD6rj7Jxy8F
	NOCPVrRYDnS1e+dhcz26Ho3FHOh4EKe2+q7RZG58exjYEzOC7rSllJD8mluyz+WeY3XN
	Zqf22RksbARbmbymxeZenE902haSn2/ovr+9m1b4hmY+6dXewi8ZdtD8KvRldjo0dKGA
	O9kg==
X-Gm-Message-State: APjAAAUhCU/y/7UYbPnO6exhb8ttKAvLqCMbhBYJWpi4cuWimwJGck+r
	nWIKIBrKUm0dKch8QSGHMAp88ttxPII=
X-Google-Smtp-Source: APXvYqyyF8K6UuMr6NG8qKzDore8P+kbwNTZOfEPOt4bG7T/Caz4O8Vq/TNQj384aPKgj4h9+8gOiQ==
X-Received: by 2002:adf:e843:: with SMTP id d3mr6171329wrn.249.1562861545990; 
	Thu, 11 Jul 2019 09:12:25 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c7sm4841279wro.70.2019.07.11.09.12.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 09:12:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 17:12:20 +0100
Message-Id: <20190711161223.12376-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
References: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/5] runqueue: Streamline outright setscene failure handling
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
X-List-Received-Date: Thu, 11 Jul 2019 16:12:26 -0000
Content-Transfer-Encoding: 8bit

With the recent codebase changes we can just call the outrightfail
function immediately, removing some intermediate data structures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 48b668abc1..2d52ef3190 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1913,9 +1913,6 @@ class RunQueueExecute:
                             self.sq_task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
                             return True
-                    if nexttask in self.sqdata.outrightfail:
-                        self.sq_task_failoutright(nexttask)
-                        return True
                     task = nexttask
                     break
         if task is not None:
@@ -2330,8 +2327,6 @@ class SQData(object):
         self.stamps = {}
         # Setscene tasks directly depended upon by the build
         self.unskippable = set()
-        # List of setscene tasks which aren't present
-        self.outrightfail = []
         # A list of normal tasks a setscene task covers
         self.sq_covered_tasks = {}
 
@@ -2553,7 +2548,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         for tid in sqdata.sq_revdeps:
             if tid not in valid_new and tid not in noexec:
                 logger.debug(2, 'No package found, so skipping setscene task %s', tid)
-                sqdata.outrightfail.append(tid)
+                sqrq.sq_task_failoutright(tid)
 
 class TaskFailure(Exception):
     """
-- 
2.20.1


