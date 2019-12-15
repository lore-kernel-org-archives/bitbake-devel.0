Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id CD5F77F7C0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 09:41:18 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id y11so3523765wrt.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 01:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/3tuJiESIKLbpgINrsrqf4SofXzyhrhSSchglIbPrZk=;
	b=DIUL6WFEbZ7MsPzR6G/sW4DkfxYjVJ5hv7DFt2a3VSTw4ChsjNaTnzb/z1Io8gq/yE
	f8e5IVq/PO0FJHFV7WhZaMPGRZSw7D7parWLq+RJh1KNrKsNq+kAoMhSviBscE0wpTNJ
	ip8iswcPGUAl9tYkWdndnqs4wURZSnsarc91Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/3tuJiESIKLbpgINrsrqf4SofXzyhrhSSchglIbPrZk=;
	b=s9WOY2nY/1PLckvz7Vtv5FLTtlc/qRt4TCbcnXIrokuwdFwVC1zZLmFYhIdVv2gaLw
	EvpMTbp4s+pdQWjc059SwAOVJu4YzqQnX1yI0jSCKV1Il1mv7dd46yNepjsUBVkC89bJ
	0V0/zv9sVMiIQPTTe2H7HYgfbbNi30wx8P9VOqHqKT0+ctONRWCK+WzVUkbuRLrpVHVq
	iWXeZ3ioAVHocO0ymbMiHhwvpX9YTKGS1LOTxqn6w6DX5s0JeNw5PxjsRFMMZYagsBXl
	486nalUCgmYP2ZeSDT4D76K46It+eFy94B6EpXHSbdr25nN9iAsF5NSpmFKpMxpCYUVl
	aXCA==
X-Gm-Message-State: APjAAAUxAZ43276q48Sn7nhf4aujATt/vYNCKPCm6NaIYjAkzcHRqdhn
	lVRAzRsbbmev/42X8nKuxkyY+fS2sHA=
X-Google-Smtp-Source: APXvYqxwuRafaSkbI4wEYlad6+WkgL4lB6vS0ahIVrWT1DnQtTatrVfNOHgQ1nTjDVSNAJ4X4ZAk2A==
X-Received: by 2002:adf:8bde:: with SMTP id w30mr23355433wra.124.1576402879337;
	Sun, 15 Dec 2019 01:41:19 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e8sm16877572wrt.7.2019.12.15.01.41.18
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 15 Dec 2019 01:41:18 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Dec 2019 09:41:12 +0000
Message-Id: <20191215094112.28162-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
References: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 5/5] runqueue: Optimise task migration code slightly
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
X-List-Received-Date: Sun, 15 Dec 2019 09:41:19 -0000
Content-Transfer-Encoding: 8bit

Move the calls to difference_update out a code level which improves efficiency
significantly.

Also further combine the outer loop for efficiency too.

These two changes remove a bottleneck from the performance charts.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2ba4557f9f..6da612b719 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2268,15 +2268,16 @@ class RunQueueExecute:
 
         # Work out all tasks which depend upon these
         total = set()
+        next = set()
         for p in toprocess:
-            next = set(self.rqdata.runtaskentries[p].revdeps)
-            while next:
-                current = next.copy()
-                total = total | next
-                next = set()
-                for ntid in current:
-                    next |= self.rqdata.runtaskentries[ntid].revdeps
-                    next.difference_update(total)
+            next |= self.rqdata.runtaskentries[p].revdeps
+        while next:
+            current = next.copy()
+            total = total | next
+            next = set()
+            for ntid in current:
+                next |= self.rqdata.runtaskentries[ntid].revdeps
+            next.difference_update(total)
 
         # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
         next = set()
-- 
2.20.1


