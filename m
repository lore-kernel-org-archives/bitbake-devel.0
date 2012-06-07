Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <xiaotongx.lv@intel.com>) id 1Sc5Ys-0007W5-5h
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 04:01:26 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 05 Jun 2012 18:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="153456482"
Received: from lxt.sh.intel.com ([10.239.47.147])
	by orsmga002.jf.intel.com with ESMTP; 05 Jun 2012 18:50:57 -0700
From: Xiaotong lv <xiaotongx.lv@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jun 2012 21:51:14 -0400
Message-Id: <cbe94009a060bc680bf196732642e295151b8ef9.1339033548.git.xiaotongx.lv@intel.com>
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <cover.1339033548.git.xiaotongx.lv@intel.com>
References: <cover.1339033548.git.xiaotongx.lv@intel.com>
Subject: [PATCH 1/1] Webhob: a general helper interface based on webservice
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 06 Jun 2012 02:01:26 -0000

using command: 'bitbake -u webhob_webservice' to start webservice helper.
defining 2 methods of webservice , they are runCommand(param) and getEvent(),
then different languages can use webservice client to remote call them.
runCommand(params) method to send command to bitbake server.
params format is:
    {
        'function':string
        'param_type':array(string)
        'params':array(string)
    }
getEvent() method handles bitbake object event then returns a general json format data.

Signed-off-by: Xiaotong Lv <xiaotongx.lv@intel.com>
---
 bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py |  190 ++++++++++++++++++++
 bitbake/lib/bb/ui/webhob_webservice.py             |  141 +++++++++++++++
 2 files changed, 331 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py
 create mode 100755 bitbake/lib/bb/ui/webhob_webservice.py

