Return-Path: <alejandro.franco@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E601474197
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 20:55:43 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 31 Aug 2015 13:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,443,1437462000"; d="scan'208";a="794884553"
Received: from afshjern.zpn.intel.com ([10.219.128.45])
	by orsmga002.jf.intel.com with ESMTP; 31 Aug 2015 13:55:43 -0700
From: Alex Franco <alejandro.franco@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Aug 2015 15:56:08 -0500
Message-Id: <1441054569-1661-1-git-send-email-alejandro.franco@linux.intel.com>
X-Mailer: git-send-email 2.5.1
Cc: david.nystrom@enea.com, clarson@kergoth.com
Subject: [PATCHv3 0/1] Allow bitbake commands starting with do_
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
X-List-Received-Date: Mon, 31 Aug 2015 20:55:44 -0000

The output of "bitbake, -c listtasks pkg" lists tasks with their real names
(starting with "do_"), but then "bitbake -c do_task" fails, as "do_" always
gets unconditionally prepended to task names. This patch handles this error
by always removing "do_" from the beginning of task names when the runqueue
is being constructed.

[YOCTO #7818]

Changes since v1: removed regex, using string.replace
Changes since v2: removed string.replace, using slice

Signed-off-by: Alex Franco <alejandro.franco@linux.intel.com>

Alex Franco (1):
  Allow bitbake commands starting with do_

 bitbake/lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.5.1


