Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 7DB7F79514
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Aug 2018 04:18:04 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Aug 2018 21:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,280,1531810800"; d="scan'208";a="64810882"
Received: from pradhand-mobl.gar.corp.intel.com (HELO localhost.localdomain)
	([10.255.140.136])
	by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2018 21:18:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Aug 2018 16:17:53 +1200
Message-Id: <cover.1535084244.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 0/1] parse/ast: ensure saved event handlers really do get restored
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
X-List-Received-Date: Fri, 24 Aug 2018 04:18:04 -0000

The following changes since commit 49c3fd2489867c09dec6919a25b53d935a8204bb:

  bitbake: Bump version 1.39.0 -> 1.39.1 (2018-08-23 09:02:49 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib paule/fix-event-save-restore
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/fix-event-save-restore

Paul Eggleton (1):
  parse/ast: ensure saved event handlers really do get restored

 lib/bb/parse/ast.py | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

-- 
2.17.1


