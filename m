Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 7201A76A69
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:13 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so105266328wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=zJ0AC9UYIk2TC0b3RJEuUl65eSJNg/BHLDfwy2eLZu8=;
	b=He1CWBeyWnGMgiudU4HUi57ZFRWI4a3uY9WFnoVYuYyvftWT/+JPyNaMiPhIprZCv9
	844MCXtpG1GxuEjoMfKZLioOua1Z/bvCESq+tO/JsGp1SwoKbD6m3Vfbi5ZrbanE434J
	x1oVe4iF6RUcNnNMz6Ce49telA74ZfZjc10AyqEqJ+AP0Ee/kwVZadihXH+D/zb4mM5H
	2CFM/sMIGYRh93ddXDm2ReEkEVpt1rvCX5ABXxkMXDiI1PfYnYq7kqcRUuuyYjOJrav+
	ryUfoVQip+mJi8LJFLon5Mzyp5UWW+cB9WsP3xVMSicaJ85/x87PKmAKLB5CCmBn04La
	MW5Q==
X-Gm-Message-State: ALoCoQm6R9C8BO/6QpKZEFMrQSWasWLghVqvQquaYFD+MObARkngM7rU+7EBLx1tQ+ndPFedqbLY
X-Received: by 10.180.73.13 with SMTP id h13mr44017546wiv.79.1439915353181;
	Tue, 18 Aug 2015 09:29:13 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:12 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:55 +0100
Message-Id: <7cd3c01dd97d4e6e9a67b074aa99e011043b4bf0.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 09/14] bitbake: toaster: replace raising Exceptions in loadconf
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch replaces throwing Exceptions in toaster loadconf
command with proper explicit error messages. This allows
the user to properly understand and debug what went wrong when
loading a config file.

Additionally we change a bit the logic around auto-detecting relative
giturl handling so the user gets proper error messages when
trying to load an invalid toasterconf.json file.

[YOCTO #7945]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../bldcontrol/management/commands/loadconf.py     | 37 ++++++++++++++--------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/loadconf.py b/lib/toaster/bldcontrol/management/commands/loadconf.py
index 9163e9b..5022b59 100644
--- a/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -1,10 +1,14 @@
 from django.core.management.base import BaseCommand, CommandError
 from orm.models import LayerSource, ToasterSetting, Branch, Layer, Layer_Version
 from orm.models import BitbakeVersion, Release, ReleaseDefaultLayer, ReleaseLayerSourcePriority
+from django.db import IntegrityError
 import os
 
 from checksettings import DN
 
+import logging
+logger = logging.getLogger("toaster")
+
 def _reduce_canon_path(path):
     components = []
     for c in path.split("/"):
@@ -34,7 +38,7 @@ class Command(BaseCommand):
         if not os.path.exists(filepath) or not os.path.isfile(filepath):
             raise Exception("Failed to find toaster config file %s ." % filepath)
 
-        import json, pprint
+        import json
         data = json.loads(open(filepath, "r").read())
 
         # verify config file validity before updating settings
@@ -49,7 +53,7 @@ class Command(BaseCommand):
             cmd = subprocess.Popen("git remote -v", shell=True, cwd = os.path.dirname(filepath), stdout=subprocess.PIPE, stderr = subprocess.PIPE)
             (out,err) = cmd.communicate()
             if cmd.returncode != 0:
-                raise Exception("Error while importing layer vcs_url: git error: %s" % err)
+                logging.warning("Error while importing layer vcs_url: git error: %s" % err)
             for line in out.split("\n"):
                 try:
                     (name, path) = line.split("\t", 1)
@@ -59,16 +63,20 @@ class Command(BaseCommand):
                 except ValueError:
                     pass
             if url == None:
-                raise Exception("Error while looking for remote \"%s\" in \"%s\"" % (remote_name, out))
+                logging.warning("Error while looking for remote \"%s\" in \"%s\"" % (remote_name, out))
             return url
 
 
         # import bitbake data
         for bvi in data['bitbake']:
             bvo, created = BitbakeVersion.objects.get_or_create(name=bvi['name'])
-            bvo.giturl = bvi['giturl']
             if bvi['giturl'].startswith("remote:"):
                 bvo.giturl = _read_git_url_from_local_repository(bvi['giturl'])
+                if bvo.giturl is None:
+                    logger.error("The toaster config file references the local git repo, but Toaster cannot detect it.\nYour local configuration for bitbake version %s is invalid. Make sure that the toasterconf.json file is correct." % bvi['name'])
+
+            if bvo.giturl is None:
+                bvo.giturl = bvi['giturl']
             bvo.branch = bvi['branch']
             bvo.dirpath = bvi['dirpath']
             bvo.save()
@@ -89,13 +97,12 @@ class Command(BaseCommand):
             assert ((_get_id_for_sourcetype(lsi['sourcetype']) == LayerSource.TYPE_LAYERINDEX) or apiurl.startswith("/")), (lsi['sourcetype'],apiurl)
 
             try:
-                ls = LayerSource.objects.get(sourcetype = _get_id_for_sourcetype(lsi['sourcetype']), apiurl = apiurl)
-            except LayerSource.DoesNotExist:
-                ls = LayerSource.objects.create(
-                    name = lsi['name'],
-                    sourcetype = _get_id_for_sourcetype(lsi['sourcetype']),
-                    apiurl = apiurl
-                )
+                ls, created = LayerSource.objects.get_or_create(sourcetype = _get_id_for_sourcetype(lsi['sourcetype']), apiurl = apiurl)
+                ls.name = lsi['name']
+                ls.save()
+            except IntegrityError as e:
+                logger.warning("IntegrityError %s \nWhile setting name %s for layer source %s " % (e, lsi['name'], ls))
+
 
             layerbranches = []
             for branchname in lsi['branches']:
@@ -111,12 +118,14 @@ class Command(BaseCommand):
                         lo.local_path = _reduce_canon_path(os.path.join(ls.apiurl, layerinfo['local_path']))
 
                     if not os.path.exists(lo.local_path):
-                        raise Exception("Local layer path %s must exists." % lo.local_path)
+                        logger.error("Local layer path %s must exists. Are you trying to import a layer that does not exist ? Check your local toasterconf.json" % lo.local_path)
 
-                    lo.vcs_url = layerinfo['vcs_url']
                     if layerinfo['vcs_url'].startswith("remote:"):
                         lo.vcs_url = _read_git_url_from_local_repository(layerinfo['vcs_url'])
-                    else:
+                        if lo.vcs_url is None:
+                            logger.error("The toaster config file references the local git repo, but Toaster cannot detect it.\nYour local configuration for layer %s is invalid. Make sure that the toasterconf.json file is correct." % layerinfo['name'])
+
+                    if lo.vcs_url is None:
                         lo.vcs_url = layerinfo['vcs_url']
 
                     if 'layer_index_url' in layerinfo:
-- 
2.1.4


