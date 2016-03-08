Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id D4D6D6FF6B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 18:09:09 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 08 Mar 2016 10:09:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,557,1449561600"; d="scan'208";a="932378027"
Received: from hkrasnod-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.2.56])
	by fmsmga002.fm.intel.com with ESMTP; 08 Mar 2016 10:09:08 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Mar 2016 18:09:02 +0000
Message-Id: <1457460542-17462-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: use force_bytes to display non-ascii project names
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
X-List-Received-Date: Tue, 08 Mar 2016 18:09:10 -0000

From: Sujith H <sujith.h@gmail.com>

When user enters a non-ascii character in the project
name of toaster, the build doesn't get triggered.
Use force_bytes to fix this.

Also deal with non-ascii project names when logging the
build request in runbuilds.

[YOCTO #9071]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py | 2 +-
 bitbake/lib/toaster/bldcontrol/models.py                        | 4 +++-
 bitbake/lib/toaster/orm/models.py                               | 5 ++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
index edf71a7..0bd5d08 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -47,7 +47,7 @@ class Command(NoArgsCommand):
                 logger.debug("runbuilds: No build env")
                 return
 
-            logger.debug("runbuilds: starting build %s, environment %s" % (br, bec.be))
+            logger.debug("runbuilds: starting build %s, environment %s" % (str(br).decode('utf-8'), bec.be))
 
             # write the build identification variable
             BRVariable.objects.create(req = br, name="TOASTER_BRBE", value="%d:%d" % (br.pk, bec.be.pk))
diff --git a/bitbake/lib/toaster/bldcontrol/models.py b/bitbake/lib/toaster/bldcontrol/models.py
index 9244ed1..9b2d0d0 100644
--- a/bitbake/lib/toaster/bldcontrol/models.py
+++ b/bitbake/lib/toaster/bldcontrol/models.py
@@ -1,5 +1,7 @@
+from __future__ import unicode_literals
 from django.db import models
 from django.core.validators import MaxValueValidator, MinValueValidator
+from django.utils.encoding import force_bytes
 from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build, Layer_Version
 
 # a BuildEnvironment is the equivalent of the "build/" directory on the localhost
@@ -94,7 +96,7 @@ class BuildRequest(models.Model):
         return self.brvariable_set.get(name="MACHINE").value
 
     def __str__(self):
-        return "%s %s" % (self.project, self.get_state_display())
+        return force_bytes('%s %s' % (self.project, self.get_state_display()))
 
 # These tables specify the settings for running an actual build.
 # They MUST be kept in sync with the tables in orm.models.Project*
diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 182d355..cfc6ea8 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -19,9 +19,12 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+from __future__ import unicode_literals
+
 from django.db import models, IntegrityError
 from django.db.models import F, Q, Avg, Max, Sum
 from django.utils import timezone
+from django.utils.encoding import force_bytes
 
 from django.core.urlresolvers import reverse
 
@@ -1628,7 +1631,7 @@ class LogMessage(models.Model):
     lineno = models.IntegerField(null=True)
 
     def __str__(self):
-        return "%s %s %s" % (self.get_level_display(), self.message, self.build)
+        return force_bytes('%s %s %s' % (self.get_level_display(), self.message, self.build))
 
 def invalidate_cache(**kwargs):
     from django.core.cache import cache
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


