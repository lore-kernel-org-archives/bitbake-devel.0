Return-Path: <kergoth@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3B423602D9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Feb 2016 00:13:28 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id 128so13423391wmz.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Feb 2016 16:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jCSCsYz0dgJHLywIVVBcls8yGwy58bQU2d06rFFxpHc=;
	b=F85oQR7YM+i1PnF1BOn+appt6PF/vN3wSiVFuxoiVP4csF0GHiHRfRj/P7gN1IPXgW
	VRKj23f6Far+S0E/pk1db5TB2WQ7Ud3flPDTWTYRkwLDviy3/pp3KTEbCJwYGFQIxMsB
	T8yu2BXVX2k1K5ygIAV5CvVhZCodLd43/YGprXto6dudFtCHnbzPcmj14M883Kh+0Cng
	NDv1R5syYXL8GZgyER5MXuXvjdadnyVSx1+DSjBtf3R8Imum8x+PI7076KWWIMiDOpMP
	xksFBKP40wouG8qeuuj7n3v7tQjBIPY5dpx1PuN2SiX8PT4NIJoHflZKHKtf5LuWrGHp
	JONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jCSCsYz0dgJHLywIVVBcls8yGwy58bQU2d06rFFxpHc=;
	b=JxJJIIKHQZHsFPMGA4qGiGZcdqSHafvCe73UxhMJMpqq0pJWDOpm8ZBaXFvk8DxwqZ
	VOMlWAoGNeUnUc8p+waRXAtVAQBKUtCZ8vEdHJIJUGvSqsVXoq8qqFFnPJ8kfQYwNtDw
	zoMq0OcOAUpWAD30U9Mq0A6AReLF4oQeeLifxVPFayILi0OP6rwU7+84L8IN2o9qWP6H
	i9ngrEEeHDYzdW+uzjUiPdxqD5Sugl2aaKWS37egR0scfjuDEepDjwz52qmq9m37nH6I
	15sQG2ZnrpYTrsWCGECyUUe6f1jKe1zlvmlprt2r0NYQ8Xdyw86sLGqzbzv0wKSQHYa9
	+xeQ==
X-Gm-Message-State: AG10YOQAlIx+8MxOTygagPintCKi6KrfG5EzlHqcM4XN7MfAFuR4mSd/ow8gZP70Yqw8Tw==
X-Received: by 10.194.243.103 with SMTP id wx7mr53573141wjc.136.1455236008776; 
	Thu, 11 Feb 2016 16:13:28 -0800 (PST)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id t3sm9690310wjz.11.2016.02.11.16.13.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 11 Feb 2016 16:13:27 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Feb 2016 17:13:23 -0700
Message-Id: <8a2dddd65c84e749e1af2e2d03175dd51b4f59b0.1455235936.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <cover.1455235936.git.chris_larson@mentor.com>
References: <cover.1455235936.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [RFC PATCH 1/1] Move bb.{debug, note, ..} into their own logging domain
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
X-List-Received-Date: Fri, 12 Feb 2016 00:13:30 -0000

From: Christopher Larson <chris_larson@mentor.com>

This lets us filter and use -l to show messages from that source specifically.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/__init__.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index ac62d26..7acc0a9 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -70,6 +70,8 @@ logger = logging.getLogger("BitBake")
 logger.addHandler(NullHandler())
 logger.setLevel(logging.DEBUG - 2)
 
+mainlogger = logging.getLogger("BitBake.Main")
+
 # This has to be imported after the setLoggerClass, as the import of bb.msg
 # can result in construction of the various loggers.
 import bb.msg
@@ -79,26 +81,26 @@ sys.modules['bb.fetch'] = sys.modules['bb.fetch2']
 
 # Messaging convenience functions
 def plain(*args):
-    logger.plain(''.join(args))
+    mainlogger.plain(''.join(args))
 
 def debug(lvl, *args):
     if isinstance(lvl, basestring):
-        logger.warn("Passed invalid debug level '%s' to bb.debug", lvl)
+        mainlogger.warn("Passed invalid debug level '%s' to bb.debug", lvl)
         args = (lvl,) + args
         lvl = 1
-    logger.debug(lvl, ''.join(args))
+    mainlogger.debug(lvl, ''.join(args))
 
 def note(*args):
-    logger.info(''.join(args))
+    mainlogger.info(''.join(args))
 
 def warn(*args):
-    logger.warn(''.join(args))
+    mainlogger.warn(''.join(args))
 
 def error(*args, **kwargs):
-    logger.error(''.join(args), extra=kwargs)
+    mainlogger.error(''.join(args), extra=kwargs)
 
 def fatal(*args, **kwargs):
-    logger.critical(''.join(args), extra=kwargs)
+    mainlogger.critical(''.join(args), extra=kwargs)
     raise BBHandledException()
 
 def deprecated(func, name=None, advice=""):
-- 
2.2.1


