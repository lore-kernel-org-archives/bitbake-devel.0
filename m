Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4739.1795121342159225264
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Nov 2026 12:49:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=DToctpwN;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: stondo@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso1610665e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795121340; x=1795726140; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwlZY8pVXW4m2EkRjTEzscCHAd26YMTppIgD771Pkk4=;
        b=DToctpwNqIay5tv/IxKX/sx2yTVLqVMsvMmBieaaOc1vu9rTSnyH58fpLD+bscRlXS
         O6bGqFS4BIC0W6c6seWMa2PdrUTkB1ik8/86ZuUM/2hOu05OKG3C0usmusWQmbOPWS4W
         4/rGhJFIOf0TBBy2VUhsl0UpgUBZG9MtFX3IRTGkzF45rQlWQ1nnXL44A3whO4qFo7Ph
         v4kZYAPq6h4GX91j+Reh2dE3+1s4YNsMHThW1BhgBLfzsVdibceJQut3R2GVYHjrcc4i
         0LuVDtiaOVi2S75gwA6u46DbPu1ktROlbvcw9CrQDvCCXX0PAbNdbGUinnH/o/KgXxPj
         vWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795121340; x=1795726140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EwlZY8pVXW4m2EkRjTEzscCHAd26YMTppIgD771Pkk4=;
        b=fphnWG0wSfBp+nqsFylmYm1ZSfGDfJmbXilpL2C4VxLUbt9ldScbYg33XMwlJuYihB
         eaHu5cof44Bw87TWX0W0LFRiUuy+tU60LfnIiHpVejF7XELPOg0lS27nTrjP+QtF32NB
         2ip1wsHog+HFfOUfxl/TWADrHNao87f8iNtM0oZrmE6RrzqeukrnHx8ekkMjE+aCt6E6
         G4cHg9JDKiUywkXM0ry1745IUgr0JyJMXifwmUGaHNzc7oIgPYeXa1/J+1UhdE5WYnmk
         z6CguO/SA5vKYrhpmM/BwDF5v2x15FtNs6aACTBjswYdeYFrVUaNTBw64pwtgqzA70h4
         FTmA==
X-Gm-Message-State: APuU4Z/qsjK6ZIuHNwLwCaIWeZfBx3sfquoOOYWfMW7ik/Y4qA7WGiVv
	kH8ZXLUKpkMaDq1c5iJGtiN1fERX3/JIzM3ymQrVbjaQnfUyRx1fRTN6ISuDLg73
X-Gm-Gg: AYBFou165bcsY38CiMCV1AqTX8D2+Uhx7L28lCLX+J7EDTziz93weWsN8iB1F2xq9++
	RdjenXRMa2ElwkDwq7vUV9MgWB34jEr7QAbsi02LtgXr3EbaBSpQKf4sGeg0VQX3dslowU1/akH
	7p1DRP1NT6DPMEqNM/hwXRFINLoHn20WcGFXY5AxQBD/O2X180+50VxhyGq2aQphJcrW9cHkgml
	k00OMXbvKuLVKv4rs219bzQfpvnBgnNz61h4vh+1Rj8qWy3vl/WQMaB7J5FrGjh1Z+719LPVV/q
	ivYG50hFOXo66Gi5Y+Lg7ixYTO0uqt8hF7B2/9IPLt+S+n0+GBMpzW4mehH643fc9qT7ffOZ703
	FM+Z/ipQOzo+vDrmz2P5TMhw8KQyH+mcS+ERMSyJRgfw830sHZRxsjaWlRm0BSUteF1JU342nXW
	xd8ERVsldcWIc9HgXXQVmxK5ifnqUgqKXD36C5zhjSeItYLOE7dQXeXJVR+36HhNS0R3GWi6FSK
	R1aMiXhETjmFJ6Gs7rBDuv20DSVTczuVThCf+E3RZsU1vW9KK4+CREbjn49oQKnwQR7nzF4ZICQ
	gaovex5/Erd1
X-Received: by 2002:a05:600c:3509:b0:4bb:76f6:d23a with SMTP id 5b1f17b1804b1-4bb88814d16mr16004285e9.21.1795121340169;
        Thu, 19 Nov 2026 12:49:00 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm1749597f8f.2.2026.11.19.12.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:48:59 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Paul Barker <paul@pbarker.dev>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Peter Marko <peter.marko@siemens.com>,
	stefano.tondo.ext@siemens.com
Subject: [PATCH v2 1/2] fetch: Add package_identity() to the fetchers
Date: Thu, 19 Nov 2026 21:48:55 +0100
Message-ID: <20261119204856.2930668-2-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119204856.2930668-1-stondo@gmail.com>
References: <20261119204856.2930668-1-stondo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 20:49:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20463
Content-Type: text/plain; charset="utf-8"

From: Stefano Tondo <stefano.tondo.ext@siemens.com>

Fetchers of package registries know which package a URL downloads:
its name and its version are part of the URL. SBOM generation needs
this data, but it can only get it today by parsing fetcher internals.

Add FetchMethod.package_identity(). It returns a PackageIdentity
dataclass with the name, the version and the Package URL (purl) of
the downloaded package, or None when the URL does not name a package.
It uses only the URL and the datastore, so it works before the fetch
and without network access. Add bb.fetch.package_url() to build the
purl with the correct encoding.

Signed-off-by: Stefano Tondo <stefano.tondo.ext@siemens.com>
---
 lib/bb/fetch/__init__.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index ce2bd62ad..41ce55921 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -20,6 +20,7 @@ if 'git' not in urllib.parse.uses_netloc:
     urllib.parse.uses_netloc.append('git')
 import operator
 import collections
+import dataclasses
 import subprocess
 import pickle
 import errno
@@ -1765,6 +1766,43 @@ class FetchMethod(object):
         """
         return []
 
+    def package_identity(self, ud, d):
+        """
+        Return the identity of the package that the URL downloads, for
+        fetchers of package registries that know it, as a PackageIdentity.
+        Return None when the URL does not name a package.
+
+        The result depends only on the URL and the datastore. It is
+        available as soon as the FetchData exists, before the fetch and
+        without network access. It is meant for SBOM generation.
+        """
+        return None
+
+
+@dataclasses.dataclass(frozen=True)
+class PackageIdentity:
+    """
+    The identity of a package that a fetcher downloads from a package
+    registry: its name, its version and its Package URL (purl).
+    """
+    name: str
+    version: str
+    purl: str
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

