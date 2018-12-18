Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id 911A97C034;
	Tue, 18 Dec 2018 15:31:07 +0000 (UTC)
Received: by mail-it1-f196.google.com with SMTP id i145so4726137ita.4;
	Tue, 18 Dec 2018 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=w/LC+cS/gLlBiEhVz8vQ+ZdkbxjwjY7Vl2l/c7zSdfY=;
	b=c+OSHxkymLC8ufqTh4YMLuQqnZQIVCFdAYVHaOICs761lpKTyWRlHvQyT+1GHELaYu
	yeywjiJHCQY0SdtP68Xa5IUglFPc63/+1h0bioe/MFZhp66ewC8QiZ3JF0+Ful40gopv
	4Pu4wam0t+FPucRrFpv7rbXyGXjNLoMpQ1punVz1daW8EQZpZfmZof5+ARK8KlPU+Msr
	EYz1wTA58LGfM4AF6dWIhBiAB6LqM8D0Vu4jzWKz25nWubpwYDmsYqb4lTQPuR7IGFaw
	4FPcPsi94I260WPIXFZ9TdTIM8dkmGaDvp/dP9dYfuQ8jQbgZgrdRisrHbDhScA8EKeo
	BisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=w/LC+cS/gLlBiEhVz8vQ+ZdkbxjwjY7Vl2l/c7zSdfY=;
	b=VWZoO87aGZXJ5Xljyk2Q6YYjrij2bF6B5auzoIFhozkkI4vDG+KbydCTmF394A0CDj
	5yyYpN5rH/OpSysf+y2fqMcTmQPeunnqJ3qvGsHA5CaEEHuo+eAY2bwaUYcku48Fwfq9
	9Gcqo8ajrBnLygkM9PiEt9mf/Vr4Z+ZALTWfdglUV7hIesbs0/LeMexEdRu33ym/pOdf
	bOYvdb5DvLHpW3AnfMQ94oNYe61BczjZyIdsCTUnsNN0TZ3qe8bWqI60tGx5BadK8BaP
	VvXI8dVChcc8aT8140LgjXtmffiziYSTB9ebTx9i4Jdad81sxDeHiNyo9yDrewcNoRWB
	sI/A==
X-Gm-Message-State: AA+aEWYPc0TTGyOSjrHQA0XBhQ7xiI66YSt6lyrPu6uZ1LsRFHt5XXvI
	hfPjQhir8uBl3sBNy0gzD8tqTVzC
X-Google-Smtp-Source: AFSGD/V1jzTfZ6asN4BiXM4e9K1yPrcVJxuH4Xogk5wkHet3KiD27dDCrV3qDYQX7GfoHOqVpFsspQ==
X-Received: by 2002:a24:fdc4:: with SMTP id m187mr3105506ith.75.1545147068031; 
	Tue, 18 Dec 2018 07:31:08 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:06 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:52 -0600
Message-Id: <20181218153101.9212-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 01/10] bitbake: fork: Add os.fork() wrappers
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:08 -0000
Content-Transfer-Encoding: 8bit

Adds a compatibility wrapper around os.fork() that backports the ability
to register fork event handlers (os.register_at_fork()) from Python 3.7

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  2 +-
 bitbake/lib/bb/fork.py     | 73 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/bb/fork.py

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index cd687e6e433..41ef6d848ac 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -181,7 +181,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
         pipein, pipeout = os.pipe()
         pipein = os.fdopen(pipein, 'rb', 4096)
         pipeout = os.fdopen(pipeout, 'wb', 0)
-        pid = os.fork()
+        pid = bb.fork.fork()
     except OSError as e:
         logger.critical("fork failed: %d (%s)" % (e.errno, e.strerror))
         sys.exit(1)
diff --git a/bitbake/lib/bb/fork.py b/bitbake/lib/bb/fork.py
new file mode 100644
index 00000000000..2b2b0b73b62
--- /dev/null
+++ b/bitbake/lib/bb/fork.py
@@ -0,0 +1,73 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Copyright (C) 2018 Garmin Ltd.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+"""
+Python wrappers for os.fork() that allow the insertion of callbacks for fork events.
+This is designed to exacmimic os.register_at_fork() available in Python 3.7 with the
+intent that it can be removed when that version becomes standard
+"""
+
+import sys
+import os
+
+before_calls = []
+after_in_parent_calls = []
+after_in_child_calls = []
+
+def _do_calls(l, reverse=False):
+    # Make a copy in case the list is modified in the callback
+    copy = l[:]
+    if reverse:
+        copy = reversed(copy)
+
+    for f in copy:
+        # All exception in calls are ignored
+        try:
+            f()
+        except:
+            pass
+
+def fork():
+    if sys.hexversion >= 0x030700F0:
+        return os.fork()
+
+    _do_calls(before_calls, reverse=True)
+
+    ret = os.fork()
+    if ret == 0:
+        _do_calls(after_in_child_calls)
+    else:
+        _do_calls(after_in_parent_calls)
+    return ret
+
+def register_at_fork(**kwargs):
+    def add_arg_to_list(name, lst):
+        if name in kwargs:
+            arg = kwargs[name]
+            if not callable(arg):
+                raise TypeError("'%s' must be callable, not %s" % (name, type(arg)))
+            lst.append(arg)
+
+    if sys.hexversion >= 0x030700F0:
+        os.register_at_fork(**kwargs)
+        return
+
+    add_arg_to_list('before', before_calls)
+    add_arg_to_list('after_in_parent', after_in_parent_calls)
+    add_arg_to_list('after_in_child', after_in_child_calls)
+
-- 
2.19.2


