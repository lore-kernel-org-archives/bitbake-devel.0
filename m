Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id F079673E10
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 May 2015 11:47:11 +0000 (UTC)
Received: by wief7 with SMTP id f7so75621314wie.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 May 2015 04:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=JiVnHCvxcB7akQmOV8wUKNxqtBUVuoycfjUlo1QIM8M=;
	b=UMDwOnp1NBbnAKMRD2ONmkt+aIPWzZ50QoN5cqmTrTEO3dQqOGSI/a2gbsqaUX+SZm
	BEIRulcu0AoRxUnGuAHKEaFkZ+cJInRPfAB+ilnHaNxbu/Vn/40nVjcCs43Go9E2tz7w
	e6FPuuf9dvWTs034bCpZKVsUM0MssqyFPJZ8Oqp/EPJn3kCdDSot1vjop+JJ8HmeAN4+
	buEKKtQpd4oPnj/e00AdQrZoTOaUJ4f33AbP46qKxxrLsj+1sc2s77vTsYB5jjfbslTz
	FOYDTVkUudnbDM2jNXzllEmN8wQUa3JJiFYM0TzYyHsOOV2aGlSG6ti6p+Jc35Kx+7Ce
	HAXw==
X-Gm-Message-State: ALoCoQmAgJ4T7Tn8x1B2BB1tl2y2Y0XbiS6uAiZHCsSvM0/3FdPGb5rkxlvyyhV4IfriflF5lx1i
X-Received: by 10.180.216.40 with SMTP id on8mr19242766wic.55.1430740032616;
	Mon, 04 May 2015 04:47:12 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ch2sm10823562wib.18.2015.05.04.04.47.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 May 2015 04:47:09 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 38058566863; Fri,  1 May 2015 17:40:43 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 May 2015 17:40:42 +0100
Message-Id: <cover.1430498382.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/7] toaster patchset
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
X-List-Received-Date: Mon, 04 May 2015 11:47:16 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a toaster patchset adding UI and build logger fixes.

Cheers,
Alex

The following changes since commit f8590547a198a78334debdf14bf40acb50c22ecc:

  bitbake: reset build mtime cache before the build (2015-04-28 22:28:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150501-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150501-submission-bb

Alexandru DAMIAN (2):
  toasterui: proper exit code on toaster errors
  toasterui: close build on BuildCompleted event

Michael Wood (5):
  toaster: Move project context variables to common scope
  toaster: projectapp Implement machine select command
  toaster: Refactor and expand layer add remove mechanism
  toaster: Add links to the layer add notification
  toaster: filtersnippet remove redefinition of filter type key

 bin/toaster-eventreplay                            |  13 +-
 lib/bb/ui/buildinfohelper.py                       |   5 +-
 lib/bb/ui/toasterui.py                             |  45 +++--
 lib/toaster/orm/views.py                           |   8 +-
 lib/toaster/toastergui/static/css/default.css      |   2 +-
 .../toastergui/static/html/layer_deps_modal.html   |  17 ++
 lib/toaster/toastergui/static/js/base.js           |  39 ++--
 lib/toaster/toastergui/static/js/filtersnippet.js  |   3 +-
 lib/toaster/toastergui/static/js/importlayer.js    |  20 +-
 lib/toaster/toastergui/static/js/layerBtn.js       |  63 ++++++
 lib/toaster/toastergui/static/js/layerDepsModal.js |  90 +++++++++
 lib/toaster/toastergui/static/js/layerdetails.js   |  99 ++-------
 lib/toaster/toastergui/static/js/libtoaster.js     |  96 ++++++++-
 lib/toaster/toastergui/static/js/machines.js       |  97 ---------
 lib/toaster/toastergui/static/js/projectapp.js     |  31 ++-
 lib/toaster/toastergui/templates/base.html         |  19 +-
 lib/toaster/toastergui/templates/importlayer.html  |   6 +-
 lib/toaster/toastergui/templates/layerdetails.html |   9 +-
 lib/toaster/toastergui/templates/layers.html       | 223 +++------------------
 .../toastergui/templates/layers_dep_modal.html     |  99 ---------
 lib/toaster/toastergui/templates/machines.html     |  36 ++--
 lib/toaster/toastergui/templates/targets.html      | 220 ++++----------------
 lib/toaster/toastergui/views.py                    |   2 +-
 23 files changed, 471 insertions(+), 771 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/html/layer_deps_modal.html
 create mode 100644 lib/toaster/toastergui/static/js/layerBtn.js
 create mode 100644 lib/toaster/toastergui/static/js/layerDepsModal.js
 delete mode 100644 lib/toaster/toastergui/static/js/machines.js
 delete mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.html

-- 
1.9.1


