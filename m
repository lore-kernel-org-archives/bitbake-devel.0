Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id BD97776710
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:33:20 +0000 (UTC)
Received: by mail-pa0-f49.google.com with SMTP id bx7so20141568pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=tczvfuX5tNR7IA/PNavj/gvNKS0difUaEVdRsYBvzow=;
	b=khIr2m4fyoJT6ViFdUabIh5KAqbjX3uD+zpuDXUt3b2Cz2DAQLXHOMuubMk5xqfR5F
	iak12eq7VtFiu7HLhY8p/cIEA5s1cvnZsYQ1RfrFx5nkdPnmu7e977AcqiVSNEe/vZkP
	wigVUJTb+X7Z9fen6hPfmwO8P7fOLoAIVi6zG8hpxIZC5pov0DOYOJV7ynUtpTetvw3X
	P3lJ6oSnH7Dt+hcxLUgWSTvTKseRoBdOcH/ZfoOiUT/yAu8IvYaWXIxQYbQ4kWgsdd9k
	PhRAnORWLVP1aRXk7JAdIiYdzqjhk4OVYwFskds9zJA8MJsor0Fw5hJesG8nYC1vN+ti
	Z4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=tczvfuX5tNR7IA/PNavj/gvNKS0difUaEVdRsYBvzow=;
	b=k1nDbvFG9xZydYLIGMDoOfryvVbiOPQMxrG+R2N/g46oz4kCsl/h4v4Oyurh+7D+zx
	SxyNlLT93QGpnbR5fnaVYWCwgbQExe9lTyBcbb1QdSQmTioSAILMyc0S7L/wDnspNHtR
	7QF1ItNnwYljhaMl5dkdtAf1oZP04pt1gglHi5vrQ/4e1LNlZ4Ha9srU9f0ACf8XK8JO
	EURKXG4zFXEohwM0Lq+3I9qEYY/LiPY9HzHSycD/7MyMqWcsS44zu+MTDvY3fjbostrb
	lVla1t64ezwaUICalPSByHklegaHLaVApN8IK+zTOH1UzPG0AxELc2wKVkSe80+qcCCl
	CYAw==
X-Gm-Message-State: AD7BkJJVDXl3VVDWw8TZ0LHzaRWWqkC0vFmd6UIXz/NNIBw0BXh36vFhgQ/kFJ6S/3+DxUjo
X-Received: by 10.67.24.41 with SMTP id if9mr25986946pad.63.1459960400800;
	Wed, 06 Apr 2016 09:33:20 -0700 (PDT)
Received: from draco.icx.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	g28sm6146020pfd.25.2016.04.06.09.33.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:33:20 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:33:10 +0100
Message-Id: <cover.1459960000.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 00/40] Various fixes from toaster-next
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
X-List-Received-Date: Wed, 06 Apr 2016 16:33:22 -0000

This patch set contains the fixes for:
 - Build cacnellation
 - SSTATE_DIR and DL_DIR
 - Build launching fixes
 - Support for building jeth release

They all had a dependency on the build launches fixes which is why this is multiple series in one.

This patchset fixes the following bugs:
  6787 2.1 Cancelling builds at any point in the build process (edit) 
  7880 2.1M3 Medium+/Normal: Toaster uses the same /tmp dir across releases
  9058 2.1   Medium/Normal: Bad project MACHINE setting in conf/toaster.conf causes command line builds to fail
  8958 2.1M3 Medium/Normal: Toaster does not build with the Jethro release
  6787 2.1   Medium/Enhancement: Cancelling builds at any point in the build process
  8422 2.1   Medium/Enhancement: we currently don't allow setting of sstate_dir or dl_dir



are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib michaelw/submit/ed/toaster/project-build-dir-cancel-dldir_sstatedir
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/submit/ed/toaster/project-build-dir-cancel-dldir_sstatedir

