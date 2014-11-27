Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 6845E7239F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:08 +0000 (UTC)
Received: by mail-wi0-f176.google.com with SMTP id ex7so16324560wid.15
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=bV/FymbwC3QAcZPNb1hUmwNFL2PbdYiPCeF00mGoqQ4=;
	b=Bv7L+l5G0GDsyW8H1A2FDD/fHqi0B3Os7X545n9srzoTEoeiThDCVpGAE5wFbGedTo
	hlN4fzSEb1/EdS96TexZgzs5kYdJXJrfgtzqykuAeJhNHSF9vPwvtqbSX6DEb2YkTIMP
	eRZq4aChgWfYDiGW7pSs4l7YqOPXAduno6ceWh9sQUKN60XrqH+zo1Z3mW1uxPKnYVfN
	I3lpPfMKzb1I8YwiX6IlUaAYFHm7pyorQvYvSyIm5nE95fdGUA3fORRhuHoBKhWRXesZ
	643Loe5Fl7z8NzPHA9QU8Mteudwuv+Pg9tLQqcdoOfhLp08rJx3oLGFTMCWKZMKWcRGo
	JqBQ==
X-Gm-Message-State: ALoCoQmFNWvF/U4hDxzM/NrLF8vH1hc8zEruhKogVVIZPo+h1+8SOl9N2XYUxxZ1Ga3WZ3XunNFk
X-Received: by 10.180.198.52 with SMTP id iz20mr26239093wic.60.1417108088743; 
	Thu, 27 Nov 2014 09:08:08 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	bm1sm11493567wjb.45.2014.11.27.09.08.07 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 039B1564116; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:56 +0000
Message-Id: <2378812bc24d433125fb940f110154f0ce638448.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 05/14] toaster: display Toaster exceptions and other fixes
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:12 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Changing ToasterUI to log toaster exceptions on a different level than
build errors.

Updating the build dashboard to show Toaster exceptions.

We add extra logging to console for exceptions.

Fixed a problem where packages database entries were created instead of
being looked up in the database, conficting with entries created to
satisfy dependency information.

Toaster now checks for invalid states at startup and performs needed
cleanups.

Removed loading reference to jquery-ui.min.css as we do not have this
file.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       | 15 ++++++++--
 lib/bb/ui/toasterui.py                             |  7 +++--
 .../management/commands/checksettings.py           |  8 +++++
 lib/toaster/orm/models.py                          |  9 +++++-
 lib/toaster/toastergui/static/js/libtoaster.js     |  7 +++++
 lib/toaster/toastergui/templates/base.html         |  2 +-
 .../toastergui/templates/builddashboard.html       | 35 ++++++++++++++++++++++
 lib/toaster/toastergui/views.py                    |  2 +-
 8 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index a907a03..a3401ce 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -381,7 +381,7 @@ class ORMWrapper(object):
                 searchname = pkgpnmap[p]['OPKGN']
 
             packagedict[p]['object'], created = Package.objects.get_or_create( build = build_obj, name = searchname )
-            if created or package[p]['object'].size == -1:    # save the data anyway we can, not just if it was not created here; bug [YOCTO #6887]
+            if created or packagedict[p]['object'].size == -1:    # save the data anyway we can, not just if it was not created here; bug [YOCTO #6887]
                 # fill in everything we can from the runtime-reverse package data
                 try:
                     packagedict[p]['object'].recipe = recipes[pkgpnmap[p]['PN']]
@@ -462,7 +462,7 @@ class ORMWrapper(object):
         if 'OPKGN' in package_info.keys():
             pname = package_info['OPKGN']
 
