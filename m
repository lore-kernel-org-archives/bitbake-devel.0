Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 2D28F71498
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Sep 2014 16:45:08 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id n3so1477812wiv.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Sep 2014 09:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=DBzI57k483BJvBzU3B2vYE+UnZJmWw6mhbQ5Y1ckFE8=;
	b=gSZX40VrVJ36vEeldYsjbX4HsuoZiue913NOvmMTqjW75QgI4M8vJsOwtUkJmURL4L
	jmzsMBjnqgoA4igyNtkHBuztZ+6slkQBhScrWgoI4fAHkvQV5JjMpJLjdFs4eZ7fqLgT
	rIMZvBIY19wNMlO11SM1gYs9XJ9Uz4YaOtAvHDOm8XjMKFA8xC2F1L1OP3oXX4QrfNhj
	pRDytP1qU2KVF3MsqvAjqIi6Mr2DxN19LmHqk13EH89iGeWuZeV9WITQm7wV0N42laR4
	/dqQP0Q/v+XhA0WpAyScJtJT6AMWGCL6Qb5sT8FxJPNYyEz3J88T5OrCRGrh4sTrShtz
	hNOA==
X-Gm-Message-State: ALoCoQkvWqHKx/yIl+iC4+Elag7BOuxXS8kFOyRGo+pgWW2aiowNEY0WLB577l0avaBTF4yIQx/A
X-Received: by 10.194.94.196 with SMTP id de4mr7933055wjb.86.1409849109300;
	Thu, 04 Sep 2014 09:45:09 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hi4sm19912453wjb.46.2014.09.04.09.45.07 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Sep 2014 09:45:08 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 49E8A5616CF; Thu,  4 Sep 2014 17:45:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  4 Sep 2014 17:44:56 +0100
Message-Id: <cover.1409848901.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/6] bug fixes patchset
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
X-List-Received-Date: Thu, 04 Sep 2014 16:45:11 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a bugfix patchset that fixes two critical issues preventing normal
operation of Toaster, and four bugs that break pieces of functionality
or self-testing in the project.

Can you please merge them at your convenience ?

Cheers,
Alex

The following changes since commit 8f5c1cdae1ee6ce04ae0d04d0b95bd80efbf7534:

  process: Ensure abnormal exits set an error level (2014-09-02 18:10:17 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140904-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140904-submission-bb

Alexandru DAMIAN (4):
  toaster: rename bldviewer projecttags custom tagset
  toaster: bitbake server listen on all interface
  toaster: enable SSH-based remote build support
  toaster: do not save objects in session

Marius Avram (2):
  toaster: use cookies for count and sorting in templates tables
  toaster: fix some code spacing issues

 bin/toaster                                        |   6 +-
 lib/toaster/bldcontrol/bbcontroller.py             | 170 ++----------------
 lib/toaster/bldcontrol/localhostbecontroller.py    | 191 ++++++++++++++++++++
 lib/toaster/bldcontrol/sshbecontroller.py          | 193 +++++++++++++++++++++
 lib/toaster/bldcontrol/tests.py                    | 116 ++++++++++---
 lib/toaster/bldviewer/templates/simple_build.html  |   2 +-
 lib/toaster/bldviewer/templates/simple_layer.html  |   2 +-
 lib/toaster/bldviewer/templates/simple_recipe.html |   2 +-
 .../{projecttags.py => simple_projecttags.py}      |   0
 .../toastergui/templates/basetable_bottom.html     |  52 +++---
 .../toastergui/templates/basetable_top.html        |  18 +-
 lib/toaster/toastergui/views.py                    | 140 +++++++++------
 12 files changed, 628 insertions(+), 264 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/localhostbecontroller.py
 create mode 100644 lib/toaster/bldcontrol/sshbecontroller.py
 rename lib/toaster/bldviewer/templatetags/{projecttags.py => simple_projecttags.py} (100%)

-- 
1.9.1


