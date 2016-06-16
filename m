Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 60928607F8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2016 14:02:05 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id a66so59589491wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2016 07:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=NP7XDOwI5bn/hsoQyRWUml6mAWgbVp07hF9urbOWZt8=;
	b=Q5VR0evFEO0Age7UHN0VzHaR04a3yQOluE1tURh+uTlLvVoWzVaMTiCeglOcfxFXHR
	A2DMgwVArBUoXMqPGSgKGxPm53hk7xd4jMAHQkfQXgtmiHi2NoKTA89Ijijr72iaQGqq
	M0Gc8QRapg3FZiuuDB2JfNcX3W9asvuUSJoxcbeRCYFdLLx0JtkfrPC9oJ9lt+WFHU2a
	AYrqcT7MsstR25ptGYVUUgC/HKNM383qWCZqCV+2YKK6zaB7CINpvu6n+sZgocckhDjJ
	5Pe0knV2ez7l+DavMOihbi8KbKanitw2Ri45mRI1Ba308dMYCJM0JfWX4Ln72I0zmYEd
	1rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=NP7XDOwI5bn/hsoQyRWUml6mAWgbVp07hF9urbOWZt8=;
	b=M5bTOPDCEjHwddDEWbmkp6BTWy6LERICuYHnemV0cDTr/Cin2YYZZKkQqtwDM/lzHC
	ibRGPElnRsf89C0HK5tscErRpypoCHOtbk5V1fQBqLAHNvdlNOwW8ZBK/fc6Qi4mbQ20
	opZdlpIEBjoInc6x6vA9oe+PelVbQQJDC72eVJ+f5Nc9k2nY/G6JwT9Qq6juUIKdEF+e
	oBCjPmFEL8S8YXdD1EKM5UFOYDzV5cFhmtn4FIwpqGUTtl4oSqkjLlxFWa6r1wEPvk/w
	eikdwK3rJnYFxZhhhqUN5u9W9FpQVGdft1ekIyyPwj9ekP1eVtY8sgDc8tOEiTN5lYKk
	sNVA==
X-Gm-Message-State: ALyK8tJE4t6c5e036F7s0iqzXAw74bagLA30688ZJJyI/H7jUvBv0WoKREn2xq2Cazd0IzBh
X-Received: by 10.194.123.199 with SMTP id mc7mr807361wjb.12.1466085726267;
	Thu, 16 Jun 2016 07:02:06 -0700 (PDT)
Received: from orion.home (host86-169-85-169.range86-169.btcentralplus.com.
	[86.169.85.169]) by smtp.gmail.com with ESMTPSA id
	kp9sm43794788wjb.28.2016.06.16.07.02.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 16 Jun 2016 07:02:05 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Jun 2016 15:02:00 +0100
Message-Id: <1466085720-6698-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] toaster: fix typo which causes table searches to fail
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
X-List-Received-Date: Thu, 16 Jun 2016 14:02:09 -0000

From: Elliot Smith <elliot.smith@intel.com>

The iterator used to create a search query refers to a
variable "x" which isn't set, causing an "'x' is not defined" error
and preventing table searches (on non-ToasterTables) from working.

Use the "field" variable instead, which contains the name of the
field to add to the query.

[YOCTO #9749]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 0254876..28ff67b 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -324,7 +324,7 @@ def _get_search_results(search_term, queryset, model):
     for st in search_term.split(" "):
         queries = None
         for field in model.search_allowed_fields:
-            query =  Q(**{x+'__icontains': st})
+            query = Q(**{field + '__icontains': st})
             queries = queries | query if queries else query
 
         search_object = search_object & queries if search_object else queries
-- 
2.7.4


