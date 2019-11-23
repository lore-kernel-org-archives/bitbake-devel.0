Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
	[209.85.210.181])
	by mail.openembedded.org (Postfix) with ESMTP id C92A57FCF7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:01 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id p26so5156048pfq.8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=FvkjN1a/fuGbTL+7aj7kGfiKLECiMl7j+ALo+zi/nEg=;
	b=ZbCg++64pGohYeDJsgQXPOJ1rdYb0s9JvYK7vn6/rvUuAZVP+Q1gttyMfpXcB5Nr7U
	szbld5nqaw0RJIPF47wY9Mw4HJX0ORjXWb4ODAZpQZ6eRHH5y4olPPYWyG2pmFFIaR41
	Up/rBf6sxquGr41gNomEQe14Nr6G4bawFroBMFfVpD+uPRQ3RUQcgZiVIxBMdfuZ6qjJ
	a9xqORX8ELBzFzZvzP4HGwyZeOh7tX9gMkne4+iUpu4vEyUAOuXGBeLo904G7JRj6N1g
	8DaUvSvj+tgL9wqo98ujUC9Gufuprf3G0g69SXViZPwGu9mXF8EacLA81Jo0MH8nyaye
	VjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=FvkjN1a/fuGbTL+7aj7kGfiKLECiMl7j+ALo+zi/nEg=;
	b=t5KISdVdsM73OtzJJyNla2DSVVx1Bq2ewWOVkqaDveSdwYhyBKS3YMkWM+dx92SW+R
	5NTyYJqKdA2+EHm9u7mMt2rEHvfcsMVdyzhMM0iFHBOMrzdEq3ZekqtjJLoKrh1vqN16
	xEW2RSsRmGLoNH4DhW6AjdHlCyRAs3Y6VMfZnyeJe+JvD/zJWVKgsS47acOyN4owvqAo
	zsNKYv0kYlF6GGoQTbNbi3XUwa3kmJv0TqzYZLlJqw2nKprnOrFjLHGQS3s/ln/F4oMV
	EjwcN/DOkR30NSfIA+OvjRt0qfrZziO2qY6nT8TpeZ6tA507dYWto6mzRaC10ZFXDlOL
	HvtQ==
X-Gm-Message-State: APjAAAVJ1J2lKUeA2Jyztir1DV8A2yiytF/HvEXQzIGnpA5WoJoW/KKE
	20xEDMB7vVn1jNk+OdHs2N49Ar2k
X-Google-Smtp-Source: APXvYqz+esPEkvIaWGUBX+VLH7CTYV2jEd8CnSw2xYl9vCKv2DatEs8VJ9vdszH9FYcZDIaoy23Nrg==
X-Received: by 2002:a65:6241:: with SMTP id q1mr22581073pgv.309.1574526302696; 
	Sat, 23 Nov 2019 08:25:02 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:02 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:52 -0800
Message-Id: <1574526299-21018-2-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
References: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [1.44][PATCH 2/9] tests/fetch: add test for fetching shallow revs
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:02 -0000

From: Christopher Larson <chris_larson@mentor.com>

[YOCTO #13586]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/tests/fetch.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a0b656b..83fad3f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1863,6 +1863,26 @@ class GitShallowTest(FetcherTest):
         with self.assertRaises(bb.fetch2.FetchError):
             self.fetch()
 
+    def test_shallow_fetch_missing_revs(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        fetcher, ud = self.fetch(self.d.getVar('SRC_URI'))
+        self.git('tag v0.0 master', cwd=self.srcdir)
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
+        self.fetch_shallow()
+
+    def test_shallow_fetch_missing_revs_fails(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        fetcher, ud = self.fetch(self.d.getVar('SRC_URI'))
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
+
+        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs("BitBake.Fetcher", level="ERROR") as cm:
+            self.fetch_shallow()
+        self.assertIn("Unable to find revision v0.0 even from upstream", cm.output[0])
+
     @skipIfNoNetwork()
     def test_bitbake(self):
         self.git('remote add --mirror=fetch origin git://github.com/openembedded/bitbake', cwd=self.srcdir)
-- 
2.7.4


