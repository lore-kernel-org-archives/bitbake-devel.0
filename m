Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id B273A7F7C0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 09:41:17 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id q6so3504106wro.9
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 01:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=5X9sVz+m2P28d42sUO+dTKNf6EUTt3fb1CYHh+nyQoY=;
	b=RdqOWfcoaZsUIJW0dZHGOz1a2JRUfAwsrkkdleIOucTZpkrRDkNCM/mXcBERPHMJhw
	8dEDlp2hwoxMoqGVQ2PcpVlBYM0GPD0/wgAE1YU1vRxFOsZEgeyUDUZFK2kJzKHiT/su
	WVo0JcOzK5HiH8rdMFTIyjaVo0V9KyTjWt1kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5X9sVz+m2P28d42sUO+dTKNf6EUTt3fb1CYHh+nyQoY=;
	b=cWZbDA1RIWTiym0rAakzCzOAILCm1CHjXXyJ52yQsYgWNVlVfv0DdN183X3Dh4Lspp
	48dBynhuAaK75HjEgtBbCroO13losn7BK7yX93alT0MIIbDlxmQTxJYSyxGL85RTXnE/
	VDMmUE2YfTEwe3tvqpLupaVlLb9sH6g/rZeGI8ckdsIVGeGPVofOPDtQvHUTap4TwKYv
	kUJcdQLwnK5anU2RpkaKPTiySY7SsoVMozvGThbTSK31PobHntiFfjOaeCvQBnkYhUBy
	xzIW0OVOcDnyURGD/MKx6czBSqWYdBbhwJcVi2I4BdUJ0zLgdIwXPzhhGOxkPfxYDYzs
	M2yA==
X-Gm-Message-State: APjAAAW1r5ElZ6SJwdSafPOeYwYkH14wJ0SCzyAW1RADMZnDoZuDfqTe
	JBj7NcBDVJQa+9aeBKKz+LyGyi66xNY=
X-Google-Smtp-Source: APXvYqw4eyjAaVq3A8R/+T0Smpa+mG+jQYBhZttOBcQRDSJZ/QeGSQq+AebhbADsTpWX6F7+cJc1UA==
X-Received: by 2002:a05:6000:f:: with SMTP id
	h15mr22516146wrx.90.1576402878124; 
	Sun, 15 Dec 2019 01:41:18 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e8sm16877572wrt.7.2019.12.15.01.41.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 15 Dec 2019 01:41:17 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Dec 2019 09:41:11 +0000
Message-Id: <20191215094112.28162-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
References: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/5] runqueue: Fix sstate task iteration performance
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
X-List-Received-Date: Sun, 15 Dec 2019 09:41:18 -0000
Content-Transfer-Encoding: 8bit

Creating a new sorted list of sstate tasks each iteration through runqueue is
extremely ineffecient and was compounded by the recent change from a list to set.

Create one sorted list instead of recreating it each time.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 515e9d4314..2ba4557f9f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1965,10 +1965,14 @@ class RunQueueExecute:
         self.rq.read_workers()
         self.process_possible_migrations()
 
+        if not hasattr(self, "sorted_setscene_tids"):
+            # Don't want to sort this set every execution
+            self.sorted_setscene_tids = sorted(self.rqdata.runq_setscene_tids)
+
         task = None
         if not self.sqdone and self.can_start_task():
             # Find the next setscene to run
-            for nexttask in sorted(self.rqdata.runq_setscene_tids):
+            for nexttask in self.sorted_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
                     if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         if nexttask not in self.rqdata.target_tids:
-- 
2.20.1


