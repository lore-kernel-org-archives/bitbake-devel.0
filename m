Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B953C433EF
	for <webhook@archiver.kernel.org>; Fri, 13 May 2022 12:14:01 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web12.7451.1652444035485250711
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 May 2022 05:13:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=MS30/Aut;
 spf=pass (domain: gmail.com, ip: 209.85.218.48,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id bv19so15884568ejb.6
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 May 2022 05:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozWshONYZCdconwmrSdUmNLdpHyGqtAqy9A/RdECb6o=;
        b=MS30/AutevP3B/2RdWTPAwxHkrY9ifEWXZagYjkiHPr4Q02S14py+r0p+ZD9LE7oce
         bFjwcgzdJnVzM9nSkDekOsbkkwe0HAxJsO/tGzBJatThgKd3YJFPb8FIZaoue10uHEFm
         faI9r+sNpdobrVRI5XFdl75P9jmrG4VVUI5OJcZjuLwYIg/h/xLsL3AguLRDYVAeKl+w
         2VixojotYGURzS4otUbO5CkJu9ojgH3lt/EcBfXNprkeiqBN20Lcnk/0bO9GfDz7wLB1
         gpSZZEdz4/WKVEbgmPzefLCfwWi5AWKVA2rG+cwPpGolk2num8psIFF6hwqjDuHApsqS
         H0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozWshONYZCdconwmrSdUmNLdpHyGqtAqy9A/RdECb6o=;
        b=L8NTCznVlRhfRpZ0B/RYuAWzGOW8gRJIeFWwEDU7uXrUOVnnpo3j1gANQF7yuHg8Nv
         lUrVs9UEO2Yp5EzdqBCS/NPJg67kSUlhxJBEZkMQ0oeT3u69IrzpBM33moHRtUl0ok7P
         BlT0kaXrPPwtH9WxNjPQW2ymY9OPWr/maVpaZpqh5A1cehHHTqS+eI8T3GY/eesVrbTq
         QdqL4E8c0tQtvJk6PqoyV9yALSmoPntV5MdcCaW0r6Sel9Z213+i99yzlfU67VxSmPiA
         74BrwrQRJ0UICrNvGYtTlN2J6tlWiSbQhslEQiEEGamcB7t9/O2KXu5eFTAdw7ciQJ4m
         noZQ==
X-Gm-Message-State: AOAM533J2nkiICMfWPRF6Gw8oS+NgOAAE8U0NSUkHA+wgeMNs8yyFJP3
	r7M0OfioY62SHrhgLj0RY9ezhynudbHG5Q==
X-Google-Smtp-Source: 
 ABdhPJxGtLUX7JG3lKlQIYtAeoFKHIF8cp1Rb18Hw0eKxLZFdYkeO1be2ZJ++fQBgx7P8tx6unLAIQ==
X-Received: by 2002:a17:907:96a8:b0:6f4:45f1:6e76 with SMTP id
 hd40-20020a17090796a800b006f445f16e76mr4209161ejc.186.1652444033477;
        Fri, 13 May 2022 05:13:53 -0700 (PDT)
Received: from localhost.localdomain ([37.120.211.126])
        by smtp.gmail.com with ESMTPSA id
 eb20-20020a170907281400b006f3ef214e4fsm695956ejc.181.2022.05.13.05.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:13:53 -0700 (PDT)
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH] data: Do not depend on vardepvalueexclude flag
Date: Fri, 13 May 2022 14:11:16 +0200
Message-Id: <20220513121116.12271-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 May 2022 12:14:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13701

If SRC_URI contains python function that extends vardepvalueexclude its
value is being tracked by sstate-cache, which can lead to rebuilds if
value is set dynamically (for example gerrit replicas).

Return empty string if vardepvalueexclude is checked to fix this
behaviour.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
---
 lib/bb/data.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 62ec2147..c09d9b04 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -277,6 +277,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
     try:
         if key[-1] == ']':
             vf = key[:-1].split('[')
+            if vf[1] == "vardepvalueexclude":
+                return deps, ""
             value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
-- 
2.36.0


