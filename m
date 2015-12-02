Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 7094560616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:49 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47009420pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=q4JnBjp7JzWlD2xjdAg2OP0rlNKQ0fFmYq8KeSNak+I=;
	b=u71geWLvgvoN7UyZZItVjacfqWkPrg6/z216IwxAnQXwY0tZ9bdlCMtZ9gaeA6N6lC
	wkdRaQ4eyEeDy4UfBF/rsfJuYuH9B6s0RrGUfhAXw2/mxFI1BKmQzeV54qUMKD/x5jc5
	8TPj0MPap547YdaIxj0NyvMCIJ0cBquvkP1f32I/Te6bNx4OdBuwvEA/bzCXpxO4YmOm
	h1NHc5qTSwRre86F7nmpqmvhQFB9NmQHcHDSO+fy8QtKxWtBhRYt75o+75eroibqF2mY
	Xp9/SCDMchAFdMY7Ly8OmbdluSVINEmQFdgz5OIC2K2GiMu3jizP1LVCeTDSIxxaQRdo
	2bAQ==
X-Received: by 10.98.65.2 with SMTP id o2mr6480523pfa.99.1449079190517;
	Wed, 02 Dec 2015 09:59:50 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:49 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:49 -0800
Message-Id: <b83f9481e2f91471541c326dc4406b4ee4317b8f.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 17/30] toaster: do not terminate bb server
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:49 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Toaster needs bb server to be running all the time due
to merged analysis and managed modes. Server gets restarted
before every build triggered by UI, but it shouldn't be
terminated as it will influence command line builds.

[YOCTO #8279]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/toasterui.py | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index cdfe7ae..435cc2b 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -330,15 +330,11 @@ def main(server, eventHandler, params):
                 logger.info("ToasterUI build done 1, brbe: %s", buildinfohelper.brbe )
 
                 # we start a new build info
-                if buildinfohelper.brbe is not None:
-                    logger.debug("ToasterUI under BuildEnvironment management - exiting after the build")
-                    server.terminateServer()
-                else:
-                    logger.debug("ToasterUI prepared for new build")
-                    errors = 0
-                    warnings = 0
-                    taskfailures = []
-                    buildinfohelper = BuildInfoHelper(server, build_history_enabled)
+                logger.debug("ToasterUI prepared for new build")
+                errors = 0
+                warnings = 0
+                taskfailures = []
+                buildinfohelper = BuildInfoHelper(server, build_history_enabled)
 
                 logger.info("ToasterUI build done 2")
                 continue
-- 
1.9.1


