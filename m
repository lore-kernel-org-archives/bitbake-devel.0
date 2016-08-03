Return-Path: <Liam.Howlett@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 02C4B73243
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Aug 2016 19:57:53 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u73Jvsrd028490
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 3 Aug 2016 12:57:54 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.205) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.248.2; Wed, 3 Aug 2016 12:57:53 -0700
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 3 Aug 2016 15:57:49 -0400
Message-ID: <1470254270-5368-2-git-send-email-Liam.Howlett@WindRiver.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1470254270-5368-1-git-send-email-Liam.Howlett@WindRiver.com>
References: <1470254270-5368-1-git-send-email-Liam.Howlett@WindRiver.com>
MIME-Version: 1.0
Cc: Liam.Howlett@WindRiver.com
Subject: [PATCH 1/2] bin/toaster: Remove extra CMD check.
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
X-List-Received-Date: Wed, 03 Aug 2016 19:57:54 -0000
Content-Type: text/plain

This if statement was left over from the switch to the case statement
logic.

Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
---
 bin/toaster | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index e3a0dae..66157d0 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -253,10 +253,8 @@ echo "The system will $CMD."
 case $CMD in
     start )
         # check if addr:port is not in use
-        if [ "$CMD" == 'start' ]; then
-            if [ $WEBSERVER -gt 0 ]; then
-                $MANAGE checksocket "$ADDR_PORT" || return 1
-            fi
+        if [ ${WEBSERVER} -gt 0 ]; then
+            ${MANAGE} checksocket "$ADDR_PORT" || return 1
         fi
 
         # kill Toaster web server if it's alive
-- 
1.9.1


