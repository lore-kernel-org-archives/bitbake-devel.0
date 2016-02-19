Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id BFE7577041
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Feb 2016 05:16:02 +0000 (UTC)
Received: by mail-pf0-f174.google.com with SMTP id q63so44646935pfb.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 21:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=MI81qWKFGO8BLF2yFu+GI76ZFLAhkYZJMsnqXZ0qw7c=;
	b=rBGFwoC8+IzPiN1Slo0uV5/PV/ZzwEznc6WmCBNBpg8DMSveKvYLcQYzifzXprAl0T
	JfS9CqJg1oHmOzQp5eqjm1xzZRiQkl6p7F7Xsmv/1sjKAvKEpZUvEb4sUIFYGY+1djZr
	iF/c4esh1UpZt67p9aRH570NB/2Xrb4DvmHVJXYUzDu8E4WEAozdxOu5JfF56kcuSjJY
	AKb21X7xQHanCj4m4rikjxd1g2hrwz3szxw+D+YVClJ+9L21bx8klHFUmFoSnxCRRVL7
	Atp5LaeR0rLYaB+tD+IFENb/5v+rRlNed0Pf9BEn7ev2yRAMlKpKioGXRV1XEYNVzqmV
	Q0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=MI81qWKFGO8BLF2yFu+GI76ZFLAhkYZJMsnqXZ0qw7c=;
	b=kqQJxTys41QN74eMspo3SrHFkGTwNTw0tWuh1fibz6vq/QljSEjxHPzEuCpdxSc5Nm
	3b/hJbv4W7w0+GRRS32k0yFsJVY8f92nAu3HYNmYRDUuEKJGmTUZbq1OPM3EOben4Ayj
	x90LWBpz/dCmKcoKFx1GF7vJayvgDQ8TyYtdXrdm6aM70ASDicKsFnyWzEXVnueUGPAy
	Zn6GimN5LMx4fJt8Rn3jQlwGKlcQb8cXXLEyb/Pc80wtB5CLZ4aiv1CzmGxlwESJjBj8
	6ZNmxHhZqRlfWbUxvK17kEDo02tBAuKIY7QTt3tg4rECQS3thjgJ2gQHBGQmjvADI4CZ
	tCWA==
X-Gm-Message-State: AG10YOSfOjqYZHPXzI+b0mT6VeKsmp/lFMywnYK6fbuA1urm25hvXZFRZXXPwLWsPz/VfA==
X-Received: by 10.98.17.129 with SMTP id 1mr15568259pfr.30.1455858963679;
	Thu, 18 Feb 2016 21:16:03 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ml5sm13317073pab.2.2016.02.18.21.16.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 Feb 2016 21:16:03 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Feb 2016 21:21:50 -0800
Message-Id: <7f901d35feab0c980e1975fa416165703b780ced.1455859137.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
References: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
In-Reply-To: <cover.1455859137.git.avery.brian@gmail.com>
References: <cover.1455859137.git.avery.brian@gmail.com>
Subject: [PATCH 3/5] toaster: toastergui unit tests convert to use fixtures
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
X-List-Received-Date: Fri, 19 Feb 2016 05:16:03 -0000

From: Michael Wood <michael.g.wood@intel.com>

Instead of having to manually write up in the setUp function all the
different objects to create in the database, just specifiy them in a
fixture and load it. This has the advantage that it can be used on a
live server by using the ./manage.py loaddata command and can then
be inspected.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 .../fixtures/toastergui-unittest-data.xml          | 446 +++++++++++++++++++++
 lib/toaster/toastergui/tests.py                    | 255 ++----------
 2 files changed, 488 insertions(+), 213 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml

