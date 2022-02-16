Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42132C4332F
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 11:32:07 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web12.10614.1645011123351027335
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DzA10kxZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id
 x3-20020a05600c21c300b0037c01ad715bso1377202wmj.2
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0vNaQVkcsQcQAXLW4sZiAVr2DYmpK530NHp6vGPxSWQ=;
        b=DzA10kxZjhUAUzbomJtMsexPHaaF31uyAhW9lJFb+QV00eAyRcfOv5nz+6NWFkMlhI
         YcKY0bU0L/w1rF9bbIev6ZNV6g3oWxD066fE/X9K6hkRVj/mjTIZ+Gds2NMeTzdDGO+u
         TubQTx5fd1BKiZOlj1JHwreZKzhIs+D34GVYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vNaQVkcsQcQAXLW4sZiAVr2DYmpK530NHp6vGPxSWQ=;
        b=rb/Xg25yjZkdXxpREAb7Fj9hWUAhv5mES1jy/aJhJhsaJW4vx8hvesu/z/fYDqXq84
         X8NRZT4lLdqqZxXJeTB1vJHsRdrAqNcjzDGwsT3wCo+G/VpD28Fiq5jLu5IFnMr+IC0A
         qUm+IfKU3SgOhsfNK/7gRQxU/TbVKOezZV3KftGFXT+ZBlnLuvrVHh3Goe0qjfyq+5dD
         IDLtQnncSIQjjnyzhL4+C1Ji4Q3I52Ci0MmtkhBIBNwSN78He8vpx7qnuTrT//wNe+Sf
         YJfdvnRSYe+YddjXtjyCjKTHoT3IAzo75OxCLob7j53MwkXcnNeLanRE8wFSuko2ttQO
         P/rw==
X-Gm-Message-State: AOAM532Qsu7DZSJ3jofB0XUoi3oDAps5IISs2OAPLb8SumnvE1XOgBPQ
	RjsZ+r8igfO5g3aB6Igzxj2F8cxMGcpl4AOP
X-Google-Smtp-Source: 
 ABdhPJz6fTr69RuT+pM6ZLBcXRRVukCIndmTepATowafFcjpOdmrBpABGJQqelSp/k0NJjEv8HKmaw==
X-Received: by 2002:a05:600c:49a9:b0:349:bf22:468b with SMTP id
 h41-20020a05600c49a900b00349bf22468bmr1210625wmp.136.1645011121391;
        Wed, 16 Feb 2022 03:32:01 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a680:61af:4a53:1ad3])
        by smtp.gmail.com with ESMTPSA id
 x18sm35476238wrw.17.2022.02.16.03.32.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:32:00 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/5] cooker: Improve parsing failure from handled exception
 usability
Date: Wed, 16 Feb 2022 11:31:55 +0000
Message-Id: <20220216113158.2899964-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
References: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Feb 2022 11:32:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13352

When a recipe raises a BBHandledException, it means the error was already
shown to the user. Adding an additional one here isn't helpful. What is
helpful is to mention that parsing was halted.

Tweak the code to do this with improves the messages the user sees
and helps understand what happened.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 08e45e79d0..d1d4e32595 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2167,6 +2167,8 @@ class CookerParser(object):
                                             self.total)
 
             bb.event.fire(event, self.cfgdata)
+        else:
+            bb.error("Parsing halted due to errors")
 
         for process in self.processes:
             self.parser_quit.put(None)
@@ -2257,7 +2259,7 @@ class CookerParser(object):
             return False
         except bb.BBHandledException as exc:
             self.error += 1
-            logger.error('Failed to parse recipe: %s' % exc.recipe)
+            logger.debug('Failed to parse recipe: %s' % exc.recipe)
             self.shutdown(clean=False, force=True)
             return False
         except ParsingFailure as exc:
-- 
2.32.0


