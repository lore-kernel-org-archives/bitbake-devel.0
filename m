Return-Path: <elliot.smith@intel.com>
Received: from antelope.tulip.relay.mailchannels.net
	(antelope.tulip.relay.mailchannels.net [23.83.218.4])
	by mail.openembedded.org (Postfix) with ESMTP id B5D507317E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 11:00:48 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BED69224C6;
	Wed,  6 Jul 2016 11:00:45 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-11-165.us-west-2.compute.internal [10.229.11.165])
	by relay.mailchannels.net (Postfix) with ESMTPA id 4B4E82244D;
	Wed,  6 Jul 2016 11:00:45 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.21.150.52])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 11:00:45 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467802845662:1303763086
X-MC-Ingress-Time: 1467802845662
Received: from [176.251.41.101] (port=50296 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKkc5-00073u-To; Wed, 06 Jul 2016 07:03:30 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 12:00:34 +0100
Message-Id: <b25653674856c1cf738b98ff41e9bb87339c9419.1467802608.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
References: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467802608.git.elliot.smith@intel.com>
References: <cover.1467802608.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 6/7] eventreplay: rewrite the script
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
X-List-Received-Date: Wed, 06 Jul 2016 11:00:51 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Rewritten toaster-eventreplay to make code working as expected,
more compact and readable.