Ed Bartosh (24):
  toaster: don't start bitbake server
  toaster: get rid of noui option
  toaster: set BITBAKE_UI environment variable
  toasterui: add brbe parameter to buildinfohelper
  uievent: improve BBUIEventQueue code
  buildinfohelper: improve handling of providermap
  toasterui: fix brbe reporting
  toaster: remove startBBServer API
  toaster: remove release API
  toaster: add brbe parameter to triggerBuild
  toaster: modified setLayers API
  toaster: reimplement triggerBuild
  toaster: add new parameter to _shellcmd
  toaster: stop bitbake server after the build
  toaster: update conf/local.conf
  toaster: fix jethro build
  toaster: use bash explicitly
  toasterui: shutdown on BuildCompleted event
  toaster: use empty token
  toaster: add DL_DIR and SSTATE_DIR to oe toasterconf
  toaster: export BBBASEDIR variable
  toaster: get bitbake location from BBBASEDIR
  buildinfohelper: fix KeyError
  toasterui: update build in internal state

Michael Wood (9):
  toaster: Move xhr calls for starting and stopping builds
  toaster: xhr Update the implementation of the build cancellation
    request
  toaster: libtoaster Update implementation of startABuild and
    cancelABuild
  toaster: bldcontrol models Add a cancelling state the BuildRequest
  buildinfohelper: Add handler for cancelling a build
  toaster: mrb_section template Add build cancel button
  toaster: models Exclude the CANCELLED builds from get_number_of_builds
  toaster: runbuilds Make runbuilds aware of the build CANCELLED state
  toaster: runbuilds Clean up runbuilds

Sujith H (7):
  toaster: bldcontrol Add forceShutDown function to BitbakeController
  toaster: update BuildEnvironmentController and BitbakeController
  toaster: models Add cancelled state to build outcome
  toaster: tables BuildsTable exclude cancelled builds
  toaster: add DL_DIR and SSTATE_DIR to poky toasterconf
  toaster: update view to support DL_DIR and SSTATE_DIR
  toaster: update projectconf.html for DL_DIR and SSTATE_DIR

 bin/toaster                                        |  82 ++---------
 lib/bb/ui/buildinfohelper.py                       |  49 +++++--
 lib/bb/ui/toasterui.py                             |  22 +--
 lib/bb/ui/uievent.py                               |  10 +-
 lib/toaster/bldcontrol/bbcontroller.py             |  62 +-------
 lib/toaster/bldcontrol/localhostbecontroller.py    | 152 ++++++++++----------
 .../bldcontrol/management/commands/runbuilds.py    | 109 +++++++++-----
 .../migrations/0003_add_cancelling_state.py        |  19 +++
 lib/toaster/bldcontrol/models.py                   |  27 +++-
 .../orm/migrations/0006_add_cancelled_state.py     |  19 +++
 lib/toaster/orm/models.py                          |  12 +-
 lib/toaster/toastergui/api.py                      | 110 ++++++++++++++
 lib/toaster/toastergui/static/js/customrecipe.js   |   4 +-
 lib/toaster/toastergui/static/js/layerBtn.js       |   3 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  41 ++++--
 lib/toaster/toastergui/static/js/mrbsection.js     |  95 ++++++++++++
 lib/toaster/toastergui/static/js/projectpage.js    |   4 +-
 lib/toaster/toastergui/static/js/projecttopbar.js  |   6 +-
 lib/toaster/toastergui/static/js/recipedetails.js  |   4 +-
 lib/toaster/toastergui/tables.py                   |  48 +------
 lib/toaster/toastergui/templates/base.html         |   1 +
 lib/toaster/toastergui/templates/mrb_section.html  | 148 +++++++------------
 lib/toaster/toastergui/templates/projectconf.html  | 160 ++++++++++++++++++++-
 lib/toaster/toastergui/urls.py                     |   5 +
 lib/toaster/toastergui/views.py                    |  40 +++++-
 25 files changed, 793 insertions(+), 439 deletions(-)
 create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0003_add_cancelling_state.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0006_add_cancelled_state.py
 create mode 100644 bitbake/lib/toaster/toastergui/api.py
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/mrbsection.js

-- 
2.1.4


