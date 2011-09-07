Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R1Pj8-0000hA-Ss
	for bitbake-devel@lists.openembedded.org;
	Wed, 07 Sep 2011 23:32:11 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 07 Sep 2011 14:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,347,1312182000"; d="scan'208";a="49049536"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.159])
	by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2011 14:27:07 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Sep 2011 14:27:00 -0700
Message-Id: <cover.1315406971.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [RFC PATCH 0/1] Don't use set() for datastore variables
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
X-List-Received-Date: Wed, 07 Sep 2011 21:32:11 -0000

This is an RFC patch.

I recently implemented a check within the hob gui to ensure that it's running with the
required pre and post configuration files. However this check uses a variable from the data
store which is a Python set container.

The Python xmlrpclib is unable to marshal sets and therefore the patch I added breaks hob
when using the xmlrpc server backend.

I've assumed that storing variables in the datastore that cannot be accessed using the
getVariable API with each of our servers is a bad thing and the attached patch changes the
use of set to a dict.

There are, of course, alternative workarounds for this issue. For example, we could create a
new variable to list file dependencies, but that seems a little wasteful? Or we could add
some logic to the xmlrpc server to ensure it doesn't try and marshal unsupported types?

Comments?

Regards,
Joshua

The following changes since commit 24272dae15ccf641ece11ef5a6e2bfa3ebb6f5f9:

  lib/bb/siggen.py: return a string from noop get_taskhash (2011-09-05 20:16:08 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (1):
  cache|cooker|parse: switch __depends from a set to a dict

 lib/bb/cache.py          |   11 ++++++-----
 lib/bb/cooker.py         |    8 ++++----
 lib/bb/parse/__init__.py |    4 ++--
 lib/bb/ui/hob.py         |    8 ++++----
 4 files changed, 16 insertions(+), 15 deletions(-)

-- 
1.7.6



