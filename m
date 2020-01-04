Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id EF81F7F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:25 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id b137so24180161pga.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=sHHC5spCdMcHMA8SiX5GYtNvF19WVafzS8tfmK/YS/4=;
	b=OCkEHY/4d2ewWniifJMJaX/UnChFMHsjLn58EkQooqLbvB+HiNbblpHeHNlokvuKrs
	4BIhC6aJlSfIXSHfQ+fdnz28oZWJ+9J/cVhe979d6vmVeyk4vVbND9TaLIV//MThYS6L
	adiRDv3f3tMJKEC8XsNGw8Hya2xk6JTuShCYb4Csg3tNrO4z3SHucEw3oCtl6x5UawHz
	7JjczyxrfPq/CP8VaF+jk18/5xbYWECEn5IrO44fMxp9aMSuS7D9WysxUi4ww4VcMCfu
	vC7+6Dz/Vgh6jZa3566zQI12A/IhVWA8Wbr9jPY2JeZTSbwfjQ0D9RNWC7/sgMRJtcDG
	jL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=sHHC5spCdMcHMA8SiX5GYtNvF19WVafzS8tfmK/YS/4=;
	b=s0zOeSQ8lIp7H6BDvTroIL/JOb9474o9agrFXMVa41kSkY5/VDz6ABI4+E3/OwFhpa
	g0BJ4PU0UaPP7nRbvBxA1nSRveelC0+LuYZgxIoQGlI3lEx5RiLi67pZlVVJna89KAbG
	Vg+LLl/tWk/EXk33akO80206P+9T4yOl/gncflxIzXbRhKOJUOe+PEGqmlRHgZrud0So
	fqwa+OhuLGb6kNr8zV4q3do3zzUmg6QilSjAolquo7Nqx+BCMnlWg8Z53a4eRzj7gLi2
	Y3G2nedIq6UUdSWKZtPR/hl1unMh+teW45WQbuP2vfQv2WzGVCs2YIgNufGKEQQgN4xT
	wSmA==
X-Gm-Message-State: APjAAAXkORz4j/EV/4Qy6qhq3qwb2lo3ao8V29PadwnSKICwzh2czhzG
	+d1AnNHt3cWnwEWprSQqh9TYUvqhfSE=
X-Google-Smtp-Source: APXvYqwyS7dqmKEU+7HMsAsuvL8PchsP1RsgqAIOKYAtY6icAdavkrunjarri5EsMiOQohLv7aXwBA==
X-Received: by 2002:a63:5162:: with SMTP id
	r34mr101209406pgl.227.1578104606932; 
	Fri, 03 Jan 2020 18:23:26 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:26 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:59 -0800
Message-Id: <57df7f191755dd887827d51b125d246c1af3e1b6.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 14/25] runqueue: Optimise task migration code slightly
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:26 -0000

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
index 2ba4557f..6da612b7 100644
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
2.17.1


