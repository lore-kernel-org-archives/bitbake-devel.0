Return-Path: <armccurdy@gmail.com>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
	by mail.openembedded.org (Postfix) with ESMTP id 691D771B50
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Feb 2017 21:09:22 +0000 (UTC)
Received: by mail-pg0-f66.google.com with SMTP id 194so35224139pgd.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Feb 2017 13:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=uDBIfs0Ld3BJIHkeGluBsEfkfsu8s43Br4CEBpTDbZw=;
	b=FyjC2XuZkDTWxypITIge05RmCv2Iek7hrNhXvV+uUd7NsmcYQ5nJtAwPtz0cvKwOxN
	k6WDLhTjUV/8Mic9rBMkA2KfQUwWr1x0DW9mSrGlR10WVqzDCHhfyrL7yQyqaUPOZe8q
	lOlWB4uUa3+q8YtNduuikKSOQR9WUGX3xDWK2OtYfXAhG1CbOUzPxUegR+Pgc2opONie
	TU9lI1t8hw7wf9YpmaoPRbj3qeYKrmfeOabkg0dvwGqp3E2hrekOFs/kcFS4N+FQ9lvi
	ia6xda2Pf7OuwX7RS/uT0AsGj1hjKFZUhMCq+7b9UvmfVi7oT2opfv7L+19nA+xdgtEn
	YCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=uDBIfs0Ld3BJIHkeGluBsEfkfsu8s43Br4CEBpTDbZw=;
	b=gtymRyf7nUl04MmiJ11PDgWCWgGAABgMrzTOeGLP8zQPXUM+VsV2zl2eKZjmM3Oeuz
	s4fv9+B68yz842l+3+MQAZ6OpOb5VN2bsqorpMGuEl18GnOE07xNecJIoMpwqr8uKfhc
	KvSujzpknH1YYwHPUPsgs2uwXV5MQpBuhqUDYra6L02kUASxBCEn5C4zhz+Vpf1WNk8Z
	ozV054AWkIGyN618k0MXFml2lsVN9ScI8v2FBUgX1iGjDHu8tv5PtY7vhVdhNacJs6Ef
	YYmu2+HQtlhWVaHRvlcPZMyfdXokqAPhFK9XRNTPrh28U+Bl0MutVrMvMzpAqsOWn7Y7
	6XGA==
X-Gm-Message-State: AIkVDXLDai2fB+mYAaCwpTjMZtU+b8IRoiuIZZfSWU0l0QLq+ESg6ycdn3wjC6Pp/akK+w==
X-Received: by 10.84.216.24 with SMTP id m24mr7383506pli.22.1485983362515;
	Wed, 01 Feb 2017 13:09:22 -0800 (PST)
Received: from e6520.guest-wifi.scl.liberty.com ([4.16.80.121])
	by smtp.gmail.com with ESMTPSA id
	r16sm51969312pfg.76.2017.02.01.13.09.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 01 Feb 2017 13:09:21 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Feb 2017 13:09:16 -0800
Message-Id: <1485983356-15764-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] cooker: detect malformed BBMASK expressions which begin with a separator
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
X-List-Received-Date: Wed, 01 Feb 2017 21:09:23 -0000

When constructing an older style single regex, it's possible for BBMASK
to end up beginning with '|', which matches and masks _everything_.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/cooker.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e654a60..ddfd4a6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1867,6 +1867,11 @@ class CookerCollectFiles(object):
             # that do not compile
             bbmasks = []
             for mask in bbmask.split():
+                # When constructing an older style single regex, it's possible for BBMASK
+                # to end up beginning with '|', which matches and masks _everything_.
+                if mask.startswith("|"):
+                    collectlog.warn("BBMASK contains regular expression beginning with '|', fixing: %s" % mask)
+                    mask = mask[1:]
                 try:
                     re.compile(mask)
                     bbmasks.append(mask)
-- 
1.9.1


