Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 1DE65714C0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Sep 2014 16:45:24 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id l18so10258907wgh.34
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Sep 2014 09:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=/sXCx4zudtIo5omuq9WoRlww7jqtykrTdzvQtXp1neM=;
	b=T9rW3pEC1elnBZfFE+tUOsZK0PdHmt5UnhrtCJnmh0hHFemnlkBgop/o/Y1yIp1KGb
	9hO1urhv2y1PlMvjfEuG99qx+siOhRIwQu25hIbMjuf3n0/ZRGxKHeFNvE4u+rlJgFql
	ulS+m9cOH7EtfwLB4t1UUA8h9WmKWz78TeWd5BJB+xPEHuh3DoyEtujMcp8ZOLZx9re3
	GewCxLSll5DjiqvaDUc53TpgbJxswnx6wdNUBWXQZfPWr13SntFWrATLvjGQg66jK0ov
	LZa3kGCNs58ac8JwFoMq+q49+xxcjSTcn2QAgj5Ra2F40EZWHOPViy5Ns+X9icdN3gBU
	/PKQ==
X-Gm-Message-State: ALoCoQmt5jbjbtEcH3a932tfXEyPQmGOsG8X0FtWjbIJZHW1cvtHHjMtE3qsAINOEWRQG7IW2a7I
X-Received: by 10.180.184.20 with SMTP id eq20mr7061889wic.61.1409849122233;
	Thu, 04 Sep 2014 09:45:22 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ua8sm20025520wjc.7.2014.09.04.09.45.20
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Sep 2014 09:45:21 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 87B355626C4; Thu,  4 Sep 2014 17:45:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  4 Sep 2014 17:45:17 +0100
Message-Id: <cdaea8951df6b707afd1fefbf22295088256dd6f.1409848901.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
References: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409848901.git.alexandru.damian@intel.com>
References: <cover.1409848901.git.alexandru.damian@intel.com>
Subject: [PATCH 6/6] toaster: fix some code spacing issues
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
X-List-Received-Date: Thu, 04 Sep 2014 16:45:25 -0000

From: Marius Avram <marius.avram@intel.com>

Code is related to the basetable templates files.
It had mixed tabs and spaces and was miss aligned in various places,
making it hard to read.

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 .../toastergui/templates/basetable_bottom.html     | 39 +++++++++++-----------
 .../toastergui/templates/basetable_top.html        |  9 ++---
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basetable_bottom.html b/lib/toaster/toastergui/templates/basetable_bottom.html
index cbdc164..e6b9506 100644
--- a/lib/toaster/toastergui/templates/basetable_bottom.html
+++ b/lib/toaster/toastergui/templates/basetable_bottom.html
@@ -23,13 +23,14 @@
 {%endif%}
   </ul>
   <div class="pull-right">
-                            <span class="help-inline" style="padding-top:5px;">Show rows:</span>
-                            <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
-  {% with "2 5 10 25 50 100" as list%}
-    {% for i in list.split %}<option value="{{i}}">{{i}}</option>
-    {% endfor %}
-  {% endwith %}
-                            </select>
+    <span class="help-inline" style="padding-top:5px;">Show rows:</span>
+    <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+      {% with "2 5 10 25 50 100" as list%}
+        {% for i in list.split %}
+            <option value="{{i}}">{{i}}</option>
+        {% endfor %}
+      {% endwith %}
+    </select>
    </div>
 </div>
 
@@ -40,21 +41,21 @@
 
     // we load cookies for the column display
     save = $.cookie('_displaycols_{{objectname}}');
-		if (save != undefined) {
-    setting = save.split(';');
-    for ( i = 0; i < setting.length; i++) {
-        if (setting[i].length > 0) {
-            splitlist = setting[i].split(':');
-            id = splitlist[0], v = splitlist[1];
-            if (v == 'true') {
-                $('.chbxtoggle#'+id).prop('checked', true);
-            }
-            else {
-                $('.chbxtoggle#'+id).prop('checked', false);
+    if (save != undefined) {
+        setting = save.split(';');
+        for ( i = 0; i < setting.length; i++) {
+            if (setting[i].length > 0) {
+                splitlist = setting[i].split(':');
+                id = splitlist[0], v = splitlist[1];
+                if (v == 'true') {
+                    $('.chbxtoggle#'+id).prop('checked', true);
+                }
+                else {
+                    $('.chbxtoggle#'+id).prop('checked', false);
+                }
             }
         }
     }
-    }
 
     // load cookie for number of entries to be displayed on page
     pagesize = $.cookie('count');
diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 037554b..e43eb2c 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -211,10 +211,11 @@
                 <span class="divider-vertical"></span>
                 <span class="help-inline" style="padding-top:5px;">Show rows:</span>
                 <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
-  {% with "2 5 10 25 50 100" as list%}
-{% for i in list.split %}                    <option value="{{i}}">{{i}}</option>
-    {% endfor %}
-  {% endwith %}
+                  {% with "2 5 10 25 50 100" as list%}
+                    {% for i in list.split %}
+                        <option value="{{i}}">{{i}}</option>
+                    {% endfor %}
+                  {% endwith %}
                 </select>
            </div>
         </div>
-- 
1.9.1


