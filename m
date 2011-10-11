Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RDg6D-0007C3-W2
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Oct 2011 19:26:42 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 11 Oct 2011 10:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,524,1312182000"; d="scan'208";a="72439800"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.64])
	by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2011 10:20:56 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Oct 2011 10:20:49 -0700
Message-Id: <cover.1318353511.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.4
Subject: [PATCH 0/1] Fix a silly hob bug
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 11 Oct 2011 17:26:42 -0000

Dismissing the open file dialog in hob results in a backtrace, this is due
to a stupid logic/indentation error on my part - the following patch
rectifies this.

Regards,
Joshua

The following changes since commit dca46cc2e1c75b6add2c4801e2994a4812745f5b:

  fetch2: Export additional variables to the fetchers (2011-10-05 14:23:16 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (1):
  hob: fix backtrace when dismissing open dialog

 lib/bb/ui/hob.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.6.4



