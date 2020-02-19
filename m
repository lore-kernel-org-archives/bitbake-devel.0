Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 633B0613C2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Feb 2020 18:44:38 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id y11so1768321wrt.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Feb 2020 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JkjEH2YdbRQSTh+YuOB1jIpaTjXM2CtHhSCwSCJ+xDM=;
	b=ZyeUAfsaQiDshtaYYIETxRapP7H0EYjf7rw8i0Hcovwl1rtbB7TIFbUGW8cJysxqS1
	tCawi2fRTt90kP9Uclbt53r4bkhEs9g9p1A5kVkii9uD9+VUjWR38BxRKNNZJkmNFuck
	TYeYNAJjQMS1fT2VJVN82djVy0i1CAfZbdNlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JkjEH2YdbRQSTh+YuOB1jIpaTjXM2CtHhSCwSCJ+xDM=;
	b=A4TqaKxD5NIIFQb7/V95ogATiLip70wJiJquRZojAG2yrU3TOZIQPq9rCR1h+fkecY
	Gdo155YA4su3hHuHyn31SC7lrAYLz/x4wvXS8l7+54T8O2YTMGaX8qane3kQWzMPwWBt
	JbsfV02WkrO9qtqhHHq5FTZtVal3q5aqTEcVtl/N3nr9P4WtyCAdYR4v7NDmCCnfFCx1
	dXaSOL35mstfZmZxEYwLhYsvLzX1fjMDp1gZ5/XVdNyL6iReLAZO5A3dsTwgyLXDcOtE
	sPfDdjAbR7nMX33HoOk4iICajRxYrlywrdIyMNQJn+mlp73CeVE+auq1SbSK+4TcO5+y
	6Omg==
X-Gm-Message-State: APjAAAUYMN5+4anJ9JiMaMwbiB1pW8MhRc9Do1HZPPpi4S5FXEFsVcHh
	tPhvTBiP0ET7h4WKK3TT/lLUyhHsd9Q=
X-Google-Smtp-Source: APXvYqyoFHad4ncqxHLFxMiUR7yKz1a8bZiZQslXXU+0zyE2r7NhFdQPjfkpTERI8BFUpepiIS+Wwg==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr39147099wrm.150.1582137878669;
	Wed, 19 Feb 2020 10:44:38 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c13sm836020wrn.46.2020.02.19.10.44.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 19 Feb 2020 10:44:38 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Feb 2020 18:44:37 +0000
Message-Id: <20200219184437.131258-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Subject: [PATCH] fetch2/svn: Avoid UnboundLocalError exception
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
X-List-Received-Date: Wed, 19 Feb 2020 18:44:38 -0000
Content-Transfer-Encoding: 8bit

The update codepath would trigger:
Exception: UnboundLocalError: local variable 'svnfetchcmd' referenced before assignment

Fix this so the code functions as intended in both fetch and update cases.

[YOCTO #13798]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/svn.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 385a6b2cf1..971a5add4a 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -122,30 +122,30 @@ class Svn(FetchMethod):
 
         try:
             if os.access(os.path.join(ud.moddir, '.svn'), os.R_OK):
-                svnupdatecmd = self._buildsvncommand(ud, d, "update")
+                svncmd = self._buildsvncommand(ud, d, "update")
                 logger.info("Update " + ud.url)
                 # We need to attempt to run svn upgrade first in case its an older working format
                 try:
                     runfetchcmd(ud.basecmd + " upgrade", d, workdir=ud.moddir)
                 except FetchError:
                     pass
-                logger.debug(1, "Running %s", svnupdatecmd)
-                bb.fetch2.check_network_access(d, svnupdatecmd, ud.url)
-                runfetchcmd(svnupdatecmd, d, workdir=ud.moddir)
+                logger.debug(1, "Running %s", svncmd)
+                bb.fetch2.check_network_access(d, svncmd, ud.url)
+                runfetchcmd(svncmd, d, workdir=ud.moddir)
             else:
-                svnfetchcmd = self._buildsvncommand(ud, d, "fetch")
+                svncmd = self._buildsvncommand(ud, d, "fetch")
                 logger.info("Fetch " + ud.url)
                 # check out sources there
                 bb.utils.mkdirhier(ud.pkgdir)
-                logger.debug(1, "Running %s", svnfetchcmd)
-                bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)
-                runfetchcmd(svnfetchcmd, d, workdir=ud.pkgdir)
+                logger.debug(1, "Running %s", svncmd)
+                bb.fetch2.check_network_access(d, svncmd, ud.url)
+                runfetchcmd(svncmd, d, workdir=ud.pkgdir)
 
             if not ("externals" in ud.parm and ud.parm["externals"] == "nowarn"):
                 # Warn the user if this had externals (won't catch them all)
                 output = runfetchcmd("svn propget svn:externals || true", d, workdir=ud.moddir)
                 if output:
-                    if "--ignore-externals" in svnfetchcmd.split():
+                    if "--ignore-externals" in svncmd.split():
                         bb.warn("%s contains svn:externals." % ud.url)
                         bb.warn("These should be added to the recipe SRC_URI as necessary.")
                         bb.warn("svn fetch has ignored externals:\n%s" % output)
-- 
2.25.0


