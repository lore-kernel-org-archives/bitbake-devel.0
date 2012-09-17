Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8d-0003R0-HB
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:49:59 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbJ5p009851
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:19 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:19 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:31 -0500
Message-ID: <1347921818-60562-2-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/8] bitbake: Unbuffer stdout for log files
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
X-List-Received-Date: Mon, 17 Sep 2012 22:49:59 -0000
Content-Type: text/plain

It is possible to lose critical log data when python exits in an
unorderly fashion via segmentation fault or certain types of crashes.
This is because the buffer characteristics are inherited from the top
level stdout, which should be set to unbuffered, for the purpose of
all the forked children.

This pushes the buffering to the OS, instead of having python managing
the buffers in its stream handler class.

This change is also to provide the ability to tail logs written from
processes in "real time" because they would be written in an orderly
fashion depending upon the OS characteristics for the file I/O.

(LOCAL REV ONLY: NOT UPSTREAM)

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index ed2ff06..c000d98 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -43,6 +43,14 @@ from bb import server
 __version__ = "1.15.3"
 logger = logging.getLogger("BitBake")
 
+# Unbuffer stdout to avoid log truncation in the event
+# of an unorderly exit as well as to provide timely
+# updates to log files for use with tail
+try:
+    if sys.stdout.name == '<stdout>':
+        sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)
+except:
+    pass
 
 class BBConfiguration(object):
     """
-- 
1.7.1



