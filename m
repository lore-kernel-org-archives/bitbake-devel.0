Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60584D47CC2
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 09:57:55 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2735.1768557472798962404
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 01:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xnqkvfwu;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee2715254so8523305e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 01:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557471; x=1769162271; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b61iOpYOBxoH1ouRZuLSWOicsHRp9S0J60JCtEwXzZg=;
        b=XnqkvfwuQbovGLh2ckRPWH36aJrQCasNLr5kFAeFGfnJ0+OHzgZv33C3NDbxRqY1T4
         UnDdECrxyv0lJnDf/VKFA2mDQhvp8jznvVYxVyf7sXzEiIbh5RoLt1O+E1UV9MfXuIlX
         dWxYDCUF03075Zz64BtAGXSlDzkpEdK/l1n/eDcj1yrcdI2V7cFptESGwBql2gEnvgL1
         2sJTzPZSgod47wWKSrfLlrCxcTBZm5rKYHbXeHt7dLK2wpO0vskwahdP5aBwRNnBpQEn
         5dAfllpkJUaf8NCzNz0g03+AR73cImVjM5smAJcOYSb1ep2lwmE+QMI2RwZow8t/uO0l
         eRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557471; x=1769162271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b61iOpYOBxoH1ouRZuLSWOicsHRp9S0J60JCtEwXzZg=;
        b=PZz3tQDZKy4OzE4TnApegWI8ojU0hLUmnJQdvwTS4PSgzIF9BY3BoyayQxkzGzTHQE
         TpmdyuRGitMsK+tjMkUWuExUpzyCaN7WbzsrylfB7xwIchwTn9FdJHHXMwrEYpEuzE63
         mRQn8G7i5qIyNFt7wk0jXnqroUdKLpG/pAPpGWwiUH8XV8FxGQlpvPddSVbb4/5xUiiV
         AQbwBFjpG5OatGLqEE9DdkZMuE894uLLT8sr5tvz2gNlxXkxQD7nzrrzs9iZdv+Il8/i
         lkjNjG0OR2EJ08cm2ZuTZLH+eIDXqwvWUMTX5qs2taT3T8EKkVvgyIc8n0sFweRz/+Yw
         luzA==
X-Gm-Message-State: AOJu0YyFMK0DeIGDjK0OzbT2LEmbTiq4TrNqXwaJ+KW550kE+aK1V4RJ
	6UEt6l5Txlygv6Z0tAUppX8inXqEdHHTpDp8Z0kFQu8+wdzOE5FgSRNASoOdg7yD
X-Gm-Gg: AY/fxX7suRuyyZlg7lf1ZN17Ti5BxLHvxSoMqZrPRi+f86lmW9s4rrLZe+oRo825Wnv
	pIHBRrqYJ7y951xzD073ECrY6iui0xopl6JK747sfthFcLErDXc7eOimfXEEMOyB57x0hSw7DcF
	rqDrARRn9CnYhUvHRPOXo8t/+Q/6a3bcBxSY2iXfbsFm0YiZs7UyAgcL5q1LLcnu6R+iMTDlZye
	bkoY76XwtMvvqeUDDms2mvCMFeiKvhB7dddnu2BAXtHyek2mOolpyS2uTFcOiuHh5yfJ8UtXHOA
	vz77BFx1dAPRVafrt3Kc97ERjqAXFOIz1srkcrGfo+ErA4HN0ov/F+B+q7aAb6Qhxeo+JprsWQn
	dDQIeL51S3QnO5XLAfClKFmQOlXVcshmk9dPDdfphoEjckABLOvKkCTSm1eK7rFrXXXDP9Q30Zd
	kFmZMqgipQepCHbIch8RQgBdOhB7a8vjTAgg040bvbb6n0pyE=
X-Received: by 2002:a05:600c:630f:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-4801e3495e9mr29952475e9.32.1768557470869;
        Fri, 16 Jan 2026 01:57:50 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c1b2sm34188175e9.3.2026.01.16.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:50 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 6/7] bitbake-setup: tests: use a tuple for iterating over configurations
Date: Fri, 16 Jan 2026 10:57:39 +0100
Message-ID: <20260116095741.3654153-6-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116095741.3654153-1-alex.kanavin@gmail.com>
References: <20260116095741.3654153-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 09:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18797

From: Alexander Kanavin <alex@linutronix.de>

This prepares the data for the next commit.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index ef331c8a2..41aae2d36 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -326,15 +326,15 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # test-config-1 is tested as a registry config, test-config-2 as a local file
         variants = ('gadget','gizmo','gizmo-env-passthrough','gizmo-no-fragment','gadget-notemplate','gizmo-notemplate')
         variants_local = variants + ('gizmo-notemplate-with-filerelative-layers',)
-        test_configurations = {'test-config-1': {'cmdline': 'test-config-1',
+        test_configurations = ({'name':'test-config-1','cmdline': 'test-config-1',
                                                  'buildconfigs': variants},
-                               'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'),
+                               {'name':'test-config-2','cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'),
                                                  'buildconfigs': variants_local}
-                               }
-        for cf, v in test_configurations.items():
+                               )
+        for v in test_configurations:
             for c in v['buildconfigs']:
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
-                setuppath = self.get_setup_path(cf, c)
+                setuppath = self.get_setup_path(v['name'], c)
                 self.check_setupdir_files(setuppath, test_file_content)
 
         # install buildtools
-- 
2.47.3


