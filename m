Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
	[209.85.128.51])
	by mail.openembedded.org (Postfix) with ESMTP id 671C660F4B
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  8 Feb 2020 16:01:14 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id b17so5975876wmb.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 08 Feb 2020 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=wfcfr7s2dwD9SevPhJ9RsMb3a9cxhynC5lsPnjOHru4=;
	b=iaiqvoxE4Up8okHrOib34iv+7cE/1OoJkj+9COuZStjqgrkEchi1038kiWUPwHXX8K
	tXrSsUmWPAUWhmW10YVyTrfkrkKiVGOYob/6sVnist5hL4Vmxjj/gSUQPeF7kNM5cii0
	h7fyj9GA5WmdvP19FoqmV9vg8UokWPt+f0f8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wfcfr7s2dwD9SevPhJ9RsMb3a9cxhynC5lsPnjOHru4=;
	b=X4m431d+XKnEWP8o5V8uI9U5kZz1RP2EjkA7FE8ce3WKSxNAcJT+YOBAYLzszfGLqS
	d0LwX8z+i1lM71KfbScjAdhGH/eVjEgqjYmh4LLf2siesXHtO4AOIJrokRS/jYnnbIVa
	a3jMpeL+luCDw6M9DZ7w/LN5VS7zhDkwUppeG1yhcnhe/xvfNg3/HA6EJr74jDiBXVfa
	R0sUDBE17Wk+nEZU9OJPagPme86CKb1y5vaKKS9j/xiIBRVt197Qf1Wlq8440Qpk/Ib9
	gRa6G9oNwBEhZpdBZMvtwvxupWBcplYCWS9NpfGXABuqo7sGYzTzO1H/SIp/UGJOIEC9
	OQRw==
X-Gm-Message-State: APjAAAVMt9UrB3GelRzG+3IaI4vZM3Zrdx4aLorCCUxXGGqKXb75yYMb
	ElQJTAEKvcsUKQoxTjZ8PSnSo5B5d2A=
X-Google-Smtp-Source: APXvYqw1k/rgZk9yUlxeyPKySPmrpjJDfb8swNistFMsU9z33bJeuicMOoLqhYi0JgpHdJA3jozeQA==
X-Received: by 2002:a05:600c:410f:: with SMTP id
	j15mr4091329wmi.132.1581177674857; 
	Sat, 08 Feb 2020 08:01:14 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s23sm2512996wra.15.2020.02.08.08.01.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 08 Feb 2020 08:01:14 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  8 Feb 2020 16:01:11 +0000
Message-Id: <20200208160111.13305-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208160111.13305-1-richard.purdie@linuxfoundation.org>
References: <20200208160111.13305-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/3] siggen: Avoid cache mismatch issues with locked sigs
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
X-List-Received-Date: Sat, 08 Feb 2020 16:01:14 -0000
Content-Transfer-Encoding: 8bit

If locked sigs are in use this function makes little sense, need to
avoid generating mismatch warnings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 96807c46cd..ffd8fcaf36 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -515,6 +515,10 @@ class SignatureGeneratorUniHashMixIn(object):
         if self.setscenetasks and tid not in self.setscenetasks:
             return
 
+        # This can happen if locked sigs are in action. Detect and just abort
+        if taskhash != self.taskhash[tid]:
+            return
+
         # Sanity checks
         cache_unihash = self._get_unihash(tid, checkkey=taskhash)
         if cache_unihash is None:
-- 
2.20.1


