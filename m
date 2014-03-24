Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id C802F6FB0B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:33 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id bs8so2707649wib.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=SYVcqkZqpL0OPuIhx658i0CXRjRmSofkG696r1ktCzU=;
	b=TgL7TxgCCSOxxI4mW00BoCbAqYWevkEGzO2Z+SjOMFGlCRkr+wOa0i2sVSt6mLWWiA
	0hdImBhha/E02Mz4VAJsVQ/YlbVJIO5qgQtdouOhtmvw1YhFIeRZ46tOT3WSnZHFJ+X0
	PF6goSpAcoDZhm28+eZA4taU+DFZRtDzKaoqiDDU69wn5tNbk9iLVtmP4uxhndjo6U8E
	8mNMGQdvpKW64U0oQurUTPrDKB2THh0Se5hL17Xrm+8Atgh6z98LB1lyo5E0j9nOfuJs
	IDQcgs33MXs9PCT37wFjumYc6w6IMsqPYFBPmpBlAUm76HFWWuGh30yHrQWINZG6KNQf
	cFYA==
X-Gm-Message-State: ALoCoQk3M2IRNL5CLAg2kJPO6K6wTfbifGwTRS0Y8VDh1tyRjEh5lGFyM2SrDNwQcvJKRpVwAKBT
X-Received: by 10.180.36.226 with SMTP id t2mr2220176wij.37.1395686254203;
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	qg3sm41446972wic.10.2014.03.24.11.37.32 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:33 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B85A55612EE; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:16 +0000
Message-Id: <54ec8dfe779bc20d5aaeeeeb768da8412e5dfd0f.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Subject: [PATCH 06/18] toaster: Fix alignment issue in searchform
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:36 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The search form in basetable_top.html had a small alignment
issue between the search text field and the search button.
This change aligns the elements correctly.

Whitespace fix by Alex Damian.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/basetable_top.html | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 9df3647..58b55b6 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -30,12 +30,10 @@
 <div class="navbar">
     <div class="navbar-inner">
         <form class="navbar-search input-append pull-left" id="searchform">
-	<div class="input-append" style="padding-right:1em">
             <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on"><i class="icon-remove"></i></a>{%endif%}
-	</div>
-	    <input type="hidden" name="orderby" value="{{request.GET.orderby}}">
-	    <input type="hidden" name="page" value="1">
-            <input class="btn" type="submit" value="Search"/>
+            <input type="hidden" name="orderby" value="{{request.GET.orderby}}">
+            <input type="hidden" name="page" value="1">
+            <button class="btn" type="submit" value="Search">Search</button>
         </form>
         <div class="pull-right">
 {% if tablecols %}
-- 
1.8.3.2


