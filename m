Return-Path: <jpuhlman@mvista.com>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
	[209.85.192.170])
	by mail.openembedded.org (Postfix) with ESMTP id 52D266057B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 22:32:30 +0000 (UTC)
Received: by mail-pf0-f170.google.com with SMTP id y69so34852954pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=VhEwUw12MGINLssxaKzl3C5ORcBriMFqB9Y1d4pP3ZU=;
	b=H61ET12mWqJWvCgxvrX11i4OUN2aoQu2HI4jrgJRhcuI0Ybdsr8hcDuwHK8BrWbj6e
	3UXyf84d8tXKW5V+E1ZNTVDMp6n/gGUWijJ6LsSvO3w/ODnH0RMT7mtzxBKYGXh2g1ku
	VnSnjbT9QAGnf+Pvm04fJ+7BE/oVjTf/QZO4hHWvCHz7PIrMqN0EGJHaVEBYRgWXanYc
	AoM3S0DLwh5FX1uFZZbtNhlgCbjHKw2lDoXGeOmoDWvMHZCYy7C+i0IOH9YMFCtCPGv/
	C/Ohsae4arVMomjN1Iiahss08rYA2OTlaPWN81QejLqEHxx0WUTQr2tmg8ZgRai1uTNn
	l3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=VhEwUw12MGINLssxaKzl3C5ORcBriMFqB9Y1d4pP3ZU=;
	b=SHWpal89XzzIJGhQ9wbFZkDL0w6+ZlLojpmiHG9GLAn2BfQluZxu5vUsK3GHdqc/VW
	J/GbSCUaEV4e7oovE8SEZnexlhunj5aEonsq2I3ZpJzKIF28f3+0xHVtOb8TEyucXL7w
	NAlZxoSQIIx3BxxwlrIXfWuNsyUs7JR9Bt/x5JUJffY9sE7VfuZEaEHLjDT9r3eTeA7A
	WRrelnESyqZvHn9rhNswMdgoGQ3DJUVS5YQ37rwNbu1o0XnwpWSL6uWc9KglzldVkrS2
	XC+TVrcsKEmn3uygsMhuJX410uJbVS+Btx9I3v9WuipuNbtDkjzxzQKFnXHZqFkdcJtV
	XfjQ==
X-Gm-Message-State: AOPr4FV+U8I8vxXlqkKOxJXfJJl/EgHgY3TZNB3AZJOFpZkiVrqEeUtKXxtWYbeGzsOevp/5
X-Received: by 10.98.44.81 with SMTP id s78mr17688914pfs.56.1463092351034;
	Thu, 12 May 2016 15:32:31 -0700 (PDT)
Received: from workhorse.mvista.com
	(99-0-9-164.lightspeed.frokca.sbcglobal.net. [99.0.9.164])
	by smtp.gmail.com with ESMTPSA id n6sm22239700pfa.2.2016.05.12.15.32.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 May 2016 15:32:29 -0700 (PDT)
From: Jeremy Puhlman <jpuhlman@mvista.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 May 2016 15:32:05 -0700
Message-Id: <1463092325-11724-1-git-send-email-jpuhlman@mvista.com>
X-Mailer: git-send-email 2.6.2
Subject: [python3][PATCH] Set required python 3 version to 3.4.0
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
X-List-Received-Date: Thu, 12 May 2016 22:32:30 -0000

get_context was added to mutliprocessing as part of 3.4.0

Signed-off-by: Jeremy Puhlman <jpuhlman@mvista.com>
---
 lib/bb/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 6b85984..a98ebd1 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -24,8 +24,8 @@
 __version__ = "1.31.0"
 
 import sys
-if sys.version_info < (2, 7, 3):
-    raise RuntimeError("Sorry, python 2.7.3 or later is required for this version of bitbake")
+if sys.version_info < (3, 4, 0):
+    raise RuntimeError("Sorry, python 3.4.0 or later is required for this version of bitbake")
 
 
 class BBHandledException(Exception):
-- 
2.6.2


