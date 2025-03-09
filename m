Return-Path: <pmi183@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6222C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 14:58:37 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.39918.1741618711369261839
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Mar 2025 07:58:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JXjKTwMy;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: pmi183@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so25501315e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741618710; x=1742223510; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lV8We84Pjw5PpmS5W6O9QxOGmQOng57ZRo0j8/mHv0g=;
        b=JXjKTwMybW7YDMXUyYag1M9nkGOeuxh2gtgnfxLMVviUVa2h0U33Sm044Cx/4Zqhhh
         bIznaDafckSWWQ5uuXvtF8Oz9epErJR2tcyrXgM45KpU4kvwHB5TKgEeCky6zRWqNXZS
         afgTQyYTigmH0AacSzCfQi+Tdf4m/wcjQgGor5/oFJTUbsejPaBHO+GHqdW8uQH+HHlX
         XVFCJh3o57HOHgv5tnqGSmyFKWzMpsaNz+Ss/WS+0qKS4gfpdmyMvJ5xTqBXYjJCDIjs
         aX54sLSec4rR6vDq/szQkB4N3UE9OS2mvOynlXXzO+G+b2J/ODoCwrZrtsyeC1YhRAzz
         BQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618710; x=1742223510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lV8We84Pjw5PpmS5W6O9QxOGmQOng57ZRo0j8/mHv0g=;
        b=sbNUTRiQBNXsgOex/jk4X/EI9iH00WnjYj32EcmBxWracOiyiqqHLjZ1Rfdamd2T6j
         d4MlC1uePJKH5mz3bkYfVkE3WQU1lBGm+gZIxDQxlz9wJeGsxTA3xhiaFK2ib5EALaTc
         7QjCn9srxSEPetavL8/97FtDUshw7D6QpKSrJEVUaR3jSlr2Hh0nbGA/+2UEAKKgd+Cv
         42PH62jf9wIJhmJST6DOsWEm/aSwbGZcHY37ZbpL8riZYrp8vVzqyt6Xa5tsywq5K4aR
         hoi8Eyp6wYCDcwzGVhAaJGPX/5bCxscubBJP3GPXvBz1XjhiSJre5rcntkx7w6OYtaje
         Z5mg==
X-Gm-Message-State: AOJu0YykiyMkRvhLQAHdpfMazFvbR8mdgUWPAM3OXbRWz2lHGTtLc+X8
	va5BUAffGonWr9TlI7UcXbjSaF38m4S6Z7feqo7Ry2DNsVa5dDu6ldhigg==
X-Gm-Gg: ASbGncvg3gKo4U3gIxYJ5e5BSGva5Efmc1rruA/NaeE7Rm9/om2wAWEm/moPiBevLLF
	HEGiN7QSPZSc+159bxlCpcqGpSyrbxgcPqGBWGr9NxUOX8Abn7evh/UFo3EPXogtDRtgy1hMxV3
	2Pev11KILtwmFqeKct1orNaGy+Qked/PpWJwyOeit88A/XprI+0cOqajKhVVLVqJiWXhT7j13el
	pOvwfe68us0o/enXME8rOFQPZKI0jirXa/jXXbZ4fXTdqsf/22poSEiT/LVU5M68+bajTY2/BOK
	pEqUqGHnb54devTd/VL0svNg418sxN04+Y283NseTnNXbitmuI4kHC6ljoKeYdoiKZ/AUWtYOXo
	=
X-Google-Smtp-Source: AGHT+IFCDfQmKS4JNhjEnkBGs92XU2T792s9j5qrMxHfg/b1WmQWddsDPMx/uGSTS2956nnG1Dqkxw==
X-Received: by 2002:a05:600c:5108:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-43c5c6a4137mr76178715e9.25.1741618709385;
        Mon, 10 Mar 2025 07:58:29 -0700 (PDT)
Received: from LAPTOP-0FHSM1V0.criticaltechworks.com ([78.137.195.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cebe3f1e7sm76378095e9.13.2025.03.10.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:58:28 -0700 (PDT)
From: Pedro Ferreira <pmi183@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap] bitbake: codeparser: Skipping typing when inspecting Python modules
Date: Sun,  9 Mar 2025 21:59:38 +0000
Message-Id: <20250309215938.1983319-1-pmi183@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 14:58:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17425

From: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>

If a custom python module is added thru BBIMPORTS and it
uses typing(Any,Tuple,Union...), codeparser will fail because
inspect.py raises TypeError exception if the object is a
built-in module, class, or function.

(Bitbake rev: 0ecfd0b8540220633e71d24cd73cc5306863ae3c)

Signed-off-by: Pedro Silva Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Upstream-status: Backport [https://patchwork.yoctoproject.org/project/bitbake/patch/20250307103351.374456-1-pmi183@gmail.com/ ]
---
 bitbake/lib/bb/codeparser.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 1001ca1900..b6e6296965 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -72,12 +72,20 @@ def add_module_functions(fn, functions, namespace):
             parser.parse_python(None, filename=fn, lineno=1, fixedhash=fixedhash+f)
             #bb.warn("Cached %s" % f)
         except KeyError:
-            targetfn = inspect.getsourcefile(functions[f])
+            try:
+                targetfn = inspect.getsourcefile(functions[f])
+            except TypeError:
+                # Builtin
+                continue
             if fn != targetfn:
                 # Skip references to other modules outside this file
                 #bb.warn("Skipping %s" % name)
                 continue
-            lines, lineno = inspect.getsourcelines(functions[f])
+            try:
+                lines, lineno = inspect.getsourcelines(functions[f])
+            except TypeError:
+                # Builtin
+                continue
             src = "".join(lines)
             parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f)
             #bb.warn("Not cached %s" % f)
-- 
2.34.1


