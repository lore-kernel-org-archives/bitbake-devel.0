Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 61E2565D00
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 15:28:13 +0000 (UTC)
Received: by mail-pa0-f46.google.com with SMTP id qn10so47866327pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NTkVBA71C2o96chDrV/CgRAlJaohyt6+hQnXcEGtgkM=;
	b=AZWjEMW2nWY6LZdOv8pe+v8qBuI2Rle+ZoFOHEqTQxBZ7gYSVAc/0Aeco3tmMsqBEe
	uv9x2LTuClpDgg13uPITgq6ybz9hleu9HIt+TKhCQauT5tg+IlKsKgl4K9fwN212CYJA
	y9CpNPREcSJhBbmAs8jzs5IfpOMgIbUFEwRzKGlK95Zs81jOvWrWEIMOoQEyRk3gEQx2
	FCn9hA+Zrf6CmcHmUSvanGw2w0g0iiX5FRaJSJMtmveX/EcU07EmI+ZK1BFw/HIbfrmW
	E6lxK161kfEGMhESapdmxFoWnOB88lvOOqdSgXy7304ko013UTAuYDFz8qXFNfdK2W2Y
	YaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=NTkVBA71C2o96chDrV/CgRAlJaohyt6+hQnXcEGtgkM=;
	b=Pk7PeWdLWa4mn5D5jGqqyoJk/1K/9N9eZCOs7CeMCEWTJUxwRP9xVvtHa5FaNt3bO0
	HxkljpFp+yWAXQYL8seiAaBLC1o060jNCvUyM0s+1SU3u9Iq5/H22JhgGAA65cAQ+n6d
	u0mQhjc/Uc3KsMSs0rtQrWkC9yYAorvxoXR63O3EoAlWLmZBIGJzw2t8X3eCt6uYW1tB
	hV/Zq5QdT2CPlnEKA79d7BB9c2fbQstKQNwD2vBH4JzCLUKXSgQdtaV/b/qAN0cJU4g/
	RoxwJ9gIszPID+q0Km0yLFSS05OoI1ndpE3r8igiebknf8dxHt4G+NEOPnkhmCHmBGLN
	Fz1Q==
X-Gm-Message-State: AA6/9RmhOetRzH3RpoDj266SDtYsCNYDQGWyEIpbKVJH6YDy5d4luRIOtxHv/zbWSEzgheJo
X-Received: by 10.66.22.38 with SMTP id a6mr16234911paf.39.1476458895535;
	Fri, 14 Oct 2016 08:28:15 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.40])
	by smtp.gmail.com with ESMTPSA id
	n7sm28386090pfn.62.2016.10.14.08.28.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Oct 2016 08:28:15 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Oct 2016 16:28:00 +0100
Message-Id: <1476458881-10624-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
References: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 2/3] toaster: Update poky fixture for Morty release
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
X-List-Received-Date: Fri, 14 Oct 2016 15:28:14 -0000

From: brian avery <brian.avery@intel.com>

Update the poky fixture to the Morty release.  This removes the
master branch from the release and limits it to the morty branch.
Normally, we would also support at least one past branch but the change
from Python 2.7 -> Python 3 makes that infeasible.

Signed-off-by: brian avery <brian.avery@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/fixtures/poky.xml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 75a2916..c192baa 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">master</field>
+    <field type="CharField" name="name">morty</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="branch">morty</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
@@ -22,11 +22,11 @@
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">master</field>
-    <field type="CharField" name="description">Yocto Project master</field>
+    <field type="CharField" name="name">morty</field>
+    <field type="CharField" name="description">Yocto Project 2.2 "Morty"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">master</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project master branch&lt;/a&gt;, where active development takes place. This is not a stable branch, so your builds might not work as expected.</field>
+    <field type="CharField" name="branch_name">morty</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=morty"&gt;Yocto Project Morty branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
-- 
2.7.4


