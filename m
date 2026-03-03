Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E089EDA698
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 16:24:40 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22623.1772555073179593864
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Mar 2026 08:24:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GZwq3O6R;
 spf=pass (domain: gmail.com, ip: 209.85.160.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so666018fac.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Mar 2026 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772555072; x=1773159872; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2eZiaLvfszKz89810WosWWbU4Kdv+s0WNZUWMaBY/4=;
        b=GZwq3O6Rq8+h17jMyEhRrX153P1tP0fwrYqqCe8KDN23Bzhu/SwNjYEHPql+FlbhM5
         dnVhNu6FGXwxEV93gWcnxc/115UhHKDTqUzRA/yU6h7O0pu+ojENhQS4FhMqyIKCBDES
         lH9gEhvugiuwkLZwJPqxRf3fMVjQtp2TFl9UnJXe76NZUUT2Et6JXc2fUAyJD/FMXWMi
         mLE0B9lhDGs1rGSL/o+47PcUYMUFkGxUaILfj4mWU4p/nkcyLS7GhUtBQsYX5l+NkQF4
         GNXapY+iXnMLAShoyDL98ZiwBTW7wut9oTTkQAEcdru8hIjtihQ29cfbFJDK3p7X/QVT
         113w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772555072; x=1773159872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2eZiaLvfszKz89810WosWWbU4Kdv+s0WNZUWMaBY/4=;
        b=NzU6HvIyZQIGvHvIYKqCunMnPD5HqV8twECyZY6Wv/pibEGXEpQ4CwSI/f2ltGVFXG
         1r1ctmccb6VwJc93pR5zt5EAL68o+fy5cmOl8uH2RkN+mjpUHSoz53T8Rf8g81vlOxCg
         b+verzlMa1QOnmzXgGav/TxwKOwnqsKHMuMhvjamfYEhFOjD2Sy9zQ4Nez/RAslQVdUz
         SZPF+JGialMOKDBJNGH6lNppmzr729DVMiSTiCZ0Gpb6PSEvU85ZVH+P36YZlw3xZJgE
         zgQsa6h5XOlRqHsU/uBtCHKqh9ks/hJ5wfU6y9cwSNpr1w7BB/IOXvBoG6LXQriqEb1b
         /Hlg==
X-Gm-Message-State: AOJu0Yz+o1eHpNbQZJ/Uyv7hZn7ApVJ3bHpmR72TIomFYiEMyAc/3wF1
	cgh+61xOYeNx8EIFUhH8qTWgsPlNM23msUnkNjxWXzOILNesuXO75yXZpQOiww==
X-Gm-Gg: ATEYQzyYfDhj4j9qGOVERhyOMFn6kJXb3nUg4+jTS2dRO3+AGl6TbCb8KQXJdfLqRKG
	TEo/jmfkj7Kekve075hjHDtWvZjY1tEHbHROLouAbn9Ou72BIS6wtPgNjOCiEUAnTlVnfSYHeIr
	9M7ZN0Er40WnxwLHPHfkTMDq1hJTAf4p28gbAUat7VjZDwjW9tI1wY2GqBemKsqCXlK5/TI4Hz5
	UZMKWCqmcnfbId4yKZNpUD2r6+FqFNkje+1DqOo7xor/EXRp/0LU9ErNT7WkCg2U9U3YF1WnyOU
	EiGWuHOM4MWoegBSrkj16s/cy/DB75qOUyoaMtHxaEfxJ5DTh3bTcTespYQR4gerG/j7yMucXbD
	tQdMUUcVFuEVQcgVRQKCTqe6CZ+y56zN6oRoBpo4Ot7r+dB7HjC9PGCqiUCu4QYCQtOvxmUtUsD
	EKH+6cZpzr/szd9fipBC41
X-Received: by 2002:a05:6871:c902:b0:404:3569:59ef with SMTP id 586e51a60fabf-416270c5479mr9386591fac.36.1772555072132;
        Tue, 03 Mar 2026 08:24:32 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4200:11c0::865a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41668233c4bsm6266847fac.19.2026.03.03.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:24:31 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-worker: Use Lock from bb.multiprocessing
Date: Tue,  3 Mar 2026 09:24:27 -0700
Message-ID: <20260303162427.938147-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Mar 2026 16:24:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19101

bitbake-worker relies on multiprocessing using the "fork" method to pass
data to the child process. Starting in Python 3.13 the default changed
to "forkserver", so the bb.multiprocessing context needs to be used in
order to preserve the "fork" method.

Note that bb.multiprocessing is a context, so Lock can't be imported
from it; instead a local alias for Lock must be used

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-worker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index d2b146a6a..aa14ef191 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -23,9 +23,10 @@ import queue
 import shlex
 import subprocess
 import fcntl
-from multiprocessing import Lock
 from threading import Thread
 
+Lock = bb.multiprocessing.Lock
+
 # Remove when we have a minimum of python 3.10
 if not hasattr(fcntl, 'F_SETPIPE_SZ'):
     fcntl.F_SETPIPE_SZ = 1031
-- 
2.53.0


