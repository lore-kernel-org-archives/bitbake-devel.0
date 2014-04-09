Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 8C29560EFA
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:41 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id bs8so9488506wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=O5tlUqIDap07zwvtEauzgpp8AIYIWGIgtuBt8DWwF7Y=;
	b=bxJSqOClw+czGDbHQuiB0csZHEL4/n0HuWw2mkJrFsbQNgs24k0Svvr4NP6YkNAUES
	QI5LhxClcC/ZrN0SiCCW2eh3sEw4T5kuUH7eExzNMq7VDeEPP/7514AQaLTdvq8cpjoB
	BuXLJKC7+OjQgKdEzm41jkdDDcZnmFdOtFxAezaaDkyWL4be+b9BaQrxPQ0E0n3gjIVa
	dIhmNzAsg3I15pIO85VKApD5W8OvyQcJF8E4unStWDQ8HXKMhZPqmN28Az2L6B4L0PgS
	qlyjAWlmeeBkMNhhFDRAByQNUsHA0hMxt3jXD17XIcIwrzT/GIMVnfCbvW8aklKrrgHS
	YJ2w==
X-Gm-Message-State: ALoCoQmXjHRwFy8TSzjjH+RlffFGuLjSvgQOKHLfC9RQ3yzqE3d/w5MVVSWRpA2xhTf17Y6impve
X-Received: by 10.194.122.6 with SMTP id lo6mr9691234wjb.38.1397049462811;
	Wed, 09 Apr 2014 06:17:42 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t18sm4342352wiv.16.2014.04.09.06.17.41
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:42 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 76CE85602D4; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:35 +0100
Message-Id: <1450de9793d7af8e8570ddc5a683edc8912405f1.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
References: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/9] toaster: keep number of rows across searches
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:44 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch will make Toaster remember the selected
number of rows to be displayed in tables across different
searches.

The number of rows setting will not be remembered if the
the user leaves the page and subsequently returns to it.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/basetable_top.html | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index f625901..22c3897 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -33,6 +33,7 @@
             <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{%endif%}
             <input type="hidden" name="orderby" value="{{request.GET.orderby}}">
             <input type="hidden" name="page" value="1">
+            <input type="hidden" name="count" value="{{request.GET.count}}">
             <button class="btn" type="submit" value="Search">Search</button>
         </form>
         <div class="pull-right">
-- 
1.9.1


