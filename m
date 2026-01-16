Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB7D46620
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 09:57:55 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2687.1768557473400416161
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 01:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AWZdHm6+;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso9749285e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 01:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557472; x=1769162272; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPZVyFzsh7QyVAzh7m6PEX5MZGWV8bpAcx7k7OH+u0o=;
        b=AWZdHm6+nmTwKTWNboqr5GXZA4v028Esrvx3H6b6DcoEUvzzG9ap3EKWgbQ01RxETd
         bCB26lwNE6Ou9iqZoiZSC9+OskljK3YI2wgPn1kINtDhxoXqMDLJnIL1Xl1uUz+fE/SS
         4vhfqcJ2t0mjNItzvGjWiQKg3lPOB00ZuV/VEDZWgQO0/C7KauXODISXqy/bqVkO/9Gn
         s81y2D0YdSuBea/OXMKcqoJhw2X7cZTzhPDWoQJbFv3DfHhpo/adQO04qtIWyMyxl7gf
         w2XSlbJTD8aC/4a+dTWRgbSXnJw1saJ2IOEC0J5JLDSmhs62VlJDR+8WSuyfoDyFdYdF
         RE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557472; x=1769162272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPZVyFzsh7QyVAzh7m6PEX5MZGWV8bpAcx7k7OH+u0o=;
        b=K8kVklr9VuGr6i/S+GFsIKYKxvBMfgdX1AjeBorlcE8MJjJ8W1fiXobihK8ruFCU+L
         6QlbX/0EsGlpWjj2+q3BxGUHg5gXaUmTBVON3TbDqOBI5h8/ECFHASklo6bHhJsc74ZJ
         pJeBBgVQGeuocD2tIKbpks9wk97XSnt5p839lmKaVY4379IVJLOFNiTqjdUR0fZYEtxl
         pi5OGKGW4fhDEqFF9HX/lBkLpegdRTpd0lPrk01PgkYwBwPTxW4TJ0YMc3ybHciLnUxR
         Pg6Y5JcCfpAq/Eq5HGM15vbvB+QG3ny+pX1nJhaFMtZD4PxmSZnUsdlobjnYKAaZ+sN0
         Bpmg==
X-Gm-Message-State: AOJu0YwP6XvIpokdbdHEstd4IbpuoEtHN3aeOOr08ZEnNMT8COBxmh1T
	wtAQ4cluNNiA/1ftL6pDYHAMatJ2pzcBiybtEoHf7+G/HJLgQ71TrUfZVbqXGEmN
X-Gm-Gg: AY/fxX7r/c5i5p1kPuTkrLYWMc6Ck5Xfx+Y0Tz9yzGEZO1nous7J/JLZUqu0t8fCzy/
	CW/lceBHDjQhMkBHjh6YfLb218DyLIcByFZEeOGWGSnH5HCyEgid8+w+Hd1LoGGAsS6t58fntzz
	eZqTADTv+iYOx5EPbh1vzrkljvlw4Jb2n9AB4CBQp1eKnrwuMPRINlGv18KhyAGijl7HeLY7IYd
	c0+qic5HdNhLNKILPmDeYIdHWBo4iRJUsstJUCIKby4ypLJOveSmU4mOKg6228K5DAqIdLowU/D
	Dx1GdOpKhvefvlyWz50WnpyytFpn1FMLvH4VFlpIy120MLU4lOaqInPvJVPmSGrtNwq0i47m0YN
	8WXC2CeHvhb6riiUuQ/HOfkYy5nCunvpQMzOGC9TFwwvlQUdQvSFSlrtZU5HUJOzQgo4UhHWdhT
	oNo5I46mKhmbZ8cP4QxiIgSqcxPLTPOQaVIlKtAo/hYk5dwGE=
X-Received: by 2002:a05:600c:458f:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-4801eabee40mr21733795e9.11.1768557471635;
        Fri, 16 Jan 2026 01:57:51 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c1b2sm34188175e9.3.2026.01.16.01.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:51 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 7/7] bitbake-setup: tests: add a test for getting configs over http
Date: Fri, 16 Jan 2026 10:57:40 +0100
Message-ID: <20260116095741.3654153-7-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116095741.3654153-1-alex.kanavin@gmail.com>
References: <20260116095741.3654153-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 09:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18798

From: Alexander Kanavin <alex@linutronix.de>

Configs from registry, and configs on local filesystem were tested,
but not configs obtained over http URIs.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 41aae2d36..a98160f4a 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -8,6 +8,7 @@ from bb.tests.fetch import FetcherTest
 import json
 import hashlib
 import glob
+from bb.tests.support.httpserver import HTTPService
 
 class BitbakeSetupTest(FetcherTest):
     def setUp(self):
@@ -323,19 +324,24 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
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
         for v in test_configurations:
             for c in v['buildconfigs']:
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
                 setuppath = self.get_setup_path(v['name'], c)
                 self.check_setupdir_files(setuppath, test_file_content)
+        server.stop()
 
         # install buildtools
         out = self.runbbsetup("install-buildtools --setup-dir {}".format(setuppath))
-- 
2.47.3


