Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C8CEC1EA7
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 11:54:30 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19107.1770292461385589640
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 03:54:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IT33V1lv;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so12423765e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 03:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770292460; x=1770897260; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbn7IcjvoBniJ/pjtuSCLTt8P8zNygOwHRO2YDqV/ns=;
        b=IT33V1lvv7SnoHuOvYLjvb5s6Es271uQngF2qWvEmLX7qSHxVkiw8WKG2RwXx58e4k
         /ZZE/GUB8Pam3u3wYJ5D0TePIxFeIyZarU8lq31eEe0n9DK1LqLk8mcOVZpphR5ye8Ti
         3aseOyVL7fgfUladpVaXMvNzzy0PhfweLxRwRewti9ZvRXF4mjUMn1ubWR1dJWYxh7Rr
         XOJ8mS53zWXRfmCPKdkHdoO9EWbvNqH2wiOPwP2HgnLIMMxGwNJcNsnTefNgNuqgoQ+b
         Q9FZD5qzoK8TbJVGJV8HeMQuCqmxYBKBnHiFAc/YhHoP39C5/04YUBAhSoW/NUeShXuM
         OLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770292460; x=1770897260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbn7IcjvoBniJ/pjtuSCLTt8P8zNygOwHRO2YDqV/ns=;
        b=CT2h1BsaCF7QS0uXY+pA/6sb0tOgiNTmfGZMDgKH3Qw4aeVzvA4rUNuwKoCQc83WH9
         khRVR+dsOAKmnnFPt/DMb21JXl1KEV3tC5dyhThQvNTLOuzgIGm9ibMWRRcDJ6iDCCuf
         280bn+Whq9ZJ1vyRLz5i4efCw8jy0UX0m2jueDpd/J5A6EoriMTmMU1cHIE5zcK88oot
         4Y37B4VceXGWO9nm42Yftk8blsKNjECtSj9svChbot0tZ6o9EP2ifDmyYTcBNT0aR6g9
         4aVm+FLcwTVA2D9Za+eDEXMTt7LwMXyt6mKcb0uZE1m/dJzYSdEC+bplhepHpRZdfmrh
         agPw==
X-Gm-Message-State: AOJu0YzSGDvS/Kz1DK5MeNVwa56Vh6rB+ARb25pnBCiIRAYDFh5SO/wj
	sBI6K039iovTM2RErbRRHIlJYuA5A/loMcACQ7aWxU88JtNRHKBBOvp7Uth3eQ==
X-Gm-Gg: AZuq6aKsm7gOWB/0skfsZyyITfINE+4zUHbSQgegEoSGyuAxr5pJ4JsuEo7sQzg5295
	Nx2MvyBbNzR1e6fMWVmUt6arLRL4nIjYwJPakrvllsSUyPCt7tfPC7whq8BY/NtiFgxNsgimlG5
	WkzphhN+gd18UrM7ZPc9mso7YH1NGcUfFLNWoSVkwIVWNCtgEIZrjIcgtSzvIySyLqHwhYzPJ/j
	X9F1aRMYK03vWV1pFNW9qitDvlVlYhJlm88vZ8CUC5Izvq2+EiBv+S8d/bQnqdKxUlmgl/8BVk+
	OWxDcGx7jydwyuC+1vUPCebqQmgAKas6hb6u2nenOssdqK6Oa/O/Uhq/SuHfMzf+GdUG4uOklRg
	m/fIN/YQo5qxCNQBzKot5GEJ+WDbJFnRE+9zNomWQ1OQfssc3T7IVLWq8nM6W8vX3AoZI3rlqZU
	ARwxK41vTblXWkcoqE1KMW5dmS9jkEu+E8yfaq+aPK5+gs+dg=
X-Received: by 2002:a05:600c:5491:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-4830e922970mr89649585e9.7.1770292459516;
        Thu, 05 Feb 2026 03:54:19 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179dbdcfsm68280415e9.0.2026.02.05.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:54:19 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2] bitbake-setup: tests: add a test for getting configs over http
Date: Thu,  5 Feb 2026 12:54:14 +0100
Message-ID: <20260205115414.3956729-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 11:54:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18966

From: Alexander Kanavin <alex@linutronix.de>

Configs from registry, and configs on local filesystem were tested,
but not configs obtained over http URIs.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
v2: wrap the tests in a try..finally block that ensures the http
server would be shut down on both success and failure. Otherwise,
in case of failure it would never exist, hanging the executable.
Unfortunately the implementation in bitbake does not provide a
context manager that can be used in a 'with' statement.
---
 lib/bb/tests/setup.py | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 41aae2d36..ef407ee9e 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -8,6 +8,7 @@ from bb.tests.fetch import FetcherTest
 import json
 import hashlib
 import glob
+from bb.tests.support.httpserver import HTTPService
 
 class BitbakeSetupTest(FetcherTest):
     def setUp(self):
@@ -323,19 +324,26 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         test_file_content = 'initial\n'
         self.add_file_to_testrepo('test-file', test_file_content)
 
-        # test-config-1 is tested as a registry config, test-config-2 as a local file
+        # test-config-1 is tested as a registry config and over http, test-config-2 as a local file
+        server = HTTPService(self.registrypath, host="127.0.0.1")
+        server.start()
         variants = ('gadget','gizmo','gizmo-env-passthrough','gizmo-no-fragment','gadget-notemplate','gizmo-notemplate')
         variants_local = variants + ('gizmo-notemplate-with-filerelative-layers',)
         test_configurations = ({'name':'test-config-1','cmdline': 'test-config-1',
                                                  'buildconfigs': variants},
                                {'name':'test-config-2','cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'),
-                                                 'buildconfigs': variants_local}
+                                                 'buildconfigs': variants_local},
+                               {'name':'test-config-1','cmdline':'http://127.0.0.1:{}/test-config-1.conf.json'.format(server.port),
+                                                 'buildconfigs': variants}
                                )
-        for v in test_configurations:
-            for c in v['buildconfigs']:
-                out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
-                setuppath = self.get_setup_path(v['name'], c)
-                self.check_setupdir_files(setuppath, test_file_content)
+        try:
+            for v in test_configurations:
+                for c in v['buildconfigs']:
+                    out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
+                    setuppath = self.get_setup_path(v['name'], c)
+                    self.check_setupdir_files(setuppath, test_file_content)
+        finally:
+            server.stop()
 
         # install buildtools
         out = self.runbbsetup("install-buildtools --setup-dir {}".format(setuppath))
-- 
2.47.3


