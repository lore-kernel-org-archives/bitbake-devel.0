Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 635BC71B16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 15:15:11 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id m5so96708018ioe.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 07:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=Gq/CYZGt3LADMcJb1wYV76EGh42mmpxYNbN/4pxDYvw=;
	b=ux6ZBzwswVKFGvQMl5dzPcVxmpek8bNlITN2JKYsmGWk/5fsCqU1jHgWj4xsrRvmzt
	dRdIcljugbTjECJeCtg//ER85EL+abru836W1/+OIPUdwD8q/XBz4Sw1TjOfa6grDREk
	ao8lS26N3kp7FGujLHXvfJQtwANlmsoC5/uo5PWVLKE3hBJNEfcIjK9iWo6/OYImlFmA
	v6SLboYX/GI7srScFI4Uy+HNwqr/peoWQuPDnD7OR3B9MryCK3dp0pDErjaBjSwS0VF+
	+YTDwzZsZNCi5bh5uBGvyj5KEFfcehsMPUpYTVcOsx0pJN9uYtffq71Hf+n9l2bGNgl+
	xxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Gq/CYZGt3LADMcJb1wYV76EGh42mmpxYNbN/4pxDYvw=;
	b=IenkHjdsHX5NuvQe4yNVKKpMkIIeuXgsYeV+I3Xj4QS1cBwmCmDRos1GqITDPBNJP0
	pQM74MoovKAzm3UR3J3Ejstg8CamcTPe05G3iy5zFs7W7GDXgBMJwTOV5+I3ZvtTkxtl
	nI+1h2TfBrJHc7iBN+dwfjyljvmjSY/D1MGSw1e9aXEESdyoQ0KaSjJeFiiDlXUzgfua
	hh30SJEWqYmwhZZ3QKKlMLfPH8RFWGznAuEvmZTWz4/hqIvKcRMb2fCb+HI7ewut/3OP
	xlFAM5TtHA7JkOY7Ow+e9pwnqgCmIbe/IELh9pQBZanfrB+ehSxIHqdTGjKr80trYn6n
	Cy7g==
X-Gm-Message-State: AKaTC03otq+iMQIhq/tBsGBHul+ZSVlLbGfVp+vKXZcI/Q3gvpK4iEauTr4issEyWnBK3xXq
X-Received: by 10.107.19.29 with SMTP id b29mr17401267ioj.219.1480346113323;
	Mon, 28 Nov 2016 07:15:13 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8C83A.dip0.t-ipconnect.de.
	[93.232.200.58])
	by smtp.gmail.com with ESMTPSA id p2sm9297000itg.5.2016.11.28.07.15.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Nov 2016 07:15:12 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2016 16:15:05 +0100
Message-Id: <cover.1480345719.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/4] system statistics sampling
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
X-List-Received-Date: Mon, 28 Nov 2016 15:15:13 -0000

These patches are a precondition for the corresponding patches to
OE-core. See https://bugzilla.yoctoproject.org/show_bug.cgi?id=10583

The original motivation for the heartbeat event was the system
statistics sampling, but it also turned out to be useful for
monitoring disks more deterministically. That improvement is also
included here and shows that the heartbeat mechanism is useful also
without the OE-core patches.

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
 lib/bb/runqueue.py       |  8 +++++---
 lib/bb/server/process.py | 25 +++++++++++++++++++++++++
 lib/bb/ui/knotty.py      |  1 +
 lib/bb/ui/toasterui.py   |  3 +++
 6 files changed, 75 insertions(+), 12 deletions(-)

-- 
2.1.4


