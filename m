Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 3407070472
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 16:55:28 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id y10so2969221wgg.34
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 09:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=e0lEqoVqJqIqsYWJjXMlaGV7TItZ/q+d1kcqKtI9V8M=;
	b=R2uxhjMjmquvqO43XmolGVM17DJiFpnnWo0jv2IdYIGIq4QooF631rvRvdRVZqqvL0
	KspEFPe+x2qonwNppvPuhNJiO2CMHyQfA3ZgffSg/3RNfs484Ls5Z+OpYCs6CjSMSa4d
	fEYJlVtI8DtsS9ayrWXDzQy3TXLt875nyDGIpvmIjB36taRJsAkk+ABso51pFTf2g3mV
	4p7bf+UkE3eB/9D0vMT3qF6+08Nh0t0ebnWLTkQEGS81tLQihQCIXaNT7l41ilpfAAsG
	MeHdh9Y5sv1M+Lu2pUnJ/aLE8zsFouSxkpXleG3v11GKxxZoFvhCwbJFSPNZZaUjXxPf
	6vbA==
X-Gm-Message-State: ALoCoQkKR+WMhuIlKQIjkWJx0QLHQoy4mefve3iwqJGQvZBthsLW9gFzMAjanpQvkFsoNlEgbaDt
X-Received: by 10.194.71.12 with SMTP id q12mr50028384wju.5.1404924929202;
	Wed, 09 Jul 2014 09:55:29 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hi2sm104489278wjb.29.2014.07.09.09.55.27 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Jul 2014 09:55:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8E028560126; Wed,  9 Jul 2014 17:55:26 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Jul 2014 17:55:17 +0100
Message-Id: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1404924713.git.alexandru.damian@intel.com>
References: <cover.1404924713.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/9] toaster: remove strftime calls in filters
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
X-List-Received-Date: Wed, 09 Jul 2014 16:55:29 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We remove the unneeded strftime calls in filters, as the
filters can deal directly with datetime types.

[YOCTO #6379]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 68e981a..1f3e11d 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -301,9 +301,9 @@ def builds(request):
                  'filter' : {'class' : 'started_on',
                              'label': 'Show:',
                              'options' : [
-                                         ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now().strftime("%Y-%m-%d")).count()),
-                                         ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d")).count()),
-                                         ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d")).count()),
+                                         ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now()).count()),
+                                         ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                         ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7))).count()),
                                          ]
                             }
                 },
@@ -315,9 +315,9 @@ def builds(request):
                  'filter' : {'class' : 'completed_on',
                              'label': 'Show:',
                              'options' : [
-                                         ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now().strftime("%Y-%m-%d")).count()),
-                                         ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d")).count()),
-                                         ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d")).count()),
+                                         ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now()).count()),
+                                         ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                         ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7))).count()),
                                          ]
                             }
                 },
-- 
1.9.1


