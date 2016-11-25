Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 20B4260796
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Nov 2016 16:30:25 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 25 Nov 2016 08:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,547,1473145200"; d="scan'208";a="1073434122"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.26.83])
	by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2016 08:30:25 -0800
From: Joshua Lock <joshua.g.lock@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Nov 2016 16:30:21 +0000
Message-Id: <cover.1480091225.git.joshua.g.lock@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/2] remove True option to getVar / getVarFlag calls
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
X-List-Received-Date: Fri, 25 Nov 2016 16:30:26 -0000

My patch 1/2 is held for moderation so here's a cover letter pointing to
a branch with the two patches which remove the True option to getVar()
and getVarFlag () calls now that expanding is the default.

The following changes since commit d140f0ee6f301264e226914766d9f63558acfd6c:

  COW.py: fix sample codes (2016-11-23 10:59:49 +0000)

are available in the git repository at:

  https://github.com/incandescant/bitbake.git joshuagl/getvar
  https://github.com/incandescant/bitbake/tree/joshuagl/getvar

Joshua Lock (2):
  bitbake: remove True option to getVar calls
  bitbake: remove True option to getVarFlag calls

 bin/bitbake-layers                                 |  2 +-
 bin/bitbake-worker                                 |  6 +-
 .../bitbake-user-manual-fetching.xml               |  4 +-
 .../bitbake-user-manual-metadata.xml               |  8 +--
 lib/bb/build.py                                    | 46 +++++++--------
 lib/bb/cache.py                                    | 10 ++--
 lib/bb/cooker.py                                   | 42 ++++++-------
 lib/bb/cookerdata.py                               | 12 ++--
 lib/bb/data.py                                     | 26 ++++-----
 lib/bb/data_smart.py                               | 16 ++---
 lib/bb/fetch2/__init__.py                          | 68 +++++++++++-----------
 lib/bb/fetch2/clearcase.py                         | 10 ++--
 lib/bb/fetch2/cvs.py                               | 14 ++---
 lib/bb/fetch2/git.py                               | 12 ++--
 lib/bb/fetch2/hg.py                                | 10 ++--
 lib/bb/fetch2/local.py                             | 12 ++--
 lib/bb/fetch2/npm.py                               | 20 +++----
 lib/bb/fetch2/osc.py                               | 10 ++--
 lib/bb/fetch2/perforce.py                          |  8 +--
 lib/bb/fetch2/repo.py                              |  4 +-
 lib/bb/fetch2/sftp.py                              |  2 +-
 lib/bb/fetch2/ssh.py                               |  4 +-
 lib/bb/fetch2/svn.py                               |  2 +-
 lib/bb/fetch2/wget.py                              | 12 ++--
 lib/bb/monitordisk.py                              |  4 +-
 lib/bb/parse/__init__.py                           |  2 +-
 lib/bb/parse/ast.py                                | 14 ++---
 lib/bb/parse/parse_py/BBHandler.py                 |  2 +-
 lib/bb/parse/parse_py/ConfHandler.py               |  6 +-
 lib/bb/persist_data.py                             |  4 +-
 lib/bb/providers.py                                | 12 ++--
 lib/bb/runqueue.py                                 | 32 +++++-----
 lib/bb/siggen.py                                   | 14 ++---
 lib/bb/tests/codeparser.py                         | 12 ++--
 lib/bb/tests/data.py                               | 58 +++++++++---------
 lib/bb/tests/parse.py                              | 28 ++++-----
 lib/bb/utils.py                                    | 16 ++---
 lib/bblayers/action.py                             |  2 +-
 lib/bblayers/common.py                             |  2 +-
 lib/bblayers/layerindex.py                         |  8 +--
 lib/bblayers/query.py                              | 10 ++--
 lib/prserv/serv.py                                 |  4 +-
 42 files changed, 295 insertions(+), 295 deletions(-)

-- 
2.7.4


