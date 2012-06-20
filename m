Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqM-0007wt-Go
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:14 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHSIf008014 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:47 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SEE6ksYuWI8b for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:46 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHiQc008103
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:46 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLfS-0002TE-Jo
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:58 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:13:03 +0100
Message-Id: <24b59a3ca143af295675388fbab16bafa192ac2f.1340200208.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 12/14] fetch2: uri_replace() improve mirrortarball handling
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
X-List-Received-Date: Wed, 20 Jun 2012 14:25:14 -0000

We only consider mirror tarballs when the source and target urls are of
differing types. We also should clear all url paramters when handling
mirror tarballs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 945db7b..63e2e48 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -212,8 +212,11 @@ def uri_replace(ud, uri_find, uri_replace, d):
             if loc == 2:
                 # Handle path manipulations
                 basename = None
-                if ud.mirrortarball:
+                if uri_decoded[0] != uri_replace_decoded[0] and ud.mirrortarball:
+                    # If the source and destination url types differ, must be a mirrortarball mapping
                     basename = os.path.basename(ud.mirrortarball)
+                    # Kill parameters, they make no sense for mirror tarballs
+                    uri_decoded[5] = {}
                 elif ud.localpath:
                     basename = os.path.basename(ud.localpath)
                 if basename and not result_decoded[loc].endswith(basename):
-- 
1.7.5.4



