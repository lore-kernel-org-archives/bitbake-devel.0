Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
	[209.85.216.68])
	by mail.openembedded.org (Postfix) with ESMTP id 6C0037F67E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:26 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id a10so5581108pju.10
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=tkMABYnkFIwWY0E+PaUNJFEMofxe+kofEknqra4S7CE=;
	b=UUgYN4AvU1zecJuc1T1zqUbO2NRwB80CGgDGNzKKh6o2c9yL2GywCdy2R4WVf5S3/b
	/0cD0fTL3OJlzmWRHPpWWcV1WM3zdA3LMn+kwUllaNQ3lv0L3n23t7VEg3wtSHLn1kJg
	r7EMo8IBW4haCwsMTHYnkkuqHKV32xyDu5mXef500wPchzbwJIHcFYomabenv2bHaTVW
	zCfgM9Y39dRmk7HBaP0Cz77iE20o6MNjfIIWV0n80cc7+A7QXYvRygX+AkXdGW3KycMh
	cRGvYukWoeZ1NDUPJbHFD91/mpof3LTvtkAsDkLYOXsRaiBdcAAkPxm2GcwBGX8I5SR7
	/MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=tkMABYnkFIwWY0E+PaUNJFEMofxe+kofEknqra4S7CE=;
	b=LlId8wOF6fE4SFa8c/3MRtihiJYM9Buy7LiekbIp5yYkQYeMNsusdAJNtPPmgiw4OH
	VAfTGUjGS3HWP45tzxXY+TXkDNthCQsaoWL80IXdggZNStdJDmJrfcWPp/y+z0/BGkMm
	yOT1oMw4O+VFns/AjKAaxJKu+pGa8bAFSTFy4W+Pbb9oJL4HUha+/8YnYZIndT32AsWR
	QWN/7u2eXHUTeNT9WHmn7uF6ULvciszUKfI3odAT14B4iyIlDVKuxJJKYhNa++aFsGEv
	CCqryaYXwHuCcteo42izFQuSKlkdYXcWNf4INaEbXjLEk1x+6pXN7m5xVbKSnzqWfEOz
	Z91g==
X-Gm-Message-State: APjAAAV2y2n3VK83mfthYsyII1M6P+3ZyJjSYfRBw3V3559V5EwIj3s/
	b4Ana95eBBa3JI3zxpTItYgCScC4
X-Google-Smtp-Source: APXvYqz8Wn4ix5dvX3W2HE/DyNLhTeSzQmLmlx0R4wzUJ7ZRztQhVWhFvdqZBV1j/OsAxDMIt65kiQ==
X-Received: by 2002:a17:90a:1db:: with SMTP id
	27mr35653273pjd.57.1574639007316; 
	Sun, 24 Nov 2019 15:43:27 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:26 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:13 -0800
Message-Id: <cover.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/9] 1.44 merge request
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:26 -0000

Clean A-full build.

Please merge these chages to 1.44

The following changes since commit 1a79651c518abc35b99005c137ab7e82a99c75b0:

  fetch2: Ensure cached url data is matched to a datastore (2019-11-13 21:59:58 +0000)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.44-next

Christopher Larson (2):
  fetch2/git: fetch shallow revs when needed
  tests/fetch: add test for fetching shallow revs

Gavin Li (1):
  prserv: fix ResourceWarning due to unclosed socket

Peter Kjellerstedt (1):
  cooker: Remove a left-over comment about expanded_data

Richard Purdie (2):
  fetch2/clearcase: Fix warnings from python 3.8
  runqueue: Fix hash equivalence duplicate tasks running

Ross Burton (2):
  tests: add test for the hashing functions
  utils: also use mmap for SHA256 and SHA1, for performance

Volker Vogelhuber (1):
  fetch2/hg: Fix various runtime issues

 lib/bb/cooker.py           |  4 ----
 lib/bb/fetch2/clearcase.py |  6 +++---
 lib/bb/fetch2/git.py       | 23 ++++++++++++++++-------
 lib/bb/fetch2/hg.py        | 27 +++++++++++++++++----------
 lib/bb/runqueue.py         | 14 ++++++++++----
 lib/bb/tests/fetch.py      | 20 ++++++++++++++++++++
 lib/bb/tests/utils.py      | 26 ++++++++++++++++++++++++++
 lib/bb/utils.py            | 34 ++++++++++++++--------------------
 lib/prserv/serv.py         |  1 +
 9 files changed, 107 insertions(+), 48 deletions(-)

-- 
2.7.4


