Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 701527354C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:30 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id r20so27708535wiv.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=IFFK6wSd4y9AXCjpeDjkaCWv4fXIqwOnhbDSss2RaX4=;
	b=m7n2qUYD/+fZjw8PQlrajrTCCc3oIHgG77TMuS9V5SOwFwlG8Iq4qvkxZH+h25XZgJ
	ekMSGaiNLZb42gWiRJNTcm+RA4Mq4lUOFXWx8e2XkdpdNi7xla6FIx0+G3n9ZojBUrGq
	7MFtZrdauann3P4Zhbeiu6SLBSjowg+abWeKDB+5iaOpsPfv8pIczQkMK6CbczPQuA9r
	fqWDk/snonRNesQLRx6Vt+vO+l1Db/SYhvYjKKDycjhdgZCC3IRWzryzC5VfcMBvwVdP
	w/fMY0ZzIAMEUSi/bHBqCbRv4e1ZsLHmucwOGTQbbXiE2pL9K9A0aVHharlju5IoB3Hs
	pw2Q==
X-Gm-Message-State: ALoCoQmUvT8JqaKAScFZaoKiD0UKLkJ9iyymm6C9AGIFQ9HoELfusp7hok646LDGvrybEFBAPSLc
X-Received: by 10.180.98.5 with SMTP id ee5mr49470651wib.11.1424109211440;
	Mon, 16 Feb 2015 09:53:31 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	pp10sm23827933wjc.31.2015.02.16.09.53.29
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:30 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D7683560A94; Mon, 16 Feb 2015 17:53:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:25 +0000
Message-Id: <7c862ae4e3c3a00f2b37c2272007ce64304359bd.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
References: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Subject: [PATCH 09/10] toaster: Set the machines page default pagesize to 100
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:30 -0000

From: Michael Wood <michael.g.wood@intel.com>

This brings it into line with the all layers and targets pages

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 1553c74..338b8c3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2746,7 +2746,7 @@ if toastermain.settings.MANAGED:
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
-        (pagesize, orderby) = _get_parameters_values(request, 10, 'name:+')
+        (pagesize, orderby) = _get_parameters_values(request, 100, 'name:+')
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby };
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
@@ -2775,6 +2775,7 @@ if toastermain.settings.MANAGED:
            if len(to_rm) > 0:
              queryset_all = queryset_all.exclude(layer_version__in=to_rm)
 
+        machine_info = _build_page_range(Paginator(queryset_all, request.GET.get('count', 100)),request.GET.get('page', 1))
 
         context = {
             'objects' : machine_info,
-- 
1.9.1


