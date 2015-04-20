Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
	[209.85.192.177])
	by mail.openembedded.org (Postfix) with ESMTP id E93096E268
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Apr 2015 13:43:05 +0000 (UTC)
Received: by pdbnk13 with SMTP id nk13so208156922pdb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Apr 2015 06:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=tnn45MniF5Ws+BSRlH/zq/ESj5W33tWfAOt+lmcd7yg=;
	b=i1mWhWe1PTWA+eJQgKBVlTci0X9cdcY/LKV0ZfqftqR6ybNDTitavuW9H6cMedbbNp
	sKKFAAgleBxvs3bs5HGr6AfkLWGBidDbuzuZtf+81u4xInqrLFJhyck7SdT1WJ2Yudu2
	v5VUcPn27/uqhFMDq/nnmCLq/BSndQIVbLTn6aTU5cq3e/Mr1bzDdb+n6imAzAPPeRwo
	cqebi9AD/ocS7bUoHHOYmlN+REPJx5F7q0lBIOn9JQz3unPiftpJtna402LNSPN3d4rT
	yAlBhZX5Z3ej1refsT4l49vqbzd2bMufS00FV6mZwi6wWEiXrRm0RHrk+Nx23ppsX+28
	JFqg==
X-Gm-Message-State: ALoCoQkmi44MvnjKi0hC3HrBSlHIHQ1P28q3vIlz/X90XQ3Tyzh4GzDn0wLTrZdWUhl4TLQ7gohq
X-Received: by 10.70.35.108 with SMTP id g12mr15828568pdj.75.1429537386487;
	Mon, 20 Apr 2015 06:43:06 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id a5sm5274884pdk.58.2015.04.20.06.43.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 Apr 2015 06:43:05 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D8F36561547; Mon, 20 Apr 2015 13:31:20 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Apr 2015 13:31:19 +0100
Message-Id: <1429533079-32620-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 1/1] setup.py update for 1.26 release
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
X-List-Received-Date: Mon, 20 Apr 2015 13:43:06 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch updates setup.py and MANIFEST.in so it correctly
packages bitbake in standard python package format.

Use "python manage.py sdist" to generate installation package.

Minor updates to toaster scripts so they work correctly
from a package installation.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 MANIFEST.in                         | 207 ++++++++++++++++++++++++++++++++++--
 bin/toaster                         |  31 ++++--
 lib/toaster/toastermain/settings.py |   4 -
 lib/toaster/toastermain/urls.py     |   3 -
 setup.py                            |  16 +--
 5 files changed, 232 insertions(+), 29 deletions(-)

diff --git a/MANIFEST.in b/MANIFEST.in
index b197378..b837b2b 100644
--- a/MANIFEST.in
+++ b/MANIFEST.in
@@ -1,11 +1,204 @@
-include COPYING
-include ChangeLog
 include AUTHORS
+include bin/bitbake-worker
+include bin/bitdoc
+include bin/image-writer
+include bin/toaster
+include bin/toaster-eventreplay
+include build/scripts-2.7/bitbake
+include build/scripts-2.7/bitbake-diffsigs
+include build/scripts-2.7/bitbake-dumpsig
+include build/scripts-2.7/bitbake-layers
+include build/scripts-2.7/bitbake-prserv
+include build/scripts-2.7/bitbake-selftest
+include build/scripts-2.7/bitbake-worker
+include build/scripts-2.7/bitdoc
+include build/scripts-2.7/image-writer
+include build/scripts-2.7/toaster
+include build/scripts-2.7/toaster-eventreplay
+include ChangeLog
+include classes/*
+include classes/base.bbclass
+include conf/*
+include conf/bitbake.conf
 include contrib/*
+include contrib/bbdev.sh
+include contrib/README
 include contrib/vim/*/*
