Return-Path: <mounesh.sutar@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 60CF360938
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 06:24:36 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id n24so282856pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 23:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=moRybTF+dY4ZH1XKA0nn5Qw4CdZajB4z+F2n2RI2jno=;
	b=TH1h0+mBR0y3LdZjtAF5xY10ZVA/u5NaMxWM4lyaer6ijnx3PQtWWP26B2nq5EM2T1
	lfRLzhGeh/P0b8yOTgsLIMvITK79YrKDI5cR4FmxQz/m6qZXzA/YC/6ssV+eu9ITs1th
	lS+dAK55jX2d1+jmbva94BxeKZJF1tWSoQb17HZxf4q/iycEvNktlVgGzwCx2oE7HMVe
	k/M0xlHP5ePGGHDVjcFnhZx2vemIiA7NYExWePI+AsVcW0OIhNqN0aLW5Mix+MdaU9LR
	4xQsaApEeY6OLGZ1r3ebblNXBTc7CE9bKZbPsgviRLpew1YeSC5+xl0PqoEz/2R1mxbV
	zE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=moRybTF+dY4ZH1XKA0nn5Qw4CdZajB4z+F2n2RI2jno=;
	b=YzBLT1DO/4ixDfygszogX9g86Xe/4xd2oOpVykeepfiIDhkHzRJLl0YQUOJC/PWN5p
	vwUslOH+9pQSOooLLhjVzL3c/zbWS2acgumER1/c0kDkw+qbuRw+ea7VnUSjhfvpi0pj
	O9E5qpsrEkI0SZeh8VY9v3YvDzJAJ05Io458UaqSvOu1MSIyjjRiy/ya1rGEoiJysl0/
	dC9D713L1ZebTv0/tFx7tiMdczk1UOLU2HFuqyX7pqEg1kdSnKEz6aRuGh8WpsxpQs5k
	aQ9Gc+ondhTKF08AwU4tVGi3ekRDxkDmm6xL6EqCndlxOcA9QN6eU43iNhgCWwAjWN5o
	Vmzg==
X-Gm-Message-State: AE9vXwN5iuu4BLJoSDIAlzEvnFekI0FRWXAkHAYWSXt2IEOt6NvZ4bwKL1vUSNoLQYMXaA==
X-Received: by 10.98.81.1 with SMTP id f1mr44856649pfb.35.1474957477703;
	Mon, 26 Sep 2016 23:24:37 -0700 (PDT)
Received: from mounesh-VirtualBox.inp.mentorg.com ([139.181.35.34])
	by smtp.gmail.com with ESMTPSA id
	s74sm1511819pfs.44.2016.09.26.23.24.35
	(version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 26 Sep 2016 23:24:37 -0700 (PDT)
From: Mounesh Sutar <mounesh.sutar@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2016 11:54:25 +0530
Message-Id: <1474957465-27791-1-git-send-email-mounesh.sutar@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Mounesh Sutar <mounesh_sutar@mentor.com>
Subject: [PATCH] bitbake warning fix: No bb files matched BBFILE_PATTERN_packageName
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
X-List-Received-Date: Tue, 27 Sep 2016 06:24:39 -0000

From: Mounesh Sutar <mounesh_sutar@mentor.com>

bitbake is parsing all recipe files, against layers BBFILE_PATTERN for warning message display.
In case of sublayer with lower/equal priority, then all sublayer's patterns are not being
considered for pattern match. While checking recipe file against matching pattern,
the first matching pattern is accepted and added to matched list, while remaning PATTERNs are
not being considered. With this, the recipes are being neglected from PATTERN match.
This fix let's parser run through all the layers PATTERNs and on matching added to match list.

Upstream-Status: Submitted [bitbake-devel@lists.openembedded.org]

Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>
---
 bitbake/lib/bb/cooker.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4df8881..5fde995 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1705,7 +1705,7 @@ class CookerCollectFiles(object):
                 if matched != None:
                     if not regex in matched:
                         matched.add(regex)
-                return pri
+                        return pri
         return 0
 
     def get_bbfiles(self):
-- 
1.7.9.5


