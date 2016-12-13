Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1EAED71B5F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:45 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961468"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:44 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:07 +1300
Message-Id: <67194147bd3666778544bd14437bc689feb40a2f.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 08/15] remotedata: enable transporting datastore from the client to the server
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:45 -0000

For the purposes of server-side parsing and expansion allowing for
client-side use of the datastore, we need a means of sending a datastore
from the client back to the server, where the datastore probably
consists of a remote (server-side) original plus some client-side
modifications. To do this we need to take care of a couple of things:

1) xmlrpc can't handle nested dicts, so if you enable memres and simply
   try passing a serialised datastore then things break. Instead of
   serialising the entire datastore, just take the naive option of
   transferring the internal dict alone (as a list of tuples) for now.

2) Change the TinfoilDataStoreConnector object into simply the handle
   (number) when transmitting; it gets substituted with the real
   datastore when the server receives it.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/remotedata.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/bb/remotedata.py b/lib/bb/remotedata.py
index 932ee43..68ecffc 100644
--- a/lib/bb/remotedata.py
+++ b/lib/bb/remotedata.py
@@ -72,3 +72,45 @@ class RemoteDatastores:
         if idx in self.locked:
             raise Exception('Tried to release locked datastore %d' % idx)
         del self.datastores[idx]
+
+    def receive_datastore(self, remote_data):
+        """Receive a datastore object sent from the client (as prepared by transmit_datastore())"""
+        dct = dict(remote_data)
+        d = bb.data_smart.DataSmart()
+        d.dict = dct
+        while True:
+            if '_remote_data' in dct:
+                dsindex = dct['_remote_data']['_content']
+                del dct['_remote_data']
+                if dsindex is None:
+                    dct['_data'] = self.cooker.data.dict
+                else:
+                    dct['_data'] = self.datastores[dsindex].dict
+                break
+            elif '_data' in dct:
+                idct = dict(dct['_data'])
+                dct['_data'] = idct
+                dct = idct
+            else:
+                break
+        return d
+
+    @staticmethod
+    def transmit_datastore(d):
+        """Prepare a datastore object for sending over IPC from the client end"""
+        # FIXME content might be a dict, need to turn that into a list as well
+        def copy_dicts(dct):
+            if '_remote_data' in dct:
+                dsindex = dct['_remote_data']['_content'].dsindex
+                newdct = dct.copy()
+                newdct['_remote_data'] = {'_content': dsindex}
+                return list(newdct.items())
+            elif '_data' in dct:
+                newdct = dct.copy()
+                newdata = copy_dicts(dct['_data'])
+                if newdata:
+                    newdct['_data'] = newdata
+                return list(newdct.items())
+            return None
+        main_dict = copy_dicts(d.dict)
+        return main_dict
-- 
2.5.5


