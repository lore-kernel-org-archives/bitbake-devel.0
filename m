Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <xiaotongx.lv@intel.com>) id 1SfLQD-0000Sq-Gq
	for bitbake-devel@lists.openembedded.org;
	Fri, 15 Jun 2012 03:33:57 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 14 Jun 2012 18:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="153460880"
Received: from lxt.sh.intel.com ([10.239.47.66])
	by orsmga001.jf.intel.com with ESMTP; 14 Jun 2012 18:23:17 -0700
From: Xiaotong lv <xiaotongx.lv@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jun 2012 21:23:30 -0400
Message-Id: <303a74c28fb34b1f0d40005a7bd197ea061c4e49.1339809365.git.xiaotongx.lv@intel.com>
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <cover.1339809365.git.xiaotongx.lv@intel.com>
References: <cover.1339809365.git.xiaotongx.lv@intel.com>
Subject: [PATCH 1/1] Webhob: webservice client
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
X-List-Received-Date: Fri, 15 Jun 2012 01:33:57 -0000

A webservice client wrapper class.

Signed-off-by: Xiaotong Lv <xiaotongx.lv@intel.com>
---
 .../bb/ui/webservice_client/client_webservice.py   |   63 ++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/webservice_client/client_webservice.py

diff --git a/bitbake/lib/bb/ui/webservice_client/client_webservice.py b/bitbake/lib/bb/ui/webservice_client/client_webservice.py
new file mode 100644
index 0000000..e70ce36
--- /dev/null
+++ b/bitbake/lib/bb/ui/webservice_client/client_webservice.py
@@ -0,0 +1,63 @@
+import sys
+import traceback
+try:
+    from suds.client import Client, WebFault
+except ImportError as e:
+    sys.exit('Error:Install suds python lib firstly\n%s' % str(e))
+try:
+    import simplejson as json
+except ImportError:
+    import json
+
+class Connection:
+    def __init__(self, wsUrl, cache=None):
+        self.wsUrl = wsUrl
+        self.cache = cache
+        try:
+            self.client = Client(wsUrl, cache=self.cache)
+        except Exception, e:
+            sys.exit(str(e))
+
+    def runCommand(self, command):
+        if not isinstance(command, list) or not command:
+            raise ValueError('command must be list type, and be not empty')
+        params = {}
+        param_type = []
+        params['function'] = command.pop(0)
+        for i in command:
+            if isinstance(i, list):
+                param_type.append(('list'," ".join(i)))
+            elif isinstance(i, bool):
+                param_type.append(('bool',bool(i)))
+            elif isinstance(i, str):
+                param_type.append(('string',str(i)))
+
+        if param_type:
+            params['param_type'] = {'string':[type for type, param in param_type]}
+            params['params'] = {'string':[param for type, param in param_type]}
+
+        try:
+            return self.client.service.runCommand(params)
+        except WebFault, f:
+            print f.fault
+        except Exception, e:
+            print e
+            traceback.print_exc()
+
+    def getEvent(self):
+        try:
+            event = self.client.service.getEvent()
+            if isinstance(event, unicode):
+                event = event.encode('utf-8')
+            o_event = json.loads(event)
+            return o_event['events']
+        except WebFault, f:
+            print f.fault
+        except Exception, e:
+            print e
+            traceback.print_exc()
+
+#only testing
+if __name__ == '__main__':
+    server = Connection('http://localhost:8888/?wsdl')
+    print server.runCommand(['getVariable', 'BBLAYERS'])
-- 
1.7.4.4



