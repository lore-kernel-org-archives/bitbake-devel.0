Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
	[209.85.216.42])
	by mail.openembedded.org (Postfix) with ESMTP id C312C7F891
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:56 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id r67so6898244pjb.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=ETdhbTbBuEUZ9p9giL7/FN5IL29P1qhietUMpBGLf3o=;
	b=ibgHuWIex3st8pzoTaA0hxZ71bZT+dQIocHyxXA9IWP880uu0BgkPvfGVzZU1WbOPy
	4AI7ogxs/dglh3moRt41UuRY/lCdqKqzUgB5TaIUB7Kr1zq0VEK5YICrsencqGb6wRS2
	Wfjo2jhyw5vnkg4IrOL+NmFX02m+pRsmSMEE6BQeuiN0OT+31QEuwRye+udEmFkwpUf1
	mpbrwI7uI5rG4mHi3l7Rjwpq1uCXuqNrmm4Sy6ZCmi9hI2moA+klJJ/PxjPXgwEFdN1d
	7iMASrp4/NE9fJubpAt9sA9Z0eSOlD+nK1oUxGzHazb5uTUxg9tYRzGP1F0j6dDTAk7q
	J7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=ETdhbTbBuEUZ9p9giL7/FN5IL29P1qhietUMpBGLf3o=;
	b=qZLDuwpXw8hsvL6ZnskFJg8vXB+8x9wey3E91I2fqpKDls1JA4BuE4uK34tit/Kuq8
	DaafU7bLp73xgIf3C/7zDwDGTbpfVFGn9QpQZUtVLWMY1pB+6anw62M+LJo5McHoWaAc
	cPH5ifrujLU5yxnLYHjdAyTrQ3U68etd1VCuuYaylPqx0PVePwC/8pJbRjnkyasb4WHT
	SeuwopF8Oku5hQFPjLMe261G5EjFbenbm27XWR909Ni7vsCcosGCzxest+48F9o1ZKvT
	rvXew2UqEFM0Hw0Yd9ZY30xES91zNAE678ctSOq7rGEAsV1OlqmW3NR9BEZgX4Ma/WL/
	APhg==
X-Gm-Message-State: APjAAAU/TpCagpHGKH3WuIDRZf4nnaSU6uUnKhjLcVqMttAZFIOQ1bus
	l4tS2t1QUSeAIfkd9d/ShQdniCBoNr8=
X-Google-Smtp-Source: APXvYqwDVZb5DJc9s0XTKpXNt5lBf+TA6b/ikkU3Wx12KUGJ3P7lp6Je72YyGDqT0DA+RN4zHdz52g==
X-Received: by 2002:a17:90a:ead3:: with SMTP id
	ev19mr31803060pjb.80.1577076657841; 
	Sun, 22 Dec 2019 20:50:57 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:57 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:38 -0800
Message-Id: <57df7f191755dd887827d51b125d246c1af3e1b6.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 14/18] runqueue: Optimise task migration code slightly
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:56 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Move the calls to difference_update out a code level which improves efficiency
significantly.

Also further combine the outer loop for efficiency too.

These two changes remove a bottleneck from the performance charts.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e28ec69356f1797de3e4e3fca0fef710bc4564de)
---
 lib/bb/runqueue.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2ba4557..6da612b 100644
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
2.7.4


