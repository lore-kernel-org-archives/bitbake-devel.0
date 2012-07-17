Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1SrGaC-0002a3-EE
	for bitbake-devel@lists.openembedded.org;
	Wed, 18 Jul 2012 00:49:32 +0200
Received: by wibhm11 with SMTP id hm11so744556wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2012 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
	bh=9a6m4+Ie5lROyyYMgkR3RaZ5TMnemkm8UJa1HM2KXLQ=;
	b=rtUiLqpx7YRKwmN166WZnaVDKQDvRNxwxFKS2YMml0ElkVygd8Bws7nKeSwML3owJ7
	ckkie+P3NaZy1QQpQyu7yxg49dulne4ojGU2VZPTI74MtzwNNEOd/tZLUcPIhlBzIhUJ
	UirlYka4k789Xe4hPHiT/A/TplPDknbZqyGANQ+abfPc36PUwGITnvvWNCd6+Ey7Dwpp
	8KALNzGr5j64FXazI1TMwekp72G9n/Osier5vPg1eNczhc2PpxynmplGxFgQ7wFuWbsk
	Qj1x1RlhfAg4UvxrBD9+balKTJo8V+o2JZy7rVgijGZele09kK0W/gXmliF3pFlUGnmZ
	89OA==
Received: by 10.180.81.133 with SMTP id a5mr1360385wiy.17.1342564692644;
	Tue, 17 Jul 2012 15:38:12 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id eu4sm29325520wib.2.2012.07.17.15.38.11
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 17 Jul 2012 15:38:11 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Jul 2012 00:38:19 +0200
Message-Id: <1342564699-490-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.6
In-Reply-To: <y>
References: <y>
Subject: [PATCH] fetch2/svn.py: Use protocol parameter to get the protocol
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
X-List-Received-Date: Tue, 17 Jul 2012 22:49:32 -0000

* it was send in v1 of proto -> protocol changes but then wasn't in V2
  http://patchwork.openembedded.org/patch/31617/
  where warning about proto= was moved to shared __init__

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/svn.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index bc5b96b..ea5902e 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -71,7 +71,7 @@ class Svn(FetchMethod):
         command is "fetch", "update", "info"
         """
 
-        proto = ud.parm.get('proto', 'svn')
+        proto = ud.parm.get('protocol', 'svn')
 
         svn_rsh = None
         if proto == "svn+ssh" and "rsh" in ud.parm:
-- 
1.7.8.6



