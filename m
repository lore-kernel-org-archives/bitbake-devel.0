Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 5FA5B778B2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 05:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 0CEE111A001
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 6rCxFoyIHsH5 for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:19 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bes.se.axis.com (Postfix) with ESMTPS id A54FC2E3BD
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91AC61A077
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86BDC1A075
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 7AE5A211
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v2B5MIkV004381
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:22:18 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v2B5MIQM004354
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Mar 2017 06:22:18 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 11 Mar 2017 06:22:14 +0100
Message-Id: <cover.1489209703.git.pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [PATCH 0/3] Improve bitbake-dumpsig
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
X-List-Received-Date: Sat, 11 Mar 2017 05:22:21 -0000

This adds support to bitbake-dumpsig to specify the signature file to
dump by specifying a recipie and task using --task (-t), the same way
it is possible to do for bitbake-diffsigs.

It also adds support to bitbake-dumpsig and bitbake-diffsigs to output
some debug data (currently the names of the identified signature
files) by specifying --debug (-D).

//Peter

The following changes since commit 760e81678cec80dcdaab12c2a0a0148e3e0ba275:

  go: Add recipes for golang compilers and tools (2017-03-10 15:51:55 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/bitbake-dumpsig
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/bitbake-dumpsig

Peter Kjellerstedt (3):
  bitbake-dumpsig: Allow recipe and task to be specified
  bitbake-dumpsig: Add debug support
  bitbake-diffsigs: Add debug support

 bitbake/bin/bitbake-diffsigs |  9 +++++++
 bitbake/bin/bitbake-dumpsig  | 61 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.12.0


