Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id BD74B76A7A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:16 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so113362035wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=QAPgBvMbnHZSgiAE6TZe7hobSz4LpXgfVBKBNcup/Oc=;
	b=fyD5cBFTl75QwexT2M57t/HLQ+0lHEVGJ1CS4bcf9Ra9oCAVwx8JX0mR5rxLxrIiYA
	6N04AHVM1h12Wpf1DOCVwNbIXLV4oQ09oDovBkCH73+l77NexFyqWmwqd4Tol66iggDv
	SQJUcrH6TFicH0rKjbJ3yRTHLDC+bTbv2eex1lNM3Z+S7b7NY1LwvqgqGJBAFUEuJH5i
	mKMKD3pbIJ8rpSxvsPmNPVKHLHdcFcVxx/YZP2ATh1TkeoDzH0BNTx+NWwSuw/TPh1Hd
	1Gh9bQWM0LKsASHfBjvOVc4DvNDbUCkLWUvdMHjDAyMNSckBffPlIppjAVNwrJkdx2UD
	wBTw==
X-Gm-Message-State: ALoCoQmRpQ41lKGoWUZjyqIpp4kKAozLsyHaCRqmORqw/eKYNeuRlAghD8QLhvxxY8sdgHzTntb3
X-Received: by 10.194.58.130 with SMTP id r2mr15039375wjq.72.1439915356791;
	Tue, 18 Aug 2015 09:29:16 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:16 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:58 +0100
Message-Id: <6327c2465f573e6332219c62c1a9b3d8323cfb50.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 12/14] bitbake: toaster logger: fix pylint issues
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes pylint issues in the toaster build data logger,
toasterui. The following types of warnings are touched here:

* fixing imports
* unused variables are set to _
* logger calls now use lazy evaluation instead of formatting
the string
* correct whitespace identation
* removes unneeded "pass" statements, and extra parantheses
* disable specific pylint warnings when decideing to override
them

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 130 +++++++++++++++++++++++--------------------
 lib/bb/ui/toasterui.py       |  57 +++++++++----------
 2 files changed, 98 insertions(+), 89 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index cce6da5..09e8853 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -19,12 +19,20 @@
 import sys
 import bb
 import re
-import ast
+import os
 
 os.environ["DJANGO_SETTINGS_MODULE"] = "toaster.toastermain.settings"
 
+
 from django.utils import timezone
-import toaster.toastermain.settings as toaster_django_settings
+
+
+def _configure_toaster():
+    """ Add toaster to sys path for importing modules
+    """
+    sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'toaster'))
+_configure_toaster()
+
 from toaster.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
 from toaster.orm.models import Target_Image_File, BuildArtifact
 from toaster.orm.models import Variable, VariableHistory
@@ -33,14 +41,17 @@ from toaster.orm.models import Task_Dependency, Package_Dependency
 from toaster.orm.models import Recipe_Dependency
 
 from toaster.orm.models import Project
+from bldcontrol.models import BuildEnvironment, BuildRequest
 
-from bb.msg import BBLogFormatter as format
+from bb.msg import BBLogFormatter as formatter
 from django.db import models
 from pprint import pformat
 import logging
 
 from django.db import transaction, connection
 
+# pylint: disable=invalid-name
+# the logger name is standard throughout BitBake
 logger = logging.getLogger("ToasterLogger")
 
 
@@ -57,7 +68,6 @@ class ORMWrapper(object):
         self.layer_version_objects = []
         self.task_objects = {}
         self.recipe_objects = {}
-        pass
 
     @staticmethod
     def _build_key(**kwargs):
@@ -106,6 +116,13 @@ class ORMWrapper(object):
 
         return vars(self)[dictname][key]
 
+    # pylint: disable=no-self-use
+    # we disable detection of no self use in functions because the methods actually work on the object
+    # even if they don't touch self anywhere
+
+    # pylint: disable=bad-continuation
+    # we do not follow the python conventions for continuation indentation due to long lines here
+
     def create_build_object(self, build_info, brbe, project_id):
         assert 'machine' in build_info
         assert 'distro' in build_info
@@ -119,8 +136,7 @@ class ORMWrapper(object):
         buildrequest = None
         if brbe is not None:            # this build was triggered by a request from a user
             logger.debug(1, "buildinfohelper: brbe is %s" % brbe)
