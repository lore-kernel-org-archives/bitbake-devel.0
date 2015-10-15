Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id CEBA97710C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 16:32:13 +0000 (UTC)
Received: by payp3 with SMTP id p3so44535735pay.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=dGED+S9ZM71it00Z7kcbV2Oo5gSs2Jt7XtIoElBNFfg=;
	b=FZZ4iRV6CUURH8BwiNnwSC/WdciXlD6RuIkk/e0asrA1rHyGMGS6a5PwB8nITkPoVn
	TkMGdH5ndCIiZtD8TKT1eUQDLWhkfRaAh7NMU8b43R8QVx/xOEXDF8TgrhHdvCnJ+wny
	1O4Afw0meyZI+5YmzHiaGHwzIYnzjmBJDd38JAHNdFKBOo8ZVke4ZDONxAslnepKB+Gb
	iIbBQGfH/HTCXK80J39lHFsh3HH4TVws4lFND5HNhoG/h6K5C4zyO2ybr9jJ5+VUPAZy
	JhBRPOgX1/40fe5KgvjK1Qpr47iN7E/2DIWerIDO2CcCy6Ew46OLSk+7vti0bNpnI4nh
	oKWw==
X-Received: by 10.66.163.228 with SMTP id yl4mr10990279pab.112.1444926733740; 
	Thu, 15 Oct 2015 09:32:13 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ih4sm16312960pbc.28.2015.10.15.09.32.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Oct 2015 09:32:13 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 09:34:17 -0700
Message-Id: <44fc582143892ef2dddd37c2bd72948f41be82e3.1444926648.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <48d240461508600763a287d95ef3a94d885a5b57.1444926648.git.avery.brian@gmail.com>
References: <48d240461508600763a287d95ef3a94d885a5b57.1444926648.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444926648.git.avery.brian@gmail.com>
References: <cover.1444926648.git.avery.brian@gmail.com>
Subject: [PATCH 4/4] toaster: exit or return depending on the mode
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
X-List-Received-Date: Thu, 15 Oct 2015 16:32:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

When toaster script is sourced 'return' should be used as
using 'exit' will cause script to exit the shell and close terminal
window. If script is called 'exit' should be used. Otherwise shell
will throw and error:
  return: can only `return' from a function or sourced script

Used 'return' or 'exit' depending on the toaster mode using
TOASTER_MANAGED variable.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index cf93e9f..2c3432c 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -201,7 +201,7 @@ if [ "$TOASTER_CONF" = "" ]; then
 fi
 if [ ! -f $TOASTER_CONF ]; then
     echo "$TOASTER_CONF configuration file not found. set TOASTER_CONF to specify a path"
-    exit 1;
+    [ "$TOASTER_MANAGED" = '1' ] && exit 1 || return 1
 fi
 # this defines the dir toaster will use for
 # 1) clones of layers (in _toaster_clones )
-- 
1.9.1


