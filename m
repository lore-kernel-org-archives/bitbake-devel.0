Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id B6B3873943
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:44 +0000 (UTC)
Received: by widex7 with SMTP id ex7so19175300wid.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=cVXDDu8V0mQubGAsk59N3KtcvZr6NUbqOs18tf/xM7w=;
	b=J2JjcFUI/87DVO5UoaSBl+YqO6tU/JCWFtYrjDZIffJL/dVoxGxcRzrIlXX+hS/Z+q
	0+4shOsOcpQ/bzKMp4wNCsZHSY87YuK3UpZIzm38sH4H87ILBGAGZ9BlzTqdx+8IjiT0
	M94+sTGJATNuts9CVolRMY4HBekLqATa6xaoSllH8Af8u5GVcs4mmsSeZIwDCUmAwuMd
	YIHQmVoP0NHoDXkWY8DyhRIBKcYoWqQtLZfJLOfjm+lyV4Rc01u3YkUBrBBXu8SW2r5X
	+JsWOZSx56cSWyzCa37fHiNpGSCZGSC90c8TJHiqtAq0IG2DiuoQ3xOi3qb5A/PtQte4
	ESug==
X-Gm-Message-State: ALoCoQmPrD9WhBg8f4dV+/vnxT/iv7VfEYJXP/0hVaUubl5ip28tZSVuyvWKA9iyFgB+8Y1DoaGR
X-Received: by 10.180.14.196 with SMTP id r4mr9895378wic.77.1426157205694;
	Thu, 12 Mar 2015 03:46:45 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k1sm9450037wjn.9.2015.03.12.03.46.44
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:44 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 79A805618E3; Thu, 12 Mar 2015 10:46:47 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:45 +0000
Message-Id: <cover.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/17] toaster patchset
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a toaster bug fixing patchset, with patches tested and reviewed
on the mailing list.

Can you please pull,

Cheers,
Alex

The following changes since commit 0e0ba408c2dce14a0fabd3fdf61d8465a031495b:

  cooker/server: Fix up 100% CPU usage at idle (2015-03-10 10:37:07 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150312-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150312-submission-bb

Alexandru DAMIAN (15):
  toastergui: project page - consistent error display
  toastergui: suggestion in alphabetical order
  toastergui: fix project page layer branch names
  toastergui: improve data suggestion
  toastergui: improve performance in the all targets page
  toasterui: identify proper layer in build mode
  toastergui: update search fields
  toastergui: project app build command fix
  toastergui: tables display optimizations
  toastergui: dirinfo needs path separation
  toastergui: improve toaster suggestion
  toasterui: relative recipe paths
  toaster: localhost build increase timeout
  toastergui: fix mrb Run again buttons
  toastergui: replace ETA with percentage

Michael Wood (2):
  toaster: projectconf fix typo of package name
  toaster: Fix the orderkey to match the column

 lib/bb/ui/buildinfohelper.py                       | 29 +++++++--
 lib/toaster/bldcontrol/localhostbecontroller.py    |  8 +--
 lib/toaster/orm/models.py                          | 52 ++++++++-------
 lib/toaster/toastergui/static/js/projectapp.js     |  7 +-
 .../toastergui/templates/managed_mrb_section.html  |  7 +-
 lib/toaster/toastergui/templates/project.html      | 56 ++++++++--------
 lib/toaster/toastergui/templates/projectconf.html  | 22 +++----
 lib/toaster/toastergui/templates/targets.html      |  2 +-
 lib/toaster/toastergui/urls.py                     |  2 +-
 lib/toaster/toastergui/views.py                    | 75 ++++++++++++++--------
 10 files changed, 153 insertions(+), 107 deletions(-)

-- 
1.9.1


