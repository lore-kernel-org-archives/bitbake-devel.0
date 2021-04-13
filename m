Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.362.1618326177856302340
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 08:02:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: henning.schild@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13DF2sX5008165
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Apr 2021 17:02:54 +0200
Received: from localhost.localdomain ([167.87.48.83])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13DF2rM2021528;
	Tue, 13 Apr 2021 17:02:53 +0200
From: henning.schild@siemens.com
To: bitbake-devel@lists.openembedded.org
Cc: isar-users@googlegroups.com,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Chris Larson <Chris_Larson@mentor.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 1/3] fetch/git: add support for disabling shared clones on unpack
Date: Tue, 13 Apr 2021 17:02:49 +0200
Message-Id: <20210413150251.1969-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default the unpacker will create a "shared" clone when cloning from
the DL_DIR to the WORKDIR. This patch introduces an option to control
that behaviour.

Imagine some recipe steps are executed in a namespace that is different
from the one your downloader and unpacker ran in. (chroot) Because a
"shared" clone has an absolute reference to its "alternate" you now
have to make that "alternate" visible in that new namespace (chroot) at
the exact place.

With this patch you can unpack "noshared" and get a stand-alone copy.
This copy will also work if the "alternate" is not visible or existant.

The switch is a global bitbake switch and will affect all git urls.
Build systems that need "noshared" most likely need it for everything
they do with git.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/bb/fetch2/git.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e3ba80a3f52a..3e25b4b6047c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -168,7 +168,11 @@ class Git(FetchMethod):
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
 
-        ud.cloneflags = "-s -n"
+        ud.noshared = d.getVar("BB_GIT_NOSHARED") == "1"
+
+        ud.cloneflags = "-n"
+        if not ud.noshared:
+            ud.cloneflags += " -s"
         if ud.bareclone:
             ud.cloneflags += " --mirror"
 
-- 
2.26.3

