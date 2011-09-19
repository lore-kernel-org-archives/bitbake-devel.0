Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1R5Ypi-0007Ui-OK
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Sep 2011 10:04:06 +0200
Received: by bke11 with SMTP id 11so23502592bke.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2011 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
	bh=auKm7iUY1xfmdr1EWqOwvsPT1e7k0EyTfTubiyiE0Rc=;
	b=v9qAajmJYTtlGSlfxHH1mjh6HpK1D4VZ/XXEZCJUCf936IbK9KfwuV4Bqrg4minZoj
	WkRZiUq8YP5TzxIE/KIIMiz9NXioBV08cRKOTWVYwuxdozcbs9OQownOzPhGs/sdzsGz
	61azOba4C6xflkataF7pTtKMQmEBrYXysgy1A=
Received: by 10.204.130.139 with SMTP id t11mr745166bks.300.1316419130965;
	Mon, 19 Sep 2011 00:58:50 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id b17sm13131265bkd.8.2011.09.19.00.58.49
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 19 Sep 2011 00:58:50 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Sep 2011 09:58:41 +0200
Message-Id: <1316419121-30931-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <20110919073802.GA19168@jama.jama.net>
References: <20110919073802.GA19168@jama.jama.net>
Subject: [PATCH] fetch2/git: fix logger.debug
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
X-List-Received-Date: Mon, 19 Sep 2011 08:04:06 -0000

* logging/logger typo was fixed in 38a598731b49c8a0ba0ede570adc33eb1e848235
  but debug level is still missing

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 275536f..26236b8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -280,7 +280,7 @@ class Git(FetchMethod):
         # Check if we have the rev already
 
         if not os.path.exists(ud.clonedir):
-            logger.debug("GIT repository for %s does not exist in %s.  \
+            logger.debug(1, "GIT repository for %s does not exist in %s.  \
                           Downloading.", url, ud.clonedir)
             self.download(None, ud, d)
             if not os.path.exists(ud.clonedir):
-- 
1.7.6.1



