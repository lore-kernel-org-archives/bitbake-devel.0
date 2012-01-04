Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RiRnk-0000Lr-Sg
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jan 2012 15:26:49 +0100
Received: by opal (Postfix, from userid 111)
	id 5445D10331; Wed,  4 Jan 2012 14:27:02 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120104142702.5445D10331@opal>
Date: Wed,  4 Jan 2012 14:27:02 +0000 (UTC)
From: git@git.openembedded.org
Subject: Juraj Hercek : fetch2/git: change colon to dot in ud.host
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
X-List-Received-Date: Wed, 04 Jan 2012 14:26:49 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 1f2867b79f1cd2bfbdc849ba5677a39db6fa3396
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=1f2867b79f1cd2bfbdc849ba5677a39db6fa3396

Author: Juraj Hercek <juraj.hercek@jhksoftware.com>
Date:   Thu Dec 22 15:21:12 2011 +0100

fetch2/git: change colon to dot in ud.host

Local cloning of git repositories from DL_DIR into WORKDIR fails when
using ssh URL with port specification e.g.
"ssh://user@host:port/path/to/repo.git". Git fetcher clones such remote
repository into "${DL_DIR}/git2/host:port.path.to.repo.git". However,
when clonging from ${DL_DIR}/git2/host:port.path.to.repo.git into
${WORKDIR}, git fetcher fails with "ssh: Could not resolve hostname
${DLDIR}/git2/host: Name or service not known".

A solution is to replace ":" by "." in host component, similarly as it
is done when replacing "/" with "." in path component, so that local
clone directory in DL_DIR looks like this: "host.port.path.to.repo.git".

Signed-off-by: Juraj Hercek <juraj.hercek@jhksoftware.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/fetch2/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f203c5a..d833714 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -115,7 +115,7 @@ class Git(FetchMethod):
                 ud.branches[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud.url, ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host, ud.path.replace('/', '.'))
+        gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.'))
         # for rebaseable git repo, it is necessary to keep mirror tar ball
         # per revision, so that even the revision disappears from the
         # upstream repo in the future, the mirror will remain intact and still



