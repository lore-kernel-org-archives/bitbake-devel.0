Return-Path: <nathan@nathanrossi.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id 54AD577BD9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Apr 2017 13:07:59 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id a188so5064179pfa.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Apr 2017 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=nathanrossi.com; s=google;
	h=date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=i5LqLTChtgrWaA4/t7QIjp/vOPm+2U6PkimxDFu1yiA=;
	b=RVomFNOfqZbfskDHF20naFoKvz+KiYiZwAlhm7RqbYco2KEmeRxjY2BiPh3SWTcDA5
	Qij75yO5CknJiHXkJwGcAIohr9FDah5hD93E0oYef62irzuGamzLCe5pO1vyDe8jlfeS
	zghNnZ3acBXtGJaZF0VLE+WtL6QwAbUO9Dm9lR/WuD2+uFr5uxgyIRD5z0ur+mhLsuHO
	psQcaivPLQDNWgikAdRh0HmDXuxiT3qBrHAZuewNGbUmspDKOrSmJ2ho7BW0WOC0Zy6P
	/9TrrjTg6eAv1uivR52laFXN2I23nzQBqBKGv/izMxej9tJzcYUHq7lguSY1XYJenr35
	w6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=i5LqLTChtgrWaA4/t7QIjp/vOPm+2U6PkimxDFu1yiA=;
	b=sYSLYuqQjP7tayGKXHI7LMKJewJpl5ofRIJ4NFnMsr0/miADe3K+gRvEUQF/10otSr
	va5syOl3uILhbihRezO8b+/uRT0scJBilz6to//IhEJXV+FB4mNKeqIIuZkxkqJW63BD
	TstG2/QGiJAGVbFUJsBvx0NWWz20c0g7fd1IiQDjO4r0dgE9mhJAv++INWGP0ilNKMKv
	EXsMSAwM/RGw7k0LZVuzNEOMgZyq56yb9NX+89F3hijbVdSNPWoaDV3wk/fR4F1gocnZ
	/8TCfo5IhU2YAfB59jhrWo16q4oaiG5KetiasOgiuQPDm0A+LnJADOzCsvy/XGNVAcD5
	P1kQ==
X-Gm-Message-State: AFeK/H1C5LXCKm7oEkQ8eEbVWbesbOFDl2sBNEuEHTxWZMO4GzsjkJtPxYaqoiSe1mGCMQ==
X-Received: by 10.98.108.1 with SMTP id h1mr59041332pfc.95.1491916081500;
	Tue, 11 Apr 2017 06:08:01 -0700 (PDT)
Received: from [127.0.1.1] (CPE-123-211-196-155.lnse4.woo.bigpond.net.au.
	[123.211.196.155]) by smtp.gmail.com with ESMTPSA id
	e207sm920048pfh.121.2017.04.11.06.07.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 11 Apr 2017 06:07:59 -0700 (PDT)
Date: Tue, 11 Apr 2017 23:07:50 +1000
Message-Id: <20170411130750.3274-1-nathan@nathanrossi.com>
From: Nathan Rossi <nathan@nathanrossi.com>
To: bitbake-devel@lists.openembedded.org
MIME-Version: 1.0
Subject: [PATCH] lib/bb/{data, siggen}: Don't warn on SkipRecipe exceptions
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
X-List-Received-Date: Tue, 11 Apr 2017 13:08:01 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Recipes/variables that raise a SkipRecipe exception are intentionally
skipped, and should not generate warnings.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
 lib/bb/data.py   | 2 ++
 lib/bb/siggen.py | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 0403754dee..134afaacc9 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -359,6 +359,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
 
         deps |= set((vardeps or "").split())
         deps -= set(varflags.get("vardepsexclude", "").split())
+    except bb.parse.SkipRecipe:
+        raise
     except Exception as e:
         bb.warn("Exception during build_dependencies for %s" % key)
         raise
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 25ad3e9165..169756e254 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -157,6 +157,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         try:
             taskdeps = self._build_data(fn, d)
+        except bb.parse.SkipRecipe:
+            raise
         except:
             bb.warn("Error during finalise of %s" % fn)
             raise
-- 
2.11.0


