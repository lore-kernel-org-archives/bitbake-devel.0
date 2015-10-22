Return-Path: <paul.barker.commagility@gmail.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 398A6770E9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Oct 2015 14:25:19 +0000 (UTC)
Received: by wikq8 with SMTP id q8so34597724wik.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Oct 2015 07:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Qum/JUWfkR+iv2gDdI3a3rGkznNegTTMAJM9I87n1gI=;
	b=OvLqSPgaIiC8neyMpmcxYKBBk7KWRsn8CKjc2EZN6ayBCt7HFHGpP6SVBRasd12EfF
	6dRGj8izsjheRGbv1fxtnULJ66so+JQ3wXFo8BaDPJQ1ZNuZjN0l+WTOs0OpQZFhLbb5
	VH6qu1Pdoa1k5/Jsxoh/8AAEYLqCU/gLSZHDhzzcVWJrB4sj+jSPptQZ61lK//ogQjJQ
	DUrAybzev0HPlDfur+OX7iAh2A2l+8BjqNwc+GcXWJqU6UA9NQ3GxOlwy6vtwktJHLNW
	4zkrSOnPEvYxpXonSfNMomcOMJ9gg2XtUVd3W3jeJVtBm5SKk1g/qFQjp6b6C4mG5o4u
	GkpQ==
X-Received: by 10.181.8.72 with SMTP id di8mr18082581wid.62.1445523919635;
	Thu, 22 Oct 2015 07:25:19 -0700 (PDT)
Received: from oebuild.commagility.com (inno-commagility-ownrouter.lut.ac.uk.
	[131.231.60.35]) by smtp.gmail.com with ESMTPSA id
	lg1sm28276828wic.17.2015.10.22.07.25.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Oct 2015 07:25:18 -0700 (PDT)
From: Paul Barker <paul.barker@commagility.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Oct 2015 15:21:49 +0100
Message-Id: <1445523709-17314-2-git-send-email-paul.barker@commagility.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1445523709-17314-1-git-send-email-paul.barker@commagility.com>
References: <1445523709-17314-1-git-send-email-paul.barker@commagility.com>
Subject: [PATCH][1.26] toaster: buildinfohelper Skip packages we have no build info about
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
X-List-Received-Date: Thu, 22 Oct 2015 14:25:20 -0000

If there are more packages listed as installed than we know about from
bitbake, and therefore have insufficient information to be able to
create a Toaster Package object then skip it. Also handle the case where
a dependency references such a package.

Also clarify the error logging.

Signed-off-by: Paul Barker <paul.barker@commagility.com>
Cc: Michael Wood <michael.g.wood@intel.com>
Cc: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 64bd94e..f7e0bfb 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -419,6 +419,11 @@ class ORMWrapper(object):
         errormsg = ""
         for p in packagedict:
             searchname = p
+            if p not in pkgpnmap:
+                logger.warning("Image packages list contains %p, but is"
+                               " missing from all packages list where the"
+                               " metadata comes from.  Skipping...", p)
+                continue
             if 'OPKGN' in pkgpnmap[p].keys():
                 searchname = pkgpnmap[p]['OPKGN']
 
@@ -462,13 +467,20 @@ class ORMWrapper(object):
                 elif deptype == 'recommends':
                     tdeptype = Package_Dependency.TYPE_TRECOMMENDS
 
-                packagedeps_objs.append(Package_Dependency( package = packagedict[p]['object'],
-                                        depends_on = packagedict[px]['object'],
-                                        dep_type = tdeptype,
-                                        target = target_obj))
+                try:
+                    packagedeps_objs.append(Package_Dependency(
+                        package = packagedict[p]['object'],
+                        depends_on = packagedict[px]['object'],
+                        dep_type = tdeptype,
+                        target = target_obj))
+                except KeyError as e:
+                    logger.warn("Could not add dependency to the package %s "
+                                "because %s is an unknown package", p, px)
 
         if len(packagedeps_objs) > 0:
             Package_Dependency.objects.bulk_create(packagedeps_objs)
+        else:
+            logger.info("No package dependencies created")
 
         if (len(errormsg) > 0):
             logger.warn("buildinfohelper: target_package_info could not identify recipes: \n%s" % errormsg)
@@ -1015,17 +1027,21 @@ class BuildInfoHelper(object):
         # for all image targets
         for target in self.internal_state['targets']:
             if target.is_image:
+                pkgdata = BuildInfoHelper._get_data_from_event(event)['pkgdata']
+                imgdata = BuildInfoHelper._get_data_from_event(event)['imgdata'][target.target]
+                filedata = BuildInfoHelper._get_data_from_event(event)['filedata'][target.target]
+
                 try:
-                    pkgdata = BuildInfoHelper._get_data_from_event(event)['pkgdata']
-                    imgdata = BuildInfoHelper._get_data_from_event(event)['imgdata'][target.target]
                     self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'])
-                    filedata = BuildInfoHelper._get_data_from_event(event)['filedata'][target.target]
-                    self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
-                except KeyError:
-                    # we must have not got the data for this image, nothing to save
-                    pass
-
+                except KeyError as e:
+                    logger.warn("KeyError in save_target_package_information"
+                                "%s ", e)
 
+                try:
+                    self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
+                except KeyError as e:
+                    logger.warn("KeyError in save_target_file_information"
+                                "%s ", e)
 
     def store_dependency_information(self, event):
         assert '_depgraph' in vars(event)
-- 
1.8.3.1


