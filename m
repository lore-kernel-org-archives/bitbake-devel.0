Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <xiaotongx.lv@intel.com>) id 1Sbqhl-00044P-SI
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 12:09:38 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 05 Jun 2012 02:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="153059780"
Received: from lxt.sh.intel.com ([10.239.47.78])
	by orsmga002.jf.intel.com with ESMTP; 05 Jun 2012 02:58:05 -0700
From: Xiaotong lv <xiaotongx.lv@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jun 2012 05:58:26 -0400
Message-Id: <a37743c622fceab340dd090228f978074d85239d.1338969711.git.xiaotongx.lv@intel.com>
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <cover.1338969711.git.xiaotongx.lv@intel.com>
References: <cover.1338969711.git.xiaotongx.lv@intel.com>
Subject: [PATCH 1/1] Webhob: Clean up the code and modify some errors
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
X-List-Received-Date: Tue, 05 Jun 2012 10:09:38 -0000

Signed-off-by: Xiaotong Lv <xiaotongx.lv@intel.com>
---
 bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py |   20 ++++---
 bitbake/lib/bb/ui/webhob_webservice.py             |   53 ++++++++-----------
 2 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py b/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py
index dc6f316..eaa8729 100644
--- a/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py
@@ -27,12 +27,14 @@ class WSEventHandler:
         if self.ret_value:
             self.ret_value = {}
 
-    def event_model_to_jsondata(self, data):
+    #To convert the list in recipe and packages tree model into string type.
+    #so that the tree model can be converted into standard json data
+    def treemodel_list_tostring(self, data):
         for k, v in data.iteritems():
             if isinstance(v, dict):
-                data[k] = self.event_model_to_jsondata(v)
+                data[k] = self.treemodel_list_tostring(v)
             elif isinstance(v, list):
-                data[k] = " ".join(v)
+                data[k] = ' '.join(v)
             else:
                 data[k] = v
         return data
@@ -45,12 +47,12 @@ class WSEventHandler:
 
         if isinstance(event, bb.event.PackageInfo):
             self.ret_value["event"] = bb.event.getName(event)
-            self.ret_value["pkginfolist"] = self.event_model_to_jsondata(event._pkginfolist)
+            self.ret_value["pkginfolist"] = self.treemodel_list_tostring(event._pkginfolist)
         elif isinstance(event, bb.event.SanityCheckPassed):
             self.ret_value["event"] = bb.event.getName(event)
 
         #Handler these logs, do we need to do some logging filtering under logging.INFO level.
-        #cause maybe some logging are unuseful but this can affect the webservice efficiency 
+        #cause maybe some loggings are unuseful but this can affect the webservice efficiency.
         #and client user experience
         elif isinstance(event, logging.LogRecord):
                 self.ret_value["event"] = bb.event.getName(event)
@@ -63,7 +65,7 @@ class WSEventHandler:
         elif isinstance(event, bb.event.TargetsTreeGenerated):
             self.ret_value["event"] = bb.event.getName(event)
             if event._model:
-                self.ret_value["model"] = self.event_model_to_jsondata(event._model)
+                self.ret_value["model"] = self.treemodel_list_tostring(event._model)
 
         elif isinstance(event, bb.event.ConfigFilesFound):
             self.ret_value["event"] = bb.event.getName(event)
@@ -121,7 +123,7 @@ class WSEventHandler:
 
         elif isinstance(event, bb.event.MultipleProviders):
             self.ret_value["event"] = bb.event.getName(event)
-            self.ret_value["candidates"] = ", ".join(event._candidates)
+            self.ret_value["candidates"] = ' '.join(event._candidates)
             self.ret_value["runtime"] = event._runtime
             self.ret_value["item"] = event._item
 
@@ -166,7 +168,7 @@ class WSEventHandler:
             self.ret_value["taskid"] = event.taskid
             self.ret_value["stats"] = {'completed':event.stats.completed,
                                        'active':event.stats.active,
-                                       'active':event.stats.failed
+                                       'failed':event.stats.failed
                                        }
             self.ret_value["pid"] = event.pid
 
@@ -185,4 +187,4 @@ class WSEventHandler:
             self.ret_value["taskstring"] = event.taskstring
             self.ret_value["pid"] = event.pid
 
-        return self.ret_value
\ No newline at end of file
+        return self.ret_value
diff --git a/bitbake/lib/bb/ui/webhob_webservice.py b/bitbake/lib/bb/ui/webhob_webservice.py
index c4544e1..1dd474a 100755
--- a/bitbake/lib/bb/ui/webhob_webservice.py
+++ b/bitbake/lib/bb/ui/webhob_webservice.py
@@ -51,7 +51,6 @@ class Param(ClassSerializer):
     If a client to call runCommand() method, the following is param format:
     param = {
         'function'   = 'string'
-        'param_num'  = 'int'
         'param_type' = ['string','list','bool']
         'params'     = ['str','str1 str2 str3...','true or false']
     }
@@ -59,7 +58,6 @@ class Param(ClassSerializer):
 
     __namespace__ = "param"
     function = String
-    param_num = Integer
     param_type = Array(String)
     params = Array(String)
 
@@ -71,34 +69,27 @@ class WebServiceWrap(DefinitionBase):
     def runCommand(self, param):
         command = []
         function = param.function
-        param_num = param.param_num
         param_type = param.param_type
         params = param.params
 
-        if param_num>0:
-            if None in param.__dict__.values():
-               return "Fatal: function, param_num, param_type, params values cannot be None."
-
-            if len(params) != param_num and len(params) != param_num:
-                return "Fatal: param_type and params length should be equal to param_num"
-
+        if function:
             command.append(function)
-            for item in param_type:
-               if item == 'string':
-                   command.append(params.pop(0))
-               elif item == 'bool':
-                   command.append(bool(params.pop(0)))
-               elif item == 'list':
-                  command.append(params.pop(0).split())
-               else:
-                  command = []
-                  return "Fatal: only 'string', 'bool', 'list' should be in param_type"
-
-        if param_num == 0 and param.function:
-            command.append(function)
-
-        if not command:
-            return "Fatal: function, param_num values cannot be None."
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
 
         ret = WebServiceWrap.server.runCommand(command)
         return json.dumps(ret)
@@ -124,10 +115,10 @@ def main (server = None, eventHandler = None):
     port = 0
     for i in sys.argv[1:]:
         pattern = r'(\d+.\d+.\d+.\d+):(\d+)'
-        if re.match(pattern, i):
-            ip = i.split(':')
-            host = ip[0]
-            port = int(ip[1])
+        match = re.match(pattern, i)
+        if match:
+            host = match.group(1)
+            port = int(match.group(2))
             break
     if not host and not port:
             sys.exit('Fatal: using bitbake -u webhob_webservice ip:port\n')
@@ -135,7 +126,7 @@ def main (server = None, eventHandler = None):
     try:
         from wsgiref.simple_server import make_server
         server = make_server(host, port, Application([WebServiceWrap], 'tns'))
-        print "Webservice UI runnning \nWSDL is at: http://%s:%s/?wsdl" % (host, port)
+        print "Webservice UI runnning... \nWSDL is at: http://%s:%s/?wsdl" % (host, port)
         server.serve_forever()
     except ImportError:
         print "Fatal: webservice server code requires Python >= 2.5"
-- 
1.7.4.4



