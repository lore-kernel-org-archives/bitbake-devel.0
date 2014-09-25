Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id D8516609B2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 14:10:33 +0000 (UTC)
Received: by mail-wg0-f44.google.com with SMTP id z12so4113721wgg.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Sep 2014 07:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=+jUJ0udnPif7nKCRyv0k9VmN4cr5dazlpmJp++bH8Mo=;
	b=HFqKiPpK7LGy4HGBp+a5KNGDXdSHah6gMYEbC7GsRQIn6FOuRkR6SSQhKgajOwzcWQ
	lYXb440n71f222sM5oT9wBmxVGE5iV4ihi5hamXTygJ8JghKesAFOS3cqZ2yxtC/K85h
	tXT07gccFVa2yz5vYcXhXFUu2UPlYMvOsQt0Z/1Wt8912OyNbmyxRoDv/8DVGnXjrYF3
	dblwSwHwRH/OjRwc9f06NP63QOkeK/UvvxUmtw3E3PSIa/aMT4uvHc1KBZih+uISSz08
	B2FOUmYXx25p3plmrlHSA3XqEy3Bo4w9F8anLXVRix/N7GfAjTaGacxfzj0PBrBvTp9j
	vp9g==
X-Gm-Message-State: ALoCoQlUN7fQNOtDVv1W22QNm4jl117VLUodA18mm6YyNe5BdGOAgkBsqLBK/do2jlaNoVYY6ThI
X-Received: by 10.180.91.70 with SMTP id cc6mr19723952wib.66.1411654234563;
	Thu, 25 Sep 2014 07:10:34 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ic8sm2848087wjb.25.2014.09.25.07.10.33
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Sep 2014 07:10:33 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id AB46456211D; Thu, 25 Sep 2014 16:10:34 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Sep 2014 16:10:33 +0100
Message-Id: <1411657833-11304-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH] toastergui fix size rendering in dirinfo page
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
X-List-Received-Date: Thu, 25 Sep 2014 14:10:35 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We fix the rendering of the size field in dirinfo-related pages
by directly calling filtered_filesizeformat and not rendering
it through the template engine.

Additionally, we enable error dumping into logs if an
Exception happens.

[YOCTO #6669]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index defbbbf..ea81423 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -742,7 +742,6 @@ class LazyEncoder(json.JSONEncoder):
         return super(LazyEncoder, self).default(obj)
 
 from toastergui.templatetags.projecttags import filtered_filesizeformat
-from django import template
 import os
 def _get_dir_entries(build_id, target_id, start):
     node_str = {
@@ -797,9 +796,7 @@ def _get_dir_entries(build_id, target_id, start):
                 # don't use resolved path from above, show immediate link-to
                 if o.sym_target_id != "" and o.sym_target_id != None:
                     entry['link_to'] = Target_File.objects.get(pk=o.sym_target_id).path
-            t = template.Template('{% load projecttags %} {{ size|filtered_filesizeformat }}')
-            c = template.Context({'size': o.size})
-            entry['size'] = str(t.render(c))
+            entry['size'] = filtered_filesizeformat(o.size)
             if entry['link_to'] != None:
                 entry['permission'] = node_str[o.inodetype] + o.permission
             else:
@@ -808,7 +805,10 @@ def _get_dir_entries(build_id, target_id, start):
             entry['group'] = o.group
             response.append(entry)
 
-        except:
+        except Exception as e:
+            print "Exception ", e
+            import traceback
+            traceback.print_exc(e)
             pass
 
     # sort by directories first, then by name
-- 
1.9.1


