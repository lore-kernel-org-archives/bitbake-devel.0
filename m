Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66648C54FB3
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 16:26:07 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.25350.1748535960589917702
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 May 2025 09:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HS1mN1P1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f379662cso626908f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 May 2025 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748535958; x=1749140758; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1+WCybBrtIG/mEroliUMzUDCZW/+urekveMc0j9RMw=;
        b=HS1mN1P1DdYAFAXXjZ4gdxNhSgtZtkCKbZVbHD9zdQIhmlTXAVoyWfJ4qPO1CVTk3j
         Ph8RVhIKcKe6Ply1yO7JYGN0FHvwjJ1ZZhCVfz+wBcmy9LkO5KIpgU+VaNC56MHfX7Cz
         WRaR7v1RGyzxwWPXUhj7fqS9LbaKEd8VR+3MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748535958; x=1749140758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1+WCybBrtIG/mEroliUMzUDCZW/+urekveMc0j9RMw=;
        b=DPR2MQxU3B26Sqg3ffjxxG8zKUN/rvgtyJF04lY4luctSw3W46FB1+Iyupq+1GlLc9
         hpxwrM3fY7zcBPMjEl0RFlPT9xAIhMmfjIYiEpP+09hqbQxCnLDXXdRtC/bdJ3h5dTEG
         2Nu5k4GMKiDuTZSzI8nqHwULYPGHAiSCnWU0Txbmzcaf8MAB7wIpwBSCFnyCkhU8jZEL
         atgYs4YSu9X/O9IsuieendvljfjZKujAXYWVOXim3o4WBB6NHqRWKtu4JepwnhGA6F27
         hGyaqZOSoSJ7mh/sCAkj8o6hX28XUX18u96GpZvgJt5GZU9h+rU88dmv7CAPtXDweSXc
         I0Dw==
X-Gm-Message-State: AOJu0Yw+irM27KFQbj41+lst7LZHnXtSBrcqwxx6dNBlYkWCDmu3hZwh
	SJu0VOB7LdehSQGjkka3eLfdHOlgEc4k3r0K+/5XgaYqIknASL1Mjh3k4M3gVxFt6VFvzR4W4m0
	r+kFtJyE=
X-Gm-Gg: ASbGncvsKzd33lzJ1Pb3P8em+9Q/Lu2OYAGugTEGpUsEdapLscRk6MgkusWwNZBvJ/9
	8jO6QpyRCdBG/cJZKsQGTFW0VgtgdNM5Ssg4tGhemR5cnkLHsgS10BYKYry/v0k77jUxAW5mWxt
	P5Ye2OD9L5c3d7kMdhhFYkzyNozsdwPkdnXqSLlDgPJUM+mzZdk3dtFgHhSBjj7mAYIgKP0bpuz
	0j7qLLkFWxdplmXEtXV7/puRg3y6Rpn4J0THW2aGCfHdJ4Jl/4XFLx76FJbz+P0QU1KGia+byWR
	0gBkF7Tq22PN50CvWOVxh1hQyoJgcOQNRmVBzf6PleNUPVaxMfZibpbQ4c3adExxxt+zGlLZKGn
	Bsg==
X-Google-Smtp-Source: AGHT+IGVS57B4cjQK0U3BaCijGo/eFo2VbuIgfZu30bEIV46oXoAG91YwLXopwJBvEs84KaW1a2CVQ==
X-Received: by 2002:a05:6000:26cf:b0:3a4:f52d:8b11 with SMTP id ffacd0b85a97d-3a4f52d8c18mr2136211f8f.20.1748535958119;
        Thu, 29 May 2025 09:25:58 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a5e:81:40ad:9da7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f865sm2379858f8f.81.2025.05.29.09.25.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:25:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster/tests/buildtest: Switch to new CDN
Date: Thu, 29 May 2025 17:25:56 +0100
Message-ID: <20250529162556.3115477-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 May 2025 16:26:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17656

The project is switching the way handle our CDN provision of sstate objects,
update the URL accordingly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/builds/buildtest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index cacfccd4d3..e54d561334 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -128,7 +128,7 @@ class BuildTest(unittest.TestCase):
         if os.environ.get("TOASTER_TEST_USE_SSTATE_MIRROR"):
             ProjectVariable.objects.get_or_create(
                 name="SSTATE_MIRRORS",
-                value="file://.* http://cdn.jsdelivr.net/yocto/sstate/all/PATH;downloadfilename=PATH",
+                value="file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH",
                 project=project)
 
         ProjectTarget.objects.create(project=project,

