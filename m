Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.121420.1597960243614113985
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2020 14:50:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=mcVCrZDm;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id x6so1659252qvr.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Aug 2020 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzW6tQJt1Y3iFkP72B54EGI4hif5wfNUSf8jKrx2hP0=;
        b=mcVCrZDmRz43uR2oTgPH5JT0jmThupzdGJLJ2QMFL5gCmXfaSkkO8YIvoiyw3D/Acu
         VmqhDxCEo4RVN8MIbw9RYiuSWII0uWVSWcrdvIJT6opnGwfvRjnN4rjPYXlnjuMSQbdJ
         2hlxv4FoDZmxabev0QUh7WfgLsdMzbpYaO++HWasf0BVzS1GSWCXCukFhqhdTpr+Qa7W
         l4RaMZYCjslO0y0/msq9fxGGRoRFn+ZMk57G8wdhLeKALZHV136nu+bFy0Gz/D1yR3rk
         ilYm6jiyMPhM2MsS/N8AsswsuG27GDrDV2iKeGLvmAdB65nc6yFxQhVqCGYDekIDhcwF
         eTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzW6tQJt1Y3iFkP72B54EGI4hif5wfNUSf8jKrx2hP0=;
        b=BYKCJijIDpEw37k/R7E53gjRADvZkGBQ85Nxzp4eSGWyRDkroUQr8Lc1DVOMTRNWpX
         kZOPlsFLkX95XBd8aNn3D8LSPdoEh5Uv5KLEFBa6A69IPB+pEiSU1JpngUVhPgwUjn/+
         En4+nDbOv3MuTzJI5v5r/bF3aejHF5zKGGZkQgrz3NgrixxOS/vwowe96sb5EyQgbLVv
         fR1Xt19CJ6BXsDaABGms4AdU4CR+zBe/0RBZHTfs+1EDvp1P/upT/NDyB9ZDEiT82lOV
         /PSyMT4Iz8R4dfmVe259u2kepsbKerj/M6OVnZBXtffqWsyR0RMNzx/czAXOcEGzZKcC
         BYPw==
X-Gm-Message-State: AOAM532bFOg+iSFR1TGf2SsiKrWstQDRy/eZgZvtuX5EqZ3yE5AUIcgN
	V03+d+D0/jNsDsiZ11UgAyB9zBXp9FUbqQ==
X-Google-Smtp-Source: ABdhPJzoY/pVK1EVr8RQuRF6ZFlOSfuABvb8erSJNXsiVYRlbzcMSYdrykWvqD7lo6jBH8cxv9LhjQ==
X-Received: by 2002:a0c:e90b:: with SMTP id a11mr913953qvo.168.1597960242662;
        Thu, 20 Aug 2020 14:50:42 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id x28sm3407534qki.55.2020.08.20.14.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:50:42 -0700 (PDT)
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>,
	guillaume.champagne@sonatest.com,
	jeff.dagenais@gmail.com
Subject: [PATCH] siggen: clean_basepath: remove recipe full path when virtual:xyz present
Date: Thu, 20 Aug 2020 17:50:00 -0400
Message-Id: <20200820215000.30818-2-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820215000.30818-1-jeff.dagenais@gmail.com>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Before this fix, this example basepath (a):
virtual:native:/full/path/to/recipes-example/helloworld/helloworld_1.2.3.bb:do_compile
would get incorrectly "cleaned" into:
helloworld/helloworld_1.2.3.bb:do_compile:virtual:native:/full/path/to/recipes-example/helloworld/helloworld_1.2.3.bb

When searching backwards in `a` trying to isolate the 'virtual:xyz' to add
it to the end of the string, we need to consider `a` still has the recipe
path and taskname. So stoping the rsplit after only 1 split is not enough.
We want to reach the second ':' from the end.

This way, we obtain:
helloworld/helloworld_1.2.3.bb:do_compile:virtual:native

reviewed-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 4c63b0ba..ad49d1e2 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -752,7 +752,7 @@ def clean_basepath(a):
         _, mc, a = a.split(":", 2)
     b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2]
     if a.startswith("virtual:"):
-        b = b + ":" + a.rsplit(":", 1)[0]
+        b = b + ":" + a.rsplit(":", 2)[0]
     if mc:
         b = b + ":mc:" + mc
     return b
-- 
2.28.0

