Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 28C746F89A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:16 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id bs8so3482828wib.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=3fU37VUDRH2WSjGFFz2xzl4n8VE125YUVlYsdvUyPH8=;
	b=HvtZiadOv/kseovwJQB9+AbL98Cw70yNsbtEtZ6dbHUtafBpwrAe9VADCl83ZF4jio
	/q7otchEI7sqd+LHxWLenRuGjdVvoLL0SwQBWmuyjlR8ScvUNc6KkEX20RRb+f5zfHWj
	kAdvzXn5/3W5BN5Gl76gpIOigcWnsBmAO7B1yX3E0NMOo+DUnlnnTMX2NlN9ghRB7ckF
	YesQAKeRjyJ/p3Ly2uIDkSjDvqiJpF7WIFzFZn3skh1QutG3OYDkRvc51meuJlqt9ATj
	DVAitEW3+if4Taf5HzjtOKWKua6kV0lI3Wyf3sW1qk3Xph97GvuQddUVNgsgFJPD9iRe
	/qFA==
X-Gm-Message-State: ALoCoQlV0OSRXoInwcirDsJckJUhJoytaSI3ap1zfkOX6vGoh4tSUMnkOJx1WSuK9WrV6OR5iBYK
X-Received: by 10.180.108.199 with SMTP id hm7mr13608636wib.1.1396284437149;
	Mon, 31 Mar 2014 09:47:17 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id n3sm27672509wix.10.2014.03.31.09.47.15
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 112F256039E; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:06 +0100
Message-Id: <a0beac3daa60a622b77872fb43f041b4631ecf01.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Subject: [PATCH 06/14] toaster: Show "No builds found" in the builds table
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:17 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Making sure the h1 of build.html shows "No builds found"
instead of "0 builds found" when a search returns no results.
This matches the builds table to all other Toaster tables.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/build.html | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index 7d13cc8..afa390f 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -85,10 +85,10 @@
   {% else %}
   <div class="page-header top-air">
      <h1>
-      {% if request.GET.filter and objects.count or request.GET.search and objects.count > 0  %}
+      {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
           {{objects.paginator.count}} build{{objects.paginator.count|pluralize}} found
-      {%elif objects.paginator.count == 0%}
-          No builds
+      {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
+          No builds found
       {%else%}
           All builds
       {%endif%}
-- 
1.9.1


