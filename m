Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id E543565D4A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:39 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id cc10so8862562wib.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=N4OKHxhNdn12bavE9t6T94D/LUWPfV4VGbboFA4c5gg=;
	b=eCXfTBq+GKegcUfH7HXQQQYiqlqcVXA/kijWSZvsvyTDgWGBQVqtp+9izj5Ezc2Q4C
	fs00NrYcJmjIEzyQ4M4izQlbEC/JwtdJCpF4pnu7auXPLEbG3ue64Kl4xVEu4tqCfd1x
	hEvVtfGaVTLfp1XJncrWkhJVGgT5c/DlP2rKpC/4Ohb5gO6ULL3rVb6krIIVlFM5NCxs
	qm99GZIBNyvisCZg84OKH8xG3pEUFWAHby8GST63sZrGtM1aZ+vnly4cwVCbB2WLlXCd
	1V0umavJkwPOE39cqefJEJ47v81ZijyXvm0FLUjJqzkh/Qy38vnnRqELhA5NLPDVSh7q
	35QA==
X-Gm-Message-State: ALoCoQlnoQ62WaDoI7KxzZBBHdr5n69w4iSxwIaEp8HK18ire180gDRIH9xkv5/IzjNKFxg0Xl/n
X-Received: by 10.180.74.242 with SMTP id x18mr10023475wiv.20.1397049459752;
	Wed, 09 Apr 2014 06:17:39 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id lh6sm1654874wjb.27.2014.04.09.06.17.38
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:38 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 3575F560213; Wed,  9 Apr 2014 14:17:37 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:35 +0100
Message-Id: <cover.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Dave Lerner <dave.lerner@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/9] toaster patchset pull request
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:42 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a pull request for toaster.

All the patches have been reviewed on the toaster mailing list.
Patches have been tested invidividually and in this patchset.

Can you please pull at your convenience ?

Thank you,
Alex

The following changes since commit 4fafea4fa69542b491e84463f6eae0d5bf645673:

  bitbake: knotty: Clear footer before outputting to stderr (2014-04-08 18:05:19 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140409-bb-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140409-bb-submission

Alexandru DAMIAN (3):
  toaster: do not load all available timezones
  toaster: keep number of rows across searches
  toaster: fix filtering query for multiple filters

Dave Lerner (2):
  toaster: disable 'size over total' sort
  toaster: sort on size in detail pages

David Reyna (4):
  toaster: show unique set-in files in configvar
  toaster: regex alternation filter caused django error
  toaster: hide tasks without order or outcome
  toaster: add URI search path list

 lib/toaster/toastergui/static/css/default.css      |   4 +-
 .../toastergui/templates/basetable_top.html        |   1 +
 lib/toaster/toastergui/templates/bpackage.html     |   2 +-
 lib/toaster/toastergui/templates/dirinfo.html      |   2 +-
 .../templates/package_built_dependencies.html      |   8 +-
 .../toastergui/templates/package_built_detail.html |  14 +-
 .../templates/package_included_dependencies.html   |   8 +-
 .../templates/package_included_detail.html         |  14 +-
 .../package_included_reverse_dependencies.html     |  19 +--
 lib/toaster/toastergui/templates/recipe.html       |   4 +-
 lib/toaster/toastergui/templates/tablesort.html    |  38 +++++
 lib/toaster/toastergui/templates/target.html       |   4 +-
 lib/toaster/toastergui/templates/task.html         |   2 +-
 lib/toaster/toastergui/templatetags/projecttags.py |  20 +--
 lib/toaster/toastergui/views.py                    | 158 ++++++++++++++++-----
 lib/toaster/toastermain/settings.py                |  10 +-
 16 files changed, 211 insertions(+), 97 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/tablesort.html

-- 
1.9.1


