Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 1834375692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:15:51 +0000 (UTC)
Received: by wgv5 with SMTP id 5so37771149wgv.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pSNSxHzvg9S/0FbVyeY9PFy89ebqbWbvGfouBxg8blw=;
	b=btnUBfNk6M4GFls9m7+Ry9Sn3fGW6bxXGHJ7tKv0c/bEKaOvYo1Zvwx6FrS5eulgQ/
	1/gcCC5+jTh++xV42GotwiywwKPYv66DeWbAwcu0iQPRW/cA9zyll5c+BDe/zHKTWCSQ
	49/rgu8KAU9paZSR/eL9rR8E4w8VhWcCgAcLDPzCfJA9RDRsuNw+sfA01F36BrBfej4F
	NKOkqHb4yrVUcRAd3PDLcGk+7pAVHbsptT3EDVaC4KYAuxWllXG7lHMV1TgS8y9DeyBD
	XFMbnMcqBlZhv4kc9NovWh7hoRyFPIl5lhHr13Jiq16WxPr2dvY+AaQWqkWgZDvSHXW1
	YlyQ==
X-Gm-Message-State: ALoCoQmGA8wP7PAMPBeo6ehO855MJfUV8pGhllJLfIXtuNnBY7YWH7clKALoFYTjC/v1jylaeRMP
X-Received: by 10.194.23.66 with SMTP id k2mr5672229wjf.18.1432822551964;
	Thu, 28 May 2015 07:15:51 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id r9sm3559358wjo.26.2015.05.28.07.15.50
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:15:51 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C180356124B; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:02 +0100
Message-Id: <785d23956c7448fea284f753cd85fe3ac1d38ee7.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 08/22] toaster: Add a simplified ToasterTable template
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
X-List-Received-Date: Thu, 28 May 2015 14:15:51 -0000

From: Michael Wood <michael.g.wood@intel.com>

This is like the normal ToasterTable template but with a number of
features removed such as edit columns and has a lower profile compared
to the "main" tables.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../toastergui/templates/toastertable-simple.html  | 112 +++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 lib/toaster/toastergui/templates/toastertable-simple.html

diff --git a/lib/toaster/toastergui/templates/toastertable-simple.html b/lib/toaster/toastergui/templates/toastertable-simple.html
new file mode 100644
index 0000000..98cad64
--- /dev/null
+++ b/lib/toaster/toastergui/templates/toastertable-simple.html
@@ -0,0 +1,112 @@
+
+{% load static %}
+{% load projecttags %}
+
+<script src="{% static 'js/table.js' %}"></script>
+<script src="{% static 'js/layerBtn.js' %}"></script>
+<script>
+  $(document).ready(function() {
+    (function(){
+
+    var ctx = {
+      tableName : "{{table_name}}",
+      url : "{{ xhr_table_url }}",
+      title : "{{title}}",
+      projectLayers : {{projectlayers|json}},
+    };
+
+    try {
+      tableInit(ctx);
+    } catch (e) {
+      document.write("Problem loading table widget: " + e);
+    }
+    })();
+  });
+</script>
+
+<!-- filter modal -->
+<div id="filter-modal" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="false">
+  <form id="filter-modal-form" style="margin-bottom: 0px">
+    <div class="modal-header">
+      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
+      <h3 id="filter-modal-title">&nbsp;</h3>
+    </div>
+    <div class="modal-body">
+      <p>Show:</p>
+      <span id="filter-actions"></span>
+    </div>
+    <div class="modal-footer">
+      <button class="btn btn-primary" type="submit">Apply</button>
+    </div>
+  </form>
+</div>
+<button id="clear-filter-btn" style="display:none"></button>
+
+<div class="row-fluid" id="no-results-{{table_name}}" style="display:none">
+  <div class="alert">
+    <form class="no-results input-append">
+      <input class="input-xlarge" id="new-search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{{request.GET.search}}"/>
+      <a href="#" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
+        <i class="icon-remove"></i>
+      </a>
+      <button class="btn search-submit-{{table_name}}" >Search</button>
+      <button class="btn btn-link remove-search-btn-{{table_name}}">Show {{title|lower}}
+      </button>
+    </form>
+  </div>
+</div>
+
+
+<div id="table-container-{{table_name}}">
+  <!-- control header -->
+  <div class="row-fluid" id="table-chrome-{{table_name}}">
+      <div class="navbar-search input-append pull-left">
+
+        <input class="input-xlarge" id="search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{{request.GET.search}}"/>
+        <a href="#" style="display:none" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
+          <i class="icon-remove"></i>
+        </a>
+        <button class="btn" id="search-submit-{{table_name}}" >Search</button>
+      </div>
+
+      <div class="pull-right">
+
+        <div style="display:inline">
+          <span class="divider-vertical"></span>
+          <span class="help-inline" style="padding-top:5px;">Show rows:</span>
+          <select style="margin-top:5px;margin-bottom:0px;" class="pagesize-{{table_name}}">
+            {% with "10 25 50 100 150" as list%}
+            {% for i in list.split %}
+            <option value="{{i}}">{{i}}</option>
+            {% endfor %}
+            {% endwith %}
+          </select>
+        </div>
+      </div>
+  </div>
+
+  <!-- The actual table -->
+  <table class="table table-bordered table-hover tablesorter" id="{{table_name}}">
+    <thead>
+      <tr><th></th></tr>
+    </thead>
+    <tbody></tbody>
+  </table>
+
+  <!-- Pagination controls -->
+  <div class="pagination pagination-centered">
+    <ul id="pagination-{{table_name}}" class="pagination" style="display: block-inline">
+    </ul>
+
+    <div class="pull-right">
+      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
+      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize-{{table_name}}">
+        {% with "10 25 50 100 150" as list%}
+        {% for i in list.split %}
+        <option value="{{i}}">{{i}}</option>
+        {% endfor %}
+        {% endwith %}
+      </select>
+    </div>
+  </div>
+</div>
-- 
1.9.1


