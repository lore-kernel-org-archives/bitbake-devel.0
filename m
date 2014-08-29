Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 55650710C5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 15:41:41 +0000 (UTC)
Received: by mail-wi0-f180.google.com with SMTP id ex7so2780673wid.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=BTf9dWdI/+08wyew/jzqpmFXFuWdPwU3hfmC7StKVy0=;
	b=Er9T3OKzvNrtDnH7qysNVGnWsaDtNvxj8JTi9GeF6oYTzUCkXNuEYITZ4rlh62tMGO
	hIxw7x/PQxNByGLNPwBj67pnUrk10xLpe8SWCcZL6ZtlRmApueWjs9HpPipPKNOpNbSl
	BJuzFMnxGUSgrbBUD7iHP17/EE64VUulALdtO8NY9nRDSenlrpb7E+iX32FVE7wQhF4f
	4PtBMvMtdzq19tQA/3z6Swfh8NEjPmVBe4MqLpf11QJcQIde9AmyABz7DJt0g4Hqs4Os
	ramPTTxQhyMu9b0cCF1ccez09e3T22wDqSfUgfJ4O0U2hwdT/kIVaHA9KLnRmP2MtGxn
	sGlQ==
X-Gm-Message-State: ALoCoQmrefKzIGKin0rPzuw5IcAG2WbwDerRIt3kfDD29jlybYCv2XgEaoJlQEn5/iGPe4WI//zv
X-Received: by 10.194.203.105 with SMTP id kp9mr14464698wjc.41.1409326902416; 
	Fri, 29 Aug 2014 08:41:42 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ka3sm838080wjc.3.2014.08.29.08.41.41
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 29 Aug 2014 08:41:41 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0B302560818; Fri, 29 Aug 2014 16:41:40 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 29 Aug 2014 16:41:39 +0100
Message-Id: <cover.1409326534.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/2] add pages for Toaster project views
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
X-List-Received-Date: Fri, 29 Aug 2014 15:41:42 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patchset adds all the pages needed to display project views in Toaster.

The pages may have bugs, and functionality is read-only, but we need to be able
to validate already existing data in the database.

Can you please merge at your convenience ?

Thanks,
Alex

The following changes since commit c2ced09e7ea4a1762d2788bb12a761734d20fd8e:

  toaster: create Build methods for calculating progress and ETA (2014-08-29 13:56:39 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140829-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140829-submission-bb

Alexandru DAMIAN (2):
  toaster: add project pages for machines, targets, layers
  toastergui: added pages for project details

 lib/toaster/orm/models.py                          | 131 ++++----
 .../toastergui/templates/basebuilddetailpage.html  |   0
 .../toastergui/templates/baseprojectpage.html      |  43 +++
 lib/toaster/toastergui/templates/importlayer.html  |  68 ++++
 lib/toaster/toastergui/templates/layerdetails.html | 159 +++++++++
 lib/toaster/toastergui/templates/layers.html       |  11 +-
 lib/toaster/toastergui/templates/machines.html     |  63 ++++
 lib/toaster/toastergui/templates/project.html      | 123 +++----
 .../toastergui/templates/projectbuilds.html        |  59 ++++
 lib/toaster/toastergui/templates/projectconf.html  |  62 ++++
 lib/toaster/toastergui/templates/recipes.html      |   0
 lib/toaster/toastergui/templates/targets.html      | 186 +++++++++++
 lib/toaster/toastergui/urls.py                     |   2 +-
 lib/toaster/toastergui/views.py                    | 365 +++++++++++++++++++--
 14 files changed, 1121 insertions(+), 151 deletions(-)
 mode change 100755 => 100644 lib/toaster/toastergui/templates/basebuilddetailpage.html
 create mode 100644 lib/toaster/toastergui/templates/baseprojectpage.html
 create mode 100644 lib/toaster/toastergui/templates/importlayer.html
 create mode 100644 lib/toaster/toastergui/templates/layerdetails.html
 mode change 100755 => 100644 lib/toaster/toastergui/templates/layers.html
 create mode 100644 lib/toaster/toastergui/templates/machines.html
 create mode 100644 lib/toaster/toastergui/templates/projectbuilds.html
 create mode 100644 lib/toaster/toastergui/templates/projectconf.html
 mode change 100755 => 100644 lib/toaster/toastergui/templates/recipes.html
 create mode 100644 lib/toaster/toastergui/templates/targets.html

-- 
1.9.1


