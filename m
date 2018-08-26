Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C7330793B2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 22:36:57 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w7QMaxqS024346
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 15:36:59 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 26 Aug 2018 15:36:58 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Aug 2018 15:33:32 -0700
Message-ID: <9953979df07811d99d039b62809cf253a4745f5b.1535322629.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535322629.git.David.Reyna@windriver.com>
References: <cover.1535322629.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 9/9] toaster: enable project import and merged Toaster settings
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
X-List-Received-Date: Sun, 26 Aug 2018 22:36:58 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Enable the ability to select an existing build directory into Toaster.
This  opens to the user the backend features of 12823, for command line
user compatibility.

Enable the ability to select saving Toaster settings in the regular
"bblayers.conf" and "local.conf" instead of the default
"toaster_bblayers.conf" and "toaster.conf". This opens to the user the
backend features of 12821, for command line user compatibility.

[YOCTO #12902]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py    |  8 ++--
 lib/toaster/toastergui/templates/newproject.html   | 53 +++++++++++-----------
 lib/toaster/toastergui/views.py                    | 22 ++++++---
 .../toastermain/management/commands/buildimport.py |  7 +--
 4 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index aba09e0..67bfbf6 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -373,8 +373,8 @@ class LocalhostBEController(BuildEnvironmentController):
                 conf.write('INHERIT+="toaster buildhistory"')
         else:
             # Append the Toaster-specific values directly to the bblayers.conf
-            bblconfpath = os.path.join(bitbake.req.project.builddir, "conf/bblayers.conf")
-            bblconfpath_save = os.path.join(bitbake.req.project.builddir, "conf/bblayers.conf.save")
+            bblconfpath = os.path.join(builddir, "conf/bblayers.conf")
+            bblconfpath_save = os.path.join(builddir, "conf/bblayers.conf.save")
             shutil.copyfile(bblconfpath, bblconfpath_save)
             with open(bblconfpath) as bblayers:
                 content = bblayers.readlines()
@@ -399,8 +399,8 @@ class LocalhostBEController(BuildEnvironmentController):
                 bblayers.write('  "\n')
                 bblayers.write('#=== TOASTER_CONFIG_EPILOG ===\n')
             # Append the Toaster-specific values directly to the local.conf
-            bbconfpath = os.path.join(bitbake.req.project.builddir, "conf/local.conf")
-            bbconfpath_save = os.path.join(bitbake.req.project.builddir, "conf/local.conf.save")
+            bbconfpath = os.path.join(builddir, "conf/local.conf")
+            bbconfpath_save = os.path.join(builddir, "conf/local.conf.save")
             shutil.copyfile(bbconfpath, bbconfpath_save)
             with open(bbconfpath) as f:
                 content = f.readlines()
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index bd03bb5..7e1ebb3 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -20,23 +20,19 @@
             <input type="text" class="form-control" required id="new-project-name" name="projectname">
           </div>
           <p class="help-block text-danger" style="display: none;" id="hint-error-project-name">A project with this name exists. Project names must be unique.</p>
-<!--
-            <fieldset>
-                <label class="project-form">Project type</label>
-                    <label class="project-form radio"><input type="radio" name="ptype" value="analysis" checked/> Analysis Project</label>
 
+                <label class="project-form">Project type:</label>
                 {% if releases.count > 0 %}
-                    <label class="project-form radio"><input type="radio" name="ptype" value="build" checked /> Build Project</label>
+                    <label class="project-form radio" style="padding-left: 35px;"><input id='type-new'    type="radio" name="ptype" value="new"/> New project</label>
                 {% endif %}
-              </fieldset> -->
-        <input type="hidden" name="ptype" value="build" />
+                    <label class="project-form radio" style="padding-left: 35px;"><input id='type-import' type="radio" name="ptype" value="import"/> Import command line project</label>
 
         {% if releases.count > 0 %}
-				<div class="release form-group">
+          <div class="release form-group">
             {% if releases.count > 1 %}
               <label class="control-label">
                 Release
-                <span class="glyphicon glyphicon-question-sign get-help" title="The version of the build system you want to use"></span>
+                <span class="glyphicon glyphicon-question-sign get-help" title="The version of the build system you want to use for this project"></span>
               </label>
               <select name="projectversion" id="projectversion" class="form-control">
                 {% for release in releases %}
@@ -59,28 +55,26 @@
             {% else %}
               <input type="hidden" name="projectversion" value="{{releases.0.id}}"/>
             {% endif %}
-                </div>
+
+              <input type="checkbox" class="checkbox-mergeattr" name="mergeattr" value="mergeattr">  Merged Toaster settings (Command line user compatibility)
+              <span class="glyphicon glyphicon-question-sign get-help" title="Place the Toaster settings into the standard 'local.conf' and 'bblayers.conf' instead of 'toaster_bblayers.conf' and 'toaster.conf'"></span>
+
+           </div>
         {% endif %}
+
+            <div class="build-import form-group" id="import-project">
+              <label class="control-label">Import existing project directory
+                <span class="glyphicon glyphicon-question-sign get-help" title="Enter a path to an existing build directory, import the existing settings, and create a Toaster Project for it."></span>
+              </label>
+              <input style="width: 33%;"type="text" class="form-control" required id="import-project-dir" name="importdir">
+            </div>
+
             <div class="top-air">
               <input type="submit" id="create-project-button" class="btn btn-primary btn-lg" value="Create project"/>
               <span class="help-inline" style="vertical-align:middle;">To create a project, you need to enter a project name</span>
             </div>
 
         </form>
-        <!--
-        <div class="col-md-5 well">
-                <span class="help-block">
-                 <h4>Toaster project types</h4>
-                 <p>With a <strong>build project</strong> you configure and run your builds from Toaster.</p>
-                 <p>With an <strong>analysis project</strong>, the builds are configured and run by another tool
-                 (something like Buildbot or Jenkins), and the project only collects the information about the
-                 builds (packages, recipes, dependencies, logs, etc). </p>
-                 <p>You can read more on <a href="#">how to set up an analysis project</a>
-                 in the Toaster manual.</p>
-                 <h4>Release</h4>
-                 <p>If you create a <strong>build project</strong>, you will need to select a <strong>release</strong>,
-                 which is the version of the build system you want to use to run your builds.</p>
-             </div> -->
       </div>
     </div>
 
@@ -89,6 +83,7 @@
             // hide the new project button
             $("#new-project-button").hide();
             $('.btn-primary').attr('disabled', 'disabled');
+            $('#type-new').attr('checked', 'checked');
 
             // enable submit button when all required fields are populated
             $("input#new-project-name").on('input', function() {
@@ -118,20 +113,24 @@
                  $(".btn-primary"));
 
 
-/*			// Hide the project release when you select an analysis project
+			// Hide the project release when you select an analysis project
 			function projectType() {
-				if ($("input[type='radio']:checked").val() == 'build') {
+				if ($("input[type='radio']:checked").val() == 'new') {
+					$('.build-import').fadeOut();
 					$('.release').fadeIn();
+                    $('#import-project-dir').removeAttr('required');
 				}
 				else {
 					$('.release').fadeOut();
+					$('.build-import').fadeIn();
+                    $('#import-project-dir').attr('required', 'required');
 				}
 			}
 			projectType();
 
 			$('input:radio').change(function(){
 				projectType();
-			}); */
+			});
         });
     </script>
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4939b6b..c712b06 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1398,7 +1398,9 @@ if True:
             mandatory_fields = ['projectname', 'ptype']
             try:
                 ptype = request.POST.get('ptype')
