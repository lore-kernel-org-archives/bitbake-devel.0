Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC082C79FB9
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 07:31:14 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6474.1788939067145357977
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2026 00:31:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=y+2oGKe2;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso54042235e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1788939065; x=1789543865; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=prHlDQSCWdtk7MIZW5fGZh31yv0LV3FTrB1H4yGpnV4=;
        b=y+2oGKe2CVR6AEaxn+9FcgdYtjpVQ9V2eFL8DvXSHRhH9aEfsDkuR3r7FQmipWkwsh
         DQGv3N/sV28Rv1dy9m2DQkLQ8yv506ppCqtr9WQY7Jk8dZi52xmWLj1+tv1Ds0qbK7AL
         kwi5x7iDLV/4pC2mIn0KSg5l2tA6WMo+1kGtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939065; x=1789543865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=prHlDQSCWdtk7MIZW5fGZh31yv0LV3FTrB1H4yGpnV4=;
        b=q0H2cEhHxbznQxEzwd8g2CgSUpka62a9mNlXgOT/Zn6vvObUpOKOXbkkWRk+5yfejT
         3ZMJC/oqqECw2Q1lEvfMs5jKrr/itAcw29uX9ns2a3SvVsxXeR7O/KpJQ0iAv3QE4EBi
         bNTB6Fc3lWW13hKIx4QpkqRvNMZu3xg7rQcwuxWGTDL+3S/p/FHFpga+emyIt7OYZjMu
         BI3ENnQYhLG4hq8v592oN4dj2BevpG1QK5t7gmSsA+CqJ4VtzWxmYKCvNxwLGt0I0W75
         v/1lmWCWHCAccvYqiVhGIxf8DVlFXfO/Rm9qgRzNC/EiUBxyasF6XQ9mA7pRdwyNc2YZ
         5cCg==
X-Gm-Message-State: AFuF++khyzU7XQqR0VPQBxI39tZ4/cXsCC3OJMZwZbBb0NvhDHFEjdQL
	Qe5y4Q62h5pqbDDsuDlqVIXM0abK9UZtWDxmC3qirV6mhEkmFre1b25zlzjF3DrtldBYv4dT9UN
	YbqUv+jI=
X-Gm-Gg: AYBFou1Y9G3+3vP3nc2JOmEMiCrjk4xa71fh6/OMQjsmqk6DByWLkte9aqo0K2enSK0
	/+F7CsVgW8Ur2XcDDTOrLfXRBF8sboH/jvm26VXgW19F4uWCOURyyMgXuPA/wCdT+Sj0IRMcL8K
	wVn1r9F+lBfhreSI6eE6nyAxhaf0o7iT4HBdyw6Mx0qqbPWz21HV+bkRPbBhupgU2q9oxZv7i8c
	d4Ev8g55SJzOACbmxkYVff7IuSBK5sikQt3f8EJXvriX99KuljCPWNo4sZ+DfF5lFRewQtjZ33K
	ID/8NGQGSIFQWn+rDXhDfl8dDnRe+sksI/ZfVyZUEPAu0EZs5y1kIRqnASYFIzsgWgF1TMi6KE8
	QsR6jvcrV/FFoju+5fGBTHwic4Ig9Brp+sxWOgGJfr4CA8uRyAJ3NzV1mDphuGAFIxuT29mJ/dg
	ca0pqlHhMBOKJS0Ig6C7G99vs2lSKEPxkHrD9rmOEYGamUEts/r4RTmNy9iQQjJXri+RYm0G6dA
	qFyHGoyXECoyLZPTgBR8H5PU0OD/LtSccHRJXheKiS7DnbLuPIF5cA4G2dzRNjqVtK45J6GPQUh
X-Received: by 2002:a05:600c:3f08:b0:49c:fa20:cc04 with SMTP id 5b1f17b1804b1-49cfa20cd10mr290700915e9.27.1788939065250;
        Wed, 09 Sep 2026 00:31:05 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm553491385e9.4.2026.09.09.00.31.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:31:04 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 3/4] tests/fetch: Swap github grpc repo for our own small test repo
Date: Wed,  9 Sep 2026 09:30:59 +0200
Message-ID: <b8ce6eafd4a1f2f8b07bc87583e55e3119718545.1788939009.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788939009.git.yoann.congal@smile.fr>
References: <cover.1788939009.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 07:31:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20175

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The grpc repo is 1GB in size and makes a poor choice of test repo. With github
rate limiting, it is proving probematic.

Swap if for our own gitsm test repo which is smaller but can serve the purposes
of the test.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a64b3157d74f883002318cc46c70bfa1c3609110)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c071401e6..845741060 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1199,7 +1199,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_restricted_network_premirrors(self):
         # this test is to ensure that premirrors will be tried in restricted network
         # that is, BB_ALLOWED_NETWORKS does not contain the domain the url uses
-        url = "gitsm://github.com/grpc/grpc.git;protocol=https;name=grpc;branch=v1.60.x;rev=0ef13a7555dbaadd4633399242524129eef5e231"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=38e61644af90dccd73c03ed3acaed98c8dda9294;branch=master;protocol=https"
         # create a download directory to be used as premirror later
         tempdir = tempfile.mkdtemp(prefix="bitbake-fetch-")
         dl_premirror = os.path.join(tempdir, "download-premirror")