diff --git a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
new file mode 100644
index 0000000..2d83ff8
--- /dev/null
+++ b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
@@ -0,0 +1,446 @@
+<?xml version="1.0" encoding="utf-8"?>
+<django-objects version="1.0">
+  <object pk="1" model="orm.project">
+    <field type="CharField" name="name">a test project</field>
+    <field type="CharField" name="short_description"></field>
+    <field to="orm.bitbakeversion" name="bitbake_version" rel="ManyToOneRel">1</field>
+    <field to="orm.release" name="release" rel="ManyToOneRel">1</field>
+    <field type="DateTimeField" name="created">2016-02-15T18:46:20.098248+00:00</field>
+    <field type="DateTimeField" name="updated">2016-02-15T18:46:20.098392+00:00</field>
+    <field type="IntegerField" name="user_id"><None></None></field>
+    <field type="BooleanField" name="is_default">False</field>
+  </object>
+  <object pk="2" model="orm.project">
+    <field type="CharField" name="name">z test project</field>
+    <field type="CharField" name="short_description"></field>
+    <field to="orm.bitbakeversion" name="bitbake_version" rel="ManyToOneRel">1</field>
+    <field to="orm.release" name="release" rel="ManyToOneRel">2</field>
+    <field type="DateTimeField" name="created">2016-02-15T18:46:20.107936+00:00</field>
+    <field type="DateTimeField" name="updated">2016-02-15T18:46:20.108066+00:00</field>
+    <field type="IntegerField" name="user_id"><None></None></field>
+    <field type="BooleanField" name="is_default">False</field>
+  </object>
+  <object pk="1" model="orm.ProjectVariable">
+    <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="name">machine</field>
+    <field type="TextField" name="value">qemux86</field>
+  </object>
+  <object pk="2" model="orm.ProjectVariable">
+    <field to="orm.project" name="project" rel="ManyToOneRel">2</field>
+    <field type="CharField" name="name">machine</field>
+    <field type="TextField" name="value">qemux86</field>
+  </object>
+  <object pk="1" model="orm.build">
+    <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="machine">x12</field>
+    <field type="CharField" name="distro"></field>
+    <field type="CharField" name="distro_version"></field>
+    <field type="DateTimeField" name="started_on">2016-02-14T18:46:20.114530+00:00</field>
+    <field type="DateTimeField" name="completed_on">2016-02-14T18:46:20.114530+00:00</field>
+    <field type="IntegerField" name="outcome">0</field>
+    <field type="CharField" name="cooker_log_path"></field>
+    <field type="CharField" name="build_name">a</field>
+    <field type="CharField" name="bitbake_version"></field>
+  </object>
+  <object pk="2" model="orm.build">
+    <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="machine">raspberrypi2</field>
+    <field type="CharField" name="distro"></field>
+    <field type="CharField" name="distro_version"></field>
+    <field type="DateTimeField" name="started_on">2016-02-13T18:46:20.114530+00:00</field>
+    <field type="DateTimeField" name="completed_on">2016-02-13T18:46:20.114530+00:00</field>
+    <field type="IntegerField" name="outcome">0</field>
+    <field type="CharField" name="cooker_log_path"></field>
+    <field type="CharField" name="build_name">b</field>
+    <field type="CharField" name="bitbake_version"></field>
+  </object>
+  <object pk="3" model="orm.build">
+    <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="machine">qemux86</field>
+    <field type="CharField" name="distro"></field>
+    <field type="CharField" name="distro_version"></field>
+    <field type="DateTimeField" name="started_on">2016-02-12T18:46:20.114530+00:00</field>
+    <field type="DateTimeField" name="completed_on">2016-02-12T18:46:20.114530+00:00</field>
+    <field type="IntegerField" name="outcome">1</field>
+    <field type="CharField" name="cooker_log_path"></field>
+    <field type="CharField" name="build_name">c</field>
+    <field type="CharField" name="bitbake_version"></field>
+  </object>
+  <object pk="4" model="orm.build">
+    <field to="orm.project" name="project" rel="ManyToOneRel">2</field>
+    <field type="CharField" name="machine">qemux86</field>
+    <field type="CharField" name="distro"></field>
+    <field type="CharField" name="distro_version"></field>
+    <field type="DateTimeField" name="started_on">2016-02-11T18:46:20.114530+00:00</field>
+    <field type="DateTimeField" name="completed_on">2016-02-11T18:46:20.114530+00:00</field>
+    <field type="IntegerField" name="outcome">0</field>
+    <field type="CharField" name="cooker_log_path"></field>
+    <field type="CharField" name="build_name">d</field>
+    <field type="CharField" name="bitbake_version"></field>
+  </object>
+  <object pk="1" model="orm.target">
+    <field to="orm.build" name="build" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="target">a image recipe</field>
+    <field type="CharField" name="task"><None></None></field>
+    <field type="BooleanField" name="is_image">False</field>
+    <field type="IntegerField" name="image_size">0</field>
+    <field type="CharField" name="license_manifest_path"><None></None></field>
+  </object>
+  <object pk="2" model="orm.target">
+    <field to="orm.build" name="build" rel="ManyToOneRel">2</field>
+    <field type="CharField" name="target">z something</field>
+    <field type="CharField" name="task"><None></None></field>
+    <field type="BooleanField" name="is_image">False</field>
+    <field type="IntegerField" name="image_size">0</field>
+    <field type="CharField" name="license_manifest_path"><None></None></field>
+  </object>
+  <object pk="3" model="orm.target">
+    <field to="orm.build" name="build" rel="ManyToOneRel">3</field>
+    <field type="CharField" name="target">h recipe</field>
+    <field type="CharField" name="task"><None></None></field>
+    <field type="BooleanField" name="is_image">False</field>
+    <field type="IntegerField" name="image_size">0</field>
+    <field type="CharField" name="license_manifest_path"><None></None></field>
+  </object>
+  <object pk="1" model="orm.package">
+    <field to="orm.build" name="build" rel="ManyToOneRel">1</field>
+    <field to="orm.recipe" name="recipe" rel="ManyToOneRel">2</field>
+    <field type="CharField" name="name">b pkg</field>
+    <field type="CharField" name="installed_name"></field>
+    <field type="CharField" name="version"></field>
+    <field type="CharField" name="revision"></field>
+    <field type="TextField" name="summary"></field>
+    <field type="TextField" name="description"></field>
+    <field type="IntegerField" name="size">777</field>
+    <field type="IntegerField" name="installed_size">0</field>
+    <field type="CharField" name="section"></field>
+    <field type="CharField" name="license">a license</field>
+  </object>
+  <object pk="2" model="orm.package">
+    <field to="orm.build" name="build" rel="ManyToOneRel">1</field>
+    <field to="orm.recipe" name="recipe" rel="ManyToOneRel">2</field>
+    <field type="CharField" name="name">f pkg</field>
+    <field type="CharField" name="installed_name"></field>
+    <field type="CharField" name="version"></field>
+    <field type="CharField" name="revision"></field>
+    <field type="TextField" name="summary"></field>
+    <field type="TextField" name="description"></field>
+    <field type="IntegerField" name="size">4</field>
+    <field type="IntegerField" name="installed_size">10</field>
+    <field type="CharField" name="section"></field>
+    <field type="CharField" name="license">z license</field>
+  </object>
+  <object pk="3" model="orm.package">
+    <field to="orm.build" name="build" rel="ManyToOneRel"><None></None></field>
+    <field to="orm.recipe" name="recipe" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="name">a custom image pkg</field>
+    <field type="CharField" name="installed_name"></field>
+    <field type="CharField" name="version"></field>
+    <field type="CharField" name="revision"></field>
+    <field type="TextField" name="summary"></field>
+    <field type="TextField" name="description"></field>
+    <field type="IntegerField" name="size">10</field>
+    <field type="IntegerField" name="installed_size">0</field>
+    <field type="CharField" name="section"></field>
+    <field type="CharField" name="license">h license</field>
+  </object>
+  <object pk="4" model="orm.package">
+    <field to="orm.build" name="build" rel="ManyToOneRel"><None></None></field>
+    <field to="orm.recipe" name="recipe" rel="ManyToOneRel">2</field>
+    <field type="CharField" name="name">z custom image pkg</field>
+    <field type="CharField" name="installed_name"></field>
+    <field type="CharField" name="version"></field>
+    <field type="CharField" name="revision"></field>
+    <field type="TextField" name="summary"></field>
+    <field type="TextField" name="description"></field>
+    <field type="IntegerField" name="size">5</field>
+    <field type="IntegerField" name="installed_size">0</field>
+    <field type="CharField" name="section"></field>
+    <field type="CharField" name="license">z license</field>
+  </object>
+  <object pk="5" model="orm.package">
+    <field to="orm.build" name="build" rel="ManyToOneRel">1</field>
+    <field to="orm.recipe" name="recipe" rel="ManyToOneRel">4</field>
+    <field type="CharField" name="name">a custom image pkg</field>
+    <field type="CharField" name="installed_name"></field>
+    <field type="CharField" name="version"></field>
+    <field type="CharField" name="revision"></field>
+    <field type="TextField" name="summary"></field>
+    <field type="TextField" name="description"></field>
+    <field type="IntegerField" name="size">2</field>
+    <field type="IntegerField" name="installed_size">0</field>
+    <field type="CharField" name="section"></field>
+    <field type="CharField" name="license">h licence</field>
+  </object>
+  <object pk="1" model="orm.target_installed_package">
+    <field to="orm.target" name="target" rel="ManyToOneRel">1</field>
+    <field to="orm.package" name="package" rel="ManyToOneRel">1</field>
+  </object>
+  <object pk="2" model="orm.target_installed_package">
+    <field to="orm.target" name="target" rel="ManyToOneRel">1</field>
+    <field to="orm.package" name="package" rel="ManyToOneRel">2</field>
+  </object>
+  <object pk="3" model="orm.target_installed_package">
+    <field to="orm.target" name="target" rel="ManyToOneRel">1</field>
+    <field to="orm.package" name="package" rel="ManyToOneRel">3</field>
+  </object>
+  <!-- Note that these augment the existing orm.package of the same pk -->
+  <object pk="4" model="orm.customimagepackage">
+    <field to="orm.customimagerecipe" name="recipe_includes" rel="ManyToManyRel"></field>
+    <field to="orm.customimagerecipe" name="recipe_excludes" rel="ManyToManyRel"></field>
+    <field to="orm.customimagerecipe" name="recipe_appends" rel="ManyToManyRel"><object pk="3"></object></field>
+  </object>
+  <object pk="5" model="orm.customimagepackage">
+    <field to="orm.customimagerecipe" name="recipe_includes" rel="ManyToManyRel"></field>
+    <field to="orm.customimagerecipe" name="recipe_excludes" rel="ManyToManyRel"></field>
+    <field to="orm.customimagerecipe" name="recipe_appends" rel="ManyToManyRel"><object pk="3"></object></field>
+  </object>
+  <object pk="1" model="orm.recipe">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">z recipe</field>
+    <field type="CharField" name="version">5.2</field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">2</field>
+    <field type="TextField" name="summary">z recipe</field>
+    <field type="TextField" name="description">z recipe</field>
+    <field type="CharField" name="section">z section</field>
+    <field type="CharField" name="license">z license</field>
+    <field type="CharField" name="homepage"></field>
+    <field type="CharField" name="bugtracker"></field>
+    <field type="FilePathField" name="file_path"></field>
+    <field type="CharField" name="pathflags"></field>
+    <field type="BooleanField" name="is_image">False</field>
+  </object>
+  <object pk="2" model="orm.recipe">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">a recipe</field>
+    <field type="CharField" name="version">1.2</field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">1</field>
+    <field type="TextField" name="summary">a recipe</field>
+    <field type="TextField" name="description">a recipe</field>
+    <field type="CharField" name="section">a section</field>
+    <field type="CharField" name="license">a license</field>
+    <field type="CharField" name="homepage"></field>
+    <field type="CharField" name="bugtracker"></field>
+    <field type="FilePathField" name="file_path">a_recipe.bb</field>
+    <field type="CharField" name="pathflags"></field>
+    <field type="BooleanField" name="is_image">False</field>
+  </object>
+  <object pk="3" model="orm.recipe">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">a custom recipe</field>
+    <field type="CharField" name="version"></field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">2</field>
+    <field type="TextField" name="summary"></field>
+    <field type="TextField" name="description"></field>
+    <field type="CharField" name="section"></field>
+    <field type="CharField" name="license"></field>
+    <field type="CharField" name="homepage"></field>
+    <field type="CharField" name="bugtracker"></field>
+    <field type="FilePathField" name="file_path">custr</field>
+    <field type="CharField" name="pathflags"></field>
+    <field type="BooleanField" name="is_image">False</field>
+  </object>
+  <object pk="4" model="orm.recipe">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">a image recipe</field>
+    <field type="CharField" name="version">1.2</field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">1</field>
+    <field type="TextField" name="summary">one recipe</field>
+    <field type="TextField" name="description">recipe</field>
+    <field type="CharField" name="section">A</field>
+    <field type="CharField" name="license">A</field>
+    <field type="CharField" name="homepage"></field>
+    <field type="CharField" name="bugtracker"></field>
+    <field type="FilePathField" name="file_path">/one/</field>
+    <field type="CharField" name="pathflags"></field>
+    <field type="BooleanField" name="is_image">True</field>
+  </object>
+  <object pk="5" model="orm.recipe">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">z image recipe</field>
+    <field type="CharField" name="version">1.3</field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">2</field>
+    <field type="TextField" name="summary">two image recipe</field>
+    <field type="TextField" name="description">recipe two</field>
+    <field type="CharField" name="section">B</field>
+    <field type="CharField" name="license">Z</field>
+    <field type="CharField" name="homepage"></field>
+    <field type="CharField" name="bugtracker"></field>
+    <field type="FilePathField" name="file_path">/two/</field>
+    <field type="CharField" name="pathflags"></field>
+    <field type="BooleanField" name="is_image">True</field>
+  </object>
+  <object pk="6" model="orm.recipe">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">z custom recipe</field>
+    <field type="CharField" name="version"></field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">2</field>
+    <field type="TextField" name="summary"></field>
+    <field type="TextField" name="description"></field>
+    <field type="CharField" name="section"></field>
+    <field type="CharField" name="license"></field>
+    <field type="CharField" name="homepage"></field>
+    <field type="CharField" name="bugtracker"></field>
+    <field type="FilePathField" name="file_path">zzzz</field>
+    <field type="CharField" name="pathflags"></field>
+    <field type="BooleanField" name="is_image">False</field>
+  </object>
+  <object pk="1" model="orm.machine">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="name">a machine</field>
+    <field type="CharField" name="description">a machine</field>
+  </object>
+  <object pk="2" model="orm.machine">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">2</field>
+    <field type="CharField" name="name">z machine</field>
+    <field type="CharField" name="description">z machine</field>
+  </object>
+  <object pk="3" model="orm.machine">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="name">g machine</field>
+    <field type="CharField" name="description">g machine</field>
+  </object>
+  <object pk="1" model="orm.layersource">
+    <field type="CharField" name="name">local</field>
+    <field type="IntegerField" name="sourcetype">1</field>
+    <field type="CharField" name="apiurl"></field>
+  </object>
+  <object pk="1" model="orm.bitbakeversion">
+    <field type="CharField" name="name">test bbv</field>
+    <field type="CharField" name="giturl">/tmp/</field>
+    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="dirpath"></field>
+  </object>
+  <object pk="1" model="orm.release">
+    <field type="CharField" name="name">test release</field>
+    <field type="CharField" name="description"></field>
+    <field to="orm.bitbakeversion" name="bitbake_version" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="branch_name">master</field>
+    <field type="TextField" name="helptext"><None></None></field>
+  </object>
+  <object pk="2" model="orm.release">
+    <field type="CharField" name="name">test release 2</field>
+    <field type="CharField" name="description"></field>
+    <field to="orm.bitbakeversion" name="bitbake_version" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="branch_name">master</field>
+    <field type="TextField" name="helptext"><None></None></field>
+  </object>
+  <object pk="1" model="orm.releaselayersourcepriority">
+    <field to="orm.release" name="release" rel="ManyToOneRel">1</field>
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="priority">0</field>
+  </object>
+  <object pk="1" model="orm.branch">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">master</field>
+    <field type="CharField" name="short_description"></field>
+  </object>
+  <object pk="1" model="orm.layer">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">a layer</field>
+    <field type="CharField" name="layer_index_url"></field>
+    <field type="CharField" name="vcs_url">/tmp/</field>
+    <field type="CharField" name="vcs_web_url"><None></None></field>
+    <field type="CharField" name="vcs_web_tree_base_url"><None></None></field>
+    <field type="CharField" name="vcs_web_file_base_url"><None></None></field>
+    <field type="TextField" name="summary"><None></None></field>
+    <field type="TextField" name="description"><None></None></field>
+  </object>
+  <object pk="2" model="orm.layer">
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field type="CharField" name="name">z layer</field>
+    <field type="CharField" name="layer_index_url"></field>
+    <field type="CharField" name="vcs_url">git://two/</field>
+    <field type="CharField" name="vcs_web_url"><None></None></field>
+    <field type="CharField" name="vcs_web_tree_base_url"><None></None></field>
+    <field type="CharField" name="vcs_web_file_base_url"><None></None></field>
+    <field type="TextField" name="summary"><None></None></field>
+    <field type="TextField" name="description"><None></None></field>
+  </object>
+  <object pk="1" model="orm.layer_version">
+    <field to="orm.build" name="build" rel="ManyToOneRel"><None></None></field>
+    <field to="orm.layer" name="layer" rel="ManyToOneRel">1</field>
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field to="orm.branch" name="up_branch" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="branch"></field>
+    <field type="CharField" name="commit">master</field>
+    <field type="CharField" name="dirpath">/tmp/</field>
+    <field type="IntegerField" name="priority">0</field>
+    <field type="FilePathField" name="local_path">/</field>
+    <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
+  </object>
+  <object pk="2" model="orm.layer_version">
+    <field to="orm.build" name="build" rel="ManyToOneRel"><None></None></field>
+    <field to="orm.layer" name="layer" rel="ManyToOneRel">2</field>
+    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
+    <field type="IntegerField" name="up_id"><None></None></field>
+    <field type="DateTimeField" name="up_date"><None></None></field>
+    <field to="orm.branch" name="up_branch" rel="ManyToOneRel">1</field>
+    <field type="CharField" name="branch"></field>
+    <field type="CharField" name="commit">master</field>
+    <field type="CharField" name="dirpath"><None></None></field>
+    <field type="IntegerField" name="priority">0</field>
+    <field type="FilePathField" name="local_path">/</field>
+    <field to="orm.project" name="project" rel="ManyToOneRel"><None></None></field>
+  </object>
+  <object pk="1" model="orm.projectlayer">
+    <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
+    <field to="orm.layer_version" name="layercommit" rel="ManyToOneRel">1</field>
+    <field type="BooleanField" name="optional">True</field>
+  </object>
+  <object pk="3" model="orm.customimagerecipe">
+    <field to="orm.recipe" name="base_recipe" rel="ManyToOneRel">2</field>
+    <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
+    <field type="DateTimeField" name="last_updated"><None></None></field>
+  </object>
+  <object pk="6" model="orm.customimagerecipe">
+    <field to="orm.recipe" name="base_recipe" rel="ManyToOneRel">4</field>
+    <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
+    <field type="DateTimeField" name="last_updated"><None></None></field>
+  </object>
+  <object pk="1" model="orm.logmessage">
+    <field to="orm.build" name="build" rel="ManyToOneRel">2</field>
+    <field to="orm.task" name="task" rel="ManyToOneRel"><None></None></field>
+    <field type="IntegerField" name="level">1</field>
+    <field type="TextField" name="message"><None></None></field>
+    <field type="FilePathField" name="pathname"></field>
+    <field type="IntegerField" name="lineno"><None></None></field>
+  </object>
+  <object pk="2" model="orm.logmessage">
+    <field to="orm.build" name="build" rel="ManyToOneRel">2</field>
+    <field to="orm.task" name="task" rel="ManyToOneRel"><None></None></field>
+    <field type="IntegerField" name="level">2</field>
+    <field type="TextField" name="message"><None></None></field>
+    <field type="FilePathField" name="pathname"></field>
+    <field type="IntegerField" name="lineno"><None></None></field>
+  </object>
+</django-objects>
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 56a7d7e..1b6e78d 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -51,205 +51,17 @@ CLI_BUILDS_PROJECT_NAME = 'Command line builds'
 class ViewTests(TestCase):
     """Tests to verify view APIs."""
 
