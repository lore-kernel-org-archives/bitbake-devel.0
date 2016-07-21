Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id CA0F1731EA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:44:30 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 79C9E1BC495;
	Thu, 21 Jul 2016 13:44:28 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-107-69-155.us-west-2.compute.internal [10.107.69.155])
	by relay.mailchannels.net (Postfix) with ESMTPA id CD665169E47;
	Thu, 21 Jul 2016 13:44:27 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.92.147.53])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:44:28 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108668267:2415800675
X-MC-Ingress-Time: 1469108668267
Received: from [176.249.240.35] (port=56888 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQEH4-0002ZY-Fb; Thu, 21 Jul 2016 09:44:26 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:43:28 +0100
Message-Id: <1469108612-12433-6-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469108612-12433-1-git-send-email-elliot.smith@intel.com>
References: <1469108612-12433-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH][v2 06/10] toaster: tests: Remove references to LayerSource model
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
X-List-Received-Date: Thu, 21 Jul 2016 13:44:31 -0000

From: Michael Wood <michael.g.wood@intel.com>

Remove and replace layersource model references in the tests and test
data. Remove the orm/test as this only tested LayerSource interactions
which have now been removed.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../bldcontrol/management/commands/loadconf.py     |  18 ---
 bitbake/lib/toaster/orm/tests.py                   | 180 ---------------------
 .../tests/browser/test_layerdetails_page.py        |   2 +-
 .../fixtures/toastergui-unittest-data.xml          |  39 -----
 bitbake/lib/toaster/toastergui/tests.py            |   3 +-
 5 files changed, 2 insertions(+), 240 deletions(-)
 delete mode 100644 bitbake/lib/toaster/orm/tests.py

diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py b/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
index 6f08f1d..1f57fc1 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -9,24 +9,6 @@ from .checksettings import DN
 import logging
 logger = logging.getLogger("toaster")
 
-def _reduce_canon_path(path):
-    components = []
-    for c in path.split("/"):
-        if c == "..":
-            del components[-1]
-        elif c == ".":
-            pass
-        else:
-            components.append(c)
-    if len(components) < 2:
-        components.append('')
-    return "/".join(components)
-
-def _get_id_for_sourcetype(s):
-    for i in LayerSource.SOURCE_TYPE:
-        if s == i[1]:
-            return i[0]
-    raise Exception("Could not find definition for sourcetype '%s'. Valid source types are %s" % (str(s), ', '.join(map(lambda x: "'%s'" % x[1], LayerSource.SOURCE_TYPE ))))
 
 class Command(BaseCommand):
     help = "Loads a toasterconf.json file in the database"
