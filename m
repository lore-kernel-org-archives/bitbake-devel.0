Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 2FD7C60125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:55:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 07 Oct 2015 06:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="786677544"
Received: from cdoyle2-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.38])
	by orsmga001.jf.intel.com with ESMTP; 07 Oct 2015 06:55:19 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 14:55:08 +0100
Message-Id: <eb79129121bacccd9ba6d5cc6dbf78c9749b6509.1444225939.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1870fdfb0c4c5abd8b562b1839f1696bca380b8f.1444225939.git.elliot.smith@intel.com>
References: <1870fdfb0c4c5abd8b562b1839f1696bca380b8f.1444225939.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444225939.git.elliot.smith@intel.com>
References: <cover.1444225939.git.elliot.smith@intel.com>
Subject: [PATCH 2/2] toaster: buildinfohelper Skip packages we have no build info about
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
X-List-Received-Date: Wed, 07 Oct 2015 13:55:27 -0000

From: Michael Wood <michael.g.wood@intel.com>

If there are more packages listed as installed than we know about from
bitbake, and therefore have insufficient information to be able to
create a Toaster Package object then skip it. Also handle the case where
a dependency references such a package.

Also clarify the error logging.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 9195584..67c239e 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -319,7 +319,7 @@ class ORMWrapper(object):
                             commit=layer_version_information['commit'],
                             local_path = layer_version_information['local_path'],
                             )
-            logger.warning("created new historical layer version %d", layer_copy.pk)
+            logger.info("created new historical layer version %d", layer_copy.pk)
 
             self.layer_version_built.append(layer_copy)
 
@@ -510,6 +510,12 @@ class ORMWrapper(object):
         errormsg = ""
         for p in packagedict:
             searchname = p
+            if p not in pkgpnmap:
+                logger.warning("Image packages list contains %p, but is"
+                               " missing from all packages list where the"
+                               " metadata comes from. Skipping...", p)
+                continue
+
             if 'OPKGN' in pkgpnmap[p].keys():
                 searchname = pkgpnmap[p]['OPKGN']
 
@@ -553,13 +559,20 @@ class ORMWrapper(object):
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
 
         if len(errormsg) > 0:
             logger.warn("buildinfohelper: target_package_info could not identify recipes: \n%s", errormsg)
@@ -1160,15 +1173,22 @@ class BuildInfoHelper(object):
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
+                except KeyError as e:
+                    logger.warn("KeyError in save_target_package_information"
+                                "%s ", e)
+
+                try:
                     self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
-                except KeyError:
-                    # we must have not got the data for this image, nothing to save
-                    pass
+                except KeyError as e:
+                    logger.warn("KeyError in save_target_file_information"
+                                "%s ", e)
+
 
 
 
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


