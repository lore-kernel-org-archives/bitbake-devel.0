Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.1087.1598288020435361031
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TTCMRgEy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id o21so8859842wmc.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jRDZ1iheIEdFWcmufj1quLNdn8cvdBNJtTkDFBCy+PE=;
        b=TTCMRgEy3E84W0ZyvWCRFZ0sNhP3is7SfCi7h6p7eMZnqqEp8SdCDkfALRwTx2oZPU
         DD3svPrOznlq7Yx19dBKn1j7fUq1Bk831JLf7AeOEhVwPU43tJ2HUpWwzifC6LFXanjZ
         DxkDrfuY/VF5ZsFfffWpaMdnG2iQT8V1pKXAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRDZ1iheIEdFWcmufj1quLNdn8cvdBNJtTkDFBCy+PE=;
        b=fM9waw3kan63albyCk+NAI6Zo5xMSxItvr9gyFPZWljeWNDyUK8mltpQ1NB5QU0Ev3
         lftiDo+COJ76EuqHjwkOhZk4AJMKYqatnZtEReBVS3uqJRrQ0ZH6p529y/Dq4/KPPX49
         LXzTyqPHg2rq3jBBtFhPRZYRvLy9s8JDuJN+lJQ54U5L5kCkFofE6knWVQX/FSrYqyf4
         JqBj7/Yri6r9lk7Icy4XF66cVF7HT5TQhbkVyIRfe4+LncQaGlrSDS2K33e9VrSyTnTU
         kU1Ln4O7vo3KbXBZdAa/6TqQ12kzdqBl3P+yAm6y0GTnZeRI1XU/1o6ZV1cxicvzUJVq
         nSgQ==
X-Gm-Message-State: AOAM533wldnRl2yuuH40BUGKH+SRYuOpk4v99XGeMijMzsqiECuDYzqd
	7abCJR0NjvviP0KKZuk04v6UuUETs76EIfF8
X-Google-Smtp-Source: ABdhPJzartRTckSEp0Y6kIc2RNWfoJSzY8/vE58PSzpxuI760Kf5DEmmH8kGCr8AZ4BEuo8MrSa6zA==
X-Received: by 2002:a7b:c38a:: with SMTP id s10mr198010wmj.13.1598288014657;
        Mon, 24 Aug 2020 09:53:34 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:34 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 03/10] cookerdata: Ensure UI options are updated to the server
Date: Mon, 24 Aug 2020 17:53:24 +0100
Message-Id: <20200824165331.1373725-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were some options which were not being passed to the server. This
was breaking, particularly in memory resident bitbake mode.

Add the missing options to the correct place to ensure the server is
updated correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index f43610e7f8..9eddf7cf6a 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -60,7 +60,9 @@ class ConfigParameters(object):
         for o in ["abort", "force", "invalidate_stamp",
                   "dry_run", "dump_signatures",
                   "extra_assume_provided", "profile",
-                  "prefile", "postfile", "server_timeout"]:
+                  "prefile", "postfile", "server_timeout",
+                  "nosetscene", "setsceneonly", "skipsetscene",
+                  "runall", "runonly"]:
             options[o] = getattr(self.options, o)
 
         options['build_verbose_shell'] = self.options.verbose
-- 
2.25.1

