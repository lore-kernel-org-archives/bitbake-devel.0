Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail.openembedded.org (Postfix) with ESMTP id 0D92F7E6F8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:24 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id l2so4549370wmg.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=BY3QVNpJJs70crsWuIqJAlI6wa814FdJzezV7XaBdKc=;
	b=cJ05EMDhNxEAEqZE10QdCqFiG8F1amV/F2XNen4vGsDN88ouBorJZo0/RxBP1SEpIZ
	n9he6WOMGHnqbxZGfzD3E3Hx556MfHuDPi3TIgP/s0mT4ELwU4/sXgdPLOEg33kH9Uw7
	SkyX6UJR6cgykmXRpg0kL1YvajZ0tNo1Xh7NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BY3QVNpJJs70crsWuIqJAlI6wa814FdJzezV7XaBdKc=;
	b=oa59lyrXxiOvSjZEVfLGRLPdMJqUbGck0CbbKiNZzFvbBlBWIsDiOU+NUCjrpfd0mn
	WXQjCa7IWRwimbWZp0N+3KHB7V1LLBxDjvACiiiM9wq3nPi08EM+LgRFxV92JcIul0Uv
	5J2r5HznEBiqm2KwJnzqr9MzXxLzifcATjm9yattgXzkEWrJRD6Y1AB7qY1g2+5jeQJw
	b+CqJ+4Z0tbdyqDL2I/wA+0eTy3I1lyyLSUVfEmx/N74QhdUF/LKaOAug1Du2vXZvJHY
	FPIe8JEh4Aufp37IRSRZMdRGKoQmTpZrr1OFGfY32G22cTJ2FJAJEGylK1gdJM3ECXbP
	KRBA==
X-Gm-Message-State: APjAAAXsrDrt3SlYttbJo+PpJwckmOdGx3YQmsCfK/bseLCf7tOwWfjY
	B91js2GKC12O6GPfhQUsp8EwbTruI9oinQ==
X-Google-Smtp-Source: APXvYqxdFnETQy5F/P+T/51+znTZZ1mOG7tsrJmKVpfIe7RmOVeKAu31PD4QuRHULDkrMsOv3QrGqA==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr8785515wmi.48.1565790805573; 
	Wed, 14 Aug 2019 06:53:25 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:15 +0100
Message-Id: <20190814135317.28887-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
References: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 08/10] runqueue: Recompute holdoff tasks from scratch
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:25 -0000
Content-Transfer-Encoding: 8bit

The changed_setscene variable here is just odd and not needed. Worse,
it could prevent some tasks from being removed from the holdoff tasks
list. The list is being rebuilt and should work as intended just from
the other data, this is a leftover from previous versions of the code
as far as I can tell.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a1e3285821..eb8e342761 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2237,7 +2237,7 @@ class RunQueueExecute:
             self.update_holdofftasks()
 
     def update_holdofftasks(self):
-        self.holdoff_tasks = set(self.changed_setscene)
+        self.holdoff_tasks = set()
 
         for tid in self.rqdata.runq_setscene_tids:
             if tid not in self.scenequeue_covered and tid not in self.scenequeue_notcovered:
-- 
2.20.1


