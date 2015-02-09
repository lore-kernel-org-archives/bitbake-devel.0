Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 3FB456E6C2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:01:56 +0000 (UTC)
Received: by mail-pa0-f42.google.com with SMTP id bj1so35361994pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ldV1rZvumkYliVpZ7l9yoI8Q8nRNHMl+NRtQZ83SMYY=;
	b=PLdgeB/NqWrfxIqszYQBrw4A755J1HmV2SkFqpXUYRYjB72mhVR19qlZlg+k64ZvZM
	4ia0B+37xKO4CP4RF9AovXuv1HZ+RFgS8gcU439ANj5oEF9ayQGqtb+C0t3eSX7QCbH7
	/a29RBOtkr9LIpRp01qWiOyKChgGTmbfGVsvgC6PLteNI3ytBD+ZOnz3viDHg/eu7GrT
	wTskvjxPn0ypexBeREVVPXwnvKosdNuXY3rWfkWe0G4N2xqkgYaQXj/0AbF6+TTkJqKJ
	wsjgQ/qfZLmHcJ/ANMIr6AwzMppUGmCMikX6goX5BRxPH3Moe6jdSv+OcP+2Jz58H0og
	UUDQ==
X-Gm-Message-State: ALoCoQn/PmqqUKfx4f665W7oBIGtTbod4kvthT/qQgZNkN/gPBSGlB4qZIGZWp+A8HxYf/+B/uAt
X-Received: by 10.69.16.99 with SMTP id fv3mr30692364pbd.98.1423504918152;
	Mon, 09 Feb 2015 10:01:58 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fy8sm14066145pdb.42.2015.02.09.10.01.56
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:01:57 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id DF9AD566188; Mon,  9 Feb 2015 18:01:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:53 +0000
Message-Id: <cover.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/27] Toaster patchset
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:03 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


Hello,

This is a Toaster patchset containing the All Machines page implementation, and fixes
for numerous bugs. All patches have been reviewed and tested on the toaster mailing list.

Can you please pull at your convenience ?

Thank you,
Alex



The following changes since commit 207013b6dde82f9654f9be996695c8335b95a288:

  data_smart: split expanded removal values when handling _remove (2015-02-02 16:20:42 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150209-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150209-submission-bb

Alexandru DAMIAN (6):
  toastergui: fix loadconf error message
  toaster: enable server-side caches and debug-panel
  toastergui: improvements in layer selection logic
  toaster: enhancements for the startup sequence
  toaster: improve logging facilities for toaster
  toaster: display Toaster mode and version in debug mode

Belen Barros Pena (7):
  toastergui: remove time link for failed build requests
  toasterui: use text() instead of html()
  toaster: correct typo in toaster script
  toastergui: set column heading to 'Revision'
  toastergui: add the word 'compatible' to 'all' pages
  toastergui: add download task log icon to recipe details page
  toastergui: links outside Toaster should open in a new window

Michael Wood (14):
  toaster: machines Fix undefined variables
  toaster: Add add/select functionality to machines page
  toaster: machines Make sure we don't overwrite the pagesize
  toaster: All machines add a column to link back to machine conf
  toaster: All machines Update layer notifications
  toaster: layerdetails Don't remove alert from dom on dismissal
  toaster: All machines Add layer name order by functions
  toaster: All machines Add filtering based on layer in project
  toaster: models Allow the machine's layer name to be searched
  toaster: All Machines fix reset search link
  toaster: all Machines exclude de-prioritised layer source items
  toaster: All machines reset order_by if removing that column
  toaster: All machines show results count if filtering or searching
  toaster: All machines Fix filter counts

 bin/toaster                                        |  82 +++++++++---
 lib/bb/ui/buildinfohelper.py                       |  47 +++++--
 lib/toaster/bldcontrol/bbcontroller.py             |  13 --
 lib/toaster/bldcontrol/localhostbecontroller.py    |  54 +++++---
 .../management/commands/checksettings.py           |  76 ++++++++---
 .../bldcontrol/management/commands/loadconf.py     |   2 +-
 .../bldcontrol/management/commands/runbuilds.py    |   2 +-
 lib/toaster/bldcontrol/sshbecontroller.py          |   2 +-
 lib/toaster/orm/models.py                          |  32 ++++-
 lib/toaster/orm/tests.py                           | 131 ++++++++++++++++++-
 lib/toaster/toastergui/static/css/default.css      |  21 ++-
 lib/toaster/toastergui/static/js/layerdetails.js   |   6 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |   4 +-
 lib/toaster/toastergui/static/js/machines.js       |  98 ++++++++++++++
 lib/toaster/toastergui/templates/base.html         |   6 +
 lib/toaster/toastergui/templates/layerdetails.html |  13 +-
 lib/toaster/toastergui/templates/layers.html       |   6 +-
 lib/toaster/toastergui/templates/machines.html     | 125 ++++++++++--------
 .../toastergui/templates/managed_mrb_section.html  |   2 +-
 lib/toaster/toastergui/templates/project.html      |  24 ++--
 lib/toaster/toastergui/templates/recipe.html       |  11 +-
 lib/toaster/toastergui/templates/targets.html      |  20 +--
 lib/toaster/toastergui/templates/tasks.html        |  10 +-
 lib/toaster/toastergui/views.py                    | 142 ++++++++++++++++-----
 lib/toaster/toastermain/settings.py                |  48 ++++++-
 lib/toaster/toastermain/urls.py                    |  23 +++-
 26 files changed, 779 insertions(+), 221 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/js/machines.js

-- 
1.9.1


