Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA6CC46467
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.209996.1672333657013717810
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NIb4BdP1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id y8so17878408wrl.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10952peMSbCjNKygbzkhlQaifYsAkrqPX0YF0GHq3fU=;
        b=NIb4BdP1BEw9cvUJUzKdF3Ej3AAcSgzPKjBnwnUbdBs79JAjaZSjHcxe4K31C7T9wO
         v4X5n6++q3eD3+z59rYBf6IlMavXNw//JeKsi5cLkCfn/lxyRq6T47JUtVdyQGYV619l
         TocedMMmbGUMcnXzzNPrlt20Ul3q0JY4GfinY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10952peMSbCjNKygbzkhlQaifYsAkrqPX0YF0GHq3fU=;
        b=W43n/fQjvfcxjPK6eng4ODAJhDsOZnbOfiTfilx7poIaO7plee6ZdfKBNX3cBvb6b2
         ZVP0mOo8xbAtIYNrK/IwHYILub6td1XB9F9jN+iykGfWJkdE/xM5OjXkYyn8QYyyMXjs
         8mN/z4oYKnzsJmjnJtzNRgUFZFzlRlX9EqXCdTZT7Oqwuh6pll3/Hh80mdfxkZejzydD
         Aw6f3udH/ivka/ef2JGWNXcgI6EHNTYXVIOHJxgM1eu83rISj0zzNf8xK67je4WaMsvc
         W9x2NR8acdmoilNQIkqGVQVWld0J6ptIx2Gj8orlNgw7PI9A4y5ShPX1ADRGuaUn88s2
         GO4A==
X-Gm-Message-State: AFqh2kqLMHzkr93nfy8nZZZ/K9V1+YKAYPfZNpT2GxU8Lc0eHG1a/SBN
	4JZFsup6fPxQ0grKUTRAKK3FIRx+p45OH3/B
X-Google-Smtp-Source: AMrXdXt2v2h10Ozbz48m846jnJK7z8KUKg/i4M9DYTvR5Gs7qvMam/Uhdzk0bgtgV4PdRQlbt75wXQ==
X-Received: by 2002:a05:6000:1109:b0:28d:b028:b16 with SMTP id z9-20020a056000110900b0028db0280b16mr946819wrw.32.1672333659457;
        Thu, 29 Dec 2022 09:07:39 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:39 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 14/15] cache: Drop reciever side counting for SiggenRecipeInfo
Date: Thu, 29 Dec 2022 17:07:27 +0000
Message-Id: <20221229170728.880367-15-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14256

Joshua Watt pointed out maintaining the counting on both sides of the
connection isn't needed. Remove the receiver side counting and simplify
the code, also allowing errors if the counts do go out of sync.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 3fc097241a..ee924b2d2b 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -285,7 +285,6 @@ class SiggenRecipeInfo(RecipeInfoCommon):
         cls.save_map = {}
         cls.save_count = 1
         cls.restore_map = {}
-        cls.restore_count = {}
 
     @classmethod
     def _save(cls, deps):
@@ -294,11 +293,13 @@ class SiggenRecipeInfo(RecipeInfoCommon):
             return deps
         for dep in deps:
             fs = deps[dep]
-            if fs in cls.save_map:
+            if fs is None:
+                ret.append((dep, None, None))
+            elif fs in cls.save_map:
                 ret.append((dep, None, cls.save_map[fs]))
             else:
                 cls.save_map[fs] = cls.save_count
-                ret.append((dep, fs, None))
+                ret.append((dep, fs, cls.save_count))
                 cls.save_count = cls.save_count + 1
         return ret
 
@@ -309,18 +310,18 @@ class SiggenRecipeInfo(RecipeInfoCommon):
             return deps
         if pid not in cls.restore_map:
             cls.restore_map[pid] = {}
-            cls.restore_count[pid] = 1
         map = cls.restore_map[pid]
         for dep, fs, mapnum in deps:
-            if mapnum:
+            if fs is None and mapnum is None:
+                ret[dep] = None
+            elif fs is None:
                 ret[dep] = map[mapnum]
             else:
                 try:
                     fs = cls.store[fs]
                 except KeyError:
                     cls.store[fs] = fs
-                map[cls.restore_count[pid]] = fs
-                cls.restore_count[pid] = cls.restore_count[pid] + 1
+                map[mapnum] = fs
                 ret[dep] = fs
         return ret
 
-- 
2.37.2


