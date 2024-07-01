Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB386C2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 12:53:05 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.19033.1719838381946147745
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jul 2024 05:53:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fRYs8p6/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42562e4b5d1so21560025e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jul 2024 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719838380; x=1720443180; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4u17GhuiPBXYVluaTgImgNLqsTOHr6oRHgfMtg+ZFvk=;
        b=fRYs8p6/4TD5Pf7ywBr30Rb1Ws7NGYORAdJEXk+HvL/wDybE3Vtoatn7fSJThrr7jN
         BAmIbfKukMAkim2mRMJBFyVagSs5+KpppHUM6R8NJ8spGz4XoQi1kdU6sFoY6sjRRaB8
         TjzoqS9NN/E7+VrWlP2aAug3S4Hrm7Yr8bH48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838380; x=1720443180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4u17GhuiPBXYVluaTgImgNLqsTOHr6oRHgfMtg+ZFvk=;
        b=YTl/rqUz5DnpCZQMR4lWx3Eytr3OU8YQqZcHickt2t7PbY4EDUPvkE7dijymeKUzCf
         a+/NYCv95UrkAh6NVQtLo4s5IwEcoeZsroyRIqO7xea/aKQ6shoslYuZUzd31yJ9jxAB
         zOETFJWTfcKiok2LtDWOi1HkOab/gxWD7hF+wQpA/QA5lmtcOkDbpQg4jrAqo6kW3KZU
         BtnZB8xjafMjDhOwYAFFS1juAYIFSiQF4Zl11Sf28bqZU4uWWGl56HOWO0Wpb2qvEP9z
         RKQDM4tahMt2xA2tjd+NCuO8gV6LDGIomY8PitXJXKQYCv3Pv32eT2MFK2ik4MwsZ/mL
         YeUw==
X-Gm-Message-State: AOJu0YwE8CyG1s751LjcHer/4w4eS4gEOi5oqzQMMHFiuNzPGt7JjQ8d
	fZpjzY1E/uVnXV9AWZZVlWbgXBIFRwXLg/gAwpyO5vdhTVDdfw+IDpxRYEYF/uk/pmhiZpuVCdm
	5
X-Google-Smtp-Source: AGHT+IH23o2gVYGixnbI6Y2rHdr6+38eZNh+t52/x+tdTSX92FLuzjjSBUdXTYlKa8uzMn95Ijzx+A==
X-Received: by 2002:a05:600c:3515:b0:425:6f85:6013 with SMTP id 5b1f17b1804b1-4257a00aaaemr34234245e9.8.1719838379624;
        Mon, 01 Jul 2024 05:52:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:476a:5554:3166:a3c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4258014f8b7sm57146005e9.41.2024.07.01.05.52.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:52:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] codeparser: Skip non-local functions for module dependencies
Date: Mon,  1 Jul 2024 13:52:58 +0100
Message-ID: <20240701125258.2605493-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jul 2024 12:53:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16382

If modules do something like "from glob import glob" then we end up
checksumming the glob code. That leads to bugs as the code can change
between different python versions for example, leading to checksum
instability.

We should ignore functions not from the current file as implemented
by this change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 4c4758ecbe..b25a2133d2 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -72,6 +72,11 @@ def add_module_functions(fn, functions, namespace):
             parser.parse_python(None, filename=fn, lineno=1, fixedhash=fixedhash+f)
             #bb.warn("Cached %s" % f)
         except KeyError:
+            targetfn = inspect.getsourcefile(functions[f])
+            if fn != targetfn:
+                # Skip references to other modules outside this file
+                #bb.warn("Skipping %s" % name)
+                continue
             lines, lineno = inspect.getsourcelines(functions[f])
             src = "".join(lines)
             parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f)

