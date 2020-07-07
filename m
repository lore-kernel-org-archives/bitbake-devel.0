Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
 by mx.groups.io with SMTP id smtpd.web11.17725.1594132764137156861
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2020 07:39:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=U0ZlqI2p;
 spf=pass (domain: gmail.com, ip: 209.85.222.196, mailfrom: dakhouya@gmail.com)
Received: by mail-qk1-f196.google.com with SMTP id r22so38280761qke.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2020 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87WDsX1wzF1eJ04xy+CCoLzUYtnAFL0vDYTm9eBe9+s=;
        b=U0ZlqI2pJ2BSs/mHKr0kIDUat0jkloZEmDBUQWYkkZf1P+gE2DnxjBWvu5n3pnlgAU
         bmJna5U3TiDSSCzDM/4l6545N4AW5VkOXl4fgNA7IOWPIGB03mXrsKEJjkYFmv6U7z44
         2hhEPgQA91mtMHxx6lolc8A+fyQnyb0gNNTHNI8b/HBs2mJMWPNzs4evoUlL6YNL5SZ+
         MqLfXm9OWfp+vvBVam5Tr18lObF0jvRN0sA2FJXL/i+AIigbFoAF8Sgr7t0SyYucKyb5
         kTSwhdfIeMIdrgkNj9eHAumZv2i9WJ/ejHRMqqT9OOqfH41PJJLJEWlRN1mEkFaViu9B
         P/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87WDsX1wzF1eJ04xy+CCoLzUYtnAFL0vDYTm9eBe9+s=;
        b=am1gvd5xompFVrf14htQBsEgb4X1l2Z3Y+jMHHS+kGz2+dk1HUsJdhlG9bjmv6ij3v
         T5FOiDdvkMijg7DyQ7IcntVadSW7ZzPcyVWoFOqXCLRFlue1UR/UiuZELNSipG3gvIeJ
         vsG+XN7HXxtI+7V/CYK8nwFZbFa/lSvUQ/JXxVD4I+x2UF5Y4vCMqR/SLkkYSzBXh9PT
         ymFIxG9PZvK/7+FG9AUsgFoqQoRXAeDIv3zRAkA8Gv0g+WVcmSa/XmKXbSYqTJ7TmsTV
         fnfVhWTP1JOiRdbmmYyyBBm7VivAAykn8f2YY4XceCz+1t3IY5LAzhmjJjf1nKTRsCGD
         arLQ==
X-Gm-Message-State: AOAM533+YIq8Ve4ST6XjUtO7lKvwraXTz0U/XctvxLdXnLM9GdZms5p/
	MywHo9NWCvEh1XVJSS0TB8JpX/2liik=
X-Google-Smtp-Source: ABdhPJxSGHgi9uKyqp9WYFmxSJnbha/s/u2/Nbm2IScQabPkIPkjITBShImdNKfVtP3LdI4VbxsXMw==
X-Received: by 2002:a37:7683:: with SMTP id r125mr49656881qkc.39.1594132762952;
        Tue, 07 Jul 2020 07:39:22 -0700 (PDT)
Return-Path: <dakhouya@gmail.com>
Received: from dkhouya-ThinkPad-P53s.effenco.com ([216.46.7.178])
        by smtp.gmail.com with ESMTPSA id o187sm23754073qke.76.2020.07.07.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:39:22 -0700 (PDT)
From: "David Khouya" <dakhouya@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: David Khouya <dakhouya@gmail.com>
Subject: [bitbake][PATCH] lib/ui/taskexp: Fix missing Gtk import
Date: Tue,  7 Jul 2020 10:39:09 -0400
Message-Id: <20200707143909.92348-1-dakhouya@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding back gtk objects import.

Fix bug introduce when adding validation on gtk import.

Signed-off-by: David Khouya <dakhouya@gmail.com>
---
 lib/bb/ui/taskexp.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 336d197d..05e32338 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -12,6 +12,7 @@ import sys
 try:
     import gi
     gi.require_version('Gtk', '3.0')
+    from gi.repository import Gtk, Gdk, GObject
 except ValueError:
     sys.exit("FATAL: Gtk version needs to be 3.0")
 except ImportError:
-- 
2.25.1

