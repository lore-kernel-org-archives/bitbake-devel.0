Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 1804678258
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:51 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410428"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:09 +0200
Message-Id: <dfa7d5ffb89fc428bcd81ff5ce09f13c25ecc52d.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 10/12] tinfoil: add more doc comments
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:51 -0000

We want this API to be easier to use, so add missing function
documentation to help with that.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 7209cc9..5d1d7f8 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -55,6 +55,7 @@ class TinfoilCommandFailed(Exception):
     """Exception raised when run_command fails"""
 
 class TinfoilDataStoreConnector:
+    """Connector object used to enable access to datastore objects via tinfoil"""
 
     def __init__(self, tinfoil, dsindex):
         self.tinfoil = tinfoil
@@ -294,8 +295,25 @@ class TinfoilRecipeInfo:
 
 
 class Tinfoil:
+    """
+    Tinfoil - an API for scripts and utilities to query
+    BitBake internals and perform build operations.
+    """
 
     def __init__(self, output=sys.stdout, tracking=False, setup_logging=True):
+        """
+        Create a new tinfoil object.
+        Parameters:
+            output: specifies where console output should be sent. Defaults
+                    to sys.stdout.
+            tracking: True to enable variable history tracking, False to
+                    disable it (default). Enabling this has a minor
+                    performance impact so typically it isn't enabled
+                    unless you need to query variable history.
+            setup_logging: True to setup a logger so that things like
+                    bb.warn() will work immediately and timeout warnings
+                    are visible; False to let BitBake do this itself.
+        """
         self.logger = logging.getLogger('BitBake')
         self.config_data = None
         self.cooker = None
@@ -316,6 +334,37 @@ class Tinfoil:
         self.shutdown()
 
     def prepare(self, config_only=False, config_params=None, quiet=0, extra_features=None):
+        """
+        Prepares the underlying BitBake system to be used via tinfoil.
+        This function must be called prior to calling any of the other
+        functions in the API.
+        NOTE: if you call prepare() you must absolutely call shutdown()
+        before your code terminates. You can use a "with" block to ensure
+        this happens e.g.
+
+            with bb.tinfoil.Tinfoil() as tinfoil:
+                tinfoil.prepare()
+                ...
+
+        Parameters:
+            config_only: True to read only the configuration and not load
+                        the cache / parse recipes. This is useful if you just
+                        want to query the value of a variable at the global
+                        level or you want to do anything else that doesn't
+                        involve knowing anything about the recipes in the
+                        current configuration. False loads the cache / parses
+                        recipes.
+            config_params: optionally specify your own configuration
+                        parameters. If not specified an instance of
+                        TinfoilConfigParameters will be created internally.
+            quiet:      quiet level controlling console output - equivalent
+                        to bitbake's -q/--quiet option. Default of 0 gives
+                        the same output level as normal bitbake execution.
+            extra_features: extra features to be added to the feature
+                        set requested from the server. See
+                        CookerFeatures._feature_list for possible
+                        features.
+        """
         self.quiet = quiet
 
         if self.tracking:
@@ -440,9 +489,16 @@ class Tinfoil:
         return self.server_connection.events.waitEvent(timeout)
 
     def get_overlayed_recipes(self):
+        """
+        Find recipes which are overlayed (i.e. where recipes exist in multiple layers)
+        """
         return defaultdict(list, self.run_command('getOverlayedRecipes'))
 
     def get_skipped_recipes(self):
+        """
+        Find recipes which were skipped (i.e. SkipRecipe was raised
+        during parsing).
+        """
         return OrderedDict(self.run_command('getSkippedRecipes'))
 
     def get_all_providers(self):
@@ -475,6 +531,9 @@ class Tinfoil:
         return best[3]
 
     def get_file_appends(self, fn):
+        """
+        Find the bbappends for a recipe file
+        """
         return self.run_command('getFileAppends', fn)
 
     def all_recipes(self, mc='', sort=True):
@@ -739,6 +798,12 @@ class Tinfoil:
             return ret
 
     def shutdown(self):
+        """
+        Shut down tinfoil. Disconnects from the server and gracefully
+        releases any associated resources. You must call this function if
+        prepare() has been called, or use a with... block when you create
+        the tinfoil object which will ensure that it gets called.
+        """
         if self.server_connection:
             self.run_command('clientComplete')
             _server_connections.remove(self.server_connection)
-- 
2.9.4


