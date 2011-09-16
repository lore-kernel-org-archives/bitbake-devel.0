Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1R4T5O-0002OE-3W
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Sep 2011 09:43:46 +0200
Received: by bke11 with SMTP id 11so4590775bke.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2011 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
	bh=uD4JbqMOaFPy11ebpKwytzPTczNv3qhKFZM1l/EjuFA=;
	b=Oux2oHa9tuGrACCnOKu2NAF2JtJ3AUxo8lOllaTo3tE0BDOjm69EA4oiY8kZpRIZyO
	cAEl+aISWLsdCsYaof+FUPTpHBFkffCgohuPam0+eYlH988WhTjbJ7n9ffJYnJfDqmAy
	TYWXiihtAXqXBu73FQAzX55q6jVvfQrYdfUqA=
Received: by 10.204.132.195 with SMTP id c3mr1280982bkt.241.1316158713839;
	Fri, 16 Sep 2011 00:38:33 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id v16sm5488578bkd.6.2011.09.16.00.38.31
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Sep 2011 00:38:32 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2011 09:38:21 +0200
Message-Id: <dcee0b51ca65396116e907215717cd946a56b210.1316158579.git.Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <cover.1316158579.git.Martin.Jansa@gmail.com>
References: <cover.1316158579.git.Martin.Jansa@gmail.com>
Subject: [PATCH 1/3] fetch2/git: fix typo logggin/logger
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
X-List-Received-Date: Fri, 16 Sep 2011 07:43:46 -0000

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
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



