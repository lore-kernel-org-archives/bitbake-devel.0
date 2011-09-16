Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1R4T5b-0002OE-PX
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Sep 2011 09:43:59 +0200
Received: by mail-bw0-f47.google.com with SMTP id 11so4590775bke.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2011 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references;
	bh=dRHDxmxOZL2uNTR3Ks80R10ue/L+cd7apGpvzRsqulo=;
	b=syQSz9f9sW47GUc0Dveu+PVTdXry4zc8Kh/EcZv8D4u9LFqacZj+/AaGf7TKzYePLx
	RPjqaL/O53SKkp6KujZRtRQPk69GAKzAhIjwSRtA9FCjhn6y/waMbpeHwuZXcF+IPzjc
	8QJ41AnjUar8D8xg1TH8Z58hR6AhlS9awDJAc=
Received: by 10.204.3.20 with SMTP id 20mr1335122bkl.60.1316158729656;
	Fri, 16 Sep 2011 00:38:49 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id z9sm5487523bkn.7.2011.09.16.00.38.47
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Sep 2011 00:38:48 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2011 09:38:23 +0200
Message-Id: <ddba709dd6e0e2ecc065a95774ae0a1dd64fd02f.1316158579.git.Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <dcee0b51ca65396116e907215717cd946a56b210.1316158579.git.Martin.Jansa@gmail.com>
References: <dcee0b51ca65396116e907215717cd946a56b210.1316158579.git.Martin.Jansa@gmail.com>
In-Reply-To: <cover.1316158579.git.Martin.Jansa@gmail.com>
References: <cover.1316158579.git.Martin.Jansa@gmail.com>
Subject: [PATCH 3/3] fetch2: export LD_LIBRARY_PATH
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
X-List-Received-Date: Fri, 16 Sep 2011 07:43:59 -0000

* in some cases git calls omits extra output like this
  ERROR: ld.so: object 'libpseudo.so' from LD_PRELOAD cannot be preloaded: ignored.
  and because runfetchcmd redirects stderr to stdout it ends in output
  which we're parsing ie in _contains_ref

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/__init__.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f6fa46c..8a8a636 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -385,7 +385,7 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
     exportvars = ['PATH', 'GIT_PROXY_COMMAND', 'GIT_PROXY_HOST',
                   'GIT_PROXY_PORT', 'GIT_CONFIG', 'http_proxy', 'ftp_proxy',
                   'https_proxy', 'no_proxy', 'ALL_PROXY', 'all_proxy',
-                  'SSH_AUTH_SOCK', 'SSH_AGENT_PID', 'HOME']
+                  'SSH_AUTH_SOCK', 'SSH_AGENT_PID', 'HOME', 'LD_LIBRARY_PATH']
 
     for var in exportvars:
         val = bb.data.getVar(var, d, True)
-- 
1.7.6.1



