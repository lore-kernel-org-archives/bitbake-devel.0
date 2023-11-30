Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5211DC10DAA
	for <webhook@archiver.kernel.org>; Thu, 30 Nov 2023 21:42:51 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.6396.1701380566236630600
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Nov 2023 13:42:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ea6cTDh7;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E04BD9C33F8;
	Thu, 30 Nov 2023 16:42:44 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id qKaGgneO8Hjn; Thu, 30 Nov 2023 16:42:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DBE869C3766;
	Thu, 30 Nov 2023 16:42:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com DBE869C3766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701380563; bh=8I3ni6N4r/ITRGqlS2hM7wbAqMD1gQ7WehXHPKMRhYc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ea6cTDh7ZaCKMju8Ch4B3DklWR3D+MEhblQdP2JAzHP5WmzRvz7MzTCbK4jmeAl3a
	 yJWC4VJSpCldp3D2Wy4qHHjJLwtXrVZy2NPofmS8x7pNB6PpdoJab1xQiikWzkzW19
	 DITY3QWv/m9IXL+ayEGi9B8xRtSnwyimu2whaV01OFwAveGGYBZlbaMaecDpyXcYay
	 GiBQFnoLD+HGFGrK8BsCTJcad/LgAvlkCAmWjunllMq8IxdRP99HKcyXYoMPekYW6d
	 iYIQ5r/xdYXMTjr8sKW8HGBPYTXOXfAWwdA8pDDRGTiarhvmjn4e7RL1ohcHikDDmP
	 syGWJgMz0PrTg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id D7DuMGVX7kIs; Thu, 30 Nov 2023 16:42:43 -0500 (EST)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C149F9C3471;
	Thu, 30 Nov 2023 16:42:43 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [toaster][PATCHv2 2/2] toaster: Update feat to import eventlogs
Date: Thu, 30 Nov 2023 16:42:35 -0500
Message-Id: <20231130214235.20330-3-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130214235.20330-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: <20231130214235.20330-1-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Nov 2023 21:42:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15592

Follow up to feature to import eventlogs
Updated UI using jquery and ajax to block screen and redirect to build pa=
ge when import eventlogs is trigger
Changed title for eventlogs folder in template
Added a new button on landing page linked to import build page, and set m=
in-height of buttons in landing page for uniformity

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/toaster/toastergui/static/css/default.css | 28 ++++++++++++++++
 .../templates/command_line_builds.html        | 33 ++++++++++++++++---
 lib/toaster/toastergui/templates/landing.html | 10 ++++--
 lib/toaster/toastergui/views.py               | 17 ++++++++++
 4 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/=
toastergui/static/css/default.css
index 5cd7e211..284355e7 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -367,3 +367,31 @@ h2.panel-title { font-size: 30px; }
   }
 }
 /* End copied in from newer version of Font-Awesome 4.3.0 */
+
+
+#overlay {
+  display: flex;
+  position: fixed;
+  top: 0;
+  left: 0;
+  width: 100%;
+  height: 100%;
+  background-color: rgba(0, 0, 0, 0.7);
+  align-items: center;
+  justify-content: center;
+  z-index: 999;
+}
+
+.spinner {
+  border: 6px solid rgba(255, 255, 255, 0.3);
+  border-radius: 50%;
+  border-top: 6px solid #3498db;
+  width: 50px;
+  height: 50px;
+  animation: spin 1s linear infinite;
+}
+
+@keyframes spin {
+  0% { transform: rotate(0deg); }
+  100% { transform: rotate(360deg); }
+}
diff --git a/lib/toaster/toastergui/templates/command_line_builds.html b/=
lib/toaster/toastergui/templates/command_line_builds.html
index 5b085e33..3145f535 100644
--- a/lib/toaster/toastergui/templates/command_line_builds.html
+++ b/lib/toaster/toastergui/templates/command_line_builds.html
@@ -7,6 +7,12 @@
 {% block pagecontent %}
=20
 <div class=3D"container-fluid">
+    <div id=3D"overlay" class=3D"hide">
+        <div class=3D"spinner">
+            <div class=3D"fa-spin">
+            </div>
+        </div>
+    </div>
     <div class=3D"row">
         <div class=3D"col-md-12">
             <div class=3D"page-header">
@@ -32,7 +38,7 @@
             {% endif %}
             <div class=3D"row">
                 <h4 style=3D"margin-left: 15px;"><strong>Import eventlog=
 file</strong></h4>
-                <form method=3D"POST" enctype=3D"multipart/form-data" ac=
tion=3D"{% url 'cmdlines' %}">=20
+                <form method=3D"POST" enctype=3D"multipart/form-data" ac=
tion=3D"{% url 'cmdlines' %}" id=3D"form_file">=20
                     {% csrf_token %}=20
                     <div class=3D"col-md-6" style=3D"padding-left: 20px;=
">
                         <div class=3D"row">
@@ -52,7 +58,7 @@
=20
             <div class=3D"row" style=3D"padding-top: 20px;">
                 <div class=3D"col-md-6 ">
-                    <h4><strong>Import eventlog files from directory</st=
rong>
+                    <h4><strong>Eventlogs from existing build directory:=
 </strong>
                         <a href=3D"#" data-toggle=3D"tooltip" title=3D"{=
{dir}}">
                             <svg xmlns=3D"http://www.w3.org/2000/svg" wi=
dth=3D"16" height=3D"16" fill=3D"currentColor" class=3D"bi bi-info-circle=
" viewBox=3D"0 0 16 16" data-toggle=3D"tooltip">
                                 <path d=3D"M8 15A7 7 0 1 1 8 1a7 7 0 0 1=
 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
