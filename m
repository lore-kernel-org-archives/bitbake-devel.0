Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 121D073B10
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68Ex8aI026575; Wed, 8 Jul 2015 15:59:08 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ddhe8hOIltrZ; Wed,  8 Jul 2015 15:59:08 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68Ex48u026569
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:05 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqoM-0004R9-T3; Wed, 08 Jul 2015 15:58:58 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:58:55 +0100
Message-Id: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 00/16] update_data() removal patchset
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:10 -0000

Removing the need for finalization or update_data is something we've
idly thought about for a long time. Basically, the whole idea of a
specific finalization phase to the data store causes a lof of issues and
horrible corner cases. For example, should bitbake call update_data,
then expandKeys, or the other way around? Or should we keep calling
update_data until nothing changes?

Through careful thought of some operations and working around the corner
case problems, we've avoided most of the issues however there are some
things we keep observing:

* We keep needing "expanded" data stores in different parts of the 
  system alongside their unexpanded versions
* Few people understand why/when exactly they should call update_data()
* Its near impossible to set PREFERRED_PROVIDERS of recipes which are 
  dynamically named (gcc-cross-${TARGET_ARCH}) along with overrides. 
  This is something meta-darwin/mingw/baremetal could really use.

The alternative is a datastore which dynamically adjusts when anything
changes so that the work is done at getVar time rather than precaching
things at update_data time.

What is missing from the branch as yet is removal of the "expanded" data
stores from use within bitbake and starting to remove the update_data
calls (which are now just empty calls). This can happen once the code
is merged/stablising.

The following changes since commit f883cf240266ee7be2cbd8971a8164cf4df9e372:

  cooker: Improve DATE/TIME handling (2015-07-08 00:06:01 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake noupdatedata
  http://cgit.openembedded.org/cgit.cgi/bitbake/log/?h=noupdatedata

Richard Purdie (16):
  data_smart: Defer append/prepend handling
  data_smart: Remove need for update_data calls
  data_smart: Improve override handling
  data_smart: Fix cache clearance problems
  data_smart: Cache overrides and fix data store
  data_smart: Move override handling to getVar
  parse/ast/data_smart: Add parsing flag to getVar/setVar
  data_smart: VariableHistory: Ignore override duplicates and overlap
    with CoW functions
  data_smart: Seperate out the override cache
  data_smart: Tweak OVERRIDES value cache for performance
  data_smart: Improve override recursion handling
  data_smart: Cache set(self.overrides)
  data_smart: Fix keys() missing overrides
  data_smart: Fix data expansion cache issues
  data_smart: Fix appendVar/prependVar
  tests/data: Add new data tests

 lib/bb/data_smart.py  | 337 ++++++++++++++++++++++++++++++--------------------
 lib/bb/parse/ast.py   |  14 +--
 lib/bb/tests/data.py  |  47 +++++++
 lib/bb/tests/parse.py |  46 +++++++
 4 files changed, 306 insertions(+), 138 deletions(-)

-- 
2.1.0


