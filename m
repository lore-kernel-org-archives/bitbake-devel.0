Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id 434EA744DB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Dec 2018 13:07:08 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id c14so19625724wrr.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Dec 2018 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=NHsPl1eHFBLsej0jWUqB89bTV1fj0vvSenAhORlK8MQ=;
	b=ZYopuKEGPGTO2XUv6LHSOP0K6MyBhU3+EEnyslSr26hLstobQ2lSshIGrKTbeowYDl
	H4q0X5hSYDHLvXyY5cqMJff9ldMeIHGI/bOIrRiKE4SSHdzArGzwbuX9iay19mwSqfcX
	mMLiXzq2ziGUX2fdQjJfzCyWsap2Vx7XE/Nb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NHsPl1eHFBLsej0jWUqB89bTV1fj0vvSenAhORlK8MQ=;
	b=U4NzVwgrnpQpbxu0hQGjbLQ0eSBGYYdeozDofNXeHmbeh/V6X12ZVMvNJyofi6uzzl
	aIh+fuh/JcecozAVioF5kK9k/GDrQT6ObZzz1AnbtqlJu13gPy254oO1wrSnS6X1r2nK
	PNPw/dICD8y5UcHwQA04ZkedtEcVq4+jKhs3KH6QWkzSqKbVedijGilEF9Q8ixXobvPa
	BFZ3dITIRs8bJI0dvFg1axalv6rsM1gWX1wy7ECvKLTQjk83fa3u2eWDgWj6tN4jeu63
	Xi9hWhROITF8u4cpOsdXyVJVMpPAg6bbp1NvKNJt1PXc9bzsSpfljhdlJzEhCIwbegCu
	qn8Q==
X-Gm-Message-State: AA+aEWbmrN6I/P2kyZ4+UwUR4+5tT4+OQ+RfvzQ1LU4T4cITBKfw/7MZ
	vE0Bhpl7xb/uYthN108RJXMIl9kcwyY=
X-Google-Smtp-Source: AFSGD/WnO82fz5WHIyfDvHamfW2M0IwN+gzJ+6BDIlT9ZvunEo+rbWc0htIFzNsS83tm7ZcJ5h8L9Q==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr22942685wrn.142.1544015228661;
	Wed, 05 Dec 2018 05:07:08 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l197sm11825711wma.44.2018.12.05.05.07.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Dec 2018 05:07:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Dec 2018 13:07:03 +0000
Message-Id: <20181205130703.13546-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181205130703.13546-1-richard.purdie@linuxfoundation.org>
References: <20181205130703.13546-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/4] main: Don't use print() directly, use logger
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
X-List-Received-Date: Wed, 05 Dec 2018 13:07:08 -0000
Content-Transfer-Encoding: 8bit

Avoid failures like:

2018-12-04 03:30:56,033 - oe-selftest - INFO - ======================================================================
2018-12-04 03:30:56,033 - oe-selftest - INFO - FAIL: pkgdata.OePkgdataUtilTests.test_find_path (subunit.RemotedTestCase)
2018-12-04 03:30:56,033 - oe-selftest - INFO - ----------------------------------------------------------------------
2018-12-04 03:30:56,033 - oe-selftest - INFO - testtools.testresult.real._StringException: Traceback (most recent call last):
[...]
AssertionError: 'Previous bitbake instance shutting down?,[77 chars]xist' != 'ERROR: Unable to find any package produci[14 chars]xist'
- Previous bitbake instance shutting down?, waiting to retry...
  ERROR: Unable to find any package producing path /not/exist

We need to use the logger so output is correctly handled in such cases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 732a315404..7dc953da66 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -448,7 +448,7 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                 else:
                     logger.info("Reconnecting to bitbake server...")
                     if not os.path.exists(sockname):
-                        print("Previous bitbake instance shutting down?, waiting to retry...")
+                        logger.info("Previous bitbake instance shutting down?, waiting to retry...")
                         i = 0
                         lock = None
                         # Wait for 5s or until we can get the lock
-- 
2.19.1


