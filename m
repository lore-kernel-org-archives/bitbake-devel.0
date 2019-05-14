Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by mail.openembedded.org (Postfix) with ESMTP id 3B3887DEDA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 May 2019 04:41:00 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id v80so8416297pfa.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 May 2019 21:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=rIm/dr4QQOq8OPP+d9QIfB/FtYuqCJO8khRCdWIBWKg=;
	b=Ck96qPYLUvBnGb1o2Nx0uT79qyKIza+aXrjsJlTTMdYOnFz1vLUZKnQvdczLjzpnT0
	V0qBfk5ucVqm8wasS+4xPRC7omkEFkeKhUjl1rAXUZrXrCTsN4zMrTlvk7hkcU57M/8W
	9TdP5BednEkeRyV799xZkoz+CVanrzXWxNH8HsJF3lb9LVUUa2LrzN4Q5wMIqeEhhzBi
	0KUHaDZ+s3W9nh4JfuUiM1oJskkUaN0AJA92yds+gMYEGPWt+ZrCpqoVFu30xT42PNtm
	crBlho1IRoR1Ta93OrvhP5gUkl84WOqwntgVW99G75NbrEoSnetf0YppIuMd0NXFGuil
	o4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=rIm/dr4QQOq8OPP+d9QIfB/FtYuqCJO8khRCdWIBWKg=;
	b=ZnmcdqpjCUwc7BFawCrIvU4u6MYxWxOLYZS8/VdgqBHDgWz2lRIqB15FvaGsA1yQhr
	EDuYCdeJE0U4ibQ08wCg1UTr1Ss0LsXEWshDKMKWbqlzqI50nVNqjdFUoLf9iquBF4Gz
	8TNlcBBOz4S6cb+wcm6/ekdYWzPzQhMkiWbsn1lqo7oT25zkkbkcmh+O5QMTvwK5E8bG
	FnGPtY/I7CofOYHwMM4AmGl/KZYaW+uR1OyBf0ryorEH4+97nxA0KwZRG2CgaDCiALzS
	GHGBQtuyDUVCOIfLCVk2IDEFsb6BqVGeoC1wHpxN9CYNNqp3H21I97/E0wjJrdUJVA6d
	RYXg==
X-Gm-Message-State: APjAAAXEDnmHjygNmfJG41ftEzpqhYpzkWxstiVve1z6thfxyGkgrrrE
	nIrBUwkf6wmWTDJRlsMS5pX5kExl
X-Google-Smtp-Source: APXvYqxxH78PWtcKWWAakm7hIYZT9+8q8+okxWinryh4Aq5D7zX+nEwxQZPykxevqnTqeoI81KGaAw==
X-Received: by 2002:a62:5587:: with SMTP id j129mr17050852pfb.45.1557808861251;
	Mon, 13 May 2019 21:41:01 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:c33:d909:eb3d:d2ab:fd1d])
	by smtp.gmail.com with ESMTPSA id
	132sm18371323pga.79.2019.05.13.21.41.00
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 May 2019 21:41:00 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 May 2019 21:40:28 -0700
Message-Id: <3863ac81072057c5b9a954a0e78a496cd808297c.1557808320.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1557808320.git.akuster808@gmail.com>
References: <cover.1557808320.git.akuster808@gmail.com>
Subject: [PATCH 2/2] bitbake: fetch2/git: git-lfs check
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
X-List-Received-Date: Tue, 14 May 2019 04:41:00 -0000

From: Naveen Saini <naveen.kumar.saini@intel.com>

Build will fail if repository has lfs contents in absense of git-lfs tool on host.
Build will pass if repository may or may not contains lfs content if host has git-lfs installed.

[YOCTO #13198]

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/git.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 8185bf4..c69d25c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -503,6 +503,17 @@ class Git(FetchMethod):
 
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
+
+        if self._contains_lfs(ud, d, destdir):
+            path = d.getVar('PATH')
+            if path:
+                gitlfstool = bb.utils.which(path, "git-lfs", executable=True)
+                if not gitlfstool:
+                    raise bb.fetch2.FetchError("Repository %s has lfs content, install git-lfs plugin on host to download" % (repourl))
+            else:
+                bb.note("Could not find 'PATH'")
+
+
         if not ud.nocheckout:
             if subdir != "":
                 runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d,
@@ -553,6 +564,20 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
+    def _contains_lfs(self, ud, d, wd):
+        """
+        Check if the repository has 'lfs' (large file) content
+        """
+        cmd = "%s grep lfs HEAD:.gitattributes | wc -l" % (
+                ud.basecmd)
+        try:
+            output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
+            if int(output) > 0:
+                return True
+        except (bb.fetch2.FetchError,ValueError):
+            pass
+        return False
+
     def _get_repo_url(self, ud):
         """
         Return the repository URL
-- 
2.7.4


