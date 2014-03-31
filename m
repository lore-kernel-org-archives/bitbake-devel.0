Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by mail.openembedded.org (Postfix) with ESMTP id 87C646F8BC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:18 +0000 (UTC)
Received: by mail-we0-f179.google.com with SMTP id x48so4978331wes.38
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=N1peQMCZG6PfzsHWTeFObnz8jNVjaJIJl/mvBd1x6cM=;
	b=AaxXCupwW/JqTnhYr32cBk33NcYeD2YsVvQmuFK8PFliBshsgVnnXsWMoOEYxs/NDA
	4YeQ1h0d9Toai520IGAz7DwWyGt4zuNC4hyIf4ZgHzAOiNkZXJEEzlnWHbeH8jUNWHFJ
	WRWHCScNaTgO1+QPpJsp++/B3/RQ4GmYrSeZRoB7q016X7/YQq+Ffftx9ROs2MJaqcem
	Jxq2TzLw9xwDiFrHWfA5JW97q/YwrYDQ0j4LaGbQMBc4BaqDSbFTNkXQvDsk0r8IeLHK
	STw8RyDpHDLl+cD9ynTsqt1CQQ0URKbBUmXnOxB1kCDGJ1Un7N4APv4cJTWWMEGmNLa9
	PgKQ==
X-Gm-Message-State: ALoCoQlI0jXlFTC0PcLUdRu8aS+vRp0nbrxi3VAcaisaR6jDKorOhESfgoxebfO8/dx7NqktXhcE
X-Received: by 10.180.87.164 with SMTP id az4mr13681561wib.2.1396284438959;
	Mon, 31 Mar 2014 09:47:18 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id u1sm13863743wjx.16.2014.03.31.09.47.16
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1A4DA560408; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:11 +0100
Message-Id: <05b781740f1a48bc9312d411352fe7ffa30b343c.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Subject: [PATCH 11/14] toaster: Match search results form to no results form
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:19 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the search results form, add the btn class to the clear
search button and set its tabindex to -1 so that you don't
accidentally clear the search when you want to search
again.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/basetable_top.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 3fc0f31..f625901 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -30,7 +30,7 @@
 <div class="navbar">
     <div class="navbar-inner">
         <form class="navbar-search input-append pull-left" id="searchform">
-            <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on"><i class="icon-remove"></i></a>{%endif%}
+            <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{%endif%}
             <input type="hidden" name="orderby" value="{{request.GET.orderby}}">
             <input type="hidden" name="page" value="1">
             <button class="btn" type="submit" value="Search">Search</button>
-- 
1.9.1