[YOCTO #9585]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster-eventreplay | 207 +++++++++++++++++++-----------------------------
 1 file changed, 82 insertions(+), 125 deletions(-)

diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index 7de3967..80967a0 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -21,11 +21,13 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+"""
+This command takes a filename as a single parameter. The filename is read
+as a build eventlog, and the ToasterUI is used to process events in the file
+and log data in the database
+"""
 
-# This command takes a filename as a single parameter. The filename is read
-# as a build eventlog, and the ToasterUI is used to process events in the file
-# and log data in the database
-
+import os
 import sys
 import json
 import pickle
@@ -40,130 +42,85 @@ sys.path.insert(0, join(dirname(dirname(abspath(__file__))), 'lib'))
 import bb.cooker
 from bb.ui import toasterui
 
-class FileReadEventsServerConnection():
-    """  Emulates a connection to a bitbake server that feeds
-        events coming actually read from a saved log file.
-    """
-
-    class MockConnection():
-        """ fill-in for the proxy to the server. we just return generic data
+class EventPlayer:
+    """Emulate a connection to a bitbake server."""
+
+    def __init__(self, eventfile, variables):
+        self.eventfile = eventfile
+        self.variables = variables
+        self.eventmask = []
+
+    def waitEvent(self, _timeout):
+        """Read event from the file."""
+        line = self.eventfile.readline().strip()
+        if not line:
+            return
+        try:
+            event_str = json.loads(line)['vars'].encode('utf-8')
+            event = pickle.loads(codecs.decode(event_str, 'base64'))
+            event_name = "%s.%s" % (event.__module__, event.__class__.__name__)
+            if event_name not in self.eventmask:
+                return
+            return event
+        except ValueError as err:
+            print("Failed loading ", line)
+            raise err
+
+    def runCommand(self, command_line):
+        """Emulate running a command on the server."""
+        name = command_line[0]
+
+        if name == "getVariable":
+            var_name = command_line[1]
+            variable = self.variables.get(var_name)
+            if variable:
+                return variable['v'], None
+            return None, "Missing variable %s" % var_name
+
+        elif name == "getAllKeysWithFlags":
+            dump = {}
+            flaglist = command_line[1]
+            for key, val in self.variables.items():
+                try:
+                    if not key.startswith("__"):
+                        dump[key] = {
+                            'v': val['v'],
+                            'history' : val['history'],
+                        }
+                        for flag in flaglist:
+                            dump[key][flag] = val[flag]
+                except Exception as err:
+                    print(err)
+            return (dump, None)
+
+        elif name == 'setEventMask':
+            self.eventmask = command_line[-1]
+            return True, None
+
+        else:
+            raise Exception("Command %s not implemented" % command_line[0])
+
+    def getEventHandle(self):
         """
-        def __init__(self, sc):
-            self._sc = sc
-            self.eventmask = []
-
-        def runCommand(self, commandArray):
-            """ emulates running a command on the server; only read-only commands are accepted """
-            command_name = commandArray[0]
-
-            if command_name == "getVariable":
-                if commandArray[1] in self._sc._variables:
-                    return (self._sc._variables[commandArray[1]]['v'], None)
-                return (None, "Missing variable")
-
-            elif command_name == "getAllKeysWithFlags":
-                dump = {}
-                flaglist = commandArray[1]
-                for k in self._sc._variables.keys():
-                    try:
-                        if not k.startswith("__"):
-                            v = self._sc._variables[k]['v']
-                            dump[k] = {
-                                'v' : v ,
-                                'history' : self._sc._variables[k]['history'],
-                            }
-                            for d in flaglist:
-                                dump[k][d] = self._sc._variables[k][d]
-                    except Exception as e:
-                        print(e)
-                return (dump, None)
-
-            elif command_name == 'setEventMask':
-                self.eventmask = commandArray[-1]
-                return True, None
-
-            else:
-                raise Exception("Command %s not implemented" % commandArray[0])
-
-        def terminateServer(self):
-            """ do not do anything """
-            pass
-
-        def getEventHandle(self):
-            pass
-
-
-    class EventReader():
-        def __init__(self, sc):
-            self._sc = sc
-            self.firstraise = 0
-
-        def _create_event(self, line):
-            def _import_class(name):
-                assert len(name) > 0
-                assert "." in name, name
-
-                components = name.strip().split(".")
-                modulename = ".".join(components[:-1])
-                moduleklass = components[-1]
-
-                module = __import__(modulename, fromlist=[str(moduleklass)])
-                return getattr(module, moduleklass)
-
-            # we build a toaster event out of current event log line
-            try:
-                event_data = json.loads(line.strip())
-                event_class = _import_class(event_data['class'])
-                event_str = event_data['vars'].encode('utf-8')
-                event_object = pickle.loads(codecs.decode(event_str, 'base64'))
-            except ValueError as e:
-                print("Failed loading ", line)
-                raise e
-
-            if not isinstance(event_object, event_class):
-                raise Exception("Error loading objects %s class %s ", event_object, event_class)
-
-            return event_object
-
-        def waitEvent(self, timeout):
-
-            nextline = self._sc._eventfile.readline()
-            if len(nextline) == 0:
-                # the build data ended, while toasterui still waits for events.
-                # this happens when the server was abruptly stopped, so we simulate this
-                self.firstraise += 1
-                if self.firstraise == 1:
-                    raise KeyboardInterrupt()
-                else:
-                    return None
-            else:
-                self._sc.lineno += 1
-            return self._create_event(nextline)
-
-
-    def _readVariables(self, variableline):
-        self._variables = json.loads(variableline.strip())['allvariables']
-
-
-    def __init__(self, file_name):
-        self.connection = FileReadEventsServerConnection.MockConnection(self)
-        self._eventfile = open(file_name, "r")
-
-        # we expect to have the variable dump at the start of the file
-        self.lineno = 1
-        self._readVariables(self._eventfile.readline())
-
-        self.events = FileReadEventsServerConnection.EventReader(self)
+        This method is called by toasterui.
+        The return value is passed to self.runCommand but not used there.
+        """
+        pass
+
+def main(argv):
+    with open(argv[-1]) as eventfile:
+        # load variables from the first line
+        variables = json.loads(eventfile.readline().strip())['allvariables']
+
+        params = namedtuple('ConfigParams', ['observe_only'])(True)
+        player = EventPlayer(eventfile, variables)
+
+        return toasterui.main(player, player, params)
 
 # run toaster ui on our mock bitbake class
 if __name__ == "__main__":
-    if len(sys.argv) < 2:
-        print("Usage: %s event.log " % sys.argv[0])
+    if len(sys.argv) != 2:
+        print("Usage: %s <event file>" % os.path.basename(sys.argv[0]))
         sys.exit(1)
 
-    file_name = sys.argv[-1]
-    mock_connection = FileReadEventsServerConnection(file_name)
-    configParams = namedtuple('ConfigParams', ['observe_only'])(True)
-
-    # run the main program and set exit code to the returned value
-    sys.exit(toasterui.main(mock_connection.connection, mock_connection.events, configParams))
+    sys.exit(main(sys.argv))
-- 
2.7.4


