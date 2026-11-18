Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9002.1794994124771813889
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2026 01:28:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=C9rbh90F;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: stondo@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb61185057so6154335e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 01:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794994123; x=1795598923; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cDGFXJ5Mf4xkTfQODbFRTgwgvPvEz6hboBsNnpukkdU=;
        b=C9rbh90FKScsbMcPhYeLIUkDJnuuxpvoSG3rBx/a9zI4T6E36UpgUEXBlLr9CTjPZH
         LPkGqFsBQx3XxCLZuvDgiM6bVPVKC7ASgzNqD4c5nM+cXJ5r0cMuAr9R/LBkbiD9uyBo
         J/K1IlRQg+FceHiIlW+HlIh4DSdD5SdHUi6ITTuzXbdrHqStyMpCeWy2eANpQXynXt9k
         fRO2A/FWRBhQ9zeT3ltcWuT1TBp99IQ/6gG9lhaH45K6kr6A+bqW4ih5xL/N0rlohxfx
         kjFziTCR/jFMD4+SmK0KLzyI+Y1GA2JBIoirSenWjfECnVjs8a9n+6Tzykit8A/VZkXI
         MRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994123; x=1795598923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cDGFXJ5Mf4xkTfQODbFRTgwgvPvEz6hboBsNnpukkdU=;
        b=V+aUGzhdPT+LlWsezKfR0tly48pVKDKyQEEIwRrrIB1Bhd2zY+lig8QWm7J/rS9oLM
         1SwOKNx6eAuHMCg8aJ1R2ciZLZecY6z2wCm+ctOyl4IQh0ifkknsB97aDeuDLyODauwS
         mXEAPAZKbfkJADwLHaa9Z6i7XUDUOQx82F9GlfBlKTn5BMBsafq/y6KJwK++6nK7e3a3
         OzET0jat2yDTCDxBtLCVQOdLAYG1Ny9K18YyUmNPbphoJ+xjR0gk5mij6Vnp3Y/nbubZ
         RLLE6OYuawMHHkpT99QycMZDQzng1s/h+y/8dxS0wbImx6soy5ODBB/W9nAeEwTWTrNf
         YfNA==
X-Gm-Message-State: APuU4Z9lv7q/qR6Yx6V30g4ynKXp3cJam+T8cRYdWTG4URwqGHKmP089
	6Rw00KRl2F9E2EeDx3M/U5zn01F8eGRf1/yOxgRA5qBhMWzIIyNt/Wns0QKnTg==
X-Gm-Gg: AYBFou2GnA7gVeKpUHHTh2QcPMm8UV448kY0WzfE/oT/CUx2GimyFq9vqK2USgDcOWJ
	jlJCEZnrXXb7jLBxVj2illa7TA8O2NkRC0gLs0c3fS4dAVWHIw0153qmRfDx5O6dTxzoJN89Z8K
	bxSEkw7lmLoV4j1VaMQjwSNwa8ZiP5312odBou0LqaMFfpDzwm/BHoBB2yZJ5PMBC9VXBtct3sR
	g4Il2sH/KpGGNhwDNjHkIatBrJZfhkyEQ4fnucc6XgkvV4jhsxEJvB2/5LbZThuzeMSPixqcNyA
	S+7DlrlnjoNuLdhuajmsLViCX3OrhlFTs6EkshETTo1JVzzZywT5NIHTMnG7EehXWbBqsTNksnb
	T6pUEXNddxR2t7sqwO1cDhNqpyYy5ubnwF6wKIif0Nn+DC1dzXfJZQ/Vao5gO4FGaBIZ121fIcq
	5/7oBbFSfR609pHOnsm5o6bh8GWekyDam3qRv0YUxZc9hha1oq0hCvOMKpAj6Til34sCdHC7+ce
	+Y5rOrRA0l+Qf2wxuGYNRwPU5P+E/5Rorm+EOzsY90mc9Akvazh34dDDGwCaoY3vyOVgcnEXdk2
	HSpPTslmUvo=
X-Received: by 2002:a05:600c:3ac5:b0:4b8:4af2:88b3 with SMTP id 5b1f17b1804b1-4bb7da4af9bmr36967665e9.22.1794994122920;
        Wed, 18 Nov 2026 01:28:42 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7defa59csm27007085e9.3.2026.11.18.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:28:38 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Stefano Tondo <stondo@gmail.com>,
	Stefano Tondo <stefano.tondo.ext@siemens.com>
Subject: [PATCH 1/2] fetch: Add package_identity() to the fetchers
Date: Wed, 18 Nov 2026 10:28:30 +0100
Message-ID: <20261118092831.201831-2-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118092831.201831-1-stondo@gmail.com>
References: <20261118092831.201831-1-stondo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 09:28:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20456
Content-Type: text/plain; charset="utf-8"

From: Stefano Tondo <stefano.tondo.ext@siemens.com>

Fetchers of package registries know which package a URL downloads:
its name and its version are part of the URL. SBOM generation needs
this data, but it can only get it today by parsing fetcher internals.

Add FetchMethod.package_identity(). It returns the name, the version
and the Package URL (purl) of the downloaded package as a dict, or
None when the URL does not name a package. It uses only the URL and
the datastore, so it works before the fetch and without network
access. Add bb.fetch.package_url() to build the purl with the correct
encoding.

Signed-off-by: Stefano Tondo <stefano.tondo.ext@siemens.com>
---
 lib/bb/fetch/__init__.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index ce2bd62ad..a4b5860c0 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1765,6 +1765,33 @@ class FetchMethod(object):
         """
         return []
 
+    def package_identity(self, ud, d):
+        """
+        Return the identity of the package that the URL downloads, for
+        fetchers of package registries that know it, as a dict with the
+        keys "name", "version" and "purl" (Package URL). Return None when
+        the URL does not name a package.
+
+        The result depends only on the URL and the datastore. It is
+        available as soon as the FetchData exists, before the fetch and
+        without network access. It is meant for SBOM generation.
+        """
+        return None
+
+
+def package_url(purl_type, name, version, qualifiers=None):
+    """
+    Return a Package URL (https://github.com/package-url/purl-spec) for a
+    package. name can contain "/": the segments before the last one are
+    the namespace. Each segment, the version and the qualifier values are
+    percent-encoded. qualifiers is a dict, written sorted by key.
+    """
+    quote = lambda s: urllib.parse.quote(s, safe="")
+    purl = "pkg:%s/%s@%s" % (purl_type, "/".join(quote(s) for s in name.split("/")), quote(version))
+    if qualifiers:
+        purl += "?" + "&".join("%s=%s" % (k, quote(v)) for k, v in sorted(qualifiers.items()))
+    return purl
+
 
 class DummyUnpackTracer(object):
     """
-- 
2.56.1

