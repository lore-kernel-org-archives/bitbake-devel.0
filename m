Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1URh3y-0004B4-Mv
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Apr 2013 12:55:07 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Apr 2013 03:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,474,1363158000"; d="scan'208";a="286240160"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.147])
	by azsmga001.ch.intel.com with ESMTP; 15 Apr 2013 03:37:35 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Apr 2013 13:38:12 +0300
Message-Id: <1366022295-4744-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/3] Generic bitbake errors for hob ui
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
X-List-Received-Date: Mon, 15 Apr 2013 10:55:09 -0000

Implemented a way to handle generic bitbake errors when
starting a ui ( in this case hob ).

[HOB #3909]

Andrei Dinu (3):
  bitbake : handle each ui error
  hob.py : implemented handle_sys_exit() for hob
  hoberror.py : new class in handling hob errors

 bitbake/bin/bitbake                      |   13 +++--
 bitbake/lib/bb/ui/crumbs/hig/hoberror.py |   87 ++++++++++++++++++++++++++++++
 bitbake/lib/bb/ui/hob.py                 |    8 ++-
 3 files changed, 103 insertions(+), 5 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/hoberror.py

-- 
1.7.9.5



