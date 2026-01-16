Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AE2D4A619
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 09:57:55 +0000 (UTC)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2683.1768557469458865816
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 01:57:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CroGw5tm;
 spf=pass (domain: gmail.com, ip: 209.85.128.68, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so9394465e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557468; x=1769162268; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18LELIipLKKARrAqkE2/P1tV1/34wQQlQQyaU3oYwBc=;
        b=CroGw5tmprka8ZxRAGZELlwlz1l8PEEtHRAWnn/BvyKlkfFPg9DUMq1FrXZmiyEofI
         AqriB+8jvFm8dW0MafRKGbmsyZgJo9qZ+VpJXlzXbqQzL2OlY7Th7N41ZZU+Xh8G6cvG
         D0aOjGVY8ip4HCpH5gbk4MFGU5X/YMff9U7eVCEujbyDgxIlcc+k1m4O1xgF3AMLuhcC
         TOVZunXakc4/HQzFhTy9eoQ+jc7eXAVqysWflfEBWoHHroi9bp5nj+nrlx4kBtPO2tq1
         vQPPVOCfB1fYaZVJsFgFpEx24goqBa+5C9VkuAnYHpWCiLOFlVq/7cTbMlWMlqAm5eOu
         bPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557468; x=1769162268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18LELIipLKKARrAqkE2/P1tV1/34wQQlQQyaU3oYwBc=;
        b=TuXGwU8SNQJ8IZ8lFl1IyNi4kxnOr/eVoIzX7lJzohTQMIZhEkkOz9uH0LT4sJFr6m
         ZlgLgXy6ikwuO8E3B496/1SCMhKFEhRbfRi82Kv4G4uScNOpscLrCeshh6LQAAM1qmp1
         GjmOwLqO8jxRQuvfZCqCiPLVMWhB2lP28dJA9Aoez3lVSLr65MpARRfYeBwJJ93HOOIZ
         BllLYXZuoAP2ODdw6mVPbChPN9VRwz49Q/SLQNE4mkc/2WgVgRICPBBjMNKOqD7jy82Q
         roMVWtaa/J5a0EuEHpyW8+5lVaX0M7a2jZ9vNt1+3Kkzk7q6af/NShFidosJsJ0IIYgz
         v0gA==
X-Gm-Message-State: AOJu0YxhsPS3P3GRXb3bepHYTdJ4HDQMKx4nFLNFj61qmreXXSMPqERk
	G3YyBT2a3lzijieVfNvR2FYVX6gob8+kxMI7cQT01exqX66lwl5SLtKWxgcCbNyd8H0=
X-Gm-Gg: AY/fxX5gJNdXsfE7aZwUUVmNvTneiI/P2F3Mj7h0RQUYDau21SJ19E68LAzG7Uq5/q+
	7cz1+dQAz/W7NIpDw/z7830LOrt1AdWsE2fhzqMLYCFCstRn7rqGDHAqgq1DlKEOlr7ujXGxzkW
	3F30QB6ngHRZtsFe/NEDe6+mvg3xa8x+LxPRPFvWOhNSZijc2PYlHNvWKd4NfM9kq/9FcsalWy1
	WsAtDvHAhf0263EC5RNSpBF/X+1Z/NVv2f/B9zlKsyBIRV6XSbAN95FWhiKVfcKzlXgYrgZaYDV
	16u+HL/TZ3pjKfERvhsfqinm0sDJbVneVwDIMKmMQNgL5xJ7FZ7RVefeLENaM6igyfzfG7N8waU
	O8diP0aB+Y+GoH96T69TJk/9uW9OPqT82XpAusNmEITeQS5hbB4StFLTxycpXVkMEdOO6a3D65M
	3sg90zP7SVAATqrZs/xexhSkC9DN4oNek1yqMP6iApe3mJIEQ=
X-Received: by 2002:a05:600c:c4a4:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-4801e2fef34mr34419125e9.15.1768557467585;
        Fri, 16 Jan 2026 01:57:47 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c1b2sm34188175e9.3.2026.01.16.01.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:47 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/7] bitbake-setup: pass only the registry settting into obtain_config(), not the whole settings
Date: Fri, 16 Jan 2026 10:57:34 +0100
Message-ID: <20260116095741.3654153-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 09:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18792

From: Alexander Kanavin <alex@linutronix.de>

This will help the following commit.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 4d709ed8c..4496cb61c 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -523,7 +523,7 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         choices[k] = options_enumerated[option_n][1]
     return choices
 
-def obtain_config(top_dir, settings, args, source_overrides, d):
+def obtain_config(top_dir, registry, args, source_overrides, d):
     if args.config:
         config_id = args.config[0]
         config_parameters = args.config[1:]
@@ -541,20 +541,20 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
               upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
         else:
             logger.info("Looking up config {} in configuration registry".format(config_id))
-            registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
+            registry_path = update_registry(registry, cache_dir(top_dir), d)
             registry_configs = list_registry(registry_path, with_expired=True)
             if config_id not in registry_configs:
                 raise Exception("Config {} not found in configuration registry, re-run 'init' without parameters to choose from available configurations.".format(config_id))
-            upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
+            upstream_config = {'type':'registry','registry':registry,'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
         expiry_date = upstream_config['data'].get("expires", None)
         if has_expired(expiry_date):
             logger.warning("This configuration is no longer supported after {}. Please consider changing to a supported configuration.".format(expiry_date))
     else:
-        registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
+        registry_path = update_registry(registry, cache_dir(top_dir), d)
         registry_configs = list_registry(registry_path, with_expired=True)
         config_id = choose_config(registry_configs, args.non_interactive)
         config_parameters = []
-        upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
+        upstream_config = {'type':'registry','registry':registry,'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
 
     upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
     upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive, args.skip_selection)
@@ -594,7 +594,7 @@ def init_config(top_dir, settings, args):
         logger.handlers[0].terminator = '\n'
 
     source_overrides = obtain_overrides(args)
-    upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
+    upstream_config = obtain_config(top_dir, settings["default"]["registry"], args, source_overrides, d)
     logger.info("Run 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
     if args.setup_dir_name:
@@ -708,7 +708,7 @@ def build_status(top_dir, settings, args, d, update=False):
     args.non_interactive = True
     args.skip_selection = current_upstream_config['skip-selection']
     source_overrides = current_upstream_config["source-overrides"]
-    new_upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
+    new_upstream_config = obtain_config(top_dir, settings["default"]["registry"], args, source_overrides, d)
 
     write_upstream_config(confdir, new_upstream_config)
     config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
-- 
2.47.3


