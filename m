Return-Path: <Liam.Howlett@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 2FB7472207
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 15:56:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t4FFuQf7013992
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 08:56:26 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.224.2; Fri, 15 May 2015 08:56:25 -0700
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 15 May 2015 11:56:24 -0400
Message-ID: <1431705384-7866-2-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1431705384-7866-1-git-send-email-Liam.Howlett@WindRiver.com>
References: <1431705384-7866-1-git-send-email-Liam.Howlett@WindRiver.com>
MIME-Version: 1.0
Cc: Liam.Howlett@WindRiver.com
Subject: [PATCH] fetch2: Allow GIT_SMART_HTTP to be passed through
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
X-List-Received-Date: Fri, 15 May 2015 15:56:26 -0000
Content-Type: text/plain

Allow GIT_SMART_HTTP to be passed through to the fetch command so that
servers that cannot use GIT_SMART_HTTP can be used by the fetcher.

Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 68f65a9..a40a88b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -795,6 +795,7 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
                   'ALL_PROXY', 'all_proxy',
                   'GIT_PROXY_COMMAND',
                   'GIT_SSL_CAINFO',
+                  'GIT_SMART_HTTP',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
                   'SOCKS5_USER', 'SOCKS5_PASSWD']
 
-- 
2.1.1


