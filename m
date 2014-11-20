Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 1567B6B7CA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:38 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id kq14so2846875pab.34
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=2uP0/wpV+D9GOlHcttKe7a+XRGlnAb0SdiiJscDb010=;
	b=PmzcEzrgf4/J1OaltAGlydtTv0m7rQVj8cC8gAzQ43CocXiE5O9NtJk7YDru8KB8F2
	A5tdShPmoFyibrX9ityoRJnsPnIDYhLwoRLpE1XwEw07W7z/mR0i9Qtvw9GveQ4aL13k
	7BBgArv/AErwUKIKCY5Kw5hPrt1m8YycZgBoNcQRlz661hbgBCxGJC+H1AvqDnxBv6Sq
	6eEM4M7utw/X/GTK82V/wbiy6HX4CgnERk/vqHnlISyta7VoGyjtyW4q89QjYThEKPyF
	P0LfqVsQBsl2D1GWwCfo2j4geT53sRDRscfO3qXCIiBJMGbML/6g69ExMN1M26H6ONMR
	OGtg==
X-Gm-Message-State: ALoCoQlUYcjufHyTJM+QM9a5o/CNEliVcvrNs386XGR7PAN8J5R1Rq2wtkzDKXbSO11hbXiWithe
X-Received: by 10.68.68.197 with SMTP id y5mr40614641pbt.82.1416500859670;
	Thu, 20 Nov 2014 08:27:39 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id u8sm2503655pdr.10.2014.11.20.08.27.36
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:38 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 86A60564120; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:25 +0000
Message-Id: <c67a5dd8026833e167c58a17643febee130dbb35.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 09/11] toaster: add no results state to all layers page
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

When you search for a layer and your search returns no results,
we should show you an alert and a link to show back all layers,
as we do in all other tables.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
---
 lib/toaster/toastergui/templates/layers.html | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index 2bca84b..e9f910f 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -23,6 +23,18 @@
   <div id="zone1alerts">
   </div>
 
+{% if objects.paginator.count == 0 %}
+  <div class="row-fluid">
+      <div class="alert">
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all layers</button>
+        </form>
+      </div>
+  </div>
+
+{% else %}
 
 {% include "basetable_top_layers.html" %}
     {% for o in objects %}
@@ -264,4 +276,6 @@ $(document).ready(function (){
 </script>
 {%endif%}
 
+{%endif%}
+
 {% endblock %}
-- 
1.9.1