-    def setUp(self):
-        bbv = BitbakeVersion.objects.create(name="test bbv", giturl="/tmp/",
-                                            branch="master", dirpath="")
-        release = Release.objects.create(name="test release",
-                                         branch_name="master",
-                                         bitbake_version=bbv)
-        release2 = Release.objects.create(name="test release 2",
-                                          branch_name="master",
-                                          bitbake_version=bbv)
-
-        self.project = Project.objects.create_project(name=PROJECT_NAME,
-                                                      release=release)
-
-        self.project2 = Project.objects.create_project(name=PROJECT_NAME2,
-                                                       release=release2)
-
-        now = timezone.now()
-        later = now + timedelta(days=1)
-
-        build = Build.objects.create(project=self.project,
-                                     started_on=now,
-                                     completed_on=now,
-                                     outcome=Build.SUCCEEDED)
-
-        # for testing BuildsTable
-        build1 = Build.objects.create(project=self.project,
-                                      started_on=now,
-                                      completed_on=now,
-                                      outcome=Build.SUCCEEDED,
-                                      machine="raspberrypi2")
-
-        Build.objects.create(project=self.project,
-                             started_on=later,
-                             completed_on=later,
-                             outcome=Build.FAILED,
-                             machine="qemux86")
-
-        Build.objects.create(project=self.project2,
-                             started_on=later,
-                             completed_on=later,
-                             outcome=Build.SUCCEEDED,
-                             machine="qemux86")
-
-        # to test sorting by errors and warnings in BuildsTable
-        LogMessage.objects.create(build=build1, level=LogMessage.WARNING)
-        LogMessage.objects.create(build=build1, level=LogMessage.ERROR)
-
-        layersrc = LayerSource.objects.create(sourcetype=LayerSource.TYPE_IMPORTED)
-        self.priority = ReleaseLayerSourcePriority.objects.create(release=release,
-                                                                  layer_source=layersrc)
-        layer = Layer.objects.create(name="base-layer", layer_source=layersrc,
-                                     vcs_url="/tmp/")
-
-        layer_two = Layer.objects.create(name="z-layer",
-                                         layer_source=layersrc,
-                                         vcs_url="git://two/")
-
-
-        branch = Branch.objects.create(name="master", layer_source=layersrc)
-
-        self.lver = Layer_Version.objects.create(layer=layer,
-                                                 project=self.project,
-                                                 layer_source=layersrc,
-                                                 commit="master",
-                                                 dirpath="/tmp/",
-                                                 up_branch=branch)
-
-        lver_two = Layer_Version.objects.create(layer=layer_two,
-                                                layer_source=layersrc,
-                                                commit="master",
-                                                up_branch=branch)
-
-        Recipe.objects.create(layer_source=layersrc,
-                              name="z recipe",
-                              version="5.2",
-                              summary="z recipe",
-                              description="G recipe",
-                              license="Z GPL",
-                              section="h section",
-                              layer_version=lver_two)
-
-        # Create a dummy recipe file for the custom image generation to read
-        open("/tmp/my_recipe.bb", 'wa').close()
-        self.recipe1 = Recipe.objects.create(layer_source=layersrc,
-                                             name="base-recipe",
-                                             version="1.2",
-                                             summary="one recipe",
-                                             description="recipe",
-                                             section="A section",
-                                             license="Apache",
-                                             layer_version=self.lver,
-                                             file_path="my_recipe.bb")
-
-        Machine.objects.create(layer_version=self.lver, name="wisk",
-                               description="wisking machine")
-        Machine.objects.create(layer_version=self.lver, name="zap",
-                               description="zap machine")
-        Machine.objects.create(layer_version=lver_two, name="xray",
-                               description="xray machine")
-
-
-
-        ProjectLayer.objects.create(project=self.project, layercommit=self.lver)
-
-        lver_custom = Layer_Version.objects.create(layer=layer,
-                                                   project=self.project,
-                                                   layer_source=layersrc,
-                                                   commit="mymaster",
-                                                   up_branch=branch)
-
-        self.customr = CustomImageRecipe.objects.create(\
-                           name="custom recipe", project=self.project,
-                           base_recipe=self.recipe1,
-                           file_path="custr",
-                           layer_version=lver_custom)
-
-        self.package = Package.objects.create(name='pkg1',
-                                              size=999,
-                                              recipe=self.recipe1,
-                                              license="HHH",
-                                              build=build)
-
-        Package.objects.create(name='A pkg1',
-                               size=777,
-                               recipe=self.recipe1,
-                               build=build)
-
-        Package.objects.create(name='zpkg1',
-                               recipe=self.recipe1,
-                               build=build,
-                               size=4,
-                               license="ZZ")
-
-        self.cust_package = CustomImagePackage.objects.create(
-            name="A pkg",
-            recipe=self.recipe1,
-            size=10,
-            license="AAA")
-
-        self.customr.appends_set.add(self.cust_package)
-
-        # recipe with project for testing AvailableRecipe table
-        self.recipe2 = Recipe.objects.create(layer_source=layersrc,
-                                             name="fancy-recipe",
-                                             version="1.4",
-                                             summary="a fancy recipe",
-                                             description="fancy recipe",
-                                             license="MIT",
-                                             layer_version=self.lver,
-                                             section="Z section",
-                                             file_path='/home/foo')
-
-        # additional package for the sorting for the SelectPackagesTable
-        cust_package_two = CustomImagePackage.objects.create(name="ZZ pkg",
-                                                        size=5,
-                                                        recipe=self.recipe2)
-
-        self.customr.appends_set.add(cust_package_two)
-
-        Package.objects.create(name='one1',
-                               recipe=self.recipe2,
-                               build=build,
-                               size=2,
-                               license="L")
-
-        Recipe.objects.create(layer_source=layersrc,
-                              is_image=True,
-                              name="Test image one",
-                              version="1.2",
-                              summary="one recipe",
-                              description="recipe",
-                              section="A",
-                              license="A",
-                              file_path="/one/",
-                              layer_version=self.lver)
-
-        zrecipe = Recipe.objects.create(layer_source=layersrc,
-                                        is_image=True,
-                                        name="Z Test image two",
-                                        version="1.3",
-                                        summary="two image recipe",
-                                        description="recipe two",
-                                        section="B",
-                                        license="Z",
-                                        file_path="/two/",
-                                        layer_version=lver_two)
-
-        CustomImageRecipe.objects.create(name="z custom recipe",
-                                         project=self.project,
-                                         base_recipe=zrecipe,
-                                         file_path="zzzz",
-                                         layer_version=lver_custom)
-
-        # Packages in PackagesTable requre that the recipe has been built so
-        # we need to create a target and build pair
-        target = Target.objects.create(target=self.recipe1.name,
-                                       build=build)
+    fixtures = ['toastergui-unittest-data']
 