diff --git a/bitbake/lib/toaster/orm/tests.py b/bitbake/lib/toaster/orm/tests.py
deleted file mode 100644
index 719266e..0000000
--- a/bitbake/lib/toaster/orm/tests.py
+++ /dev/null
@@ -1,180 +0,0 @@
-#! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
-# BitBake Toaster Implementation
-#
-# Copyright (C) 2013-2015 Intel Corporation
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-"""Test cases for Toaster ORM."""
-
-from django.test import TestCase, TransactionTestCase
-from orm.models import LocalLayerSource, LayerIndexLayerSource, ImportedLayerSource, LayerSource
-from orm.models import Branch, LayerVersionDependency
-
-from orm.models import Project, Layer, Layer_Version, Branch, ProjectLayer
-from orm.models import Release, ReleaseLayerSourcePriority, BitbakeVersion
-
-from django.db import IntegrityError
-
-import os
-
-# set TTS_LAYER_INDEX to the base url to use a different instance of the layer index
-
-class LayerSourceVerifyInheritanceSaveLoad(TestCase):
-    """
-    Tests to verify inheritance for the LayerSource proxy-inheritance classes.
-    """
-    def test_object_creation(self):
-        """Test LayerSource object creation."""
-        for name, sourcetype in [("a1", LayerSource.TYPE_LOCAL),
-                                 ("a2", LayerSource.TYPE_LAYERINDEX),
-                                 ("a3", LayerSource.TYPE_IMPORTED)]:
-            LayerSource.objects.create(name=name, sourcetype=sourcetype)
-
-        objects = LayerSource.objects.all()
-        self.assertTrue(isinstance(objects[0], LocalLayerSource))
-        self.assertTrue(isinstance(objects[1], LayerIndexLayerSource))
-        self.assertTrue(isinstance(objects[2], ImportedLayerSource))
-
-    def test_duplicate_error(self):
-        """Test creation of duplicate LayerSource objects."""
-        stype = LayerSource.TYPE_LOCAL
-        LayerSource.objects.create(name="a1", sourcetype=stype)
-        with self.assertRaises(IntegrityError):
-            LayerSource.objects.create(name="a1", sourcetype=stype)
-
-
-class LILSUpdateTestCase(TransactionTestCase):
-    """Test Layer Source update."""
-
-    def setUp(self):
-        """Create release."""
-        bbv = BitbakeVersion.objects.create(\
-                  name="master", giturl="git://git.openembedded.org/bitbake")
-        Release.objects.create(name="default-release", bitbake_version=bbv,
-                               branch_name="master")
-
-    def test_update(self):
-        """Check if LayerSource.update can fetch branches."""
-        url = os.getenv("TTS_LAYER_INDEX",
-                        default="http://layers.openembedded.org/")
-
-        lsobj = LayerSource.objects.create(\
-                    name="b1", sourcetype=LayerSource.TYPE_LAYERINDEX,
-                    apiurl=url + "layerindex/api/")
-        lsobj.update()
-        self.assertTrue(lsobj.branch_set.all().count() > 0,
-                        "no branches fetched")
-
-class LayerVersionEquivalenceTestCase(TestCase):
-    """Verify Layer_Version priority selection."""
-
-    def setUp(self):
-        """Create required objects."""
-        # create layer source
-        self.lsrc = LayerSource.objects.create(name="dummy-layersource",
-                                               sourcetype=LayerSource.TYPE_LOCAL)
-        # create release
-        bbv = BitbakeVersion.objects.create(\
-                  name="master", giturl="git://git.openembedded.org/bitbake")
-        self.release = Release.objects.create(name="default-release",
-                                              bitbake_version=bbv,
-                                              branch_name="master")
-        # attach layer source to release
-        ReleaseLayerSourcePriority.objects.create(\
-            release=self.release, layer_source=self.lsrc, priority=1)
-
-        # create a layer version for the layer on the specified branch
-        self.layer = Layer.objects.create(name="meta-testlayer",
-                                          layer_source=self.lsrc)
-        self.branch = Branch.objects.create(name="master", layer_source=self.lsrc)
-        self.lver = Layer_Version.objects.create(\
-            layer=self.layer, layer_source=self.lsrc, up_branch=self.branch)
-
-        # create project and project layer
-        self.project = Project.objects.create_project(name="test-project",
-                                                      release=self.release)
-        ProjectLayer.objects.create(project=self.project,
-                                    layercommit=self.lver)
-
-        # create spoof layer that should not appear in the search results
-        layer = Layer.objects.create(name="meta-notvalid",
-                                     layer_source=self.lsrc)
-        self.lver2 = Layer_Version.objects.create(layer=layer,
-                                                  layer_source=self.lsrc,
-                                                  up_branch=self.branch)
-
-    def test_single_layersource(self):
-        """
-        When we have a single layer version,
-        get_equivalents_wpriority() should return a list with
-        just this layer_version.
-        """
-        equivqs = self.lver.get_equivalents_wpriority(self.project)
-        self.assertEqual(list(equivqs), [self.lver])
-
-    def test_dual_layersource(self):
-        """
-        If we have two layers with the same name, from different layer sources,
-        we expect both layers in, in increasing priority of the layer source.
-        """
-        lsrc2 = LayerSource.objects.create(\
-                    name="dummy-layersource2",
-                    sourcetype=LayerSource.TYPE_LOCAL,
-                    apiurl="test")
-
-        # assign a lower priority for the second layer source
-        self.release.releaselayersourcepriority_set.create(layer_source=lsrc2,
-                                                           priority=2)
-
-        # create a new layer_version for a layer with the same name
-        # coming from the second layer source
-        layer2 = Layer.objects.create(name="meta-testlayer",
-                                      layer_source=lsrc2)
-        lver2 = Layer_Version.objects.create(layer=layer2, layer_source=lsrc2,
-                                             up_branch=self.branch)
-
-        # expect two layer versions, in the priority order
-        equivqs = self.lver.get_equivalents_wpriority(self.project)
-        self.assertEqual(list(equivqs), [lver2, self.lver])
-
-    def test_compatible_layer_versions(self):
-        """
-        When we have a 2 layer versions, get_all_compatible_layerversions()
-        should return a queryset with both.
-        """
-        compat_lv = self.project.get_all_compatible_layer_versions()
-        self.assertEqual(list(compat_lv), [self.lver, self.lver2])
-
-    def test_layerversion_get_alldeps(self):
-        """Test Layer_Version.get_alldeps API."""
-        lvers = {}
-        for i in range(10):
-            name = "layer%d" % i
-            lvers[name] = Layer_Version.objects.create(layer=Layer.objects.create(name=name),
-                                                       project=self.project)
-            if i:
-                LayerVersionDependency.objects.create(layer_version=lvers["layer%d" % (i - 1)],
-                                                      depends_on=lvers[name])
-                # Check dinamically added deps
-                self.assertEqual(lvers['layer0'].get_alldeps(self.project.id),
-                                 [lvers['layer%d' % n] for n in range(1, i+1)])
-
-        # Check chain of deps created in previous loop
-        for i in range(10):
-            self.assertEqual(lvers['layer%d' % i].get_alldeps(self.project.id),
-                             [lvers['layer%d' % n] for n in range(i+1, 10)])
diff --git a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
index 71c5c12..0005192 100644
--- a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -63,7 +63,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
 
         self.imported_layer_version = Layer_Version.objects.create(
             layer=imported_layer,
-            layer_source=layer_source,
+            layer_source=LayerSource.TYPE_IMPORTED,
             branch=gitrev,
             commit=gitrev,
             dirpath=subdir,
diff --git a/bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml b/bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
index 213bf0f..80c1e19 100644
--- a/bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
+++ b/bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
@@ -195,8 +195,6 @@
     <field to="orm.customimagerecipe" name="recipe_appends" rel="ManyToManyRel"><object pk="3"></object></field>
   </object>
   <object pk="1" model="orm.recipe">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">z recipe</field>
     <field type="CharField" name="version">5.2</field>
@@ -212,8 +210,6 @@
     <field type="BooleanField" name="is_image">False</field>
   </object>
   <object pk="2" model="orm.recipe">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">a recipe</field>
     <field type="CharField" name="version">1.2</field>
@@ -229,8 +225,6 @@
     <field type="BooleanField" name="is_image">False</field>
   </object>
   <object pk="3" model="orm.recipe">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">a custom recipe</field>
     <field type="CharField" name="version"></field>
@@ -246,8 +240,6 @@
     <field type="BooleanField" name="is_image">False</field>
   </object>
   <object pk="4" model="orm.recipe">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">a image recipe</field>
     <field type="CharField" name="version">1.2</field>
@@ -263,8 +255,6 @@
     <field type="BooleanField" name="is_image">True</field>
   </object>
   <object pk="5" model="orm.recipe">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">z image recipe</field>
     <field type="CharField" name="version">1.3</field>
@@ -280,8 +270,6 @@
     <field type="BooleanField" name="is_image">True</field>
   </object>
   <object pk="6" model="orm.recipe">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">z custom recipe</field>
     <field type="CharField" name="version"></field>
@@ -307,34 +295,23 @@
   </object>
 
   <object pk="1" model="orm.machine">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">1</field>
     <field type="CharField" name="name">a machine</field>
     <field type="CharField" name="description">a machine</field>
   </object>
   <object pk="2" model="orm.machine">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">2</field>
     <field type="CharField" name="name">z machine</field>
     <field type="CharField" name="description">z machine</field>
   </object>
   <object pk="3" model="orm.machine">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field to="orm.layer_version" name="layer_version" rel="ManyToOneRel">1</field>
     <field type="CharField" name="name">g machine</field>
     <field type="CharField" name="description">g machine</field>
   </object>
-  <object pk="1" model="orm.layersource">
-    <field type="CharField" name="name">local</field>
-    <field type="IntegerField" name="sourcetype">1</field>
-    <field type="CharField" name="apiurl"></field>
-  </object>
   <object pk="1" model="orm.bitbakeversion">
     <field type="CharField" name="name">test bbv</field>
     <field type="CharField" name="giturl">/tmp/</field>
@@ -355,26 +332,16 @@
     <field type="CharField" name="branch_name">master</field>
     <field type="TextField" name="helptext"><None></None></field>
   </object>
-  <object pk="1" model="orm.releaselayersourcepriority">
-    <field to="orm.release" name="release" rel="ManyToOneRel">1</field>
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="priority">0</field>
-  </object>
   <object pk="1" model="orm.branch">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
     <field type="CharField" name="name">master</field>
     <field type="CharField" name="short_description"></field>
   </object>
   <object pk="1" model="orm.layer">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel"><None></None></field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">a layer</field>
     <field type="CharField" name="vcs_url">/tmp/</field>
   </object>
   <object pk="2" model="orm.layer">
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">z layer</field>
     <field type="CharField" name="layer_index_url"></field>
@@ -383,8 +350,6 @@
   <object pk="1" model="orm.layer_version">
     <field to="orm.build" name="build" rel="ManyToOneRel">1</field>
     <field to="orm.layer" name="layer" rel="ManyToOneRel">1</field>
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field to="orm.branch" name="up_branch" rel="ManyToOneRel">1</field>
     <field type="CharField" name="branch">master</field>
@@ -397,8 +362,6 @@
   <object pk="2" model="orm.layer_version">
     <field to="orm.build" name="build" rel="ManyToOneRel"><None></None></field>
     <field to="orm.layer" name="layer" rel="ManyToOneRel">2</field>
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field to="orm.branch" name="up_branch" rel="ManyToOneRel">1</field>
     <field type="CharField" name="branch">testing-branch</field>
@@ -411,8 +374,6 @@
   <object pk="3" model="orm.layer_version">
     <field to="orm.build" name="build" rel="ManyToOneRel">1</field>
     <field to="orm.layer" name="layer" rel="ManyToOneRel">2</field>
-    <field to="orm.layersource" name="layer_source" rel="ManyToOneRel">1</field>
-    <field type="IntegerField" name="up_id"><None></None></field>
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field to="orm.branch" name="up_branch" rel="ManyToOneRel">1</field>
     <field type="CharField" name="branch">testing-branch</field>
diff --git a/bitbake/lib/toaster/toastergui/tests.py b/bitbake/lib/toaster/toastergui/tests.py
index da530a1..03b73a9 100644
--- a/bitbake/lib/toaster/toastergui/tests.py
+++ b/bitbake/lib/toaster/toastergui/tests.py
@@ -28,7 +28,7 @@ from django.utils import timezone
 from django.db.models import Q
 
 from orm.models import Project, Release, BitbakeVersion, Package, LogMessage
-from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Build
+from orm.models import LayerSource, Layer, Build
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
 from orm.models import CustomImageRecipe, ProjectVariable
 from orm.models import Branch, CustomImagePackage
@@ -149,7 +149,6 @@ class ViewTests(TestCase):
 
     def test_xhr_import_layer(self):
         """Test xhr_importlayer API"""
-        LayerSource.objects.create(sourcetype=LayerSource.TYPE_IMPORTED)
         #Test for importing an already existing layer
         args = {'vcs_url' : "git://git.example.com/test",
                 'name' : "base-layer",
-- 
2.7.4


