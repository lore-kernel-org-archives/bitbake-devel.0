Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 967396EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:10 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id hm4so36597wib.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=SA12M1jX0NVN+LMrfHIeDy8+In+ctij92up6owNB0P8=;
	b=V7im1FOTO+QPIEUNxmEmUpoaFkV57bBlLoeWJQ37dOUskqj/BupMk3opOwo32haJYU
	DUK7qAfi14sgKM064mO/Fv5o2m4TcWRsmohneJiySsGbolIATU/UK9sTiZhRocKkR/dc
	xwRaI8fCmdSGObZm6AE1GEpcPFc0dJHyYwBUlVhqQJN1xcRhokE0Z/XUdCet8EsRu7Dv
	68AllXApbRFpHKaNxHgQSJiSo1JZyDohWX4oZM3EHBDjCJCz6YY+mKTxPoECMyZFHmCi
	cmaXmhLKmrA4aqc8jWVASnrMB3Bg6B5mnrc8+oeM6h1/J4Afsh60TZMb7vJK2QDNUZam
	4dug==
X-Gm-Message-State: ALoCoQnfYuzVHAD1PZrJX7CxePzFmAdDfIMF5++3suor7HDsAfOLMtWFMDvsn9EbnGzz/WVemO0e
X-Received: by 10.180.77.74 with SMTP id q10mr7265413wiw.39.1394819951665;
	Fri, 14 Mar 2014 10:59:11 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	h13sm15529934wjr.22.2014.03.14.10.59.07 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 285A65612C5; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:59 +0000
Message-Id: <8eadf6eb691a460212c4f9a4e560689809a49b2e.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 18/19] toaster: Sort layers in alphabetical order
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:13 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the Summary tab of the Configuration page, make
sure that the table of layers is sorted by layer name
in ascending alphabetical order.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/configuration.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/configuration.html b/lib/toaster/toastergui/templates/configuration.html
index ddfa5af..674f896 100644
--- a/lib/toaster/toastergui/templates/configuration.html
+++ b/lib/toaster/toastergui/templates/configuration.html
@@ -49,7 +49,7 @@
           <th>Layer directory</th>
         </tr>
       </thead>
-      <tbody>{% for lv in build.layer_version_build.all %}
+      <tbody>{% for lv in build.layer_version_build.all|dictsort:"layer.name" %}
         <tr>
             <td>{{lv.layer.name}}</td>
             <td>{{lv.branch}}</td>
-- 
1.8.3.2


