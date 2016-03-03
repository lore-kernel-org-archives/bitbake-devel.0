Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 98133731BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 06:41:27 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id 63so814070pfe.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 22:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=FwBS8MvVoBrily7vbZSby8go7BuBbRHlnpX21FCcK0E=;
	b=shakg46P3X7Uq7aKjockIM8PjYSdDknWtLwqtxhxf+ArjHoBzHG7nmht8SQC9IhWw/
	j0J15P62Vet9k9CRQN6uxC2lBplVl80jwcSZlrmtJNRaj4mO1SWiQE5EPGRrKf45NmZn
	97CfNbXo6t/tP3lLq3XjM5Vmggpyr1/kabWUjSAyH3p59UgAR2kR4jsszJjONjmnLP8U
	Vf0b2b95mxOvv1XuY8kFG3mKTqVCR9kjsOacvWRsPgz6lyeCToOfBZ0wzOhqm6bCuszT
	YC0LxndHShwPZmDePHrfsBjdDoh4MMF0SJgpfPixvGyittFVrKAiyPkXbcNjM5zjdhIR
	jCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=FwBS8MvVoBrily7vbZSby8go7BuBbRHlnpX21FCcK0E=;
	b=FczKX/tp7izpAhtFGE+pKvoH/zb6ikX3RBj61IWFpnRalSVeeQ9xTHJqwifuLR986H
	BDjYIWVchVIs8L5dBSI/rkvezG+NIZHNDar+mTXN2qNS7FBctIFEeFICdFrjGM3IBb0q
	RCkJKwXj/o8yfHlJQDZugUeog3S7W+h0gj+J9jR/celbFki6xC32trxjLjHKq8KYNx6t
	ptMsUXwISEV7UfXvSSEBinIAuLHzUK2tEWTlhDl+61ORH4P6EOyzrPFki29gNd0bS909
	X6S1uSkM6d0Ep27CfkDHsVd2FXAxub0Dfk0uaGrwjXyKhhMLV3EHkD4UtGc6rUucFCeK
	LAZg==
X-Gm-Message-State: AD7BkJJmLsi1zVQVpBni3EZfThTV5F6YRjtU962i2xvNFmuL06/VxrJ5e/wIU4BfMqPyqQ==
X-Received: by 10.98.75.8 with SMTP id y8mr1461929pfa.126.1456987288027;
	Wed, 02 Mar 2016 22:41:28 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ud10sm57605085pab.27.2016.03.02.22.41.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 22:41:27 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 22:47:41 -0800
Message-Id: <cover.1456987460.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/7] toaster: allow setEventMask to be called by bitbake observer
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
X-List-Received-Date: Thu, 03 Mar 2016 06:41:28 -0000

This patchset is a preparation for the #7880 fix. This will allow the toasterui to work in build mode, i.e. with
bitbake <target> -u toasterui.

If you want to test this functionality you can do the following:
 - start Toaster
 - kill bitbake server and observer processes
 - unset BBSERVER
 - add INHERIT+="toaster buildhistory" line to conf/local.conf
 - run bitbake <target> -u toasterui

Expected outcome: you should see commandline build in UI without bitbake server
                  and observer running.

Also, I've discovered nasty bug in handling setEventMask by bitbake server while
working on this. It causes ignoring of the event mask set by toasterui. The result
of this is that list of events in _ev_list variable is different from the actual
list of events processed by toasterui.

Upstreamed for Ed,
-bavery

The following changes since commit ffce6a18876c3a0c949eb75f0ce2f9dc36054c83:

  toaster: remove sshbecontroller module (2016-03-02 20:31:08 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/toaster/toasterui-in-build-mode
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/toaster/toasterui-in-build-mode

Ed Bartosh (7):
  toasterui: reformat list of events
  toasterui: update list of events
  command: make setEventMask readonly
  toasterui: check if setEventMask succeeded
  toasterui: make toasterui to work in build mode
  toasterui: exit on final events
  toasterui: fix warning 'Unknown event'

 lib/bb/command.py      |  1 +
 lib/bb/ui/toasterui.py | 90 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 64 insertions(+), 27 deletions(-)

--
1.9.1

