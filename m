Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web10.20135.1584833278653520940
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Mar 2020 16:27:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=GPWvaxAI;
 spf=pass (domain: gmail.com, ip: 209.85.214.193, mailfrom: raj.khem@gmail.com)
Received: by mail-pl1-f193.google.com with SMTP id h11so4183676plk.7
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Mar 2020 16:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRaj/+Fi+l+ykPaL2DVkawyjXm0JpGovpQ2KbmNhCCs=;
        b=GPWvaxAIX3LF3HUIrCIrMLA0PNDNzbZhcAMibBil1UUnPhKLt3gcrqPsiui3ZgDfQo
         69jcs+6XXDP9tG6iENIQxrM74qwS26vgdl/4oup91ypi3ThbwweJoDU/5AHNi6wAjgh9
         s3M1tnEU7be6j5S+Ekq0+alNBhJqTzyHo+FV+3jNSs2KqcBUtS6s+5UQGv8vHQ8PIQf/
         h211PJiRSdOrkzAptbX97IiNJ0NAuIguTZ8A+YV0UX+FluKBx2H/3VF8MUORwU/6eokp
         A3tqb006tY71eWnxkOG/YauGDfLIC4p3swccQqkgtYzOuerR8AWWkd0VNghPHCV0JIcn
         GF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRaj/+Fi+l+ykPaL2DVkawyjXm0JpGovpQ2KbmNhCCs=;
        b=dGqh598Insg1uygicSmowiAbp9ilhlV72bUpnkUQ9uPavTGrgL2iwSzyaqVXhK5B9P
         22FkXqtiuZSYJiozf3l/+Gc2TCz8i5yPIujedGQFlMVz43XIRcvHVfl/kc02qf37H0C2
         5FH96FT5dBQaXmNRmsJ6wzy4TChqQPIJ8kKJJPb0P8T1TIQ6TiuBx/GtX7GOOhmRR/qm
         QM7vqD9C1vkI/IkCC3zWNtp3As8Pl6hc7vWTvtiEiK+zbS+32TPjUdQ/e4zW77nni8aR
         pnlokLk2QP2ZRYPDOmVE6q5uN05Ih8C70uqBsLpPoN+pNi0GzcBvX/wICs/LJYO1u61u
         yigw==
X-Gm-Message-State: ANhLgQ08MGNy+MoKkl5pbYM3R/5M/klEqZaUzl44qlAMUVpnxZsnLWpt
	jPWxeTlvkSwRIGp2RNHP1MKw4sTE0o8=
X-Google-Smtp-Source: ADFU+vvNgoFQ8JUX7ToTNBUEV0wOFrar2atNsLnY3YxMMlsxMue7nZtFtxOdWWkeA70kERpe5naXPg==
X-Received: by 2002:a17:902:d712:: with SMTP id w18mr15784002ply.238.1584833277672;
        Sat, 21 Mar 2020 16:27:57 -0700 (PDT)
Return-Path: <raj.khem@gmail.com>
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:4e0::81bf])
        by smtp.gmail.com with ESMTPSA id g9sm9119948pfi.37.2020.03.21.16.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 16:27:56 -0700 (PDT)
From: "Khem Raj" <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Revert "fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache""
Date: Sat, 21 Mar 2020 16:28:03 -0700
Message-Id: <20200321232803.746823-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ba093a38539960e645e994a66ed7872a604c00a9.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/bb/fetch2/__init__.py | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9734e211..d8ad19b5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -500,11 +500,6 @@ def fetcher_init(d):
     srcrev_policy = d.getVar('BB_SRCREV_POLICY') or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
-        # We still need to remove keys that are marked with "dontcache".
-        for key in list(revs.keys()):
-            if key.startswith("dontcache-"):
-                logger.debug(1, "Removing SRCREV key: %s" % key)
-                revs.pop(key)
     elif srcrev_policy == "clear":
         logger.debug(1, "Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
         revs.clear()
@@ -737,8 +732,9 @@ def subprocess_setup():
     signal.signal(signal.SIGPIPE, signal.SIG_DFL)
 
 def get_autorev(d):
-    # Do not cache the srcrev in the autorev case
-    d.setVar('BB_DONT_CACHE', '1')
+    #  only not cache src rev in autorev case
+    if d.getVar('BB_SRCREV_POLICY') != "cache":
+        d.setVar('BB_DONT_CACHE', '1')
     return "AUTOINC"
 
 def get_srcrev(d, method_name='sortable_revision'):
@@ -1601,13 +1597,7 @@ class FetchMethod(object):
         return True, str(latest_rev)
 
     def generate_revision_key(self, ud, d, name):
-        key = self._revision_key(ud, d, name)
-        if d.getVar('BB_DONT_CACHE'):
-            # Mark the key so it can be removed on the next bitbake run even if
-            # BB_SRCREV_POLICY is "cache".
-            return "dontcache-%s" % key
-        else:
-            return key
+        return self._revision_key(ud, d, name)
 
     def latest_versionstring(self, ud, d):
         """
-- 
2.25.2

