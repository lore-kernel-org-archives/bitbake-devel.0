Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 54D6265D76
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 14:28:30 +0000 (UTC)
Received: by mail-pa0-f42.google.com with SMTP id bj1so53043256pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 06:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=YY7fNkWS/PGrKt5JRrIwqHgP4j88sDTUXuObFfspZcw=;
	b=dbs46Ytwl65BOtCDMyuPuNYHaBCVwsywn7vBDF41uBWMFDv6nGr/EgjrcJnDZb+lEd
	A+GC2S81pv+fGhCMfIg7jZokczXSovuZrSWbi+XLnfkXDXNtd+xH7txKaVpbf7IK+F1D
	EKDXir7u8lz1DM28ghLzdMA8ZVQDHRWjMKxOfeGRYVAVZ5Zk1bQKrBKrabSKr0LSSLRY
	/DpC6//wiUP4ugXIP5xu8TXJ7DU2ebiOtN++1k9bzGTvrB9Dodxz/BXKTHqPDkyNESGX
	emzg/DOYlC7A0FWvXifH9Yi5JjebDHNCan8xT1i4J4te3WfV4R70Sk0bY9NV2MsaFDLY
	AJOw==
X-Gm-Message-State: ALoCoQnF+nkU4B8pT7qRmcfF9iLTLnchleaifj8ROKo5iFtKbl0MTUabxBTDQK//O71kNTZ8un3S
X-Received: by 10.66.236.1 with SMTP id uq1mr8999430pac.55.1422628111797;
	Fri, 30 Jan 2015 06:28:31 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	vk4sm10951460pbc.74.2015.01.30.06.28.30
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 30 Jan 2015 06:28:31 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 972C4561796; Fri, 30 Jan 2015 14:28:28 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Jan 2015 14:28:27 +0000
Message-Id: <cover.1422627985.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/2] Toaster patchset
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
X-List-Received-Date: Fri, 30 Jan 2015 14:28:35 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hi,

This is a small patchset for toaster for fixing the startup sequence, and some build issues.

It has been reviewed on toaster mailing list, can you please pull when you can ?

Cheers,
Alex

The following changes since commit 9facf3604759b00e8fe99f929353d46f8b8ba5cb:

  data_smart: Don't use mutable objects as default args (2015-01-29 22:10:53 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150130-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150130-submission-bb

Alexandru DAMIAN (2):
  toaster: update texts for the startup sequence
  toaster: new layer checkout logic

 bin/toaster                                        |   6 +-
 lib/toaster/bldcontrol/bbcontroller.py             |  13 ++-
 lib/toaster/bldcontrol/localhostbecontroller.py    | 107 +++++++++++++++------
 .../management/commands/checksettings.py           |  21 ++--
 .../bldcontrol/management/commands/loadconf.py     |   2 +-
 .../bldcontrol/management/commands/runbuilds.py    |   7 +-
 lib/toaster/bldcontrol/sshbecontroller.py          |  58 +----------
 7 files changed, 110 insertions(+), 104 deletions(-)

-- 
1.9.1


