Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id A8A246FFD2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:58 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47012771pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=gf1q2V/k9sE88MK3bT+FbExOqs/ffTxxHFr+dmI0sQg=;
	b=Fv+5rOB+UAStNnMUZLhafbuqeUQn2q86zDw0XABKTmREqWwnhoZThEGbQjd0EkI5l/
	px9ob/UkyWOJSs4pxRsM9NxQ4BTcl4rNcLi0XAIZ67lSzW5QN2YMGrzEq9nQxoWwDNkt
	qo1T4bih0jB1g/3txpXk0EBpJBUFpIlWY38u3CCU7ZJNn45y8ZPUVOwBtzVn6kBn2Z1u
	uXT5t+v81N4zwzglNYf/5yyeXGxFSFLKZV6wsan33gWL5PlDroPaXq9lCR963TpLqXli
	TsF5SJXkfmSgpMN4A4FwksDATH4VSfI+yC0VD886omZPX53xcdw9S5qM1Bce+4xIOMxQ
	2Yhg==
X-Received: by 10.98.14.15 with SMTP id w15mr6464001pfi.145.1449079199415;
	Wed, 02 Dec 2015 09:59:59 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:58 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:56 -0800
Message-Id: <a4d0ecda2f5af8d684a7c83465de6b188f0110f9.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 24/30] toaster: stop using toaster-pre.conf
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:59 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This file is not needed anymore as toaster UI doesn't
write variables to it. It sets them directly on bitbake
server.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index c89e015..3b5b7f8 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -135,7 +135,7 @@ stop_system()
 
 start_bitbake() {
     unset BBSERVER
-    bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
+    bitbake --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
     if [ $? -ne 0 ]; then
         echo "Bitbake server start failed"
         return 1
@@ -350,7 +350,6 @@ fi
 case $CMD in
     start )
         addtoConfiguration toaster.conf "INHERIT+=\"toaster buildhistory\"" $TOASTER_BRBE
-        echo > ${BUILDDIR}/conf/toaster-pre.conf
         if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
             return 4
-- 
1.9.1


