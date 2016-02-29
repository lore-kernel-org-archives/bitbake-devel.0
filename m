Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id D33CF731F0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 18:43:36 +0000 (UTC)
Received: by mail-pa0-f46.google.com with SMTP id fl4so96363262pad.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=qK/ua6ho0dsELGPV87Q1epMgpR1Y/8sUy/lKgx/JrSI=;
	b=MZkCMgLf+d/C/YJFBI9Nx52Za/qe+qco9m47mZKoVw5a2eMcLoby7NnWZ7xoTCwWxO
	Y01tn+YAF+uDm3X8ZC/IBYa/5ejEmS16eh/4pU3S45abZ24g5jUpawvhjcjBXoiOECIE
	QS5i3m1cBOaRJTTGSdguSxZ7fLoHtzc9NgiFVD91aFnnlW1faoScpaC5AenhdhFOp31q
	i3eEOTnUjpzwcyQtTptFKZFt4z3haYo3b+rojEcq2duL0StY/iRpKUqqHKm3z2KI2Mzk
	2/NY3EuP9H0DKsMSZQLm4MUgdXeiACE7vG7EJrfhzGzy8PhBIO8phaKsdxUDyFIrsPeq
	lCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qK/ua6ho0dsELGPV87Q1epMgpR1Y/8sUy/lKgx/JrSI=;
	b=P+tdnZfHl7G1O82ITyRfbYkXQrPAk59aJ7fH6oIAKTJ6g5TjA90E6J1+4f83QZPbgN
	EwCo0hEwLrrU9PNUYFN5LoYvRAsxNy2gv5CZ7kt5ROstSFCpyZoJ792yPSRFj/h81XDD
	13yv7glGX3LVWxkjIu633qL03YBH5YPUbUMvxwdJj7KGHauM+Nq9iOhsjlcp8r6Lx3W4
	3FhEY72S0IzCFLXvjkjM6kdqh696YvNcb0g6S4XEUhyTPEV+GKcmNdsnqSJrGhgDrl64
	SCZw9R0mz5bVJmBXoefMk3g2sXZmprIrch3Wb4/2VE3fA6mldwDVt4xmohN79UxDa9yB
	jYFQ==
X-Gm-Message-State: AD7BkJL/8wuTpBcEvZk3hHks+ap8ZXSRx1+Fm0K7a0CRw24zXRoiKwccpAVToHT6ceZAFw==
X-Received: by 10.66.155.232 with SMTP id vz8mr24275966pab.53.1456771417015;
	Mon, 29 Feb 2016 10:43:37 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	y68sm39806530pfi.6.2016.02.29.10.43.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 29 Feb 2016 10:43:36 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Feb 2016 10:49:46 -0800
Message-Id: <cover.1456771684.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] bitbake: Remove puccho ui
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
X-List-Received-Date: Mon, 29 Feb 2016 18:43:37 -0000

The puccho ui is currently broken and hasn't been touched in
several years. Given it's lack of care and feeding it seems
best to remove it.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=9178

-bavery

The following changes since commit 4006a7f2762ccd5dcbc6cdff49482d4387a73261:

  sanity: Fix int verses string reference (2016-02-28 22:54:09 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/bitbake/removePuccho
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/bitbake/removePuccho

brian avery (1):
  ui: remove the puccho ui

 lib/bb/ui/crumbs/buildmanager.py | 455 ---------------------------------------
 lib/bb/ui/puccho.py              | 425 ------------------------------------
 2 files changed, 880 deletions(-)
 delete mode 100644 bitbake/lib/bb/ui/crumbs/buildmanager.py
 delete mode 100644 bitbake/lib/bb/ui/puccho.py

--
1.9.1

