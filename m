Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9113DCEBF8D
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 19:48:55 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18490.1763408926936843721
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 11:48:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I3wpWx5s;
 spf=pass (domain: gmail.com, ip: 209.85.166.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-94861514a5cso341559239f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763408926; x=1764013726; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=socwnvaXpEJHc4IgQKPX6raIayVvkHgumHgVzft4VLA=;
        b=I3wpWx5sDtwq7sgh2oZk7JOFAQte/FOCx0lheVFZWUnc1d8GC5cZTjE0NohcszeODj
         kxAOPSyP7MbBADwGX1SUV0hqcUjOHO6qiA00ZynAEPc70iG5aYBDdt/o/l+o/HBu8AI8
         uhEWo/EQGg/d1oDI+IAXfaQ/yguancTTj2lerWQrD8WtueVNw6+PUlOKM0CRGp/KwaXf
         4RHTckpC+eJpxg7rjmOOl+EUEaaLDn+5VI70PnZtXcK3SimP4YJgNjKHAkAZUOEqgpaI
         b+UEPQ/Xk53CXLwF04Tx4BtgnwRlyD/Dqp6XEzLkHJIZ8OJAcQKZQbrokUxRvb18dMh9
         lRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763408926; x=1764013726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=socwnvaXpEJHc4IgQKPX6raIayVvkHgumHgVzft4VLA=;
        b=gei0g7TiQPbR5tUMAsyYA/hsYZNlBXCI4GX/19POTzOGyo2DKZKtDOv2xUxpzfKpeM
         AXRU0bKkVpiqnZcki9MIHAIMg/gAA9ymioeDi2w2tT6P0UoQR3Qe8qLLM8uIsO92INP9
         3vtouncX3kEF/coD72ZnfTMWj/qmYeTAqpM7YjrUsAnBqcz5rc8EUOhjB/vEu9jGhzSK
         1/Qx+NtThxfUqbL8/nkN2zqZy2o6buiuC5gPm4Gc6qqGV860+MqmEG5P22Z0RtvWoqTg
         v2574CYVGU/VYA5RRyRhRXPlRsKyzveLqqrFDL0AuPCD35NorYNHnYYtQSSEgSzC49oK
         zGPg==
X-Gm-Message-State: AOJu0YxeK/FzMbac0CHLzX1BMnGePnXVtixIqTWDQFrGVjEyBPpoFdEl
	SDHzjqbIWtwv1z0hcF7g5Ac3JazzcNMe3tcVV24CDhN0369VwRuvaI5B7RCXRA==
X-Gm-Gg: ASbGncuIJkYc/rgtwvUHYiAv1z3Oh+IXKbdHrjXY00yNuyNGTxFEgC2oNCu0mnGOb5g
	pHERAwA3+LRnO+CsFB5u3pQPJu3xm9Go2th7j5Jzf1d2VMW9t6adKUuzEWn/51GR1t7yrsE+7EM
	OtHtjwDAax6bJIg7ctuiblX6uU3JA/NMWBIPbrn8fgYt3C7GgN3dsJvAeL6CO1Y9jzxEj2KpcqR
	fGxMh4EMH3LHKEF4E09J+GiEDskoejaLRDwsNrN/3dHlCqjvBRxflmqiEZPqMH5EnENhHSHeJMC
	NEGsYI9GDO9FRxFHKuA9L79KXic2lQqKAQTSPGSRBbzufRBoauO6OJl6vemii3lPEJVAWkYcAFI
	CEWYsZlZpvlb6stesvIVRmQ37rfXd49AC+eX8rZaV8U9m11CLkj7OhJC6jzvNe0a0qUwHd3e2/3
	zQop7LDADb8eqFHbyLnVI=
X-Google-Smtp-Source: AGHT+IEzg4m03kWRUVPDmsD6NzLzVHZJ0afijLOygcjzs9F1n7Nz+G8KbPvWi2/YSYVMoya+l2ofmg==
X-Received: by 2002:a05:6638:16ca:b0:5b7:c3f8:9d96 with SMTP id 8926c6da1cb9f-5b7c9c45cf5mr10202055173.2.1763408925976;
        Mon, 17 Nov 2025 11:48:45 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::9115])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd24d922sm5086968173.10.2025.11.17.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:48:45 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/2] bitbake-setup: Allow setup-dir-name to be specified in JSON
Date: Mon, 17 Nov 2025 12:48:39 -0700
Message-ID: <20251117194840.2322115-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 19:48:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18437

Enables the JSON file to specify the preferred name of the setup
directory with a 'setup-dir-name' key. This key can have variable
expansions in the same format as python string.Template strings (which
matches the shell variable expansion rules).

Variables that can be expanded are any fragment configuration prompted
by the user (e.g. the keys in "oe-fragments-one-of"), or "$name" to use
the name of the configuration (e.g. the .conf.json file).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7e9491fac..7ee182bf3 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -17,6 +17,7 @@ import glob
 import subprocess
 import copy
 import textwrap
+import string
 
 default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
@@ -467,7 +468,15 @@ def init_config(top_dir, settings, args, d):
     if args.setup_dir_name:
         setup_dir_name = args.setup_dir_name
     else:
-        setup_dir_name = "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_"))
+        if 'setup-dir-name' in upstream_config['bitbake-config']:
+            mapping = {
+                    k: v.replace(" ", "-").replace("/", "_")
+                    for k, v in upstream_config['bitbake-config']['oe-fragment-choices'].items()
+            }
+            setup_dir_name = string.Template(upstream_config['bitbake-config']['setup-dir-name']).substitute(mapping)
+        else:
+            setup_dir_name = "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_"))
+
         if not args.non_interactive:
             n = input(f"Enter setup directory name: [{setup_dir_name}] ")
             if n:
-- 
2.51.1


