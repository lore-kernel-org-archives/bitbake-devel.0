Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 8987160670
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:09 +0000 (UTC)
Received: by wggx12 with SMTP id x12so15056916wgg.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=8b2Rlq/5Vq3NQ2WV8jipqySG5Pi7ZY/pKc8iKNzbvz4=;
	b=iQjJCEDCluVM/hUJtLip3VKobXIQhlpCiM9dDABuR+9DHWoeVXNyIaZawENdMSK1lh
	nPJUkhZQ5D5VGcZHxRKqD1ENCOv+/2cBdKrs0qKFeUwoua0bviXfSsc/zlD3czW5YXbx
	wzs7x8lBKLOSvzPpE0PiMMOf+nOSJUOaSv6cZ3eBHT6aHJqdptCB7QVP0FstryzGP6oe
	ZUeg2BfnJst1Ll3xm25qWFiA5s6hfQd58DNlNzgOpi4i6WSwOXzfEBdYnGadg4h5vl/o
	05Lw/ZAQ5YLm5b/ARXdxdfyMbxVHI63yYtJJ3rduDx+1MrHuu563UX3V0aak23dZd4L8
	hrdA==
X-Gm-Message-State: ALoCoQkWM33C95WwIoSZA7B76ZM7Eq+ZtsgonFTiT6/t/Y0YK6M2G2cjDhD334Es915qzKITP3Oc
X-Received: by 10.180.14.196 with SMTP id r4mr53668338wic.77.1424986930643;
	Thu, 26 Feb 2015 13:42:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k1sm3187405wjn.9.2015.02.26.13.42.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:08 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 3E35256139D; Thu, 26 Feb 2015 21:41:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:41:56 +0000
Message-Id: <cover.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/8] Toaster patchset
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
X-List-Received-Date: Thu, 26 Feb 2015 21:42:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This patchset is targeted at bringing critical fixes for M3 rc2 release, including
multiple show stoppers. It also adds fixes for M3 features.

The patches have been tested and reviewed on the toaster mailing list.

Can you please pull before M3 rc2 cut-off ?

Thank you,
Alex


The following changes since commit 7182cdd3c4a534a87147bb0aad7b360ffef6426b:

  bitbake-layers: fix wildcard support in remove-layer (2015-02-25 23:28:15 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150226-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150226-submission-bb

Alexandru DAMIAN (5):
  toastergui: stop covered task graph traversal early
  toasterui: fix sstate task identification
  toaster: order layers with same priority
  toasterui: do not use transactions if the database autocommits
  toastergui: add csrf tokens for AJAX calls

Belen Barros Pena (1):
  toaster: fix typo in models.py

David Reyna (2):
  toaster: all projects data and sorts
  toaster: config var layout fixes

 lib/bb/ui/buildinfohelper.py                       |  24 +++--
 lib/toaster/bldcontrol/models.py                   |   2 +-
 lib/toaster/orm/models.py                          |  80 +++++++++++++---
 lib/toaster/toastergui/static/css/default.css      |   2 +-
 lib/toaster/toastergui/templates/layers.html       |   1 +
 .../toastergui/templates/managed_builds.html       |  22 +++--
 .../toastergui/templates/managed_mrb_section.html  |   1 +
 lib/toaster/toastergui/templates/projectconf.html  |  23 ++---
 lib/toaster/toastergui/templates/projects.html     |  60 +++++++++---
 lib/toaster/toastergui/templates/targets.html      |   1 +
 lib/toaster/toastergui/views.py                    | 104 ++++++++++++++-------
 11 files changed, 229 insertions(+), 91 deletions(-)

-- 
1.9.1


