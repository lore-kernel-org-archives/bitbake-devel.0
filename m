Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 92280609BE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:14 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id u57so7000060wes.18
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=yvPZ0vL4COqXro/WgNZwBgf5Nxqe4VTNEPdtpw73gkw=;
	b=I3hQJycM77wst7Ld3nhQm5bH8ZPj+W9hW14sifBi/3Qoat0tSeZrMsUBMnx46LgENu
	tG5wMbI471NlQFmFZjH18r6v7GvQHhhQM8/fFWY6o7jnIKAuMlv/dmZAG8trEEF4//FS
	nz6DhyR1j9AaENh/6BG0g0V8KqXrfenkS2MJW3Vk7UBB8e0K20Kj52Srr8DGIR4msq29
	xQQygRtDwKOKa10HKeqOZUkfPQVUkRTkNlug2xZcGp2gDmyZEMK9rO9b9wA9xKqEh8aP
	tjZRjuVwKVN8SqgVlLU9t7Htt7b1+RbIWcgtOR9eQq5x/TRrrKgmqDSAKjlXBUPjbFtS
	VGIQ==
X-Gm-Message-State: ALoCoQlnJ6FhARcRYJo/5F5RI/ZNCBXcCcCQMU1S4+x11udgLp+8MtWtB/oXIjndu0Vu8/ouaeQY
X-Received: by 10.180.20.210 with SMTP id p18mr33545977wie.8.1401809173551;
	Tue, 03 Jun 2014 08:26:13 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ek4sm3753614wib.9.2014.06.03.08.26.12
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:12 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8C706560496; Tue,  3 Jun 2014 16:26:14 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:13 +0100
Message-Id: <cover.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/9] toaster build functionality - preparatory patches
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a set of patches that bring punctual fixes, in preparation for deploying 
Toaster build functionality. They are mainly focused on making bitbake and toaster a bit
more resilient on starting and stopping programatically, under the control 
of a program, and preparing data models for controlling a build.

The patches have been reviewed on the toaster list.

Can you please pull ?

Cheers,
Alex

The following changes since commit 18f9bcbad059608e22fca20309314e1c399acec7:

  siggen: Print warning about tainted tasks (2014-06-01 14:26:51 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140503-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140503-submission-bb

Alexandru DAMIAN (9):
  bitbake: move configuration reading code
  xmlrpc: client - remove fatal errors
  uievent: retry on handler registration failure
  toaster: read database settings from the environment
  toaster: startup script noweb mode
  toaster: startup script standalone mode
  toaster: update toaster to run in managed mode
  toaster: add project related models
  toasterui: fix django settings environment value

 bin/bitbake                         | 60 +++++++++++++++++++++++++------------
 bin/toaster                         | 58 ++++++++++++++++++++++++++++++-----
 lib/bb/server/xmlrpc.py             | 46 ++++++++++------------------
 lib/bb/ui/buildinfohelper.py        |  2 +-
 lib/bb/ui/toasterui.py              | 16 +++++++---
 lib/bb/ui/uievent.py                | 23 ++++++++++++--
 lib/toaster/orm/models.py           | 19 ++++++++++++
 lib/toaster/toastermain/settings.py | 35 +++++++++++++++++++++-
 8 files changed, 193 insertions(+), 66 deletions(-)

-- 
1.9.1


