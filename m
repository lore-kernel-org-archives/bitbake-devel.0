Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5F8D4770F9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 09:08:54 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 22 Feb 2016 01:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; 
	d="scan'208,217";a="921077123"
Received: from mmisiak-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.233])
	by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2016 01:08:54 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 09:08:39 +0000
Message-Id: <a032a41417e3df5bdc36ee0ee215827b4b5cfa3d.1456131920.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
References: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
In-Reply-To: <cover.1456131920.git.elliot.smith@intel.com>
References: <cover.1456131920.git.elliot.smith@intel.com>
Subject: [PATCH 8/9] toaster: adjust the search field width
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
X-List-Received-Date: Mon, 22 Feb 2016 09:08:54 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The search field at the top of our tables was using one of the Bootstrap
classes for text field sizing. Those classes are a bit rigid, resulting
in text fields too wide that made other table controls wrap.

Setting a maximum width to the search form using one of the span classes,
combined with a % width css declaration, make for text fields that
adapt a bit better to the horizontal space available in each table.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/css/default.css       | 1 +
 lib/toaster/toastergui/templates/basetable_top.html | 4 ++--
 lib/toaster/toastergui/templates/toastertable.html  | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index ae9fa06..b024d96 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -114,6 +114,7 @@ th > a, th > span { font-weight: normal; }
 /* Styles for the navbar actions */
 .btn-group + .btn-group { margin-right: 10px; }
 .navbar-inner > .btn-group { margin-top: 6px; }
+[id^="search-input-"], #search { width: 80%; }
 
 /* Styles for the parent item in the left navigation */
 
diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 33ede66..0ddd749 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -161,8 +161,8 @@
 <!-- control header -->
 <div class="navbar">
     <div class="navbar-inner">
-        <form class="navbar-search input-append pull-left" id="searchform">
-            <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{%if request.GET.search %}{{request.GET.search}}{% endif %}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{%endif%}
+        <form class="navbar-search input-append pull-left span6" id="searchform">
+            <input id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{%if request.GET.search %}{{request.GET.search}}{% endif %}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{%endif%}
             <input type="hidden" name="orderby" value="{{request.GET.orderby}}">
             <input type="hidden" name="page" value="1">
             <button class="btn" id="search-button" type="submit" value="Search">Search</button>
diff --git a/lib/toaster/toastergui/templates/toastertable.html b/lib/toaster/toastergui/templates/toastertable.html
index 4cd1b42..21c3d36 100644
--- a/lib/toaster/toastergui/templates/toastertable.html
+++ b/lib/toaster/toastergui/templates/toastertable.html
@@ -46,9 +46,9 @@
   <!-- control header -->
   <div class="navbar" id="table-chrome-{{table_name}}">
     <div class="navbar-inner">
-      <div class="navbar-search input-append pull-left">
+      <div class="navbar-search input-append pull-left span6">
 
-        <input class="input-xxlarge" id="search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{%if request.GET.search%}{{request.GET.search}}{%endif%}"/>
+        <input id="search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{%if request.GET.search%}{{request.GET.search}}{%endif%}"/>
         <a href="#" style="display:none" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
           <i class="icon-remove"></i>
         </a>
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


