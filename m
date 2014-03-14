Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id E42276F805
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:03 +0000 (UTC)
Received: by mail-wg0-f42.google.com with SMTP id y10so2424636wgg.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=3nJPX4ikxs3TcSqUIQDscNtx/5lQczFzgQVdq5g8I3I=;
	b=YtalhQ3zZu03CB3SuY03vvubnsg9kd6m3VF6NiURUjeO3HJfKIh+6+UCkL8VAMI0ox
	+b7QpiCAtQhJAngLK3uyEhUKyegOMLgLakvv5+y1UeOoxsQjhQLfPbOK5vARd/zJZpOH
	gUrXcwp5Q3iRgmMNtr+HhppBED9xxmsR6SQcNFwL3hqp6I/G9G8D+A/uSsabtmWBfWnE
	xoOGHRa9uxD3+JeY3Pq2FuANd82RDOfwF5UOHYt9/36F9Xjk+VakBH0swN5FvDHC8Kv9
	yxuDZGWk6a58fEv8qW2k1ydgYT6Jwdpn0ox+go71y0JtNBWuKrkVg4kuJ42iyEyqvki0
	zFKg==
X-Gm-Message-State: ALoCoQnYGZn2xGh7s9GiV8cFkvLs0lDr3LG6RsXirMrqscVuLjcCw3JZR8WkCOw6YmmImpxtYKzv
X-Received: by 10.180.104.103 with SMTP id gd7mr7217722wib.21.1394819944328;
	Fri, 14 Mar 2014 10:59:04 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id hy8sm15580163wjb.2.2014.03.14.10.59.01
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0D977561085; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:45 +0000
Message-Id: <a928e0cfb82dac0eb920913e3f9c5b45e3dcdf2f.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 04/19] toaster: Make Order column part of the minimum table
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:04 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The Order column in the tasks table should be always shown and
be part of the minimum table (i.e. its checkbox should be
disabled in the Edit columns menu). Changing views.py to
make sure this is the case.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7f61ade..bf7f2c8 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -514,7 +514,7 @@ def tasks_common(request, build_id, variant):
         'clclass': 'order', 'hidden' : 1,
         'orderfield':_get_toggle_order(request, "order"),
         'ordericon':_get_toggle_order_icon(request, "order")}
-    if 'tasks' == variant: tc_order['hidden']='0';
+    if 'tasks' == variant: tc_order['hidden']='0'; del tc_order['clclass']
     tc_recipe={
         'name':'Recipe',
         'qhelp':'The name of the recipe to which each task applies',
-- 
1.8.3.2


