Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqN-0007wt-1B
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:15 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHSIe008014 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:45 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DK1h2mWzBKeI for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:45 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHcTQ008046
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:39 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLfM-0002T0-Hl
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:52 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:13:01 +0100
Message-Id: <f1c1213d1b9c58153fc1a7e25de5c06f79fcbd79.1340200208.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 10/14] fetch2: Add parameter handling to uri_replace()
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
X-List-Received-Date: Wed, 20 Jun 2012 14:25:15 -0000

This means that parameters in the source expression are used as part of the
match. Parameters in the destination are used explicitly in the final
url.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 7045e1b..37f13e2 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -194,7 +194,15 @@ def uri_replace(ud, uri_find, uri_replace, d):
     for loc, i in enumerate(uri_find_decoded):
         result_decoded[loc] = uri_decoded[loc]
         if loc == 5:
-            continue
+            # Handle URL parameters
+            if i:
+                # Any specified URL parameters must match
+                for k in uri_replace_decoded[loc]:
+                    if uri_decoded[loc][k] != uri_replace_decoded[loc][k]:
+                        return None
+            # Overwrite any specified replacement parameters
+            for k in uri_replace_decoded[loc]:
+                result_decoded[loc][k] = uri_replace_decoded[loc][k]
         elif (re.match(i, uri_decoded[loc])):
             if not uri_replace_decoded[loc]:
                 result_decoded[loc] = ""    
-- 
1.7.5.4



