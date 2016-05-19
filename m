Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 67A2865CBB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 May 2016 12:59:41 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 19 May 2016 05:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,334,1459839600"; d="scan'208";a="106841758"
Received: from gfois-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.121])
	by fmsmga004.fm.intel.com with ESMTP; 19 May 2016 05:59:42 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 May 2016 13:59:28 +0100
Message-Id: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 1/6] toaster: Remove DATABASE_URL being passed around as an environment var
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
X-List-Received-Date: Thu, 19 May 2016 12:59:42 -0000

From: Michael Wood <michael.g.wood@intel.com>

We don't need to pass the DATABASE_URL around and read it back if we
setup the django framework in the correct way.
We make the default sqlite database path a full path so that the
database isn't being assumed to be in CWD.

Also add some more useful comments on the database settings.

This is preparation work to migrate the build tests and be able to
trigger builds on differently configured databases.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/bin/toaster                                |  2 -
 bitbake/lib/bb/ui/buildinfohelper.py               | 20 +++----
 .../toastermain/management/commands/get-dburl.py   |  9 ---
 bitbake/lib/toaster/toastermain/settings.py        | 67 ++++------------------
 4 files changed, 20 insertions(+), 78 deletions(-)
 delete mode 100644 bitbake/lib/toaster/toastermain/management/commands/get-dburl.py

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 987d53c1..91716e6 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -100,7 +100,6 @@ stop_system()
     fi
     webserverKillAll
     # unset exported variables
-    unset DATABASE_URL
     unset TOASTER_CONF
     unset TOASTER_DIR
     unset BITBAKE_UI
@@ -278,7 +277,6 @@ case $CMD in
             return 4
         fi
         export BITBAKE_UI='toasterui'
-        export DATABASE_URL=`$MANAGE get-dburl`
         $MANAGE runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
         # set fail safe stop system on terminal exit
         trap stop_system SIGHUP
diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index c5368f6..cea53e0 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -21,19 +21,19 @@ import bb
 import re
 import os
 
-os.environ["DJANGO_SETTINGS_MODULE"] = "toaster.toastermain.settings"
-
-
 import django
 from django.utils import timezone
 
+import toaster
+# Add toaster module to the search path to help django.setup() find the right
+# modules
+sys.path.insert(0, os.path.dirname(toaster.__file__))
 
-def _configure_toaster():
-    """ Add toaster to sys path for importing modules
-    """
-    sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'toaster'))
-_configure_toaster()
-
+#Set the DJANGO_SETTINGS_MODULE if it's not already set
+os.environ["DJANGO_SETTINGS_MODULE"] =\
+    os.environ.get("DJANGO_SETTINGS_MODULE",
+                   "toaster.toastermain.settings")
+# Setup django framework (needs to be done before importing modules)
 django.setup()
 
 from orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
@@ -54,11 +54,11 @@ from datetime import datetime, timedelta
 
 from django.db import transaction, connection
 
+
 # pylint: disable=invalid-name
 # the logger name is standard throughout BitBake
 logger = logging.getLogger("ToasterLogger")
 
-
 class NotExisting(Exception):
     pass
 
diff --git a/bitbake/lib/toaster/toastermain/management/commands/get-dburl.py b/bitbake/lib/toaster/toastermain/management/commands/get-dburl.py
deleted file mode 100644
index 911296f..0000000
--- a/bitbake/lib/toaster/toastermain/management/commands/get-dburl.py
+++ /dev/null
@@ -1,9 +0,0 @@
-from toastermain.settings import getDATABASE_URL
-from django.core.management.base import NoArgsCommand
-
-class Command(NoArgsCommand):
-    args    = ""
-    help    = "get database url"
-
-    def handle_noargs(self,**options):
-        print(getDATABASE_URL())
diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/toaster/toastermain/settings.py
index 8662f39..adcf707 100644
--- a/bitbake/lib/toaster/toastermain/settings.py
+++ b/bitbake/lib/toaster/toastermain/settings.py
@@ -21,7 +21,7 @@
 
 # Django settings for Toaster project.
 
