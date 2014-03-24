Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id D11336F77C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:27 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so3716172wes.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=GcHE205WwIe1iKvVUnZxvptv0ZtWzS7Vmtyj4vs99cM=;
	b=i+aNNRz05uCFlul/8b5VYmmZq5EroS9zgecA2uADsNltltmFWpwhjaBUBGgkU0Fhw+
	gmjQh6tVr889ZGf+tumQafa/9SQ3QC2JFoBqlIw3AAuINKFcEKCiXgaKJihAA6ELHBG9
	cdESl3B8xCJOdGXCq1TaEhLlA5uQARuBxdsQB2RQ0rv5BI3vUblc5R1k9RfgJiCIgMHe
	LbQOHix9cD+rbx2T/bSo5gizkigxauH6+FQMbfTVxUcBaW/D1VulUfDKHZyqKK82wqfX
	6QDVUwe23rKbTURlprmrNsPgz5oGmRBd1z3kPezIYwQOakNZlTLWkRRsN4LkIbL18Cl3
	4ZkQ==
X-Gm-Message-State: ALoCoQltK1GTFNq9xq/sCjKnkpX1bUJnffWmKufu8oIYdTaKdH0V75Ck6i5Lv27E+bM6eWRAYL3C
X-Received: by 10.181.11.169 with SMTP id ej9mr17990234wid.18.1395686248478;
	Mon, 24 Mar 2014 11:37:28 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t6sm41427074wix.4.2014.03.24.11.37.26
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id F4072560C23; Mon, 24 Mar 2014 18:37:25 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:24 +0000
Message-Id: <cover.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Amit Kumar Chaudhary <amit@floatingpondtech.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>,
	Dave Lerner <dave.lerner@windriver.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 00/18] toaster patchset
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:31 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a pull-request for toaster. It includes fixes for data collection and
for the UI. The patches have been reviewed on the toaster mailing list.

Can you please merge this ?

Thank you,
Alex

The following changes since commit f34575809677dc52e1071a3ae3daebe92819cec0:

  hob: output filenames based on initial recipe name (2014-03-24 10:13:58 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140324-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140324-submission-bb

Alexandru DAMIAN (5):
  toaster: Revert "added file types to the Outputs column in the build
    page"
  toaster: select recipe based on PN name
  toasterui: save missed sstate tasks
  toaster: clean exit on bb server shutdown
  toaster: replace package dependency tag w/ view queries

Amit Kumar Chaudhary (1):
  toaster: combine ready functions

Belen Barros Pena (5):
  toaster: Change objectname 'packages' to 'packages built'
  toaster: Fix alignment issue in searchform
  toaster: Add help text to filters
  toaster: Update local configuration counter
  toaster: Change "0 found" to "No found"

Cristiana Voicu (1):
  bitbake toaster: check the file_name with the content of the
    IMAGE_FSTYPES variable

Dave Lerner (1):
  toaster: fix package size 1st sort order

David Reyna (3):
  toaster: warn new filter replaces existing filter
  toaster: reset default filter for configvar page on new searches
  toaster: add search by section to all recipe page

Irina Patru (1):
  toaster: Remove circular dependecies from packages/recipes

Marius Avram (1):
  toaster: apply filter only on selected attributes

 bin/toaster                                        | 28 +++++++++++-
 lib/bb/ui/buildinfohelper.py                       | 50 ++++++++++++++++------
 lib/bb/ui/toasterui.py                             |  9 +++-
 lib/toaster/orm/models.py                          | 16 ++++++-
 lib/toaster/toastergui/static/css/default.css      |  1 +
 lib/toaster/toastergui/static/js/main.js           |  4 +-
 .../toastergui/templates/basetable_top.html        | 10 ++---
 lib/toaster/toastergui/templates/bpackage.html     |  6 +--
 lib/toaster/toastergui/templates/build.html        |  6 +--
 lib/toaster/toastergui/templates/configvars.html   |  6 +--
 .../toastergui/templates/filtersnippet.html        |  6 +++
 lib/toaster/toastergui/templates/recipes.html      |  6 +--
 lib/toaster/toastergui/templates/target.html       |  4 +-
 lib/toaster/toastergui/templates/tasks.html        |  6 +--
 lib/toaster/toastergui/templatetags/projecttags.py | 41 ++----------------
 lib/toaster/toastergui/views.py                    | 49 ++++++++++++---------
 16 files changed, 144 insertions(+), 104 deletions(-)

-- 
1.8.3.2


