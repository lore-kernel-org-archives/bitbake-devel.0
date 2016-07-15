Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 0DA286067C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jul 2016 10:27:25 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id o80so23378623wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jul 2016 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=ImOzww3+/fmBR6lXfmwwTqwezUEK7tvmB7U52A6+fgM=;
	b=GmcD5bgngwirJ506v4lbqRwVxgKC195Birbc56rxC9KxN4q+YeqR+6l9KCGuRNy9oa
	Njy8dNWLCuK0EoXAKM8zvr8rgYyDaUX0OaDW+5+82pXIEcyPwpWB9/nuYJiJVji65MKP
	9BawX8x9dA9NAUWuV5a1OY28eCvrWuOq2Zl9t2YUvi2AFL05RrVugouA2H071AGUSbxk
	DHKsfllypqLuh23Azjv/qv/HTzZBVC9pKyeRV5FsEviuQ/+T5aAIH+UbG5DXjOyWKiyu
	lrrd7hJ4+GhPROvyszT5TJVE454I+P/hlkGHdJqzu8h8uN6zqxSlCdGDVadKWcxWEgxb
	2GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=ImOzww3+/fmBR6lXfmwwTqwezUEK7tvmB7U52A6+fgM=;
	b=KqgZXkNAAiMEfS3eA+PFsQ8tRZ/lv0G08MbnV8s9txCEWrBiCzzZk8aQlBDxcekdqI
	ocISKQMm6JR0YoPniYlVQ+iKFSB9Yp9jIL6/LrO5U5g30DNANSlsLekwBSAhMN3O115o
	V+RgT4D8aRFEPmKzQU15mIyXjYTXo9Xt1R2lXenjJ+iij8I/5ye4hjKoomWOjcrXLt7d
	wSuqfkGJar1EV1/Khz6+LZYRxsgqntUHGW/HifZ90cExMa1uRbY6miKOkfldjMyxLYUn
	Uaofn9P7Nk/ZcLKDM+U9uwKm8ohuXcD7qqayI/aLvjdEvPVTpdr305yzYa112MWu+K4d
	9EYQ==
X-Gm-Message-State: ALyK8tI8QwJVctILiylcaAex8AGT1MgjOawN7EXDnqj6kz+G7W9wgavrA5Ibh6OKElRdYcMT
X-Received: by 10.28.27.143 with SMTP id b137mr32726507wmb.12.1468578445718;
	Fri, 15 Jul 2016 03:27:25 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	a203sm2062825wma.0.2016.07.15.03.27.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 15 Jul 2016 03:27:24 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jul 2016 11:27:22 +0100
Message-Id: <1468578442-23552-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] lib/bb/build.py: decode the command as UTF-8
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
X-List-Received-Date: Fri, 15 Jul 2016 10:27:27 -0000

The messaging FIFO is UTF-8, so decode the command as UTF-8 as well as the value
as otherwise "bberror" != b("bberror") and none of the messages from shell
functions are ever displayed.

Also add an else to the command parser so unhandled commands are noticed.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/build.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 4f01d66..7c47680 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -389,7 +389,7 @@ exit $ret
         lines = data.split(b'\0')
         for line in lines:
             splitval = line.split(b' ', 1)
-            cmd = splitval[0]
+            cmd = splitval[0].decode("utf-8")
             if len(splitval) > 1:
                 value = splitval[1].decode("utf-8")
             else:
@@ -413,7 +413,8 @@ exit $ret
                 level = int(splitval[0])
                 value = splitval[1]
                 bb.debug(level, value)
-
+            else:
+                bb.warn("Unrecognised command '%s' on FIFO" % cmd)
     tempdir = d.getVar('T', True)
     fifopath = os.path.join(tempdir, 'fifo.%s' % os.getpid())
     if os.path.exists(fifopath):
-- 
2.8.1


