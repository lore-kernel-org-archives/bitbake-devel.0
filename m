Return-Path: <marciohenriques84@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81956CD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 16:43:46 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15985.1778777018638109263
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 May 2026 09:43:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GrTka13h;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: marciohenriques84@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso51297925e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777017; x=1779381817; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoeWRdcon/Cm1LIqdOmZUDt8JLPMOaxz/JW2z38KlxU=;
        b=GrTka13hCw+xqlM2tIzBzWWLs6aEgOL0h2+y871k0YhqjSAewfBPMhwfezHf35z210
         ITuTsZruY5lGpWjJKB3eGs3+dtJUSXluOk9zxxIx5DoBkqYWIeIMAZlmT45imuMeH18g
         vYkwGdSz7RztBgLmW5z5cWX/gO7tliGQwzKXy4uA1sbZ6djIa46QIKqvGhUrgATLe/Gf
         URv92m7K2SW+ptPOmNu7TJcodqNp3JFSAhxHhWFgpyidHsQP++Fyi8iCOb+lSLpCsGIv
         b2OQGJoSYVbrfdxg0VexCSdohDJslaGBXFfUsP5ggiseTf5nEfhCiXkEq0A4j8qw7P2q
         8awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777017; x=1779381817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoeWRdcon/Cm1LIqdOmZUDt8JLPMOaxz/JW2z38KlxU=;
        b=lJIy/lYbT4JJLlh3NItpRQMdg80YeZ5jnaRHQUNnriBZJr79sZFNQFlKPg9RyX2oEF
         KiOapXPo+j5reAfhHHEIt6OvYjLfTAHCFLdDLX1RxIbvE2uPlwYL4MBodZXwLNsHNvBg
         B3yO15aQhXmhSBN/EM69GZ+Q3Fh5qCSxQwxfvkeqnFuMUvVnr/UHzUYOZ+N48w4q016F
         rQMW+SYGxpjuRj3II4CZSB11NkN2upYB555eck/aXVL05Vhfzlp0TddHvK8z6VxlgXyN
         M8/p4NftGF4J1hlZwMsP8SV0+7CroVb0/d+ehmFYRGvueWWkVlhPqaVh3rXD3dwprh36
         wucA==
X-Gm-Message-State: AOJu0Yw4rBJoVP+k+WVZYF4oNXnmolgcat3PMH5ZOMNFUbUlxeflBfjS
	RZIkuFDKo65ZCafo78+QzA1SRVGSJclrsB6iwFWVM95s1ZLP1U1P4VQvIPlLz0mH
X-Gm-Gg: Acq92OGPYSvwOZholiJLIbixHBxikUPxAT1LPW5rjYNLS7lyMTGm/trpAeUYGw12iR4
	uoOIKBNAq2CVU2mRaSSaWB2Qg9yCru3RcJmXvWsfWnQx1KijQxx2FU09VTzk6pHAOrYLF2rmUcD
	ndb8kbXsD5wkLFrhyJfR77uyJPv0N/hbGH0rTV0hg2/OFqQwOQ9+u6Ms0hy1M/mZJiPhD0evnLI
	ZIg6empc2L3QCayl/mItIhJ6lTYcsHjVfVthdXKkfMz3yypK/hM5kYXD5Z5StE6PgU/rRVxBBGZ
	0uVmvqtIo68Pocl8vnIL6nL5A4LpWymTqj0WHwExfDmV57ysivL0tZN6Df9j6wOxockXUkQb4Jh
	cj4hX+aaJ9DIUgqIpaDKuzPoqyrBLNQlxL6Lz8QCB4QEiSyWUaHbAGzASKqkHiJ1ZBNcYTKH1+C
	a1tvd/JkqYxOwYHD4l88IldOQdYxE8W9xIjDdI+qBTLt1i/Gpkw7JZiaBe11JuOfYG7Hmfrxk4A
	dgDRyBLikAFKHeraNy77DqelpaukqV9Ubw07tQCl2CJepKOJaBQMmfh
X-Received: by 2002:a05:600c:a11c:b0:48a:5970:2003 with SMTP id 5b1f17b1804b1-48fe5fd483amr2193165e9.3.1778777016967;
        Thu, 14 May 2026 09:43:36 -0700 (PDT)
Received: from PT-PF3LTRXS.critical.pt ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm8866125e9.1.2026.05.14.09.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:43:36 -0700 (PDT)
From: Marcio Henriques <marciohenriques84@gmail.com>
X-Google-Original-From: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marcio Henriques <marciohenriques84@gmail.com>,
	Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.8][scarthgap][PATCH] data: fix issue with varflag exclusion
Date: Thu, 14 May 2026 17:43:31 +0100
Message-ID: <20260514164331.3588-1-marcio.henriques@ctw.bmwgroup.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 16:43:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19522

From: Marcio Henriques <marciohenriques84@gmail.com>

This patch fixes an issue when checking if a varflag
can be safely excluded.

BB_SIGNATURE_EXCLUDE_FLAGS lists variable flags that
can be safely excluded from checksum and dependency
data for keys in the datastore.

When bitbake checks if a varflag must be excluded it
checks if the varflag name is part of the string stored
in BB_SIGNATURE_EXCLUDE_FLAGS.

As an example, if the varflag 'filename' is in
BB_SIGNATURE_EXCLUDE_FLAGS, the varflag 'name'
will also be excluded because the check will return 'True'
when checking if the varflag is part of the string with
the varflags to exclude.

To fix this issue the string from BB_SIGNATURE_EXCLUDE_FLAGS
is converted to a list before checking if a varflag is part of it.

Signed-off-by: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8ab71d0ce302521da6a7e18c887cd85d9a94e8ee)
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index f672a844..53a7a092 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -377,7 +377,7 @@ def generate_dependencies(d, ignored_vars):
     mod_funcs = set(bb.codeparser.modulecode_deps.keys())
     keys = set(key for key in d if not key.startswith("__")) | mod_funcs
     shelldeps = set(key for key in d.getVar("__exportlist", False) if bb.utils.to_boolean(d.getVarFlag(key, "export")) and not bb.utils.to_boolean(d.getVarFlag(key, "unexport")))
-    varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
+    varflagsexcl = (d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS') or "").split()
 
     codeparserd = d.createCopy()
     for forced in (d.getVar('BB_HASH_CODEPARSER_VALS') or "").split():

