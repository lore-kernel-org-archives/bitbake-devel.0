Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id 5CB547CED7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:18 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id 31so111219941wrm.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=nbx/nLuPLjhsitl85vKef8hCxizM4rj8LS4DVnCxdpU=;
	b=D8KxrjWWqTZaDBElxB1rjTCCMY2eQtMVH+Vi+1THYv4ZiuTkOnXYsejl3CurTDP1jv
	o2b/IPyUy2ULh3qQKvnk3vqNBAMqpZ9KdXCDzATyGqMH2hkLXfyDDiYs6uGtC2wekH6Y
	iw60RgiLfzTugCivVxx48isCH8ZcA9QPMEHmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=nbx/nLuPLjhsitl85vKef8hCxizM4rj8LS4DVnCxdpU=;
	b=oRDryzzsLf3I9SWEqgtGn5iBAVfXOvizbkuLURgJJS+cMBjE0CpLL5HHOFbcuzsNAj
	UmthZHNOMUv/BK6CG0tGGkH51RivAqzsDxc8NW14HJ4Q93z69mmjnjgQ8AGzHTL//und
	kAGlqOQ28np0mACg/x91tSuV8oQSCuqv7515cEXbK39RmHQ/vpXucUn8zE8xgkYpzhFp
	Mf16GjM4H8rSV0Y8EF5RT7Ef57m9i3nosLjwDFd74/GR68cQ/pE/hP7rOhyCDd+FJsw5
	4TuXkdY/gRiGIoJdwXAbErE3WS4U8Pt2APkHjly/k0Ffkxe9HI6HtimXbqkL0EK+YpOm
	Zluw==
X-Gm-Message-State: APjAAAV+OoudRLJ0ftRldx61BGx21ylvgQaJCptX58PxBoFPT+yxlvit
	Xe02KPzvCfu80FTYA1xJlp5SCvmSQ6hgbA==
X-Google-Smtp-Source: APXvYqxHV+++ZLCTCxm5/4j8vgvuZJ7CoSCK+Zx61xObCfV8eMkTvcOJ9ZB3Et3ADFNiFxaIG7eVzg==
X-Received: by 2002:adf:f646:: with SMTP id x6mr56155397wrp.18.1565790798582; 
	Wed, 14 Aug 2019 06:53:18 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:18 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:08 +0100
Message-Id: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 01/10] runqueue: Fix corruption issue
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:18 -0000
Content-Transfer-Encoding: 8bit

We need to copy this set, not modify the original else all kinds
of weird and bad things break, mostly from circular references.
We'll not go into how much sleep I lost tracking down the fallout
from this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bb61087359..2bf19b9778 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2124,7 +2124,7 @@ class RunQueueExecute:
     # as most code can't handle them
     def build_taskdepdata(self, task):
         taskdepdata = {}
-        next = self.rqdata.runtaskentries[task].depends
+        next = self.rqdata.runtaskentries[task].depends.copy()
         next.add(task)
         next = self.filtermcdeps(task, next)
         while next:
-- 
2.20.1