+    def setUp(self):
 
+        self.project = Project.objects.first()
+        self.recipe1 = Recipe.objects.get(pk=2)
+        self.recipe2 = Recipe.objects.last()
+        self.customr = CustomImageRecipe.objects.first()
+        self.cust_package = CustomImagePackage.objects.first()
+        self.package = Package.objects.first()
+        self.lver = Layer_Version.objects.first()
 
     def test_get_base_call_returns_html(self):
         """Basic test for all-projects view"""
@@ -271,7 +83,7 @@ class ViewTests(TestCase):
         self.assertEqual(data["error"], "ok")
         self.assertTrue("rows" in data)
 
-        self.assertTrue(PROJECT_NAME in [x["name"] for x in data["rows"]])
+        self.assertTrue(self.project.name in [x["name"] for x in data["rows"]])
         self.assertTrue("id" in data["rows"][0])
 
     def test_typeaheads(self):
@@ -333,11 +145,13 @@ class ViewTests(TestCase):
 
     def test_xhr_import_layer(self):
         """Test xhr_importlayer API"""
+        LayerSource.objects.create(sourcetype=LayerSource.TYPE_IMPORTED)
         #Test for importing an already existing layer
         args = {'vcs_url' : "git://git.example.com/test",
                 'name' : "base-layer",
                 'git_ref': "c12b9596afd236116b25ce26dbe0d793de9dc7ce",
-                'project_id': 1, 'dir_path' : "/path/in/repository"}
+                'project_id': self.project.id,
+                'dir_path' : "/path/in/repository"}
         response = self.client.post(reverse('xhr_importlayer'), args)
         data = json.loads(response.content)
         self.assertEqual(response.status_code, 200)
