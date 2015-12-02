Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 1DEFB60616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:34 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47003890pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=L1L2zKi7PcAwbNJaIVsOjvrORGTmvghlFxPM8PhzvB0=;
	b=cNuXI/huaI5FGGusTudHFVvg3fpR2TpJjrdSLxKoX/9KPDGQ8mFH3ZvrS5fmJwCAI1
	+HWiPmHVO7K0wzZTphEvWVJmVj89fpGtbSIENiZfNdH6yhFwsP7vAHJ6Mx76LyIdEFer
	i0VLvkWbwxmQL511D7byb3jFhmcLuLKJ2dlg8ryQgIzjUghCJfCuUrgC5xX2Tyv9Z0us
	pVAlZCRPbrmbiXP8kolphVklk7cTt59uwoKiWhsKiOsWrUt+LdrHfHr/lgyWoASqGnmZ
	ZGKF+o9Ay2gUviMZZULbZTuV+PM9RoAWkYUjR1nLW+7RwedL7gvWqYx2CNpYencsslXz
	h03w==
X-Received: by 10.98.13.156 with SMTP id 28mr6472006pfn.106.1449079175433;
	Wed, 02 Dec 2015 09:59:35 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:34 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:36 -0800
Message-Id: <23906d684d651902c9872bbbcb8e67146d348897.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 04/30] toaster: run bitbake the same way
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:35 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Run bitbake in toaster script the same way as it's run
by localbuildcontroller.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 118c305..abc8737 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -301,16 +301,13 @@ case $CMD in
     start )
         start_success=1
         addtoConfiguration toaster.conf "INHERIT+=\"toaster buildhistory\"" $TOASTER_BRBE
+        echo > ${BUILDDIR}/conf/toaster-pre.conf
         if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
             return 4
         fi
         unset BBSERVER
-        PREREAD=""
-        if [ -e ${BUILDDIR}/conf/toaster-pre.conf ]; then
-            rm ${BUILDDIR}/conf/toaster-pre.conf
-        fi
-        bitbake $PREREAD --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
+        bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
         if [ $? -ne 0 ]; then
             start_success=0
             echo "Bitbake server start failed"
@@ -318,7 +315,8 @@ case $CMD in
             export BBSERVER=0.0.0.0:-1
             export DATABASE_URL=`$BBBASEDIR/lib/toaster/manage.py get-dburl`
             if [ $NOTOASTERUI -eq 0 ]; then        # we start the TOASTERUI only if not inhibited
-                bitbake --observe-only -u toasterui >>${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
+                bitbake --observe-only -u toasterui --remote-server=$BBSERVER -t xmlrpc >>${BUILDDIR}/toaster_ui.log 2>&1 \
+                    & echo $! >${BUILDDIR}/.toasterui.pid
             fi
         fi
         if [ $start_success -eq 1 ]; then
-- 
1.9.1


