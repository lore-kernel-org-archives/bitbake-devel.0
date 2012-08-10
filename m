Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1Szeeh-00031b-Cv
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Aug 2012 04:08:51 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7A1v1S6002313
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2012 18:57:01 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Thu, 9 Aug 2012 18:57:01 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 Aug 2012 10:02:30 +0800
Message-ID: <86c6fef246be4e70f22d24754abbc920470d5997.1344564039.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <cover.1344564039.git.liezhi.yang@windriver.com>
References: <cover.1344564039.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] bitbake.conf: add BB_STAMPS_DIR for constructing STAMP
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
X-List-Received-Date: Fri, 10 Aug 2012 02:08:51 -0000
Content-Type: text/plain

Add BB_STAMPS_DIR for constructing STAMP, the defination of STAMP
before:

STAMP = "${TMPDIR}/stamps/${MULTIMACH_TARGET_SYS}/${PF}

We can only change the TMPDIR if we want to change the STAMP's location,
but the cache would be regenerated if TMPDIR changed, so add
BB_STAMPS_DIR for constructing it, and add it to the BB_ENV_EXTRAWHITE,
this is very usefull for the "bitbake -S", since then it can be run by:

BB_STAMPS_DIR=<path> bitbake -S <recipe>

which will avoid putting the stamps to ${TMPDIR}/stamps.

BTW, break the too long BB_ENV_EXTRAWHITE into several lines.

[YOCTO #1659]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 meta/conf/bitbake.conf       | 3 ++-
 scripts/oe-buildenv-internal | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index d5a43e9..8440e65 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -332,7 +332,8 @@ GITDIR = "${CO_DIR}/git2"
 BZRDIR = "${CO_DIR}/bzr"
 HGDIR = "${CO_DIR}/hg"
 
-STAMP = "${TMPDIR}/stamps/${MULTIMACH_TARGET_SYS}/${PF}"
+BB_STAMPS_DIR ?= "${TMPDIR}/stamps"
+STAMP = "${BB_STAMPS_DIR}/${MULTIMACH_TARGET_SYS}/${PF}"
 WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PF}"
 T = "${WORKDIR}/temp"
 D = "${WORKDIR}/image"
diff --git a/scripts/oe-buildenv-internal b/scripts/oe-buildenv-internal
index 32c0ba0..2674ff7 100755
--- a/scripts/oe-buildenv-internal
+++ b/scripts/oe-buildenv-internal
@@ -75,4 +75,7 @@ unset BITBAKEDIR
 # Used by the runqemu script
 export BUILDDIR
 export PATH
-export BB_ENV_EXTRAWHITE="MACHINE DISTRO TCMODE TCLIBC http_proxy ftp_proxy https_proxy all_proxy ALL_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY SDKMACHINE BB_NUMBER_THREADS PARALLEL_MAKE GIT_PROXY_COMMAND GIT_PROXY_IGNORE SOCKS5_PASSWD SOCKS5_USER SCREENDIR"
+export BB_ENV_EXTRAWHITE="MACHINE DISTRO TCMODE TCLIBC http_proxy ftp_proxy
+    https_proxy all_proxy ALL_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY
+    SDKMACHINE BB_NUMBER_THREADS PARALLEL_MAKE GIT_PROXY_COMMAND GIT_PROXY_IGNORE
+    SOCKS5_PASSWD SOCKS5_USER SCREENDIR BB_STAMPS_DIR"
-- 
1.7.11.2



