Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 1E7E760616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:37 +0000 (UTC)
Received: by padhx2 with SMTP id hx2so47137883pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=h5KBJGRSnV/hqXiGf/SL0PXfGqBN3HBY5uMQNNby8g4=;
	b=tWF2LXrf2EvZXciD583Hm+QN8BnDRRXtvgite+/cEOME2YPlkJ2itLPApdSNTX421/
	dfMdA1XK21C8Ed7fjr8QZR9N5XYiNPmdFGMlSRCv0yLH/wvYGGVR7iY5Xcf5T3PETcuz
	qpqqbEDf4rkCHw7ghLHhnFx1HhqdVkiRkTiYjKyVE2UCrzWfrU92Asg0OplI/nuEVM1x
	3S0mJal4YNHzbw57MhK921q6sVtTTwtaFCdd0eCNZY379qrYn3sTce4o2lNkqmXwdiWI
	P2eASBsJ+KISOwmgUMFo+EYfqzE3bG1J9/clSn5aJNPwAyBlKFZ6qBsCpiWeyImKSuo8
	n3hQ==
X-Received: by 10.98.72.133 with SMTP id q5mr6440006pfi.157.1449079178792;
	Wed, 02 Dec 2015 09:59:38 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:38 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:39 -0800
Message-Id: <07d5a6796f838a1996cec976e513ef4cca2e6962.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 07/30] toaster: use parent of the build dir
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:38 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Assigned TOASTER_DIR to the parent of the build directory.
This should fix local controller crash as it assumes that
TOASTER_DIR is a root of local poky and tries to clone it.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 359b23d..de03099 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -281,7 +281,7 @@ fi
 # 4) pid's we need to clean up on exit/shutdown
 # note: for future. in order to make this an arbitrary directory, we need to
 # make sure that the toaster.sqlite file doesn't default to `pwd` like it currently does.
-export TOASTER_DIR=`pwd`
+export TOASTER_DIR=`dirname $BUILDDIR`
 
 # Determine the action. If specified by arguments, fine, if not, toggle it
 if [ "$1" = 'start' ] || [ "$1" = 'stop' ]; then
-- 
1.9.1


