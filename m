Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 907F673D45
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:38 +0000 (UTC)
Received: by wgso17 with SMTP id o17so83642448wgs.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=8ZdR53u7YTTuhcYi2AFMAZM4fNR+KgyudPlAwYjkv7k=;
	b=KG2MAuwtlzw5RcxeQL4xHtG8yM73wbXSUlrNNzifbbS4BE2yLssPDjQrfpfexkUyMI
	iB6EfFerI5H9XXLUqFH8as+O/FsjnERhs3RsdbbP5uotEEVdhry7cF+bmfl6E/bV4N4k
	URullflsgPQCMQ+skSKmNnAltnl71OcxJ3K6SAIZ+Q7aynVYUjR1JAwbkPqG3T9QB1eq
	Q+ZczfSN0b6uaOTXULYVhd8cPip6+6gvBl+n8LtLytYBzWkwSeLV4EJuZ8S9JOYtaxsv
	yoMchrNSre1Hcz+lRXemrFSFu+rhTThMtXwiUFpfJHVztEJ1iALnSpayWe2qc3CLnRrJ
	MIGw==
X-Gm-Message-State: ALoCoQlWlbNORFMA3NAT4S3EocN0MZIFBZBHF/9lKu38/45bws8fhaOKIsz/96oizKO1lbHjvhhl
X-Received: by 10.180.104.34 with SMTP id gb2mr8147627wib.95.1429195659921;
	Thu, 16 Apr 2015 07:47:39 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k2sm11939899wix.4.2015.04.16.07.47.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:38 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B3169560A13; Thu, 16 Apr 2015 15:47:38 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:37 +0100
Message-Id: <cover.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/8] Toaster bugfixing patchset
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
X-List-Received-Date: Thu, 16 Apr 2015 14:47:40 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a Toaster bugfixing patchset that has been reviewed on the toaster mailinglist. 
Can you please pull whenever convenient ?

Cheers,
Alex

The following changes since commit c4172fe33f0c63eda7f4af2bd36a5e9738e13595:

  bitbake-layers: ensure non-extended recipe name is preferred (2015-04-11 16:14:30 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150416-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150416-submission-bb

Belen Barros Pena (2):
  toasterui: correct terminology in landing page
  toasterui: remove 'targets' from project notification

David Reyna (4):
  toaster: add layer source in admin throws an error
  toaster: searching all projects table resets page count
  toaster: recipe path broken in recipe detail page
  toaster: date range filter for project builds page

Michael Wood (2):
  toaster: base.js minor jshint fixes
  toaster: BuildButton target input allow building targets with tasks

 lib/toaster/orm/models.py                          | 28 ++++++++++++++++------
 lib/toaster/toastergui/static/js/base.js           | 24 +++++++++----------
 lib/toaster/toastergui/static/js/libtoaster.js     |  9 ++++---
 lib/toaster/toastergui/static/js/projectapp.js     |  2 +-
 lib/toaster/toastergui/templates/landing.html      |  2 +-
 .../toastergui/templates/projectbuilds.html        | 16 +++++++++++++
 lib/toaster/toastergui/templates/recipes.html      |  2 +-
 lib/toaster/toastergui/views.py                    |  5 +++-
 8 files changed, 59 insertions(+), 29 deletions(-)

-- 
1.9.1