-            from bldcontrol.models import BuildEnvironment, BuildRequest
-            br, be = brbe.split(":")
+            br, _ = brbe.split(":")
             buildrequest = BuildRequest.objects.get(pk = br)
             prj = buildrequest.project
 
@@ -129,18 +145,16 @@ class ORMWrapper(object):
             prj = Project.objects.get(pk = project_id)
 
         else:                           # this build was triggered by a legacy system, or command line interactive mode
-            prj, created = Project.objects.get_or_create(pk=0, name="Default Project")
+            prj, _ = Project.objects.get_or_create(pk=0, name="Default Project")
             logger.debug(1, "buildinfohelper: project is not specified, defaulting to %s" % prj)
 
 
         if buildrequest is not None:
             build = buildrequest.build
-            logger.info("Updating existing build, with %s" % build_info)
+            logger.info("Updating existing build, with %s", build_info)
             build.machine=build_info['machine']
             build.distro=build_info['distro']
             build.distro_version=build_info['distro_version']
-            started_on=build_info['started_on']
-            completed_on=build_info['started_on']
             build.cooker_log_path=build_info['cooker_log_path']
             build.build_name=build_info['build_name']
             build.bitbake_version=build_info['bitbake_version']
@@ -210,8 +224,8 @@ class ORMWrapper(object):
                         task_name=task_information['task_name']
                         )
         if created and must_exist:
-                task_information['debug'] = "build id %d, recipe id %d" % (task_information['build'].pk, task_information['recipe'].pk)
-                raise NotExisting("Task object created when expected to exist", task_information)
+            task_information['debug'] = "build id %d, recipe id %d" % (task_information['build'].pk, task_information['recipe'].pk)
+            raise NotExisting("Task object created when expected to exist", task_information)
 
         object_changed = False
         for v in vars(task_object):
@@ -278,7 +292,7 @@ class ORMWrapper(object):
         assert 'priority' in layer_version_information
         assert 'local_path' in layer_version_information
 
