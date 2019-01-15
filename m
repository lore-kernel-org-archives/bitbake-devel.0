Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D0EA66C0F6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 21:32:01 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0FLVdHn026540
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 15 Jan 2019 13:31:39 -0800 (PST)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 15 Jan 2019 13:31:38 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Jan 2019 16:31:30 -0500
Message-ID: <20190115213137.113956-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 0/7 v2] gitsm.py: submodule init and ssh url processing
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
X-List-Received-Date: Tue, 15 Jan 2019 21:32:01 -0000
Content-Type: text/plain

v2:

A lot has been added and reported here.  The original patch set had a
few minor tweaks made to them.  However there was still a bug when
processing shallow submodules.  This was corrected, along with a report
of download conflicts with multipel downloaders.  (Fixed by inspection,
but since I can't reproduce it -- I have to believe it's resolved.)

Additionally, the last commit refactors the code and adds some additional
test cases to the upstream test respositories.

As with the v1 patch, there is a specific 'ssh' style URI conversion test
that happens only if the test case is manually activated by changing the
URL.

v1 info:

This patch set covers two different items.  The first is work that started
before Christmas where someone noticed a repository that had a defined
gitmodule, but it was never initialized.  The first patch deals with that
issue.  (Thanks Raphael Lisicki for the fix approach...)

The second set works through the issues that Linus Ziegert, and
Krystian Garlinski have brought up on the list.  This fix takes a
different approach then Linus's approach of adding a specific regex.
Instead we look for '://', if we find it -- its a URL, otherwise we
look for ':' -- finding that it must be 'ssh style', otherwise it
has to be a file URL.  I think this simplifies the overall approach.

Finally a test case was developed.  See:

http://git.yoctoproject.org/cgit/cgit.cgi/git-submodule-test/tree/.gitmodules?h=ssh-gitsm-tests

for the specific .gitmodules file that was tested.  I would appreciate
it if the people experiencing problems could try out this code and
verify it works in their configurations.

RP - in the last patch, I wasn't sure how to switch which URL is used.
Either the original simplified testing or the more complex ssh based tests.
Any suggestions on a better way to handle this?

Mark Hatle (7):
  gitsm.py: Fix when a submodule is defined, but not initialized
  gitsm.py: Add support for alternative URL formats from submodule files
  tests/fetch.py: Add alternative gitsm test case
  gitsm.py: Optimize code and attempt to resolve locking issue
  gitsm.py: revise unpack
  gitsm.py: Rework the shallow fetcher and test case
  gitsm.py: Refactor the functions and simplify the class

 lib/bb/fetch2/gitsm.py | 257 ++++++++++++++++++++-----------------------------
 lib/bb/tests/fetch.py  |  24 ++++-
 2 files changed, 125 insertions(+), 156 deletions(-)

-- 
1.8.3.1


