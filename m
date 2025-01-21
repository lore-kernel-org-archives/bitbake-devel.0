Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF340C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 15:28:43 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.18563.1737473320044226326
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 07:28:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F0Y6BMUv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43690d4605dso39943325e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737473318; x=1738078118; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TOmcD5Fk9hrRMqg7glXdwTdI4y7hT0hO7R1qyThlAM=;
        b=F0Y6BMUvgLy/AdZj0JpcdGz6AjehQwlUq7IS6CJhmdRp9t5DhLh6gqGHT2YTFILRR6
         0XaW1LAnlVw5eFbyuFA9o73UuqkyluTUvYGvfAhf+L9uLspIxE8ewDXcTNJdkcad6pcL
         pjuKQBJTCGCVdkeBSxNM6S5mAaAN+eFrAxs2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473318; x=1738078118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TOmcD5Fk9hrRMqg7glXdwTdI4y7hT0hO7R1qyThlAM=;
        b=ELJLP132QPe8AVedeun6bcNg1xfhAhNkzTp1zCwpiaYMo8kvu8ZnbhZ0oLXuOmQsVZ
         smgypUU0ixF/IrcIOrwPGZAxTchaGr41bNLnlRvBgDATnWoe1S0KEoy2U2I4cxIRUxr6
         Ok5SyLs5C8aHzA3eF46ptZjJomN+Ku887ZkUlZgSo/8qbl/jtPS9KkWuxofKGWGm0VrD
         wLKEE2jSOgdA8cEtHp7WzYIwDWWvbvLZDt2wI78gb3b/FnvzVlRXBLU8HJu5feJHR0nd
         FAfKvrVbfYy9RY7hcSjjgaMw9+PdabDh8SXlKUKD2ewlgemjUnTJE063C7hd1qUrt4hF
         WoWA==
X-Gm-Message-State: AOJu0Yyhdwg+cuHmm/jHvTCxzoEVcBvcRyqMZn/8UM0zva3YYKuXvF/t
	PC3i5GDhvQb9NE5BNAjBoyDP7uI3A/zFJowGDykIi2BJkUrQwII/UVzMsDvGFE47eyrPKsiXcSE
	p5B4=
X-Gm-Gg: ASbGncsao1koGNKZ7mc6IxSZmJa2ZlOwJOag7WuaVm064Q0b0evtxPsPGam57etxi9U
	F/TfLn70Z5wWkmgjNC343z21W4sjxB2CYiIYIH5D6wbRRQoGuK4IR0vljI6tNFyzQMPtazb3ye7
	ZfdTyMMl9oX4aVZD6JeeiSAgJ1iwp3X0rLs2KZZJxfYYT8h4SfySN2I7+xwxUbwsSeqWWhHNVzm
	UD/dASu9u5rjwMtS3LuuHS1z+KpYrvyJ7ZF9ZNxVIgWP6CvERE7A7iTVeoxfW0YdK0o3nHCTVE0
	v/9rv7CbDcKK9wrpKCO6u68=
X-Google-Smtp-Source: AGHT+IHVVbnWazmZB3vK0r7lS2evMAaMncrBHag5UGZuD7neHVX0or8n+hG+3J6jOSFco/m1Zk/4Xg==
X-Received: by 2002:a05:6000:1faa:b0:386:1cd3:8a0e with SMTP id ffacd0b85a97d-38bf57c034emr19684917f8f.48.1737473317659;
        Tue, 21 Jan 2025 07:28:37 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fff5:d00b:f6db:4bc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a934sm13404165f8f.42.2025.01.21.07.28.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:28:37 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] parse/ast: Add support for BB_RECIPE_VIRTUAL_PROVIDERS
Date: Tue, 21 Jan 2025 15:28:36 +0000
Message-ID: <20250121152836.1829193-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 15:28:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17039

Currently, providers are set on a global config basis. This change allows
for a select set of providers configured in BB_RECIPE_VIRTUAL_PROVIDERS to
be selected on a per recipe basis. This would allow for the selection of
virtual/cross-cc as gcc or clang for example in OE-Core.

DEPENDS and task flag [depends] values are processed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 30ede008d7..290ed45048 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -440,6 +440,30 @@ def runAnonFuncs(d):
         code.append("%s(d)" % funcname)
     bb.utils.better_exec("\n".join(code), {"d": d})
 
+# Handle recipe level PREFERRED_PROVIDERs
+def handleVirtRecipeProviders(tasklist, d):
+    depends = (d.getVar("DEPENDS") or "").split()
+    virtprovs = (d.getVar("BB_RECIPE_VIRTUAL_PROVIDERS") or "").split()
+    newdeps = []
+    for dep in depends:
+        if dep in virtprovs:
+            newdep = d.getVar("PREFERRED_PROVIDER_" + dep)
+            if not newdep:
+                 bb.fatal("Error, recipe virtual provider PREFERRED_PROVIDER_%s not set" % dep)
+            newdeps.append(newdep)
+        else:
+            newdeps.append(dep)
+    d.setVar("DEPENDS", " ".join(newdeps))
+    for task in tasklist:
+        taskdeps = (d.getVarFlag(task, "depends") or "").split()
+        remapped = []
+        for entry in taskdeps:
+            r, t = entry.split(":")
+            if r in virtprovs:
+                r = d.getVar("PREFERRED_PROVIDER_" + r)
+            remapped.append("%s:%s" % (r, t))
+        d.setVarFlag(task, "depends", " ".join(remapped))
+
 def finalize(fn, d, variant = None):
     saved_handlers = bb.event.get_handlers().copy()
     try:
@@ -465,6 +489,7 @@ def finalize(fn, d, variant = None):
 
         tasklist = d.getVar('__BBTASKS', False) or []
         bb.event.fire(bb.event.RecipeTaskPreProcess(fn, list(tasklist)), d)
+        handleVirtRecipeProviders(tasklist, d)
         bb.build.add_tasks(tasklist, d)
 
         bb.parse.siggen.finalise(fn, d, variant)