@@ -78,7 +84,11 @@
                                     <td class=3D"col-md-6 align-middle" =
style=3D"vertical-align: middle;">
                                         {% if file.imported =3D=3D True =
and file.build_id is not None %}
                                             <a href=3D"{% url 'builddash=
board' file.build_id %}">Build Details</a>
-                                        {%else %}
+                                        {% elif request.session.file =3D=
=3D file.name or request.session.all_builds %}
+                                            <a data-toggle=3D"tooltip" t=
itle=3D"Build in progress">
+                                                <span class=3D"glyphicon=
 glyphicon-upload" style=3D"font-size: 18px; color:grey"></span>
+                                            </a>
+                                        {%else%}
                                             <a onclick=3D"_ajax_update('=
{{file.name}}', false, '{{dir}}')" data-toggle=3D"tooltip" title=3D"Impor=
t File">
                                                 <span class=3D"glyphicon=
 glyphicon-upload" style=3D"font-size: 18px;"></span>
                                             </a>
@@ -160,12 +170,27 @@ $(function () {
=20
=20
 $("#id_eventlog_file").change(function(){
-    console.log($('#file_import'))
     $('#file_import').prop("disabled", false);
     $('#file_import').addClass('btn-primary')
     $('#file_import').removeClass('btn-default')
 })
=20
+$(document).ajaxStart(function(){
+    $('#overlay').removeClass('hide');
+    window.setTimeout( =20
+        function() { =20
+            window.location =3D '/toastergui/builds/'
+        }, 10000)
+});
+
+$( "#form_file").on( "submit", function( event ) {
+    $('#overlay').removeClass('hide');
+    window.setTimeout( =20
+        function() { =20
+            window.location =3D '/toastergui/builds/'
+        }, 10000)
+});
+
 </script>
=20
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/=
toastergui/templates/landing.html
index 22bbed69..589ee226 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -15,7 +15,7 @@
               <p>A web interface to <a href=3D"https://www.openembedded.=
org">OpenEmbedded</a> and <a href=3D"https://docs.yoctoproject.org/bitbak=
e.html">BitBake</a>, the <a href=3D"https://www.yoctoproject.org">Yocto P=
roject</a> build system.</p>
=20
 		          <p class=3D"top-air">
-		            <a class=3D"btn btn-info btn-lg" href=3D"http://docs.yocto=
project.org/toaster-manual/setup-and-use.html#setting-up-and-using-toaste=
r">
+		            <a class=3D"btn btn-info btn-lg" href=3D"http://docs.yocto=
project.org/toaster-manual/setup-and-use.html#setting-up-and-using-toaste=
r" style=3D"min-width: 460px;">
 			            Toaster is ready to capture your command line builds
 		            </a>
 		          </p>
@@ -23,7 +23,7 @@
 		          {% if lvs_nos %}
                     {% if project_enable %}
 		            <p class=3D"top-air">
-		              <a class=3D"btn btn-primary btn-lg" href=3D"{% url 'newp=
roject' %}">
+		              <a class=3D"btn btn-primary btn-lg" href=3D"{% url 'newp=
roject' %}" style=3D"min-width: 460px;">
 			              Create your first Toaster project to run manage builds
 		              </a>
 		            </p>
@@ -42,6 +42,12 @@
                 </div>
               {% endif %}
=20
+              <p class=3D"top-air">
+		            <a class=3D"btn btn-info btn-lg" href=3D"{% url 'cmdlines'=
 %}" style=3D"min-width: 460px;">
+			            Import command line event logs from build directory
+		            </a>
+		          </p>
+
               <ul class=3D"list-unstyled lead">
                 <li>
                   <a href=3D"http://docs.yoctoproject.org/toaster-manual=
/index.html#toaster-user-manual">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/vie=
ws.py
index a75fba47..2e34c8a2 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2061,6 +2061,10 @@ class CommandLineBuilds(TemplateView):
         else:
             context['files'] =3D []
             context['dir'] =3D ''
+       =20
+        # enable session variable
+        if not self.request.session.get('file'):
+            self.request.session['file'] =3D ""
=20
         context['form'] =3D LoadFileForm()
         context['project_enable'] =3D project_enable
@@ -2073,6 +2077,12 @@ class CommandLineBuilds(TemplateView):
         imported_files =3D EventLogsImports.objects.all()
         try:
             if all_files =3D=3D 'true':
+
+                # use of session variable to deactivate icon for builds =
in progress
+                request.session['all_builds'] =3D True
+                request.session.modified =3D True
+                request.session.save()
+
                 files =3D ast.literal_eval(request.POST.get('file'))
                 for file in files:
                     if imported_files.filter(name=3Dfile.get('name')).ex=
ists():
@@ -2095,6 +2105,12 @@ class CommandLineBuilds(TemplateView):
                 else:
                     file =3D request.POST.get('file')
=20
+                # use of session variable to deactivate icon for build i=
n progress=20
+                request.session['file'] =3D file
+                request.session['all_builds'] =3D False
+                request.session.modified =3D True
+                request.session.save()
+
                 if imported_files.filter(name=3Dfile).exists():
                     imported_files.filter(name=3Dfile)[0].imported =3D T=
rue
                 else:=20
@@ -2116,6 +2132,7 @@ class CommandLineBuilds(TemplateView):
                     event_log_import =3D EventLogsImports.objects.create=
(name=3Dfile, imported=3DTrue)
                     event_log_import.build_id =3D Build.objects.last().i=
d
                     event_log_import.save()
+                    request.session['file'] =3D ""
         except json.decoder.JSONDecodeError:
             messages.add_message(
                 self.request,
--=20
2.34.1


