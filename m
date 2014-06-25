Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 2CDD060702
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jun 2014 15:11:59 +0000 (UTC)
Received: from [99.240.204.5] (port=56441 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Wzorg-0008KC-R8 for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jun 2014 11:12:00 -0400
Date: Wed, 25 Jun 2014 11:08:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406251105540.32649@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH] bitbake.conf: Delete long-dead {FETCH, RESUME, UPDATE}COMMAND variables
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
X-List-Received-Date: Wed, 25 Jun 2014 15:12:02 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Delete apparently long-obsolete variable settings in bitbake.conf.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index c2ed926..b96a8fe 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -24,10 +24,6 @@ DEPENDS = ""
 DEPLOY_DIR = "${TMPDIR}/deploy"
 DEPLOY_DIR_IMAGE = "${DEPLOY_DIR}/images"
 DL_DIR = "${TMPDIR}/downloads"
-FETCHCOMMAND = ""
-FETCHCOMMAND_cvs = "/usr/bin/env cvs -d${CVSROOT} co ${CVSCOOPTS} ${CVSMODULE}"
-FETCHCOMMAND_svn = "/usr/bin/env svn co ${SVNCOOPTS} ${SVNROOT} ${SVNMODULE}"
-FETCHCOMMAND_wget = "/usr/bin/env wget -t 5 --passive-ftp -P ${DL_DIR} ${URI}"
 FILESDIR = "${@bb.utils.which(d.getVar('FILESPATH', True), '.')}"
 FILESPATH = "${FILE_DIRNAME}/${PF}:${FILE_DIRNAME}/${P}:${FILE_DIRNAME}/${PN}:${FILE_DIRNAME}/files:${FILE_DIRNAME}"
 FILE_DIRNAME = "${@os.path.dirname(d.getVar('FILE'))}"
@@ -44,8 +40,6 @@ PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[0] or 'defaultpkg
 PR = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[2] or 'r0'}"
 PROVIDES = ""
 PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[1] or '1.0'}"
-RESUMECOMMAND = ""
-RESUMECOMMAND_wget = "/usr/bin/env wget -c -t 5 --passive-ftp -P ${DL_DIR} ${URI}"
 S = "${WORKDIR}/${P}"
 SRC_URI = "file://${FILE}"
 STAMP = "${TMPDIR}/stamps/${PF}"
@@ -53,8 +47,5 @@ SVNDIR = "${DL_DIR}/svn"
 T = "${WORKDIR}/temp"
 TARGET_ARCH = "${BUILD_ARCH}"
 TMPDIR = "${TOPDIR}/tmp"
-UPDATECOMMAND = ""
-UPDATECOMMAND_cvs = "/usr/bin/env cvs -d${CVSROOT} update ${CVSCOOPTS}"
-UPDATECOMMAND_svn = "/usr/bin/env svn update ${SVNCOOPTS}"
 WORKDIR = "${TMPDIR}/work/${PF}"
 PERSISTENT_DIR = "${TMPDIR}/cache"

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

