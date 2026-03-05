Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB923F47CCB
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 20:09:47 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53725.1772741387299102138
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Mar 2026 12:09:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OFpt34Yq;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso56678845e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772741386; x=1773346186; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0old97PWQ3yEbyjvS8sDrhUerPZHa5x87m38AT2TPm4=;
        b=OFpt34Yq0zdco9zzZ78WoafPSJYz1CaGZkTNEmLFT1ydVnqXEFR+s1AUcbFmCFtYvn
         x1KR65IdC5VG1+WyYdAZ68qolmx23nxWgqJka+OoTql9FsVSQVPxjUL1+pzOGQJb1+zB
         YsTfa9Abh4Caw+s1XDkcpxCN2q1i2xjhARXMm2ilZ56YAcw+HEypgiXTqMYa+wl0XEMk
         EYV/o4OEISK6YEdfXqZfBYVxnK7N7WkWXIoK3Zx6YeY0kodhWvd82B2lFN95VG18fL5f
         M8gz0vINyoIHnz0KaGIsHRYi4EvFiVieQI3xSJjlz/nad/4teQploSr5DfNYSuJTBvGq
         F7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772741386; x=1773346186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0old97PWQ3yEbyjvS8sDrhUerPZHa5x87m38AT2TPm4=;
        b=eOheX+zYCpCH0dR4AyDCxfjjWLDmONip+LoHKK0Knr2pkbdZwR/2ZIuBSnumyC2Hxs
         86p6t+5+yGTX4hHEVJsgKA974mcK/XfjCSN5yYeGLtf3VEcoALt9hPiTGHj5erpDCo2q
         FqVCQxgS4mRV8RmGtSM1ga95Q5tXGc2+bWrIR/Yi1pP9qZjf+SkSTIdneO7M2IYXlKWw
         Qk1s5JUtVzFQykUuPO2ADOVf5LScWBj23Loawowy9mR/MLzqX32UcF8ne05lcn3bJeBE
         0kltXZUkDfgYTJ2qg/afnyGqMOW2TtDJpC+DqytyDBvXGW6O2SQ/rnkk6udQz1cLUny3
         fPYw==
X-Gm-Message-State: AOJu0Yw/R7sTB+hXYV+y8z5FIqpM5k7xNfbOVPNuR9wUxkyNsGcJ9Za0
	T/iBeTlVwAvCxvS7OipHY8g/h1yIDjiO/u1DMGw6ga0qBWWCHpsF2I+0XvLxfw==
X-Gm-Gg: ATEYQzyr2R/4WiLN00SR7n9MYtKO4JfNxTUAKhd6xTU+CGfFTqe7sb7IttTCGSGquXD
	CzvYo78c5eJabhH1LAdK+PJ/jAM4JJMAU5FGlXhk8cpW3olBLgz6HxFW+vYugYscFPgraO4Pvke
	NDyUQQdo+/2CAeWG9BMlf+C+7/tiks0AYBMsLbhp/4RW5xX/dZ8QGYFlWpsnG87qGJOhhLKP8V9
	blS56geBnpwMFp8yVWg9f1U2+Nlu/86MEB5tLJCm2FRgxe1G43BPGe6OyWI/meVkLRj9h2ptB1V
	3IAT0TBy5Q9emmuT/LRs6X/6ZdUgb0tNNkq3VdwFqZlLjo99/jKAChTloUK027H6Kk8IqeQUuXO
	H3uyzb4zP6lPvtSDz4+55DtrYqnq2QI/pIhLlZmWn9ivHBiJ8QE4157bQ9SrqkuVTAaHfNHu7RY
	CCCdfZNmSc8c1pSS24C/7fvJkJO+ZNWGfFtVhD1s3wQx/OePjK4cXouvJ70FE=
X-Received: by 2002:a05:600c:4f56:b0:47e:e2b8:66e6 with SMTP id 5b1f17b1804b1-4851eea0983mr62035985e9.14.1772741385380;
        Thu, 05 Mar 2026 12:09:45 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851faf3938sm61203745e9.13.2026.03.05.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:09:45 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/2] bitbake-setup: correctly determine latest revision in status/update when it is fixed to a commit id
Date: Thu,  5 Mar 2026 21:09:37 +0100
Message-ID: <20260305200937.221484-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305200937.221484-1-alex.kanavin@gmail.com>
References: <20260305200937.221484-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 20:09:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19118

From: Alexander Kanavin <alex@linutronix.de>

The code was relying on git fetcher's latest_revision() method,
which works properly if the revision in the json config template
is set to a branch or a tag, but does not work if it is set to
a fixed revision (the method will return the latest revision on the
respective branch, and bitbake-setup will incorrectly determine
that the layer needs to be updated to that revision).

Add a guard to check if revision is a commit id, and skip the
check if so.

[YOCTO #16190]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 1a42aaa51..69362b589 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -741,9 +741,13 @@ def get_diff(file1, file2):
     return None
 
 def are_layers_changed(layers, layerdir, d):
+    from bb.fetch2.git import sha1_re
+
     def _is_git_remote_changed(r_remote, repodir):
         changed = False
         rev = r_remote['rev']
+        if sha1_re.match(rev):
+            return False
         branch = r_remote.get('branch', None)
 
         remotes = _get_remotes(r_remote)
-- 
2.47.3


