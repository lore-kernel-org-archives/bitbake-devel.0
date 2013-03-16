Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1UGmeb-0006Br-46
	for bitbake-devel@lists.openembedded.org;
	Sat, 16 Mar 2013 09:39:49 +0100
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r2G8N2F1028987
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Mar 2013 01:23:03 -0700 (PDT)
Received: from pek-usp-9.wrs.com (128.224.162.26) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.342.3;
	Sat, 16 Mar 2013 01:23:02 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 16 Mar 2013 16:07:41 +0800
Message-ID: <f341ad464c4b177654dbf26d77217870a7402f1f.1363405523.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.7
In-Reply-To: <cover.1363405523.git.liezhi.yang@windriver.com>
References: <cover.1363405523.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: qingtao.cao@windriver.com
Subject: [PATCH 1/1] utils.py: fix BB_ENV_WHITELIST
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
X-List-Received-Date: Sat, 16 Mar 2013 08:39:50 -0000
Content-Type: text/plain

The BB_ENV_WHITELIST doesn't work well and flushes BB_ENV_EXTRAWHITE,
here is an example:

$ export BB_ENV_WHITELIST

$ export BB_NUMBER_THREADS=10 (or other value)

Edit conf/local.conf, change "BB_NUMBER_THREADS =" to "BB_NUMBER_THREADS ?="

$ bitbake -e | grep '^BB_NUMBER_THREADS ='
we will notice that BB_NUMBER_THREADS' value doesn't change, though
BB_NUMBER_THREADS in both BB_ENV_WHITELIST and BB_ENV_EXTRAWHITE.

This is because the "approved" inside the function approved_variables
doesn't include BB_ENV_WHITELIST or BB_ENV_EXTRAWHITE when
BB_ENV_WHITELIST is set (they are incuded by preserved_envvars()), so
the BB_ENV_WHITELIST and BB_ENV_EXTRAWHITE will be removed from the env
in the first call from bin/bitbake, and when it is called again by
cooker.py, their value will be None, then the vars inside them will be
removed from the env.

Add BB_ENV_WHITELIST and BB_ENV_EXTRAWHITE to the "approved" would fix
the problem.

[YOCTO #4031]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/utils.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index b2f81c8..d671f56 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -496,10 +496,13 @@ def approved_variables():
     approved = []
     if 'BB_ENV_WHITELIST' in os.environ:
         approved = os.environ['BB_ENV_WHITELIST'].split()
+        approved.extend(['BB_ENV_WHITELIST'])
     else:
         approved = preserved_envvars()
     if 'BB_ENV_EXTRAWHITE' in os.environ:
         approved.extend(os.environ['BB_ENV_EXTRAWHITE'].split())
+        if 'BB_ENV_EXTRAWHITE' not in approved:
+            approved.extend(['BB_ENV_EXTRAWHITE'])
     return approved
 
 def clean_environment():
-- 
1.7.7



