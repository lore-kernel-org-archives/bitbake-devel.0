Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id ACCDF60616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:33 +0000 (UTC)
Received: by pfnn128 with SMTP id n128so1137671pfn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=SxUPrCBfH2GIl57RaAHKWI7coOecWHC43ZXHsMN9lJ4=;
	b=HFAxna+n9qQvWyTU8sbYHVP41fbnnTCQQWncm3GxSy1t2YYxEWm6rkBeVbzRJxOXxR
	VldK+R1iIGDR6+mGuJDcCIooeJVja97cIU/Ew+yJVozc15GPiA++dnjTqud08nks/fPQ
	+4Bo4Lyx3Cx8w3fW+WupKhRnmCT49wlDiWeMfyGp4a7s0KjfBqNo+2c0PSaXDkNlRCgh
	Ax4T8rwtxjp2VCZnM9eowww5wVx4ze2n/o795aaCc8Cy+tPJn6/mO7YHR9TztCi4SOeN
	p61JZgYkgEdB9MeaG5cBUK5phR/jaennItHqzUmNpefkxvA+i+z3e45T3ircxAFvsWpY
	zOMg==
X-Received: by 10.98.2.18 with SMTP id 18mr6511799pfc.5.1449079174223;
	Wed, 02 Dec 2015 09:59:34 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:33 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:35 -0800
Message-Id: <16173b5294bbf0e4b09ed1eb7e6ffbfe81e002d4.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 03/30] toaster: set DATABASE_URL in toaster script
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:34 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Set environment variable DATABASE_URL in bitbake/bit/toaster
Variable value is obtained by running 'manage.py get-dburl'

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/toaster b/bin/toaster
index 7b510fc..118c305 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -316,6 +316,7 @@ case $CMD in
             echo "Bitbake server start failed"
         else
             export BBSERVER=0.0.0.0:-1
+            export DATABASE_URL=`$BBBASEDIR/lib/toaster/manage.py get-dburl`
             if [ $NOTOASTERUI -eq 0 ]; then        # we start the TOASTERUI only if not inhibited
                 bitbake --observe-only -u toasterui >>${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
             fi
-- 
1.9.1


