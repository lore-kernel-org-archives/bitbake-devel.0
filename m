Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 482A075645
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:33 +0000 (UTC)
Received: by wibdq8 with SMTP id dq8so49784880wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=+HBKXmY4Bn3auCxBfMr8bf1zlyP8S18qfyAXhZYzQoI=;
	b=cpGvihycMjE8NejkX1LgkWj7hXdJJ/Dn8dtLCy6jzAgBllFyum7x/9L+8Z5/Ea8rzc
	G0KIV/1p3q1Dz6efUlokqLUwjnDOoE8/Ab7TFp2Ja3DeG4l0QBT2tFgpFiHT9Eszdit9
	ilCPqALoQh7ZOMbAq65ObtnuorFQZuu/7LQwIYgSOKrYNkiN+wiqrh3LwYn9PABft/kF
	WYULwQxfgKpe5kR0sHfqIjod3NzETwV1doLwlXk9eJDs71GMj3RxyAhxM3PRm+f78Itn
	LjBJ3NFf2TI3YcyxIxr1CWHPxP7XL1G/U0G5l2Bh5BKuNDdggDPDfw7lyqdnEFwCnG0x
	5+Bg==
X-Gm-Message-State: ALoCoQlRbT656OYYThZ1kLG6pJ1rVAmTlMh4b74Y24nkI8MW+dr6r498x9Ob3UWoADwfxXbdRIp+
X-Received: by 10.194.192.166 with SMTP id hh6mr6627627wjc.127.1433947174812; 
	Wed, 10 Jun 2015 07:39:34 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k2sm8252702wif.3.2015.06.10.07.39.33
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:34 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 158A2561175; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:56 +0100
Message-Id: <26dc19284e06a7ae35f75a243b2062f61e30f2ca.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 08/19] toaster: toastertables raise errors
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:34 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Modifies the widget code to raise the Exceptions to the user
instead of printing then to stdout - making the programming
errors much more visible.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/widgets.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 407a0fb..3d3c1d1 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -207,7 +207,8 @@ class ToasterTable(TemplateView):
         try:
             self.filter_actions[filter_action]()
         except KeyError:
-            print "Filter and Filter action pair not found"
+            # pass it to the user - programming error here
+            raise
 
     def apply_orderby(self, orderby):
         # Note that django will execute this when we try to retrieve the data
@@ -217,8 +218,7 @@ class ToasterTable(TemplateView):
         """Creates a query based on the model's search_allowed_fields"""
 
         if not hasattr(self.queryset.model, 'search_allowed_fields'):
-            print "Err Search fields aren't defined in the model"
-            return
+            raise Exception("Err Search fields aren't defined in the model")
 
         search_queries = []
         for st in search_term.split(" "):
@@ -228,9 +228,10 @@ class ToasterTable(TemplateView):
             search_queries.append(reduce(operator.or_, q_map))
 
         search_queries = reduce(operator.and_, search_queries)
-        print "applied the search to the queryset"
+
         self.queryset = self.queryset.filter(search_queries)
 
+
     def get_data(self, request, **kwargs):
         """Returns the data for the page requested with the specified
         parameters applied"""
@@ -318,7 +319,8 @@ class ToasterTable(TemplateView):
                 data['rows'].append(required_data)
 
         except FieldError:
-            print "Error: Requested field does not exist"
+            # pass  it to the user - programming-error here
+            raise
         data = json.dumps(data, indent=2, default=objtojson)
         cache.set(cache_name, data, 60*30)
 
-- 
1.9.1


