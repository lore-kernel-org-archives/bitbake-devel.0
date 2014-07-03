Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 652336084E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Jul 2014 06:27:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s636RPVd016521
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 2 Jul 2014 23:27:25 -0700 (PDT)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.169.1;
	Wed, 2 Jul 2014 23:27:25 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Jul 2014 14:42:05 +0800
Message-ID: <2db0140beb657f2ceafa0a346e88ca6fc0f9f6b0.1404369560.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1404369559.git.liezhi.yang@windriver.com>
References: <cover.1404369559.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/3] bitbake: doc: fix no newline at end of file
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
X-List-Received-Date: Thu, 03 Jul 2014 06:27:27 -0000
Content-Type: text/plain

Add a '\n' to the last line of the file to fix:

No newline at end of file

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/doc/template/component.title.xsl       | 2 +-
 bitbake/doc/template/division.title.xsl        | 2 +-
 bitbake/doc/template/formal.object.heading.xsl | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/doc/template/component.title.xsl b/bitbake/doc/template/component.title.xsl
index 3a5539d..faef043 100644
--- a/bitbake/doc/template/component.title.xsl
+++ b/bitbake/doc/template/component.title.xsl
@@ -36,4 +36,4 @@
       </xsl:call-template>
     </xsl:element>
   </xsl:template>
-</xsl:stylesheet>
\ No newline at end of file
+</xsl:stylesheet>
diff --git a/bitbake/doc/template/division.title.xsl b/bitbake/doc/template/division.title.xsl
index 8cd70a5..6c26597 100644
--- a/bitbake/doc/template/division.title.xsl
+++ b/bitbake/doc/template/division.title.xsl
@@ -21,4 +21,4 @@
       </xsl:call-template>
     </h1>
   </xsl:template>
-</xsl:stylesheet>
\ No newline at end of file
+</xsl:stylesheet>
diff --git a/bitbake/doc/template/formal.object.heading.xsl b/bitbake/doc/template/formal.object.heading.xsl
index 4f3900d..1a5e697 100644
--- a/bitbake/doc/template/formal.object.heading.xsl
+++ b/bitbake/doc/template/formal.object.heading.xsl
@@ -18,4 +18,4 @@
       </xsl:call-template>
     </p>
   </xsl:template>
-</xsl:stylesheet>
\ No newline at end of file
+</xsl:stylesheet>
-- 
1.8.3.1


