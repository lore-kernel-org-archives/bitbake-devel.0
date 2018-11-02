Return-Path: <mac@mcrowe.com>
X-Greylist: delayed 450 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 02 Nov 2018 14:39:54 UTC
Received: from avasout03.plus.net (avasout03.plus.net [84.93.230.244])
	by mail.openembedded.org (Postfix) with ESMTP id 3D83479F65
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Nov 2018 14:39:54 +0000 (UTC)
Received: from deneb ([80.229.24.9]) by smtp with ESMTP
	id IaUogqVW7d3rWIaUpgxket; Fri, 02 Nov 2018 14:32:23 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uv9Nyd4B c=1 sm=1 tr=0
	a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
	a=JHtHm7312UAA:10 a=-An2I_7KAAAA:8 a=FTTrtT_7mAswyJ3t-lMA:9
	a=Sq34B_EcNBM9_nrAYB9S:22
Received: from mac by deneb with local (Exim 4.89)
	(envelope-from <mac@mcrowe.com>)
	id 1gIaUn-0005zw-NM; Fri, 02 Nov 2018 14:32:21 +0000
From: Mike Crowe <mac@mcrowe.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Nov 2018 14:32:15 +0000
Message-Id: <20181102143215.2122-1-mac@mcrowe.com>
X-Mailer: git-send-email 2.11.0
X-CMAE-Envelope: MS4wfNm8+/r02dWsTy8c2IgjWbotoC+ibjOCFSPbKxUZnq8CH340i89WxemqAWNc5Kz+GyUduI5P+YrN8e4z7JyzPM9r+tEe9sD4LyCH+2F6YmqQpNb/TrGU
	VOP4MGuCLL9VLA4ZVGfKQXzdYiCoeNyrjuLIUkBuByf1tocT351j8u0d
Subject: [PATCH] fetch: Also export GIT_SSH environment variable
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
X-List-Received-Date: Fri, 02 Nov 2018 14:39:54 -0000

Support users who want to specify a custom ssh to Git using an environment
variable. (This lets build systems work without requiring users to
configure Git explicitly.)

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2b62b416..572b71a9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -827,6 +827,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
                   'NO_PROXY', 'no_proxy',
                   'ALL_PROXY', 'all_proxy',
                   'GIT_PROXY_COMMAND',
+                  'GIT_SSH',
                   'GIT_SSL_CAINFO',
                   'GIT_SMART_HTTP',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
-- 
2.11.0


