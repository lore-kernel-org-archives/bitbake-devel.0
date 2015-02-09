Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id EEB93732D9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:16 +0000 (UTC)
Received: by mail-pa0-f50.google.com with SMTP id hz1so6536461pad.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=OaheLK04wdQUjNwgN6ddCtfpkjbqhYkmffgKPQtPCOw=;
	b=BIuThZN+nBFeK2J3e2GypcbqwN9egjkOkjKpjzQfg13RixzRBC7S7XL6y4X1H3QD/q
	A2QFB0waIWGqp/ETktxaOaZxF2aH/9mI+aLe9Ve/Nf2ebeTEiwwUGgnd8cjYzJhBp/uI
	s4DefBWNGn1WjeCiRCwiebrePb7g59OLh/SgGj7jRX7Xbf0ONWI7OWK03MKwuhOCsP83
	av+G+Qt/uxLU0gn+ANYTMdGfP1Fvkn5f4QR9dQBOsrE6bm5t/noUDSXaQ2aMzugeHd6H
	7/SwfJ0Wqy0idxWDha+HW07+h+4n6W2eCe619TeAKINzva6SWd0apuvAqra0AEU1/gL5
	x++A==
X-Gm-Message-State: ALoCoQnWe72kt75guW+qDtii+w7/JYaj2bMceMFBPkA42K2X2ALcKc/VnW7D2v0HAYFdz6/olmAz
X-Received: by 10.70.56.34 with SMTP id x2mr30893561pdp.127.1423504938126;
	Mon, 09 Feb 2015 10:02:18 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id c2sm16962631pbu.49.2015.02.09.10.02.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:17 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 2503F56618E; Mon,  9 Feb 2015 18:02:15 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:56 +0000
Message-Id: <97ef99ea5107543799ec2386b3840b435347edfb.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 26/27] toaster: All machines Fix filter counts
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:17 -0000

From: Michael Wood <michael.g.wood@intel.com>

Filter counts needed to take into account the filters that had
previously been applied.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 255b6a3..a7f58ad 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2814,11 +2814,6 @@ if toastermain.settings.MANAGED:
           queryset_all = queryset_all.exclude(layer_version__in=project_layers)
           by_pass_filter_string = True
 
-        selected_filter_count = {
-          'inprj' : queryset_all.filter(layer_version__in=project_layers).count(),
-          'notinprj' : queryset_all.exclude(layer_version__in=project_layers).count()
-        }
-
         # END FILTERS
 
         if by_pass_filter_string:
@@ -2834,13 +2829,16 @@ if toastermain.settings.MANAGED:
              queryset = queryset.exclude(layer_version__in=to_rm)
 
         machine_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
+        selected_filter_count = {}
+        selected_filter_count['inprj'] = queryset.filter(layer_version__in=project_layers).count()
+        selected_filter_count['notinprj'] = queryset.count() - selected_filter_count['inprj']
 
         context = {
             'objects' : machine_info,
             'project_layers' : project_layers,
             'objectname' : "machines",
             'default_orderby' : 'name:+',
-            'total_count': machine_info.paginator.count,
+            'total_count': queryset.count(),
 
             'tablecols' : [
                 {   'name': 'Machine',
-- 
1.9.1


