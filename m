Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id 5E5306003C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 16:47:59 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id m5so161496009ioe.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=uU5kc8eugZ+G5YJvJo1+G7KBjkErityhLg3fi6IQrTs=;
	b=DrOhVtGA/7L67VZKqc3QH6vCPN/sMxwGLJ7M7H1Ah0oLmF7HuCfIZYu8pVw+OHLE8c
	FKTL6oD5G859W7ya/W1LzYqjZWvEhGBtLO+v4bsABrxnJE5PAvVBgKihmZoNxWuVW7Tp
	kSJoDWPtdxb1fSqFV4SOwk63TXEMiHD6xOuCbpHxOzdy5ZLp8XQ+uLgdQ4Y6RFnlGPQC
	DUoOBAmyGH3CvqeIn0kDZuNuSsrnasy2fKtE/8+MsJ9cfDL67Qp0NYTVdMtPSMT12Lfj
	5289tiwG/H13qG3sqqMCR2OGhVUhqstwzxQwvF9OXHNMLWfCt4n7xxaLrA9+M+/3LmiU
	6eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=uU5kc8eugZ+G5YJvJo1+G7KBjkErityhLg3fi6IQrTs=;
	b=Xrv9TIeSzaeb3yo1dCEW7AlJGTdHGgM50CYByjFaL04AaBEcFUwaX1T606zeae7Diq
	yopSwkVJRybgAouPSY9Qm0yd55Gs//YHRKJ1zM7RwJAiIgzXDPpnEFYfP/i1mPcHEde7
	iCVIReWLmGpTdvinY81ec1BVoeO9pXcaAu0Ec+KsgEvZ070CdKsZooglIlecdgaShEPV
	5BUvyQ4neoE/A2+zHidPLxmjRpvVd6b/HOih3xaqgqPNZo5RrXU7g/xacuthUS6BG4OC
	gJkn+tP27aqwsy0PlL9p4dzGAkAFO6d/yjwRuBGv4qBbbY8x6VAQWcxuEYTyP6GdaIgC
	ZdiQ==
X-Gm-Message-State: AKaTC01Tfb/7k8eeJg4nApxKS5q1CDVrxvdf2ZrxspQ+S2oU8BHR3jGzC/gpZTSGv0S6kE5x
X-Received: by 10.107.58.195 with SMTP id h186mr24809750ioa.117.1480438080419; 
	Tue, 29 Nov 2016 08:48:00 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8EEDB.dip0.t-ipconnect.de.
	[93.232.238.219])
	by smtp.gmail.com with ESMTPSA id l79sm1119425itb.1.2016.11.29.08.47.58
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 29 Nov 2016 08:47:58 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Nov 2016 17:47:41 +0100
Message-Id: <cover.1480437099.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH V2 0/4] system statistics sampling
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
X-List-Received-Date: Tue, 29 Nov 2016 16:48:01 -0000

These patches are a precondition for the corresponding patches to
OE-core. See https://bugzilla.yoctoproject.org/show_bug.cgi?id=10583

The original motivation for the heartbeat event was the system
statistics sampling, but it also turned out to be useful for
monitoring disks more deterministically. That improvement is also
included here and shows that the heartbeat mechanism is useful also
without the OE-core patches.

These changes work when using the normal, non-memory-resident bitbake.
When testing with memres bitbake, the bb.warn() output about invalid
BB_HEARTBEAT_EVENT was not visible (neither console nor log file) and
events also didn't seem to get triggered. This needs further analysis
once memres is ready. Tracked as YOCTO #10741.

Changes in V2:
  "runqueue.py: monitor disk space at regular time intervals" was changed
  so that it registers and unregisters the event handler during the build.

The following changes since commit d140f0ee6f301264e226914766d9f63558acfd6c:

  COW.py: fix sample codes (2016-11-23 10:59:49 +0000)

are available in the git repository at:

  git://github.com/pohly/bitbake heartbeat
  https://github.com/pohly/bitbake/tree/heartbeat

Patrick Ohly (4):
  cooker process: fire heartbeat event at regular time intervals
  runqueue.py: monitor disk space at regular time intervals
  monitordisk.py: minor code and comment cleanup
  monitordisk: add event

 lib/bb/event.py          | 27 +++++++++++++++++++++++++++
 lib/bb/monitordisk.py    | 23 ++++++++++++++---------
 lib/bb/runqueue.py       | 24 +++++++++++++++++++-----
 lib/bb/server/process.py | 25 +++++++++++++++++++++++++
 lib/bb/ui/knotty.py      |  1 +
 lib/bb/ui/toasterui.py   |  3 +++
 6 files changed, 89 insertions(+), 14 deletions(-)

-- 
2.1.4


