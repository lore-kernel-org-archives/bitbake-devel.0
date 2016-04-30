Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
	[209.85.220.66])
	by mail.openembedded.org (Postfix) with ESMTP id D6FF976639
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:43:59 +0000 (UTC)
Received: by mail-pa0-f66.google.com with SMTP id zy2so18065626pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=XbJdcqayMlXxBaO/BsscgZUAMq6+5ji+pZj2cTra4uo=;
	b=nJRnE3X4dwn3CRvkwcd93PtANzkUg39XBNFctSpWJdjUkIt0GlBY4TcbmpudGabJ8A
	Gw13D58W0zq9qoewbqz/HahepnSJfDUKWM5UH/7QajLBgjkvjMHAc0GbAKsgsO14h4ns
	1TzE2PnGmIU7uKMtiBIdCC46qynYPluUD+bdEWg/a5OCCuUc9lLeNBMTpHS2Y5mrVRSk
	IuJiKm203i8Gu4x5ei6y1rkrXU9pyxj0pudiHzgb5AF8uWXJG+VJPyEULLbFAPjzhfPw
	FGGSIyXsw0fTc4ZmIbZjugf5jcKkth1PzGPiCsavk3VzKOxdFawAqSKGiApH3NOOrBM2
	vioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=XbJdcqayMlXxBaO/BsscgZUAMq6+5ji+pZj2cTra4uo=;
	b=XcRXI0bjXIeRYAKtvKdnTsOwsUkvPVDyrD3+wp/5cNkWBlpx6kCGcBN8Dh3RGcZzuh
	Qsir7YK0lTRnEGwQU3RNkVU+SQ3ujn+2YZ0u+4QlIjEGb8GU/NZGkj7Rh9fvrNe2a2n3
	jHDaAT1vXsE+bo8ftQs5muQx/JaCpk2q6begx9htT9mad7oRtB4wg2b5pEnyr0QpyCfy
	m8q1cVurrs5h11uneAiT+P34VUXIZRubGAiETuEYEdVL4wBg3EBErLrlPK42KMECUjvH
	lbKbzNfNRtn2wdvQG1IHv/2cqNlCf50tPcWJlMxoPXuVRFTBS7Ctpuz3uIZEBN8rbSqh
	m2zQ==
X-Gm-Message-State: AOPr4FUbUGitXIkpGZUxU0XZ1eYj4e7t9jjxkMPDM8sFocKeVSvQqnETcyeFSj0+ARdNNA==
X-Received: by 10.66.21.102 with SMTP id u6mr35882606pae.118.1462045440924;
	Sat, 30 Apr 2016 12:44:00 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	fh14sm33540798pab.31.2016.04.30.12.43.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:43:59 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:43:53 -0700
Message-Id: <28c2239c94f8b15270a33bdce8009855542b676f.1462040900.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <fec58af5443888769f2737837bb8b307d7a7c32f.1462040900.git.chris_larson@mentor.com>
References: <fec58af5443888769f2737837bb8b307d7a7c32f.1462040900.git.chris_larson@mentor.com>
In-Reply-To: <cover.1462040900.git.chris_larson@mentor.com>
References: <cover.1462040900.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH 2/3] bb.event: handle __builtins__ as a module
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
X-List-Received-Date: Sat, 30 Apr 2016 19:44:00 -0000

From: Christopher Larson <chris_larson@mentor.com>

Fixes pypy support.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/event.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 5ffe89e..5a03a31 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -72,11 +72,16 @@ _catchall_handlers = {}
 _eventfilter = None
 _uiready = False
 
+if hasattr(__builtins__, '__setitem__'):
+    builtins = __builtins__
+else:
+    builtins = __builtins__.__dict__
+
 def execute_handler(name, handler, event, d):
     event.data = d
     addedd = False
-    if 'd' not in __builtins__:
-        __builtins__['d'] = d
+    if 'd' not in builtins:
+        builtins['d'] = d
         addedd = True
     try:
         ret = handler(event)
@@ -94,7 +99,7 @@ def execute_handler(name, handler, event, d):
     finally:
         del event.data
         if addedd:
-            del __builtins__['d']
+            del builtins['d']
 
 def fire_class_handlers(event, d):
     if isinstance(event, logging.LogRecord):
-- 
2.8.0


