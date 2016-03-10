Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id CB766601F6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 13:58:06 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id l68so31555792wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=nPdvz14DztgjQbc+J4vIVJzhe/D0Yvhc2GKAB7B+WXE=;
	b=mKwIhsAx15GmNAB7mw2f94q2CKi76jznQjdajkdY5G1/SrKtgwii3seM4dtgyLfdWl
	4Y3DECVZ+3hsbM/BTvC9mPwC4jC4QP5XGJy32iZlHVZGGOEcMgCCIvORPkFKZ4ebAZcX
	LLUbK1xrBeBn8HFuLbqy9/qFk5C8qiAE//caQ0CVN7w0YAVKj1U/9QdzKvGV9dbJ434M
	X+4H103f9W0pu7XqMaFl8K4evZiWQnCqrBmJFGhcee7K4rvhgkr2cZpOFzs79uAttKyo
	JIN1KIZI0ZasJTa8QrsXChX7osKnvNgGFyD92B5jeim+Cusb2VCGpEGTuaUS7YssJvWA
	Qm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=nPdvz14DztgjQbc+J4vIVJzhe/D0Yvhc2GKAB7B+WXE=;
	b=UFsqHGTgmgzTCgtKrEZYBxJbDwOdRmelf65iJRD4oW6NSQds++qal5LnVq8Csr7+iZ
	5l4r2jOmXvfp6qwlkiGDA++FsOF2pi5r0Pl25IqOs/1df/BhMI+8Q53qDcgfyvnGkuz1
	fMaI0RWu9M8whgS2doCdQ39UmIBm6M4oufpvKv60pmVP96LoivM4k++PCiwEjIbfMPWg
	lmV9sYIBYtzUb9yts2Uzw3cWqBbj2SbP5sdOM6QPsBtt8C9onyTdepO2aF7TC792d8qw
	khjUbMaB8Kty1sy48rjK5BovUT57IJcDZOYEJwbztwEQ9YhB6NnDcxE0o+63keiefiTu
	gg2A==
X-Gm-Message-State: AD7BkJImNaiTZ4B1hJLQXugpb8K478Bhvju4t7m+QSQlKtzSWvhOnX4x0ZjDdmNa27TSUr1U
X-Received: by 10.28.228.137 with SMTP id b131mr4035809wmh.16.1457618287225;
	Thu, 10 Mar 2016 05:58:07 -0800 (PST)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	c128sm3677424wma.11.2016.03.10.05.58.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Mar 2016 05:58:06 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Mar 2016 13:57:54 +0000
Message-Id: <1457618275-7801-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] Create Build object earlier in bitbake processing
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
X-List-Received-Date: Thu, 10 Mar 2016 13:58:09 -0000

Patch from Elliot for capturing early build failure errors

""
To capture command-line build failures earlier, add an additional event to
the bitbake XMLRPC server which fires just before the buildTargets command
is run. This event contains the target and task information required by
Toaster for annotating a build so that it displays correctly in the "recent
builds" page fragment. Toaster can then capture builds which fail very early
in the build process (e.g. due to bitbake misconfiguration or bad targets) and
display them intelligibly.

Note that you may get an error like this when running a build on this branch:

WARNING: Unknown event: <bb.event.ParseStarted object at 0x29f2950>

This should be resolved later by Ed's patches (awaiting review) which fix how
Toaster uses the event mask.

To test, try the following on the command line:

1. Set an invalid MACHINE in conf/toaster.conf and do a build of a valid target, e.g. bitbake zlib.
2. Set an invalid DISTRO in conf/toaster.conf and do a build of a valid target, e.g. bitbake zlib.
3. Try to build an invalid target, e.g. bitbake zzz.

In all cases, the "all builds" pages should show the failed command line build.
Note that the fixes for bug 8443 (which I will submit once these patches
are in toaster-next) will improve how we display such early failed builds.

Related bug: https://bugzilla.yoctoproject.org/show_bug.cgi?id=8440
""

Elliot Smith (1):
  toaster: create Build object earlier in bitbake processing

 lib/bb/event.py                                    |  7 +++
 lib/bb/server/xmlrpc.py                            |  3 +
 lib/bb/ui/buildinfohelper.py                       | 73 ++++++++++------------
 lib/bb/ui/toasterui.py                             | 17 ++---
 .../orm/migrations/0006_remove_build_build_name.py | 18 ++++++
 lib/toaster/orm/models.py                          |  1 -
 .../fixtures/toastergui-unittest-data.xml          |  4 --
 7 files changed, 71 insertions(+), 52 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0006_remove_build_build_name.py

-- 
2.1.4


