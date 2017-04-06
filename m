Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 24FC5775FD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:52:43 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565817"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:52:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:00 +1200
Message-Id: <cover.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 00/11] bitbake-diffsigs fixes/improvements
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
X-List-Received-Date: Thu, 06 Apr 2017 21:52:44 -0000

As part of an effort to add task signature recording and comparison to
buildhistory in OE, I went digging into bitbake-diffsigs and the code
that supports it and discovered that unfortunately it had a number of
bugs - in particular the -t option despite being around for a while and
having numerous band-aids applied in the past still wasn't really
working properly. I have to take a big chunk of the responsibility for
this as I wrote the thing in the first place. This patchset corrects
most of the issues that I found and also makes a number of improvements
to the readability of the output.

NOTE: there are a few corresponding changes required in OE-Core that I
am about to send out, these should be applied at the same time.


The following changes since commit 751c9dc51fd01fa64a1ff37ba2638110335f71af:

  fetch/local: Drop FILESDIR (2017-04-05 09:38:01 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-sigstuff
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-sigstuff

Paul Eggleton (11):
  bitbake-diffsigs: fix -t picking wrong files to compare
  lib/bb/siggen: add missing path separator to cleaned paths
  bitbake-diffsigs: properly report which signature is missing
  bitbake-diffsigs: drop naive logic for removing duplicate files
  lib/bb/siggen: show a diff when dumping changes to multi-line values
  lib/bb/siggen: don't show unchanged runtaskdeps list
  bitbake-diffsigs: change to use argparse
  bitbake-diffsigs: add an option to find and compare specific signatures
  lib/bb/siggen: add collapsed mode to compare_sigfiles()
  lib/bb/siggen: show word-diff for single-line values containing spaces
  bitbake-diffsigs: colourise output

 LICENSE                    |   2 +
 bin/bitbake-diffsigs       | 175 +++++++++++++++++++++------------------
 lib/bb/siggen.py           | 166 +++++++++++++++++++++++++++++--------
 lib/simplediff/LICENSE     |  22 +++++
 lib/simplediff/__init__.py | 198 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 453 insertions(+), 110 deletions(-)
 create mode 100644 lib/simplediff/LICENSE
 create mode 100644 lib/simplediff/__init__.py

-- 
2.9.3


