Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1R4Sfq-0001RX-TT
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Sep 2011 09:17:22 +0200
Received: by fxi1 with SMTP id 1so1433574fxi.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2011 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=vo8JeOOdzAzoOYk4qC+/qgD+qb8wC2rzwYW8raIJhjk=;
	b=IbH8Xg+HvbaTza3hXVtctRjnOuY5d+6+f7qMMw7JCCUuL1UvwZGboE3Sk8tSg4K1Kk
	5h567RYDFGzeVHLklosFtgnWMbJJRp0OKt1xtFQ1L5zxLJBv/OPRgR5nQPvL/YIsChnW
	3ZtQX9ZMTTREEKL0eAkDqF1HoKGrD2/W2GQpg=
Received: by 10.223.41.153 with SMTP id o25mr1999713fae.79.1316157130727;
	Fri, 16 Sep 2011 00:12:10 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id i5sm596258fai.15.2011.09.16.00.12.08
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Sep 2011 00:12:09 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2011 09:11:55 +0200
Message-Id: <1316157115-13998-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.6.1
Subject: [PATCH] fetch2/git: fix typo logggin/logger
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 16 Sep 2011 07:17:23 -0000

---
 lib/bb/fetch2/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 9a578ae..26236b8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -280,7 +280,7 @@ class Git(FetchMethod):
         # Check if we have the rev already
 
         if not os.path.exists(ud.clonedir):
-            logging.debug("GIT repository for %s does not exist in %s.  \
+            logger.debug(1, "GIT repository for %s does not exist in %s.  \
                           Downloading.", url, ud.clonedir)
             self.download(None, ud, d)
             if not os.path.exists(ud.clonedir):
-- 
1.7.6.1



