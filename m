Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id E48067F31A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 15:51:23 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id i16so5185239wmd.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=aXQP9I/V+lmXyBXWUciF+05peF/WOnYnd5xwW2O+8yA=;
	b=HkF6Llft2ka8cf1JByBsswNo24IER5hiXZnTeetKviHazaNWJ0stzDvfKB3kyKEjdN
	2XAt6IQGQbXaFi4Fz89WeIgIQu0STx+FjogyoyCmrOv/9dAcSY5Ma9VzKQC0yF2T7GSI
	FyEfFSAXn4yRB9OSNOeAG/xEWusb1J1K+YPzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=aXQP9I/V+lmXyBXWUciF+05peF/WOnYnd5xwW2O+8yA=;
	b=GKnuF+HqzEHtLJYaLy4nYEI6x/Q5hA9M2pecYTaBZB252Lxtj6RDkF/ipBbetwzjt5
	82SzxAeX8G70114IltSWG7FXyg2OGt8zcN3WD0TvDWi8HAEVL1krZgeP6BXzcAC7YySj
	NVEXaHcbI2QfNF+9vNAOvvGXg95PrPT0zdIj5IaMiv3MKp/CunDu9YGEG1l5nkaeS7xQ
	YNcXcb7V1irV7kKn4QqWlDii3IaoqBUq+izgU61ZkcPy9MFN3vgSNTzYxs7Jyb5oitZu
	V/KlIsn09DHsBExocOMg/+Vx11oR+9yiffHtDUMygC/0Fuwk98KEL2G536jrL2YG/LQX
	229w==
X-Gm-Message-State: APjAAAW5+OejCLh3Lt+7A9NBNrAgjSztl/1oiXYC2W9cifpDYLxPuziv
	EAxmZQhUz7UHSm9I/LXNj5DnS6Ycfms=
X-Google-Smtp-Source: APXvYqz+sWOHQQqe4LJrTt8iQpV/+dbLsBY/I5rHL+oYdjGmLE46vkCuvJ5/+9QtHxhR5jWNLTkzag==
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr3169994wmm.37.1568908284430;
	Thu, 19 Sep 2019 08:51:24 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s10sm10023700wmf.48.2019.09.19.08.51.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 08:51:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Sep 2019 16:51:22 +0100
Message-Id: <20190919155122.28732-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] utils: Add ionice option to prunedir
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
X-List-Received-Date: Thu, 19 Sep 2019 15:51:24 -0000
Content-Transfer-Encoding: 8bit

Autobuilder type infrastructure can benefit from deletion of certain files as
background IO due to the way Linux filesystem priority works.

We have problems where build directories as part of oe-selftest being
delete starves the running tasks of IO to the point builds take much
longer to compelte.

Having this option of running the deletion at "idle" helps a lot with
that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3e90b6a306..d035949b3d 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -677,7 +677,7 @@ def _check_unsafe_delete_path(path):
         return True
     return False
 
-def remove(path, recurse=False):
+def remove(path, recurse=False, ionice=False):
     """Equivalent to rm -f or rm -rf"""
     if not path:
         return
@@ -686,7 +686,10 @@ def remove(path, recurse=False):
             if _check_unsafe_delete_path(path):
                 raise Exception('bb.utils.remove: called with dangerous path "%s" and recurse=True, refusing to delete!' % path)
         # shutil.rmtree(name) would be ideal but its too slow
-        subprocess.check_call(['rm', '-rf'] + glob.glob(path))
+        cmd = []
+        if ionice:
+            cmd = ['ionice', '-c', '3']
+        subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
         return
     for name in glob.glob(path):
         try:
@@ -695,12 +698,12 @@ def remove(path, recurse=False):
             if exc.errno != errno.ENOENT:
                 raise
 
-def prunedir(topdir):
+def prunedir(topdir, ionice=False):
     # Delete everything reachable from the directory named in 'topdir'.
     # CAUTION:  This is dangerous!
     if _check_unsafe_delete_path(topdir):
         raise Exception('bb.utils.prunedir: called with dangerous path "%s", refusing to delete!' % topdir)
-    remove(topdir, recurse=True)
+    remove(topdir, recurse=True, ionice=ionice)
 
 #
 # Could also use return re.compile("(%s)" % "|".join(map(re.escape, suffixes))).sub(lambda mo: "", var)
-- 
2.20.1


