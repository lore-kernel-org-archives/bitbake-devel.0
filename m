Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail.openembedded.org (Postfix) with ESMTP id 9E9EA6BD11;
	Tue,  4 Dec 2018 03:46:21 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id l14so12409586ioj.5;
	Mon, 03 Dec 2018 19:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AhJo0w5FJSJDHATla1+ALFEm8rM+NEJamYroVJGqcho=;
	b=Ihk6vGhxVlG3yHk3mWIcONyqA8Ps8FdXtu5I9UoPFHnqKrAeFFoke9hi81Kf5HUveY
	pBKDih/oZAOfErQ33EH3uGeuVP4YTkeuJCP0hDV8bN3/DKPWo55nWmf/FA18r1rToOqH
	BJ8htSlmuvOuh4IKT3WuB34yb4XpzCAclliqWReX8oZh907Ko7Y0g4QSt7XWLfkB8/Lt
	aHQM9kg3eHooqQJzIJ9jueJ+bNyJgIZjLqS7hnIG/JHEpSXrO0zAbsgw0ecRgDLRFv03
	+r2cmMZFB8UsE8X3dTOcTwBqscdQyXvAhnRmtuim6ju9/+tYkZF1E+KNS+Nzb0quhsxq
	A3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AhJo0w5FJSJDHATla1+ALFEm8rM+NEJamYroVJGqcho=;
	b=Q+wHIIYWr2KQarauAxkr1RsBfzov9nqzzL8GPfrg0Z2bjCxHkjB4oT1nfDgkpMCWiI
	TyPn/Z2hZQoVxal7tmBu/KFo7DFTl06O0BUPYlbritbCQgKsX2joeW+1IxSIO2KS6wCb
	v7gJblowcM8l4A/ZDMiMAPuFasSKXFyIKt1/zMSOdlOCbQmYNe74pWCoSN6gLxoAdygT
	gJp3tbFvl1niWw65nRM/00kV/zyuRhx90b1M5YRFaXYUmeQVH7DvvdgKHU6tZxdElISt
	qw1w49oFONLUa2h47vF1GcdLm1Me1/UoS3/LdagYM1bPl/wnoUh084NLXxku2jRPX3yV
	Zcig==
X-Gm-Message-State: AA+aEWaFJ0mvgFTkb5xpIwQgEEfvCEUMXqKbTZl6YBFpXwXBfGGGmsSe
	bN514UsrltUc5SfkvUSCzGQYECBHaoE=
X-Google-Smtp-Source: AFSGD/VWzcwR3NMSUzLMa+ldIZtu9rgICJ+FpyReyhU/h027XPtyAemiRYaI3xeC0fUpemNYq/+s/Q==
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr16012202ior.169.1543895182190; 
	Mon, 03 Dec 2018 19:46:22 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:21 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:29 -0600
Message-Id: <20181204034245.25461-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 01/17] bitbake: fork: Add os.fork() wrappers
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:21 -0000
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
index e925054b7f9..baa1a84e6dd 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -181,7 +181,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
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
2.19.1


