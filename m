Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id 6CA937F00C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:25 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id n9so4234641wrr.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=nJ+f4FILv8GSZZqH48Acwobgb8X7RWu4N3MvCLRXp+Y=;
	b=Hcg2B2pWk2t/wlC6PNQuv7lJEXQh+Ofu3OKXqTvihtxotbDz5mtHMV3TrSN/xGvgdT
	cOLWwrcQ0iHNBpeNjL6VvpRsEmcx34udbIKQS3oV6wn7v3+IOH5Cee/oa4N3uxaXciiq
	q7KZHIpRyv/peO8IPMET/ajql7hlmJfGlA8EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=nJ+f4FILv8GSZZqH48Acwobgb8X7RWu4N3MvCLRXp+Y=;
	b=nxEF7JPmz7P5RXpF7D5eUwJcnjriPEZVVecKEQ+sZtAhmWdpU0+2CjP67uKzSRxwdY
	Gx1vLFT0tyutFKjwK6RXSAP//TcST99wnwgVVSCgRE3Npm21GdEw3OX4Q4jquOnZnnsc
	PevCXkj1KCaCGEi2dDxqv0qI9SLU/DoFBRA48EG8G66iGRw0s5Z3KkuYU1w/Vsz64xKw
	NTDorO+yQBXW7SK8ns7mLcX6fI96TD/hAzMwv4Kf7Tyg2cOa3/vq5vTBlCgTOI0tum1n
	FEZX7lkfioWGHrgBO6SQt13AKx6So+ZNXigv22+0auJhQB4IfsVnIJIF6unOHDXPjKsB
	mvFw==
X-Gm-Message-State: APjAAAW+WxhEVUa6cwQG9L4vTBHSx8W9au9ozTa0IuVyrZjWwfFbC6rr
	PQHyDvozi9oeX7NdUKvA0Jt6J6ArLhU=
X-Google-Smtp-Source: APXvYqyUSxj5z/Xp42v41KDkEjI5J16PA0YOH2oD+T4OKt7Vacly8LBHEK3bWhkRFPJo3UdyXzw8Sw==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr229625wrp.176.1562802865945; 
	Wed, 10 Jul 2019 16:54:25 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:53:59 +0100
Message-Id: <20190710235420.23825-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 05/26] runqueue: Remove unused function parameter
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:25 -0000
Content-Transfer-Encoding: 8bit

The function is only used by setscene code so the parameter is pointless,
remove it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b3116bce2c..b6943f238f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1759,7 +1759,8 @@ class RunQueueExecute:
         self.rq.state = runQueueComplete
         return True
 
-    def check_dependencies(self, task, taskdeps, setscene = False):
+    # Used by setscene only
+    def check_dependencies(self, task, taskdeps):
         if not self.rq.depvalidate:
             return False
 
@@ -2413,7 +2414,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 if nexttask in self.runq_buildable and nexttask not in self.runq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
                     if nexttask in self.sqdata.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % nexttask)
-                    if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask], True):
+                    if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         fn = fn_from_tid(nexttask)
                         foundtarget = False
 
-- 
2.20.1