-include conf/*
-include classes/*
-include doc/*
-include doc/manual/*
-include ez_setup.py
+include contrib/vim/ftdetect/bitbake.vim
+include contrib/vim/ftplugin/bitbake.vim
+include contrib/vim/plugin/newbb.vim
+include contrib/vim/syntax/bitbake.vim
+include COPYING
+recursive-include doc *
 include HEADER
+
+include lib/bb/ui/crumbs/puccho.glade
+include lib/bb/ui/icons/images/images_display.png
+include lib/bb/ui/icons/images/images_hover.png
+include lib/bb/ui/icons/indicators/add-hover.png
+include lib/bb/ui/icons/indicators/add.png
+include lib/bb/ui/icons/indicators/alert.png
+include lib/bb/ui/icons/indicators/confirmation.png
+include lib/bb/ui/icons/indicators/denied.png
+include lib/bb/ui/icons/indicators/error.png
+include lib/bb/ui/icons/indicators/info.png
+include lib/bb/ui/icons/indicators/issues.png
+include lib/bb/ui/icons/indicators/refresh.png
+include lib/bb/ui/icons/indicators/remove-hover.png
+include lib/bb/ui/icons/indicators/remove.png
+include lib/bb/ui/icons/indicators/tick.png
+include lib/bb/ui/icons/info/info_display.png
+include lib/bb/ui/icons/info/info_hover.png
+include lib/bb/ui/icons/layers/layers_display.png
+include lib/bb/ui/icons/layers/layers_hover.png
+include lib/bb/ui/icons/packages/packages_display.png
+include lib/bb/ui/icons/packages/packages_hover.png
+include lib/bb/ui/icons/recipe/recipe_display.png
+include lib/bb/ui/icons/recipe/recipe_hover.png
+include lib/bb/ui/icons/settings/settings_display.png
+include lib/bb/ui/icons/settings/settings_hover.png
+include lib/bb/ui/icons/templates/templates_display.png
+include lib/bb/ui/icons/templates/templates_hover.png
+include lib/bs4/AUTHORS.txt
+include lib/bs4/COPYING.txt
+include lib/bs4/NEWS.txt
+include lib/toaster/bldviewer/static/css/bootstrap.css
+include lib/toaster/bldviewer/static/js/bootstrap.js
+include lib/toaster/bldviewer/static/js/jquery-2.0.3.js
+include lib/toaster/bldviewer/templates/simple_basebuildpage.html
+include lib/toaster/bldviewer/templates/simple_base.html
+include lib/toaster/bldviewer/templates/simple_basetable.html
+include lib/toaster/bldviewer/templates/simple_bfile.html
+include lib/toaster/bldviewer/templates/simple_bpackage.html
+include lib/toaster/bldviewer/templates/simple_build.html
+include lib/toaster/bldviewer/templates/simple_configuration.html
+include lib/toaster/bldviewer/templates/simple_layer.html
+include lib/toaster/bldviewer/templates/simple_package.html
+include lib/toaster/bldviewer/templates/simple_recipe.html
+include lib/toaster/bldviewer/templates/simple_task.html
+include lib/toaster/toastergui/static/css/bootstrap.min.css
+include lib/toaster/toastergui/static/css/bootstrap-responsive.min.css
+include lib/toaster/toastergui/static/css/default.css
+include lib/toaster/toastergui/static/css/font-awesome.min.css
+include lib/toaster/toastergui/static/css/images/ui-bg_diagonals-thick_18_b81900_40x40.png
+include lib/toaster/toastergui/static/css/images/ui-bg_diagonals-thick_20_666666_40x40.png
+include lib/toaster/toastergui/static/css/images/ui-bg_flat_10_000000_40x100.png
+include lib/toaster/toastergui/static/css/images/ui-bg_glass_100_f6f6f6_1x400.png
+include lib/toaster/toastergui/static/css/images/ui-bg_glass_100_fdf5ce_1x400.png
+include lib/toaster/toastergui/static/css/images/ui-bg_glass_65_ffffff_1x400.png
+include lib/toaster/toastergui/static/css/images/ui-bg_gloss-wave_35_f6a828_500x100.png
+include lib/toaster/toastergui/static/css/images/ui-bg_highlight-soft_100_eeeeee_1x100.png
+include lib/toaster/toastergui/static/css/images/ui-bg_highlight-soft_75_ffe45c_1x100.png
+include lib/toaster/toastergui/static/css/images/ui-icons_222222_256x240.png
+include lib/toaster/toastergui/static/css/images/ui-icons_228ef1_256x240.png
+include lib/toaster/toastergui/static/css/images/ui-icons_ef8c08_256x240.png
+include lib/toaster/toastergui/static/css/images/ui-icons_ffd27a_256x240.png
+include lib/toaster/toastergui/static/css/images/ui-icons_ffffff_256x240.png
+include lib/toaster/toastergui/static/css/jquery.treetable.css
+include lib/toaster/toastergui/static/css/jquery.treetable.theme.default.css
+include lib/toaster/toastergui/static/css/jquery.treetable.theme.toaster.css
+include lib/toaster/toastergui/static/css/jquery-ui.min.css
+include lib/toaster/toastergui/static/css/jquery-ui.structure.min.css
+include lib/toaster/toastergui/static/css/jquery-ui.theme.min.css
+include lib/toaster/toastergui/static/css/prettify.css
+include lib/toaster/toastergui/static/css/screen.css
+include lib/toaster/toastergui/static/fonts/FontAwesome.otf
+include lib/toaster/toastergui/static/fonts/fontawesome-webfont.eot
+include lib/toaster/toastergui/static/fonts/fontawesome-webfont.svg
+include lib/toaster/toastergui/static/fonts/fontawesome-webfont.ttf
+include lib/toaster/toastergui/static/fonts/fontawesome-webfont.woff
+include lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.eot
+include lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.svg
+include lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.ttf
+include lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.woff
+include lib/toaster/toastergui/static/img/logo.png
+include lib/toaster/toastergui/static/img/toaster_1.7.png
+include lib/toaster/toastergui/static/img/toaster.png
+include lib/toaster/toastergui/static/jquery-treetable-license/GPL-LICENSE.txt
+include lib/toaster/toastergui/static/jquery-treetable-license/MIT-LICENSE.txt
+include lib/toaster/toastergui/static/jquery-treetable-license/README.md
+include lib/toaster/toastergui/static/jquery.treetable.theme.toaster.css
+include lib/toaster/toastergui/static/js/angular-animate.min.js
+include lib/toaster/toastergui/static/js/angular-cookies.min.js
+include lib/toaster/toastergui/static/js/angular.min.js
+include lib/toaster/toastergui/static/js/angular.min.js.map
+include lib/toaster/toastergui/static/js/angular-route.min.js
+include lib/toaster/toastergui/static/js/angular-sanitize.min.js
+include lib/toaster/toastergui/static/js/base.js
+include lib/toaster/toastergui/static/js/bootstrap.min.js
+include lib/toaster/toastergui/static/js/filtersnippet.js
+include lib/toaster/toastergui/static/js/importlayer.js
+include lib/toaster/toastergui/static/js/jquery-2.0.3.min.js
+include lib/toaster/toastergui/static/js/jquery-2.0.3.min.map
+include lib/toaster/toastergui/static/js/jquery.cookie.js
+include lib/toaster/toastergui/static/js/jquery.treetable.js
+include lib/toaster/toastergui/static/js/jquery-ui.min.js
+include lib/toaster/toastergui/static/js/.jshintrc
+include lib/toaster/toastergui/static/js/layerdetails.js
+include lib/toaster/toastergui/static/js/libtoaster.js
+include lib/toaster/toastergui/static/js/machines.js
+include lib/toaster/toastergui/static/js/prettify.js
+include lib/toaster/toastergui/static/js/projectapp.js
+include lib/toaster/toastergui/static/js/ui-bootstrap-tpls-0.11.0.js
+include lib/toaster/toastergui/static/js/ui-bootstrap-tpls-0.11.0.min.js
+include lib/toaster/toastergui/templates/basebuilddetailpage.html
+include lib/toaster/toastergui/templates/basebuildpage.html
+include lib/toaster/toastergui/templates/base.html
+include lib/toaster/toastergui/templates/baseprojectpage.html
+include lib/toaster/toastergui/templates/basetable_bottom.html
+include lib/toaster/toastergui/templates/basetable_top_buildprojects.html
+include lib/toaster/toastergui/templates/basetable_top.html
+include lib/toaster/toastergui/templates/basetable_top_layers.html
+include lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
+include lib/toaster/toastergui/templates/bfile.html
+include lib/toaster/toastergui/templates/bpackage.html
+include lib/toaster/toastergui/templates/builddashboard.html
+include lib/toaster/toastergui/templates/build.html
+include lib/toaster/toastergui/templates/buildrequestdetails.html
+include lib/toaster/toastergui/templates/buildtime.html
+include lib/toaster/toastergui/templates/configuration.html
+include lib/toaster/toastergui/templates/configvars.html
+include lib/toaster/toastergui/templates/cpuusage.html
+include lib/toaster/toastergui/templates/detail_pagination_bottom.html
+include lib/toaster/toastergui/templates/detail_search_header.html
+include lib/toaster/toastergui/templates/detail_sorted_header.html
+include lib/toaster/toastergui/templates/dirinfo.html
+include lib/toaster/toastergui/templates/diskio.html
+include lib/toaster/toastergui/templates/filtersnippet.html
+include lib/toaster/toastergui/templates/importlayer.html
+include lib/toaster/toastergui/templates/landing.html
+include lib/toaster/toastergui/templates/landing_not_managed.html
+include lib/toaster/toastergui/templates/layerdetails.html
+include lib/toaster/toastergui/templates/layer.html
+include lib/toaster/toastergui/templates/layers_dep_modal.html
+include lib/toaster/toastergui/templates/layers.html
+include lib/toaster/toastergui/templates/machines.html
+include lib/toaster/toastergui/templates/managed_builds.html
+include lib/toaster/toastergui/templates/managed_mrb_section.html
+include lib/toaster/toastergui/templates/mrb_section.html
+include lib/toaster/toastergui/templates/newproject.html
+include lib/toaster/toastergui/templates/package_built_dependencies.html
+include lib/toaster/toastergui/templates/package_built_detail.html
+include lib/toaster/toastergui/templates/package_detail_base.html
+include lib/toaster/toastergui/templates/package.html
+include lib/toaster/toastergui/templates/package_included_dependencies.html
+include lib/toaster/toastergui/templates/package_included_detail.html
+include lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
+include lib/toaster/toastergui/templates/package_included_tabs.html
+include lib/toaster/toastergui/templates/projectbuilds.html
+include lib/toaster/toastergui/templates/projectconf.html
+include lib/toaster/toastergui/templates/project.html
+include lib/toaster/toastergui/templates/projects.html
+include lib/toaster/toastergui/templates/recipe.html
+include lib/toaster/toastergui/templates/recipe_packages.html
+include lib/toaster/toastergui/templates/recipes.html
+include lib/toaster/toastergui/templates/tablesort.html
+include lib/toaster/toastergui/templates/target.html
+include lib/toaster/toastergui/templates/targets.html
+include lib/toaster/toastergui/templates/task.html
+include lib/toaster/toastergui/templates/tasks.html
+include lib/toaster/toastergui/templates/unavailable_artifact.html
+include LICENSE
+include MANIFEST.in
+include toaster-requirements.txt
+include TODO
diff --git a/bin/toaster b/bin/toaster
index 7907b57..47da7eb 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -53,23 +53,23 @@ function webserverStartAll()
         fi
 
         retval=0
-        python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
-        python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
+        python $MANAGEPY syncdb || retval=1
+        python $MANAGEPY migrate orm || retval=2
         if [ $retval -eq 1 ]; then
                 echo "Failed db sync, stopping system start" 1>&2
         elif [ $retval -eq 2 ]; then
             echo -e "\nError on migration, trying to recover... \n"
-            python $BBBASEDIR/lib/toaster/manage.py migrate orm 0001_initial --fake
+            python $MANAGEPY migrate orm 0001_initial --fake
             retval=0
-            python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
+            python $MANAGEPY migrate orm || retval=1
         fi
 	if [ "x$TOASTER_MANAGED" == "x1" ]; then
-	        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
-		python $BBBASEDIR/lib/toaster/manage.py checksettings  --traceback || retval=1
+	        python $MANAGEPY migrate bldcontrol || retval=1
+		python $MANAGEPY checksettings  --traceback || retval=1
 	fi
         if [ $retval -eq 0 ]; then
 	    echo "Starting webserver..."
-            python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
+            python $MANAGEPY runserver "0.0.0.0:$WEB_PORT" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
             sleep 1
             if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
                 retval=1
@@ -145,6 +145,21 @@ function verify_prereq() {
 # read command line parameters
 
 BBBASEDIR=`dirname ${BASH_SOURCE}`/..
+
+MANAGEPY=$BBBASEDIR/lib/toaster/manage.py
+
+if [ ! -f "$MANAGEPY" ]; then
+   echo "Could not find $MANAGEPY, trying autodetection"
+   MANAGEPY=`echo -e "from toaster import manage\nprint manage.__file__" | python`
+   echo "MANAGEPY is $MANAGEPY"
+fi
+
+if [ ! -f $MANAGEPY ]; then
+   echo "Could not find toaster's manage.py; this is a serious error and I don't know what to do"
+   exit
+fi
+
+
 RUNNING=0
 
 NOTOASTERUI=0
@@ -235,7 +250,7 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     trap trap_ctrlc SIGINT
     echo "Toaster is now running. You can stop it with Ctrl-C"
     while [ $RUNNING -gt 0 ]; do
-        python $BBBASEDIR/lib/toaster/manage.py runbuilds 2>&1 | tee -a "$BUILDDIR/toaster.log"
+        python $MANAGEPY runbuilds 2>&1 | tee -a "$BUILDDIR/toaster.log"
         sleep 1
     done
     cleanup
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 80f26e0..17792c2 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -324,10 +324,6 @@ import os
 currentdir = os.path.dirname(__file__)
 for t in os.walk(os.path.dirname(currentdir)):
     modulename = os.path.basename(t[0])
-    #if we have a virtualenv skip it to avoid incorrect imports
-    if os.environ.has_key('VIRTUAL_ENV') and os.environ['VIRTUAL_ENV'] in t[0]:
-        continue
-
     if ("views.py" in t[2] or "models.py" in t[2]) and not modulename in INSTALLED_APPS:
         INSTALLED_APPS = INSTALLED_APPS + (modulename,)
 
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 395c4e8..e9481c9 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -69,9 +69,6 @@ if toastermain.settings.MANAGED:
 import os
 currentdir = os.path.dirname(__file__)
 for t in os.walk(os.path.dirname(currentdir)):
-    #if we have a virtualenv skip it to avoid incorrect imports
-    if os.environ.has_key('VIRTUAL_ENV') and os.environ['VIRTUAL_ENV'] in t[0]:
-        continue
 
     if "urls.py" in t[2] and t[0] != currentdir:
         modulename = os.path.basename(t[0])
diff --git a/setup.py b/setup.py
index 02de77b..f20b431 100755
--- a/setup.py
+++ b/setup.py
@@ -51,14 +51,14 @@ class Build(build):
 
 setup(name='bitbake',
       version = __version__,
-      requires = ["ply", "progressbar"],
-      package_dir = {"": "lib"},
-      packages = ["bb.server", "bb.parse.parse_py", "bb.parse", 
-                  "bb.fetch2", "bb.ui.crumbs", "bb.ui", "bb.pysh", "bb", "prserv", "bb.tests"],
-      py_modules = ["codegen"],
-      scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs", "bin/bitbake-prserv", "bin/bitbake-selftest", "bin/image-writer"],
+      requires = ["gobject", "html5lib", "lxml", "django", "south", "argparse", "wsgiref", "pyinotify"],
+      package_dir = {"": "lib", "toaster": "lib/toaster" },
+      packages = ['ply',  'prserv', 'bs4', 'bs4.builder', 'bs4.tests', 'bb', 'bb.tests', 'bb.fetch2', 'bb.pysh', 'bb.ui', 'bb.ui.crumbs', 'bb.ui.crumbs.hig', 'bb.server', 'bb.parse', 'bb.parse.parse_py', 'toaster', 'toaster.bldviewer', 'toaster.bldviewer.templatetags', 'toaster.toastergui', 'toaster.toastergui.templatetags', 'toaster.orm', 'toaster.orm.management', 'toaster.orm.management.commands', 'toaster.orm.migrations', 'toaster.bldcontrol', 'toaster.bldcontrol.management', 'toaster.bldcontrol.management.commands', 'toaster.bldcontrol.migrations', 'toaster.toastermain', 'toaster.toastermain.management', 'toaster.toastermain.management.commands'],
+      py_modules = ["codegen", "progressbar", "pyinotify"],
+      scripts = [ "bin/bitbake-layers", "bin/bitbake-worker", "bin/toaster-eventreplay", "bin/toaster", "bin/bitbake-diffsigs", "bin/bitbake-dumpsig", "bin/bitdoc", "bin/image-writer", "bin/bitbake", "bin/bitbake-selftest", "bin/bitbake-prserv" ],
       data_files = [("share/bitbake", glob("conf/*") + glob("classes/*")),
                   ("share/doc/bitbake-%s/bitbake-user-manual" % __version__, glob("doc/bitbake-user-manual/html/*"))],
+      include_package_data=True,
       cmdclass = {
           "build": Build,
           "clean": Clean,
@@ -69,5 +69,7 @@ setup(name='bitbake',
       description = 'BitBake build tool',
       long_description = 'BitBake is a simple tool for the execution of tasks. It is derived from Portage, which is the package management system used by the Gentoo Linux distribution. It is most commonly used to build packages, as it can easily use its rudimentary inheritance to abstract common operations, such as fetching sources, unpacking them, patching them, compiling them, and so on.  It is the basis of the OpenEmbedded project, which is being used for OpenZaurus, Familiar, and a number of other Linux distributions.',
       author = 'BitBake Development Team',
-      author_email = 'bitbake-dev@lists.berlios.de',
+      author_email = 'bitbake-devel@lists.openembedded.org',
+      maintainer = "Alexandru Damian",
+      maintainer_email = "alexandru.damian@intel.com",
 )
-- 
1.9.1