-        bp_object = Package.objects.create( build = build_obj,
+        bp_object, created = Package.objects.get_or_create( build = build_obj,
                                        name = pname )
 
         bp_object.installed_name = package_info['PKG']
@@ -1043,6 +1043,15 @@ class BuildInfoHelper(object):
         mockevent.lineno = -1
         self.store_log_event(mockevent)
 
+    def store_log_exception(self, text, backtrace = ""):
+        mockevent = MockEvent()
+        mockevent.levelno = -1
+        mockevent.msg = text
+        mockevent.pathname = backtrace
+        mockevent.lineno = -1
+        self.store_log_event(mockevent)
+
+
     def store_log_event(self, event):
         if event.levelno < format.WARNING:
             return
@@ -1078,6 +1087,8 @@ class BuildInfoHelper(object):
             log_information['level'] = LogMessage.ERROR
         elif event.levelno == format.WARNING:
             log_information['level'] = LogMessage.WARNING
+        elif event.levelno == -1:   # toaster self-logging
+            log_information['level'] = -1
         else:
             log_information['level'] = LogMessage.INFO
 
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index b9e8029..9bd04df 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -299,12 +299,13 @@ def main(server, eventHandler, params ):
             logger.error(e)
             import traceback
             exception_data = traceback.format_exc()
+            print(exception_data)
 
             # save them to database, if possible; if it fails, we already logged to console.
             try:
-                buildinfohelper.store_log_error("%s\n%s" % (str(e), exception_data))
-            except Exception:
-                pass
+                buildinfohelper.store_log_exception("%s\n%s" % (str(e), exception_data))
+            except Exception as ce:
+                print("CRITICAL: failed to to save toaster exception to the database: %s" % str(ce))
 
             pass
 
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index cd604eb..96d2d51 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -139,4 +139,12 @@ class Command(NoArgsCommand):
             ToasterSetting.objects.filter(name = 'DEFAULT_RELEASE').delete()
             ToasterSetting.objects.get_or_create(name = 'DEFAULT_RELEASE', value = '')
 
+        # we are just starting up. we must not have any builds in progress, or build environments taken
+        for b in BuildRequest.objects.filter(state = BuildRequest.REQ_INPROGRESS):
+            BRError.objects.create(req = b, errtype = "toaster", errmsg = "Toaster found this build IN PROGRESS while Toaster started up. This is an inconsistent state, and the build was marked as failed")
+
+        BuildRequest.objects.filter(state = BuildRequest.REQ_INPROGRESS).update(state = BuildRequest.REQ_FAILED)
+
+        BuildEnvironment.objects.update(lock = BuildEnvironment.LOCK_FREE)
+
         return 0
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 364b215..34d3754 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -178,6 +178,11 @@ class Build(models.Model):
         tgts = Target.objects.filter(build_id = self.id).order_by( 'target' );
         return( tgts );
 
+    @property
+    def toaster_exceptions(self):
+        return self.logmessage_set.filter(level=LogMessage.EXCEPTION)
+
+
 class ProjectTarget(models.Model):
     project = models.ForeignKey(Project)
     target = models.CharField(max_length=100)
@@ -966,13 +971,15 @@ class HelpText(models.Model):
     text = models.TextField()
 
 class LogMessage(models.Model):
+    EXCEPTION = -1      # used to signal self-toaster-exceptions
     INFO = 0
     WARNING = 1
     ERROR = 2
 
     LOG_LEVEL = ( (INFO, "info"),
             (WARNING, "warn"),
-            (ERROR, "error") )
+            (ERROR, "error"),
+            (EXCEPTION, "toaster exception"))
 
     build = models.ForeignKey(Build)
     task  = models.ForeignKey(Task, blank = True, null=True)
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 4983ef6..8e76ecb 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -252,6 +252,13 @@ $(document).ready(function() {
     $('.toggle-warnings').click(function() {
         $('#collapse-warnings').toggleClass('in');
     });
+    $('.show-exceptions').click(function() {
+        $('#collapse-exceptions').addClass('in');
+    });
+    $('.toggle-exceptions').click(function() {
+        $('#collapse-exceptions').toggleClass('in');
+    });
+
     //show warnings section when requested from the previous page
     if (location.href.search('#warnings') > -1) {
         $('#collapse-warnings').addClass('in');
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index f457b91..8170a3d 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -8,7 +8,7 @@
 <link rel="stylesheet" href="{% static 'css/font-awesome.min.css' %}" type='text/css'>
 <link rel="stylesheet" href="{% static 'css/prettify.css' %}" type='text/css'>
 <link rel="stylesheet" href="{% static 'css/default.css' %}" type='text/css'>
-<link rel="stylesheet" href="assets/css/jquery-ui-1.10.3.custom.min.css" type='text/css'>
+
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
 <script src="{% static 'js/jquery-2.0.3.min.js' %}">
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 2aa7b6b..e682094 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -39,6 +39,14 @@
             <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a></span>
 {%endif%}
     </div>
+    {% if build.toaster_exceptions.count > 0 %}
+    <div class="row">
+        <small class="pull-right">
+		<i class="icon-question-sign get-help get-help-blue" title="" data-original-title="Toaster exceptions do not affect your build: only the operation of Toaster"></i>
+		<a class="show-exceptions" href="#exceptions">Toaster threw {{build.toaster_exceptions.count}} exception{{build.toaster_exceptions.count|pluralize}}</a>
+	</small>
+    </div>
+    {% endif %}
   </div>
 </div>
 
@@ -223,6 +231,33 @@
 </div>
 {% endif %}
 
+
+{% if build.toaster_exceptions.count > 0 %}
+<div class="accordion span10 pull-right" id="exceptions">
+  <div class="accordion-group">
+    <div class="accordion-heading">
+      <a class="accordion-toggle exception toggle-exceptions">
+        <h2 id="exception-toggle">
+          <i class="icon-warning-sign"></i>
+          {{build.toaster_exceptions.count}} Toaster exception{{build.toaster_exceptions.count|pluralize}}
+        </h2>
+      </a>
+    </div>
+    <div class="accordion-body collapse" id="collapse-exceptions">
+      <div class="accordion-inner">
+        <div class="span10">
+          {% for exception in build.toaster_exceptions %}
+            <div class="alert alert-exception">
+              <pre>{{exception.message}}</pre>
+            </div>
+          {% endfor %}
+        </div>
+      </div>
+    </div>
+  </div>
+</div>
+{% endif %}
+
 <script type="text/javascript">
     $(document).ready(function() {
         //show warnings section when requested from the previous page
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 11c373a..b13f3e8 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -461,7 +461,7 @@ def builddashboard( request, build_id ):
     template = "builddashboard.html"
     if Build.objects.filter( pk=build_id ).count( ) == 0 :
         return redirect( builds )
-    build = Build.objects.filter( pk = build_id )[ 0 ];
+    build = Build.objects.get( pk = build_id );
     layerVersionId = Layer_Version.objects.filter( build = build_id );
     recipeCount = Recipe.objects.filter( layer_version__id__in = layerVersionId ).count( );
     tgts = Target.objects.filter( build_id = build_id ).order_by( 'target' );
-- 
1.9.1


