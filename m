Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
	[209.85.215.181])
	by mail.openembedded.org (Postfix) with ESMTP id 4CF007FD5E
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 16:01:14 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id q127so2795804pga.4
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=uUF1CzOIRrVfItCXb7QNbPR6UCe3KiwyhKUJBWMTiUk=;
	b=SBV4UAHUNEz5jGisT64U39Q9ecS6TWWE5uXv//hUqhxA4cseXx8bH1OIgOrKSLygw7
	9oxbf24W9ng5EIGKdsWfbzaCbNj9tCbU7DzI8Z208EQ6DgH6QEvtX04aifvbxYgvXBC6
	rT/3kjyf37dZtdz0Qe7iuOgSPKnpsFv94Lal586yoM6Jodp/yHNghpjgopo6WZWPqq0V
	2iO5kb+bNFgLFVuJOgR+XQg3RdNx6dnzMk+jaBoqiCndf+CCqnjONs0zNtsi63aArUW1
	FfuZwsItBIy6DArQdocPtMWebSn+ZVw2WvHRJqFTe0vxtmye12EWo1zhPW63pAlIN+bH
	YySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=uUF1CzOIRrVfItCXb7QNbPR6UCe3KiwyhKUJBWMTiUk=;
	b=rP7MssI+2+UQZYxc3NEUt6+QLlD1vbNVzCwAZ3nwZbMsaJ6+u+KZHU1Zt11jB28VrH
	SjbPdwmvvS0CkTQJiJN8HPlFZ2humHR1kNPJZz/721K0l6XKKBFtyyWje2WhHe3/GI6b
	cMAlB1b+97lVGVCOzT5lCVP4C+Jse19nKY3LdmUEWottbCtkdAn5gHPi+uYPmVF3XbTp
	j/XrvOa8VX94BBIUlE0JQYHXsa6PpMp8iOwIlT780P16BiNenzSAitPqbA6PRke/cVgv
	Bd5hXxOpvAlYy+nVuChw1QJm0Gxnx6Mfd2LFZNA/NzcpOl7AX668wbZMx3oedQg/L2Qx
	DWnQ==
X-Gm-Message-State: APjAAAXcSRtvckjudnA1taxCFIBRjDdeAFJa0j1i/y94PieGthQehHVB
	4c1qRxxtPiYwlFb8gEni0QOdZL0U
X-Google-Smtp-Source: APXvYqwaPzQ0rff4ycjR5jbIVHDJqVlgBVGqIffLCKYQTSO5WFazSi5wZp/amPILE/YuzYHUDs/QEw==
X-Received: by 2002:a63:d306:: with SMTP id b6mr10148782pgg.195.1579968074931; 
	Sat, 25 Jan 2020 08:01:14 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:953f:6ade:6955:1d1c])
	by smtp.gmail.com with ESMTPSA id j9sm10291064pff.6.2020.01.25.08.01.14
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 25 Jan 2020 08:01:14 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sat, 25 Jan 2020 08:01:07 -0800
Message-Id: <1115a14c93dc44124c3ab95053142da78032a004.1579968003.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579968003.git.akuster808@gmail.com>
References: <cover.1579968003.git.akuster808@gmail.com>
Subject: [1.44 3/4] knotty: Be consistent when creating/updating progress bars
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 25 Jan 2020 16:01:14 -0000

From: Peter Kjellerstedt <pkj@axis.com>

When creating a new progress bar (using BBProgress), a colon was
appended to the supplied message. However, when updating the message,
no colon was appended.

Change this so that the colon is instead part of the widgets that make
up the progress bar so that it does not matter when and how the
message is updated, it always displays the same.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 08f35c04f6e1ce4c4ca5c2bef4cd8a192e12e682)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/ui/knotty.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index ddcb2148..c6abb2a1 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -35,15 +35,15 @@ class BBProgress(progressbar.ProgressBar):
         self.msg = msg
         self.extrapos = extrapos
         if not widgets:
-            widgets = [progressbar.Percentage(), ' ', progressbar.Bar(), ' ',
-            progressbar.ETA()]
-            self.extrapos = 4
+            widgets = [': ', progressbar.Percentage(), ' ', progressbar.Bar(),
+                       ' ', progressbar.ETA()]
+            self.extrapos = 5
 
         if resize_handler:
             self._resize_default = resize_handler
         else:
             self._resize_default = signal.getsignal(signal.SIGWINCH)
-        progressbar.ProgressBar.__init__(self, maxval, [self.msg + ": "] + widgets, fd=sys.stdout)
+        progressbar.ProgressBar.__init__(self, maxval, [self.msg] + widgets, fd=sys.stdout)
 
     def _handle_resize(self, signum=None, frame=None):
         progressbar.ProgressBar._handle_resize(self, signum, frame)
@@ -255,10 +255,10 @@ class TerminalFilter(object):
                 start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[' ', progressbar.BouncingSlider(), ''], extrapos=3, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[' ', progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=5, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = False
                     activetasks[t]["progressbar"] = pbar
                 tasks.append((pbar, progress, rate, start_time))
-- 
2.17.1


