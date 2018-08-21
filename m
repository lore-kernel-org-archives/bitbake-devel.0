Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id E01AE79192
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2018 14:05:00 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id y10-v6so15462036ioa.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2018 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=3+Zc6Yu1nD6r8CLtkqCdWpfUgv66oNWBtV1vnoxNmMI=;
	b=dzwAEnFkb5rgejJ7n8U/ppLfs5Fod341eLk3okZthOtLBzlAIUOmDIrTqmP74UEI6Q
	mEqa0sVmUWPrWaFV0K1cRTSLG6DqH9oBjYioFKntZQn9SujhsNjf0dVQpbAJASi0Z8Fb
	hVqSSrsq8mYG7M9aaRMTM7wr5zY7wbYE6TccvDb/GOFzNQxxkZanCWmfDpHzi0C++sQQ
	rQMpsoIscyv4QVzYgaaCv1IKzpJvhSSdHRU9vVyiOr8s2qXI50LmSEONT7A9vVtPuV80
	8XZ/zj/6xEF+YaNfX7Ih6Hgu50JpHURC0UckE7SplP+3ov9BHQN2BbvsZwOgs84q7zLS
	coHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3+Zc6Yu1nD6r8CLtkqCdWpfUgv66oNWBtV1vnoxNmMI=;
	b=uehNh2C2YrFV0KXFlwmSr0/4PU5HTNvlCi1lXxtbmH/X5rmelQkU3T0o/KtwcILjlb
	7R9phIUjU9i1IYf5x3bG7rkA+A9ykO0+AWM29Gj33aX1TqIwkaLge9zBnSVPpwOkYtjw
	NUB6yLNRoy0cE3EIE5VSXaKP3a2Zraj/EdRIch5ZznwS/O14BaVKOrrOuLmy6zU007GL
	pokPBOkCQa/ZWkq+xZZ2J8zyV43K2X/z4aTdIFeEs2d0UNVl3kJdrhefT92dOwEiAjW+
	kUA7DVPZPhrmnIJuqBuA9owQBF9YTGb0m2hC67rp6GBluiYnx5Ebw9lPR0qyV9tiQrrT
	/Erg==
X-Gm-Message-State: APzg51DWvwJ+0CKExD5bROtYIcEe+CUuTQQRbHC36CCoJZB1LR1x3ToP
	C46tVFXp1vlNFGa9/An8vGRCNu+C
X-Google-Smtp-Source: ANB0VdZ2kxvqf21u+GpwX+JEZ+24tbDXSasuccE0tKeLxkJxGuuaY/3D8jEvf8dw81xuiRFa7pKOJg==
X-Received: by 2002:a5e:8f42:: with SMTP id x2-v6mr7123915iop.92.1534860301635;
	Tue, 21 Aug 2018 07:05:01 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	130-v6sm201221ioe.67.2018.08.21.07.05.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 Aug 2018 07:05:01 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2018 09:04:16 -0500
Message-Id: <20180821140416.10764-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] daemonize: Flush stdio on exit
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
X-List-Received-Date: Tue, 21 Aug 2018 14:05:01 -0000

In spite of a comment suggesting otherwise, os._exit() does not flush
buffered output from file descriptors before exiting the process like
os.exit() does. This means that any un-flushed output is lost in the
daemon process, in particular the traceback from any thrown exceptions,
making debugging exceptions in the daemon quite difficult.

The solution is to flush stdout and stderr before exiting.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/daemonize.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/daemonize.py b/bitbake/lib/bb/daemonize.py
index 8300d1d0f0f..bf16793468e 100644
--- a/bitbake/lib/bb/daemonize.py
+++ b/bitbake/lib/bb/daemonize.py
@@ -49,8 +49,8 @@ def createDaemon(function, logfile):
             # exit() or _exit()?
             # _exit is like exit(), but it doesn't call any functions registered
             # with atexit (and on_exit) or any registered signal handlers.  It also
-            # closes any open file descriptors.  Using exit() may cause all stdio
-            # streams to be flushed twice and any temporary files may be unexpectedly
+            # closes any open file descriptors, but doesn't flush any buffered output.
+            # Using exit() may cause all any temporary files to be unexpectedly
             # removed.  It's therefore recommended that child branches of a fork()
             # and the parent branch(es) of a daemon use _exit().
             os._exit(0)
@@ -79,4 +79,9 @@ def createDaemon(function, logfile):
         traceback.print_exc()
     finally:
         bb.event.print_ui_queue()
+        # os._exit() doesn't flush open files like os.exit() does. Manually flush
+        # stdout and stderr so that any logging output will be seen, particularly
+        # exception tracebacks.
+        sys.stdout.flush()
+        sys.stderr.flush()
         os._exit(0)
-- 
2.17.1


