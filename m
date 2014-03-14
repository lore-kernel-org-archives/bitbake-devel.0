Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id AEAD66EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:10 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id w61so2406520wes.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=aJD/Jg0ioSFDclg5/AcL/aswiXbiNsjDympE6iJ+cRM=;
	b=J8HYAxXj5hkWDheVfCBpxX+EUU9hCchqAst1XFxrrfuvlGnFISwYo2PLZxEw/JHswn
	pGJetS7kKvOYuA8F6f0DRbKELaPkMGJbEC3WjA79obWthjgjpxwzuJMf6v4wi3tE/c5x
	RLragec7bmbrXjk4dRZLcaJZ3dPQVKMadTQEdLqeihhzQWSaKBRYybtBMIrgkvbOSKKQ
	LO9muOnVV+9gI9cQ56hRHqKfNVFKM27oGAFmwQ/ODRyaLZO8bEIO1/OEYkn0CLdRcsgc
	YkJ5fxLk9qrB1FW4XO/86psGZXlzGMee53hhElXYeY9HTHnItY4nRSi8ZSV+FQiRkJt5
	SCqg==
X-Gm-Message-State: ALoCoQlyP/Z2TuKKq8vVkY4vb161cqxntXk2O6SGRUyCCcaPhadyPVECKEBluRQHJEFkoaEdCd1f
X-Received: by 10.194.19.161 with SMTP id g1mr7584666wje.20.1394819951194;
	Fri, 14 Mar 2014 10:59:11 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id 19sm15544785wjy.17.2014.03.14.10.59.06
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 2641C5612B2; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:58 +0000
Message-Id: <393b3fbcdfc85eee29a4dbc2d823a6e17d450cf8.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 17/19] toaster: Remove the data-toggle attribute
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:11 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Help icons with the .get-help class do not need the
data-toggle attribute. That attribute initialises the
Bootstrap tooltips, but they are already initialised
in main.js for any element with the .get-help class.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/basetable_top.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index e2549f7..9df3647 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -75,7 +75,7 @@
         <!-- Table header row; generated from "tablecols" entry in the context dict -->
         <tr>
             {% for tc in tablecols %}<th class="{{tc.dclass}} {{tc.clclass}}">
-                {%if tc.qhelp%}<i class="icon-question-sign get-help" data-toggle="tooltip" title="{{tc.qhelp}}"></i>{%endif%}
+                {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
                 {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })" >{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
                 {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
                 {%if tc.filter%}<div class="btn-group pull-right">
-- 
1.8.3.2


