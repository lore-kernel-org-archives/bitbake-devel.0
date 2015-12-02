Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 6499460616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:36 +0000 (UTC)
Received: by padhx2 with SMTP id hx2so47137470pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=OibQF2bPDMmWDq2AsszzUC8fuDiX1mgN24MD9LLN6c4=;
	b=S0T7y4MszI6yUfLZtSUsnRoRInJ2j2gTuN2QLoAl1fk2eedDNvwqbTmvYnhB1767L2
	vhrssQHrLpZltyBcSJV2CxoBd43ZnvLDiAjO0XeyI6xa1OTMOU/rrCIGKqwaU6b/2Vxf
	IlmhH9kUS34bz4S696IX8n9hc0i2X/i2P3EsWJbvYiw5V0vp708I2hgFQ6d9s5+XWRnj
	d5mH/8UZfyaXxwUegaExbBkCrX6TWm6aRbZjSQHFCCOn+5SFHRgXMfdMeNuQwaKxLGZ4
	4S5kNKjPXyRriU0L2Vn4boCB9JyVVzLoeXtbSUBbWjEc/BBap+WTkSqsw5qvuG7GshCE
	FsLA==
X-Received: by 10.98.75.142 with SMTP id d14mr6494388pfj.91.1449079177820;
	Wed, 02 Dec 2015 09:59:37 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:37 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:38 -0800
Message-Id: <c629aac9710867df1d2db0a58c7210e0d452d59c.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 06/30] toaster: check for toaster configuration later
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:37 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Moved check for toasterconf.json after check of build environment.
We'll need some variables from build environment to find toasterconf.json
better way.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 1ce4af7..359b23d 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -222,7 +222,6 @@ fi
 # make sure that the toaster.sqlite file doesn't default to `pwd` like it currently does.
 export TOASTER_DIR=`pwd`
 
-
 NOBROWSER=0
 
 for param in $*; do
@@ -260,6 +259,30 @@ if [ -z "$BUILDDIR" ] ||  ! which bitbake >/dev/null 2>&1 ; then
     return 2
 fi
 
+# this is the configuraton file we are using for toaster
+# note default is assuming yocto. Override this if you are
+# running in a pure OE environment and use the toasterconf.json
+# in meta/conf/toasterconf.json
+# note: for future there are a number of relative path assumptions
+# in the local layers that currently prevent using an arbitrary
+# toasterconf.json
+if [ "$TOASTER_CONF" = "" ]; then
+    TOASTER_CONF="$(dirname $TOASTER)/../../meta-yocto/conf/toasterconf.json"
+    export TOASTER_CONF=$(python -c "import os; print os.path.realpath('$TOASTER_CONF')")
+fi
+if [ ! -f $TOASTER_CONF ]; then
+    echo "$TOASTER_CONF configuration file not found. set TOASTER_CONF to specify a path"
+    return 1
+fi
+# this defines the dir toaster will use for
+# 1) clones of layers (in _toaster_clones )
+# 2) the build dir (in build)
+# 3) the sqlite db if that is being used.
+# 4) pid's we need to clean up on exit/shutdown
+# note: for future. in order to make this an arbitrary directory, we need to
+# make sure that the toaster.sqlite file doesn't default to `pwd` like it currently does.
+export TOASTER_DIR=`pwd`
+
 # Determine the action. If specified by arguments, fine, if not, toggle it
 if [ "$1" = 'start' ] || [ "$1" = 'stop' ]; then
     CMD="$1"
-- 
1.9.1


