Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFDFCCFA13
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 19:06:48 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17661.1762369604846787162
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 11:06:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KkdF9ao5;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775895d69cso809285e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 11:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369603; x=1762974403; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPRv7h9aFZz/gdi9IpifxZuqZwXZtjJYIFD4hy0CIZQ=;
        b=KkdF9ao5F/1MDABkYZH0espgPf8JhABgE08WHDgS4qyYab+lKF8Wy3TAukKmCLMsLA
         7cByHq2auTYh4mdX2GM1EAz3TSn454arNwORz6PLoB+L3XNGKSrFjYv5KKBix3R0aswU
         +VcqM77QwztYpNw6AoXEgZhz6wAF8+qY3mfFWBpvSneLMy0VPDI/yMLfBsfXq31Jj8Qp
         S/LKsZOyIvxg6BIr9WatpVtv0nsIN53Pn1ukg9wMXAbDUQxiEiMXsCvSS4VhOpftsPBk
         roS7igXhIgETQUzhG8pGe4BpJKk1oyKeIsoZOy3fOV7825SmnuzLeY+afXy7rrg406DL
         0rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369603; x=1762974403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPRv7h9aFZz/gdi9IpifxZuqZwXZtjJYIFD4hy0CIZQ=;
        b=Nb8BaD1eWDVyNtWhKF3j+P3Q/Zp363p8+zOLF1QhZGAYbvF1V2R92Zd/T8bmH5wJ12
         5XpIRxNNR+Y/yixg+uI1xn2yONjhjLXEj6TFVTRU7GlmC/DejErsO8IyLngolqRi8aGK
         ZDpwBA27XGZD37Rb7qZEKI/hREajrcE3MOVL/f2OPwoC2pnDrq5/IceJ8zOkk0oxudsr
         RIopQFBs01CdNOknc5xjXx1Ac25bCYcI7cjPztatTgHXdXYMBJuEAEycKCOARhKGnICO
         WVe5JKlBdbKyXXqMjywhQa+JXmWq55yHjr4YZUbfxzz6/wRInNJz+8GltSmeW6jRcibD
         e3aw==
X-Gm-Message-State: AOJu0YzKa77dFVdvVOqoZO40ZBBtwxutaEjFSjKK7eBvpS6nSsIzQ2d8
	ulx+GqguGaYeHA2F9vhG260MhwsQSZnGa7M1H8hWBzwJoZKAppnf0sS7vfdgAQ==
X-Gm-Gg: ASbGncsKGrGAiRMYoH/7GXjl4L8EtKRr26s01rJs1h/YljUwcBD/W7K2c/TtVbW0Gia
	E2LbQXltDQpodjmzFAESn5y3SPYRITvk+f9HALmhARLvj0dhnL7OiTFrEykxeeKUig2FSn9V9P/
	kRzTqI3iAQ7dU7JKtkywh4uwqhaC/AsXZpeAQdnbdMJyi5ee4yXaym6P6wnCjXkcQg8I18KB/Zv
	AWpCDtBTw5wUG7uv4crIPLnPy/brGRmezRMGM1bdrQMIQ+9P+1uVIt6o9dfgc5tMB+ldjL7D2u0
	FSCzzaO3CrTvxZp0nJTmgVE4vjdNe8jRnOz6GbkpJl0nsrXrPIwF0qdo7I044/KsE7NLJ2u5Wji
	wWfPgU1ootBTk9W/+8B68rmIJSfYOZM1PZE2PMbj9FBL7TZ903LeF2eDkAvO6z29bMhxXyminvm
	w6U2tYw71pO53yoNoAaZc2SA6o5B5laKffhk11Cx3xCoTWRI0=
X-Google-Smtp-Source: AGHT+IHcNN5vZqTk9umic0CWpWmHJ3JNArZA+kxklnH6CYqfnsCVqLE6Mk/yaSfBQkGB2SUFRZh+Mg==
X-Received: by 2002:a05:6000:40cc:b0:429:b857:6fdb with SMTP id ffacd0b85a97d-429e3311896mr3545483f8f.49.1762369603137;
        Wed, 05 Nov 2025 11:06:43 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477203sm313840f8f.29.2025.11.05.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:06:42 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 3/6] bitbake-setup: rename 'write_config' into 'write_upstream_config'
Date: Wed,  5 Nov 2025 20:06:33 +0100
Message-Id: <20251105190636.679388-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105190636.679388-1-alex.kanavin@gmail.com>
References: <20251105190636.679388-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 19:06:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18272

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Rename the function to reflect which (of the possibly many) files in
the build/config directory it writes to.

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3f56f8378..59b4dfdb8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -57,9 +57,9 @@ def get_config_name(config):
     else:
         raise Exception("Config file {} does not end with {}, please rename the file.".format(config, suffix))
 
-def write_config(config, config_dir):
+def write_upstream_config(config_dir, config_data):
     with open(os.path.join(config_dir, "config-upstream.json"),'w') as s:
-        json.dump(config, s, sort_keys=True, indent=4)
+        json.dump(config_data, s, sort_keys=True, indent=4)
 
 def commit_config(config_dir):
     bb.process.run("git -C {} add .".format(config_dir))
@@ -469,7 +469,7 @@ def init_config(top_dir, settings, args, d):
 
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
-    write_config(upstream_config, confdir)
+    write_upstream_config(confdir, upstream_config)
     commit_config(confdir)
     update_build(upstream_config, confdir, setupdir, layerdir, d)
 
@@ -526,7 +526,7 @@ def build_status(top_dir, settings, args, d, update=False):
     source_overrides = current_upstream_config["source-overrides"]
     new_upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
 
-    write_config(new_upstream_config, confdir)
+    write_upstream_config(confdir, new_upstream_config)
     config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
 
     if config_diff:
-- 
2.39.5


