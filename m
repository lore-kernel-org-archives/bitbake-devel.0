Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
	[209.85.215.177])
	by mail.openembedded.org (Postfix) with ESMTP id 2F9FA6AA18
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2014 13:13:22 +0000 (UTC)
Received: by mail-ea0-f177.google.com with SMTP id n15so1748775ead.22
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2014 05:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=8/vruSYoTFLKgMpWsk5Emc0FQ5DMcQvERYLFrhJZHJw=;
	b=pARqgIE/HHuHw+fMP8A4jyNIm3QziEtC8gJi0mSQfrJqI6t8r+A6FGIsgrJ3UDGmAe
	fAUXToiaGotuXUnU2KfJlVVz4o0XVpsjUvxY1O8EOburH65gByovQz9eGQIRxWF0FPp9
	HZFIpC+4lf15qqW2bSYfI26hutMvBt+HN0wNryVY1uK2QgUWOi8JglmLxtoBNF66F5tE
	BvNYs8BIUW9JSm1J1x7WVAWa0jEGLCue1tYohOQ7qr7d8asLD+I2Ba20LffESlFN5TON
	6un+cexjYtbw/nzIr4Jw010WScxTdQniStOFOAldEszlodvyJNWTmzCSSDsmV6U3/LSc
	fpdw==
X-Received: by 10.15.86.75 with SMTP id h51mr2445789eez.44.1389964402306;
	Fri, 17 Jan 2014 05:13:22 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id w4sm26782437eef.20.2014.01.17.05.13.21
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 Jan 2014 05:13:21 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2014 14:13:43 +0100
Message-Id: <1389964423-6092-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.5.2
Subject: [PATCH] SignatureGenerator: Add empty implementation for dump_sigs
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
X-List-Received-Date: Fri, 17 Jan 2014 13:13:23 -0000

* bitbake -S throws exception when 'noop' signature handler is used

[YOCTO #5738]

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/siggen.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index bc96fd3..9796c31 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -57,6 +57,8 @@ class SignatureGenerator(object):
     def invalidate_task(self, task, d, fn):
         bb.build.del_stamp(task, d, fn)
 
+    def dump_sigs(self, dataCache):
+        return
 
 class SignatureGeneratorBasic(SignatureGenerator):
     """
-- 
1.8.5.2