-                if ptype == "build":
+                if ptype == "import":
+                    mandatory_fields.append('importdir')
+                else:
                     mandatory_fields.append('projectversion')
                 # make sure we have values for all mandatory_fields
                 missing = [field for field in mandatory_fields if len(request.POST.get(field, '')) == 0]
@@ -1415,14 +1417,22 @@ if True:
                     login(request, user)
 
                 #  save the project
-                if ptype == "analysis":
-                    release = None
+                if ptype == "import":
+                    if not os.path.isdir('%s/conf' % request.POST['importdir']):
+                        raise BadParameterException("Bad path or missing 'conf' directory (%s)" % request.POST['importdir'])
+                    from django.core import management
+                    management.call_command('buildimport', '--command=import', '--name=%s' % request.POST['projectname'], '--path=%s' % request.POST['importdir'], interactive=False)
+                    prj = Project.objects.get(name = request.POST['projectname'])
+                    prj.merged_attr = True
+                    prj.save()
                 else:
                     release = Release.objects.get(pk = request.POST.get('projectversion', None ))
+                    prj = Project.objects.create_project(name = request.POST['projectname'], release = release)
+                    prj.user_id = request.user.pk
+                    if 'mergeattr' == request.POST.get('mergeattr', ''):
+                        prj.merged_attr = True
+                    prj.save()
 
-                prj = Project.objects.create_project(name = request.POST['projectname'], release = release)
-                prj.user_id = request.user.pk
-                prj.save()
                 return redirect(reverse(project, args=(prj.pk,)) + "?notify=new-project")
 
             except (IntegrityError, BadParameterException) as e:
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 791d528..9e1cd6d 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -484,11 +484,8 @@ class Command(BaseCommand):
     def handle(self, *args, **options):
         project_name = options['name']
         project_path = options['path']
-        project_callback = options['callback']
-        if options['release']:
-            release_name = options['release']
-        else:
-            release_name = ''
+        project_callback = options['callback'] if options['callback'] else ''
+        release_name = options['release'] if options['release'] else ''
 
         #
         # Delete project
-- 
1.9.1


