Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 349836E7D7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:06 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id n12so2615376wgh.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=7zMP57XmMeS0Cckc1TAMWDqxab4Dou35CoCc5xAcg8A=;
	b=R7YofkAm75g2mqtbqUfHcwOHemIuQ74EzO/mnMTCvLIZpDTXXbuYRYcUF9+J6DMDBS
	ADaqb/I/CaW2ffKjHfzEb/kltNdqF/41z9a9VAa07mWJGpv390aojj/b8EGzye8PucbD
	E2ePjL3zTlxkVqzB2oRzbROsrvI8Ul6Rdom4DZ6su/NcXdV1qPlphi0VYI+eNg9c3OpB
	M3SstoAz0/+0XHqx5jyPyEHE2D4PXhlCpvFhI4EoU9uZL73xUlXptESCSmtVT5YpMzQ1
	lRDmMThCK93jlryt08C584hndCB5OxxNHwLV+i6FenU5GBopfzAtVZb2BGW2/+v5rJcp
	ZLUQ==
X-Gm-Message-State: ALoCoQmDXSpI3NHN7z6LL2N5NmkowS/1tTqCCSEFCtZRqFmpoOa/n5sodRSNqE5LYk1tC2bHoptQ
X-Received: by 10.180.188.66 with SMTP id fy2mr6356836wic.45.1395939006866;
	Thu, 27 Mar 2014 09:50:06 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h19sm8782099wiw.17.2014.03.27.09.50.04
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8A6A1560E63; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:50:01 +0000
Message-Id: <554619d7c8cfcba55792104648fb2157aa15f12a.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
References: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 9/9] toaster: filter tasks with cache attempts for all attempts
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:06 -0000

From: David Reyna <David.Reyna@windriver.com>

Adjust the filter for task cache attempts to include all attempts except
SSTATE_NA.

[YOCTO #5923]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4f7170b..4e412ca 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -872,7 +872,7 @@ def tasks_common(request, build_id, variant):
                    'class' : 'cache_attempt',
                    'label': 'Show:',
                    'options' : [
-                               ('Tasks with cache attempts', 'sstate_result:%d'%Task.SSTATE_NA, queryset_with_search.filter(sstate_result=Task.SSTATE_NA).count(), 'Show all tasks that tried to restore ouput from the <code>sstate-cache</code> directory or mirrors'),
+                               ('Tasks with cache attempts', 'sstate_result__gt:%d'%Task.SSTATE_NA, queryset_with_search.filter(sstate_result__gt=Task.SSTATE_NA).count(), 'Show all tasks that tried to restore ouput from the <code>sstate-cache</code> directory or mirrors'),
                                ("Tasks with 'File not in cache' attempts", 'sstate_result:%d'%Task.SSTATE_MISS,  queryset_with_search.filter(sstate_result=Task.SSTATE_MISS).count(), 'Show tasks that tried to restore output, but did not find it in the <code>sstate-cache</code> directory or mirrors'),
                                ("Tasks with 'Failed' cache attempts", 'sstate_result:%d'%Task.SSTATE_FAILED,  queryset_with_search.filter(sstate_result=Task.SSTATE_FAILED).count(), 'Show tasks that found the required output in the <code>sstate-cache</code> directory or mirrors, but could not restore it'),
                                ("Tasks with 'Succeeded' cache attempts", 'sstate_result:%d'%Task.SSTATE_RESTORED,  queryset_with_search.filter(sstate_result=Task.SSTATE_RESTORED).count(), 'Show tasks that successfully restored the required output from the <code>sstate-cache</code> directory or mirrors'),
-- 
1.8.3.2


