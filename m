Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	by mail.openembedded.org (Postfix) with ESMTP id B854579B57
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:51 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id x15so68365177wmj.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=98wOcNcwkqkeBIBrEpv/Wgwu179WEARJWYTxekgZ7JI=;
	b=AunWexNlj7ulL5BPKxzoQ+xaOeWHZa20Apk75GQCYy9GuZ2TbqC37IajgH5mrgS6Tx
	JXlWZi0YqZWIRdmFhzV4Eykiceb0AJk71TMCAIX19zY7slMngb20MbRMoF7f4WjcxJPm
	WjAfDkUigi7/vlQKKjG6+8eAb3+5PdoXga4Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=98wOcNcwkqkeBIBrEpv/Wgwu179WEARJWYTxekgZ7JI=;
	b=NXt/6cUASzsztwVACzyjircbTgeh2hbHL7xZn9OxVqyY6CqEmOvFsFz19kDjUABoHr
	CM8+XlTvFPQiePVhCngJCfLPqrfJ9LNvbuE0tSgmUmxJ2JHbN1/JVkQNmDb3Bps9nZmI
	34q/IKSNTVgEPj1zck7arQVfOSHHNNU25WZLZ+ObGqz6JgUmz1Rt13bH2vfb54D9F47w
	AUemD//D44MGLWi4H9qXm7btdSgtHqPLhKPVR6lRFUGhUPPRYRkVTzX2DU3prWSVJohY
	SbPDcHEWEcEMsj1q9mAywk0nhMqxw6NSUJ+GJpu0j+aHmDDWpSWGVC4CYd5cY41Y8Ldc
	L4LA==
X-Gm-Message-State: APjAAAWC64VK5J5YKLBtkituQmI+W/8DdKrAbw/SwDE8RJY4nRMYMaMI
	Iz9b3B0GgCuzJ1x5kb6rKOFnftBxHgc=
X-Google-Smtp-Source: APXvYqyMpIUzHGnze0pLe5f6WmvBF5YAjISU6pb30wyAzRMZk1TAVEmiTLIjfTBcWqZb9jw9z5ajAA==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr4949817wmj.155.1564759252240; 
	Fri, 02 Aug 2019 08:20:52 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:35 +0100
Message-Id: <20190802152049.16529-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 02/16] cache: Add SimpleCache class
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
X-List-Received-Date: Fri, 02 Aug 2019 15:20:52 -0000
Content-Transfer-Encoding: 8bit

This adds a simple version of the MultiProcessCache which can be used to
save and load cache data, useful for a new usecase we have in
sigdata/runqueue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index ab18dd5eaa..233f994279 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -883,3 +883,56 @@ class MultiProcessCache(object):
             p.dump([data, self.__class__.CACHE_VERSION])
 
         bb.utils.unlockfile(glf)
+
+
+class SimpleCache(object):
+    """
+    BitBake multi-process cache implementation
+
+    Used by the codeparser & file checksum caches
+    """
+
+    def __init__(self, version):
+        self.cachefile = None
+        self.cachedata = None
+        self.cacheversion = version
+
+    def init_cache(self, d, cache_file_name=None, defaultdata=None):
+        cachedir = (d.getVar("PERSISTENT_DIR") or
+                    d.getVar("CACHE"))
+        if not cachedir:
+            return defaultdata
+
+        bb.utils.mkdirhier(cachedir)
+        self.cachefile = os.path.join(cachedir,
+                                      cache_file_name or self.__class__.cache_file_name)
+        logger.debug(1, "Using cache in '%s'", self.cachefile)
+
+        glf = bb.utils.lockfile(self.cachefile + ".lock")
+
+        try:
+            with open(self.cachefile, "rb") as f:
+                p = pickle.Unpickler(f)
+                data, version = p.load()
+        except:
+            bb.utils.unlockfile(glf)
+            return defaultdata
+
+        bb.utils.unlockfile(glf)
+
+        if version != self.cacheversion:
+            return defaultdata
+
+        return data
+
+    def save(self, data):
+        if not self.cachefile:
+            return
+
+        glf = bb.utils.lockfile(self.cachefile + ".lock")
+
+        with open(self.cachefile, "wb") as f:
+            p = pickle.Pickler(f, -1)
+            p.dump([data, self.cacheversion])
+
+        bb.utils.unlockfile(glf)
-- 
2.20.1