@@ -407,13 +221,12 @@ class ViewTests(TestCase):
 
     def test_xhr_custom_details(self):
         """Test getting custom recipe details"""
-        name = "custom recipe"
         url = reverse('xhr_customrecipe_id', args=(self.customr.id,))
         response = self.client.get(url)
         self.assertEqual(response.status_code, 200)
         expected = {"error": "ok",
                     "info": {'id': self.customr.id,
-                             'name': name,
+                             'name': self.customr.name,
                              'base_recipe_id': self.recipe1.id,
                              'project_id': self.project.id,
                             }
@@ -484,6 +297,10 @@ class ViewTests(TestCase):
                                     {"error": "ok"})
 
     def test_download_custom_recipe(self):
+        """Download the recipe file generated for the custom image"""
+
+        # Create a dummy recipe file for the custom image generation to read
+        open("/tmp/a_recipe.bb", 'wa').close()
         response = self.client.get(reverse('customrecipedownload',
                                            args=(self.project.id,
                                                  self.customr.id)))
@@ -503,8 +320,6 @@ class ViewTests(TestCase):
         row2 = next(x for x in rows if x['name'] == self.recipe2.name)
 
         self.assertEqual(response.status_code, 200, 'should be 200 OK status')
-        # All recipes in the setUp
-        self.assertEqual(len(rows), 5, 'should be 5 recipes')
 
         # check other columns have been populated correctly
         self.assertEqual(row1['name'], self.recipe1.name)
