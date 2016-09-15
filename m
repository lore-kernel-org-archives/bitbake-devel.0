Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
	[209.85.220.66])
	by mail.openembedded.org (Postfix) with ESMTP id A80D7731BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 21:15:55 +0000 (UTC)
Received: by mail-pa0-f66.google.com with SMTP id oz2so2561550pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=z3q6uQ+bNRzot9vDTUTGxBJrGwBH5ip1gy/7hrBBZgQ=;
	b=G7QLgHsi66v+yyhGSLmNHX4doUc1yKeROdw3FQ174LHM1MPmArHc50KLzcgkF/fyOv
	r30XKd3AlMTETbCRJoHshDBYg6ra2pxf+qjC7+eu7f55xuc2DAKBB5izHLw+36WCLsIG
	VIYXujS8thl9wHoT5oTsjJfn5S5qKfAILHXcD4sB7/bR+FyOD1ROVRhRQ103+06OHD2D
	MN7vEOxyRQZsup4eMuIt5uO/yVkglwu9ooCzBfDGK9dkv5ZVXjAtPN2+aJ4p/ogddueY
	NbVwtEapmHSZHkcccncqcZ8m6F3CF1O8/99GCk5PvuluGLIdCPRyw9+vPfM2pWy5Y3+U
	EqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=z3q6uQ+bNRzot9vDTUTGxBJrGwBH5ip1gy/7hrBBZgQ=;
	b=QLfQ7DGY/cDh4KSbQ4N+acj4idpsV1k+YzCsCaxurla15+63JvQS1gGRm5r4cY8kJD
	FnezV4SKF/o3IQhzzd//+eixAhNMXSWYXQDBnaRYj8DnHJnCNm2oaMX9LGpaSckUDTM3
	OLJcClrcYM10+kOIHW7SOl9y8zXwNDv9xMMCdOK3wY+PKjP6DOSG8oqR5DYlKLJN/RhM
	FM9VQBijzqFQN7AGbsTDoLlDHsfItq2i2+7u5vqcclTOV4iCpi8TYvsOS1wgQQJyDURm
	d1cjmakrZk5h875pT/zX16jURehbVH0gtdrBJ0+JorBRM+zRrWPrpP0Lcjs2zKcsgYlv
	8utg==
X-Gm-Message-State: AE9vXwNJDI/k7gYCFhw9DiyIMzWTRl5xrqyLnKgX0sdtm0Ipi4zOJ3kU9sW1rdMw/JNqFQ==
X-Received: by 10.66.161.195 with SMTP id xu3mr17802901pab.68.1473974156026;
	Thu, 15 Sep 2016 14:15:56 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	ps2sm7115880pab.10.2016.09.15.14.15.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Sep 2016 14:15:54 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Sep 2016 14:15:47 -0700
Message-Id: <1473974147-29966-2-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1473974147-29966-1-git-send-email-kergoth@gmail.com>
References: <1473974147-29966-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/2] bb.build: in _exec_task, catch BBHandledException
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
X-List-Received-Date: Thu, 15 Sep 2016 21:15:55 -0000

From: Christopher Larson <chris_larson@mentor.com>

We don't want a traceback for this exception, we need to catch it, fire
TaskFailed, and return failure.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/build.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 28401b3..8581e72 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -575,6 +575,9 @@ def _exec_task(fn, task, d, quieterr):
             logger.error(str(exc))
             event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
         return 1
+    except bb.BBHandledException:
+        event.fire(TaskFailed(task, logfn, localdata, True), localdata)
+        return 1
     finally:
         sys.stdout.flush()
         sys.stderr.flush()
-- 
2.8.0


