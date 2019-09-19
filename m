Return-Path: <ross.burton@intel.com>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id C41BD7FE7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 22:43:42 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id y19so4800932wrd.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=8vjrzt+oP3yTuwB7rNSU0RpkwwLYbXNClh2bAsIhqQ0=;
	b=t9yCdrQB08w1LH031Uu1OZ6CiJVr71OuX077tzYmSL0Stfu2+Q+gToftb1QDGsWk5u
	3Xd38o9gNRPAeF30FH23vHqcKY6ZqBLAMH+FRNN3WeME+NlVpgGT4tfcP9K+HCPhzZ3w
	nxl6rrI0MPAWW3sxYTAjX9/bVlFXauWuIHK3ZZNA29NkjX2TZX9TF/OfN7flanhFkwMG
	MZ04wNPghGWRbSM9YvWuN3TrN/sZ1oNaJevqIHPFP5uD17A9WgsNiBchnyPIg7yYkfAe
	/7ARJM9sI1eUye8VOEoogLhfdA4Djs2M7v5i9y63x6q7cN/EV+Xkx/KLI04XJwZZqJHB
	Sk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=8vjrzt+oP3yTuwB7rNSU0RpkwwLYbXNClh2bAsIhqQ0=;
	b=OR033BsJIbWK+PoCRXAlWMAohQxNQ9ca7bagv6/GcX2PL2UedBvcge1bcIm8YnASe4
	mxyanaD1FFSgd1ta+aGLHMbJBW7oVT3SHUGvaDDBs/Lq8hrkWUsDFyWktqTobpYZZtgB
	313xtU1AF6wjey+HPzJiJU/bkUZo3by4TPuIjvDof4CLnChCevMyqEA+6zJFBkXNjDm3
	43Kle4o4WxHBG8p8PeGxIe/Q86B7sayS0lHXlmEburF2hbvGUtIhKLH9YXXL8cbuwHvH
	fVk6zpg787DNzw0wku+TMrT74/HrQkDBfcd/6jxXCU5P9tgoHKEG5vmzQG+cuJi34FjE
	po9w==
X-Gm-Message-State: APjAAAXFaHwGRijifoKleqPpmtDfDQpIy77VeNkLw8z7yK8zOt498Elt
	8+RTgTjX4rTQ3Q9fTJH6U74KNUkay9o=
X-Google-Smtp-Source: APXvYqy0V+5ZeFUrBqHPfR5mE47ah2KIh9kjSoFTL23GuFcjjGb7jj52zRtjGDzevvA8/+Z4sdJxJQ==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr9434731wrj.269.1568933023142; 
	Thu, 19 Sep 2019 15:43:43 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	u18sm5562054wmj.11.2019.09.19.15.43.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 15:43:41 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Sep 2019 23:43:36 +0100
Message-Id: <20190919224337.30208-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/2] fetch2/git: refactor check for git-lfs command
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
X-List-Received-Date: Thu, 19 Sep 2019 22:43:44 -0000
Content-Transfer-Encoding: 8bit

Refactor the git-lfs checking: this means both clearer code in the download()
function and allows unit testing to monkeypatch the functionality.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/git.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5fd63b4e33b..2d1d2cabd59 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -495,14 +495,8 @@ class Git(FetchMethod):
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
 
         if self._contains_lfs(ud, d, destdir):
-            if need_lfs:
-                path = d.getVar('PATH')
-                if path:
-                    gitlfstool = bb.utils.which(path, "git-lfs", executable=True)
-                    if not gitlfstool:
-                        raise bb.fetch2.FetchError("Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)" % (repourl))
-                else:
-                    bb.note("Could not find 'PATH'")
+            if need_lfs and not self._find_git_lfs(d):
+                raise bb.fetch2.FetchError("Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)" % (repourl))
             else:
                 bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
 
@@ -570,6 +564,13 @@ class Git(FetchMethod):
             pass
         return False
 
+    def _find_git_lfs(self, d):
+        """
+        Return True if git-lfs can be found, False otherwise.
+        """
+        import shutil
+        return shutil.which("git-lfs", path=d.getVar('PATH')) is not None
+
     def _get_repo_url(self, ud):
         """
         Return the repository URL
-- 
2.20.1


