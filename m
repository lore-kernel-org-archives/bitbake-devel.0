Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 2EF697710C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 16:32:12 +0000 (UTC)
Received: by payp3 with SMTP id p3so44535483pay.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=ZaKtiry02oLSY0wU5tWZ/bIUfbYT9xIwKyyZnwo+DGQ=;
	b=ELBtnJg4VT3N0KMVrQoOuAA/bkGr8nCK8F7+J5y7+tLD//0V63HCwT4f+uFWR0+2vR
	JMESowUnX0NPxBv352TxocJ+Co0RQIo7kCJhRVFW8xfxNiT0k9sSTW4MB424sjJl1UiT
	ziTynxPvOeE3+BzRmZ2lMHVryEGYrqPQUqMj6I7WKKfupWsmbUbl5LidXs9rFP61S/7S
	/BX2EXhCkOYYXsbWqn5n6896eS7w2YMYOZj4Rs0UAD2YBTjf+VpVgOwGCBbB417SI3Jo
	1F1eGJWCz4tpxCALd5A7E0YZv2sHcg6yZ/nMjhxCeCloa3ufpplydxMkTRzMsa1uOmNV
	kn0Q==
X-Received: by 10.66.101.68 with SMTP id fe4mr11159904pab.30.1444926732983;
	Thu, 15 Oct 2015 09:32:12 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ih4sm16312960pbc.28.2015.10.15.09.32.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Oct 2015 09:32:12 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 09:34:16 -0700
Message-Id: <a70f8ccce55633952052f8333f80d807b0958a99.1444926648.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <48d240461508600763a287d95ef3a94d885a5b57.1444926648.git.avery.brian@gmail.com>
References: <48d240461508600763a287d95ef3a94d885a5b57.1444926648.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444926648.git.avery.brian@gmail.com>
References: <cover.1444926648.git.avery.brian@gmail.com>
Subject: [PATCH 3/4] toaster: set TOASTER_MANAGED variable
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

Set TOASTER_MANAGED to 1 if toaster is run as a script.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index d7c5a84..cf93e9f 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -176,6 +176,8 @@ else
     TOASTER=$0
 fi
 
+[ `basename \"$0\"` = `basename \"${TOASTER}\"` ] && TOASTER_MANAGED=1
+
 BBBASEDIR=`dirname $TOASTER`/..
 
 RUNNING=0
@@ -232,7 +234,7 @@ for param in $*; do
     esac
 done
 
-if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
+if [ "$TOASTER_MANAGED" = '1' ]; then
     # We are called as standalone. We refuse to run in a build environment - we need the interactive mode for that.
     # Start just the web server, point the web browser to the interface, and start any Django services.
 
@@ -279,7 +281,6 @@ if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
             do_cleanup
         fi
     }
-    TOASTER_MANAGED=1
     export TOASTER_MANAGED=1
     if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
         echo "Failed to start the web server, stopping" 1>&2
-- 
1.9.1


