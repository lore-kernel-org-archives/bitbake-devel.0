Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE561C27C76
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 21:52:38 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.7031.1674337956390866128
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 13:52:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=aurWgrBp;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id g23so8214871plq.12
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDNtGF7C9uM9YjG6ZdyMXazUBCRiqMblARBNFC55VEE=;
        b=aurWgrBpj6EtvyTWVaxZk/wxJ0nKwzjwTqEwQ3D/DHLmgl9tl8d8Houmwedu9Gx6GL
         syKl82lN6JdzSvaLN3QT5RSCoQ3PbnAceTwFGbbsiF0DNe1HDFIZXgA7/aTQ2xaPjaft
         ar3vzWHMO+UYjbmcMe8qKjOxCRL5ybdDX++s1wjL3cY5Ie0D14+/mVo6E4eRriMuwnbd
         rh2IYBTqM+Y9CG4KC/AiNotScIMGW7mz/f6T9yzoQ/wuIfjhtofI19NYSu6m6+wOUeGz
         VDf7KBh0ndYfRX0cKYA5KiT50IZNp+Dwn+NxNOzyJUClVYO1YeiYYoteWIqL01Gsovqf
         Yiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDNtGF7C9uM9YjG6ZdyMXazUBCRiqMblARBNFC55VEE=;
        b=Shudb+37rlbDqrOIUL44pHJGfMezzt0b9TBQ0fSY/J/JxnYzp+02eBf6s2dxsc9od/
         SZJfpLwa7QYetcgPNGiA4/5KOCSPUfYB8BQGw11W++RwiTZxNIMNe2wbc4m2uVjHeBhD
         wHVaoGIXFjQENwdWpEJp+fqgV1X8oPjEFND+2nzOprV4eWMCHB2a8KsfTBx4u61XblNs
         BMkJidibsOP8fZ0MakR//zG+qfe8ojmy1MS0c6VCyvC/eBTQUAdZkkmzlJ1GrM1+8tkx
         eVU1+Poc7RwOcBn1gCc5YbeI4U0m1T3aP48DZtZ+3Bx/N8500QqRvZaweHizOHKsQDjW
         VITg==
X-Gm-Message-State: AFqh2kpSiLF7azbKjmB8sS6+Ao1QDKEYMbf/Xl4kp763zLwM2anVNrGz
	mSUi4QUoQntNrsVUzheVyITo+30/8zM=
X-Google-Smtp-Source: AMrXdXsVxYQhDfSOjR1uhZEdNAwRP5AZdGSmGA3/12VnyCxv/fiKQLCIc9BZ/Zm3QC8+Q5NIcTNUOQ==
X-Received: by 2002:a17:902:ccce:b0:194:91eb:5b84 with SMTP id z14-20020a170902ccce00b0019491eb5b84mr22854275ple.22.1674337955225;
        Sat, 21 Jan 2023 13:52:35 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:a180:2f88:c007:24cf])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b00174f61a7d09sm6031672plg.247.2023.01.21.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:52:34 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] bitbake: fix deprecated threading.Thread.setDaemon
Date: Sat, 21 Jan 2023 13:52:00 -0800
Message-Id: <20230121215200.2853367-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 21:52:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14336

Deprecated in Python 3.10:
https://docs.python.org/3/whatsnew/3.10.html#deprecated
https://github.com/python/cpython/pull/25174

Fixes warnings like:

...bitbake/lib/bb/ui/uievent.py:68: DeprecationWarning: setDaemon() is
deprecated, set the daemon attribute instead
  self.t.setDaemon(True)

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/bb/ui/taskexp.py                             | 2 +-
 lib/bb/ui/uievent.py                             | 2 +-
 lib/toaster/orm/management/commands/lsupdates.py | 2 +-
 lib/toaster/tests/commands/test_runbuilds.py     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index c00eaf663..bedfd69b0 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -177,7 +177,7 @@ class gtkthread(threading.Thread):
     quit = threading.Event()
     def __init__(self, shutdown):
         threading.Thread.__init__(self)
-        self.setDaemon(True)
+        self.daemon = True
         self.shutdown = shutdown
         if not Gtk.init_check()[0]:
             sys.stderr.write("Gtk+ init failed. Make sure DISPLAY variable is set.\n")
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index adbe69893..c2f830d53 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -65,7 +65,7 @@ class BBUIEventQueue:
         self.server = server
 
         self.t = threading.Thread()
-        self.t.setDaemon(True)
+        self.t.daemon = True
         self.t.run = self.startCallbackHandler
         self.t.start()
 
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index eb097555e..6d64830eb 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -40,7 +40,7 @@ class Spinner(threading.Thread):
     """ A simple progress spinner to indicate download/parsing is happening"""
     def __init__(self, *args, **kwargs):
         super(Spinner, self).__init__(*args, **kwargs)
-        self.setDaemon(True)
+        self.daemon = True
         self.signal = True
 
     def run(self):
diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/tests/commands/test_runbuilds.py
index e223b95fc..c77d6cf49 100644
--- a/lib/toaster/tests/commands/test_runbuilds.py
+++ b/lib/toaster/tests/commands/test_runbuilds.py
@@ -24,7 +24,7 @@ class KillRunbuilds(threading.Thread):
     """ Kill the runbuilds process after an amount of time """
     def __init__(self, *args, **kwargs):
         super(KillRunbuilds, self).__init__(*args, **kwargs)
-        self.setDaemon(True)
+        self.daemon = True
 
     def run(self):
         time.sleep(5)
-- 
2.34.1


