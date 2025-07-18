Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A692C83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 13:54:43 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.21423.1752846880892874595
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 06:54:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e7S33lC8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a51481a598so1109363f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752846879; x=1753451679; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwrHoYXSIt2LcPvhsFwBzZK+TAdX6L/PpAtIxOXzUE4=;
        b=e7S33lC8hZ+OWpxamOJUew2GjDx5HlBFADLtBVvDP2dP+brM1NEZKL8ZL6fKnk4VUY
         wOD9ob3QhuRHzIGKTquNRhp0pQ+RAt6PujMczd54PvhuuHNNLztfFq8OAGnW6jbjca80
         c7p6WrBm7YB3SWsJNYfgRFn+6AVLxxc+YEnZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752846879; x=1753451679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwrHoYXSIt2LcPvhsFwBzZK+TAdX6L/PpAtIxOXzUE4=;
        b=wdQMv8mAUPwNlnv+CEFPaU70PPoj7e8q8FYquOonp4oUXKvHykKHTcbiDA7+ryFAuJ
         82BU7Rekv5JmfM2YVpo/xJr+ay7H3+/X1zRk8M/jm2hgTUxNCSRnl5KQ7l88tKlg1yJ1
         vV45+lHfQaNSEI0kNaqb5kSMyT5EOAjS9PBDyt6JZAQ7lIsrW4xkUDrUNnlQ3vgXf6C1
         PLNiOK3zmN8xa08t7gKQDEpteMv/GKWe6JrWbipcmWvXTYb+ooohkh/DQdxVQdk+mNLO
         7eyMDMT/GOEA1+B7H+m8YA+l3iK0k1HzfOuZU9RT6hRPjW37JUOJvyGOuGDlDlljVGfa
         5Fvg==
X-Gm-Message-State: AOJu0YztmAU79cjMvqNcWA1HWjJpq71Vb7dwHcRUT66kQSA2QNGTKal9
	DPGZDma/6ubGIENQ9vXfaLC1zDNBOJz7iH2OWspl4bxs+2bXIIAHZdhUuDfov5S8RAajSIJakIg
	1BZ13
X-Gm-Gg: ASbGncsp6CJniEO/Hdciz/foPY5Z9Da+Qn7MeQe00W/O8HSgMtDKt1oXOJIXi0cqINX
	o0RVkbGCMHrqLIz7DbWGoBr2oSsLr58cO5F4iWUpI+yfj545AVI9vN4tLQoPH/MFgbGKijbt6CL
	XV28He7jiXlQUXQgfJ9RChZdKE+om3/ZwDIWpi5ENGERezLmjDKrhJcCazgE4WAHGv6ljrcU+Yg
	qDUj5wpgMnwpKVAWboWXXO2TzEm9R4f6WhBJPhXAX6Fl2xlcR8wG0P2Q0wLehNxho68M7Se+8s/
	wn26g2hcf9zaDRMe2qSHV6LM5KdRfknDzjaWW8CHgVC+cwuFJRY1Vimiam/yNAs1LHNyDbc7Nz9
	YhSNXOAAV/r4NSOXm2MOXehvV9BIvac3NWQ/WPYtW5cjdB43E
X-Google-Smtp-Source: AGHT+IFAjLe6lklnBUXu54wNGOVJ9KmAfSqxotzbRYegmatySci9I6Ir/0NV4I2IQ4pR5tWO2NoMgQ==
X-Received: by 2002:a05:6000:4006:b0:3a4:f975:30f7 with SMTP id ffacd0b85a97d-3b60e55040fmr9614860f8f.56.1752846878501;
        Fri, 18 Jul 2025 06:54:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b19:5c6:27ed:a530])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45635fe6a9dsm31275825e9.2.2025.07.18.06.54.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 06:54:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] utils: Optimise signal/sigmask performance
Date: Fri, 18 Jul 2025 14:54:36 +0100
Message-ID: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 13:54:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17794

Running "time bitbake -pP idle" with a valid cache shows around 800,000
calls to enum creation from python's signal.py. We don't care about this
overhead and it adversely affects cache load time quite badly.

Try and use _signal directly, falling back to signal, which avoids
this overhead we don't need and makes cache loading much faster.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f688f7dd687..016036dbce4 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2226,6 +2226,15 @@ def path_is_descendant(descendant, ancestor):
 
     return False
 
+# Recomputing the sets in signal.py is expensive (bitbake -pP idle)
+# so try and use _signal directly to avoid it
+valid_signals = signal.valid_signals()
+try:
+    import _signal
+    sigmask = _signal.pthread_sigmask
+except ImportError:
+    sigmask = signal.pthread_sigmask
+
 # If we don't have a timeout of some kind and a process/thread exits badly (for example
 # OOM killed) and held a lock, we'd just hang in the lock futex forever. It is better
 # we exit at some point than hang. 5 minutes with no progress means we're probably deadlocked.
@@ -2235,7 +2244,7 @@ def path_is_descendant(descendant, ancestor):
 @contextmanager
 def lock_timeout(lock):
     try:
-        s = signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signals())
+        s = sigmask(signal.SIG_BLOCK, valid_signals)
         held = lock.acquire(timeout=5*60)
         if not held:
             bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
@@ -2243,17 +2252,17 @@ def lock_timeout(lock):
         yield held
     finally:
         lock.release()
-        signal.pthread_sigmask(signal.SIG_SETMASK, s)
+        sigmask(signal.SIG_SETMASK, s)
 
 # A version of lock_timeout without the check that the lock was locked and a shorter timeout
 @contextmanager
 def lock_timeout_nocheck(lock):
     l = False
     try:
-        s = signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signals())
+        s = sigmask(signal.SIG_BLOCK, valid_signals)
         l = lock.acquire(timeout=10)
         yield l
     finally:
         if l:
             lock.release()
-        signal.pthread_sigmask(signal.SIG_SETMASK, s)
+        sigmask(signal.SIG_SETMASK, s)

