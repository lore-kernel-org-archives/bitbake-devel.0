Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 3573560616
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Nov 2016 03:48:59 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id 144so2476840pfv.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Nov 2016 19:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zgyC+R+FEvQ7awZqI7dDzY6PLpAwROyC5sKjq+riGL8=;
	b=jmcfbCi8fK8Ai5CkKEnZA0ktFhHCmdpmX+1T80DsCUe/FwD/Fl1ZqZj/Bm8nE2rx14
	UcwK8If8gMo5r0yTGL0DB69TWv44q7Nfd0IqCyov3RM8/bEfspgUyxG+udqhIkny1a8W
	c6Q6jkg4SHc7Lub8OTBt1Px6p/tJXWEqZ70485znABbHlMQtRXM7ZMwIggBstLYj1ivc
	ZBtLMDJDrwBBJdCe5JEodwqyQF4HVDWNEI6Xr/Y4ZegA91R+veFczf++4bgOI3dNIvhn
	74LwjhyxWffPftVkXwcOb7qldc96ChWYODUHqmsawqVnljq4POlFTp3iPfvuJkll5jQt
	k4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zgyC+R+FEvQ7awZqI7dDzY6PLpAwROyC5sKjq+riGL8=;
	b=IlPKxkqWwtgWfqRTRt7j7Qf4gpoKTV/QJwXbhn+AEmUcQ/6/YIhUa4Fi4TbLXXF0ic
	Dett+MY/8VV0YIEUQh9GSvMvNagnHkpNzBQKRN0dg63biK6nA2nRxdAaAdvfhD3oTFYh
	thD2A18DoizDtlEk5f1hyJuVQi4iTDYmCZ7XMer8dko3jCHvoX9h/XpaQLSVmCQk+6ac
	llcb1TNYgeifikgioKXj7NdTbplhJn2M+vFxI1o5hUhoZFWq3OBZ0E3j1r79XCL0m5Sr
	oR9w/6KSGwgctyvRYBjYCqbPu8tj3moy5comWlv9TVjslGSdCiMyjGd1cJTe8gDPk1OK
	Tkig==
X-Gm-Message-State: ABUngvdWJwzhCDPSK60Vj5gvEHgOR1QLUaMGMMejmZK76f0x+VCTA83q3NjuvkCCnaBxGg==
X-Received: by 10.98.59.154 with SMTP id w26mr5760900pfj.112.1478749740874;
	Wed, 09 Nov 2016 19:49:00 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id t5sm2536480pfb.58.2016.11.09.19.49.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Nov 2016 19:49:00 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Nov 2016 19:52:32 -0800
Message-Id: <c8d2d3015115bc44b7f29000463bff7840f45447.1478749786.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1478749786.git.brian.avery@intel.com>
References: <cover.1478749786.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 1/3] toaster: settings fixture Set default release to master
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
X-List-Received-Date: Thu, 10 Nov 2016 03:48:59 -0000

From: Michael Wood <michael.g.wood@intel.com>

Now that morty has been released we now set the DEFAULT_RELEASE back to
master.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/toaster/orm/fixtures/settings.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/fixtures/settings.xml b/lib/toaster/orm/fixtures/settings.xml
index ee6a202..78c0fdc 100644
--- a/lib/toaster/orm/fixtures/settings.xml
+++ b/lib/toaster/orm/fixtures/settings.xml
@@ -4,7 +4,7 @@
   <!-- pk=1 is DISTRO -->
   <object model="orm.toastersetting" pk="2">
     <field type="CharField" name="name">DEFAULT_RELEASE</field>
-    <field type="CharField" name="value">morty</field>
+    <field type="CharField" name="value">master</field>
   </object>
   <object model="orm.toastersetting" pk="3">
     <field type="CharField" name="name">DEFCONF_PACKAGE_CLASSES</field>
-- 
1.9.1


