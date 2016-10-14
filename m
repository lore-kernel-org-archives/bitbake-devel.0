Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 6062F65D00
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 15:28:11 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id qn10so47866155pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kPNWY+HgQZ7rzuVCip9Xz6E3IaIUtByLG+pXdPB4IMo=;
	b=zs+Oz4YrY3uYxPD6TkorGAYqk9n/6XOWVDHlR+jg6rD5T0n2VthGFway+E4+lr8jpj
	Tpu0jfogKdIZ3n5NXAJ4xxmQ8S4OpuE+IbQWaQuO8KCA/Be2IyrHVdYNcO+Jo7EoCcTV
	WMdURO77T4wDYy1mPmNiy/YtwrfytI7cSkjGI+1CizS5dqm99vZ65N3RvIKxhwKR9kd5
	PF+ev4KQFmgSwLgXG9SW6ceSNRV3ryy58C+o9h8Lco8x1kkxh0biQooxG5jCNkp4zNh7
	twMPcrGUvpEBrjczlgyAh2iaLznqLJ3CET3X0waEu4JLTJAUa/sKdO+8vBtaS0uw7Boy
	l8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=kPNWY+HgQZ7rzuVCip9Xz6E3IaIUtByLG+pXdPB4IMo=;
	b=UQ3Zq7MMzHo3ubC/6WCygjReHlypRAPfgixewZ/RsXwJ1SQQ44NnzR9n/c23VkNJVD
	p/cnLMWfPv826q3Pve8pwRYdpHIu/dWSO6MY6ZyZ5cMPANQsi0rFc/AUamXbxwUGJoUY
	xyNCPFdgEH3QpyeTqy5tna3TyLTOF+V4elFFCkYgrd9bTcdcXzBTcl3HQl+7Mz18cNRZ
	P+rfLE02qkLZYYxZvfCAevFuEN9FtjEvxz+7h1olB7AJxQJbFAkrkJrDc27Nd6VS3YmL
	zBOrItR8pGhUykm0ugaPAdRw8igOk5gTbZ1eN4YD7adcRWVAYlKQb0whq++F7YSvVebE
	JrMA==
X-Gm-Message-State: AA6/9RkJIS3eOrPJulK9UQe86UzGMxk7YtF/Teo8P1fEghdwSppco+g8+MrhxUHmq2X4QdLg
X-Received: by 10.66.62.193 with SMTP id a1mr15767096pas.131.1476458893522;
	Fri, 14 Oct 2016 08:28:13 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.40])
	by smtp.gmail.com with ESMTPSA id
	n7sm28386090pfn.62.2016.10.14.08.28.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Oct 2016 08:28:12 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Oct 2016 16:27:59 +0100
Message-Id: <1476458881-10624-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
References: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 1/3] toaster: Update oe-core fixture for Morty release
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
X-List-Received-Date: Fri, 14 Oct 2016 15:28:12 -0000

From: brian avery <brian.avery@intel.com>

Update the oe-core fixture to the Morty release.  This removes the
master branch from the release and limits it to the morty branch.
Normally, we would also support at least one past branch but the change
from Python 2.7 -> Python 3 makes that infeasible.

Signed-off-by: brian avery <brian.avery@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index d062de5..a6c834f 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">master</field>
+    <field type="CharField" name="name">morty</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="branch">1.32</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
@@ -18,11 +18,11 @@
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">master</field>
-    <field type="CharField" name="description">Openembedded master</field>
+    <field type="CharField" name="name">morty</field>
+    <field type="CharField" name="description">Openembedded Morty</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">master</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch, where active development takes place. This is not a stable branch, so your builds might not work as expected.</field>
+    <field type="CharField" name="branch_name">morty</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=morty\"&gt;OpenEmbedded Morty&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -41,12 +41,12 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
-  
+
   <!-- TYPE_LOCAL = 0 Layers for the Local release -->
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
     <field type="CharField" name="vcs_url">git://git.openembedded.org/openembedded-core</field>
-  </object> 
+  </object>
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
-- 
2.7.4


