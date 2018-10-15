Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 97D6A78E88
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 07:17:47 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w9F7HmUV016059
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 00:17:48 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 15 Oct 2018 00:17:48 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Oct 2018 00:14:18 -0700
Message-ID: <603d25b684bdc45df0e76b5f56ec820529a80907.1539558338.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1539558338.git.David.Reyna@windriver.com>
References: <cover.1539558338.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 2/3] toaster: bump django version to match build tools
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
X-List-Received-Date: Mon, 15 Oct 2018 07:17:47 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The version of django in the 2.6 release got bumped to 1.11.14.
The toaster requirements file needs to be updated to accept it.

[YOCTO #12958]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 toaster-requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index c0ec368..a682b08 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,3 @@
-Django>1.8,<1.11.9
+Django>1.8,<1.12
 beautifulsoup4>=4.4.0
 pytz
-- 
1.9.1


