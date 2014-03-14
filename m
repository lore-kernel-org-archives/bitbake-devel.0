Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by mail.openembedded.org (Postfix) with ESMTP id EF7A96F84C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:05 +0000 (UTC)
Received: by mail-we0-f171.google.com with SMTP id t61so2459168wes.30
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=mrwkJyYxravAuIjzTPfIydCk2q/ye/senfSK8uKuedE=;
	b=L7UmTiKdwP4Zza9f2GJj5k591R7xxbTwpwbENWNPLnN5kQRt7HXle3xfkytxNAJuQ9
	qzHnm5OIchNqmZTUX8VRDh0l6KgO7ZGXSQOuuwCWtS/MyffkCQQPbYA1FuS0rZwTxryU
	OQIFR03KWPhW9GS49Z3FySdxXrkHMLffpfDW0uyfYvbdKhO6piTzlmuRGKoGsnCWttHU
	UJWPQwE4GwaRlKi5cYbjmMtQGfruhGE8SRKiypejycWjVws8OPU6z0vm36XqWk7AuYAw
	nbMgSqtwQ4I+fgFQrgyz7F+gGaPe6ry/k38bVtIKooEZ6qIt0O1GzQ7Q2mIl1O49imK6
	ApDA==
X-Gm-Message-State: ALoCoQnfCAOfoIRQ8nPigfQsJZnYLImZJSS83lRzWCYqBJ5C4U0ZoKfJArkPUcIwCM/WzfbDRodF
X-Received: by 10.180.23.99 with SMTP id l3mr7229034wif.47.1394819946107;
	Fri, 14 Mar 2014 10:59:06 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t6sm36755398wix.4.2014.03.14.10.59.03
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:04 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 131C8561120; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:48 +0000
Message-Id: <4ada4307623c1e27b589831d359dc6351e6e3ad5.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 07/19] toaster: Small tweaks to the no results page
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:08 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Correctly align the Search button to the text input field,
add .btn class to the clear search button, replace the
placeholder attribute with the value attribute so that you
can edit your search query, remove the clear search button
from the tab index so that you don't clear the search by
mistake and edit the margins of the .no-results class.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>

Conflicts:
	bitbake/lib/toaster/toastergui/templates/build.html
---
 lib/toaster/toastergui/static/css/default.css |  2 +-
 lib/toaster/toastergui/templates/build.html   | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 76d6cb9..2b47aff 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -102,7 +102,7 @@ select { width: auto; }
 .progress { margin-bottom: 0px; }
 .lead .badge { font-size: 18px; font-weight: normal; border-radius: 15px; padding: 9px; }
 .well > .lead, .alert .lead { margin-bottom: 0px; }
-.no-results { margin: 10px 0 0; }
+.no-results { margin: 10px 0; }
 .task-name { margin-left: 7px; }
 
 
diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index 85de98a..f0ef4d4 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -68,13 +68,11 @@
  {% if objects.paginator.count == 0 %}
   <div class="row-fluid">
       <div class="alert">
-      <form class="no-results" id="searchform">
-          <div class="input-append">
-              <input id="search" name="search" class="input-xxlarge" type="text" placeholder="{{request.GET.search}}" />{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on"><i class="icon-remove"></i></a>{% endif %}
-              <input class="btn" type="submit" value="Search"/>
-              <button class="btn btn-link" onclick="javascript:reload_params({'search':'', 'filter':''})">Show all builds</button>
-          </div>
-      </form>
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:reload_params({'search':'', 'filter':''})">Show all builds</button>
+        </form>
       </div>
   </div>
 
-- 
1.8.3.2


