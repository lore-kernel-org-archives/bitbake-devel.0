Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id C38E560616
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Nov 2016 03:49:00 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id 144so2476927pfv.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Nov 2016 19:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=g7NMPi0L1lAntzeFDwyKFt38xeYELuYfuHi5r2s9IFI=;
	b=kDwrpTUwEfKEm/gQJRlsGVpvi0ZOydUxwOCOwmkWP9JxljWLbcjB0nc21DobVeKuTo
	cX6Sa7QkyZmFdqB1NXyf+Wlr34sGmAlxtVZOsXw+v7Jg/T3P6CWYv6g1gGx49RXy8axW
	dsKBXwntZLhbRWPyi8nsfXdDYbUe2gioQbu8TdxIvPgxB9ux1s9fReUnnRdErPABVuYn
	nCsHYKNmM4qVRVNnN/oGNqiW/eepj6fajQ1tFUtHQtgznIeKgU0DKN6sU/KeAVpGVeGK
	crrNH++Z7+MF4gCglt+C99a8LpG/EWsH4ihB+c+9tXKO4fNA+q/R+YR3884iFQVlAvDU
	61Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=g7NMPi0L1lAntzeFDwyKFt38xeYELuYfuHi5r2s9IFI=;
	b=DACNmr7wY9bJWIAhxB0Cfr1WWOEj4lNbP2kExD6yYcAq4rENFh9oMtzwzYg0YEuiwy
	Z9OIUmtTtXBdKIqMZHATxCbdUOEwSdM7ysMQWdTTg8NdOVR+iORoHGf04aY2+YNgj4JY
	FXbT7qOAXq8qWaHyMra31XJqbnpcQPZ2HtpIOqBpYnxEaa9/8Sqeo4DYbgOPbiuNKXoW
	A2sTfxEP+eXM3xKTnnKPDOtf7aKMN9vAMDLiPtX6nl+UiAwGRvKd7iBTg0RTWKFSAcRB
	49hDRjowo9ya3YTkw3K0mFlOkGGe6aE5hgaxMdDvhC4j7OJV1B9CuGzi3toZikGOblX/
	Nr1g==
X-Gm-Message-State: ABUngveMU2u4aHlM9rh1dqyh3JYTCpxD98J7x15vBFOsaI1ATm2NkkFQQuCXlzOvUVPRew==
X-Received: by 10.98.4.6 with SMTP id 6mr5742286pfe.152.1478749742513;
	Wed, 09 Nov 2016 19:49:02 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id t5sm2536480pfb.58.2016.11.09.19.49.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Nov 2016 19:49:01 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Nov 2016 19:52:34 -0800
Message-Id: <6eec988c6a5f276a78b3c2de9aa231c8b0097d20.1478749786.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c8d2d3015115bc44b7f29000463bff7840f45447.1478749786.git.brian.avery@intel.com>
References: <c8d2d3015115bc44b7f29000463bff7840f45447.1478749786.git.brian.avery@intel.com>
In-Reply-To: <cover.1478749786.git.brian.avery@intel.com>
References: <cover.1478749786.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 3/3] toaster: layerindex updater Take into account layers being predefined
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
X-List-Received-Date: Thu, 10 Nov 2016 03:49:00 -0000

From: Michael Wood <michael.g.wood@intel.com>

As we can now provide layer definitions through fixtures we need to be
more clever how we update the metadata in the database to avoid
duplicate metadata being created. To do this we make more effort to
match existing data in the database and update only the fields which
will be better provided by the layer index.

This removes the need for us to special case layers which are provided
as part of poky such as openembedded-core or meta-poky which exist on
the layerindex but with different git urls.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/toaster/orm/management/commands/lsupdates.py | 60 ++++++++----------------
 1 file changed, 19 insertions(+), 41 deletions(-)

diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 8ff120e..688918e 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -154,41 +154,17 @@ class Command(NoArgsCommand):
 
         total = len(layers_info)
         for i, li in enumerate(layers_info):
