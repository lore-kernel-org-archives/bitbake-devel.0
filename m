Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5EFC52D7D
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 15:53:46 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.49913.1723478021141851456
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 08:53:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VjbcUDKn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so34688815e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723478019; x=1724082819; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+x2qSsVcwjRJDx93qCaA8G7lFTNpH0tDZHbg6IHE18=;
        b=VjbcUDKnjXe4rmd4Um6zZfkRHnhmv6SZiSJSGoq/M3rvFzf55Crub2z8p321EE/DZK
         dFD+F3x7+xOQe+tQEhD3M51CVwOh65CKDrVBt7daqYmAKk3bNFxKytpLn7fw5oRPzC3e
         AfZ33RqpKCqTfVyLDfWKpMIEKhdDL0kXYnBq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478019; x=1724082819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+x2qSsVcwjRJDx93qCaA8G7lFTNpH0tDZHbg6IHE18=;
        b=pqIc/sIcs80J5r7U9pAev2tVCKcWM82ZdH7By1PO7bJ9EvNuzZg0F8noFKHfMAnAV+
         VC/zepDvZEou9VFnpVEx98PiqwL2DH4Aovc1QpKWEswwlGu4cPfzVLdRaOrx8SulKWo6
         EdtNRNKosySc12TWms6q3P9ZoSv5K+EFmLx6y4/4GR7jeUgoF6pi0qDW3NJZi1Ncy4Oi
         G8PXRYZtWSKeDkGYlfFFxwhfGedsXvn2RJQqxJOgNl8x+R07r9WIxqAXOTIusKEJHKpJ
         sMON9a2s3s/1MUq7bAd0qhyI1I6q0BLp/d2I1sJdyMaj280vboA28SVXBxq4YTTwtg/R
         CeOw==
X-Gm-Message-State: AOJu0YymsH7f86792xVXKINnJ/tLRjzBIuV/AvfrZBk9fCyomKndNHey
	7PCk/7YYW9bAb0jMNZPF3gwwTpAEtmjdJe1uJYOqJRQ8HV26/7O3y/CvWmWbLOSzDnx4FrI4JUN
	Ty/I=
X-Google-Smtp-Source: AGHT+IFu7P68bOKIGUAp+Ge+YGW/JBhMKzOPbhe0hOJaTD+9DNdSAqeaYrzPBFRx2T788TExSxTAgg==
X-Received: by 2002:a05:600c:548b:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-429d486fea7mr6809075e9.27.1723478019215;
        Mon, 12 Aug 2024 08:53:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:450:fb95:e7af:f3ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c77372e8sm109970015e9.33.2024.08.12.08.53.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:53:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] build: Ensure addtask before/after tasknames have prefix applied
Date: Mon, 12 Aug 2024 16:53:35 +0100
Message-ID: <20240812155335.904273-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
References: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 15:53:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16474

"addtask do_XXX before YYY after ZZZ "

where YYY or ZZZ is missing the "do_" prefix don't work as expected. Ajust the
code so that it doesn't just silently do the wrong thing but works as expected.

Expand a test case to cover this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py       | 13 +++++++++----
 lib/bb/tests/parse.py |  6 +++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index ab8bce3d57..d226aadacb 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -932,9 +932,13 @@ def add_tasks(tasklist, d):
     # don't assume holding a reference
     d.setVar('_task_deps', task_deps)
 
+def ensure_task_prefix(name):
+    if name[:3] != "do_":
+        name = "do_" + name
+    return name
+
 def addtask(task, before, after, d):
-    if task[:3] != "do_":
-        task = "do_" + task
+    task = ensure_task_prefix(task)
 
     d.setVarFlag(task, "task", 1)
     bbtasks = d.getVar('__BBTASKS', False) or []
@@ -946,19 +950,20 @@ def addtask(task, before, after, d):
     if after is not None:
         # set up deps for function
         for entry in after.split():
+            entry = ensure_task_prefix(entry)
             if entry not in existing:
                 existing.append(entry)
     d.setVarFlag(task, "deps", existing)
     if before is not None:
         # set up things that depend on this func
         for entry in before.split():
+            entry = ensure_task_prefix(entry)
             existing = d.getVarFlag(entry, "deps", False) or []
             if task not in existing:
                 d.setVarFlag(entry, "deps", [task] + existing)
 
 def deltask(task, d):
-    if task[:3] != "do_":
-        task = "do_" + task
+    task = ensure_task_prefix(task)
 
     bbtasks = d.getVar('__BBTASKS', False) or []
     if task in bbtasks:
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 97df2c4590..410679d5a1 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -188,6 +188,9 @@ addtask do_mytask3
 deltask do_mytask3# comment
 deltask do_mytask4 # comment2
 
+# Ensure a missing task prefix on after works
+addtask do_mytask5 after mytask
+
 MYVAR = "do_patch"
 EMPTYVAR = ""
 deltask do_fetch ${MYVAR} ${EMPTYVAR}
@@ -198,7 +201,8 @@ deltask ${EMPTYVAR}
         f = self.parsehelper(self.addtask_deltask)
         d = bb.parse.handle(f.name, self.d)['']
 
-        self.assertEqual(['do_fetch2', 'do_patch2', 'do_myplaintask', 'do_mytask', 'do_mytask2'], d.getVar("__BBTASKS"))
+        self.assertEqual(['do_fetch2', 'do_patch2', 'do_myplaintask', 'do_mytask', 'do_mytask2', 'do_mytask5'], d.getVar("__BBTASKS"))
+        self.assertEqual(['do_mytask'], d.getVarFlag("do_mytask5", "deps"))
 
     broken_multiline_comment = """
 # First line of comment \\

