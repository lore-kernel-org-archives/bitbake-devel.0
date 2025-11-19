Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EDCCF3955
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 16:24:19 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11195.1763569456332195971
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 08:24:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MHcq6EDO;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso3101401f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763569455; x=1764174255; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sbj5O290ajhpEa/C/eQEbseDCuKKfi1YSno9oHdF70Y=;
        b=MHcq6EDOQBdHtos+NI5o+BbQtmSkDI+qRt8pV0pEIc0Ku1MBJmlPosfew+C/PQJZoL
         /cUTpYBjK9CzmfzqRVxcuLFDyzEmNj4lIGv+oo9f7G6Jl5k2wb5FX+fKeRXPV9K7f8V0
         2OZRlhljvB+j+5nDDmMNsc8E3Sy7OMB7jPaRsHXG4GRtGcXlIeY4gnS5mQCFBVrxwU8i
         MnsTizzCIIJYp0JjfAQxqQmpNFbrVN/uzbHWwchjuT/tlS9oPsCK2iSRbRj17tbjJPHm
         +CUozp3IDBM3DtRBjGCsFq2i5kJYX1EwLRvHtjVOIO5Z/p+Ad/mE8dSWdXI2UtaxAYgG
         KA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569455; x=1764174255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sbj5O290ajhpEa/C/eQEbseDCuKKfi1YSno9oHdF70Y=;
        b=ae5hbhIwx7+kiP00kFhR7TaJChkWNsfDBV5jPD3neCw7BzIRodqBbF3Qg4jB13DZmA
         tPRLxyKsGVCVzC5ebYsBPUmK8V1mAh6w47XGIWSzU1jQt2U9HYVRwoCjezGm3Smw5m28
         lOCffevseluKVcp2C17xn2Lh3ivaPl1PpYZIPwjktO1qkE2yUlCw1aWpT8DZFn0fOFMe
         /elkjvAM6CWFhDxK0uoWpqQUvtIPdrum0RPxM1FCZ4yqmgQWBn2ndjvIi7xNh/YF4434
         SDq/fJnebHmdYFnsOcr/oC6vQJl2bkFS8RD8zI6QwrxdqSSluZCmOr2Ars/2rQRTsZiy
         RDfg==
X-Gm-Message-State: AOJu0Yw0ZOtTR1vOC5U4hLgFFrxpvV9Xqr7NiLqpI+5SKL68l62W+gg/
	PMA4ZEeatoSOmLNV87Hj2YOF+gg2Fe/+RVe6swJr4l78chAfeDs2gkH4HC2XbA==
X-Gm-Gg: ASbGncseP6q39X2Mkx6RzL5de4ujfgEVIf/kmNHZWPz+dHxGBsVh3gSGNJM+105+V87
	IVn9xwy9EDO0maC5YhEgh1m2l7/yI+HtvxzynKzSHt48ILkMA68Flo7OdjxkYj65SWEvte3yIhL
	H58oLOqM2viI1iErbKKIFyyGCfyxSf1isBguuQEbZq502gQXyduvboIzot8pr2mrmCCWzeGyX6U
	TLdKKN2XOVF3IBAYbFj3aMvB2/ESH0b2DyJBI3Tr/FAmWzt6N0CGrB2681sEzl9G8vbMjmX1uwx
	IL9G+VfjQ4NUfDX5HYy8o4Fz9R+SfQ0HBSfsBwbdqypTqZwZWgeQ1Y/9BOA/sfHhAjEAuyC4nLq
	PZQpEruWuuDVOxZoWP/3To+7jwEJ/uzaMAzsr64nDqUuNLqUJZzKyYPio1jP4f68QoB0fxetTvx
	VRKbyDd+THiaFZMakaJpvWzj1DltHQxzW4XcKeGgtx21nxxGfM0cGviqvQTg==
X-Google-Smtp-Source: AGHT+IFd8bMsFm558GPyGQN4drsVPeWWrEP23RjHgKzqJjuo82Ju/EhaOhmQIo1dcnKJeUH+8CwhKw==
X-Received: by 2002:a05:6000:615:b0:425:75c6:7125 with SMTP id ffacd0b85a97d-42b5934f2famr18159051f8f.16.1763569454426;
        Wed, 19 Nov 2025 08:24:14 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363c0sm42850f8f.18.2025.11.19.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:24:14 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: use a transient temporary top_dir to list available configs
Date: Wed, 19 Nov 2025 17:24:08 +0100
Message-Id: <20251119162408.3793924-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 16:24:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18462

From: Alexander Kanavin <alex@linutronix.de>

As pointed out here:
https://lists.openembedded.org/g/bitbake-devel/topic/116374639

reusing the standard top_dir is prone to issues: the user, if they're just starting,
may not want anything to be left over after issuing 'list' or even want to decide where
the top_dir should be, they just want a list of configs.

Also if the top_dir is set to . (which is the default) and the user is in
a directory that cannot be written into, there'll be a baffling traceback.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a8da10e4f..792f5579f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -681,10 +681,15 @@ def list_registry(registry_path, with_expired):
                     json_data[config_name] = {"description": config_desc}
     return json_data
 
-def list_configs(top_dir, settings, args, d):
+def list_configs(settings, args):
+    import tempfile
+    top_dir = tempfile.mkdtemp(prefix="bitbake-setup-list-")
+    d = init_bb_cache(top_dir, settings, args)
     registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
     json_data = list_registry(registry_path, args.with_expired)
-    print("\nAvailable configurations:")
+    shutil.rmtree(top_dir)
+
+    print("Available configurations:")
     for config_name, config_data in json_data.items():
         expiry_date = config_data.get("expires", None)
         config_desc = config_data["description"]
@@ -983,6 +988,9 @@ def main():
         if args.func == settings_func:
             settings_func(top_dir, all_settings, args)
             return
+        if args.func == list_configs:
+            list_configs(all_settings, args)
+            return
 
         print('Bitbake-setup is using {} as top directory.\n'.format(top_dir, global_settings_path(args)))
 
-- 
2.39.5


