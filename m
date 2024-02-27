Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E64C54798
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 22:04:41 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.2221.1709071478678393391
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 14:04:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=N5henHbg;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e4d869b019so2463465b3a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 14:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1709071478; x=1709676278; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVxlT+L7ovL/yzsh4GRyeN/puMEGuFuZPt8K2Fzba80=;
        b=N5henHbgcdFR7Yzoh4NmQsYLxRch1DS4mNJzODMDLxsX9hHp6gmrdnri/Q1ov3fSqi
         wXebxdw5W4BXKY01zqdkfiPtvbG4pYzRu1Jow6tW3/RrbWgrYPqX+5FWHZpEQaSVHqjR
         BchyYPVuGJDBXBvlhY9QaEH0uWue624iYrn5BNUz3J07JXLd1b3YTMyKJbS1uwRY+ng5
         VgVbx6BRAUplgy3Datmo1rLhCttAqvusWT6M7e58FnH+gMNt4bq5zMM1z5+QahUl/dTa
         /wJQYn3I90bVEwpU2joAjxAmLx3X1MCMoha0sUrH3wRdjAFBoz6ZMe+IQLyP54EJqZ6p
         gJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071478; x=1709676278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVxlT+L7ovL/yzsh4GRyeN/puMEGuFuZPt8K2Fzba80=;
        b=YrYkBauSDvqm9CXl9odfZBvW5X1FbMxpm01CUiNhJMc94wQt851CprkqoxlIvrCBt1
         dD8GfoXIDdp8dwdX8EkjylhwKCyUNin1MFnrzMLHY2Aj36ZznE4F7J1pHFRciAFyXq8A
         qzIZed2TGOZW1i8pMI2pAMkL8Ewje3u2KwJrsQBeMTE82AOW8S0Et/Al+E4HVFhvb93B
         dv8tQkdK+sRvi6+dwwTETj6sK1o7PuIHKh/mM60JQ5zWKytYpJtV0JTjOfDWQDaqIQIn
         CRK6sgvx9gwnvMOWtI8J5ryKkqFZhX3et32amLmlhiV1NxypWZ0sE9olbltF8QB0FWd4
         H2ew==
X-Gm-Message-State: AOJu0Yx0unF2rWkBIBv1cwL3MPkZX33EhHLTDR4MhkJbk+8Wd5Vi7DjR
	QnNL3FvFyD2CiQz/dLMcn5aiAk37AnNn4zHITrBiJ9bUO8AGWDN1XfumKPjd55BYitZJI9XQh61
	I6mo=
X-Google-Smtp-Source: AGHT+IEE/5lqijlcH5hz9e0OV2OjR/m/idd6K5Wza1R/7dn9ZrMkUDS7r3RV/NDCgcCqLi3pM8eU3A==
X-Received: by 2002:a62:ce0b:0:b0:6e5:58f1:cb35 with SMTP id y11-20020a62ce0b000000b006e558f1cb35mr1122449pfg.9.1709071478003;
        Tue, 27 Feb 2024 14:04:38 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id t13-20020a056a0021cd00b006e50c0d6421sm5059772pfj.11.2024.02.27.14.04.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:04:37 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/6] codeparser: replace deprecated ast.Str and 's'
Date: Tue, 27 Feb 2024 12:04:20 -1000
Message-Id: <4591011449212c8e494ea42348acb2d27a82a51b.1709071317.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709071317.git.steve@sakoman.com>
References: <cover.1709071317.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 22:04:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15967

From: Chris Laplante <chris.laplante@agilent.com>

These have been deprecated since 3.8

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/codeparser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 9d66d3ae4..bb890dddd 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -225,8 +225,8 @@ class PythonParser():
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
         if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
-            if isinstance(node.args[0], ast.Str):
-                varname = node.args[0].s
+            if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
+                varname = node.args[0].value
                 if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
                     if varname not in self.contains:
                         self.contains[varname] = set()
-- 
2.34.1


