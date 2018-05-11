Return-Path: <matt.hoosier@gmail.com>
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
	[209.85.214.48])
	by mail.openembedded.org (Postfix) with ESMTP id 4D43778375
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 19:26:38 +0000 (UTC)
Received: by mail-it0-f48.google.com with SMTP id z6-v6so3296073iti.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=dBoT677zPcIlOi/UiV5n+ZDUaOna5hx4nxdnLrRFftc=;
	b=qUrNSns0gmqKHPOEUzGjdmqgkqsaK3uNbnkBDMJbJPljxUH/aEA4UVs69Y+d3/jRVA
	wrh0eNvHr1x/5IqECqTESlnQJ3TFo/LQkJpyNUWB0AdbPzNbzT3J4rE88QwLJYBILvM3
	sjTJrrij24d6hBEMInUVaD0EWOXqnu0E+/PUdw4ywBQB3gM2BGpRK5+sxu/cElpQ7Vcz
	rYiKnm2Hg9+1HANfrPo9YKCNScyG/siVIfTqD2MTvod6VcoLRPmnAQObJNnNjom0s+99
	RO+LCkUe1n1QZNKWW1E6WHoklChotXxnB/IzS+nUrjYgAa6ZggOUcXl3p8Qabo8gxab+
	lWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=dBoT677zPcIlOi/UiV5n+ZDUaOna5hx4nxdnLrRFftc=;
	b=Vy/8eUOb8cTCJixEvx6FhIxKKiJR6bN1IjTdXH2uHJlHga/MRJiYdyob1uottcUEmZ
	6V1oYnbVNlFYMQpJ+6H2ShHEC3cJLZk7aFbZ8aBVEhbCg9+oSelC/qjQfAZHR3TbeAf3
	Od3r2iTZnfA8ueEYpQ7M3wmiQbkmk+gNEhdxayW/LRy2tRuT5sgcR4BoWgvzDq4vHOxv
	JpE6gskg8iytzXFyKDvEjahfdylq+46FQBjuXxPxt53chUjEw34rMIfmzgcwohWO64UR
	oBt9owdBsgy+o7Cu7/soQIroAAMJMu9T7cUfOC9NmU01DMqizChve6xzwrowqbu3MKsz
	02Ew==
X-Gm-Message-State: ALKqPwdrmEFe3NT91Rgrobh5iHrEy6clw8qIUVFi0VmcG3Z8HIgEfZvK
	nJ+KFdSTAfYiyC5/f3b4iCqZVlv8
X-Google-Smtp-Source: AB8JxZp+5gzK70FfFLR5iOCjNAelLnPS8OfJGbW9uTOzRjOhxuul4/C+YuCyfGCOmm67arXqL0u7JQ==
X-Received: by 2002:a24:4953:: with SMTP id
	z80-v6mr4559335ita.49.1526066799657; 
	Fri, 11 May 2018 12:26:39 -0700 (PDT)
Received: from localhost.localdomain ([204.77.163.42])
	by smtp.gmail.com with ESMTPSA id
	m137-v6sm990441itg.14.2018.05.11.12.26.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 11 May 2018 12:26:38 -0700 (PDT)
From: Matt Hoosier <matt.hoosier@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 May 2018 14:26:36 -0500
Message-Id: <20180511192636.6231-1-matt.hoosier@gmail.com>
X-Mailer: git-send-email 2.13.6
Subject: [PATCH] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 11 May 2018 19:26:39 -0000

Although the submodules' histories have been fetched during the
do_fetch() phase, the mechanics used to clone the workdir copy
of the repo haven't been transferring the actual .git/modules
directory from the repo fetched into downloads/ during the
fetch task.

Fix that, and for good measure also explicitly tell Git to avoid
hitting the network during do_unpack() of the submodules.

Rev3 changes:

- Really fix the shallow-clone issue claimed to be addressed in rev2.

Rev2 changes:

- Fixed a failure when unpacking a shallow cloned mirror repository.

[YOCTO #12739]

Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0aff1008..3969f2f5 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -132,4 +132,30 @@ class GitSM(Git):
 
         if self.uses_submodules(ud, d, ud.destdir):
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
-            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
+
+            updateflags = ""
+
+            # Copy over the submodules' fetched histories too.
+            if ud.bareclone:
+                repo_conf = ud.destdir
+            else:
+                repo_conf = os.path.join(ud.destdir, '.git')
+
+            if os.path.exists(ud.clonedir):
+                # This is not a copy unpacked from a shallow mirror clone. So
+                # the manual intervention to populate the .git/modules done
+                # in clone_shallow_local() won't have been done yet.
+                runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
+                updateflags += " --no-fetch"
+            elif os.path.exists(os.path.join(repo_conf, 'modules')):
+                # Unpacked from a shallow mirror clone. Manual population of
+                # .git/modules is already done.
+                updateflags += " --no-fetch"
+            else:
+                # This isn't fatal; git-submodule will just fetch it
+                # during do_unpack().
+                bb.error("submodule history not retrieved during do_fetch()")
+
+            # Careful not to hit the network during unpacking; all history should already
+            # be fetched.
+            runfetchcmd(ud.basecmd + " submodule update --init --recursive %s" % updateflags, d, workdir=ud.destdir)
-- 
2.13.6


