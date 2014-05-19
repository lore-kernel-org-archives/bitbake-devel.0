Return-Path: <Peter.Seebach@windriver.com>
Received: from mail1.windriver.com (unknown [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 958FD660CC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 21:48:26 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s4JLmRHG021902
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 14:48:27 -0700 (PDT)
Received: from msp-lpggp2.wrs.com (172.25.34.109) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.169.1;
	Mon, 19 May 2014 14:48:27 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 19 May 2014 16:52:44 -0500
Message-ID: <87695832bf6a443b530e9058f5c9cf208b276d8f.1400270358.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1400270358.git.peter.seebach@windriver.com>
References: <cover.1400270358.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] utils.py: default mode for mkdirhier
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
X-List-Received-Date: Mon, 19 May 2014 21:48:26 -0000
Content-Type: text/plain

The default behavior of os.makedirs() is to create a directory
with mode 777 & ~umask. When populating packages, oe-core uses
a umask of 0, so that files and directories copied in from the
source tree will have the right modes, and that's reasonable,
but it can result in packages-split being created with mode 777,
which is not so reasonable.

Since mkdirhier is used for build system stuff, it is
pretty reasonable for it to assume that you don't want or need
world-writeable directories, so we add a default mode, allowing
a caller to override it if they really want to. Which they
don't.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/utils.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1be1874..cd16b3b 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -618,13 +618,13 @@ def prune_suffix(var, suffixes, d):
             return var.replace(suffix, "")
     return var
 
-def mkdirhier(directory):
+def mkdirhier(directory, mode = 0755):
     """Create a directory like 'mkdir -p', but does not complain if
     directory already exists like os.makedirs
     """
 
     try:
-        os.makedirs(directory)
+        os.makedirs(directory, mode)
     except OSError as e:
         if e.errno != errno.EEXIST:
             raise e
-- 
1.7.1


