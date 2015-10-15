Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 19BBF7711F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 16:32:11 +0000 (UTC)
Received: by pabur7 with SMTP id ur7so9871215pab.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=n7U83GJGHzwjYxs67G3dLTUlCFASdIm25q3/i0rF+sw=;
	b=YBGn0d5QnwnpyczC6pBBDxHlpXRxjfPfApKp20ut+sPkd26xfBVDwmIakAteQmco6t
	bJUchhS+Y7TAYMkUjc/Yk+0RB43XOQ9qxrsA1ep/nX4lbahr6HeNC+h1UKJVWNoJf+u2
	tqUGLMdmD0MmXfyFi/BR1OzAaO/uW8oEbH3eepHeyZ9hg7FFeAWb4LgtjAXObNW1HDki
	Rzb3szA3w30N4wTHHhrotsrej94nhojK7wSEpOPlPAaGeg2AljedHf48Yj6GDlzSn++5
	soWAk4G9yqTsa6AtZXM6qf47xO4C6QMvRBSs1Zqsl1sJaGN9xa94VuZHZ4usZLNop4vG
	zodQ==
X-Received: by 10.68.197.97 with SMTP id it1mr11096862pbc.4.1444926732186;
	Thu, 15 Oct 2015 09:32:12 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ih4sm16312960pbc.28.2015.10.15.09.32.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Oct 2015 09:32:11 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 09:34:15 -0700
Message-Id: <3d5cfe639bb50a751ea8e546d6dc8d0d41b02e8a.1444926648.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <48d240461508600763a287d95ef3a94d885a5b57.1444926648.git.avery.brian@gmail.com>
References: <48d240461508600763a287d95ef3a94d885a5b57.1444926648.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444926648.git.avery.brian@gmail.com>
References: <cover.1444926648.git.avery.brian@gmail.com>
Subject: [PATCH 2/4] toaster: get rid of SRCFILE
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

Used TOASTER variable instead of SRCFILE as they're
essentially the same.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 75d3390..d7c5a84 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -232,9 +232,7 @@ for param in $*; do
     esac
 done
 
-[ -n "${BASH_SOURCE}" ] && SRCFILE=${BASH_SOURCE} || SRCFILE=$_
-
-if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
+if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
     # We are called as standalone. We refuse to run in a build environment - we need the interactive mode for that.
     # Start just the web server, point the web browser to the interface, and start any Django services.
 
-- 
1.9.1


