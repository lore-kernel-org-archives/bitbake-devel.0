Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A0D1A770C4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 13:44:46 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 06 Apr 2016 06:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,447,1455004800"; d="scan'208";a="926686766"
Received: from lmcenteg-mobl4.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.21.33])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2016 06:44:44 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 14:44:41 +0100
Message-Id: <1459950281-4625-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH] toaster: add rev dep column to image detail pages
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
X-List-Received-Date: Wed, 06 Apr 2016 13:44:47 -0000

From: Dave Lerner <dave.lerner@windriver.com>

Add a column to the custom image pages that shows the reverse
dependencies in a format matching the dependencies column:
  - either blank or a button showing the count of reverse dependencies,
  - when the button is clicked, a popover appears showing the list
    of reverse dependencies, with each package's size, and the total
    size of all of the reverse dependencies.

The implementation adds a packages table method to retreive the reverse
dependency total size, and adds a separate 'popover' html template. Both
of these changes follow the pattern for the dependencies column.

[YOCTO #9163]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/orm/models.py                          |  7 +++++++
 bitbake/lib/toaster/toastergui/tables.py                   |  6 ++++++
 .../templates/snippets/pkg_revdependencies_popover.html    | 14 ++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 bitbake/lib/toaster/toastergui/templates/snippets/pkg_revdependencies_popover.html

diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index d3277ef..e67b0d6 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -814,6 +814,13 @@ class Package_DependencyManager(models.Manager):
         """
         return self.all().aggregate(Sum('depends_on__size'))
 
+    def get_total_revdeps_size(self):
+        """ Returns the total file size of all the packages that depend on
+        this package.
+        """
+        return self.all().aggregate(Sum('package_id__size'))
+
+
     def all_depends(self):
         """ Returns just the depends packages and not any other dep_type """
         return self.filter(Q(dep_type=Package_Dependency.TYPE_RDEPENDS) |
diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 67a6592..c677ec5 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -725,6 +725,12 @@ class PackagesTable(ToasterTable):
                         static_data_template='\
                         {% include "snippets/pkg_dependencies_popover.html" %}')
 
+        self.add_column(title="Reverse dependencies",
+                        static_data_name="reverse_dependencies",
+                        static_data_template='\
+                        {% include "snippets/pkg_revdependencies_popover.html" %}',
+                        hidden=True)
+
         self.add_column(title="Recipe",
                         field_name="recipe__name",
                         orderable=True,
diff --git a/bitbake/lib/toaster/toastergui/templates/snippets/pkg_revdependencies_popover.html b/bitbake/lib/toaster/toastergui/templates/snippets/pkg_revdependencies_popover.html
new file mode 100644
index 0000000..453a9d0
--- /dev/null
+++ b/bitbake/lib/toaster/toastergui/templates/snippets/pkg_revdependencies_popover.html
@@ -0,0 +1,14 @@
+{# Popover that displays the reverse dependencies and sizes of a package 'data' used in the Packages table #}
+{% with data.package_dependencies_target.all_depends.count as dep_count %}
+{% load projecttags %}
+{% if dep_count %}
+ <a data-content="<ul class='unstyled'>
+   {% for dep in data.package_dependencies_target.all_depends|dictsort:'package.name' %}
+  <li>{{dep.package.name}} {% if dep.package.size > 0 %}({{dep.package.size|filtered_filesizeformat}}){% endif %}</li>
+    {% endfor %}
+  </ul>" title="" class="btn" data-original-title="
+  <strong>{{data.name}}</strong> reverse dependencies - <strong>{{data.package_dependencies_target.get_total_revdeps_size.package_id__size__sum|filtered_filesizeformat}}</strong>">
+    {{dep_count}}
+</a>
+{% endif %}
+{% endwith %}
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


