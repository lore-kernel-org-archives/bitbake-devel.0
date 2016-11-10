Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 3442A60616
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Nov 2016 03:48:56 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id i88so2463008pfk.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Nov 2016 19:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=O7DLjvYW5q0kIpNMD++pZUCGPmXwzCk7h6EyXa94ggc=;
	b=phP7CrgIqX8X5iUNUivksRtS1lWtEZEeDrFiRqnYMBIVhKPYtV7y5zYodkTjq4IuSZ
	NLkxLXsI0Yhoj0iC7e11c4JjHfM4sNF0fycImDOqnJzEtU602f+XpO6Db34x8VndxWy5
	Kjax94pEPyW0zBtcO3DH0dS5TnorZh7scarQ1WXVDdDZRYL8drgJ26k22bJsMbK5Lrea
	+fHBU9kkBWOrdfPO9AgzOY1PR1yKdnFIctviAwPPCS2BFUO9Cq3L53lS2nx0lnrIw2xN
	9EWfqQbVyBigMn6YgiLHe38JlLrYentP3OysyPYdFQD/OxbEYgwYheAQbfkDXxRaGg4M
	VpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=O7DLjvYW5q0kIpNMD++pZUCGPmXwzCk7h6EyXa94ggc=;
	b=NULB7CWJmVzc4JIduwNgRcGs+GtHnW2N6Eutxq5iQVqYNcH9zXtEk5rIpkj8SC6r+f
	pL3NkGsOzFilVNLORhus+8Z9lkcusERfCyN9LosMywO3zfpBG96IdRtJbVHCYXlt/U2Y
	Jc+eVQQCyjuAhY98eoUV6q/kWQzv/R8YtC6JM7X4UzRrhtBtxgFsLFkjGyyV96y+cbjD
	F2znbfijR2IfVm11GYgsqV41/4ZYA6q0ma+NHkVHcSGgow3VAbZYhRSHnM4Gpyq1RUlv
	LI2KQ/xknk71GWOXERdw0ZZ9NVSqQBr7vKmPVmD+nBicK5wflOfUTnkmR2BiiCXVx4Zt
	rMlw==
X-Gm-Message-State: ABUngvfO9/33CRl/F7DY0F5lOMgeaqyjms4Ni8TSSzIZoLhSOLgD3r2WM+WCNiT2agCPKA==
X-Received: by 10.99.161.2 with SMTP id b2mr32561136pgf.5.1478749738340;
	Wed, 09 Nov 2016 19:48:58 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	w15sm2540706pfi.55.2016.11.09.19.48.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Nov 2016 19:48:57 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Nov 2016 19:52:31 -0800
Message-Id: <cover.1478749786.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 0/3] toaster: add master branch back into new project options
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
X-List-Received-Date: Thu, 10 Nov 2016 03:48:57 -0000

This patch adds master to the oe and poky fixtures so that a new project can be
based on morty or the master branch.

It also has an fix for lsupdates to support the layers in fixtures definition.

-Brian
an intel employee

The following changes since commit 065310e77ab4c8c914c53ff43d5e601ebf9468b5:

  toaster: settings set ALLOWED_HOSTS to * in debug mode (2016-11-09 16:28:17 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/toaster/mw-masterproj-11-2016
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/toaster/mw-masterproj-11-2016

Michael Wood (3):
  toaster: settings fixture Set default release to master
  toaster: orm/fixtures Add the master release and correct morty release
  toaster: layerindex updater Take into account layers being predefined

 lib/toaster/orm/fixtures/oe-core.xml             | 23 ++++++-
 lib/toaster/orm/fixtures/poky.xml                | 82 ++++++++++++++++++++++--
 lib/toaster/orm/fixtures/settings.xml            |  2 +-
 lib/toaster/orm/management/commands/lsupdates.py | 60 ++++++-----------
 4 files changed, 116 insertions(+), 51 deletions(-)

--
1.9.1

