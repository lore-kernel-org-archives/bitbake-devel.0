Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 3758C724AF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:21 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id r20so4248265wiv.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=zyV7UpRyNiYmrU6eTQM3DVP9jEzpaooggNS+4pyJzTk=;
	b=Thz3Fxgdlv34m2wMmW90PiVdZ5CW17M2NltD1wp9LSn+pZ8DNBIO77fJzFe3prV/KO
	K7EnTHqxyoj3OEGwEppWv0/z/j4Q/l3PsD0fPFTLnJROCJJLRKFkX8HrbANSS1HXt+Jd
	tzPXX/u2w1XeA6xp3zoqjb2p3r1H3Ch75EjPzmRJw3v1DAfX+hfp8wAkK5Z58LsDEY0f
	aTyl3fw07NMP4PZd/RVU78zdP5ZhQNg8WfJYXUe1ltepKwYnF5cbyX/eopKpZqOmtAj1
	DJOty/Zad6Fi2fe56Owm4wD3DT2bduLmlyzU1ZnQJccrNIMemOV7qyD7bkCqR5eUz1aB
	aLCQ==
X-Gm-Message-State: ALoCoQn8k1KE64wG9AKQjYiQnjPO6iLc2eujF8vGzGLP9aLiq+Ifj7ph2kYRwmaeTUZe2fCLCTqr
X-Received: by 10.194.94.132 with SMTP id dc4mr27135421wjb.56.1418384721836;
	Fri, 12 Dec 2014 03:45:21 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id w10sm1516094wje.10.2014.12.12.03.45.19
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:19 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 3626F565191; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:02 +0000
Message-Id: <1befb4a783bb7b7b387d4b5ee08830d9516f1ac2.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 03/18] add option to write offline event log file
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds a "-w/--write-log" option to bitbake
that writes an event log file for the current build.

The name of the file is passed as a parameter to the "-w"
argument. If the parameter is the empty string '', the file
name is generated in the form bitbake_eventlog_DATE.json,
where DATE is the current date and time, with second precision.

The "-w" option can also be supplied as the BBEVENTLOG
environment variable.

We add a script, toater-eventreplay, that reads an event
log file and loads the data into a Toaster database, creating
a build entry.

We modify the toasterui to fix minor issues with reading
events from an event log file.

Performance impact is undetectable under no-task executed builds.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake                  |  12 ++-
 bin/toaster-eventreplay      | 179 +++++++++++++++++++++++++++++++++++++++++++
 lib/bb/cooker.py             |  75 +++++++++++++++++-
 lib/bb/cookerdata.py         |   1 +
 lib/bb/ui/buildinfohelper.py |  53 +++++++++----
 lib/bb/ui/toasterui.py       |   2 +-
 6 files changed, 300 insertions(+), 22 deletions(-)
 create mode 100755 bin/toaster-eventreplay

diff --git a/bin/bitbake b/bin/bitbake
index 7f8449c..d46c3dd 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -196,6 +196,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("", "--status-only", help = "Check the status of the remote bitbake server.",
                    action = "store_true", dest = "status_only", default = False)
 
+        parser.add_option("-w", "--write-log", help = "Writes the event log of the build to a bitbake event json file. Use '' (empty string) to assign the name automatically.",
+                   action = "store", dest = "writeeventlog")
+
         options, targets = parser.parse_args(sys.argv)
 
         # some environmental variables set also configuration options
@@ -206,6 +209,14 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         if "BBTOKEN" in os.environ:
             options.xmlrpctoken = os.environ["BBTOKEN"]
 
+        if "BBEVENTLOG" is os.environ:
+            options.writeeventlog = os.environ["BBEVENTLOG"]
+
+        # fill in proper log name if not supplied
+        if options.writeeventlog is not None and len(options.writeeventlog) == 0:
+            import datetime
+            options.writeeventlog = "bitbake_eventlog_%s.json" % datetime.datetime.now().strftime("%Y%m%d%H%M%S")
+
         # if BBSERVER says to autodetect, let's do that
         if options.remote_server:
             [host, port] = options.remote_server.split(":", 2)
@@ -266,7 +277,6 @@ def start_server(servermodule, configParams, configuration, features):
     return server
 
 
-
 def main():
 
     configParams = BitBakeConfigParameters()
diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
new file mode 100755
index 0000000..624829a
--- /dev/null
+++ b/bin/toaster-eventreplay
@@ -0,0 +1,179 @@
+#!/usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Copyright (C) 2014        Alex Damian
+#
+# This file re-uses code spread throughout other Bitbake source files.
+# As such, all other copyrights belong to their own right holders.
+#
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+
+# This command takes a filename as a single parameter. The filename is read
+# as a build eventlog, and the ToasterUI is used to process events in the file
+# and log data in the database
+
+import os
+import sys, logging
+
+# mangle syspath to allow easy import of modules
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
+                                'lib'))
+
+
+import bb.cooker
+from bb.ui import toasterui
+import sys
+import logging
+
+logger = logging.getLogger(__name__)
+console = logging.StreamHandler(sys.stdout)
+format_str = "%(levelname)s: %(message)s"
+logging.basicConfig(format=format_str)
+
+
+import json, pickle
+
+
+class FileReadEventsServerConnection():
+    """  Emulates a connection to a bitbake server that feeds
+        events coming actually read from a saved log file.
+    """
+
+    class MockConnection():
+        """ fill-in for the proxy to the server. we just return generic data
+        """
+        def __init__(self, sc):
+            self._sc = sc
+
+        def runCommand(self, commandArray):
+            """ emulates running a command on the server; only read-only commands are accepted """
+            command_name = commandArray[0]
+
+            if command_name == "getVariable":
+                if commandArray[1] in self._sc._variables:
+                    return (self._sc._variables[commandArray[1]]['v'], None)
+                return (None, "Missing variable")
+
+            elif command_name == "getAllKeysWithFlags":
+                dump = {}
+                flaglist = commandArray[1]
+                for k in self._sc._variables.keys():
+                    try:
+                        if not k.startswith("__"):
+                            v = self._sc._variables[k]['v']
+                            dump[k] = {
+                                'v' : v ,
+                                'history' : self._sc._variables[k]['history'],
+                            }
+                            for d in flaglist:
+                                dump[k][d] = self._sc._variables[k][d]
+                    except Exception as e:
+                        print(e)
+                return (dump, None)
+            else:
+                raise Exception("Command %s not implemented" % commandArray[0])
+
+        def terminateServer(self):
+            """ do not do anything """
+            pass
+
+
+
+    class EventReader():
+        def __init__(self, sc):
+            self._sc = sc
+            self.firstraise = 0
+
+        def _create_event(self, line):
+            def _import_class(name):
+                assert len(name) > 0
+                assert "." in name, name
+
+                components = name.strip().split(".")
+                modulename = ".".join(components[:-1])
+                moduleklass = components[-1]
+
+                module = __import__(modulename, fromlist=[str(moduleklass)])
+                return getattr(module, moduleklass)
+
+            # we build a toaster event out of current event log line
+            try:
+                event_data = json.loads(line.strip())
+                event_class = _import_class(event_data['class'])
+                event_object = pickle.loads(json.loads(event_data['vars']))
+            except ValueError as e:
+                print("Failed loading ", line)
+                raise e
+
+            if not isinstance(event_object, event_class):
+                raise Exception("Error loading objects %s class %s ", event_object, event_class)
+
+            return event_object
+
+        def waitEvent(self, timeout):
+
+            nextline = self._sc._eventfile.readline()
+            if len(nextline) == 0:
+                # the build data ended, while toasterui still waits for events.
+                # this happens when the server was abruptly stopped, so we simulate this
+                self.firstraise += 1
+                if self.firstraise == 1:
+                    raise KeyboardInterrupt()
+                else:
+                    return None
+            else:
+                self._sc.lineno += 1
+            return self._create_event(nextline)
+
+
+    def _readVariables(self, variableline):
+        self._variables = json.loads(variableline.strip())['allvariables']
+
+
+    def __init__(self, file_name):
+        self.connection = FileReadEventsServerConnection.MockConnection(self)
+        self._eventfile = open(file_name, "r")
+
+        # we expect to have the variable dump at the start of the file
+        self.lineno = 1
+        self._readVariables(self._eventfile.readline())
+
+        self.events = FileReadEventsServerConnection.EventReader(self)
+
+
+
+
+
+class MockConfigParameters():
+    """ stand-in for cookerdata.ConfigParameters; as we don't really config a cooker, this
+        serves just to supply needed interfaces for the toaster ui to work """
+    def __init__(self):
+        self.observe_only = True            # we can only read files
+
+
+# run toaster ui on our mock bitbake class
+if __name__ == "__main__":
+    if len(sys.argv) < 2:
+        logger.error("Usage: %s event.log " % sys.argv[0])
+        sys.exit(1)
+
+    file_name = sys.argv[-1]
+    mock_connection = FileReadEventsServerConnection(file_name)
+    configParams = MockConfigParameters()
+
+    # run the main program
+    toasterui.main(mock_connection.connection, mock_connection.events, configParams)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index df9a0ca..16fd4ad 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -205,6 +205,75 @@ class BBCooker:
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
 
