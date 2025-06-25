Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14DBC7EE2A
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 20:00:52 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.25624.1750881642381602401
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Jun 2025 13:00:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ESJ5LRMT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cfb79177so1339585e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Jun 2025 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750881640; x=1751486440; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACL4cUz/SIEStD98scqTlJ60YOCq/GL1t8k6B2HAqT0=;
        b=ESJ5LRMTLFd0RhISTWVMsEFOEqB4gApq39tA7WkBm8XlryDjQ95uE7UYlxTMeSlJbp
         fmS3NE4q35GQX413phWVMKQ+d2y4d2uLhvF1AJg7PEPbqIOUA6FQ9yB0lO2l8znl1s7/
         +0vJ60HmzyWTc3OlSI/unjqkXcZvvefJRPRHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750881640; x=1751486440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACL4cUz/SIEStD98scqTlJ60YOCq/GL1t8k6B2HAqT0=;
        b=sV+ottpD2TMJVqRhKJuZI8yJmt46e9VpwC8GYVs1/v/hJf5SmLHuGyENPyc47WvmSU
         4CkTxikQ/+f6OM4Gw0oPs2A0f6aorg7kdyAOshehO5YRbcVV5AoUg/vEIXBDnslHTWrX
         gj5qpHu7B7byYbLlBaY9jB2qaNzQsoLj4yC5mpN0xTBoOi/sVzDzqi2c1QER/GxfXBXc
         e+evRaaqSWlqz5kiSMlhda+Oxxonuv3VqmZB8gHu6T/m06GTviO8vTWxHC9PzEzzGIV/
         iOxPyt1SBXuPwEa+8iIVXDG9GvJYZXT3ZK/IRLS6WPj6ZyzkUbdGONZZyOGNRn9bImz3
         w2xA==
X-Gm-Message-State: AOJu0YxzSw3/MDHpTQ/ze1lo3o+L2IwLy/QE1whd2B/hN6Hk+U4TWJIL
	lWy0YRuaacZ6L5ACOBD4CLGoHEhXokDZQTe0bTyIZlMxFT3oTZKwy5fawxOHIR6XVcpG/odUZnx
	nJ4Zf
X-Gm-Gg: ASbGncuaAzncqXsAukb6cUP/1tVTNeH9eCSDU3GBoifwaf0h0gv53y9OLFdHjT68wpq
	Meo0+KD7DsX5efZKY54T+c2pO7aqSyBag88eFpY40yxyD/Q+J7E8KOFzLGax1+mmNBtT0jYkFI9
	cQliEEv9CEbJSdIgas9CXhw2eJ0xyXg/RDqrQQfIh9Sihr59fHUuFHtzg5atmmVfiV/q5kNsBtD
	ZNjEX8PwMvAEgtlkbP5sFkopxayrro1LXeU7CSOS+RQMJGkSmdCHkQYRjTdJdH+taRTbTk5tioD
	Jz94NyLHhgi8k4+A6ke8GiQ4/AJ3s8sgWSnDAKM4LbCjpYvehReKenhj0D1k8r14CfyzMs2gdbr
	RJk7ykDFHozKeFNs=
X-Google-Smtp-Source: AGHT+IHLHnC87mSaX+C98YbaCvsD+sWZDImVcttFqUktFyu/+3sHPaoO9AdOErfePdil6s1C3SYPcA==
X-Received: by 2002:a05:600c:4f41:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-45381b06361mr43844485e9.30.1750881640156;
        Wed, 25 Jun 2025 13:00:40 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f1c1:2228:ff4c:9514])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad0fesm29623535e9.25.2025.06.25.13.00.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:00:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] fetch2/git: Add tag to shallow clone tarball name
Date: Wed, 25 Jun 2025 21:00:36 +0100
Message-ID: <20250625200036.3148793-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250625200036.3148793-1-richard.purdie@linuxfoundation.org>
References: <20250625200036.3148793-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Jun 2025 20:00:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17718

It makes sense to allow the shallow clone mirror tarball name to include the tag
name so that tags can be added to existing urls and the tarballs will be maintained
correctly. The code already allows this to be done easily just by moving the tag
handling code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e7b030998c0..14ec45a3f67 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -199,6 +199,8 @@ class Git(FetchMethod):
         ud.shallow_skip_fast = False
         ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
         ud.shallow_extra_refs = (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") or "").split()
+        if 'tag' in ud.parm:
+            ud.shallow_extra_refs.append("refs/tags/" + ud.parm['tag'])
 
         depth_default = d.getVar("BB_GIT_SHALLOW_DEPTH")
         if depth_default is not None:
@@ -633,8 +635,6 @@ class Git(FetchMethod):
         for line in all_refs_remote:
             all_refs.append(line.split()[-1])
         extra_refs = []
-        if 'tag' in ud.parm:
-            extra_refs.append("refs/tags/" + ud.parm['tag'])
         for r in ud.shallow_extra_refs:
             if not ud.bareclone:
                 r = r.replace('refs/heads/', 'refs/remotes/origin/')

