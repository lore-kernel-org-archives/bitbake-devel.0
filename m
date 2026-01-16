Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525DDD4660C
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 09:57:55 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2734.1768557471996401233
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 01:57:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Rr+kToqe;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so6349525e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 01:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557470; x=1769162270; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX4Vh6dlUZArfzu2lgqKLj9TmaUJSsKptoWoc+PwdG4=;
        b=Rr+kToqeNsAFQF4Jg6WHJrILftNhhI0D+ed3FZHWtZ4AEKzuHT12Tr+wBCIcqLN4wY
         Hz/TiRyTG8094x7uk0NaPW1YT+sICLDupmCXJvXK3ctBcI+4BEIQPpdsMGKBB8zw6BWf
         WRtMWiHKdm01Zf4w/1H1hCZYoKknkYS9chrNS7bm9lc3hgo3uCkZiVTeMwnaXtOKaK+j
         fI4OcULyY1ayrvdOKZqu/Jy1S5SNKxPIRXY+PXW+W7JOcatlj+cDk9lKn8JMloDsDMWH
         zJ1dgj4jfKePsmnUIXWRdRtn1Fip5QE7gBUhS8vq+e+wjotXB+Gv7yjih1jEpiqzCjTq
         GZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557470; x=1769162270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fX4Vh6dlUZArfzu2lgqKLj9TmaUJSsKptoWoc+PwdG4=;
        b=xGISEZYGg23byvvwVcJK18gyLT9sJiBMb+SPbvL4wugwKVdA6dNsqiF8vJXnCdbKoR
         C4GoeI1EThxxSyMI5VuxLCXsfUVgCwJ48v3eNcepQIZ8zyEuzWgYo8+jmVEVwIMPBZpk
         FFL1hX/0m4XPSDP4p7BhEkdA/rFCE/Waa+M4ZovyQJUjsX+SajmIqMFvt4OUYs2BqBun
         xKyddGTQ8UHVRB6qiVTSpyXA/WCBH9KIXLBm3VlmF4tUOs6FJxzc7v/W0wHk3OZICfDX
         KdouxH9/JE0Pwha4//I4SkCXeK1AGOXG9GaqYIsavqDVP1Q077OKKVFFUkV2SVu+gsRG
         fJYw==
X-Gm-Message-State: AOJu0Yya7/7JbaDhhAeDlfZHk0jcPSGMyOC42QBePwPRb/WvCSDJMm5b
	bHarrjJqzZFxu/rdxq1s1BClhFDBaNG0VZdvwfCrZiPsSz40C1ceQ1yWOiLn3edY
X-Gm-Gg: AY/fxX7l3q1S3qrhPK5lglUmWR8lF5NIVcMjFIb4K90vQLCgoVWZqWPpd7oF1Mib7es
	ApEYFxpY0hKRGNYAOndCPlDzJZ+InhM9t6Iz6uX21jZdyQfkashDim6ozdoYORIPgeIGgeVA9wD
	127p3d9xf9D3nXNLGHomK+Uh4TBwjeomC5773/OT8oen5Msgbw4F0tTxbiyPQ295NiLsr2zllvu
	toQytxUD71SUJf5Yglqm2tpFDbOWdygYMxnWTjy+iQ8/aJvdBkbTOv7Ab7gBkhOhIFxZLIlWpFm
	y344pbpRGCl6u9EXMU5QIWf7k9eRInS4VXT4Ou7KhLcPjAGRE7LVqqqTUwk3+Pr4z25jX+Idi9H
	PNnoRbVqBdeQI43cO9BCYGynwE5sTVBlthoxt2r7x37LQrHOJi6lILFHvSI1QD30tJmilEecq3F
	hd3bSHAIL80trFuvmNTH74sXPb/tGhOsU9JPbSuG3D8kjiQOs=
X-Received: by 2002:a05:600c:450e:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-4801eac0721mr19617675e9.11.1768557470245;
        Fri, 16 Jan 2026 01:57:50 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c1b2sm34188175e9.3.2026.01.16.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:49 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 5/7] bitbake-setup: tests: avoid repeating the list of config variants
Date: Fri, 16 Jan 2026 10:57:38 +0100
Message-ID: <20260116095741.3654153-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116095741.3654153-1-alex.kanavin@gmail.com>
References: <20260116095741.3654153-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 09:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18796

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 802f017fb..ef331c8a2 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -324,17 +324,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.add_file_to_testrepo('test-file', test_file_content)
 
         # test-config-1 is tested as a registry config, test-config-2 as a local file
+        variants = ('gadget','gizmo','gizmo-env-passthrough','gizmo-no-fragment','gadget-notemplate','gizmo-notemplate')
+        variants_local = variants + ('gizmo-notemplate-with-filerelative-layers',)
         test_configurations = {'test-config-1': {'cmdline': 'test-config-1',
-                                                 'buildconfigs':('gadget','gizmo',
-                                                                 'gizmo-env-passthrough',
-                                                                 'gizmo-no-fragment',
-                                                                 'gadget-notemplate','gizmo-notemplate')},
+                                                 'buildconfigs': variants},
                                'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'),
-                                                 'buildconfigs': ('gadget','gizmo',
-                                                                  'gizmo-env-passthrough',
-                                                                  'gizmo-no-fragment',
-                                                                  'gadget-notemplate','gizmo-notemplate',
-                                                                  'gizmo-notemplate-with-filerelative-layers')}
+                                                 'buildconfigs': variants_local}
                                }
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
@@ -352,10 +347,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         prev_test_file_content = test_file_content
         test_file_content = 'modified\n'
         self.add_file_to_testrepo('test-file', test_file_content)
-        for c in ('gadget', 'gizmo',
-                  'gizmo-env-passthrough',
-                  'gizmo-no-fragment',
-                  'gadget-notemplate', 'gizmo-notemplate'):
+        for c in variants:
             setuppath = self.get_setup_path('test-config-1', c)
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
@@ -375,10 +367,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('checkout -b {}'.format(branch), cwd=self.testrepopath)
         self.add_file_to_testrepo('test-file', test_file_content)
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
-        for c in ('gadget', 'gizmo',
-                  'gizmo-env-passthrough',
-                  'gizmo-no-fragment',
-                  'gadget-notemplate', 'gizmo-notemplate'):
+        for c in variants:
             setuppath = self.get_setup_path('test-config-1', c)
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
@@ -408,10 +397,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('checkout -b {}'.format(branch), cwd=self.testrepopath)
         self.add_file_to_testrepo('test-file', test_file_content)
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
-        for c in ('gadget', 'gizmo',
-                  'gizmo-env-passthrough',
-                  'gizmo-no-fragment',
-                  'gadget-notemplate', 'gizmo-notemplate'):
+        for c in variants:
             setuppath = self.get_setup_path('test-config-1', c)
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             # write something in local.conf and bblayers.conf
-- 
2.47.3