-            # Special case for the openembedded-core layer
-            if li['name'] == oe_core_layer:
-                try:
-                    # If we have an existing openembedded-core for example
-                    # from the toasterconf.json augment the info using the
-                    # layerindex rather than duplicate it
-                    oe_core_l = Layer.objects.get(name=oe_core_layer)
-                    # Take ownership of the layer as now coming from the
-                    # layerindex
-                    oe_core_l.summary = li['summary']
-                    oe_core_l.description = li['description']
-                    oe_core_l.vcs_web_url = li['vcs_web_url']
-                    oe_core_l.vcs_web_tree_base_url = \
-                        li['vcs_web_tree_base_url']
-                    oe_core_l.vcs_web_file_base_url = \
-                        li['vcs_web_file_base_url']
-
-                    oe_core_l.save()
-                    li_layer_id_to_toaster_layer_id[li['id']] = oe_core_l.pk
-                    self.mini_progress("layers", i, total)
-                    continue
-
-                except Layer.DoesNotExist:
-                    pass
-
             try:
-                l, created = Layer.objects.get_or_create(name=li['name'],
-                                                         vcs_url=li['vcs_url'])
+                l, created = Layer.objects.get_or_create(name=li['name'])
                 l.up_date = li['updated']
-                l.vcs_url = li['vcs_url']
-                l.vcs_web_url = li['vcs_web_url']
-                l.vcs_web_tree_base_url = li['vcs_web_tree_base_url']
-                l.vcs_web_file_base_url = li['vcs_web_file_base_url']
                 l.summary = li['summary']
                 l.description = li['description']
+
+                if created:
+                    l.vcs_url = li['vcs_url']
+                    l.vcs_web_url = li['vcs_web_url']
+                    l.vcs_web_tree_base_url = li['vcs_web_tree_base_url']
+                    l.vcs_web_file_base_url = li['vcs_web_file_base_url']
                 l.save()
             except Layer.MultipleObjectsReturned:
                 logger.info("Skipped %s as we found multiple layers and "
@@ -211,12 +187,14 @@ class Command(NoArgsCommand):
 
         total = len(layerbranches_info)
         for i, lbi in enumerate(layerbranches_info):
+            # release as defined by toaster map to layerindex branch
+            release = li_branch_id_to_toaster_release[lbi['branch']]
 
             try:
                 lv, created = Layer_Version.objects.get_or_create(
-                    layer_source=LayerSource.TYPE_LAYERINDEX,
                     layer=Layer.objects.get(
-                        pk=li_layer_id_to_toaster_layer_id[lbi['layer']])
+                        pk=li_layer_id_to_toaster_layer_id[lbi['layer']]),
+                    release=release
                 )
             except KeyError:
                 logger.warning(
@@ -224,11 +202,12 @@ class Command(NoArgsCommand):
                     lbi['layer'])
                 continue
 
-            lv.release = li_branch_id_to_toaster_release[lbi['branch']]
-            lv.up_date = lbi['updated']
-            lv.commit = lbi['actual_branch']
-            lv.dirpath = lbi['vcs_subdir']
-            lv.save()
+            if created:
+                lv.release = li_branch_id_to_toaster_release[lbi['branch']]
+                lv.up_date = lbi['updated']
+                lv.commit = lbi['actual_branch']
+                lv.dirpath = lbi['vcs_subdir']
+                lv.save()
 
             li_layer_branch_id_to_toaster_lv_id[lbi['id']] =\
                 lv.pk
@@ -255,9 +234,8 @@ class Command(NoArgsCommand):
                 layer_id = li_layer_id_to_toaster_layer_id[ldi['dependency']]
 
                 dependlist[lv].append(
-                    Layer_Version.objects.get(
-                        layer_source=LayerSource.TYPE_LAYERINDEX,
-                        layer__pk=layer_id))
+                    Layer_Version.objects.get(layer__pk=layer_id,
+                                              release=lv.release))
 
             except Layer_Version.DoesNotExist:
                 logger.warning("Cannot find layer version (ls:%s),"
-- 
1.9.1


