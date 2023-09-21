Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0AE7D0B6
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 22:37:57 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.9219.1695335876823830416
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Sep 2023 15:37:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M2WMF0fi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40472c3faadso16221575e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695335875; x=1695940675; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=no75jRREIypbVIqx5vlJ9NXpDodtDvCRqVYoYz8qp/Y=;
        b=M2WMF0fimcWlwk3s1XzHEbwGneHsN2P1qGFySuv3Oduqj6kQ2yJLIzuB8S1EQQ4O2u
         dIo4y15/F6dn47UUm3R9oh4J8VNg/EGobdZpJ8TuSTPnEHdZZ1QUOv0QtMTbhIX+t7DQ
         IodUrFQzqHV/d15GIgkjRqqCK6BZwKjvZmpug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695335875; x=1695940675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no75jRREIypbVIqx5vlJ9NXpDodtDvCRqVYoYz8qp/Y=;
        b=YXbQYmj3Zc8iL2O8Feo/1BRMzbmSlSIGOO+S5QlhZ9OaD8R0yucXTa/o0pMO81CBa6
         5jWDpqwMxm3+Yuu/Qql3lvlCpijjIZz9qE80fzFj8NxkIMFWTLSQ5UwNu8HgY2KGIUKU
         9tOboXagcvUGLoankXSLFMmgIHxJJV1LFTUftm0i9+A3EOsf/fizgjBai2gSDeVkaa6G
         jKe3/lK3nA0um2uvmUWI427AeMQRevUtDrghoidtT8Ji9IiY4r6U+RSlLxsBT72uX1fM
         3O25nQ6fOHLUPLPNsw4YeZLGAYz+XKITct/VPIA2wNEOLap8T8Gm2zX8ysJbTgaEKOFA
         b6ZA==
X-Gm-Message-State: AOJu0YxL2hBpdqsyZSszY0nOxoNn2TQHagDOv97AeBYBx5N4AQ0IuQ9U
	Vj7uF0wVs56An0nj51BYdXdGV+JqP3AU8ufuJVo=
X-Google-Smtp-Source: AGHT+IGCt9lB/4V1yMSiWro6UfFv6hEhcSwwI3rsWUwdS8S3YA4zUIStjrXtXvSAscGDQTnpmFv2dQ==
X-Received: by 2002:adf:ee88:0:b0:317:634c:46e9 with SMTP id b8-20020adfee88000000b00317634c46e9mr6139556wro.43.1695335875187;
        Thu, 21 Sep 2023 15:37:55 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f6e4:1bee:736d:f9fd])
        by smtp.gmail.com with ESMTPSA id p14-20020adfe60e000000b003197b85bad2sm2832418wrm.79.2023.09.21.15.37.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 15:37:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] codeparser: Update debug variable reference
Date: Thu, 21 Sep 2023 23:37:54 +0100
Message-Id: <20230921223754.1333449-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 22:37:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15103

The code has changed and the debug message didn't work. Fix it. The output
is still incredibly useful.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index d6b8102585..eabeda591a 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -82,7 +82,7 @@ def add_module_functions(fn, functions, namespace):
                 execs.remove(e)
                 execs.add(namespace + "." + e)
         modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy()]
-        #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, src, parser.references, parser.execs, parser.var_execs, parser.contains))
+        #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, fn, parser.references, parser.execs, parser.var_execs, parser.contains))
 
 def update_module_dependencies(d):
     for mod in modulecode_deps:
-- 
2.39.2


