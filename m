Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
	[209.85.214.51])
	by mail.openembedded.org (Postfix) with ESMTP id 4DC7471B9B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jan 2017 09:51:05 +0000 (UTC)
Received: by mail-it0-f51.google.com with SMTP id 192so10269617itl.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jan 2017 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=umtPMIjdiE8j95VOyEZ9PAxYqWY4mJOOUlma7NN/VVM=;
	b=fgvC/jSlM7KskLHmk7OxEUHc5PUgnRfOKLbnYJXy3gVj/Rc4o1rWiV06/k05G7672G
	UnNJrbGT9lVP02q1AYsqLK8VfJ1/DrsELIEQAS+vMyCxRdYPB2HkwUyaW9sBOv/Q5obr
	+7VtJewum4xu9tKpFm1Tjq6cE9797dvnCKaFRbQ2Xagk05e4Om8yxKcFUz380xum1uGA
	146aZajJ91f3YoRszEbdPztkOPoLGz3aBkh60g56ZTunJIUC3M/UCHPbjfVHF3ORq4Jb
	bkIP+lWOW7v/aZe1/uPeMa1pAu/BsRrkLL8ghP+1nBoIHPq409ikGa1zTOUfgf1ZDKgq
	ILfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=umtPMIjdiE8j95VOyEZ9PAxYqWY4mJOOUlma7NN/VVM=;
	b=fY924CGwRs9FLiI9B9OXBkR/7UAP/h17MagcZmp6QeeKVRgrvrH2btij8NPgnMCquX
	wejc52mf6m8bzFJ3sGr6PDJVmajHf3JTf4jfRjg1OWNmqpJ2DdlWL3Kou7orFnDs5Cz7
	klY6md0gJfaaJ0m5jhQ6QM0YryQdwU6eQNsiR+d6xhCxU+3zBohGllxZ9ue5ur2a2P5N
	o+jlEIeyAhDhxtQ/yLrJdTocO6V6pXznuD2HYkDvuX1PvtW55i1/WBArS5gUnMyojPIF
	Uw4f2NSlCDMejQxGJVfdIgUdjUuplmAlKAY5QEZ5JQn2KT+C86ptwLeudPy35aDZPklz
	ju9w==
X-Gm-Message-State: AIkVDXLLzVgWvOEylL+oZZVOZI1COgSpHM8w3ANOAvrGu7tH3BiG7pljBqYB8DM8tGOmmZUu
X-Received: by 10.36.48.196 with SMTP id q187mr1703144itq.64.1483696265454;
	Fri, 06 Jan 2017 01:51:05 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8F5BD.dip0.t-ipconnect.de.
	[93.232.245.189]) by smtp.gmail.com with ESMTPSA id
	w192sm1171819itw.3.2017.01.06.01.51.03
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 06 Jan 2017 01:51:04 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2017 10:50:48 +0100
Message-Id: <ff782446708e21947126f1b4fe9abe1059a13af7.1483696010.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1483696010.git.patrick.ohly@intel.com>
References: <cover.1483696010.git.patrick.ohly@intel.com>
Subject: [PATCH 2/3] build.py: add preceedtask() API
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
X-List-Received-Date: Fri, 06 Jan 2017 09:51:05 -0000

The API is required by the revised rm_work.bbclass implementation,
which needs to know all tasks that do_build depends so that it
can properly inject itself between do_build and those tasks.

The new API primarily hides the internal implementation of the "after"
and "before" dependency tracking. Because tasks defined as
precondition via "recrdeptask" may or may not be relevant (they are for
rm_work.bclass), the API also includes support for that.

There's no default value for including recrdeptasks, so developers
have to think about what they need.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/build.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 271cda6..c6104a4 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -862,3 +862,19 @@ def deltask(task, d):
         if task in deps:
             deps.remove(task)
             d.setVarFlag(bbtask, 'deps', deps)
+
+def preceedtask(task, with_recrdeptasks, d):
+    """
+    Returns a set of tasks in the current recipe which were specified as
+    precondition by the task itself ("after") or which listed themselves
+    as precondition ("before"). Preceeding tasks specified via the
+    "recrdeptask" are included in the result only if requested. Beware
+    that this may lead to the task itself being listed.
+    """
+    preceed = set()
+    preceed.update(d.getVarFlag(task, 'deps') or [])
+    if with_recrdeptasks:
+        recrdeptask = d.getVarFlag(task, 'recrdeptask')
+        if recrdeptask:
+            preceed.update(recrdeptask.split())
+    return preceed
-- 
2.1.4