-        layer_version_object, created = Layer_Version.objects.get_or_create(
+        layer_version_object, _ = Layer_Version.objects.get_or_create(
                                     build = build_obj,
                                     layer = layer_obj,
                                     branch = layer_version_information['branch'],
@@ -296,13 +310,12 @@ class ORMWrapper(object):
         assert 'layer_index_url' in layer_information
 
         if brbe is None:
-            layer_object, created = Layer.objects.get_or_create(
+            layer_object, _ = Layer.objects.get_or_create(
                                 name=layer_information['name'],
                                 layer_index_url=layer_information['layer_index_url'])
             return layer_object
         else:
             # we are under managed mode; we must match the layer used in the Project Layer
-            from bldcontrol.models import BuildEnvironment, BuildRequest
             br_id, be_id = brbe.split(":")
 
             # find layer by checkout path;
@@ -422,7 +435,7 @@ class ORMWrapper(object):
 
             try:
                 filetarget_obj = Target_File.objects.get(target = target_obj, path = filetarget_path)
-            except Exception as e:
+            except Target_File.DoesNotExist:
                 # we might have an invalid link; no way to detect this. just set it to None
                 filetarget_obj = None
 
@@ -498,11 +511,11 @@ class ORMWrapper(object):
         if len(packagedeps_objs) > 0:
             Package_Dependency.objects.bulk_create(packagedeps_objs)
 
-        if (len(errormsg) > 0):
-            logger.warn("buildinfohelper: target_package_info could not identify recipes: \n%s" % errormsg)
+        if len(errormsg) > 0:
+            logger.warn("buildinfohelper: target_package_info could not identify recipes: \n%s", errormsg)
 
     def save_target_image_file_information(self, target_obj, file_name, file_size):
-        target_image_file = Target_Image_File.objects.create( target = target_obj,
+        Target_Image_File.objects.create( target = target_obj,
                             file_name = file_name,
                             file_size = file_size)
 
@@ -542,7 +555,7 @@ class ORMWrapper(object):
         if 'OPKGN' in package_info.keys():
             pname = package_info['OPKGN']
 
-        bp_object, created = Package.objects.get_or_create( build = build_obj,
+        bp_object, _ = Package.objects.get_or_create( build = build_obj,
                                        name = pname )
 
         bp_object.installed_name = package_info['PKG']
@@ -559,7 +572,7 @@ class ORMWrapper(object):
         # save any attached file information
         packagefile_objects = []
         for path in package_info['FILES_INFO']:
-                packagefile_objects.append(Package_File( package = bp_object,
+            packagefile_objects.append(Package_File( package = bp_object,
                                         path = path,
                                         size = package_info['FILES_INFO'][path] ))
         if len(packagefile_objects):
@@ -643,7 +656,19 @@ class ORMWrapper(object):
 
         HelpText.objects.bulk_create(helptext_objects)
 
-class MockEvent: pass           # sometimes we mock an event, declare it here
+
+class MockEvent(object):
+    """ This object is used to create event, for which normal event-processing methods can
+        be used, out of data that is not coming via an actual event
+    """
+    def __init__(self):
+        self.msg = None
+        self.levelno = None
+        self.taskname = None
+        self.taskhash = None
+        self.pathname = None
+        self.lineno = None
+
 
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
@@ -652,9 +677,12 @@ class BuildInfoHelper(object):
         Keeps in memory all data that needs matching before writing it to the database
     """
 
+    # pylint: disable=protected-access
+    # the code will look into the protected variables of the event; no easy way around this
+    # pylint: disable=bad-continuation
+    # we do not follow the python conventions for continuation indentation due to long lines here
 
     def __init__(self, server, has_build_history = False):
-        self._configure_django()
         self.internal_state = {}
         self.internal_state['taskdata'] = {}
         self.task_order = 0
@@ -671,10 +699,6 @@ class BuildInfoHelper(object):
         logger.debug(1, "buildinfohelper: Build info helper inited %s" % vars(self))
 
 
-    def _configure_django(self):
-        # Add toaster to sys path for importing modules
-        sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'toaster'))
-
     ###################
     ## methods to convert event/external info into objects that the ORM layer uses
 
@@ -727,7 +751,6 @@ class BuildInfoHelper(object):
         else:
             br_id, be_id = self.brbe.split(":")
             from bldcontrol.bbcontroller import getBuildEnvironmentController
-            from bldcontrol.models import BuildRequest
             bc = getBuildEnvironmentController(pk = be_id)
 
             def _slkey_managed(layer_version):
@@ -747,11 +770,11 @@ class BuildInfoHelper(object):
                             return lvo
 
         #if we get here, we didn't read layers correctly; dump whatever information we have on the error log
-        logger.warn("Could not match layer version for recipe path %s : %s" % (path, self.orm_wrapper.layer_version_objects))
+        logger.warn("Could not match layer version for recipe path %s : %s", path, self.orm_wrapper.layer_version_objects)
 
         #mockup the new layer
-        unknown_layer, created = Layer.objects.get_or_create(name="__FIXME__unidentified_layer", layer_index_url="")
-        unknown_layer_version_obj, created = Layer_Version.objects.get_or_create(layer = unknown_layer, build = self.internal_state['build'])
+        unknown_layer, _ = Layer.objects.get_or_create(name="__FIXME__unidentified_layer", layer_index_url="")
+        unknown_layer_version_obj, _ = Layer_Version.objects.get_or_create(layer = unknown_layer, build = self.internal_state['build'])
 
         # append it so we don't run into this error again and again
         self.orm_wrapper.layer_version_objects.append(unknown_layer_version_obj)
@@ -798,13 +821,6 @@ class BuildInfoHelper(object):
 
         return build_stats_path
 
-    def _remove_redundant(self, string):
-        ret = []
-        for i in string.split():
-            if i not in ret:
-                ret.append(i)
-        return " ".join(sorted(ret))
-
 
     ################################
     ## external available methods to store information
@@ -827,7 +843,7 @@ class BuildInfoHelper(object):
                 self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)] = layerinfos[layer]['version']
                 self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)]['local_path'] = layerinfos[layer]['local_path']
             except NotExisting as nee:
-                logger.warn("buildinfohelper: cannot identify layer exception:%s " % nee)
+                logger.warn("buildinfohelper: cannot identify layer exception:%s ", nee)
 
 
     def store_started_build(self, event):
@@ -861,8 +877,7 @@ class BuildInfoHelper(object):
         path_prefixes = []
 
         if self.brbe is not None:
-            br_id, be_id = self.brbe.split(":")
-            from bldcontrol.models import BuildEnvironment, BuildRequest
+            _, be_id = self.brbe.split(":")
             be = BuildEnvironment.objects.get(pk = be_id)
             path_prefixes.append(be.builddir)
 
@@ -887,7 +902,6 @@ class BuildInfoHelper(object):
 
 
     def update_target_image_file(self, event):
-        image_fstypes = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
         evdata = BuildInfoHelper._get_data_from_event(event)
 
         for t in self.internal_state['targets']:
@@ -949,7 +963,7 @@ class BuildInfoHelper(object):
             self.task_order += 1
             task_information['order'] = self.task_order
 
-        task_obj = self.orm_wrapper.get_update_task_object(task_information)
+        self.orm_wrapper.get_update_task_object(task_information)
 
         self.internal_state['taskdata'][identifier] = {
                         'outcome': task_information['outcome'],
@@ -970,7 +984,7 @@ class BuildInfoHelper(object):
                             file_path__endswith = recipe_information['file_path'],
                             name = recipename)
             except Recipe.DoesNotExist:
-                logger.error("Could not find recipe for recipe_information %s name %s" % (pformat(recipe_information), recipename))
+                logger.error("Could not find recipe for recipe_information %s name %s" , pformat(recipe_information), recipename)
                 raise
 
             task_information = {}
@@ -981,7 +995,7 @@ class BuildInfoHelper(object):
             task_information['disk_io'] = taskstats['disk_io']
             if 'elapsed_time' in taskstats:
                 task_information['elapsed_time'] = taskstats['elapsed_time']
-            task_obj = self.orm_wrapper.get_update_task_object(task_information, True)  # must exist
+            self.orm_wrapper.get_update_task_object(task_information, True)  # must exist
 
     def update_and_store_task(self, event):
         assert 'taskfile' in vars(event)
@@ -1047,7 +1061,7 @@ class BuildInfoHelper(object):
     def store_missed_state_tasks(self, event):
         for (fn, taskname, taskhash, sstatefile) in BuildInfoHelper._get_data_from_event(event)['missed']:
 
-            identifier = fn + taskname + "_setscene"
+            # identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
             mevent = MockEvent()
@@ -1065,7 +1079,7 @@ class BuildInfoHelper(object):
 
         for (fn, taskname, taskhash, sstatefile) in BuildInfoHelper._get_data_from_event(event)['found']:
 
-            identifier = fn + taskname + "_setscene"
+            # identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
             mevent = MockEvent()
@@ -1105,7 +1119,7 @@ class BuildInfoHelper(object):
         # save layer version priorities
         if 'layer-priorities' in event._depgraph.keys():
             for lv in event._depgraph['layer-priorities']:
-                (name, path, regexp, priority) = lv
+                (_, path, _, priority) = lv
                 layer_version_obj = self._get_layer_version_for_path(path[1:]) # paths start with a ^
                 assert layer_version_obj is not None
                 layer_version_obj.priority = priority
@@ -1218,8 +1232,8 @@ class BuildInfoHelper(object):
                 taskdeps_objects.append(Task_Dependency( task = target, depends_on = dep ))
         Task_Dependency.objects.bulk_create(taskdeps_objects)
 
-        if (len(errormsg) > 0):
-            logger.warn("buildinfohelper: dependency info not identify recipes: \n%s" % errormsg)
+        if len(errormsg) > 0:
+            logger.warn("buildinfohelper: dependency info not identify recipes: \n%s", errormsg)
 
 
     def store_build_package_information(self, event):
@@ -1232,7 +1246,6 @@ class BuildInfoHelper(object):
     def _store_build_done(self, errorcode):
         logger.info("Build exited with errorcode %d", errorcode)
         br_id, be_id = self.brbe.split(":")
-        from bldcontrol.models import BuildEnvironment, BuildRequest
         be = BuildEnvironment.objects.get(pk = be_id)
         be.lock = BuildEnvironment.LOCK_LOCK
         be.save()
@@ -1247,7 +1260,7 @@ class BuildInfoHelper(object):
 
     def store_log_error(self, text):
         mockevent = MockEvent()
-        mockevent.levelno = format.ERROR
+        mockevent.levelno = formatter.ERROR
         mockevent.msg = text
         mockevent.pathname = '-- None'
         mockevent.lineno = LogMessage.ERROR
@@ -1263,7 +1276,7 @@ class BuildInfoHelper(object):
 
 
     def store_log_event(self, event):
-        if event.levelno < format.WARNING:
+        if event.levelno < formatter.WARNING:
             return
 
         if 'args' in vars(event):
@@ -1276,8 +1289,7 @@ class BuildInfoHelper(object):
                 self.internal_state['backlog'].append(event)
                 return
             else:   # we're under Toaster control, the build is already created
-                from bldcontrol.models import BuildRequest, BRError
-                br, be = self.brbe.split(":")
+                br, _ = self.brbe.split(":")
                 buildrequest = BuildRequest.objects.get(pk = br)
                 self.internal_state['build'] = buildrequest.build
 
@@ -1293,9 +1305,9 @@ class BuildInfoHelper(object):
 
         log_information = {}
         log_information['build'] = self.internal_state['build']
-        if event.levelno == format.ERROR:
+        if event.levelno == formatter.ERROR:
             log_information['level'] = LogMessage.ERROR
-        elif event.levelno == format.WARNING:
+        elif event.levelno == formatter.WARNING:
             log_information['level'] = LogMessage.WARNING
         elif event.levelno == -2:   # toaster self-logging
             log_information['level'] = -2
@@ -1305,7 +1317,7 @@ class BuildInfoHelper(object):
         log_information['message'] = event.msg
         log_information['pathname'] = event.pathname
         log_information['lineno'] = event.lineno
-        logger.info("Logging error 2: %s" % log_information)
+        logger.info("Logging error 2: %s", log_information)
         self.orm_wrapper.create_logmessage(log_information)
 
     def close(self, errorcode):
@@ -1320,7 +1332,7 @@ class BuildInfoHelper(object):
             else:
                 # we have no build, and we still have events; something amazingly wrong happend
                 for event in self.internal_state['backlog']:
-                   logger.error("UNSAVED log: %s", event.msg)
+                    logger.error("UNSAVED log: %s", event.msg)
 
         if not connection.features.autocommits_when_autocommit_is_off:
             transaction.set_autocommit(True)
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 767bfab..9c7e87d 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -31,16 +31,12 @@ from bb.ui import uihelper
 from bb.ui.buildinfohelper import BuildInfoHelper
 
 import bb.msg
-import copy
-import fcntl
 import logging
 import os
-import progressbar
-import signal
-import struct
-import sys
-import time
-import xmlrpclib
+
+# pylint: disable=invalid-name
+# module properties for UI modules are read by bitbake and the contract should not be broken
+
 
 featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES, bb.cooker.CookerFeatures.SEND_DEPENDS_TREE, bb.cooker.CookerFeatures.BASEDATASTORE_TRACKING, bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
 
@@ -53,15 +49,15 @@ def _log_settings_from_server(server):
     # Get values of variables which control our output
     includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     if error:
-        logger.error("Unable to get the value of BBINCLUDELOGS variable: %s" % error)
+        logger.error("Unable to get the value of BBINCLUDELOGS variable: %s", error)
         raise BaseException(error)
     loglines, error = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
     if error:
-        logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
+        logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s", error)
         raise BaseException(error)
     consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
     if error:
-        logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
+        logger.error("Unable to get the value of BB_CONSOLELOG variable: %s", error)
         raise BaseException(error)
     return includelogs, loglines, consolelogfile
 
@@ -71,17 +67,17 @@ def main(server, eventHandler, params ):
 
     console = logging.StreamHandler(sys.stdout)
     format_str = "%(levelname)s: %(message)s"
-    format = bb.msg.BBLogFormatter(format_str)
+    formatter = bb.msg.BBLogFormatter(format_str)
     bb.msg.addDefaultlogFilter(console)
-    console.setFormatter(format)
+    console.setFormatter(formatter)
     logger.addHandler(console)
     logger.setLevel(logging.INFO)
 
-    includelogs, loglines, consolelogfile = _log_settings_from_server(server)
+    _, _, consolelogfile = _log_settings_from_server(server)
 
     # verify and warn
     build_history_enabled = True
-    inheritlist, error = server.runCommand(["getVariable", "INHERIT"])
+    inheritlist, _ = server.runCommand(["getVariable", "INHERIT"])
 
     if not "buildhistory" in inheritlist.split(" "):
         logger.warn("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
@@ -126,12 +122,15 @@ def main(server, eventHandler, params ):
 
             helper.eventHandler(event)
 
+            # pylint: disable=protected-access
+            # the code will look into the protected variables of the event; no easy way around this
+
             if isinstance(event, bb.event.BuildStarted):
                 buildinfohelper.store_started_build(event)
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
-                logger.warn("Logfile for task %s" % event.logfile)
+                logger.warn("Logfile for task %s", event.logfile)
                 continue
 
             if isinstance(event, bb.build.TaskBase):
@@ -143,17 +142,17 @@ def main(server, eventHandler, params ):
 
             if isinstance(event, logging.LogRecord):
                 if event.levelno == -1:
-                    event.levelno = format.ERROR
+                    event.levelno = formatter.ERROR
 
                 buildinfohelper.store_log_event(event)
-                if event.levelno >= format.ERROR:
+                if event.levelno >= formatter.ERROR:
                     errors = errors + 1
-                elif event.levelno == format.WARNING:
+                elif event.levelno == formatter.WARNING:
                     warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to
                 # include verbose/debug messages
-                if event.taskpid != 0 and event.levelno <= format.NOTE:
+                if event.taskpid != 0 and event.levelno <= formatter.NOTE:
                     continue
 
                 logger.handle(event)
@@ -241,8 +240,8 @@ def main(server, eventHandler, params ):
 
             if isinstance(event, (bb.event.BuildCompleted, bb.command.CommandFailed)):
 
-		errorcode = 0
-                if (isinstance(event, bb.command.CommandFailed)):
+                errorcode = 0
+                if isinstance(event, bb.command.CommandFailed):
                     errors += 1
                     errorcode = 1
                     logger.error("Command execution failed: %s", event.error)
@@ -251,7 +250,7 @@ def main(server, eventHandler, params ):
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 buildinfohelper.close(errorcode)
                 # mark the log output; controllers may kill the toasterUI after seeing this log
-                logger.info("ToasterUI build done 1, brbe: %s" % buildinfohelper.brbe )
+                logger.info("ToasterUI build done 1, brbe: %s", buildinfohelper.brbe )
 
                 # we start a new build info
                 if buildinfohelper.brbe is not None:
@@ -293,7 +292,7 @@ def main(server, eventHandler, params ):
                 elif event.type == "LicenseManifestPath":
                     buildinfohelper.store_license_manifest_path(event)
                 else:
-                    logger.error("Unprocessed MetadataEvent %s " % str(event))
+                    logger.error("Unprocessed MetadataEvent %s ", str(event))
                 continue
 
             if isinstance(event, bb.cooker.CookerExit):
@@ -325,30 +324,28 @@ def main(server, eventHandler, params ):
                 pass
         except KeyboardInterrupt:
             main.shutdown = 1
-            pass
         except Exception as e:
             # print errors to log
             import traceback
             from pprint import pformat
             exception_data = traceback.format_exc()
-            logger.error("%s\n%s" % (e, exception_data))
+            logger.error("%s\n%s" , e, exception_data)
 
-            exc_type, exc_value, tb = sys.exc_info()
+            _, _, tb = sys.exc_info()
             if tb is not None:
                 curr = tb
                 while curr is not None:
-                    logger.warn("Error data dump %s\n%s\n" % (traceback.format_tb(curr,1), pformat(curr.tb_frame.f_locals)))
+                    logger.warn("Error data dump %s\n%s\n" , traceback.format_tb(curr,1), pformat(curr.tb_frame.f_locals))
                     curr = curr.tb_next
 
             # save them to database, if possible; if it fails, we already logged to console.
             try:
                 buildinfohelper.store_log_exception("%s\n%s" % (str(e), exception_data))
             except Exception as ce:
-                logger.error("CRITICAL - Failed to to save toaster exception to the database: %s" % str(ce))
+                logger.error("CRITICAL - Failed to to save toaster exception to the database: %s", str(ce))
 
             # make sure we return with an error
             return_value += 1
-            pass
 
     if interrupted:
         if return_value == 0:
-- 
2.1.4


