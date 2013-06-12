Return-Path: <calinx.l.dragomir@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 855656A880
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Jun 2013 15:09:57 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 12 Jun 2013 08:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,853,1363158000"; d="scan'208";a="352306235"
Received: from calin-desktop.rb.intel.com ([10.237.105.64])
	by orsmga002.jf.intel.com with ESMTP; 12 Jun 2013 08:09:56 -0700
From: Calin Dragomir <calinx.l.dragomir@intel.com>
To: webhob@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 12 Jun 2013 18:11:44 +0300
Message-Id: <1371049906-17370-1-git-send-email-calinx.l.dragomir@intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 1/3] Create main WEBHOB project
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 12 Jun 2013 15:09:58 -0000

This creates a basic Django project where the WEBHOB code will live.
The main project had to be renamed from webhob to whbmain in order to
avoid any import issues that might occur.
---
 bitbake/lib/webhob/__init__.py         |   0
 bitbake/lib/webhob/manage.py           |  10 +++
 bitbake/lib/webhob/whbmain/__init__.py |   0
 bitbake/lib/webhob/whbmain/settings.py | 156 +++++++++++++++++++++++++++++++++
 bitbake/lib/webhob/whbmain/urls.py     |  17 ++++
 bitbake/lib/webhob/whbmain/wsgi.py     |  32 +++++++
 6 files changed, 215 insertions(+)
 create mode 100644 bitbake/lib/webhob/__init__.py
 create mode 100755 bitbake/lib/webhob/manage.py
 create mode 100644 bitbake/lib/webhob/whbmain/__init__.py
 create mode 100644 bitbake/lib/webhob/whbmain/settings.py
 create mode 100644 bitbake/lib/webhob/whbmain/urls.py
 create mode 100644 bitbake/lib/webhob/whbmain/wsgi.py