+
+        # we log all events to a file if so directed
+        if self.configuration.writeeventlog:
+            import json, pickle
+            DEFAULT_EVENTFILE = self.configuration.writeeventlog
+            class EventLogWriteHandler():
+
+                class EventWriter():
+                    def __init__(self, cooker):
+                        self.file_inited = None
+                        self.cooker = cooker
+                        self.event_queue = []
+
+                    def init_file(self):
+                        try:
+                            # delete the old log
+                            os.remove(DEFAULT_EVENTFILE)
+                        except:
+                            pass
+
+                        # write current configuration data
+                        with open(DEFAULT_EVENTFILE, "w") as f:
+                            f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
+
+                    def write_event(self, event):
+                        with open(DEFAULT_EVENTFILE, "a") as f:
+                            try:
+                                f.write("%s\n" % json.dumps({"class":event.__module__ + "." + event.__class__.__name__, "vars":json.dumps(pickle.dumps(event)) }))
+                            except Exception as e:
+                                import traceback
+                                print(e, traceback.format_exc(e))
+
+
+                    def send(self, event):
+                        event_class = event.__module__ + "." + event.__class__.__name__
+
+                        # init on bb.event.BuildStarted
+                        if self.file_inited is None:
+                            if  event_class == "bb.event.BuildStarted":
+                                self.init_file()
+                                self.file_inited = True
+
+                                # write pending events
+                                for e in self.event_queue:
+                                    self.write_event(e)
+
+                                # also write the current event
+                                self.write_event(event)
+
+                            else:
+                                # queue all events until the file is inited
+                                self.event_queue.append(event)
+
+                        else:
+                            # we have the file, just write the event
+                            self.write_event(event)
+
+                # set our handler's event processor
+                event = EventWriter(self)       # self is the cooker here
+
+
+            # set up cooker features for this mock UI handler
+
+            # we need to write the dependency tree in the log
+            self.featureset.setFeature(CookerFeatures.SEND_DEPENDS_TREE)
+            # register the log file writer as UI Handler
+            bb.event.register_UIHhandler(EventLogWriteHandler())
+
+
         #
         # Special updated configuration we use for firing events
         #
@@ -505,7 +574,7 @@ class BBCooker:
         taskdata, runlist, pkgs_to_build = self.buildTaskData(pkgs_to_build, task, False)
 
         return runlist, taskdata
-    
+
     ######## WARNING : this function requires cache_extra to be enabled ########
 
     def generateTaskDepTreeData(self, pkgs_to_build, task):
@@ -1550,10 +1619,10 @@ class CookerCollectFiles(object):
         for p in pkgfns:
             realfn, cls = bb.cache.Cache.virtualfn2realfn(p)
             priorities[p] = self.calc_bbfile_priority(realfn, matched)
- 
+
         # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
         unmatched = set()
-        for _, _, regex, pri in self.bbfile_config_priorities:        
+        for _, _, regex, pri in self.bbfile_config_priorities:
             if not regex in matched:
                 unmatched.add(regex)
 
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 470d538..2ceed2d 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -139,6 +139,7 @@ class CookerConfiguration(object):
         self.dry_run = False
         self.tracking = False
         self.interface = []
+        self.writeeventlog = False
 
         self.env = {}
 
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 533f4ce..f825b57 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -556,7 +556,6 @@ class ORMWrapper(object):
         assert isinstance(build_obj, Build)
 
         helptext_objects = []
-
         for k in vardump:
             desc = vardump[k]['doc']
             if desc is None:
@@ -667,9 +666,11 @@ class BuildInfoHelper(object):
             if (path.startswith(bl.layer.local_path)):
                 return bl
 
-        #TODO: if we get here, we didn't read layers correctly
-        assert False
-        return None
+        #if we get here, we didn't read layers correctly; mockup the new layer
+        unknown_layer, created = Layer.objects.get_or_create(name="unknown", local_path="/", layer_index_url="")
+        unknown_layer_version_obj, created = Layer_Version.objects.get_or_create(layer = unknown_layer, build = self.internal_state['build'])
+
+        return unknown_layer_version_obj
 
     def _get_recipe_information_from_taskfile(self, taskfile):
         localfilepath = taskfile.split(":")[-1]
