Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739ACD8C88
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 21:20:06 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23176.1780780804354673243
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Jun 2026 14:20:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=mtsl5/pL;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490af320e2aso34501265e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780780803; x=1781385603; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL6rTahIveE4PvuaZzyfh6+r7oH81+klNujgEqgGhQ8=;
        b=mtsl5/pLI2YLuPjvkLvf8Q0zMLrK5w3EhkovFApNHNAiqh81C6yzYz90b9ViXlF9Dm
         JLr0Wbcuaj8FP+FZ2RduF7CL0s3VuVfCUVR3oXkB9cYoIVPFdO2VHrG1CxM4tpgYJ8NM
         Jlk8qR8toSaO+TUbcCI7NR+YRMMAhK580060o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780780803; x=1781385603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nL6rTahIveE4PvuaZzyfh6+r7oH81+klNujgEqgGhQ8=;
        b=X9jkpWxX+M5lf5SuSAMpdAiGThZm0sihubwffjWzUiwPzHP0fgMzBa2pooDTDvYRpE
         wPZTu4JomyNvlq/dkfPyTuIm6wZXt7D1SCR8q7s5DPbYZOlPzngH5qO2tQVFHd2ySIs1
         lZSwEsa6Uzt4ZduYvytrg+bVqx/kd/f8hyj3MN9MfHRTIFf/7ifm/lVEROpvZYdp4YhZ
         cbMubzLHAFAKLqKUivhrCSUTHjH7vOEHYQjcUSFMGP3iiJnDbIaeLJHy2/oIBwQIBhEf
         c7vsx2HVlPc+Px2E++hTmq7IgcV+58sFdJ3hqwEXQGoxYB8F0lY+T6Sun8AG2wu07KI0
         52Bg==
X-Gm-Message-State: AOJu0Yw3eqe3bqQ+Cgj8SYR/l74kIX8BrihDyihPu1DhL5iWvhPVGnh8
	ptGgCcNb+exnko2JmLf3O1UU4Bg0db32IYUnfxk4A21dqc7p9hlTdQ52+nJJRseNKo+7ujSbSNf
	j8Vpd
X-Gm-Gg: Acq92OFVly0Bdesq19J1oY1kJB1Muos8PwPJZ1pz42eAQGGWpMs9dnklnrofnAD/MgV
	WMOhNFCUM6stLDhrmC88ggPihq1POB/Uqalw6h7YptyitZf3rifyDbazsNOACVtIhoeqtB5aDc9
	VJ0/UKDZnhjJFsq1kd193Uu8MqsPRT5ieUw+edXFVk7F1h7wDDolB1sUJAWYqTmVU8NYnuodq/8
	cl6XMp08xWoc+1ocaJ1l91dkMtTqWCQVxjv5VsdQIMDaOypasc0oxu2NrQB1XcIQY6BduoTOHQD
	DBbMCgyMC66zjFQREu7Rm6wYiNVtFhgc4qLx/aWOB47n2DdIDipkjNl83tVyImV02eQXs9CAJhE
	DlDu0ndX3CbdSIKNGt1N+MqWSMBqlGcONu0x7E/ATaJD9snz6lc8LPWENYU2cYF6HvWgbdup0Vy
	kvP3+dWDU6iW3F0OYnbShWGoje0nQzl4aHQRlKjoGyhpKXbSzRAY6fODrib+6slGiI9opt5P1vs
	oqz7eM35CnupRGSUvG7141wKsA+whVR6TKw/pykl6V+7nWf
X-Received: by 2002:a05:600c:1549:b0:490:c7dd:7cc2 with SMTP id 5b1f17b1804b1-490c7dd7defmr65259455e9.24.1780780802684;
        Sat, 06 Jun 2026 14:20:02 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa000f4f58971dfc8e81.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f4f:5897:1dfc:8e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm314340625e9.9.2026.06.06.14.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:20:02 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 3/3] toaster: use https for clones, remove cgit in links in defaults
