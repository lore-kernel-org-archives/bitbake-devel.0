Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1R4T5T-0002OE-Ql
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Sep 2011 09:43:51 +0200
Received: by mail-bw0-f47.google.com with SMTP id 11so4590775bke.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2011 00:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references;
	bh=TxODqT7PH11C17GRKGm50xQelKd6Uxe3QcqLg7kXmlc=;
	b=Cxl6nt7wf/vI9UwGGRqGpT9CPgSqzIGQhfH3BpZn8mdw12gywNM07+WlXhQOBhtu8T
	poTBURdOBnwgjpT92xjJcs9msEQbeBpLHnEzQth5A708Eg2deWpXL8w7Pzu+3See8Tfh
	vmEf6WdPv3iXR05HLCO+Q9CFuaOtL8hLDmLcM=
Received: by 10.204.157.24 with SMTP id z24mr1069163bkw.93.1316158721701;
	Fri, 16 Sep 2011 00:38:41 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id z7sm5494783bkt.5.2011.09.16.00.38.40
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Sep 2011 00:38:40 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2011 09:38:22 +0200
Message-Id: <1ad8bf411725bc4e558bab09159767eecc7b5457.1316158579.git.Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <dcee0b51ca65396116e907215717cd946a56b210.1316158579.git.Martin.Jansa@gmail.com>
References: <dcee0b51ca65396116e907215717cd946a56b210.1316158579.git.Martin.Jansa@gmail.com>
In-Reply-To: <cover.1316158579.git.Martin.Jansa@gmail.com>
References: <cover.1316158579.git.Martin.Jansa@gmail.com>
Subject: [PATCH 2/3] fetch2/git: be more carefull in _contains_ref when checking git log output
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
X-List-Received-Date: Fri, 16 Sep 2011 07:43:51 -0000

* in some cases there could be output like this
  ERROR: ld.so: object 'libpseudo.so' from LD_PRELOAD cannot be preloaded: ignored.
  before wc -l output and returned 'output.split()[0] != 0' is always True

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/git.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 26236b8..4a4c30d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -239,7 +239,10 @@ class Git(FetchMethod):
 
     def _contains_ref(self, tag, d):
         basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
-        output = runfetchcmd("%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (basecmd, tag), d, quiet=True)
+        cmd = "%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (basecmd, tag)
+        output = runfetchcmd(cmd, d, quiet=True)
+        if len(output.split()) > 1:
+            raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
     def _revision_key(self, url, ud, d, name):
-- 
1.7.6.1