@@ -732,7 +733,6 @@ class BuildInfoHelper(object):
 
     def store_started_build(self, event):
         assert '_pkgs' in vars(event)
-        assert 'lvs' in self.internal_state, "Layer version information not found; Check if the bitbake server was configured to inherit toaster.bbclass."
         build_information = self._get_build_information()
 
         build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe)
@@ -740,10 +740,13 @@ class BuildInfoHelper(object):
         self.internal_state['build'] = build_obj
 
         # save layer version information for this build
-        for layer_obj in self.internal_state['lvs']:
-            self.orm_wrapper.get_update_layer_version_object(build_obj, layer_obj, self.internal_state['lvs'][layer_obj])
+        if not 'lvs' in self.internal_state:
+            logger.error("Layer version information not found; Check if the bitbake server was configured to inherit toaster.bbclass.")
+        else:
+            for layer_obj in self.internal_state['lvs']:
+                self.orm_wrapper.get_update_layer_version_object(build_obj, layer_obj, self.internal_state['lvs'][layer_obj])
 
-        del self.internal_state['lvs']
+            del self.internal_state['lvs']
 
         # create target information
         target_information = {}
@@ -753,7 +756,8 @@ class BuildInfoHelper(object):
         self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
 
         # Save build configuration
-        self.orm_wrapper.save_build_variables(build_obj, self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0])
+        data = self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0]
+        self.orm_wrapper.save_build_variables(build_obj, [])
 
         return self.brbe
 
@@ -980,14 +984,29 @@ class BuildInfoHelper(object):
 
             recipe_info = {}
             recipe_info['name'] = pn
-            recipe_info['version'] = event._depgraph['pn'][pn]['version'].lstrip(":")
             recipe_info['layer_version'] = layer_version_obj
-            recipe_info['summary'] = event._depgraph['pn'][pn]['summary']
-            recipe_info['license'] = event._depgraph['pn'][pn]['license']
-            recipe_info['description'] = event._depgraph['pn'][pn]['description']
-            recipe_info['section'] = event._depgraph['pn'][pn]['section']
-            recipe_info['homepage'] = event._depgraph['pn'][pn]['homepage']
-            recipe_info['bugtracker'] = event._depgraph['pn'][pn]['bugtracker']
+
+            if 'version' in event._depgraph['pn'][pn]:
+                recipe_info['version'] = event._depgraph['pn'][pn]['version'].lstrip(":")
+
+            if 'summary' in event._depgraph['pn'][pn]:
+                recipe_info['summary'] = event._depgraph['pn'][pn]['summary']
+
+            if 'license' in event._depgraph['pn'][pn]:
+                recipe_info['license'] = event._depgraph['pn'][pn]['license']
+
+            if 'description' in event._depgraph['pn'][pn]:
+                recipe_info['description'] = event._depgraph['pn'][pn]['description']
+
+            if 'section' in event._depgraph['pn'][pn]:
+                recipe_info['section'] = event._depgraph['pn'][pn]['section']
+
+            if 'homepage' in event._depgraph['pn'][pn]:
+                recipe_info['homepage'] = event._depgraph['pn'][pn]['homepage']
+
+            if 'bugtracker' in event._depgraph['pn'][pn]:
+                recipe_info['bugtracker'] = event._depgraph['pn'][pn]['bugtracker']
+
             recipe_info['file_path'] = file_name
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
             recipe.is_image = False
@@ -1146,4 +1165,4 @@ class BuildInfoHelper(object):
 
         if 'backlog' in self.internal_state:
             for event in self.internal_state['backlog']:
-                   print "NOTE: Unsaved log: ", event.msg
+                   logger.error("Unsaved log: %s", event.msg)
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 7a316be..a85ad5a 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -309,7 +309,7 @@ def main(server, eventHandler, params ):
             try:
                 buildinfohelper.store_log_exception("%s\n%s" % (str(e), exception_data))
             except Exception as ce:
-                print("CRITICAL: failed to to save toaster exception to the database: %s" % str(ce))
+                logger.error("CRITICAL - Failed to to save toaster exception to the database: %s" % str(ce))
 
             pass
 
-- 
1.9.1