Date: Sat,  6 Jun 2026 23:19:39 +0200
Message-ID: <294074e65f37822a0f31bb11eb968d311b54a66a.1780780690.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780780690.git.yoann.congal@smile.fr>
References: <cover.1780780690.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 21:20:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19632

From: David Reyna <mailto:David.Reyna@windriver.com>

The YP and OE repos have moved to "https:" instead of "git:" for cloning. YP has
removed the "cgit/cgit.cgi" from web URLs for layers. This patch updates the
fixture files that bootstrap these values for bitbake and the default layers.
Also, fix Wrynose bitbake version.

Note that Toaster is dependent on these values also fixed in the Layer
Index (#16240).

[YOCTO #16304]

Signed-off-by: David Reyna <mailto:David.Reyna@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d73feaf8d0cafa35a14e95457918de99c9d5552b)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/toaster/orm/fixtures/gen_fixtures.py | 31 +++++++++++-------
 lib/toaster/orm/fixtures/poky.xml        | 40 ++++++++++++------------
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 9488ce852..bd2c03383 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,7 +35,7 @@ verbose = False
 # [0=Codename, 1=Yocto Project Version, 2=Release Date, 3=Current Version, 4=Support Level, 5=Poky Version, 6=BitBake branch]
 current_releases = [
     # Release slot #1
-    ['Wrynose','6.0','April 2026','6.0 (April 2026)','Long Term Support (until April 2030)','','2.16'],
+    ['Wrynose','6.0','April 2026','6.0 (April 2026)','Long Term Support (until April 2030)','','2.18'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
@@ -81,7 +81,7 @@ prolog_template = '''\
 bitbakeversion_poky_template = '''\
   <object model="orm.bitbakeversion" pk="{{bitbake_id}}">
     <field type="CharField" name="name">{{name}}</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">{{branch}}</field>
     <field type="CharField" name="dirpath"></field>
   </object>
@@ -89,7 +89,7 @@ bitbakeversion_poky_template = '''\
 bitbakeversion_oecore_template = '''\
   <object model="orm.bitbakeversion" pk="{{bitbake_id}}">
     <field type="CharField" name="name">{{name}}</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">{{bitbakeversion}}</field>
   </object>
 '''
@@ -247,7 +247,7 @@ def generate_poky():
             params['description'] = 'Local Yocto Project'
             params['name'] = 'local'
         else:
-            params['help_source'] = 'using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/{{h_release}}"&gt;Yocto Project {{Release}} branch&lt;/a&gt;'
+            params['help_source'] = 'using the tip of the &lt;a href="https://git.yoctoproject.org/meta-yocto/log/{{h_release}}"&gt;Yocto Project {{Release}} branch&lt;/a&gt;'
             params['description'] = 'Yocto Project {{release_version}} "{{Release}}"'
         if 'master' == params['release']:
             params['h_release'] = ''
@@ -280,10 +280,17 @@ def generate_poky():
         params = {}
         params['layer'] = layer
         params['layer_id'] = str(i+1)
-        params['vcs_url'] = 'git://git.yoctoproject.org/poky'
-        params['vcs_web_url'] = 'https://git.yoctoproject.org/cgit/cgit.cgi/poky'
-        params['vcs_web_tree_base_url'] = 'https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%'
-        params['vcs_web_file_base_url'] = 'https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%'
+        if 'openembedded-core' == layer:
+            params['vcs_url'] = 'https://git.openembedded.org/openembedded-core'
+            params['vcs_web_url'] = 'https://git.openembedded.org/openembedded-core'
+            params['vcs_web_tree_base_url'] = 'https://git.openembedded.org/openembedded-core/tree/%path%?h=%branch%'
+            params['vcs_web_file_base_url'] = 'https://git.openembedded.org/openembedded-core/tree/%path%?h=%branch%'
+        else:
+            # Yocto Project layers: meta-poky, meta-yocto-bsp
+            params['vcs_url'] = 'https://git.yoctoproject.org/meta-yocto'
+            params['vcs_web_url'] = 'https://git.yoctoproject.org/meta-yocto/tree'
+            params['vcs_web_tree_base_url'] = 'https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%'
+            params['vcs_web_file_base_url'] = 'https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%'
 
         if i:
             print_str('',fd)
@@ -392,10 +399,10 @@ def generate_oe_core():
         params = {}
         params['layer'] = layer
         params['layer_id'] = str(i+1)
-        params['vcs_url'] = 'git://git.openembedded.org/openembedded-core'
-        params['vcs_web_url'] = 'https://cgit.openembedded.org/openembedded-core'
-        params['vcs_web_tree_base_url'] = 'https://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%'
-        params['vcs_web_file_base_url'] = 'https://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%'
+        params['vcs_url'] = 'https://git.openembedded.org/openembedded-core'
+        params['vcs_web_url'] = 'https://git.openembedded.org/openembedded-core'
+        params['vcs_web_tree_base_url'] = 'https://git.openembedded.org/openembedded-core/tree/%path%?h=%branch%'
+        params['vcs_web_file_base_url'] = 'https://git.openembedded.org/openembedded-core/tree/%path%?h=%branch%'
         if i:
             print_str('',fd)
         print_template(layer_oe_core_template,params,fd)
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 3648170bb..cadb48b06 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -9,25 +9,25 @@
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
     <field type="CharField" name="name">wrynose</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.16</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">2.18</field>
     <field type="CharField" name="dirpath"></field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">HEAD</field>
     <field type="CharField" name="dirpath"></field>
   </object>
   <object model="orm.bitbakeversion" pk="3">
     <field type="CharField" name="name">master</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath"></field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
     <field type="CharField" name="name">scarthgap</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.8</field>
     <field type="CharField" name="dirpath"></field>
   </object>
@@ -51,7 +51,7 @@
     <field type="CharField" name="description">Yocto Project 6.0 "Wrynose"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
     <field type="CharField" name="branch_name">wrynose</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=wrynose"&gt;Yocto Project Wrynose branch&lt;/a&gt;.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/meta-yocto/log/?h=wrynose"&gt;Yocto Project Wrynose branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -65,14 +65,14 @@
     <field type="CharField" name="description">Yocto Project master</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
     <field type="CharField" name="branch_name">master</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/meta-yocto/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
     <field type="CharField" name="name">scarthgap</field>
     <field type="CharField" name="description">Yocto Project 5.0 "Scarthgap"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
     <field type="CharField" name="branch_name">scarthgap</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=scarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/meta-yocto/log/?h=scarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="5">
     <field type="CharField" name="name">kirkstone</field>
@@ -171,10 +171,10 @@
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
     <field type="CharField" name="layer_index_url"></field>
-    <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
-    <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
-    <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_url">https://git.openembedded.org/openembedded-core</field>
+    <field type="CharField" name="vcs_web_url">https://git.openembedded.org/openembedded-core</field>
+    <field type="CharField" name="vcs_web_tree_base_url">https://git.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">https://git.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
@@ -223,10 +223,10 @@
   <object model="orm.layer" pk="2">
     <field type="CharField" name="name">meta-poky</field>
     <field type="CharField" name="layer_index_url"></field>
-    <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
-    <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
-    <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_url">https://git.yoctoproject.org/meta-yocto</field>
+    <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/meta-yocto/tree</field>
+    <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
@@ -275,10 +275,10 @@
   <object model="orm.layer" pk="3">
     <field type="CharField" name="name">meta-yocto-bsp</field>
     <field type="CharField" name="layer_index_url"></field>
-    <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
-    <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
-    <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_url">https://git.yoctoproject.org/meta-yocto</field>
+    <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/meta-yocto/tree</field>
+    <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="13">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>

