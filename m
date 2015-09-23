Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 5891A76FD0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 22:33:30 +0000 (UTC)
Received: by pacgz1 with SMTP id gz1so2770185pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kbHZ+gdgf+HwVvglpfMXv6PnrxlrAAwF8pzLzc+5Yq8=;
	b=Oe5I5L2Tpp/E+Us76HXJh/4hL8cCqsBi0GLbef4Br8ptAUL9lSpbLWMkAjIbYSTqYv
	XkNIGevFjM/8oU/r9qRliVPaHytPWQ4OayT3hBqpKO97HbVyMJfs/JlqOyMQggegVO7G
	jndTyn+KssIH+49pk7q4BSQddkoZk7tgAPecQPtWfcVFxiWZQ/S7TWtLiqutCJf7pSIp
	dnm1YlfV3BfO/NUvZ/0iriMDZaG7LXU38hzZ7QTAGCOJ6gaQe0cxVafSIC0TYKHl7lns
	+Z4JPOPllcoO/uBUPTY3A+2/+yoot+x+meDNhbhN6JqdRN1yvwf+MaLMathXWkIdTDPa
	5OVg==
X-Received: by 10.66.251.35 with SMTP id zh3mr32173616pac.121.1443047610401;
	Wed, 23 Sep 2015 15:33:30 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	qg2sm9796764pbb.80.2015.09.23.15.33.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Sep 2015 15:33:29 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:34:53 -0700
Message-Id: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1443047547.git.avery.brian@gmail.com>
References: <cover.1443047547.git.avery.brian@gmail.com>
Subject: [PATCH 1/6] toaster: don't use --single-branch when cloning
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
X-List-Received-Date: Wed, 23 Sep 2015 22:33:32 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

git clone --single-branch works only with ref names. It fails if
commit sha1 is set in layer configuration with this error:
fatal: Remote branch <commit sha1> not found in upstream origin

Cloning repository without using --single-branch should work for
refs and commit sha1.

[YOCTO #7505]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index a9909b8..3d2f8b0 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -260,8 +260,8 @@ class LocalhostBEController(BuildEnvironmentController):
                     self._shellcmd("git remote remove origin", localdirname)
                     self._shellcmd("git remote add origin \"%s\"" % giturl, localdirname)
                 else:
-                    logger.debug("localhostbecontroller: cloning %s:%s in %s" % (giturl, commit, localdirname))
-                    self._shellcmd("git clone \"%s\" --single-branch --branch \"%s\" \"%s\"" % (giturl, commit, localdirname))
+                    logger.debug("localhostbecontroller: cloning %s in %s" % (giturl, localdirname))
+                    self._shellcmd('git clone "%s" "%s"' % (giturl, localdirname))
 
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
-- 
1.9.1


