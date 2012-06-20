Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqN-0007wt-UH
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:16 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHJNp007991 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:45 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id maA9qD-U+nu7 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:45 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHfof008053
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:42 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLfP-0002T5-II
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:55 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:13:02 +0100
Message-Id: <3234093f2018bd7cf03d4aad86e4ab99c013a165.1340200208.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 11/14] fetch2: uri_replace() remove what amounts to a null operation and add some comments
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
X-List-Received-Date: Wed, 20 Jun 2012 14:25:17 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 37f13e2..945db7b 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -207,15 +207,15 @@ def uri_replace(ud, uri_find, uri_replace, d):
             if not uri_replace_decoded[loc]:
                 result_decoded[loc] = ""    
             else:
+                #bb.note("%s %s %s" % (i, uri_replace_decoded[loc], uri_decoded[loc]))
                 result_decoded[loc] = re.sub(i, uri_replace_decoded[loc], uri_decoded[loc])
             if loc == 2:
+                # Handle path manipulations
                 basename = None
                 if ud.mirrortarball:
                     basename = os.path.basename(ud.mirrortarball)
                 elif ud.localpath:
                     basename = os.path.basename(ud.localpath)
-                if basename and result_decoded[loc].endswith("/"):
-                    result_decoded[loc] = os.path.dirname(result_decoded[loc])
                 if basename and not result_decoded[loc].endswith(basename):
                     result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
-- 
1.7.5.4



