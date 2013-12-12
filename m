Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8BB566C732
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 16:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 4D9BA3F215D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8eZiQykWeLaU for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 3283413BE4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 1263CBE7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 0785E937
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 05E113404E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Thu, 12 Dec 2013
	17:48:58 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id BFBF39C079; 
	Thu, 12 Dec 2013 17:48:58 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Dec 2013 17:48:53 +0100
Message-ID: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.4.rc3
MIME-Version: 1.0
Subject: [RFC 0/5] Git fetcher changes for resolving tags
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
X-List-Received-Date: Thu, 12 Dec 2013 16:49:00 -0000
Content-Type: text/plain

Hi,

We use the git fetcher for our internal recipes, and we are supplying
;tag=<tag> to the SRC_URI. As the tag doesn't look like a sha1 hash, bitbake
treats this as a branch name. After the changes that made bitbake verify that a
commit is present on the specified branch, this led to errors. Richard fixed
this issue, in a patch included in this patch series.

Additionally, the change also uncovered issues we had with git ls-remote not
returning the sha1 we expect, in cases where a branch ends with the tag name
you are looking for, for instance:

$ git ls-remote <url> v1.2.3
981e76c984cb5513be7e8d1b7e3cab979c3a957e        refs/heads/foo/v1.2.3
dc171f81eebc887f72a2a973f5e5fc54ce1bbaca        refs/tags/v1.2.3

The current _latest_revision implementation would just do .split()[0], and
happily return 981e76c. My suggested solution is to first try
refs/tags/v1.2.3^{} and then move on to refs/heads/v1.2.3. This changes the
behavior for the cases were either a branch or a tag is specified: you would
never get the foo/v1.2.3 branch, as it's not an exact match.


Also in this patch series is a unit test suite for the git fetcher and some
minor refactoring of the fetcher itself. These tests should complement the more
high level tests already present in bb.tests.fetch.


Olof Johansson (4):
  bb.fetch2.git: reuse basecmd attribute
  bb.tests.fetch_git: initial set of tests for git fetcher
  bb.fetch2.git: support resolving both tags and branches
  bb.fetch2.git: use the _gen_git_url() function

Richard Purdie (1):
  fetch2/git: Improve handling of unresolved names verses branches

 bin/bitbake-selftest      |   3 +-
 lib/bb/fetch2/git.py      | 104 ++++++++++++++-----
 lib/bb/tests/fetch_git.py | 259 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+), 29 deletions(-)
 create mode 100644 lib/bb/tests/fetch_git.py

-- 
1.8.4.rc3


