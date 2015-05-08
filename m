Return-Path: <jason.wessel@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id DB1646017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 May 2015 18:24:41 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t48IOgXA011326
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 May 2015 11:24:42 -0700 (PDT)
Received: from ord-lpggp3.wrs.com (128.224.149.46) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.224.2;
	Fri, 8 May 2015 11:24:42 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 May 2015 13:21:40 -0500
Message-ID: <1431109300-31794-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH] fetch2: Allow git to use a different CA Bundle with private keys
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
X-List-Received-Date: Fri, 08 May 2015 18:24:42 -0000
Content-Type: text/plain

Setting BB_ENV_EXTRAWHITE to include GIT_SSL_CAINFO is enough to
get "git ls-remote" to work for recipe parsing but it is not enough
to get the fetcher to clone properly.

This is because the fetcher has its own idea about what variables
should be exported in the environment for some operations.

It is desirable to use alternate CA Bundles for internal testing prior
to using public keys for https, so we should allow the GIT_SSL_CAINFO
to pass through.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/fetch2/__init__.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b004dae..36c9554 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -783,6 +783,7 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
                   'NO_PROXY', 'no_proxy',
                   'ALL_PROXY', 'all_proxy',
                   'GIT_PROXY_COMMAND',
+                  'GIT_SSL_CAINFO',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
                   'SOCKS5_USER', 'SOCKS5_PASSWD']
 
-- 
1.7.9.5


