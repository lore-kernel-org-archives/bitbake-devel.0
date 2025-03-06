Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892C8C28B23
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 15:24:03 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.15684.1741273595776500355
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Mar 2025 07:06:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aegCrWxd;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: pmi183@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f406e9f80so629848f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 07:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741273594; x=1741878394; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H1YWwaPKVTLi+Xvlp0TeyHKg56e6p/u+CYj2/4fzAso=;
        b=aegCrWxdm7AXm5aBe7jhSQk0h57nW1BWWmnWoerpAuyQejVCRjCyABdPB/RVmihQU+
         Ndo/ZyGyVzzaFtzWJ0WglKwGd5qGZj6F62r98R7OvXOIJaIlBz6NonEIvSy/IjgDoMNW
         O0qEFhYozlt5jpQ8qMF+syZTp1RAKmqtUiZwe4HT9J1b2/jwBJQWzXzkE3/1EUqaKBck
         llH5C6Cc/1Hx63ukteVmqsso6Fqo8tgNua9Y2sT6sF248cVCGpOksR4kbN21JnFtGX6v
         9U3P9Xy23i4EbPBn736tPQqjgOc+/oBN9I9BjmDlBR1reQUSafeBbCevw6feU0SZ5Slp
         A+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741273594; x=1741878394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1YWwaPKVTLi+Xvlp0TeyHKg56e6p/u+CYj2/4fzAso=;
        b=TZOtJ9tKAZVkCBpWz3xlAdXzyCkLenls+RqP4lNutekm9q+64f+aQWMGbUll5+plC6
         F0nJvxU2veXU2hVzrZ6cIqeP3xdJyLGb6+RumZVMC3sG/F4r8pLHH3kSbWSAUmSfRzH/
         GbOijeVMe3fSmz5JrX7b1y0Ct28tu/5iSqP8E3G+z2cXJ/7viSACJgFahymvY1MDPzZk
         vhfq+YMtlUHzBa+hlXJPXIJqS9egpZXpCZMeDN9dl7oO4wxvsGjsXZ4AHVm45BTZDcz3
         traXSF/TAV3dAZ4Ky35BfuZIYqAF89tX5m0f8X9YkpYIzvCcckFnyWmg62YvxTkfX9BD
         Ik2g==
X-Gm-Message-State: AOJu0YzWpZntl1ndMXD5zHhi7eislPvezd+CRukrKse73nExP/E8xpHP
	FG+me5KRTjo/e6p+3CtBS6mn69FoTOMs+bDdD7RqVEwSbkNX47Fk4mqEFg==
X-Gm-Gg: ASbGncuZo3dN+jzDXHFDTUHAvxLr+aAGGX5+Z+JazB+ofXAYPeEc5Wchehntpv/l5Hn
	jdOxeVrkPeWLF7xm3xzH4BmSTfyF9p+R/f1fXnfpo9pdxNZVx0C3Fl7TiNcFukoL2geflonRli9
	dd54CBI8xLI01hHk+IENby6ST0LcH8jB565hsSQD3aeug+Bd2anFA0ctDQUx8I1ctohDV6y2sK8
	dXnrLFBi5F1J85DvG4PieWiR2kYm9OXrjvtgiiSdgJEEoP/CJ7/tXKI81/g71e0YnN5nV3SviH8
	5UvIGAepyv+5E2JAc8QTyDjCPZopIB338JxCGVPEIZgLmY4vPdyK29PJ8FrT5U3Lx542hl/pUFE
	=
X-Google-Smtp-Source: AGHT+IH3sJtC7p4QTla3cbntLpWjmaSENvZntt53/RFd3Wii6dnx5QrNkdtIzzdyInp4vhIMHN0+Hw==
X-Received: by 2002:a05:6000:2108:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-3912bcc1558mr1441927f8f.1.1741273593812;
        Thu, 06 Mar 2025 07:06:33 -0800 (PST)
Received: from LAPTOP-0FHSM1V0.criticaltechworks.com ([78.137.195.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfe0004sm2257235f8f.40.2025.03.06.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:06:33 -0800 (PST)
From: "Pedro Ferreira" <pmi183@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Subject: [PATCH] codeparser: Skipping typing when inspecting Python modules
Date: Thu,  6 Mar 2025 15:06:28 +0000
Message-Id: <20250306150628.278459-1-pmi183@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 15:24:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17395

From: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>

If a custom python module is added thru BBIMPORTS and it
uses typing(Any,Tuple,Union...), codeparser will fail because
inspect.py raises TypeError exception if the object is a
built-in module, class, or function.

Signed-off-by: Pedro Silva Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
---
 lib/bb/codeparser.py | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index d249af326..7f6adaf36 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -72,15 +72,21 @@ def add_module_functions(fn, functions, namespace):
             parser.parse_python(None, filename=fn, lineno=1, fixedhash=fixedhash+f)
             #bb.warn("Cached %s" % f)
         except KeyError:
-            targetfn = inspect.getsourcefile(functions[f])
-            if fn != targetfn:
-                # Skip references to other modules outside this file
-                #bb.warn("Skipping %s" % name)
+            try:
+                targetfn = inspect.getsourcefile(functions[f])
+                if fn != targetfn:
+                    # Skip references to other modules outside this file
+                    #bb.warn("Skipping %s" % name)
+                    continue
+                lines, lineno = inspect.getsourcelines(functions[f])
+                src = "".join(lines)
+                parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f)
+                #bb.warn("Not cached %s" % f)
+            except TypeError:
+                # Since Python inspect wont support special types
+                # Skip references of typing special forms, aliases and tuples
+                bb.warn("Skipping refs to %s : %s" % (f, type(functions[f]).__name__))
                 continue
-            lines, lineno = inspect.getsourcelines(functions[f])
-            src = "".join(lines)
-            parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f)
-            #bb.warn("Not cached %s" % f)
         execs = parser.execs.copy()
         # Expand internal module exec references
         for e in parser.execs:
-- 
2.34.1


