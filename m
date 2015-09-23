Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 6C69776AC5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 22:33:32 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so52467866pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Y8GIzGknBERTEqstVSmcQshUYPQcLGEjrFdSJqwDBpU=;
	b=KdvCoU6ID1oZqCuVI5ItfxteDQaRasDUFAHWW9qsxucyp4wyjRZYsFIq4ho4nEcAWm
	MPWOEPYic9HrjUxz0omcw/+LNJXDVMO0JSgdM8Qaemqmw2aR8XqFgsWs08j3XFiBDw2T
	ZPDIc9J9125XudNGnECe4uC/QdFhaYoRC+wTCuBnF7xoRwiznAqKlLIhCeuWbjIrIqAm
	77aAjAZlYdjYIcJD2Nk0u7dqMlbnemZ/MByrCF4+ed5Fe1saj+vVMa07MgiYeSN4tf25
	RCKM4Q9py+fdJFbRXKvrS7t7km1HK+1V/Ksj1KYYQMt4ykvgN2o5eAgsKGnsggkH5rAH
	vgCQ==
X-Received: by 10.66.232.66 with SMTP id tm2mr12674587pac.157.1443047612777;
	Wed, 23 Sep 2015 15:33:32 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	qg2sm9796764pbb.80.2015.09.23.15.33.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Sep 2015 15:33:32 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:34:56 -0700
Message-Id: <7b30572778cf6d9a75df532e77a1bff547ed56de.1443047547.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
References: <de438abaff89a94027ae465a62dd4c0ce79ee208.1443047547.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443047547.git.avery.brian@gmail.com>
References: <cover.1443047547.git.avery.brian@gmail.com>
Subject: [PATCH 4/6] toaster: fix reimporting module
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
X-List-Received-Date: Wed, 23 Sep 2015 22:33:33 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

removed second 'import re' from localhostbecontroller.py

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 0c34957..c22d41b 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -181,7 +181,6 @@ class LocalhostBEController(BuildEnvironmentController):
     def getGitCloneDirectory(self, url, branch):
         """ Utility that returns the last component of a git path as directory
         """
-        import re
         components = re.split(r'[:\.\/]', url)
         base = components[-2] if components[-1] == "git" else components[-1]
 
-- 
1.9.1