diff --git a/bitbake/lib/webhob/__init__.py b/bitbake/lib/webhob/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/manage.py b/bitbake/lib/webhob/manage.py
new file mode 100755
index 0000000..1b2c1a7
--- /dev/null
+++ b/bitbake/lib/webhob/manage.py
@@ -0,0 +1,10 @@
+#!/usr/bin/env python
+import os
+import sys
+
+if __name__ == "__main__":
+    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "whbmain.settings")
+
+    from django.core.management import execute_from_command_line
+
+    execute_from_command_line(sys.argv)
diff --git a/bitbake/lib/webhob/whbmain/__init__.py b/bitbake/lib/webhob/whbmain/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/whbmain/settings.py b/bitbake/lib/webhob/whbmain/settings.py
new file mode 100644
index 0000000..bc59543
--- /dev/null
+++ b/bitbake/lib/webhob/whbmain/settings.py
@@ -0,0 +1,156 @@
+# Django settings for webhob project.
+
+DEBUG = True
+TEMPLATE_DEBUG = DEBUG
+
+ADMINS = (
+    # ('Your Name', 'your_email@example.com'),
+)
+
+MANAGERS = ADMINS
+
+DATABASES = {
+    'default': {
+        'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
+        'NAME': 'wbhob',                      # Or path to database file if using sqlite3.
+        # The following settings are not used with sqlite3:
+        'USER': 'root',
+        'PASSWORD': '',
+        'HOST': '127.0.0.1',                      # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
+        'PORT': '3306',                      # Set to empty string for default.
+    }
+}
+
+# Hosts/domain names that are valid for this site; required if DEBUG is False
+# See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
+ALLOWED_HOSTS = []
+
+# Local time zone for this installation. Choices can be found here:
+# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
+# although not all choices may be available on all operating systems.
+# In a Windows environment this must be set to your system time zone.
+TIME_ZONE = 'America/Chicago'
+
+# Language code for this installation. All choices can be found here:
+# http://www.i18nguy.com/unicode/language-identifiers.html
+LANGUAGE_CODE = 'en-us'
+
+SITE_ID = 1
+
+# If you set this to False, Django will make some optimizations so as not
+# to load the internationalization machinery.
+USE_I18N = True
+
+# If you set this to False, Django will not format dates, numbers and
+# calendars according to the current locale.
+USE_L10N = True
+
+# If you set this to False, Django will not use timezone-aware datetimes.
+USE_TZ = True
+
+# Absolute filesystem path to the directory that will hold user-uploaded files.
+# Example: "/var/www/example.com/media/"
+MEDIA_ROOT = ''
+
+# URL that handles the media served from MEDIA_ROOT. Make sure to use a
+# trailing slash.
+# Examples: "http://example.com/media/", "http://media.example.com/"
+MEDIA_URL = ''
+
+# Absolute path to the directory static files should be collected to.
+# Don't put anything in this directory yourself; store your static files
+# in apps' "static/" subdirectories and in STATICFILES_DIRS.
+# Example: "/var/www/example.com/static/"
+STATIC_ROOT = ''
+
+# URL prefix for static files.
+# Example: "http://example.com/static/", "http://static.example.com/"
+STATIC_URL = '/static/'
+
+# Additional locations of static files
+STATICFILES_DIRS = (
+    # Put strings here, like "/home/html/static" or "C:/www/django/static".
+    # Always use forward slashes, even on Windows.
+    # Don't forget to use absolute paths, not relative paths.
+)
+
+# List of finder classes that know how to find static files in
+# various locations.
+STATICFILES_FINDERS = (
+    'django.contrib.staticfiles.finders.FileSystemFinder',
+    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
+#    'django.contrib.staticfiles.finders.DefaultStorageFinder',
+)
+
+# Make this unique, and don't share it with anybody.
+SECRET_KEY = 'fy@5+5w9zn5wa0vsegn1c8p_6w&pa_ms-4t0cna1vle79nzlkn'
+
+# List of callables that know how to import templates from various sources.
+TEMPLATE_LOADERS = (
+    'django.template.loaders.filesystem.Loader',
+    'django.template.loaders.app_directories.Loader',
+#     'django.template.loaders.eggs.Loader',
+)
+
+MIDDLEWARE_CLASSES = (
+    'django.middleware.common.CommonMiddleware',
+    'django.contrib.sessions.middleware.SessionMiddleware',
+    'django.middleware.csrf.CsrfViewMiddleware',
+    'django.contrib.auth.middleware.AuthenticationMiddleware',
+    'django.contrib.messages.middleware.MessageMiddleware',
+    # Uncomment the next line for simple clickjacking protection:
+    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
+)
+
+ROOT_URLCONF = 'whbmain.urls'
+
+# Python dotted path to the WSGI application used by Django's runserver.
+WSGI_APPLICATION = 'whbmain.wsgi.application'
+
+TEMPLATE_DIRS = (
+    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
+    # Always use forward slashes, even on Windows.
+    # Don't forget to use absolute paths, not relative paths.
+)
+
+INSTALLED_APPS = (
+    #'django.contrib.auth',
+    #'django.contrib.contenttypes',
+    #'django.contrib.sessions',
+    #'django.contrib.sites',
+    #'django.contrib.messages',
+    #'django.contrib.staticfiles',
+    # Uncomment the next line to enable the admin:
+    # 'django.contrib.admin',
+    # Uncomment the next line to enable admin documentation:
+    # 'django.contrib.admindocs',
+)
+
+# A sample logging configuration. The only tangible logging
+# performed by this configuration is to send an email to
+# the site admins on every HTTP 500 error when DEBUG=False.
+# See http://docs.djangoproject.com/en/dev/topics/logging for
+# more details on how to customize your logging configuration.
+LOGGING = {
+    'version': 1,
+    'disable_existing_loggers': False,
+    'filters': {
+        'require_debug_false': {
+            '()': 'django.utils.log.RequireDebugFalse'
+        }
+    },
+    'handlers': {
+        'mail_admins': {
+            'level': 'ERROR',
+            'filters': ['require_debug_false'],
+            'class': 'django.utils.log.AdminEmailHandler'
+        }
+    },
+    'loggers': {
+        'django.request': {
+            'handlers': ['mail_admins'],
+            'level': 'ERROR',
+            'propagate': True,
+        },
+    }
+}
diff --git a/bitbake/lib/webhob/whbmain/urls.py b/bitbake/lib/webhob/whbmain/urls.py
new file mode 100644
index 0000000..04e0352
--- /dev/null
+++ b/bitbake/lib/webhob/whbmain/urls.py
@@ -0,0 +1,17 @@
+from django.conf.urls import patterns, include, url
+
+# Uncomment the next two lines to enable the admin:
+# from django.contrib import admin
+# admin.autodiscover()
+
+urlpatterns = patterns('',
+    # Examples:
+    # url(r'^$', 'webhob.views.home', name='home'),
+    # url(r'^webhob/', include('webhob.foo.urls')),
+
+    # Uncomment the admin/doc line below to enable admin documentation:
+    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
+
+    # Uncomment the next line to enable the admin:
+    # url(r'^admin/', include(admin.site.urls)),
+)
diff --git a/bitbake/lib/webhob/whbmain/wsgi.py b/bitbake/lib/webhob/whbmain/wsgi.py
new file mode 100644
index 0000000..9595eda
--- /dev/null
+++ b/bitbake/lib/webhob/whbmain/wsgi.py
@@ -0,0 +1,32 @@
+"""
+WSGI config for webhob project.
+
+This module contains the WSGI application used by Django's development server
+and any production WSGI deployments. It should expose a module-level variable
+named ``application``. Django's ``runserver`` and ``runfcgi`` commands discover
+this application via the ``WSGI_APPLICATION`` setting.
+
+Usually you will have the standard Django WSGI application here, but it also
+might make sense to replace the whole Django WSGI application with a custom one
+that later delegates to the Django one. For example, you could introduce WSGI
+middleware here, or combine a Django application with an application of another
+framework.
+
+"""
+import os
+
+# We defer to a DJANGO_SETTINGS_MODULE already in the environment. This breaks
+# if running multiple sites in the same mod_wsgi process. To fix this, use
+# mod_wsgi daemon mode with each site in its own daemon process, or use
+# os.environ["DJANGO_SETTINGS_MODULE"] = "webhob.settings"
+os.environ.setdefault("DJANGO_SETTINGS_MODULE", "wbhmain.settings")
+
+# This application object is used by any WSGI server configured to use this
+# file. This includes Django's development server, if the WSGI_APPLICATION
+# setting points here.
+from django.core.wsgi import get_wsgi_application
+application = get_wsgi_application()
+
+# Apply WSGI middleware here.
+# from helloworld.wsgi import HelloWorldApplication
+# application = HelloWorldApplication(application)
-- 
1.8.1.2


