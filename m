Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102FFC6FD19
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 17:32:42 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.260.1678987960712750184
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 10:32:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LDkoBWLL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id p4so2246942wre.11
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678987959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUxBfaBXwdjmASeK3vRihDBphGgDzOBwE01e8pFyjDI=;
        b=LDkoBWLLz+GxAEJsBfplUvwspym7dKzhTCbLOZA8ZcBKNjX2noXfBHm2tOaj5M0WaS
         UkZicQwccgv7eqtZOzTYoOE6MIe81o2TWDf/5knz8Ku/hvkrCws13TbTv336A2QbPxw0
         KwNrSSxmWM4wkKY7PrjzSGCwZFYm/lB6o3jV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUxBfaBXwdjmASeK3vRihDBphGgDzOBwE01e8pFyjDI=;
        b=YdgC1a1fCMwOGXWb0YRrjD+849i5S6gIkqkzR2Tq8YOxUnJi6/nz/LBy2cVy14vNyI
         VMeiz4of26JmZSxFReG/BxyAgAg6d6Tm84wl1R49xaeqcHycmOOUfJDzy86frgk2CtzM
         GpTZ/gfvBFtBagsAbLXAB1UUHp81dRmxgloJHNp3alJ7pKul/oGz7TE8/Xj4bAUlpj1+
         no2ZAkm06p7zfOpJgjm4lqFo9MxBYvuZnMqdjSljIk4u6F1K4RPfT/kqKiAgRF/v7wOH
         okhsUvvAtnku3wN4Dkl3Im4xTDwzB/0+kYnN3C9DoEvqz6R7cNi/5TwrxGU6ytDLxNzS
         KeBQ==
X-Gm-Message-State: AO0yUKVWtMIKGfdXsYDNl/JiFxFvQWL27iUql61QPj/uoExxF3NNA3GV
	81i9tG82QUwRUhiDnLbK2zedzs0/7tUds3/0oxk=
X-Google-Smtp-Source: AK7set9PKmaVy238yiMEJjEOZMc/UDkTd3aeRsRlx7M0ld2eThaFckEwNYYb6M2Niiqacplp5Vc6Gg==
X-Received: by 2002:a5d:43d0:0:b0:2ce:a608:b5e3 with SMTP id v16-20020a5d43d0000000b002cea608b5e3mr5186982wrr.41.1678987958694;
        Thu, 16 Mar 2023 10:32:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4181:67:6e43:6a9])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b002c8476dde7asm7797221wrt.114.2023.03.16.10.32.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:32:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Add autorev warning when it is set too late
Date: Thu, 16 Mar 2023 17:32:37 +0000
Message-Id: <20230316173237.200263-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 17:32:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14593

Bitbake expects a consistent metadata environment when it parses. There
are plenty of ways you can set a recipe to autorev at a point where parts
of the fetcher have already been triggered leading to obsure bugs which
I struggled to debug, let alone anyone not familar with the code.

If anyone is running into the message from the commit, the issue is
likely one of timing. Keep in mind that the anonymous python code
in base.bbclass will expand variables like FILESPATH, WORKDIR and others
which contain PV. The recipe needs to be set to AUTOREV before that
anonymous python runs.

In particular, that means you can't set SRCREV = "${AUTOREV}" in other
anonymous python, it needs to happen earlier.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 ++
 lib/bb/parse/ast.py       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cf65727a20..c8a6de62d0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -753,6 +753,7 @@ def get_autorev(d):
     #  only not cache src rev in autorev case
     if d.getVar('BB_SRCREV_POLICY') != "cache":
         d.setVar('BB_DONT_CACHE', '1')
+    d.setVar("__BBAUTOREV_SEEN", True)
     return "AUTOINC"
 
 def get_srcrev(d, method_name='sortable_revision'):
@@ -1219,6 +1220,7 @@ def srcrev_internal_helper(ud, d, name):
     if srcrev == "INVALID" or not srcrev:
         raise FetchError("Please set a valid SRCREV for url %s (possible key names are %s, or use a ;rev=X URL parameter)" % (str(attempts), ud.url), ud.url)
     if srcrev == "AUTOINC":
+        d.setVar("__BBAUTOREV_ACTED_UPON", True)
         srcrev = ud.method.latest_revision(ud, d, name)
 
     return srcrev
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 375ba3cb79..206757d5ee 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -400,6 +400,9 @@ def finalize(fn, d, variant = None):
 
         d.setVar('BBINCLUDED', bb.parse.get_file_depends(d))
 
+        if d.getVar('__BBAUTOREV_SEEN') and not d.getVar("__BBAUTOREV_ACTED_UPON"):
+            bb.fatal("AUTOREV/SRCPV set too late for the fetcher to work properly, please set the variables earlier in parsing. Erroring instead of later obtuse build failures.")
+
         bb.event.fire(bb.event.RecipeParsed(fn), d)
     finally:
         bb.event.set_handlers(saved_handlers)
-- 
2.38.1


