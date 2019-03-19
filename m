Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 2F6F77CD7B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 15:30:09 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id p1so21644319wrs.8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/+eVRYcoTw9ul46y+maNFew4tqMedPRaOVyrUKD2JwI=;
	b=F+W+/BjuQ96Xq1bEYvS4HLDJGxPw/A1faArSbSrODddcvY25xzSc9BajtyYg5e+M8B
	/+9UHRKTxVA8RyWFOOhwb4SIec/U77uUPU422VFgR2l3jMvvBao3uA5L+prVgHfPMUYZ
	isDAn95x7MWYXhsbgO/+dfULKTwI8Flj08FZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/+eVRYcoTw9ul46y+maNFew4tqMedPRaOVyrUKD2JwI=;
	b=PEmA++kzLwesm9R4Kfc1ZdnRnQlrx07SjzTh+QzMwo7pmu0vv2+GUq9G0ZuCe29Cf4
	YKNxmjfTf2C0eEcfsF7maPwM44EDpwt8lKz4KRl8EUF4r5QZUFmQH1zp68q4qouk6nJR
	u4HEZajtqdJPNVJn8ROEjfS9sd8UWHt4/ID5qeyTzMy4ptrqofLzC/vL+uVfI6m3zrFX
	FAC70MSAaELuFusQP7HhAcAOqzAlqlS5p0ZGt5ogV709rWtB9w1VPcz+0LSG3nb3AROb
	Ooqusl1Cu/EmSKYz7jaLVfT1ZgIp0R5q6ViC1Mu31Qbp+SZpI0kzczcoBAZNYT3ATTqx
	xVQw==
X-Gm-Message-State: APjAAAWR+OtmjwyB6NWmMOwYE6DcL2AziaK4tmhIx1cs5p5uXsYLQynC
	b0pL2GxE10mZO+TpvKLSDjNe2T9IQ/Fz1A==
X-Google-Smtp-Source: APXvYqy38l5OtXg7wx+BCzeF5SL2v+epFd3i0NNQKgxIABjWTYvDFS45CId8/ohpiBCM/3ajUbPTDw==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr18778207wru.67.1553009409701; 
	Tue, 19 Mar 2019 08:30:09 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g8sm14446149wrw.22.2019.03.19.08.30.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Mar 2019 08:30:08 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Mar 2019 15:30:02 +0000
Message-Id: <20190319153002.17984-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
References: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 5/5] fetch2: Fix undefined variable issues
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
X-List-Received-Date: Tue, 19 Mar 2019 15:30:09 -0000
Content-Transfer-Encoding: 8bit

Various refactors have left hanging variables, often in debug messages, hence
why they haven't been spotted. Fix them (pylint spotted the issues).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f112067df5..5c2a1c76c4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -524,7 +524,7 @@ def fetcher_parse_save():
 def fetcher_parse_done():
     _checksum_cache.save_merge()
 
-def fetcher_compare_revisions():
+def fetcher_compare_revisions(d):
     """
     Compare the revisions in the persistant cache with current values and
     return true/false on whether they've changed.
@@ -1403,7 +1403,7 @@ class FetchMethod(object):
         Fetch urls
         Assumes localpath was called first
         """
-        raise NoMethodError(url)
+        raise NoMethodError(urldata.url)
 
     def unpack(self, urldata, rootdir, data):
         iterate = False
@@ -1547,7 +1547,7 @@ class FetchMethod(object):
         Check the status of a URL
         Assumes localpath was called first
         """
-        logger.info("URL %s could not be checked for status since no method exists.", url)
+        logger.info("URL %s could not be checked for status since no method exists.", urldata.url)
         return True
 
     def latest_revision(self, ud, d, name):
@@ -1555,7 +1555,7 @@ class FetchMethod(object):
         Look in the cache for the latest revision, if not present ask the SCM.
         """
         if not hasattr(self, "_latest_revision"):
-            raise ParameterError("The fetcher for this URL does not support _latest_revision", url)
+            raise ParameterError("The fetcher for this URL does not support _latest_revision", ud.url)
 
         revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
         key = self.generate_revision_key(ud, d, name)
@@ -1786,7 +1786,7 @@ class Fetch(object):
 
         for url in urls:
             if url not in self.ud:
-                self.ud[url] = FetchData(url, d)
+                self.ud[url] = FetchData(url, self.d)
             ud = self.ud[url]
             ud.setup_localpath(self.d)
 
-- 
2.20.1


