Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
	[209.85.216.43])
	by mail.openembedded.org (Postfix) with ESMTP id 450627F7B1
	for <bitbake-devel@openembedded.org>;
	Wed, 22 Jan 2020 05:25:06 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id s94so1673967pjc.1
	for <bitbake-devel@openembedded.org>;
	Tue, 21 Jan 2020 21:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=h39p7rGmeriaNZP9yMx4jVuKCJ7Rcn97tmduTEr7phg=;
	b=kIw2WFxJJL1TrZhD8sngaCiYNL2FYvkpH76kCxqreFuEkn7NvhvBUMdNUZHtjzJX4H
	jx4tsH6S4xlAqLQ0wyIY44QEFVg2a2JoDvIuZTGBAqn3TQCpOwgz8uSLWyL4Y+YsJCt0
	bcQXmqyN71l8AZUAhhptafKOBW3PQnvt69ngEiyhP0Q0rQcvvrWas3hPbsZGpyLflqTD
	geWVSvjXVVO9PZGtMrArYdGpKqgj82eJz0fpN75+wFsCXLQ38D/CnOKeWvqQEHAZHsuv
	Ugg4Tj4cIUFMjjneP/PgtPW2BukjbwA6K1pcKqXW1Rk+6JKwtf+KdQesgV8fX/hkW2Dx
	A6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=h39p7rGmeriaNZP9yMx4jVuKCJ7Rcn97tmduTEr7phg=;
	b=aKfU9B+H0VtB1Qe5FrNaabjE8axV1mFLXNBHC/Ip15oVik0O9+h1SbI8tYPThB+tn4
	qs0emKlxAm2yNiVvSxDSF2cbelkH2LZqqyBJv2tJtf1g5t6xUCmqtguRH7K1UnxP2r5d
	8rr85Uc/tTzMMY7wFKuBL0N6UQPHYEBcMEXNGH0Uyg7s1n8QjpccNsM9NGNygKU82H2E
	QE5zHm2X7v9qSxICk+bvUinvoUb2PWjZQUlapnxbkIqu/ZAI9u8ly3+KC9HpcEye70kd
	JFLGjpFluoIKY/HKcgra1z1O9Fu+wTN8HoRUsuCtm6gA4/B6nqNUu7hmOgEKSs+JcSm0
	ANpw==
X-Gm-Message-State: APjAAAXluaAcqWSUwSFVXePhx31XdZr8XQbzyrWBefS5xN4ETgCviSFn
	n//eK2RWRLpS/vRhKO5rELJFlDI4
X-Google-Smtp-Source: APXvYqzjPAQU9Dsws3T/mLd0BA7+mQbRYMEwJhSKA7sIZoVzTJUW5mEK9XWpNl9RbATufp7cWY+V3Q==
X-Received: by 2002:a17:902:34d:: with SMTP id
	71mr8784518pld.316.1579670707373; 
	Tue, 21 Jan 2020 21:25:07 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:682c:76b9:6d8a:bbd2])
	by smtp.gmail.com with ESMTPSA id o7sm1228628pjs.28.2020.01.21.21.25.06
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 21 Jan 2020 21:25:07 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Tue, 21 Jan 2020 21:24:59 -0800
Message-Id: <16799ada1cda8e021cb04c43e469225790525723.1579670574.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579670574.git.akuster808@gmail.com>
References: <cover.1579670574.git.akuster808@gmail.com>
Subject: [1.44 1/4] cooker: Keep track of watched files using a set instead of a list
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
X-List-Received-Date: Wed, 22 Jan 2020 05:25:07 -0000

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

When there are many watched files, keeping track of them using lists
is suboptimal. Using sets improves the performance considerably.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1e96df260e47d160dbd36bfc92c31ef06266f662)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/cooker.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e6442bff..b74affa7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -169,8 +169,8 @@ class BBCooker:
         bb.debug(1, "BBCooker pyinotify1 %s" % time.time())
         sys.stdout.flush()
 
-        self.configwatcher.bbseen = []
-        self.configwatcher.bbwatchedfiles = []
+        self.configwatcher.bbseen = set()
+        self.configwatcher.bbwatchedfiles = set()
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         bb.debug(1, "BBCooker pyinotify2 %s" % time.time())
         sys.stdout.flush()
@@ -180,8 +180,8 @@ class BBCooker:
         self.watcher = pyinotify.WatchManager()
         bb.debug(1, "BBCooker pyinotify3 %s" % time.time())
         sys.stdout.flush()
-        self.watcher.bbseen = []
-        self.watcher.bbwatchedfiles = []
+        self.watcher.bbseen = set()
+        self.watcher.bbwatchedfiles = set()
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
         bb.debug(1, "BBCooker pyinotify complete %s" % time.time())
@@ -278,14 +278,14 @@ class BBCooker:
         if not watcher:
             watcher = self.watcher
         for i in deps:
-            watcher.bbwatchedfiles.append(i[0])
+            watcher.bbwatchedfiles.add(i[0])
             if dirs:
                 f = i[0]
             else:
                 f = os.path.dirname(i[0])
             if f in watcher.bbseen:
                 continue
-            watcher.bbseen.append(f)
+            watcher.bbseen.add(f)
             watchtarget = None
             while True:
                 # We try and add watches for files that don't exist but if they did, would influence
@@ -294,7 +294,7 @@ class BBCooker:
                 try:
                     watcher.add_watch(f, self.watchmask, quiet=False)
                     if watchtarget:
-                        watcher.bbwatchedfiles.append(watchtarget)
+                        watcher.bbwatchedfiles.add(watchtarget)
                     break
                 except pyinotify.WatchManagerError as e:
                     if 'ENOENT' in str(e):
@@ -302,7 +302,7 @@ class BBCooker:
                         f = os.path.dirname(f)
                         if f in watcher.bbseen:
                             break
-                        watcher.bbseen.append(f)
+                        watcher.bbseen.add(f)
                         continue
                     if 'ENOSPC' in str(e):
                         providerlog.error("No space left on device or exceeds fs.inotify.max_user_watches?")
-- 
2.17.1


