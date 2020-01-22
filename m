Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
	[209.85.215.175])
	by mail.openembedded.org (Postfix) with ESMTP id 465427FE24
	for <bitbake-devel@openembedded.org>;
	Wed, 22 Jan 2020 05:25:08 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id z124so2795569pgb.13
	for <bitbake-devel@openembedded.org>;
	Tue, 21 Jan 2020 21:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=uUF1CzOIRrVfItCXb7QNbPR6UCe3KiwyhKUJBWMTiUk=;
	b=O5l3P8/XFZttON4s5KF5h9hViRkSYLFIbrIjPA91534E28tWYdFa1LJG0r2x+KIbFC
	xg+sTAeCv23XGRDPAPs7eLub4DrsNYByqig10WS620yeiEaGIXIXZQ8MY8zb5V9T7OMr
	mHaxZHlq3R2Vdj7UL+6EB/NyoSFxJgZ9IAIprfQ3DbuKpAs3IcVxR3hWRVImNn1PYZiZ
	70wA80dcXXakCSIIuZvfzLI/3p4CGfTfgTjLT6joBAiwbiBu3ACitgNHWDNRujWeDQ8v
	vWQyBchPVwUQ376FAUrIl1PvyO6KlAApGJrvtoPelwGo2dWSE86Wld2h7uW26YgRZuBc
	UiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=uUF1CzOIRrVfItCXb7QNbPR6UCe3KiwyhKUJBWMTiUk=;
	b=njRlMmgnjkKmgBz6jCI6dWy/RYfKiw5+uEmxyMpmOgxDuLAV8NfTkTj/7cRBI6GO2d
	znmV9lMOWDPS6BWVLRCFCe/dv6S6hZdGNE5PIEjD37YLCl/sPNqsWf+IOECozYuxs3fY
	aQ9DmA9jznSq8CXJq543ErxCMRSqBq167s/nZBYys23LQA7XKBKMaI5S6s6rFoUO8QVs
	0vB/+i5xmLhqUBiVnhtogX8QOJo0/KVKleHblsQdi7Yzcl8qsEEk/yM82K9s9V8laXtg
	C7RrSw4oL0uwQTHA+o6q1bhJ5bW07rGdnKhSqesQ/ObkyT+SDnA7/tNA8yR8IivulTul
	dKsA==
X-Gm-Message-State: APjAAAVNyl4VfsleM2/P6BzEEiyNYzp+OrkHtdxme+dac7zcYpafJpXP
	gxgQE8WspfeAk6HZoc03494oTnrS
X-Google-Smtp-Source: APXvYqwZsW6mHYF7SuhxAQ2VTDguafwgrCoc5AsOEe0TTdDUparyCU49AhxL2EBRnZ9iGLk5bSJnMA==
X-Received: by 2002:a63:4282:: with SMTP id p124mr8907276pga.155.1579670709158;
	Tue, 21 Jan 2020 21:25:09 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:682c:76b9:6d8a:bbd2])
	by smtp.gmail.com with ESMTPSA id o7sm1228628pjs.28.2020.01.21.21.25.08
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 21 Jan 2020 21:25:08 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Tue, 21 Jan 2020 21:25:01 -0800
Message-Id: <1115a14c93dc44124c3ab95053142da78032a004.1579670574.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579670574.git.akuster808@gmail.com>
References: <cover.1579670574.git.akuster808@gmail.com>
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
X-List-Received-Date: Wed, 22 Jan 2020 05:25:08 -0000

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