-import os, re
+import os
 
 DEBUG = True
 TEMPLATE_DEBUG = DEBUG
@@ -38,14 +38,19 @@ ADMINS = (
 
 MANAGERS = ADMINS
 
+TOASTER_SQLITE_DEFAULT_DIR = os.path.join(os.environ.get('TOASTER_DIR', ''),
+                                          'build')
+
 DATABASES = {
     'default': {
-        'ENGINE': 'django.db.backends.sqlite3', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
-        'NAME': 'toaster.sqlite',                      # Or path to database file if using sqlite3.
+        # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
+        'ENGINE': 'django.db.backends.sqlite3',
+        # DB name or full path to database file if using sqlite3.
+        'NAME': "%s/toaster.sqlite" % TOASTER_SQLITE_DEFAULT_DIR,
         'USER': '',
         'PASSWORD': '',
-        'HOST': '127.0.0.1',                      # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
-        'PORT': '3306',                      # Set to empty string for default.
+        #'HOST': '127.0.0.1', # e.g. mysql server
+        #'PORT': '3306', # e.g. mysql port
     }
 }
 
@@ -55,58 +60,6 @@ DATABASES = {
 if 'sqlite' in DATABASES['default']['ENGINE']:
     DATABASES['default']['OPTIONS'] = { 'timeout': 20 }
 
-# Reinterpret database settings if we have DATABASE_URL environment variable defined
-
-if 'DATABASE_URL' in os.environ:
-    dburl = os.environ['DATABASE_URL']
-
-    if dburl.startswith('sqlite3://'):
-        result = re.match('sqlite3://(.*)', dburl)
-        if result is None:
-            raise Exception("ERROR: Could not read sqlite database url: %s" % dburl)
-        DATABASES['default'] = {
-            'ENGINE': 'django.db.backends.sqlite3',
-            'NAME': result.group(1),
-            'USER': '',
-            'PASSWORD': '',
-            'HOST': '',
-            'PORT': '',
-        }
-    elif dburl.startswith('mysql://'):
-        # URL must be in this form: mysql://user:pass@host:port/name
-        result = re.match(r"mysql://([^:]*):([^@]*)@([^:]*):(\d*)/([^/]*)", dburl)
-        if result is None:
-            raise Exception("ERROR: Could not read mysql database url: %s" % dburl)
-        DATABASES['default'] = {
-            'ENGINE': 'django.db.backends.mysql',
-            'NAME': result.group(5),
-            'USER': result.group(1),
-            'PASSWORD': result.group(2),
-            'HOST': result.group(3),
-            'PORT': result.group(4),
-        }
-    else:
-        raise Exception("FIXME: Please implement missing database url schema for url: %s" % dburl)
-
-
-# Allows current database settings to be exported as a DATABASE_URL environment variable value
-
-def getDATABASE_URL():
-    d = DATABASES['default']
-    if d['ENGINE'] == 'django.db.backends.sqlite3':
-        if d['NAME'] == ':memory:':
-            return 'sqlite3://:memory:'
-        elif d['NAME'].startswith("/"):
-            return 'sqlite3://' + d['NAME']
-        return "sqlite3://" + os.path.join(os.getcwd(), d['NAME'])
-
-    elif d['ENGINE'] == 'django.db.backends.mysql':
-        return "mysql://" + d['USER'] + ":" + d['PASSWORD'] + "@" + d['HOST'] + ":" + d['PORT'] + "/" + d['NAME']
-
-    raise Exception("FIXME: Please implement missing database url schema for engine: %s" % d['ENGINE'])
-
-
-
 # Hosts/domain names that are valid for this site; required if DEBUG is False
 # See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
 ALLOWED_HOSTS = []
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


