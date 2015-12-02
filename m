Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 680C96FFE5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 18:00:01 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47013855pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 10:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=2TXmlEgsOm3tyG7WwvCW1YSRu1jYj2Kqgz7HdeQmdLI=;
	b=EHQ0g84tete4W/iS8wnlPvG8oEvNfnvdbb6XPGKxZZdoGy7knnzgmU5piO3irFQazd
	pnRnWSjIymueWri+rl5Pr+xhYiA6De0J8tBd4UMpIws/RmHjKyHmqXsve/X8F2Kpk1Th
	fFO+RkAs/yQ88TiEI2hPB9S2mYK34u9MlIDJDayWDF294oCemGlKfLyMArm/DX0b786j
	u8JFlzkdTlNdxEdYxuiv8HuGow4l/gYn4gBwS9nWi6DEkLNkQV9N2hJMHJzRSZuj6jud
	nuepGAnlemVpyOc3hzGwbTZVHe9KjlbkqqqxHjUe9MJ1oJ1zTH0c/X2gI9yh/H7trP8K
	c1Rg==
X-Received: by 10.98.15.67 with SMTP id x64mr6564013pfi.67.1449079202244;
	Wed, 02 Dec 2015 10:00:02 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.10.00.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 10:00:01 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:59 -0800
Message-Id: <635650d44b62e888c63514789588abc31cdb77cc.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 27/30] toaster: unset environment variables
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
X-List-Received-Date: Wed, 02 Dec 2015 18:00:01 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Toaster script sets environment variables when it starts.
It makes sense to unset them when toaster stops as they can
cause other programs to behave incorrectly.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/toaster b/bin/toaster
index 3b5b7f8..6d1ec05 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -128,6 +128,10 @@ stop_system()
     fi
     stop_bitbake
     webserverKillAll
+    # unset exported variables
+    unset DATABASE_URL
+    unset TOASTER_CONF
+    unset TOASTER_DIR
     trap - SIGHUP
     #trap - SIGCHLD
     INSTOPSYSTEM=0
-- 
1.9.1


