Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 1ED7060071
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 15:32:35 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GFkaUt018348; Mon, 16 Sep 2013 16:46:36 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vT8DMuQ6hc2I; Mon, 16 Sep 2013 16:46:36 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GFkVjQ018340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 16:46:32 +0100
Message-ID: <1379345534.32201.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 16:32:14 +0100
In-Reply-To: <ac5fe2cb5237f54c439328ac7b33f2b23b07c8ea.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
	<ac5fe2cb5237f54c439328ac7b33f2b23b07c8ea.1379338189.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/7] bitbake: event: send the task dependency tree to UI
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
X-List-Received-Date: Mon, 16 Sep 2013 15:32:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 14:33 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> We add an event that will send the dependency tree
> graph to the UI client once it is computed.
> 
> This will allow the clients to display dependency
> data in an efficient manner, and not redo the runqueue
> computation specifically to get the dependency data.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/cooker.py    | 3 +++
>  bitbake/lib/bb/runqueue.py  | 3 +++
>  bitbake/lib/bb/ui/knotty.py | 3 +++
>  3 files changed, 9 insertions(+)

I continue to feel quite strongly that this should only happen when
there are UIs connected that actually want this event. We actually have
two problems, this one and the part in bin/bitbake which says:

    # Collect all the caches we need
    if configParams.server_only:
        configuration.extra_caches = gather_extra_cache_data()
    else:
        configuration.extra_caches = getattr(ui_module, "extraCaches", [])

I was never happy when this went in and I've already had one complaint
about the memory resident bitbake server reparsing compared to the
normal knotty client. You asked how this could be fixed as you couldn't
see how it could be done. I have two ideas:

The first is simpler but only fixes this problem, not the caches one.
The basic idea there would be to query the event interface and see if
anyone was listening for DepTreeGenerated events. If nobody is, no point
in generating it.

The second idea was having "server features", the caches being a special
case of this. When UI clients connect, they would merge their features
into those of the server. I've shown some pseudo code below. The
"features" could take immediate effect, the caches requested would take
effect the next time the server reparses (i.e finish current command,
then they take effect). The server features would be sent to the server
via some special command which would be allowed in an otherwise readonly
server.

Does that help?

Cheers,

Richard



--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -327,6 +327,10 @@ def main():
             os.environ[k] = cleanedvars[k]
 
         try:
+            if configParams.remote_server:
+                # Request configuration.extra_caches
+                # Request server feature flags set in UI
+
             return ui_module.main(server_connection.connection, server_connection.events, configParams)
         finally:
             bb.event.ui_queue = []
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2c8d4dc..89bf7c6 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -63,6 +63,20 @@ class CollectionError(bb.BBHandledException):
 class state:
     initial, parsing, running, shutdown, forceshutdown, stopped = range(6)
 
+#
+# Cooker Features control certain functionality in the server. This allows
+# things to happen only when we know we have a UI that needs the particular
+# feature. This is usually used to control event generation
+#
+class CookerFeatures(object):
+    def __init__(self):
+        self._features = ["generateRunQueueDepTreeEvents"]
+        for f in self._features:
+            setattr(self, f, False)
+    def merge(self, features):
+        for f in self._features:
+            v = getattr(features, f)
+            setattr(self, f, v)
 
 class SkippedPackage:
     def __init__(self, info = None, reason = None):






