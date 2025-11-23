Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695E0CFA46B
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 16:16:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17503.1763914586050782958
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 23 Nov 2025 08:16:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PAxRLP7p;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so17839255e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 23 Nov 2025 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763914584; x=1764519384; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+ti2BuqQ4IWY3ESeNA0Ehqvt3olb3WwnMkWrXbFiSE=;
        b=PAxRLP7poyWGYu3cUQdHD38SfzCDv8iVlRnsox2XK5OXz0WoL0l7zmyT4D7dagUEh6
         QAU9h4fNPhOv9lHRB5Xx7pHFspQedL971adZ1ya1FjT8URulmYPQs6kCOy/YJ4UFhGw2
         0kPwOnHGPvEjPmEcjWtNO2REZRjYdDSZLwZYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763914584; x=1764519384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+ti2BuqQ4IWY3ESeNA0Ehqvt3olb3WwnMkWrXbFiSE=;
        b=NnA6IjBz3+ITtp9m0zf7n+PwiYF9jtkBikY/R68otV0Y+95KAoyieJXX+gzC4aBh9D
         xFByZrgsPHapqgr3W5ZCn9FAl0hV03peo71ND0WwrAoXAosqUvDkP6OAH7dWigmlb4lI
         V89Y1VYlTuLgyu0LiUkqlCx3u24ZAXobhb9Rs2LDsh1oSeB6p5n+1IpGYYGYA1QuyPtE
         OskRzV4LNyiFriOjlE6QMEZHpV7yF2Jzy83vdqoAeV6q2gomm4mq51FiqwilAdPzUpGv
         jkW3HRgps29NVbY+YMPUjNdkjgnuFdRPtDhg6RzD4PjEVzBVSK9mk7j3H2O36G6a3zQO
         l0CQ==
X-Gm-Message-State: AOJu0YyH+RAxXc6X5eLVIfkKEzzMLtkn7Or1NNbKbByqvSR2cZ1eaSOy
	+c7sTMYWxon8RMs/LnYLWMT/Tm8F+2SiO+/25PNeVCJEqsoi1ovJFgAMFBJ5y8htTRCefB61Kr8
	C97/H
X-Gm-Gg: ASbGncvgOfL4kaN2qnFNHb2AUtKjDKROnDCqsYKSIjthPfTRhYHEjW66A6WcurOWJi2
	ZsIF0mztWuhuf3sLsqBsy6puQ4Eue4hdY1XdrpeaBD2adrXbP6NuVMYa1HPWeSbVlVD8uSnyzsz
	Ur7AZzSAb48jmdFzMyqynmetLkT0dz3lO2YCsF0PK3BN+9QwfwmTVSLYk/vpchVE5G5LDoalS03
	n7lpQK4Wmb0BxeQ89/MMLWQPuGEhIIQEXs5ArQVnOBP62WX9M7ymFXC0oHmFYuJLjM4DhmileVm
	pc/S0+fUt5PB72jJZYnREP9AL76En6ti4/6KOCKNVh6n+x4V8PzEAq31FeAwaXaTUZ7IOoY8/gI
	5Gb4lQUacqkY0Ltri/+DQOEuRsIfyo59clytti5zWawQpGUYDuSCw9P1lKlqQqdH1pl552mz5IK
	ecfesQyuCjEmf8IEWYo7Ru6QAIKNh0+HJUOEJOyA==
X-Google-Smtp-Source: AGHT+IFaPuNF3qkKwnGYx9MTYBeCmM0f4AYkjbK8LrtT3iQDL2C5NiysmuHYPOCDXRXG5w3vAZmVww==
X-Received: by 2002:a05:600c:5252:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-477c01defd8mr95210335e9.23.1763914583701;
        Sun, 23 Nov 2025 08:16:23 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:775c:23a4:f31e:9be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e0c802sm127620105e9.15.2025.11.23.08.16.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 08:16:22 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Fix cache issues with noweakdefault getVar
Date: Sun, 23 Nov 2025 16:16:21 +0000
Message-ID: <20251123161621.114056-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 23 Nov 2025 16:16:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18479

The recently fragment error handling code uses noweakdefault=True to getVar.
Unfortunately there is a bug where the expand cache may cause that value to
ignored, giving confusing error messages.

Avoid the expand cache if that parameter is used.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 2e0d3085882..110dfa11162 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -781,10 +781,10 @@ class DataSmart(MutableMapping):
                 return None
             cachename = var + "[" + flag + "]"
 
-        if not expand and retparser and cachename in self.expand_cache:
+        if not expand and retparser and cachename in self.expand_cache and not noweakdefault:
             return self.expand_cache[cachename].unexpanded_value, self.expand_cache[cachename]
 
-        if expand and cachename in self.expand_cache:
+        if expand and cachename in self.expand_cache and not noweakdefault:
             return self.expand_cache[cachename].value
 
         local_var = self._findVar(var)
@@ -904,7 +904,7 @@ class DataSmart(MutableMapping):
                 value = bb.filter.apply_filters(value, [self.filters[basevar],])
                 parser.value = value
 
-        if parser:
+        if parser and not noweakdefault:
             self.expand_cache[cachename] = parser
 
         if retparser:

