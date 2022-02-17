Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3662DC433F5
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 22:09:49 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web09.3386.1645135788562633780
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IDRLAq9k;
 spf=pass (domain: konsulko.com, ip: 209.85.219.52,
 mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f52.google.com with SMTP id p7so11068247qvk.11
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qs3f77h+dXGwhKe95juJctNgeeVckFYlixJ0Bl5N/90=;
        b=IDRLAq9kVHPto2Fs48Gu77QVHOyaugNk4ReHNm7wdJZqseEcBqM0HlXjBsX9IRrHJ/
         6CIwdyaUU9Ur5OGssZpKteLbPmxZlFurnPV3q5C+1VAJpgXicA2T3TIAKbsFgEy9avVs
         nfEU4i7okHZfSejXb5KxUZ04dmthWJmrRYZZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qs3f77h+dXGwhKe95juJctNgeeVckFYlixJ0Bl5N/90=;
        b=Cmxnuo2vrFVXM6mGnAy4vtRuovsnhwBwtlD1Ax/S9elmNy1RW4AT6R9xaEbnH1IPWx
         kOaY3mubrdkwXz3JOuRjGTCLncVThSCcs0fVPQNhN+9AvFRrX19jBxyjO8oHu0HbTZWa
         fhBNG7T+6HDfyXz397yRJWipDkbiqk6b8gFKlCkleFiebpPqug1wxrMNnXeNijKrkzKT
         k/+MVDCwTWAADI36brkA45Kr2ns7eIORppbwPTmaPPZfVNuKjRPQF7v7jE05I+MYstxJ
         Qslh0A9Hqc7fnlpDAPLYkwsVXw7MVxn4SuBq5LK4vMzJRUJPINVacqudDvKLurWLDQJs
         8bEw==
X-Gm-Message-State: AOAM530bw97dfkx4//sF1ISsgUmYLLYLYWfcnF6dyobejf8MiJeZYU1K
	kWMEmW4nJeaJuHeIKXSTo6fnac1hpC7wWQ==
X-Google-Smtp-Source: 
 ABdhPJx0TEtnoDUn+rasJd6lcGh6VrzntJE+5cIysjmDXSWeCMEdTjqKngW7y43jchnjBaeFmsk2rA==
X-Received: by 2002:a05:622a:20a:b0:2d7:fbbe:fdb with SMTP id
 b10-20020a05622a020a00b002d7fbbe0fdbmr4225689qtx.506.1645135786980;
        Thu, 17 Feb 2022 14:09:46 -0800 (PST)
Received: from ghidorah.spiteful.org (192-0-174-222.cpe.teksavvy.com.
 [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id
 q15sm5127572qtn.41.2022.02.17.14.09.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:09:46 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] Replace remaining "blacklist"/"whitelist" usage
Date: Thu, 17 Feb 2022 17:09:32 -0500
Message-Id: 
 <3180b994885ba51b3ccdb332854efab895eb35f0.1645135230.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645135230.git.scott.murray@konsulko.com>
References: <cover.1645135230.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Feb 2022 22:09:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13361

In line with the inclusive language migration defined at:

https://wiki.yoctoproject.org/wiki/Inclusive_language

replace the remaining non-backwards-compatibility related usage
of "blacklist"/"whitelist" with "allowed"/"disallowed" in a few
places as appropriate.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/__init__.py                      |  2 +-
 lib/layerindexlib/__init__.py                  |  4 ++--
 lib/layerindexlib/cooker.py                    |  2 +-
 .../orm/management/commands/lsupdates.py       | 12 ++++++------
 .../toastergui/templates/projectconf.html      | 10 +++++-----
 lib/toaster/toastergui/views.py                | 18 +++++++++---------
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d099cd10..917adeb2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -199,7 +199,7 @@ class URI(object):
      file://hostname/absolute/path.diff (would be IETF compliant)
 
     Note that the last case only applies to a list of
-    "whitelisted" schemes (currently only file://), that requires
+    explicitly allowed schemes (currently only file://), that requires
     its URIs to not have a network location.
     """
 
diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index 08063c57..ac03d898 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -1278,7 +1278,7 @@ class Recipe(LayerIndexItemObj_LayerBranch):
                     filename, filepath, pn, pv, layerbranch,
                     summary="", description="", section="", license="",
                     homepage="", bugtracker="", provides="", bbclassextend="",
-                    inherits="", blacklisted="", updated=None):
+                    inherits="", disallowed="", updated=None):
         self.id = id
         self.filename = filename
         self.filepath = filepath
@@ -1294,7 +1294,7 @@ class Recipe(LayerIndexItemObj_LayerBranch):
         self.bbclassextend = bbclassextend
         self.inherits = inherits
         self.updated = updated or datetime.datetime.today().isoformat()
-        self.blacklisted = blacklisted
+        self.disallowed = disallowed
         if isinstance(layerbranch, LayerBranch):
             self.layerbranch = layerbranch
         else:
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
index 2de6e5fa..ced3e063 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -279,7 +279,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
                                    summary=pn, description=pn, section='?',
                                    license='?', homepage='?', bugtracker='?',
                                    provides='?', bbclassextend='?', inherits='?',
-                                   blacklisted='?', layerbranch=depBranchId)
+                                   disallowed='?', layerbranch=depBranchId)
 
                     index = addElement("recipes", [recipe], index)
 
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 3b950e6e..eb097555 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -87,13 +87,13 @@ class Command(BaseCommand):
 
         # update branches; only those that we already have names listed in the
         # Releases table
-        whitelist_branch_names = [rel.branch_name
-                                  for rel in Release.objects.all()]
-        if len(whitelist_branch_names) == 0:
+        allowed_branch_names = [rel.branch_name
+                                for rel in Release.objects.all()]
+        if len(allowed_branch_names) == 0:
             raise Exception("Failed to make list of branches to fetch")
 
         logger.info("Fetching metadata for %s",
-                    " ".join(whitelist_branch_names))
+                    " ".join(allowed_branch_names))
 
         # We require a non-empty bb.data, but we can fake it with a dictionary
         layerindex = layerindexlib.LayerIndex({"DUMMY" : "VALUE"})
@@ -101,8 +101,8 @@ class Command(BaseCommand):
         http_progress = Spinner()
         http_progress.start()
 
-        if whitelist_branch_names:
-            url_branches = ";branch=%s" % ','.join(whitelist_branch_names)
+        if allowed_branch_names:
+            url_branches = ";branch=%s" % ','.join(allowed_branch_names)
         else:
             url_branches = ""
         layerindex.load_layerindex("%s%s" % (self.apiurl, url_branches))
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index bd49f1f5..d62691df 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -167,8 +167,8 @@
   {% for fstype in vars_fstypes %}
   <input type="hidden" class="js-checkbox-fstypes-list" value="{{fstype}}">
   {% endfor %}
-  {% for b in vars_blacklist %}
-  <input type="hidden" class="js-config-blacklist-name" value="{{b}}">
+  {% for b in vars_disallowed %}
+  <input type="hidden" class="js-config-disallowed-name" value="{{b}}">
   {% endfor %}
   {% for b in vars_managed %}
   <input type="hidden" class="js-config-managed-name" value="{{b}}">
@@ -238,9 +238,9 @@ function validate_new_variable() {
     }
   }
 
-  var blacklist_configvars = document.getElementsByClassName('js-config-blacklist-name');
-  for (var i = 0, length = blacklist_configvars.length; i < length; i++) {
-    if (blacklist_configvars[i].value.toUpperCase() == variable.toUpperCase()) {
+  var disallowed_configvars = document.getElementsByClassName('js-config-disallowed-name');
+  for (var i = 0, length = disallowed_configvars.length; i < length; i++) {
+    if (disallowed_configvars[i].value.toUpperCase() == variable.toUpperCase()) {
       error_msg = "You cannot edit this variable in Toaster because it is set by the build servers";
     }
   }
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 74f9d569..a571b8cc 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1683,12 +1683,12 @@ if True:
                 t=request.POST['configvarDel'].strip()
                 pt = ProjectVariable.objects.get(pk = int(t)).delete()
 
-            # return all project settings, filter out blacklist and elsewhere-managed variables
-            vars_managed,vars_fstypes,vars_blacklist = get_project_configvars_context()
+            # return all project settings, filter out disallowed and elsewhere-managed variables
+            vars_managed,vars_fstypes,vars_disallowed = get_project_configvars_context()
             configvars_query = ProjectVariable.objects.filter(project_id = pid).all()
             for var in vars_managed:
                 configvars_query = configvars_query.exclude(name = var)
-            for var in vars_blacklist:
+            for var in vars_disallowed:
                 configvars_query = configvars_query.exclude(name = var)
 
             return_data = {
@@ -1781,7 +1781,7 @@ if True:
             'MACHINE', 'BBLAYERS'
         }
 
-        vars_blacklist  = {
+        vars_disallowed  = {
             'PARALLEL_MAKE','BB_NUMBER_THREADS',
             'BB_DISKMON_DIRS','BB_NUMBER_THREADS','CVS_PROXY_HOST','CVS_PROXY_PORT',
             'PARALLEL_MAKE','TMPDIR',
@@ -1790,7 +1790,7 @@ if True:
 
         vars_fstypes = Target_Image_File.SUFFIXES
 
-        return(vars_managed,sorted(vars_fstypes),vars_blacklist)
+        return(vars_managed,sorted(vars_fstypes),vars_disallowed)
 
     def projectconf(request, pid):
 
@@ -1799,12 +1799,12 @@ if True:
         except Project.DoesNotExist:
             return HttpResponseNotFound("<h1>Project id " + pid + " is unavailable</h1>")
 
-        # remove blacklist and externally managed varaibles from this list
-        vars_managed,vars_fstypes,vars_blacklist = get_project_configvars_context()
+        # remove disallowed and externally managed varaibles from this list
+        vars_managed,vars_fstypes,vars_disallowed = get_project_configvars_context()
         configvars = ProjectVariable.objects.filter(project_id = pid).all()
         for var in vars_managed:
             configvars = configvars.exclude(name = var)
-        for var in vars_blacklist:
+        for var in vars_disallowed:
             configvars = configvars.exclude(name = var)
 
         context = {
@@ -1812,7 +1812,7 @@ if True:
             'configvars':       configvars,
             'vars_managed':     vars_managed,
             'vars_fstypes':     vars_fstypes,
-            'vars_blacklist':   vars_blacklist,
+            'vars_disallowed':  vars_disallowed,
         }
 
         try:
-- 
2.35.1


