Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web08.4894.1631219421925866570
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Sep 2021 13:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G4/lSSIq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id s24so2233744wmh.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Sep 2021 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlLRi5hQQxKeWCJskdLBz9NTkrTw8/0/6sQArlnPnMk=;
        b=G4/lSSIqpVQsNKS/0f+HA7gDEKcBr8tZAY7cz69LNEi2QfH/O1Ehd65afqz5Zb5OJY
         Bm1pC5uJ/oAX+e53Ptmb2R9McAlqXJc1Vg202jr3HT35WKNhNvSlizdbBaomB5jT1kmN
         6NhIjeh9qKN4nQhA3UgfCkrYYykDfDJVk9T38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlLRi5hQQxKeWCJskdLBz9NTkrTw8/0/6sQArlnPnMk=;
        b=vBPVTKyPa+2GrlcKab3vPwS5m2GU/D/+rEptfI/6i4KDbL1xBMmgqbFmLlqbhwRusw
         HHt0pzEdHyo+stylA5Lka7tEBIuLoRqH0m/U/J1NqC4szxLCqH7iFlOZpoiwfElOVbDb
         wrOvTecQIcu8HUMYAKf7Hy50q4DoS3WIOsNTZIimBNFk+lJC4p8AcD3MwJzw8cDdYSVM
         IRc+ZMejCZYiSKm/rGx3GBnNf0z6C7Ay4xnznmkhTP5L48QVJ6PEn2sYDLhnmmLYmo3Z
         qrVIe+xwpNrOTTrTdqlK30qO6u/OLEKwkaJ1O9w4b4TDSqfNoheHrI+xtsKqegYvRGc7
         9+Og==
X-Gm-Message-State: AOAM530eX44uD2RTSqEe0W2uNlzX77Qhp7VwOKarp1bf6isQP4X4CdJz
	Xp5FouyMO0OJJfsfXnRCKaABvzZfKsITVq75
X-Google-Smtp-Source: ABdhPJxfhHLzYLF9nI5AQPCPi4Rs+49hQ4Vr1JvVH1U53x2IhTe8C13BiJYzmAzfnqm/3vhG7B1JWQ==
X-Received: by 2002:a7b:cf11:: with SMTP id l17mr4973252wmg.95.1631219420262;
        Thu, 09 Sep 2021 13:30:20 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id t64sm2344002wma.48.2021.09.09.13.30.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:30:20 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] persist_data: Drop deprecated/unused function
Date: Thu,  9 Sep 2021 21:30:17 +0100
Message-Id: <20210909203019.1231314-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This class has long since been deprecated and is unused, drop it. I'd love
to get rid of the rest of persist_data but it is still used by the fetcher,
sadly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/persist_data.py | 50 ------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index c6a209fb3f..286cc0a99d 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -18,7 +18,6 @@ import logging
 import os.path
 import sqlite3
 import sys
-import warnings
 from collections import Mapping
 
 sqlversion = sqlite3.sqlite_version_info
@@ -238,55 +237,6 @@ class SQLTable(collections.MutableMapping):
     def has_key(self, key):
         return key in self
 
-
-class PersistData(object):
-    """Deprecated representation of the bitbake persistent data store"""
-    def __init__(self, d):
-        warnings.warn("Use of PersistData is deprecated.  Please use "
-                      "persist(domain, d) instead.",
-                      category=DeprecationWarning,
-                      stacklevel=2)
-
-        self.data = persist(d)
-        logger.debug("Using '%s' as the persistent data cache",
-                     self.data.filename)
-
-    def addDomain(self, domain):
-        """
-        Add a domain (pending deprecation)
-        """
-        return self.data[domain]
-
-    def delDomain(self, domain):
-        """
-        Removes a domain and all the data it contains
-        """
-        del self.data[domain]
-
-    def getKeyValues(self, domain):
-        """
-        Return a list of key + value pairs for a domain
-        """
-        return list(self.data[domain].items())
-
-    def getValue(self, domain, key):
-        """
-        Return the value of a key for a domain
-        """
-        return self.data[domain][key]
-
-    def setValue(self, domain, key, value):
-        """
-        Sets the value of a key for a domain
-        """
-        self.data[domain][key] = value
-
-    def delValue(self, domain, key):
-        """
-        Deletes a key/value pair
-        """
-        del self.data[domain][key]
-
 def persist(domain, d):
     """Convenience factory for SQLTable objects based upon metadata"""
     import bb.utils
-- 
2.32.0

