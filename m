Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id 7132871DB2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 14:51:32 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id l66so45037533ioi.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 06:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=1QNULyWZs1QuQINYGhmIw3AVoX2/yj1jkUdYa23j2VQ=;
	b=QfsOkY1tixYzNVSvkt27DwHR6cuCOcsOueDcUOqasZBCKm8IjG2f+eigIzP7yf6XnV
	w22VSdcdyudjyq07NaId74/6i/Pzveh1MZXyG00YbH4tdw6F64HsY3CsPca6tlCnXgMW
	qfvMHmYF4wUDJiktfnYk2o8KwWS2vJL6gvouRgDWfMkUZ+2Gh0nFJdF2A8f5cIuoLVr/
	T+eDA5FZImjrRQBSUPbMEKb+o8/Q/aIXLVjiK/1G7uJfua5G5VW4Dx4I0oCvMCn4FhRr
	bEoTiD0t2cRG8NuP/oflMgz/nJ48507My/ivYBwJ4ffeGTQm8TLNzDv3wlH39JpAryow
	5GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=1QNULyWZs1QuQINYGhmIw3AVoX2/yj1jkUdYa23j2VQ=;
	b=HB7LjM9/JdvsqW2EW40gi3mc3eU6zhOCSFX/E89w5eb5dVYSxEuv6bey9OYQ+CvTqg
	HI9Wdm2rmhoquhEfEl1dTleaxI+3mvXMVSfTp/5JxEgV+usVrCaUuweh4/p4XAnTMau3
	YgBKanYawfFWZf6PYmq6M+FKrIcytjKq3f1ZcMMm/Seb1kZSO777x5PVXEBUCBpfS8fx
	r3/BF7DMdLOq82sp2Fj3YWY0vei5peLTbjsOAQZYxjX63HRibXaOq2jltxmZp/7aEJa3
	aGb21zq8TZuP4jSnL0FNauBHV7V/SYC7HeihUaNQtinbgS/f2AJRLucMaYGM+aE4STx7
	s+qw==
X-Gm-Message-State: AIkVDXIenKV725B49AATvjmqTtRfqhriv+MWZogA8G3AGU99/JVOQSgtfsju42cOhbqGJSAE
X-Received: by 10.107.10.31 with SMTP id u31mr18385550ioi.157.1484319092252;
	Fri, 13 Jan 2017 06:51:32 -0800 (PST)
Received: from pohly-desktop.fritz.box (p57A56056.dip0.t-ipconnect.de.
	[87.165.96.86]) by smtp.gmail.com with ESMTPSA id
	r203sm1006974itc.5.2017.01.13.06.51.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 13 Jan 2017 06:51:31 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2017 15:51:20 +0100
Message-Id: <8c16e8d0a242976b5675ee79cb0fcebd5166dd6e.1484318890.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
References: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
In-Reply-To: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
References: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
Subject: [PATCH v2 2/3] build.py: add preceedtask() API
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
X-List-Received-Date: Fri, 13 Jan 2017 14:51:32 -0000

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
git-series 0.9.1

