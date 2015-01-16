Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182])
	by mail.openembedded.org (Postfix) with ESMTP id D80C27226D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 16:42:37 +0000 (UTC)
Received: by mail-we0-f182.google.com with SMTP id w62so21140764wes.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 08:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=sXxntnaqSvQ5oEc3ntxnh+JdZYgz+vRLDgP4NwrDjOE=;
	b=gVe6cMCsNmTaufg8zzKcf2dS2i0sjvMllelJribUlv9VEIPxJ+nXfD7/K1NX0MtYAz
	2W33ZLgkFS3rpOEkcgfks1TOtVP/bjH8nY6Me036DHOWP990GGQTyabKF3K3d+Ma6oJ8
	Jo4Yc0c/FHTPlkx8P4jLNzcRrzZ8tZbpPfIwpvuzf/KPed/qpROZMmYPHdUSrRZdqUIP
	rqlMC2pCGzzGg+uh+clDcYGurDzk66zYejoDEcV1SWcGxTrgTtJ/JtWAJzbm/oeLJZn4
	Xa8JKBRo8hVMRjRUpF9okxPVbt48R99rmxx3vllO0QnWLYH8ukB6U1WwtOGzAg87bDeR
	8AtQ==
X-Gm-Message-State: ALoCoQksRSrgenFvNSWfPFtH99bb5MkF528/9CMXsV+zVw9HISoiWOqy2HnY5FBzJbu8vAZhxoVE
X-Received: by 10.180.109.79 with SMTP id hq15mr6107577wib.47.1421426557651;
	Fri, 16 Jan 2015 08:42:37 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id g2sm6738664wjn.11.2015.01.16.08.42.36
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 16 Jan 2015 08:42:36 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A6584560DB7; Fri, 16 Jan 2015 16:42:37 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Jan 2015 16:42:35 +0000
Message-Id: <cover.1421426452.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/2] Toaster feature patchset
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
X-List-Received-Date: Fri, 16 Jan 2015 16:42:42 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a toaster feature patchset, bringing in the last two features needed
for Toaster managed-mode release with M2. The patches have been reviewed 
on toaster mailinglist.

Can you please merge at your own convenience ?

Cheers,
Alex

The following changes since commit 8118f465b9f87c66b2a741008f69198ac5fea901:

  toasterui: fix variable data error (2015-01-15 12:13:10 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150116-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150116-submission

Alexandru DAMIAN (1):
  toaster: project builds page

David Reyna (1):
  toaster: project configuration variables page

 lib/toaster/bldcontrol/models.py                   |   2 +
 .../toastergui/templates/projectbuilds.html        | 118 +++-
 lib/toaster/toastergui/templates/projectconf.html  | 649 ++++++++++++++++++++-
 lib/toaster/toastergui/urls.py                     |   1 +
 lib/toaster/toastergui/views.py                    | 376 ++++++------
 5 files changed, 890 insertions(+), 256 deletions(-)

-- 
1.9.1


