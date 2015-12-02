Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 6F3AB60667
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:40 +0000 (UTC)
Received: by padhx2 with SMTP id hx2so47138698pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=KvNOXYf0gEvkLCtp4quSQ/flijGlTU+nsCMTaYDZDhc=;
	b=BvmYLyoQe+eReUiTnq89NmAFJlRq4gQamJOZRxQEstHy6845Y/FYU3Dsr15f6Y9x1Y
	g+1K141MLqCiTegyzWLoiS7mWKXiSO6ipKqhhX3/kLnfJD9QYWlJ5CWVJiBwb4HS+ttO
	rM3EABqPzsJrIr1IWWXDNWIAXq9Q9eUmqJvTLs1raN3wWyOYdBd2trEDpChVg6pt39DN
	6XUgPR9iS0oDikAU0hpOCXSDBhrIZ4h7Ddo1g5AEKyUndqQxbz3g3py8kTjyT7hdiHEG
	I/Fh2iIUhNfdw/yy7svVf0Z3ZakpaAJrK1bGOH1tZVanIZ0KKTZU/EuIkDX7pYQa79CR
	V3rQ==
X-Received: by 10.98.68.201 with SMTP id m70mr6522071pfi.101.1449079181121;
	Wed, 02 Dec 2015 09:59:41 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:40 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:41 -0800
Message-Id: <97a51ee9b57143201eada4eeb48c24344f332733.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 09/30] toaster: start 'manage.py runbuilds' in the script
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:40 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Running runbuilds machinery in background allows Toaster to
start builds initiated by toaster UI.

Added runbuilds pid file to the list in webserverKillAll to
kill runbuilds the same way as runserver process.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index de03099..eb83e9a 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -31,7 +31,7 @@
 webserverKillAll()
 {
     local pidfile
-    for pidfile in ${BUILDDIR}/.toastermain.pid; do
+    for pidfile in ${BUILDDIR}/.toastermain.pid ${BUILDDIR}/.runbuilds.pid; do
         if [ -f ${pidfile} ]; then
             pid=`cat ${pidfile}`
             while kill -0 $pid 2>/dev/null; do
@@ -339,6 +339,7 @@ case $CMD in
                 bitbake --observe-only -u toasterui --remote-server=$BBSERVER -t xmlrpc >>${BUILDDIR}/toaster_ui.log 2>&1 \
                     & echo $! >${BUILDDIR}/.toasterui.pid
             fi
+            python $BBBASEDIR/lib/toaster/manage.py runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
         fi
         if [ $start_success -eq 1 ]; then
             # set fail safe stop system on terminal exit
-- 
1.9.1


