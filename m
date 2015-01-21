Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
	[74.125.82.178])
	by mail.openembedded.org (Postfix) with ESMTP id DEC5072CD0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:20 +0000 (UTC)
Received: by mail-we0-f178.google.com with SMTP id p10so44658925wes.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=tyUz23CgNv4l55tEX92NE+XOt53VQtN6M6llY7hnkl0=;
	b=LoToVZcLBmpCeLEmAwkynMaHsu0meipy/7YamDRIzkKS9Xp9KSU504Jb01wgfmVn0e
	cEQKPE/2OEcWO1s3GulAzbIR5qzIahfse1LvpJtLKXfd0wBl37X1Y0UZ8/Y7v6A8eP3D
	06KBEjcNYM7HITurYcIPFCnJY2GQmIaLh/i57S9pvYI+QIDyWxTUz805HyaIxCpFGnmc
	yiwS0625jWg86eJrqNK8FIcWIV0/D7UydVhmRY8EvLn0BPxSb9hUnVNmhOTAHcHAKOKU
	KAOFri7hG9yPBcAgcg+XcEFlWAHXSqwvte3YUKHeaits0WVjFa6lFFsfsw7BcDFppixf
	f7Fw==
X-Gm-Message-State: ALoCoQk7/VnfUe3MwZtonD2s+HfrkjqjSJ7umErTCQu7u5I+cy9ov/AN54N+J1GHPkE0cQ9y37vy
X-Received: by 10.181.13.105 with SMTP id ex9mr58269048wid.69.1421864540950;
	Wed, 21 Jan 2015 10:22:20 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id h13sm8304207wiw.4.2015.01.21.10.22.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:18 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 9EE50563F94; Wed, 21 Jan 2015 17:01:39 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:38 +0000
Message-Id: <cover.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/12] Toaster patchset
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:21 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a Toaster patchset with bugfixes in the UI.
The patches have been reviewed on the toaster mailing list.

Can you please pull at your own convenience ?

Cheers,
Alex

The following changes since commit 909fa19f20e909820aa484967b7fe2a34d89ab49:

  toaster: project configuration variables page (2015-01-21 14:20:55 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150121-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150121-submission-bb

Alexandru DAMIAN (11):
  toastergui: save cookie for orderby/page size settings
  toasterui: save event backlog to build
  toastergui: fix duplicate IDs all builds page
  toastergui: "Run again" button in build pages
  toaster: newproject default release selection fix
  toastergui: fix all-targets redirect
  toastergui: fix all targets page search
  toastegui: project page build selected targets
  toastergui: minor fixes
  toastergui: all projects column show/hide
  toastergui: enable re-ordering when columns are hidden

Belen Barros Pena (1):
  toastergui: fix the second 'view all targets' link

 lib/bb/ui/buildinfohelper.py                       | 11 ++-
 lib/toaster/toastergui/static/js/projectapp.js     | 27 ++++++--
 .../toastergui/templates/managed_mrb_section.html  |  4 +-
 lib/toaster/toastergui/templates/newproject.html   | 32 +++++----
 lib/toaster/toastergui/templates/project.html      | 11 +--
 lib/toaster/toastergui/templates/projects.html     | 12 ++--
 lib/toaster/toastergui/templates/targets.html      |  2 -
 lib/toaster/toastergui/urls.py                     |  2 +-
 lib/toaster/toastergui/views.py                    | 80 ++++++++++++----------
 9 files changed, 111 insertions(+), 70 deletions(-)

-- 
1.9.1


