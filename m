Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 27EDF724B9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 18:20:48 +0000 (UTC)
Received: by wiaa2 with SMTP id a2so36763228wia.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 11:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=2fLiDKbqfHEzzpptg8KuWX1XpnJtYpIdbKG9QQyhPPU=;
	b=XigHhSyjJYVy5u6QRjylIxwPh88gd5qUgONSW+DTHhsRfUOlRQN6VS8Okg3rE9gMUN
	2ebbTRd1JWradpeqbhEDDqmBzTysmMdoQk52ty86h06OdJuHMAw7KJ+gth7tWJ3cAdsr
	Y+G1UxCSTJGRl2U9izTAPHo4e/yJuEl6lkp1GEWf+f15REeBa0XTQ9u6BpHvPSnwFrcQ
	wQFNlYudzJxMNY8AOTVf/rEftYDiC7ZO9TjA4uZkDdIe5QT2QBiyJsINE7bDIYkU3qYx
	NW6cuStHLXEsCrj7UY78d6b88eBcBf7AVQNADYSbAnUtzWXZAkBhvkWrPoQoMOuiSett
	bLbA==
X-Gm-Message-State: ALoCoQlLjXwiJeZSJ8qH4sFHIwkoZAgUL0iGU72EfbatHt3IIMRkC4vvtSqwCQXdDghMrXYBnQzU
X-Received: by 10.180.98.137 with SMTP id ei9mr7516165wib.92.1427826049536;
	Tue, 31 Mar 2015 11:20:49 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hi6sm21411567wjc.34.2015.03.31.11.20.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 31 Mar 2015 11:20:48 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4998E56154C; Tue, 31 Mar 2015 15:07:28 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Mar 2015 15:07:27 +0100
Message-Id: <cover.1427810520.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/4] [fido] [master] Toaster UI patchset
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
X-List-Received-Date: Tue, 31 Mar 2015 18:20:53 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a toaster UI patchset aiming to fix an important bug in builds table,
and to enhance usability by driving consistency in the GUI in regards to 
terminology and search results.

Can you please pull for both origin and fido branch ?

Cheers,
Alex

The following changes since commit 0153e0b4e089f62a7d5a92ca6be2fa5a8f61a6e4:

  Update to version 1.27.0 post 1.26 release (2015-03-25 12:49:39 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150331-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150331-submission-bb

Alexandru DAMIAN (3):
  toastergui: prevent error on empty build list
  toastergui: add ext4 option for IMAGE_FSTYPES
  Revert "toaster: machine not searchable in all builds/projects"

Belen Barros Pena (1):
  toasterui: rename 'targets' to 'recipes'

 lib/toaster/bldcontrol/models.py                   |  2 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |  2 +-
 lib/toaster/toastergui/templates/base.html         |  4 +--
 lib/toaster/toastergui/templates/layerdetails.html | 16 ++++++------
 lib/toaster/toastergui/templates/project.html      | 22 ++++++++--------
 lib/toaster/toastergui/templates/targets.html      | 16 ++++++------
 lib/toaster/toastergui/views.py                    | 30 +++++++++++++---------
 7 files changed, 49 insertions(+), 43 deletions(-)

-- 
1.9.1


