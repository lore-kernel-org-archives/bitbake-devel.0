Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1UD7Hj-0003rO-5r
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Mar 2013 06:53:05 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r265aV4L003247
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 5 Mar 2013 21:36:31 -0800 (PST)
Received: from pek-usp-13.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.342.3;
	Tue, 5 Mar 2013 21:36:31 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Mar 2013 13:36:23 +0800
Message-ID: <962cea1584c9c61ac765e65b1e4e24cc55f73c39.1362545842.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1362545842.git.liezhi.yang@windriver.com>
References: <cover.1362545842.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: qingtao.cao@windriver.com
Subject: [PATCH 1/1] bitbake-layers: fix duplicated help info
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
X-List-Received-Date: Wed, 06 Mar 2013 05:53:05 -0000
Content-Type: text/plain

There are two "help" lines when run bitbake help under python 2.6.6
(perhaps all python 2.6):

$ bitbake-layers help
[snip]
help
    display general help or help on a specified command
[snip]
help
    display general help or help on a specified command

This is because the cmd.py in python 2.6.6 also has a do_help() function
as our bitbake-layers, and the cmd.Cmd.get_names() doesn't consider the
overload, this has been fixed in python 2.7, use set() to remove the
duplicated would fix the problem.

[YOCTO #3428]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-layers |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index b48590f..86da268 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -73,7 +73,7 @@ class Commands(cmd.Cmd):
         else:
             sys.stdout.write("usage: bitbake-layers <command> [arguments]\n\n")
             sys.stdout.write("Available commands:\n")
-            procnames = self.get_names()
+            procnames = list(set(self.get_names()))
             for procname in procnames:
                 if procname[:3] == 'do_':
                     sys.stdout.write("  %s\n" % procname[3:].replace('_', '-'))
-- 
1.7.1



