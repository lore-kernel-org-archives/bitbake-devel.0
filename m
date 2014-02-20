Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 554CF6B5C9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 537E8186F9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 16:32:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id bIN7jVMlwb9d for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 16:32:03 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id BB21918592
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id A1795AA4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 95FCAA90
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 93D4834005
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id s1KEtrCv021094
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id s1KEtrXX021089
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Feb 2014 15:55:53 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Feb 2014 15:55:50 +0100
Message-Id: <cover.1392908060.git.pkj@axis.com>
X-Mailer: git-send-email 1.8.4
Subject: [PATCH 0/1] Avoid problem with Git fetcher hanging
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
X-List-Received-Date: Thu, 20 Feb 2014 15:32:12 -0000

This fixes a problem we have had for a long time where a build on rare
occasions hangs. The problem was due to the Git fetcher trying to use
git ls-remote to determine the SHA-1 for a tag. If this happened when
pseudo was active, git (or rather ssh) would hang indefinitely.

//Peter

The following changes since commit 54562006c1327c5b99daa4cc05a3ba7e38412da1:

  image_types.bbclass: Fix tar IMAGE_CMD to not change directories (2014-02-18 08:38:52 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/no_pseudo_for_git
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/no_pseudo_for_git

Peter Kjellerstedt (1):
  bitbake: Disable pseudo in runfetchcmd()

 bitbake/lib/bb/fetch2/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.8.4


