Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 470F077032
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:43:58 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so194362858pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Qd4cEpehnXdXtdXPuBi8Sml1h78Z1x0qzzd08JtKvIU=;
	b=pKpruKJc08k5oawZDr0z9Wrp4rYFk8SKHPv4/v6M9Iw/jlxcI2vIeNzdYdSWoa+BYe
	hF1VdojqK7ZmzLKcV0nxB6qYfZKgQLjDxTW/eTaVwRRmG5c/3F7y/ys+aAces0ihOsrk
	Xa/d3tkVlhYYBvJ0kZ+ksieN5fO5ronj0qxsoT1AIDRRppRBLoRg/QtAPqzEGDTvSJEX
	sGBjnr+IFQxOoDkxyA8TzVlJu0QufvrqvrVgjBjSah99SyGj/jXVM/DNV4VRMHxUbUyx
	zUClT2OLVFliCzOThXO4P8w2Cuz6kLDv5SERYpfwq40Xhim6pNDDnKTVWQCM38aIsVb0
	ZTKg==
X-Received: by 10.66.193.230 with SMTP id hr6mr30794494pac.39.1443501839301;
	Mon, 28 Sep 2015 21:43:59 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.43.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:43:58 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:15 -0700
Message-Id: <30ca9bfbb705b7297283dad64fd00c8577295a75.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 05/22] toaster: widgets ToasterTable Add more info to search field exception
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
X-List-Received-Date: Tue, 29 Sep 2015 04:43:59 -0000

From: Michael Wood <michael.g.wood@intel.com>

If we get a search fields exception then also print out the model name

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/widgets.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 7f96370..aaa59c0 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -229,7 +229,8 @@ class ToasterTable(TemplateView):
         """Creates a query based on the model's search_allowed_fields"""
 
         if not hasattr(self.queryset.model, 'search_allowed_fields'):
-            raise Exception("Err Search fields aren't defined in the model")
+            raise Exception("Search fields aren't defined in the model %s"
+                           % self.queryset.model)
 
         search_queries = []
         for st in search_term.split(" "):
-- 
1.9.1


