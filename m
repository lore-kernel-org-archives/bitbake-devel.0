Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 629A165D00
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 15:28:15 +0000 (UTC)
Received: by mail-pa0-f44.google.com with SMTP id rz1so48141406pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Zd7Ta8fZBBHXISnqveGad8Q7oTzPE3eZ2yYmbAlVnqc=;
	b=RkbeXjcxEkbIPI2t/tJdQLiv36HL+RXC8yI1luKilhSBUP0zVAEHMFSDUJoAGfwtnz
	rXkT5B8lNSKxgK6rLRc+iYocUpx3hAPINwE3MQChQRTvNF1drwTdO8lMG5/0Ifl7eOmH
	hZeCTbIcd7vOynLgFVUe0J69w5gYxBWZED5IwkmwBw9FQPClkC0wOg3jnixxaVPFOq+P
	T/7bsM9ck5ZNrDcMT9HWbJWbZsN4g1zbg1actSkAFAEdeckec2uWE+tCu1iUBXzY2mpE
	C+6MAmEfG7vf4rcX2IBBxapfprgAIFvMdi5AKqijxuZrLIs3HjN8jfw0jd62pJYNSD+x
	zA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Zd7Ta8fZBBHXISnqveGad8Q7oTzPE3eZ2yYmbAlVnqc=;
	b=YWP0ifRWmAjh0l970WSYccZ4s2V23cLkAJK55bekZzYFiKWVYLs/BN+ibAZQGl9C6H
	q8BLNr92jQj4ujU+JAVCgjvDgOrYE30jnX+yA6gXGqq8XtBUbwun3TLVCxc1E+x+J0Yt
	A0zPyW9gULrQ2sovwnLVYf7gzFZ6sBAcT7l1FBOW7lnKW09ccq+kHwmoQRSpgKia3d77
	nisS40V5+OcQZnsGbjdkm3+2NOh6manXeHkSjloVTjIJUeCWzn3eNruOOlc3gTsN0QLY
	4qarJrb5FvS2TvXjqbK5/5HoXIoDwWUWz2jo8Dg2p/h+tv+ydudJ7AyLtx9WU9qBnZw+
	nhKg==
X-Gm-Message-State: AA6/9RnShcSlKXg1HMh3jfI/tAtxb74ABHm22xMDxsPylNhujYS2hMeEYnysETXr8LUWwTi8
X-Received: by 10.66.160.41 with SMTP id xh9mr15769937pab.92.1476458897704;
	Fri, 14 Oct 2016 08:28:17 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.40])
	by smtp.gmail.com with ESMTPSA id
	n7sm28386090pfn.62.2016.10.14.08.28.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Oct 2016 08:28:17 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Oct 2016 16:28:01 +0100
Message-Id: <1476458881-10624-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
References: <1476458881-10624-1-git-send-email-michael.g.wood@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 3/3] toaster: Update default release to Morty
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
X-List-Received-Date: Fri, 14 Oct 2016 15:28:16 -0000

From: brian avery <brian.avery@intel.com>

Set Morty to be the default release in toaster for the Morty release
when creating new projects.

Signed-off-by: brian avery <brian.avery@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/fixtures/settings.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/fixtures/settings.xml b/lib/toaster/orm/fixtures/settings.xml
index 78c0fdc..ee6a202 100644
--- a/lib/toaster/orm/fixtures/settings.xml
+++ b/lib/toaster/orm/fixtures/settings.xml
@@ -4,7 +4,7 @@
   <!-- pk=1 is DISTRO -->
   <object model="orm.toastersetting" pk="2">
     <field type="CharField" name="name">DEFAULT_RELEASE</field>
-    <field type="CharField" name="value">master</field>
+    <field type="CharField" name="value">morty</field>
   </object>
   <object model="orm.toastersetting" pk="3">
     <field type="CharField" name="name">DEFCONF_PACKAGE_CLASSES</field>
-- 
2.7.4


