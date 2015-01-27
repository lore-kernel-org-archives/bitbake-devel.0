Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 6E65F6A9FE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:29 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id l15so5157277wiw.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=nDSAqwzQfx9fO6S0d9sISCXwEuYrdHJDGwqXz0/Cxds=;
	b=bg0tGcXlw5Zrhqv0swXhlX0s1fnJcOivRnHk50IOsAWDGcQAeoqCNoCJU8fWJTswP+
	JlS7n2y73dppmlHYVK4lIEgen460snhufxX3PKSpcBvarzq4zEd4AnIncZmU8qATc979
	i/g3dC9tGcFG0F5uJmeKuVauqPxnAWgw0FkyWg8QPImuVZrea7gRX53OQTuVYWttRsyz
	gi7O3mH/3jj2CJvsleKPEZ11LRtTG0jHiXibu2C9uIXWhhVLsYwLEFlcOeQMMlHlDiIl
	KTciuQSGvOvywHBOe+3LDRis9r02xMcfn5Ru+u7q+66QMeugUjTb3cfLuXdL4G+wgNK1
	QwqQ==
X-Gm-Message-State: ALoCoQn3Okk9GES/h2pEwaqo2sIrgiMxOOpKYXDen2MgpK6B0erKYCMUjhn5ONf51qzUSV1Sd3hD
X-Received: by 10.194.83.66 with SMTP id o2mr877404wjy.55.1422368850068;
	Tue, 27 Jan 2015 06:27:30 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id be2sm2019103wjb.38.2015.01.27.06.27.28
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:28 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 945A65617F6; Tue, 27 Jan 2015 14:27:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:31 +0000
Message-Id: <cover.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/14] Toaster patchset
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:38 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


Hello,

This is a Toaster bug fixing patchset, clearing up issues in the Project interface.

The patches have been reviewed on the toaster mailing list. Can you please pull
at your own convenience ?

Cheers,
Alex


The following changes since commit 9b5b1bd7d77e3f5886f6c557d3b750de1f6d6025:

  siggen: Ensure taskdata default functions exist in base class (2015-01-23 14:39:40 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150127-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150127-submission-bb

Alexandru DAMIAN (1):
  toastergui: update project build listing

Alexandru Damian (1):
  toasterui: do not filter images by extension

Belen Barros Pena (12):
  toaster: make layouts consistent
  toaster: apply common styles to right hand column of detail pages
  toastergui: Generic message for the layer details empty states
  toastergui: remove redundant style declaration
  toastergui: consistent add / remove layer notifications
  toastergui: give the add dependencies form some breathing space
  toastergui: add 'show all' link to no results page
  toastergui: set column width in layer details page
  toastergui: hide table controls when when less than 10 entries
  toastergui: consistent capitals in button
  toastergui: remove recipe id links to the layer index
  toastergui: alignment fix

 lib/bb/ui/buildinfohelper.py                       |   2 +-
 lib/toaster/bldcontrol/models.py                   |   9 ++
 lib/toaster/toastergui/static/css/default.css      |   5 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |  14 +--
 .../toastergui/templates/baseprojectpage.html      |  12 +--
 .../toastergui/templates/buildrequestdetails.html  |  67 ++++++++++++++
 lib/toaster/toastergui/templates/layerdetails.html |  65 ++++++-------
 .../toastergui/templates/managed_builds.html       |  18 ++--
 .../toastergui/templates/managed_mrb_section.html  |  42 ++++++---
 .../toastergui/templates/package_detail_base.html  |   2 +-
 lib/toaster/toastergui/templates/project.html      |   4 +-
 .../toastergui/templates/projectbuilds.html        |  20 ++--
 lib/toaster/toastergui/templates/recipe.html       |   6 +-
 lib/toaster/toastergui/urls.py                     |   2 +
 lib/toaster/toastergui/views.py                    | 103 +++++++++++++--------
 15 files changed, 248 insertions(+), 123 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/buildrequestdetails.html

-- 
1.9.1


