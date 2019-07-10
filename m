Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail.openembedded.org (Postfix) with ESMTP id 0884F74598
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:21 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id n9so4234584wrr.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kBEiK73xBdlw/bwycOySEYZGic03uCykL1jDL8qOYl4=;
	b=QQs4/x/Y47kz4XKQuDsciECNTiQYB73QGu6wSnTlxGVGC0qqmRa+DJMAhlpkXhCuMc
	hIzR2cGNYlGuzma7FE0uHhioL/vOnLLea6akxkp9Ile87MpiXj688HFD5ScrxqcDlljA
	i9VdmXJOU4o91GyynxKMHsWQr5kt0v69kY6vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kBEiK73xBdlw/bwycOySEYZGic03uCykL1jDL8qOYl4=;
	b=K+3Il/eMIV/JJzhU1zV7ercPQtm71K9kJBpX1oIEj747RM46Gg57bHGtE8xflRnota
	IZG3zxfkUFIEjF7bb0NwGkTfLebNPrfAMDxBBCYteLPjy1P5CO9sW+rbhet0YiHnVhby
	gMewaZdRPchV8oq4qaXCpsWvbeeR5GWZzHyglnsfW3TLM/4EP1lYm9t641MQUYjQuuE1
	NCfRZyvlvxtNGoV7il3Es5IikBPy+pRjjUZoRxf2IodO9+DOcjPLrH0u+GYgshGBbojJ
	NE9VdEYMZO55mark4pqTs7xAY7/y0HTphPkwzQFfN909zSg60QUOGnn1uLx4pnFQlVeV
	aOzg==
X-Gm-Message-State: APjAAAV4EsVGRM/9CW9AlRhbkN+0fbvteoT62dgcMu2zyaRkNBDDXsGc
	WJ8JJUbzbQ/6TJ2vJnFLk4H/6OwILzI=
X-Google-Smtp-Source: APXvYqwsfUMrlysOJQtFmLh5nn3W1B2UV+fkzJfslkBZG3WFyC4J+/pID8kqt94qHVlZ6Bqmpi93Bw==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr247706wrs.93.1562802862455;
	Wed, 10 Jul 2019 16:54:22 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.21
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:53:55 +0100
Message-Id: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 01/26] runqueue: Tweak buildable variable handling in scheduler
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:22 -0000
Content-Transfer-Encoding: 8bit

Work off a copy of the 'buildable' class variable, allowing easier
future code changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 704e309b93..b19b524e77 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -142,7 +142,8 @@ class RunQueueScheduler(object):
         Return the id of the first task we find that is buildable
         """
         self.buildable = [x for x in self.buildable if x not in self.rq.runq_running]
-        if not self.buildable:
+        buildable = self.buildable
+        if not buildable:
             return None
 
         # Filter out tasks that have a max number of threads that have been exceeded
@@ -158,8 +159,8 @@ class RunQueueScheduler(object):
             else:
                 skip_buildable[rtaskname] = 1
 
-        if len(self.buildable) == 1:
-            tid = self.buildable[0]
+        if len(buildable) == 1:
+            tid = buildable[0]
             taskname = taskname_from_tid(tid)
             if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
                 return None
@@ -174,7 +175,7 @@ class RunQueueScheduler(object):
 
         best = None
         bestprio = None
-        for tid in self.buildable:
+        for tid in buildable:
             taskname = taskname_from_tid(tid)
             if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
                 continue
-- 
2.20.1


