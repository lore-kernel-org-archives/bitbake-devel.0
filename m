Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id AE2A56013D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 10:58:39 +0000 (UTC)
Received: by wgic8 with SMTP id c8so97763806wgi.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 03:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=1fOUE4aVqN8nd6CEV3kf8Zzc0bCZE0+bgKZ/QlFtPVY=;
	b=I6/OCumIGSVBujQkPnuF+Fife8hq4PgTTme2fM6/3XZEO8XxSRjuhnFM6TQ9uir8Je
	LkMIE3QL6m+pntKpJMRHpRGzw0KIF3iFu0qd+3HjBjjA3UqOqzioXhSkBX2amty1zgtF
	iJDc+SVjkc8NlZf8Vr4g8NkNfEK/o2+ZJIZq8B9BvEZm9ScUqzIR0W1F1f7hQokmHGzs
	3YHUo2/pA0lCLalgdOo8x1qHc257Hc+/BdFcrEFw9K+x67uLTXFfvFWT3JptCN64GfR+
	i7kxc5DDC/XQ3QRY9PqZk31wPdKK7lt0ut9PD8i17FOISjWZ5ACmWu718GOl7qnLZboT
	ufgw==
X-Gm-Message-State: ALoCoQk1o1QwyskeYrc/yP3RCWhWyl0R4tuGL6TSdD2KhyYh1XkmaLfEEfeLYsJ7D+m19A9IaVWU
X-Received: by 10.194.122.200 with SMTP id lu8mr18976295wjb.30.1431341919509; 
	Mon, 11 May 2015 03:58:39 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fm8sm12718899wib.9.2015.05.11.03.58.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 03:58:38 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0E0745601A3; Mon, 11 May 2015 11:58:39 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:37 +0100
Message-Id: <cover.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/11] Toaster patchset
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
X-List-Received-Date: Mon, 11 May 2015 10:58:43 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This a bug fixing patchset that cleans up the code and fixes some legacy issues,
partially refactors the URL structure for a cleaner appliance of REST principles,
and enables the code to passes tests under TTS.

Can you please pull at your convenience ?

Thank you,
Alex

The following changes since commit 3e12f4e8e3ec66d1df772a64be04b90ec72462ae:

  prserv: serv.py: remove unused and duplicate imports (2015-05-08 17:46:25 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150511-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150511-submission-bb

Alexander Kanevskiy (1):
  toaster: clear up toaster shutdown for mac osx

Alexandru DAMIAN (4):
  toasterui: URL refactoring
  toaster: adding art missing from Bootstrap
  toastergui: fix whitespace after URL
  toastergui: removing unused views

Ed Bartosh (5):
  toastergui: decrease load time for configuration page
  toaster: Make toaster script working in zsh
  toaster: Code cleanup: indent
  toaster: fix typo in format string
  toastergui: Consider task name when restarting a build

Mihail Stanciu (1):
  toaster: <Add class id to a few columns>

 bin/toaster                                        | 149 +++++++++---------
 lib/toaster/orm/models.py                          |   2 +-
 .../static/img/glyphicons-halflings-white.png      | Bin 0 -> 8777 bytes
 .../toastergui/static/img/glyphicons-halflings.png | Bin 0 -> 12799 bytes
 lib/toaster/toastergui/static/js/projectapp.js     |   2 +-
 .../toastergui/templates/basetable_top_layers.html |   2 +-
 lib/toaster/toastergui/templates/bpackage.html     |   4 +-
 lib/toaster/toastergui/templates/importlayer.html  |   2 +-
 lib/toaster/toastergui/templates/layer.html        |  34 -----
 lib/toaster/toastergui/templates/layerdetails.html |   8 +-
 lib/toaster/toastergui/templates/layers.html       |  14 +-
 lib/toaster/toastergui/templates/machines.html     |   4 +-
 lib/toaster/toastergui/templates/package.html      |  36 -----
 lib/toaster/toastergui/templates/project.html      |  24 +--
 lib/toaster/toastergui/templates/recipes.html      |   8 +-
 lib/toaster/toastergui/templates/targets.html      |   6 +-
 lib/toaster/toastergui/templates/tasks.html        |   8 +-
 lib/toaster/toastergui/urls.py                     |  26 ++--
 lib/toaster/toastergui/views.py                    | 169 ++++++---------------
 19 files changed, 177 insertions(+), 321 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/img/glyphicons-halflings-white.png
 create mode 100644 lib/toaster/toastergui/static/img/glyphicons-halflings.png
 delete mode 100644 lib/toaster/toastergui/templates/layer.html
 delete mode 100644 lib/toaster/toastergui/templates/package.html

-- 
1.9.1


