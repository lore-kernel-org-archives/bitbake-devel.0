Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
	[209.85.223.179])
	by mail.openembedded.org (Postfix) with ESMTP id 4C12278E7A;
	Thu,  9 Aug 2018 22:10:44 +0000 (UTC)
Received: by mail-io0-f179.google.com with SMTP id i18-v6so6055936ioj.13;
	Thu, 09 Aug 2018 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=tBoTfaq+rjTNagEu7VVLyoz+rhZoWJHqTFZDI+HX1W4=;
	b=cLT81uGEmpJtp5KqM3jg1uffW4Q+XpqiOue7TX4kLt1NFckc4FJWhAcFOzWnTPdE/1
	je3X8hrKjTktOwOex7Sm8yBBpDLSXenKkFzD/LGAg/3wlVqfMe83Wfxtbk7AKFoHCjnj
	JwY3Zg7ZI0jsDWBRg/CrBZagPm2xrHzrIoJmmVtdw0ROa/qtKPIKVkF1jHFCyw5Yh/YZ
	xhNK7gWHem0vc4Q6lohnZTIDTnogX0qLXlniogfJteZAHQIwpzsJZg0ABNCi4lunTemw
	q1uGFtmw0GJAGaIhy0SxTdf7APieIOQ4Z8x69SOzvDrjbmg+idUvQZe7F8s4MFJXi1MW
	+k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=tBoTfaq+rjTNagEu7VVLyoz+rhZoWJHqTFZDI+HX1W4=;
	b=Ba2WNNPmxQfIs689b7rw973jJQEEt9+Y67vtUhn8g0pHALyJhR7ToH/Ut5Q7chHHyh
	eZSKLWq/YM8dImMMzbCnvE/dMf675nA6KzpXeekSwk7qj/hIX74WPPuw/2eGT5FzrJDi
	UGvMHK7UG2uxMOxGBjJhUj5T3vV0S6Aupwz/J+aZdv9l1MjWjSMaP0qli95O1NLw3t5n
	2lAUsupVmG5lMTBnVRuz0bZWFPPPRVOCa2J9Gx6mvJw6vOMTZTAW5AnNyG83Z8GoEMq5
	PY68y0kirVCRgajg4OgZo9IzsVN8Fv0ygjOUfdger6VDvOBFb7urNL3T8X35HXY3DI91
	CW0Q==
X-Gm-Message-State: AOUpUlHCZWL9ADDNfQeStTbVVHPcb4O5Cxmpc5KuN+1I1Y9pRAcssfB2
	FDNO5G0vni4VcsYgG5jWCh1ocwYm
X-Google-Smtp-Source: AA+uWPxfQDdHYAjmvvIO30/yxeLpefhyhqpLGBq0UAsJHncLkhneRsjKawk/HWQ5bXSPaT3JHWDkpg==
X-Received: by 2002:a6b:310d:: with SMTP id
	j13-v6mr3438027ioa.250.1533852645187; 
	Thu, 09 Aug 2018 15:10:45 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:25 -0500
Message-Id: <20180809220840.26697-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 01/16] bitbake: fork: Add os.fork() wrappers
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:44 -0000

Adds a compatibility wrapper around os.fork() that backports the ability
to register fork event handlers (os.register_at_fork()) from Python 3.7

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  2 +-
 bitbake/lib/bb/fork.py     | 71 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)
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
index 00000000000..5ac5aba1832
--- /dev/null
+++ b/bitbake/lib/bb/fork.py
@@ -0,0 +1,71 @@
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
+def register_at_fork(*, before=None, after_in_parent=None, after_in_child=None):
+    if sys.hexversion >= 0x030700F0:
+        os.register_at_fork(before=before, after_in_parent=after_in_parent, after_in_child=after_in_child)
+        return
+
+    if before is not None:
+        before_calls.append(before)
+
+    if after_in_parent is not None:
+        after_in_parent_calls.append(after_in_parent)
+
+    if after_in_child is not None:
+        after_in_child_calls.append(after_in_child)
+
-- 
2.17.1


