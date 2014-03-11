Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 38B466F886
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:56 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id k14so7961388wgh.22
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=rEeCf7mAvuw6ZRhLNcZ0bPJvvrpmFav+gstTmdVwvoA=;
	b=K59xdJRFvzqywumrDtByXpqcJB6qhLxbkGqkYeuxOY2GY/Tz8OjjGclM+iit5osyuS
	ufRh3O2kQVLktJOWnkwPCFJ17gCeTarOx0fSKujZFLZlJBvnWRIacFP8HcmHQZ1IypvN
	Ch6aCYvRCUMbGygCFzBEUtI8b0sEuXt7TlcuVIvRItbQDGm2PjpYJnm3eByelYFv9Io3
	UCHLB1n/m1yO+Z0RFTm2HKYAIwDfhIHzgJwvqah0fYF4syy7o2LHfBEhHQaWHEF+FuhH
	D4onP3Tra+XsgGfj1rveCRuLQDNlYIUm7f0OcsfApPo32YbWUm6eyUpGup/l6haOgRl0
	iw/Q==
X-Gm-Message-State: ALoCoQnBGlMr6AP3+oZ84qMGHiPIKxRPsQtCYkTXd2aixfmk84yeiPJCVwlOf+jQFp6viZDwn/cv
X-Received: by 10.194.203.200 with SMTP id ks8mr1890589wjc.61.1394552997320;
	Tue, 11 Mar 2014 08:49:57 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ff9sm7651408wib.11.2014.03.11.08.49.54
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:56 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 3BA1F561887; Tue, 11 Mar 2014 15:49:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:51 +0000
Message-Id: <3c41481fd00056712348d305d0246d84e9a2ff0a.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
References: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394552757.git.alexandru.damian@intel.com>
References: <cover.1394552757.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 7/8] toaster: add 'bblayers.conf' files to local config filter
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
X-List-Received-Date: Tue, 11 Mar 2014 15:49:57 -0000

From: David Reyna <David.Reyna@windriver.com>

In the variables table, add to the local configuration
filter the 'bblayers.conf' in addition to the 'local.conf'
files.

[YOCTO #5912]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6273d4c..f8c8ccd 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -795,6 +795,8 @@ def configvars(request, build_id):
     file_filter= search_term + ":"
     if filter_string.find('conf/local.conf') > 0:
         file_filter += 'conf/local.conf'
+    if filter_string.find('conf/bblayers.conf') > 0:
+        file_filter += 'conf/bblayers.conf'
     if filter_string.find('conf/machine/') > 0:
         file_filter += 'conf/machine/'
     if filter_string.find('conf/distro/') > 0:
@@ -833,7 +835,7 @@ def configvars(request, build_id):
                     'class' : 'vhistory__file_name',
                     'label': 'Show:',
                     'options' : [
-                               ('Local configuration variables', 'vhistory__file_name__contains:conf/local.conf'),
+                               ('Local configuration variables', 'vhistory__file_name__regex:conf/(local|bblayers).conf'),
                                ('Machine configuration variables', 'vhistory__file_name__contains:conf/machine/'),
                                ('Distro configuration variables', 'vhistory__file_name__contains:conf/distro/'),
                                ('Layer configuration variables', 'vhistory__file_name__contains:conf/layer.conf'),
-- 
1.8.3.2


