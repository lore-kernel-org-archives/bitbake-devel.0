Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id 471BE7FC0C
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:34 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id h13so5604492plr.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=k7UNZI1jGDhRcgfWRgCQ0NYO6Mdl2NPCF8YVzTmWbo0=;
	b=l+TUfmh9dbAPC9utQe7mDdW0Zn4phSQP7V7kGGrqu/hmz7zliK5nSSisCJSYDsvOnv
	OXreFxYev56etZjX5teu0bO2Vvh7u5xE8lAUfnQ/eseXKJ3QYqwOfUfNmv3Lz1YffPwv
	gtJc/bs3mPnHoZ7m2adrhB9OW1iH7Xzh0cds5T/J+VZ7L7YzAj6io6X5Tm1Bhvog84cj
	t3we9TBZ8FS2zBJuWeJHHHHYGeUdkOOEcubjAIP3KrEN1JrzHTZ/lMfq3ne3/EdvzXN+
	lu1xHliQlsPi20hC6Oyw1K++5hvtFifhCZGp2dVvLdBBODrFQwAQSm6t3pZY57H6swit
	ZZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=k7UNZI1jGDhRcgfWRgCQ0NYO6Mdl2NPCF8YVzTmWbo0=;
	b=C4uwM4hQuae8vRBAOqNxVeXjX2w4nOt5IRCx0Ueh2POuC0h++2HiTek3jzJBpVvZ+P
	9vSfbDY+fOSCRDT6SwzPRBSRDJrTXpYIXbPHNajlYzqRa5LNpwqCCmJRWGLwJqzoNroK
	S/hlKfY+RVxmOtiHI37EpM8KhKONKU6+NpmtoixHTW1Ue2ORCRNQf5+F2Epwz5ELxfi5
	oz7KrzZIDI2I3c/uWo+0cem9G4PpSDnH5zQOzP+lzsNBgy1QB4c9dmD3jP20Z7rlnJsb
	L+M59lKdOYJZQpOrN3KpE5rGuQJuI+KcLlmpzTD/6cIFNNZZf9496+nm3m+HM5LxM8fG
	w3kA==
X-Gm-Message-State: APjAAAWkD99AIAK1alrW474js+h8J37CNgkYb3LLzO2KQ1qynbDHD297
	ybzV3tEMf4B/qyBkiFhOrEjcmXg5
X-Google-Smtp-Source: APXvYqwjKvRX6UFdJAuk2Pd1STc7/4CAdIgNgsvlTxTLyJC/hgA07G7bwFZ7VSATYepHiX7Fou7tBg==
X-Received: by 2002:a17:90a:9b87:: with SMTP id
	g7mr34709778pjp.64.1574639015202; 
	Sun, 24 Nov 2019 15:43:35 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:34 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:22 -0800
Message-Id: <33ffc2128b1a74fa7179a8341db68cddf402536f.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 9/9] runqueue: Fix hash equivalence duplicate tasks running
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:34 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The key problem is that currently running setscene tasks are not
accounted for when processing task migrations. This means can allow
two of the same task to execute at the same time with unpredictable
effects.

This change allows us to stop doing that and refactor the code slightly
to make it clearer that these conditions don't arrive even with
deferred tasks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/runqueue.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1804943..02a9b91 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2303,16 +2303,22 @@ class RunQueueExecute:
         for tid in changed:
             if tid not in self.rqdata.runq_setscene_tids:
                 continue
+            if tid not in self.pending_migrations:
+                self.pending_migrations.add(tid)
+
+        for tid in self.pending_migrations.copy():
             if tid in self.runq_running:
+                # Too late, task already running, not much we can do now
+                self.pending_migrations.remove(tid)
                 continue
-            if tid in self.scenequeue_covered:
+
+            if tid in self.scenequeue_covered or tid in self.sq_live:
+                # Already ran this setscene task or it running
                 # Potentially risky, should we report this hash as a match?
                 logger.info("Already covered setscene for %s so ignoring rehash" % (tid))
+                self.pending_migrations.remove(tid)
                 continue
-            if tid not in self.pending_migrations:
-                self.pending_migrations.add(tid)
 
-        for tid in self.pending_migrations.copy():
             valid = True
             # Check no tasks this covers are running
             for dep in self.sqdata.sq_covered_tasks[tid]:
-- 
2.7.4


