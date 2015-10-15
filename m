Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id B05677710D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 16:32:10 +0000 (UTC)
Received: by payp3 with SMTP id p3so44534818pay.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=1dlWyU1cL2Z6UAQzmn886f53eNyB4YbLX78f4/he7yA=;
	b=NTV+7QbALLVx8kWcE2B+3pCMYKM46SIxWR9C8Q+xTO/Au8Z7NJZhKBQk1rTMqIx3qh
	oK2m31n2mAIHaqb48FBd7Tv/fKEbPJPjcyfdCTCNL+K9zkl8kOsc6cW/lWnNiQOoJwnt
	IQjBw+8k+tc5vKTn0SjmdOJKavumNhRqE1cL9JkSMuc6FlqKGd9/uJfCC3OiQMpsRTuU
	UjtuLeZJL+WO8qxmoK83khibFaqtqilOKD5l1UjEVqycY5B9zD6lUgqpWPOLcqxguS02
	YNuK4PNqy3YnoyHlT1dvJhXKKM+61IePdmObfTpGDwYtSGFLGkxMyG0l7YwbxBB9GRVG
	leLA==
X-Received: by 10.68.240.2 with SMTP id vw2mr10905758pbc.41.1444926731201;
	Thu, 15 Oct 2015 09:32:11 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ih4sm16312960pbc.28.2015.10.15.09.32.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Oct 2015 09:32:10 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 09:34:14 -0700
Message-Id: <48d240461508600763a287d95ef3a94d885a5b57.1444926648.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1444926648.git.avery.brian@gmail.com>
References: <cover.1444926648.git.avery.brian@gmail.com>
Subject: [PATCH 1/4] toaster: use path to the script to guess config path
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
X-List-Received-Date: Thu, 15 Oct 2015 16:32:12 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used $TOASTER variable(path to the toaster script) instead of
current directory name to get path to the toasterconf.json

This way script should work in both modes and it doesn't depend
on the current directory.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index e976604..75d3390 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -194,11 +194,11 @@ fi
 # in the local layers that currently prevent using an arbitrary
 # toasterconf.json
 if [ "$TOASTER_CONF" = "" ]; then
-    BIN_DIR=$(dirname -- "$0")
-    export TOASTER_CONF="$BIN_DIR/../../meta-yocto/conf/toasterconf.json"
+    TOASTER_CONF="$(dirname $TOASTER)/../../meta-yocto/conf/toasterconf.json"
+    export TOASTER_CONF=$(python -c "import os; print os.path.realpath('$TOASTER_CONF')")
 fi
 if [ ! -f $TOASTER_CONF ]; then
-    echo "$TOASTER_CONF configuration file not found, exiting..."
+    echo "$TOASTER_CONF configuration file not found. set TOASTER_CONF to specify a path"
     exit 1;
 fi
 # this defines the dir toaster will use for
-- 
1.9.1


