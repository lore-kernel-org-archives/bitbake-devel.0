Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C9C28B30
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 23:52:35 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.718.1741996348691572491
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Mar 2025 16:52:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=lORxXOhd;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0a5cfd7dso1774015e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Mar 2025 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1741996346; x=1742601146; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COhIAVntSARlYH3SHIiYMClCbmdll3TfXtCs1sRU9NQ=;
        b=lORxXOhdFmL0RAf22EIXWsnv0t9iid4fACiMIecaZNjdOJdk7CJHa4GKbkeZ8TwSR3
         N7XftGkL9xsIGlxjHJt023g0GPf614oeb0O2y9SGGY7yovs9p6tk5DwapVD7/gwiiC/1
         3O2+yYRDxqHpvWxiuPXK7uqaL1J13S/Cw5ZKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741996346; x=1742601146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COhIAVntSARlYH3SHIiYMClCbmdll3TfXtCs1sRU9NQ=;
        b=Cn6FscTYuM0pMJKfbcUsDMPaYFAw7947ikmgr/8Ba7z4Vu8ay+vUkwDD2t7vQv3HYG
         XT6RfGJvGvJgx2uInaq4HPyQHAbuw7ttB2VGS5BvKcg3cKaAwrxwQdXVS20EhwZq9XBO
         aKIGD6Mqmo8qvCW7E0bx4m/ypn+BblHHrBZbLLt1hBXuShbWi02YwGFG+nD3m0XlAXKY
         rhzQpnlwDBbEsiaMc94emk0mKrphcDnL/hHfBM/wKyiK9rdHS2AhVF7okvkJvimDYMai
         dFDNvxu/6cYVXbjHCAwBiVKI9ulTv/oDHx/693aqr9mYV0WpTxCpaSaO4P91De8OAlw1
         e/YA==
X-Gm-Message-State: AOJu0Yx3t4jLbwZFI0UGJwWh7Dg9WJknSwBd3XuL/2IddrQI0115Fozk
	B7b3ghvpFnQ2TviiVwIOrTccaLKdN5gxMbgw1hkV806G3HPssgXtzUrFrNoWC1NORL6eWoyPK/a
	1
X-Gm-Gg: ASbGncsSJ/y9fiTrrQIyjnZZgTHrCw7FNmRr1eTH9wvqtJNX4s+T/uuQUJ2ZaQo/aps
	ut8Iz4Rn+TJO30buP79soHlK7CAfdKjBeI4EOiVqWmlrgL00wtg8SvjEFadYN5mqeKDbMTy4qSG
	zjmtkrxv+zrwI099G2WycEHpyRd2lYvvTMMc3WRkL0HP/KxSu57OlqBP4Nm8oCjD+JaX6mMRLPy
	R+DjDzqVq/ru5xNIosr/4vC8HtgbfLtH5awhqxEMSt5ZFhxepRATyIUItAt7clT9rtab0gTqayf
	AV00st2+DmlZ/bfMgNrlHMO6y8PqWuiB20wrBqdFYRlsSM252MoXW4/awM0xnFgJ9WZIfsjeqmo
	TVgm7mxXCwBnuJ/beRai5GpbVmCKc1pQdlfYVD+aA+AhT/jhKV5iYRJHkP8mIkQ==
X-Google-Smtp-Source: AGHT+IHeFGYkOjUlwu9h3lcr/DNWE1aFNnRP6Z79rCoZDjV+LCilAqFTjV5G4sj1HrBGXZcoYc0yjQ==
X-Received: by 2002:a05:600c:4e94:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-43d1ec62272mr58273335e9.2.1741996346110;
        Fri, 14 Mar 2025 16:52:26 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef0002cff7470e58ff5dc.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:2cff:7470:e58f:f5dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d20e29a38sm28036935e9.37.2025.03.14.16.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 16:52:25 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 1/2] tinfoil: Refactor temporary data tracking in a context manager
Date: Sat, 15 Mar 2025 00:52:13 +0100
Message-Id: <20250314235214.1540-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Mar 2025 23:52:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17447

From: Yoann Congal <yoann.congal@smile.fr>

A new context manager Tinfoil._data_tracked_if_enabled() is introduced to
replace the following structure:
  if self.tracking:
      self.run_command('enableDataTracking')
  # Code that need data tracking
  if self.tracking:
      self.run_command('disableDataTracking')

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tinfoil.py | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 13b05cec..60359a1a 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -15,6 +15,7 @@ import atexit
 import re
 from collections import OrderedDict, defaultdict
 from functools import partial
+from contextlib import contextmanager
 
 import bb.cache
 import bb.cooker
@@ -641,6 +642,22 @@ class Tinfoil:
         fn = self.get_recipe_file(pn)
         return self.parse_recipe_file(fn)
 
+    @contextmanager
+    def _data_tracked_if_enabled(self):
+        """
+        A context manager to enable data tracking for a code segment if data
+        tracking was enabled for this tinfoil instance.
+        """
+        if self.tracking:
+            # Enable history tracking just for the operation
+            self.run_command('enableDataTracking')
+
+        # Here goes the operation with the optional data tracking
+        yield
+
+        if self.tracking:
+            self.run_command('disableDataTracking')
+
     def finalizeData(self):
         """
         Run anonymous functions and expand keys
@@ -659,10 +676,7 @@ class Tinfoil:
             appendlist: optional list of bbappend files to apply, if you
                         want to filter them
         """
-        if self.tracking:
-            # Enable history tracking just for the parse operation
-            self.run_command('enableDataTracking')
-        try:
+        with self._data_tracked_if_enabled():
             if appends and appendlist == []:
                 appends = False
             if config_data:
@@ -674,9 +688,6 @@ class Tinfoil:
                 return self._reconvert_type(dscon, 'DataStoreConnectionHandle')
             else:
                 return None
-        finally:
-            if self.tracking:
-                self.run_command('disableDataTracking')
 
     def build_file(self, buildfile, task, internal=True):
         """

