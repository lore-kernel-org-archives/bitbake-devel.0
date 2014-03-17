Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id EFCC96F724
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Mar 2014 18:18:00 +0000 (UTC)
Received: by mail-wi0-f178.google.com with SMTP id bs8so1737422wib.17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Mar 2014 11:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=+s3Mw11Js+BgyPjRDhMmW1YotjAe6WUanBc7xlMIXqE=;
	b=ObsucWKmC5jtgLqsdGQbyPtfPeIuGXfhkJhtg1brbos1ZCXYTuq01dw3hnUQr+YsWn
	SZ2a6vZlqrmjHbQoO8r36xWbSOZh25qyWKvIIX31DjMphTK20kDLBwi+nxBdDeOmc8C8
	yPxmWq+4pxXfvd6Wxx5bArPzODbbJYvtD0EotTJDGCTDf5VqfkSNs3h+m2R3YJwlocl6
	hHpOLVBJMdNAopWK9+3Xv83GmJzlOZ8oSrp5bOKXZjMQXJDgk27ILFxwBdP1SHhxIqZ8
	Jv92Jo1hWcqOVxNFak20fVX2e/3hJhnER3vejnhGCHMtdYQwQerDf7jvBmo/xuUKaQqo
	8uPg==
X-Gm-Message-State: ALoCoQm5f93mTq9S2JmH4pxsbiqZynt04JNsWzTYBKsDhA1beau3+ggcPF8uI1PF/ycTNF93GA4Q
X-Received: by 10.194.59.226 with SMTP id c2mr19440816wjr.6.1395080280985;
	Mon, 17 Mar 2014 11:18:00 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id r1sm26455899wia.5.2014.03.17.11.17.58
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 17 Mar 2014 11:17:59 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0D87E564254; Mon, 17 Mar 2014 18:17:57 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Mar 2014 18:17:55 +0000
Message-Id: <cover.1395080167.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Dave Lerner <dave.lerner@windriver.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 00/10] Toaster upstream submission
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
X-List-Received-Date: Mon, 17 Mar 2014 18:18:01 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is the toaster upstream submission for the patches reviewed up until 17 04 2014.

The following changes since commit cc98b19112ab875ebc7cb604cd96acadac4cbf21:

  hob: sync after image deploy (2014-03-17 15:57:25 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/submission-bb-17032014
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/submission-bb-17032014

Alexandru DAMIAN (1):
  toaster: measure task duration with server-side timestamps

Belen Barros Pena (6):
  toaster: Add link to the Toaster manual
  toaster: Remove trailing spaces from 'name'
  toaster: Change "Package version" to "Version"
  toaster: Remove extra space in the breadcrumb
  toaster: Set display of "Cache attempt" column
  toaster: Amend failed tasks behaviour

Dave Lerner (2):
  toaster: add jquery treetable plugin
  toaster: image information views

David Reyna (1):
  toaster: filter out setscene tasks in recipe details

 lib/bb/build.py                                    |   2 +
 lib/bb/ui/buildinfohelper.py                       |  11 +-
 lib/toaster/orm/models.py                          |   5 +-
 lib/toaster/toastergui/static/css/default.css      |   2 +-
 .../toastergui/static/css/jquery.treetable.css     |  28 +
 .../static/css/jquery.treetable.theme.default.css  |  64 +++
 .../static/css/jquery.treetable.theme.toaster.css  |  38 ++
 lib/toaster/toastergui/static/css/screen.css       |  28 +
 .../jquery-treetable-license/GPL-LICENSE.txt       | 278 +++++++++
 .../jquery-treetable-license/MIT-LICENSE.txt       |  20 +
 .../static/jquery-treetable-license/README.md      |  20 +
 .../static/jquery.treetable.theme.toaster.css      |  66 +++
 .../toastergui/static/js/jquery.treetable.js       | 620 +++++++++++++++++++++
 lib/toaster/toastergui/templates/base.html         |   4 +-
 .../toastergui/templates/basebuildpage.html        |   4 +-
 lib/toaster/toastergui/templates/build.html        |   2 +-
 lib/toaster/toastergui/templates/dirinfo.html      | 237 ++++++++
 .../templates/package_included_detail.html         |   2 +-
 .../package_included_reverse_dependencies.html     |   2 +-
 lib/toaster/toastergui/templates/target.html       | 153 ++++-
 lib/toaster/toastergui/templatetags/projecttags.py |  49 ++
 lib/toaster/toastergui/urls.py                     |   4 +-
 lib/toaster/toastergui/views.py                    | 284 +++++++++-
 23 files changed, 1876 insertions(+), 47 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/css/jquery.treetable.css
 create mode 100644 lib/toaster/toastergui/static/css/jquery.treetable.theme.default.css
 create mode 100644 lib/toaster/toastergui/static/css/jquery.treetable.theme.toaster.css
 create mode 100644 lib/toaster/toastergui/static/css/screen.css
 create mode 100644 lib/toaster/toastergui/static/jquery-treetable-license/GPL-LICENSE.txt
 create mode 100644 lib/toaster/toastergui/static/jquery-treetable-license/MIT-LICENSE.txt
 create mode 100644 lib/toaster/toastergui/static/jquery-treetable-license/README.md
 create mode 100644 lib/toaster/toastergui/static/jquery.treetable.theme.toaster.css
 create mode 100644 lib/toaster/toastergui/static/js/jquery.treetable.js
 create mode 100644 lib/toaster/toastergui/templates/dirinfo.html

-- 
1.8.3.2


