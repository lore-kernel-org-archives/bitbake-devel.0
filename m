Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f178.google.com (unknown [74.125.82.178])
	by mail.openembedded.org (Postfix) with ESMTP id E90BF65D5B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 14:15:06 +0000 (UTC)
Received: by mail-we0-f178.google.com with SMTP id u56so2124312wes.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 07:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3ga0QdUeoVp5R4r9D7xNn2IL/+aT59ngKKqGoIJCLnY=;
	b=GdJGi60sKFjqzFIt/bQEHMRCS5Eu7c3uPSjL5k1MP/2KdqBf/jY2pEPxb/dO6K8l63
	bFVcvd6YBRQvSfec4Y3MG7XxSy6HFL6uAoncpsz2Y9SRDPRPTiDV+ADO26sQPbjijT4L
	eE2f0T9QBp4x2NpM72wYXvh9xj3PagLsdOWCBWIQoj0EI/GdZ2bWrxdy7mjRdoomuyeV
	p/+FhbddePN5yO9PSxLWpqJ9lY3X3h5yoIa9LyywLNgkG4yGNI4PGMcDDn4l3tOjjKjm
	CXxL6FTtmadEUtUjxEI2lsWMon+sdna09MDA7PgQkNwZW5DXLzI5ljE/B364Kj8RO3gX
	7TUg==
X-Gm-Message-State: ALoCoQn5XWCUk09CKIynpqGu5JHXRYQRT6/dKwExkHOe2PyTvJNhwBXrH1W5Z4am1YRAjb9J09Oa
X-Received: by 10.194.220.42 with SMTP id pt10mr17290829wjc.60.1400681707025; 
	Wed, 21 May 2014 07:15:07 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fu10sm2530410wib.11.2014.05.21.07.15.05 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 May 2014 07:15:06 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0740056019E; Wed, 21 May 2014 15:15:06 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 May 2014 15:15:04 +0100
Message-Id: <cover.1400681628.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Farrell Wymore <farrell.wymore@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>,
	Ionut Chisanovici <ionutx.chisanovici@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/3] please merge toaster patches
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
X-List-Received-Date: Wed, 21 May 2014 14:15:09 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


Hello,

This is a lightweight patchset for Toaster. The patches
have been reviewd on the list, and tested by me.

Can you please merge ?

Thank you,
Alex

The following changes since commit ef2bf63e56b87e19d1a9059dd2d81a9a1a537254:

  fetch2/gitsm: Documentation improvements for gitsm:// fetcher (2014-05-19 12:02:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140521-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140521-submission-bb

David Reyna (1):
  toaster: reduce redundant foreign key lookups

Farrell Wymore (1):
  toaster: sort columns properly after edit columns

Ionut Chisanovici (1):
  toaster: toaster oe-selftest support

 .../toastergui/templates/basetable_top.html        | 172 ++++++++-
 lib/toaster/toastergui/templates/recipes.html      |  20 +-
 lib/toaster/toastergui/views.py                    |  61 ++-
 meta/lib/oeqa/selftest/toaster.py                  | 411 +++++++++++++++++++++
 4 files changed, 644 insertions(+), 20 deletions(-)
 mode change 100644 => 100755 lib/toaster/toastergui/views.py
 create mode 100644 meta/lib/oeqa/selftest/toaster.py

-- 
1.9.1


