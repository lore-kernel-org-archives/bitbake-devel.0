Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id B049E72397
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:02 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id bs8so16372404wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Oyp+IRd9zSeqVrd3+9/Idf6SnlzNfDSxW9HaIDLixTM=;
	b=XKGiCbObbxVnlJdPDjDaOx9seyYJHIT6ur1u6xKWzQsTJh31l1V+1sF5tL/fCx/BUd
	LCAY/wdSQlIRilcvqiq8cGhszZxjgpn4b0xxBr2KqAIjKPaSj436LjF5ETLSWrLps3cT
	NWFlqrGoPoW7bgJp32+zFQ7wfer+ga92joCr0J+MFfm33KGPcNEceJEDmH3ng9JVzUhm
	1B1qLFg9ux1o7hpZyiJGcUxSytM91j6EP+RdbdXMVM8k61yVBCMleYqUMzBH8SBS6We6
	SuAz0vLNlG7fTEo8S+26pW2mW8QefWYiJhQNC8v34UHFmp5J/ugQEBiVp93TUUGtvSxB
	RdmA==
X-Gm-Message-State: ALoCoQmLbaN1whA/5KTxUYH45IdXJp9wYFicUFVsiV1OTTa9NgmCihK63M4KqtGYj9whfg3bBYl9
X-Received: by 10.180.73.175 with SMTP id m15mr53745071wiv.0.1417108083236;
	Thu, 27 Nov 2014 09:08:03 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id v6sm11498724wjz.40.2014.11.27.09.08.01
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:02 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 67980563B9C; Thu, 27 Nov 2014 17:08:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:59 +0000
Message-Id: <cover.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 00/14] please pull toaster patchset
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:11 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hi,

This is a toaster patchset consisting of new features (New Project page), and bug fixes
in toasterui data gathering, better layer identification, ability to use http_proxy
to fetch data, and other fixes.

This patch has been reviewed on "toaster/master" poky contrib.

Can you please pull at your convenience ?

Cheers,
Alex

The following changes since commit 27023ce2d264ce05008ef9af33982b054c6a87b5:

  toaster: do not show target if target name is empty (2014-11-20 15:43:57 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20141127-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141127-submission-bb

Alexandru DAMIAN (8):
  toaster: use http proxies to fetch data
  toastergui: update layer search criteria
  toastergui: do not show project info in interactive mode
  toaster: display Toaster exceptions and other fixes
  toasterui: fix layer identification for managed builds
  toaster: fix loadconf path calculation
  toastergui: new project page
  toasterui: Compatibility patch for daisy and dizzy

Belen Barros Pena (5):
  toaster: fix errors and warnings display
  toaster: make 'latest builds' section consistent across pages
  toaster: fix padding of build notifications
  toaster: release name consistency
  toaster: remove the word 'project' from layers and machine

Michael Wood (1):
  toaster: base Only show New Build button when there are > 0 projects

 lib/bb/ui/buildinfohelper.py                       |  96 ++++--
 lib/bb/ui/toasterui.py                             |   8 +-
 .../management/commands/checksettings.py           |   8 +
 .../bldcontrol/management/commands/loadconf.py     |  42 +--
 lib/toaster/bldcontrol/tests.py                    |  19 ++
 .../0018_auto__add_field_layer_version_project.py  | 331 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  58 +++-
 lib/toaster/toastergui/static/css/default.css      |   4 +
 lib/toaster/toastergui/static/js/base.js           |  13 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |   7 +
 lib/toaster/toastergui/templates/base.html         |   5 +-
 .../toastergui/templates/builddashboard.html       |  35 +++
 lib/toaster/toastergui/templates/layers.html       |   9 +-
 lib/toaster/toastergui/templates/mrb_section.html  |  25 +-
 lib/toaster/toastergui/templates/newproject.html   | 116 ++++++--
 lib/toaster/toastergui/templates/project.html      |  28 +-
 lib/toaster/toastergui/templatetags/projecttags.py |   8 +
 lib/toaster/toastergui/views.py                    |  70 +++--
 18 files changed, 736 insertions(+), 146 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0018_auto__add_field_layer_version_project.py

-- 
1.9.1


