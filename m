Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 5AF716FB0B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:35 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id l18so3798328wgh.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=PMyZ82M7Y4s9KSkZqd8dveNr/th6sBJHIKkcs/+PXEk=;
	b=FLS0pzQ82hOcjHEr5OlTf6fIh88cM6FNlwlGFhF1mIlob55a29soiY2dtWBOzQOzVK
	jbCjVW3sPpWHm00qHdAY5gG+f7OT/fYefA5Q95s8wsMr0t1/VbiDMiue0ebZFJVQTcHZ
	70lqnZdZMzK727W7Dsq2bCl4Ueec/ePWh7X7vtrMmbbIqRVNFkpE5w09ZWb7MlgCM3dc
	esENwEfNz2WKzvlDTQXgiR6BHo8cSzhNiyHWhQtsiosPpwnlTx7lPSxH+Qpaovnb5ixb
	5xsEUEq3JAWFlFCfWE2Rx6edH/mJYUcsc0Oi4tTkhmRNjLjus+CIRiVtpnL3Z2tAxf6c
	rdiQ==
X-Gm-Message-State: ALoCoQnqwkzjO2dZ3z3IQuy7avUt/otVwn6Ep25WRHB5ZOIIqGce2ZC333JuZf5UtzEG+e4oTVBX
X-Received: by 10.181.13.40 with SMTP id ev8mr18151281wid.0.1395686256067;
	Mon, 24 Mar 2014 11:37:36 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id r1sm41445148wia.5.2014.03.24.11.37.33
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C0576561515; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:20 +0000
Message-Id: <50e7f8f3bcfdd5b3e1b7778bfaaa93a563aba45d.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 10/18] toaster: apply filter only on selected attributes
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:35 -0000

From: Marius Avram <marius.avram@intel.com>

This fixes the filter from the main page: 'All builds' applied to the
table header. Once one is selected, the filter button for that respective
column will receive a title attribute which will show additional options
when you hover over it. Until now the additional option was active for
all filters buttons not only for the one selected. This also caused
malformed output in the case of the buttons which weren't among the
selected filter.

[YOCTO #5929]

Signed-off-by: Marius Avram <marius.avram@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/basetable_top.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 58b55b6..3fc0f31 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -77,7 +77,7 @@
                 {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })" >{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
                 {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
                 {%if tc.filter%}<div class="btn-group pull-right">
-                    <a href="#filter_{{tc.filter.class}}" role="button" class="btn btn-mini {%if request.GET.filter%}{{tc.filter.options|filtered_icon:request.GET.filter}} {%endif%}" {%if request.GET.filter%} title="<p>{{tc.filter.options|filtered_tooltip:request.GET.filter}}</p><p><a class='btn btn-small btn-primary' href=javascript:reload_params({'filter':''})>Show all {% if filter_search_display %}{{filter_search_display}}{% else %}{{objectname}}{% endif %}</a></p>" {%endif%} data-toggle="modal"> <i class="icon-filter filtered"></i> </a>
+                    <a href="#filter_{{tc.filter.class}}" role="button" class="btn btn-mini {%if request.GET.filter%}{{tc.filter.options|filtered_icon:request.GET.filter}} {%endif%}" {%if request.GET.filter and tc.filter.options|filtered_tooltip:request.GET.filter %} title="<p>{{tc.filter.options|filtered_tooltip:request.GET.filter}}</p><p><a class='btn btn-small btn-primary' href=javascript:reload_params({'filter':''})>Show all {% if filter_search_display %}{{filter_search_display}}{% else %}{{objectname}}{% endif %}</a></p>" {%endif%} data-toggle="modal"> <i class="icon-filter filtered"></i> </a>
                 </div>{%endif%}
             </th>{% endfor %}
         </tr>
-- 
1.8.3.2