diff --git a/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py b/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py
new file mode 100644
index 0000000..eaa8729
--- /dev/null
+++ b/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py
@@ -0,0 +1,190 @@
+#!/usr/bin/env python
+#
+# Copyright (C) 2011        Intel Corporation
+#
+# Authored by Lv Xiaotong <xiaotongx.lv@intel.com>
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
+import logging
+
+class WSEventHandler:
+    def __init__ (self):
+        self.ret_value = {}
+
+    def clear_ret_value(self):
+        if self.ret_value:
+            self.ret_value = {}
+
+    #To convert the list in recipe and packages tree model into string type.
+    #so that the tree model can be converted into standard json data
+    def treemodel_list_tostring(self, data):
+        for k, v in data.iteritems():
+            if isinstance(v, dict):
+                data[k] = self.treemodel_list_tostring(v)
+            elif isinstance(v, list):
+                data[k] = ' '.join(v)
+            else:
+                data[k] = v
+        return data
+
+    def handle_event(self, event):
+        if not event:
+            return
+
+        self.clear_ret_value()
+
+        if isinstance(event, bb.event.PackageInfo):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["pkginfolist"] = self.treemodel_list_tostring(event._pkginfolist)
+        elif isinstance(event, bb.event.SanityCheckPassed):
+            self.ret_value["event"] = bb.event.getName(event)
+
+        #Handler these logs, do we need to do some logging filtering under logging.INFO level.
+        #cause maybe some loggings are unuseful but this can affect the webservice efficiency.
+        #and client user experience
+        elif isinstance(event, logging.LogRecord):
+                self.ret_value["event"] = bb.event.getName(event)
+                self.ret_value["msg"] = event.msg
+                self.ret_value["getMessage"] = event.getMessage()
+                self.ret_value["logging_error"] = logging.ERROR
+                self.ret_value["logging_warning"] = logging.WARNING
+                self.ret_value["levelno"] = event.levelno
+
+        elif isinstance(event, bb.event.TargetsTreeGenerated):
+            self.ret_value["event"] = bb.event.getName(event)
+            if event._model:
+                self.ret_value["model"] = self.treemodel_list_tostring(event._model)
+
+        elif isinstance(event, bb.event.ConfigFilesFound):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["variable"] = event._variable
+            self.ret_value["values"] = ' '.join(event._values)
+
+        elif isinstance(event, bb.event.ConfigFilePathFound):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["path"] = event._path
+
+        elif isinstance(event, bb.event.FilesMatchingFound):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["pattern"] = event._pattern
+            self.ret_value["matches"] = ' '.join(event._matches)
+
+        elif isinstance(event, bb.command.CommandCompleted):
+            self.ret_value["event"] = bb.event.getName(event)
+
+        elif isinstance(event, bb.command.CommandFailed):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["exitcode"] = event.exitcode
+            self.ret_value["error"] = event.error
+
+        elif isinstance(event, (bb.event.ParseStarted,
+                                bb.event.CacheLoadStarted,
+                                bb.event.TreeDataPreparationStarted)
+                        ):
+            self.ret_value["event"] = bb.event.getName(event)
+            if self.ret_value["event"] != 'TreeDataPreparationStarted':
+                self.ret_value["total"] = event.total
+
+        elif isinstance(event, (bb.event.ParseProgress,
+                                bb.event.CacheLoadProgress,
+                                bb.event.TreeDataPreparationProgress)
+                        ):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["current"] = event.current
+            self.ret_value["total"] = event.total
+            self.ret_value["msg"] = event.msg
+
+        elif isinstance(event, (bb.event.ParseCompleted,
+                                bb.event.CacheLoadCompleted,
+                                bb.event.TreeDataPreparationCompleted)
+                        ):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["total"] = event.total
+            self.ret_value["msg"] = event.msg
+
+        elif isinstance(event, bb.event.NoProvider):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["dependees"] = ' '.join(event._dependees)
+            self.ret_value["reasons"] = ' '.join(event._reasons)
+            self.ret_value["runtime"] = event._runtime
+            self.ret_value["item"] = event._item
+
+        elif isinstance(event, bb.event.MultipleProviders):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["candidates"] = ' '.join(event._candidates)
+            self.ret_value["runtime"] = event._runtime
+            self.ret_value["item"] = event._item
+
+        elif isinstance(event, bb.event.BuildStarted):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["name"] = event._name
+            self.ret_value["msg"] = event.msg
+            self.ret_value["failures"] = event._failures
+            self.ret_value["pkgs"] = ' '.join(event._pkgs)
+            self.ret_value["pid"] = event.pid
+
+        elif isinstance(event, bb.event.BuildCompleted):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["name"] = event._name
+            self.ret_value["msg"] = event.msg
+            self.ret_value["failures"] = event._failures
+            self.ret_value["total"] = event.total
+            self.ret_value["pkgs"] = ' '.join(event._pkgs)
+            self.ret_value["pid"] = event.pid
+
+        elif isinstance(event, (bb.build.TaskBase,
+                                bb.build.TaskStarted,
+                                bb.build.TaskSucceeded)
+                        ):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["task"] = event._task
+            self.ret_value["message"] = event._message
+            self.ret_value["package"] = event._package
+            self.ret_value["pid"] = event.pid
+
+        if isinstance(event, bb.build.TaskFailed):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["logfile"] = event.logfile
+            self.ret_value["errprinted"] = event.errprinted
+
+        elif isinstance(event, (bb.runqueue.runQueueTaskStarted,
+                                bb.runqueue.sceneQueueTaskStarted)
+                        ):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["noexec"] = event.noexec
+            self.ret_value["taskstring"] = event.taskstring
+            self.ret_value["taskid"] = event.taskid
+            self.ret_value["stats"] = {'completed':event.stats.completed,
+                                       'active':event.stats.active,
+                                       'failed':event.stats.failed
+                                       }
+            self.ret_value["pid"] = event.pid
+
+        elif isinstance(event, bb.runqueue.runQueueTaskCompleted):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["taskstring"] = event.taskstring
+            self.ret_value["pid"] = event.pid
+            self.ret_value["taskid"] = event.taskid
+
+        elif isinstance(event, (bb.runqueue.runQueueTaskFailed,
+                                bb.runqueue.sceneQueueTaskFailed)
+                        ):
+            self.ret_value["event"] = bb.event.getName(event)
+            self.ret_value["taskid"] = event.taskid
+            self.ret_value["exitcode"] = event.exitcode
+            self.ret_value["taskstring"] = event.taskstring
+            self.ret_value["pid"] = event.pid
+
+        return self.ret_value
diff --git a/bitbake/lib/bb/ui/webhob_webservice.py b/bitbake/lib/bb/ui/webhob_webservice.py
new file mode 100755
index 0000000..1dd474a
--- /dev/null
+++ b/bitbake/lib/bb/ui/webhob_webservice.py
@@ -0,0 +1,141 @@
+#!/usr/bin/env python
+#
+# Copyright (C) 2011        Intel Corporation
+#
+# Authored by Lv Xiaotong <xiaotongx.lv@intel.com>
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
+import sys
+import os
+import re
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
+
+try:
+    import bb
+except RuntimeError as exc:
+    sys.exit(str(exc))
+
+try:
+    from soaplib.wsgi import Application
+    from soaplib.service import rpc
+    from soaplib.service import DefinitionBase
+    from soaplib.serializers.primitive import String, Integer
+    from soaplib.serializers.clazz import ClassSerializer, Array
+except ImportError as e:
+    sys.exit('Error:%s \nInstall soaplib 1.0 firstly.\nsoaplib:repo @https://github.com/soaplib/soaplib/tree/1_0' % str(e))
+
+try:
+    import simplejson as json
+except ImportError:
+    import json
+
+from bb.ui.crumbs.webserviceeventhandler import WSEventHandler
+
+extraCaches = ['bb.cache_extra:HobRecipeInfo']
+
+class Param(ClassSerializer):
+    '''
+    this class defined a Webservice params structure for runCommand() method.
+    If a client to call runCommand() method, the following is param format:
+    param = {
+        'function'   = 'string'
+        'param_type' = ['string','list','bool']
+        'params'     = ['str','str1 str2 str3...','true or false']
+    }
+    '''
+
+    __namespace__ = "param"
+    function = String
+    param_type = Array(String)
+    params = Array(String)
+
+class WebServiceWrap(DefinitionBase):
+    server = None
+    eventHandler = None
+
+    @rpc(Param, _returns=String)
+    def runCommand(self, param):
+        command = []
+        function = param.function
+        param_type = param.param_type
+        params = param.params
+
+        if function:
+            command.append(function)
+        else:
+            return "Error: key(function) value cannot be required."
+
+        if param_type and params:
+            if len(param_type) == len(params):
+                for item in param_type:
+                    if item == 'string':
+                        command.append(params.pop(0))
+                    elif item == 'bool':
+                        command.append(bool(params.pop(0)))
+                    elif item == 'list':
+                       command.append(params.pop(0).split())
+                    else:
+                       return "Error: only 'string', 'bool', 'list' should be in param_type"
+            else:
+                return "Error: key(param_type) value length should be equal to params"
+
+        ret = WebServiceWrap.server.runCommand(command)
+        return json.dumps(ret)
+
+    @rpc(_returns=String)
+    def getEvent(self):
+        event_queue = []
+        eventobj = WebServiceWrap.eventHandler.getEvent()
+        handler = WSEventHandler()
+        while eventobj:
+            event = handler.handle_event(eventobj)
+            if event:
+                event_queue.append(event)
+            eventobj = WebServiceWrap.eventHandler.getEvent()
+        ret = event_queue if event_queue else None
+        return json.dumps({'events':ret})
+
+def main (server = None, eventHandler = None):
+    WebServiceWrap.server = server
+    WebServiceWrap.eventHandler = eventHandler
+
+    host = ''
+    port = 0
+    for i in sys.argv[1:]:
+        pattern = r'(\d+.\d+.\d+.\d+):(\d+)'
+        match = re.match(pattern, i)
+        if match:
+            host = match.group(1)
+            port = int(match.group(2))
+            break
+    if not host and not port:
+            sys.exit('Fatal: using bitbake -u webhob_webservice ip:port\n')
+
+    try:
+        from wsgiref.simple_server import make_server
+        server = make_server(host, port, Application([WebServiceWrap], 'tns'))
+        print "Webservice UI runnning... \nWSDL is at: http://%s:%s/?wsdl" % (host, port)
+        server.serve_forever()
+    except ImportError:
+        print "Fatal: webservice server code requires Python >= 2.5"
+
+if __name__ == "__main__":
+    try:
+        ret = main()
+    except Exception:
+        ret = 1
+        import traceback
+        traceback.print_exc(15)
+    sys.exit(ret)
-- 
1.7.4.4



