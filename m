Return-Path: <alexandru.damian@intel.com>
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com
	[209.85.192.48])
	by mail.openembedded.org (Postfix) with ESMTP id DE8AF7169F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jan 2015 00:28:45 +0000 (UTC)
Received: by mail-qg0-f48.google.com with SMTP id j5so5748742qga.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 Jan 2015 16:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=wTpLp3Fu33FCdczMsTshWgqgvax8AxBdRgfwg8fiPcg=;
	b=i+D43lKyQeS6LZU84sjAakKbtpQxeyBJ9ilTi+ILr1tDgKj5UsnI7H4YuNyEFLZks4
	rKD4VosKaugHDdZQnOUu07m5OkM912vJfiq3Fkxl4bKrZcXrYADGMmQs9nQSpFYY/kcK
	9woLsKzAR1I3A4JZvqq22eo9anO1ZQ9YLsjeEVVF/cg0imYJFF8AvULEiRiBUrDACs2g
	b+tQpf2LXiYEa7Kc1c/x+ni5ntCg4c+JkoGv7cCbBSUs5ssyLihq06qhgTskr4SCnxpF
	z3PLCueIUIMKlDxNbo+Q7N/fnzqRVBeAeYhSMwwYqHxwCtZ7wIfLyN7CBfukn+ATJtye
	qoIw==
X-Gm-Message-State: ALoCoQlqwvTXL3aBa4sjK1B1aO/SZUhv5vN0e1lelscLWqNvkEKX5urYFmByOfiXariSLnOaskH2
X-Received: by 10.224.169.16 with SMTP id w16mr10172597qay.102.1420763326380; 
	Thu, 08 Jan 2015 16:28:46 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id p49sm5506163qgp.30.2015.01.08.16.28.45
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 Jan 2015 16:28:45 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 285D65622D2; Thu,  8 Jan 2015 13:15:11 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Jan 2015 13:15:09 +0000
Message-Id: <cover.1420722767.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/5] Toaster patchset pull request
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
X-List-Received-Date: Fri, 09 Jan 2015 00:28:49 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hi,

This is a toaster patchset with patches that have been reviewed on the toaster mailing list.

It contains bugfixes and new features in the frontend Web interface.

Can you please pull at your convenience ?

Cheers,
Alex

The following changes since commit 86704281b79e524dccccc88cbf996b299b33bae2:

  ast: Add error when trying to use dash in sh function names (2015-01-08 10:37:06 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150108-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150108-submission-bb

Alexandru DAMIAN (4):
  toaster: write pre-read conf file for build variables
  toaster: do not launch web browser on noweb option
  toaster: branch name priority resolution
  toaster: implementation of project page

Michael Wood (1):
  toaster: Improve client side error handling

 bin/toaster                                        |  13 +-
 lib/toaster/bldcontrol/bbcontroller.py             |   5 +
 .../bldcontrol/management/commands/runbuilds.py    |   5 +-
 lib/toaster/orm/models.py                          |   9 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  39 +++-
 lib/toaster/toastergui/static/js/projectapp.js     | 242 +++++++++++++++------
 lib/toaster/toastergui/templates/base.html         |   5 +
 lib/toaster/toastergui/templates/layers.html       |   8 +-
 lib/toaster/toastergui/templates/mrb_section.html  |   8 +-
 lib/toaster/toastergui/templates/project.html      |  50 +++--
 lib/toaster/toastergui/templates/targets.html      |   8 +-
 lib/toaster/toastergui/views.py                    | 103 ++++-----
 12 files changed, 329 insertions(+), 166 deletions(-)

-- 
1.9.1

