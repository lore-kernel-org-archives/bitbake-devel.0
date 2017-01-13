Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com
	[209.85.214.45])
	by mail.openembedded.org (Postfix) with ESMTP id 8D41D71DB2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 14:51:29 +0000 (UTC)
Received: by mail-it0-f45.google.com with SMTP id d9so9451751itc.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 06:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=milYHTatEIHdsCh1XKjF4YSUTS44XGd0ZwcokQEUUtQ=;
	b=rOEmZ5N7808239jmpL3Jxj0qquDW1udlQmc4hJ8ho/fRdyYM6LovwhKIzolCRamDg/
	PYQpXSDFkAVd5pYIpM2H2xHUcdCDuO82Ok8m0xuNd5M3N2OUDzac2cYpaYq13hXe0ZOf
	VVTBWvZLS9Q3rT35HJfxHXKiqxpO71L9tiC9frHWldSDLRa3J90nZqzaMfBKTHRpJJO8
	mQaAe4bifRHeYfCmvInTc/G0jE5wfrf3/KZPcqM/Z4u3MheyL7RVnZFpUuC3ZI62Yqqg
	w4yLDzZZRbhJj38ps9wmpui0tWDReiulbrM+O49mivzTAaQFjzOqxjf8C94bmxL4qlbK
	UTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=milYHTatEIHdsCh1XKjF4YSUTS44XGd0ZwcokQEUUtQ=;
	b=RarqEKGeITg/zuHyE6N2ujwGr6B8l+RiAB55B9ukOkPy74VdUccATT21vd3YQWo+7e
	c4MkDvOcbejZNPmZvcLfuSbpCYh+YlNM7cGQZKfYGC5uZnhZBK3ztSjR6wUn4TDGoe14
	3I5iQNDP2zvBt4TVWb42WY8t4sKC2nA6BSxgMndOHNPVo+sbnHQbuByyw08lba4MYF6f
	r050aR+e70htPZHYpyrwL2vERaTZZhfdTPtJggZIm2ER4wAmP31tqkMuv8+HrQ3oSabg
	/OrrYy2dBgOvWr2dmm4ORUGpYHdUlZA6onsOUr+sLQS1qoqNyBJUbgEEuYOfT9J5AuZ8
	j3wQ==
X-Gm-Message-State: AIkVDXKFRMP0H+j0zcOf5GMXlUR1nugT/uq5RaRPgciquymTu1+X77WCXUmRj0g0JMf4o6HX
X-Received: by 10.36.139.133 with SMTP id g127mr2707702ite.4.1484319089653;
	Fri, 13 Jan 2017 06:51:29 -0800 (PST)
Received: from pohly-desktop.fritz.box (p57A56056.dip0.t-ipconnect.de.
	[87.165.96.86]) by smtp.gmail.com with ESMTPSA id
	r203sm1006974itc.5.2017.01.13.06.51.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 13 Jan 2017 06:51:28 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2017 15:51:19 +0100
Message-Id: <1fdc6bd863d02bd90e842558c9a3812aaf0d3f5a.1484318890.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
References: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
In-Reply-To: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
References: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
Subject: [PATCH v2 1/3] event/ast: Add RecipeTaskPreProcess event before task finalisation
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
X-List-Received-Date: Fri, 13 Jan 2017 14:51:29 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There are various pieces of code which need to run after the tasks are
finalised but before bitbake locks in on the task dependencies. This
adds such an event so dependency changes in anonymous python can
be accounted for and acted upon by these specific event handlers.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py     | 7 +++++++
 lib/bb/parse/ast.py | 1 +
 2 files changed, 8 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index e2ca33e..946d518 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -361,6 +361,13 @@ class RecipeEvent(Event):
 class RecipePreFinalise(RecipeEvent):
     """ Recipe Parsing Complete but not yet finialised"""
 
+class RecipeTaskPreProcess(RecipeEvent):
+    """Recipe Tasks about to be finalised"""
+    def __init__(self, fn, tasklist):
+        self.fn = fn
+        self.tasklist = tasklist
+        Event.__init__(self)
+
 class RecipeParsed(RecipeEvent):
     """ Recipe Parsing Complete """
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 853dda8..f3a8a50 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -358,6 +358,7 @@ def finalize(fn, d, variant = None):
     bb.data.update_data(d)
 
     tasklist = d.getVar('__BBTASKS', False) or []
+    bb.event.fire(bb.event.RecipeTaskPreProcess(fn, tasklist), d)
     bb.build.add_tasks(tasklist, d)
 
     bb.parse.siggen.finalise(fn, d, variant)
-- 
git-series 0.9.1

