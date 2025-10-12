Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B73CCD184
	for <webhook@archiver.kernel.org>; Sun, 12 Oct 2025 17:47:52 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.23230.1760291271452161668
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Oct 2025 10:47:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JrDjmnVc;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2029139f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760291270; x=1760896070; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt2gb+hCSVl3EgVl/XpvAEv/VAiHc4ww7TDk27IX7ZY=;
        b=JrDjmnVcHJr8hUtWHTioAYYQdKZWwTHnQ5sY2Sa877+V0D7zkQ2xyhGx5blpH70cJ6
         AUFl56H9PXTUjvYshnE+V5pYrtkRzpkKJYwk28K8suJvLPIAWdt6EljFJw7GpBcVtTD2
         AyT6kySwApha4k93+skPDZncEtX3l6ZNJYBv/yLiBDa1Tpo4RNr9ViqNe2GGpQ9Qlzjq
         Df5/9s9NXlmD6IIwake+srmye42yjNq1IiNUFBHKHCO6P4xb9tAGaGTjA047RaDYq/sh
         9KTvZKFHnSW7dbM+hl/DovpWxG/+QLdSSR8Ii/h7hgLUoV+TKSnp6l7uHG1El7A/iZ5z
         YAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291270; x=1760896070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jt2gb+hCSVl3EgVl/XpvAEv/VAiHc4ww7TDk27IX7ZY=;
        b=lBjlZ3qoAHP2AqeJTC67EVu/unttcS2Zmrko0TYcm6AUpp7fmkUkqNSJ79vd0OM3i3
         W3PhnvGnoarNkEhgPWc36lXoML67oUiXglKmaLddJbxAHS6NCzi4CKNDQ3T4VuBuwfcn
         e492MHWT5JnnCckuPSXwgr+qb/y/y3opjCapriN50UVgjY0jY+BVxThZ8eXKixq2dVdj
         soXNFQURq6RrR5RG0BfKdQc7bzhs2FwC7q/qaLNxRbsMlqYjFELlItba03tQtdhP4bwZ
         WB31pfQ4wpTRl9lvWlMnlM4LbT3DKkOJeH5ryiKnEjmplyY1j2g1XiB+HQ8DNARZsks5
         5ZUg==
X-Gm-Message-State: AOJu0Yz/XvUvM1iHzTNWotRCDP7DHbSZ+8uJ+6V6Z1SewaVkSw8/rcdT
	pmgGBqAXCwRkY9BkSHakb2R4jcL54GC35SaHw/FIaEV8kZz3R3gP1GradwwKKw==
X-Gm-Gg: ASbGnct0XXtPsg2Kbnj3lom/3uyL15wj676pYPXL/tVBqEHvVcT04BEKPCNAsUm6YPA
	GfE+PqDGh8CJQ4JyyB+eGwOOQqF1ueUpckld0U+lPxxfSiXsq5IpIV420R8eWlJ5XcoTMQuwC6T
	+es3Q7WL2SMQ72CnbBDhkd8xiIfO/pcVcSBPW1GRtJ5Ou/cPMaijFL+rWf5ld8oIBu3gWwkA72V
	WPDm8yYLCN3VThlObSYAmC/xxvwqFG1XSLl2/gYZ3xcJmMbfQQ7kTThdtXfLkqO7f1oNX0J4rRy
	KvfAgwVV99k5vwy/JWa4LerehLd+IM9uVZUlzLvYYUV9G+YzacTKm5khUWaVR3xOvH8jCaC9V2Z
	r5Nb53Z+4rTI3VFpNRvWkbO8HOJyUh06BX6H7jzX/zDEAEpOunqgKpQPLmxzCzc3fGXUiwzkSat
	9/Zgw9Cu1CE4Ag9Pa4UD0J97FZ3o91uZS9tY95m1s0l8BxWh4yFUvvj7xZkisefJk8jqAEu+fn1
	q+764cN7PqO/Wg=
X-Google-Smtp-Source: AGHT+IE+pl+nSqLU30+du08oiUAQSbwPwtJ5BMnYoeQR4g/Thruff7LNkXczbAOf2F1YftykOh6feA==
X-Received: by 2002:a5d:5f55:0:b0:426:d55e:7b11 with SMTP id ffacd0b85a97d-426d55e7b52mr3513280f8f.47.1760291269577;
        Sun, 12 Oct 2025 10:47:49 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm14170160f8f.17.2025.10.12.10.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:47:49 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 3/5] bitbake-setup: use args.cmdline_settings for --settings
Date: Sun, 12 Oct 2025 19:47:25 +0200
Message-Id: <20251012174727.4191604-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251012174727.4191604-1-alex.kanavin@gmail.com>
References: <20251012174727.4191604-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 17:47:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18177

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

To align the storage destination with the internally used variable
name. This makes room for having another option use 'args.setting'

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index cb10b41d4..94514fd29 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -752,7 +752,8 @@ def main():
     parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
     parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
     parser.add_argument('--global-settings', action='store', help='Path to the global settings file.')
-    parser.add_argument('--setting', default=[], action='append', nargs=3, help='Modify a setting (for this bitbake-setup invocation only), for example "--setting default top-dir-prefix /path/to/top/dir".')
+    parser.add_argument('--setting', default=[], dest='cmdline_settings', action='append', nargs=3,
+                        help='Modify a setting (for this bitbake-setup invocation only), for example "--setting default top-dir-prefix /path/to/top/dir".')
 
     subparsers = parser.add_subparsers()
 
@@ -822,13 +823,13 @@ def main():
                          }
 
         global_settings = load_settings(global_settings_path(args))
-        top_dir = get_top_dir(args, merge_settings(builtin_settings, global_settings, {}, args.setting))
+        top_dir = get_top_dir(args, merge_settings(builtin_settings, global_settings, {}, args.cmdline_settings))
 
         # This cannot be set with the rest of the builtin settings as top_dir needs to be determined first
         builtin_settings['default']['dl-dir'] = os.path.join(top_dir, '.bitbake-setup-downloads')
 
         topdir_settings = load_settings(default_settings_path(top_dir))
-        all_settings = merge_settings(builtin_settings, global_settings, topdir_settings, args.setting)
+        all_settings = merge_settings(builtin_settings, global_settings, topdir_settings, args.cmdline_settings)
 
         if args.func == settings_func:
             settings_func(top_dir, all_settings, args)
-- 
2.39.5