@@ -529,13 +344,20 @@ class ViewTests(TestCase):
             options['format'] = "json"
             options['nocache'] = "true"
             request = RequestFactory().get('/', options)
+
+            # This is the image recipe needed for a package list for
+            # PackagesTable do this here to throw a non exist exception
+            image_recipe = Recipe.objects.get(pk=4)
+
             # Add any kwargs that are needed by any of the possible tables
-            response = table.get(request,
-                                 pid=self.project.id,
-                                 layerid=self.lver.pk,
-                                 recipeid=self.recipe1.pk,
-                                 recipe_id=self.recipe1.pk,
-                                 custrecipeid=self.customr.pk)
+            args = {'pid': self.project.id,
+                    'layerid': self.lver.pk,
+                    'recipeid': self.recipe1.pk,
+                    'recipe_id': image_recipe.pk,
+                    'custrecipeid': self.customr.pk
+                   }
+
+            response = table.get(request, **args)
             return json.loads(response.content)
 
         # Get a list of classes in tables module
@@ -562,10 +384,14 @@ class ViewTests(TestCase):
 
                 if '-' in table.default_orderby:
                     self.assertTrue(row_one >= row_two,
-                                    "Default ordering not working on %s" % name)
+                                    "Default ordering not working on %s"
+                                    " '%s' should be >= '%s'" %
+                                    (name, row_one, row_two))
                 else:
                     self.assertTrue(row_one <= row_two,
-                                    "Default ordering not working on %s" % name)
+                                    "Default ordering not working on %s"
+                                    " '%s' should be <= '%s'" %
+                                    (name, row_one, row_two))
 
             # Test the column ordering and filtering functionality
             for column in table.columns:
@@ -580,7 +406,9 @@ class ViewTests(TestCase):
 
                     self.assertTrue(row_one <= row_two,
                                     "Ascending sort applied but row 0 is less "
-                                    "than row 1")
+                                    "than row 1 %s %s " %
+                                    (column['field_name'], name))
+
 
                     descending = get_data(table_cls(),
                                           {"orderby" :
@@ -591,7 +419,8 @@ class ViewTests(TestCase):
 
                     self.assertTrue(row_one >= row_two,
                                     "Descending sort applied but row 0 is "
-                                    "greater than row 1")
+                                    "greater than row 1 %s %s" %
+                                    (column['field_name'], name))
 
                     # If the two start rows are the same we haven't actually
                     # changed the order
-- 
1.9.1


