Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
	[74.125.82.174])
	by mail.openembedded.org (Postfix) with ESMTP id D82916F895
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:57 +0000 (UTC)
Received: by mail-we0-f174.google.com with SMTP id t60so10315575wes.33
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=eii9l4fT4BPTXXG8U9xJVXvGFgPXACPjwgSPutfZrnc=;
	b=IxjyL7bS3NbL4hbz83a0YjkMeo8V8DF2fUq8YrtjXJle+rjZrQUJEjPjL645h12IqY
	t5KGRkGsSkWmIA+ZsdTv898dFxChHtpoM/1otSCIM2tNjtiKnvQZTw4xlr+4/3PgGz28
	1VnmY4qkKospV553mFouYn94Ri7r5tNF/vaXndIq9GG/tQDS0JHWh8PWVvzeQeRUy4Ua
	egFAs7a+ecHGdLm8LmcOumVFNN30MTGLTdfiHu0KjDuo9dJerX3sx12T39QnAYmYwGh8
	ZgU/UjqvdTTOSlhSb9hSt4/9t3T0+2Z8XOjsoNx22wSVyczUya23/RhQawbe+pRTt42i
	3GDw==
X-Gm-Message-State: ALoCoQkOVp9GotfFmhaJXpTvZzoh3JseWkkHSIXnOUkztOjWPa+DqJM3a/pWz36sc3grdjrDngQl
X-Received: by 10.180.79.73 with SMTP id h9mr3644119wix.3.1394552998094;
	Tue, 11 Mar 2014 08:49:58 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id dk9sm62420173wjb.4.2014.03.11.08.49.55
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:56 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 3D460561908; Tue, 11 Mar 2014 15:49:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:52 +0000
Message-Id: <e84866b7aa5a1b272c81fde548f3c7828b036bb9.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
References: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394552757.git.alexandru.damian@intel.com>
References: <cover.1394552757.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 8/8] toaster: fix 'show all' labels for tasks and variables
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
X-List-Received-Date: Tue, 11 Mar 2014 15:49:59 -0000

From: David Reyna <David.Reyna@windriver.com>

Fix the 'Show all' button label to indicate 'variables' and 'tasks'
instead of the internal page label for the variables page and the
Disk I/O, CPU Usage, and Time pages.

[YOCTO #5915]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/basetable_top.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 0cd948c..e2549f7 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -79,7 +79,7 @@
                 {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })" >{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
                 {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
                 {%if tc.filter%}<div class="btn-group pull-right">
-                    <a href="#filter_{{tc.filter.class}}" role="button" class="btn btn-mini {%if request.GET.filter%}{{tc.filter.options|filtered_icon:request.GET.filter}} {%endif%}" {%if request.GET.filter%} title="<p>{{tc.filter.options|filtered_tooltip:request.GET.filter}}</p><p><a class='btn btn-small btn-primary' href=javascript:reload_params({'filter':''})>Show all {{objectname}}</a></p>" {%endif%} data-toggle="modal"> <i class="icon-filter filtered"></i> </a>
+                    <a href="#filter_{{tc.filter.class}}" role="button" class="btn btn-mini {%if request.GET.filter%}{{tc.filter.options|filtered_icon:request.GET.filter}} {%endif%}" {%if request.GET.filter%} title="<p>{{tc.filter.options|filtered_tooltip:request.GET.filter}}</p><p><a class='btn btn-small btn-primary' href=javascript:reload_params({'filter':''})>Show all {% if filter_search_display %}{{filter_search_display}}{% else %}{{objectname}}{% endif %}</a></p>" {%endif%} data-toggle="modal"> <i class="icon-filter filtered"></i> </a>
                 </div>{%endif%}
             </th>{% endfor %}
         </tr>
-- 
1.8.3.2


