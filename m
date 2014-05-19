Return-Path: <Peter.Seebach@windriver.com>
Received: from mail.windriver.com (unknown [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2339B65FE5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 21:48:25 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s4JLmQPZ008150
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 14:48:26 -0700 (PDT)
Received: from msp-lpggp2.wrs.com (172.25.34.109) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.169.1;
	Mon, 19 May 2014 14:48:26 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 19 May 2014 16:52:43 -0500
Message-ID: <cover.1400270358.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Subject: [PATCH 0/1] utils.py: default mode on mkdirhier
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
X-List-Received-Date: Mon, 19 May 2014 21:48:26 -0000
Content-Type: text/plain

It turns out that bb.utils.mkdirhier() is occasionally called with
widely varying umasks, including but not limited to 022, 002, or 0.
This can result in unpredictable directory permissions, depending on
which context you were in when a directory got made, and it can
also result in mode 777 directories, which are Probably Bad. (The
most obvious case involves packages-split being created by
accident with umask 0 in populate_packages, shortly before a later
attempt to create it with umask 022.)

I've done test builds with this modification, and nothing seemed to
go wrong. I used an optional argument, rather than just hard-coding
the 0755, because if I use an optional argument it will always
be right, but if I don't I'm sure it will turn out to break something.

The following changes since commit d150226d11d5f041f78c8c3ce4abc5465dbc81d8:

  fetch2/perforce: Ensure command has a default (2014-05-11 15:25:47 +0100)

are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib seebs/mkdirhier
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/mkdirhier

Peter Seebach (1):
  utils.py: default mode for mkdirhier

 lib/bb/utils.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


