Received: from ecbiz66.inmotionhosting.com ([69.174.114.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <juraj.hercek@jhksoftware.com>) id 1RdmAn-0003Np-Mu
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Dec 2011 18:11:17 +0100
Received: from mail.hck.sk ([87.197.106.197]:64952 helo=localhost.localdomain)
	by ecbiz66.inmotionhosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <juraj.hercek@jhksoftware.com>)
	id 1RdjWs-00083W-Qd; Thu, 22 Dec 2011 09:21:55 -0500
From: Juraj Hercek <juraj.hercek@jhksoftware.com>
To: Bitbake Devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Dec 2011 15:21:12 +0100
Message-Id: <1324563672-26403-2-git-send-email-juraj.hercek@jhksoftware.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324563672-26403-1-git-send-email-juraj.hercek@jhksoftware.com>
References: <1324563672-26403-1-git-send-email-juraj.hercek@jhksoftware.com>
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - ecbiz66.inmotionhosting.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - jhksoftware.com
Subject: [PATCH] fetch2/git: change colon to dot in ud.host
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
X-List-Received-Date: Thu, 22 Dec 2011 17:11:17 -0000

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
-- 
1.7.2.5



