Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 25ABE60667
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:42 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48539566pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=evtlqJycMGVhN9rsED+F4N9fZndz8JUV2LyzUbSMvUk=;
	b=U6NdnrTBflWoWM+R88tcPE/ypr+bNeUcw2OVIvaQA9/5N/ei8k4O4aeizk3xEsC0Tb
	RDGKBap/mvXpPYjRp83hEHi5LNM4c3t/bmgO6NS0SbLljSIltEFfk8j0DGlc/RHUIHmr
	7W5DwqTbPVMtleMJpCxCoBxempiKOfJo88lWZvjm5OB1hOaH+isNaVOgDuGsENbFeQ6W
	yht8fQkV77MxrThHez+uIZGGMjFLjW157SAkMaFkiUOY6+zFotbgnG7OjfbHf6VJhI9F
	TbQV108470j1JyQfWDZ74zu6udrnlyzbASw75hdfl6cNttWOIqIt5iEdOB1oDwJXiVdp
	0Yxw==
X-Received: by 10.66.234.133 with SMTP id ue5mr6639889pac.56.1449079183218;
	Wed, 02 Dec 2015 09:59:43 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:42 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:43 -0800
Message-Id: <c0a56705eba386da6ddff4562a96affb67909af7.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 11/30] toaster: implement stop_bitbake function
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:42 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Separated functionality of stopping bitbake server and observer
processes.

This functionality will be used by build controllers to restart
bitbake processes.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index eb83e9a..e82df9b 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -126,16 +126,20 @@ stop_system()
         kill `cat ${BUILDDIR}/.toasterui.pid` 2>/dev/null
         rm ${BUILDDIR}/.toasterui.pid
     fi
-    BBSERVER=0.0.0.0:-1 bitbake -m
-    unset BBSERVER
+    stop_bitbake
     webserverKillAll
-    # force stop any misbehaving bitbake server
-    lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
     trap - SIGHUP
     #trap - SIGCHLD
     INSTOPSYSTEM=0
 }
 
+stop_bitbake() {
+    BBSERVER=0.0.0.0:-1 bitbake -m
+    unset BBSERVER
+    # force stop any misbehaving bitbake server
+    lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
+}
+
 check_pidbyfile() {
     [ -e $1 ] && kill -0 `cat $1` 2>/dev/null
 }
-- 
1.9.1


