Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
	[209.85.220.66])
	by mail.openembedded.org (Postfix) with ESMTP id 32A93605BA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:43:49 +0000 (UTC)
Received: by mail-pa0-f66.google.com with SMTP id yl2so15275424pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=93qTahe6qZTdU4ATtuW0MfPUOsA/x6f8QUMGfioAKRk=;
	b=cMy+SwsngVq/c5ayCxeAdEG0tDQ51QAcSA514p2n4F79T63//68q/ujDkh/qmvOhyV
	jrIW8SK2s7LtqFQAFnwnPDU3C5EShzwLoiwMUwbCjGLB2k+XEqjn/FNqziGojUiATZ6Z
	KqCPA8py0SYylYSJu3XCwHSGH6X+0mdgznnINQPf0bpWSaBkXlAV/ZAK+l6y4RjNgsE6
	Q86BL3FysBo1hLycXQKjKVEg3Wm3Ha8gbl/zuiYj5SLPTi1FUZcTuUKAIo42RDh5ODZt
	iCLxAI51/BV9rChyF2WMruVvmF7tobAO6qZX1fbt/irSH9jL+hi/0VYIcPC1a+dKChTy
	F0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=93qTahe6qZTdU4ATtuW0MfPUOsA/x6f8QUMGfioAKRk=;
	b=AKCvvw+BTh1R1DL0TKwGKdojWVZwlh5qdiX064sU7MmwB81kupn9Lss7AMfK8ktJtZ
	zvz80G2ZIt4TXeJo3WQ4HiRdzWxyldacaS9yMcBqBNwOWH39SWmgZyAaVo2zNSd36TUF
	SeTGlj9Cw/8be0iBpWhASLQ340TcjrV+Ti9NR4U9JoF96fvTgC86BVPbDJ+q3l6IzyX2
	7Aqq0M8eJZO+UkczzbfkCbncyzwi4mz5utxXHb9TnPtH03HxW2a+tO0Z4J1Lx1OueIRp
	LhpAiah3h3fRFEDE2YSWRfSMRLN4HQvjP0CTF4dWRhaVoLYXyqF6tCHEIps4voKgnYZZ
	vRbQ==
X-Gm-Message-State: AOPr4FX9HfJN3T+HAqofGDQkRyXDhknRzhQDkahSubezHkkhZoymaOuhKQ3slWQh11oFJQ==
X-Received: by 10.66.6.98 with SMTP id z2mr38864382paz.95.1462045430774;
	Sat, 30 Apr 2016 12:43:50 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	v185sm564973pfb.72.2016.04.30.12.43.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:43:49 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:43:30 -0700
Message-Id: <cover.1462040900.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH 0/3] Fixes for PyPy
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
X-List-Received-Date: Sat, 30 Apr 2016 19:43:50 -0000

From: Christopher Larson <chris_larson@mentor.com>

These reduce the dependence upon CPython, allowing bitbake to run under PyPy.
There doesn't seem to be much performance improvement, but still likely
worthwhile.


Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit 309f5907a3661821e041ed14645b5d165007b058:

  bitbake: Switch to post release version (2016-04-29 07:41:34 +0100)

are available in the git repository at:

  https://github.com/kergoth/bitbake pypy-fixup
  https://github.com/kergoth/bitbake/tree/pypy-fixup

Christopher Larson (3):
  bb.build: handle __builtins__ as a module
  bb.event: handle __builtins__ as a module
  bb.data_smart: use iter() for __len__

 lib/bb/build.py      |  9 +++++++--
 lib/bb/data_smart.py |  2 +-
 lib/bb/event.py      | 11 ++++++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.8.0


