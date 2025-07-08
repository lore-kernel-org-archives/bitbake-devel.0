Return-Path: <sider123456789101112131415@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00221C8303C
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 12:57:03 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.17992.1751979418875766879
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 05:56:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Mojk2lsD;
 spf=pass (domain: gmail.com, ip: 209.85.167.44, mailfrom: sider123456789101112131415@gmail.com)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so5980805e87.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751979416; x=1752584216; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txsEeRVl1wuxPTM+xJmJu99F+iy1V/FAqLhAnk2daxE=;
        b=Mojk2lsDQulPMhqrjMhf31EO82WRGzH+EYLD+iyHPz+fgWvDCkCs40uqLZ+o4XSDBY
         uGJrpli55hNaENSPxJ+mS08rfWchRvvt7auU64XDWTjRMGoMuULqmPkGXvnyObWn8EgV
         12jrJhEObUdZYcTXsZ6xNyasa/ZrIu8we756kpZelp2s5alANvWS25QrjDx12M5hT2mp
         UK6mVZJSmF0sAWLi6YnXhJkgNGYOLEBs/blHSHLPujLZqclwFLdtZ7puFZicpICZX378
         kq7WB2LIPk0vwiYnp/S/yhbnUnT4OR7sIIplE8G3EbJTlxaSny30K4Hc02B94wz27RMm
         1T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979416; x=1752584216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txsEeRVl1wuxPTM+xJmJu99F+iy1V/FAqLhAnk2daxE=;
        b=IoWmxd7LMiCMQ7BvTvRRXuCe57GQI1dNUaXG1ULtxI/3U5pdtQGdBH+bRJ6bBIvVCD
         Blr6H4xUakPkn+VoHodD14FZGbqrClkaCsiXWsq8W6yZ17F9+phjq4Id5wCkL4dIsG76
         hdW7FfHCuAv7bDwC+cJYvV2gU+HNMwMydF9YOlbY0Oejsi17mZAUywJjAeXtxobiJXjx
         UO6RDqWwtfYLWNKXQwUYRBSzf/zWrxkGCKRO3U6vZQPk5iaPdEYd/lJh0YaUmuiziz/C
         WUc9CPUTjvsExdGA/Wz7umsOSjh4UcMDH5W0l/fwbST78BoULa6/b13XGI2dTFdjh/In
         mmtw==
X-Gm-Message-State: AOJu0YyHLedVN04aMNn0yCTylP0cHC/zLfipRca6MBiQDHUlO7/iUlix
	9WGgT3jloRmvF9ezVcy2+Gvxzb/uC8BT+ihPa1TpiIOmKDpuVlJZmA9XshlociAlCW9vRw==
X-Gm-Gg: ASbGncvHUrtM3hp15zutGZ/f5ZDXSdjPzvBFlEcxwtcYSR5JKNLndMbXiaqO7Rc8Ees
	2in3D7g2AarYWLHTdg4aPgQ/weuvHaIovNy5vv/251QcDtoj0EzZjT5HMCgoe9OZTeu8IS005wz
	CdblBAWhJGLsU+vjGmeqGrMwswApjlsrRXToEGt77UIdR+Q52XK/J9RiHOMdoJaEC17WbWkmJNh
	0mHXKQdE+04EqOZt843KiGm5FwoU9fF90Co55YD/4jRyFnHiJx/BXZPqCapp8SHzW6i3ZOrcz0h
	XgFWTcjArSSrSgVvSm8FjnrYwORnOw6+AKXbLda5XgWT0yE5gbhVVkGPZ7WCP8f9AfXhixV2FnL
	BMpga389zHwbWWJfLfEBh
X-Google-Smtp-Source: AGHT+IGIMpaPp1yLTlGTaBHptSNnleFi7TwObymJLTmVCRB852OZBCcCZWLnKtFtarAqJz2qIJ9JIw==
X-Received: by 2002:a05:6512:39c1:b0:550:e8b6:6996 with SMTP id 2adb3069b0e04-557f899cbcamr873703e87.2.1751979416091;
        Tue, 08 Jul 2025 05:56:56 -0700 (PDT)
Received: from localhost.localdomain ([176.15.165.116])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55638494491sm1679896e87.128.2025.07.08.05.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:56:55 -0700 (PDT)
From: KonstantinKondratenko <sider123456789101112131415@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: sider123456789101112131415@gmail.com,
	gavrilov.andrew1999@yandex.ru,
	tinyakovx@gmail.com
Subject: [PATCH] [bitbake-devel] [PATCH] bitbake: fetch2: Add filtering unavailable mirrors
Date: Tue,  8 Jul 2025 15:56:46 +0300
Message-Id: <20250708125646.11134-1-sider123456789101112131415@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 12:57:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17760

I am sending the second idea regarding the filtering of unavailable servers in SSTATE_MIRRORS. The first version of the patch was left unattended; it is available at the link:
https://lists.openembedded.org/g/bitbake-devel/message/17595
In the first version, a simple availability check is performed at the stage of reading local.conf. This might slightly disrupt the logic, so I created a second version of the patch (the current version does not work—it's just an idea of where the logic can be implemented; I want to hear your opinion on this—whether it was worth dealing with). This version globally performs the same task—preventing additional load when specifying partially non-working servers in SSTATE_MIRRORS.

The main idea behind the changes is to check what error occurred when trying to retrieve a file from a remote server. If the error is one of the server-related errors (for example, Service Unavailable) or another error that makes it impossible to use the server causing the problem, then requests should not be sent to such a "non-working" server. As I understand it, for each sstate-cache artifact, three requests are sent to the server, which creates a large unnecessary load if the server is generally unavailable.

Please consider this idea and, if possible, the previous version as well.

Thank you, and have a good day!

Signed-off-by: KonstantinKondratenko <sider123456789101112131415@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 49 ++++++++++++++++++++++++++++---
 bitbake/lib/bb/fetch2/wget.py     | 19 ++++++++++++
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 0ad987c596..becb4de900 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -79,6 +79,19 @@ class FetchError(BBFetchException):
         BBFetchException.__init__(self, msg)
         self.args = (message, url)
 
+class Server5xxError(Exception):
+    """exception for 5xx server errors"""
+    def __init__(self, url, message="Server error (5xx)"):
+        self.url = url
+        self.msg = message
+        parsed = urllib.parse.urlparse(url)
+        self.mirror_host = parsed.netloc
+        super().__init__(self.msg)
+
+    def __str__(self):
+        return f"{self.msg} ({self.url})"
+
+
 class ChecksumError(FetchError):
     """Exception when mismatched checksum encountered"""
     def __init__(self, message, url = None, checksum = None):
@@ -1073,7 +1086,12 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
     try:
         if check:
             found = ud.method.checkstatus(fetch, ud, ld)
-            if found:
+            if found is None:                
+                parsed = urllib.parse.urlparse(ud.url)
+                mirror_host = parsed.netloc
+                # Raise errors until we can reorganize the mirror polling cycle
+                raise Server5xxError(ud.url, f"Server error (5xx) for mirror {mirror_host}")
+            elif found:
                 return found
             return False
 
@@ -1167,10 +1185,33 @@ def try_mirrors(fetch, d, origud, mirrors, check = False):
 
     uris, uds = build_mirroruris(origud, mirrors, ld)
 
+    '''
+    TBD: The issue with this loop is that if we don't interrupt it, there will be no effect, and we will iterate through all the addresses from build_mirror_uris. 
+    If we abruptly interrupt the loop, the progress of previous polls will be lost. We need to preserve the progress, for example, by restructuring it into a while loop. 
+    In this loop, we can iterate and, upon encountering an error, filter out only those addresses that haven't been processed yet.
+    '''
     for index, uri in enumerate(uris):
-        ret = try_mirror_url(fetch, origud, uds[index], ld, check)
-        if ret:
-            return ret
+        try:
+            ret = try_mirror_url(fetch, origud, uds[index], ld, check)
+            if ret:
+                return ret
+        except Exception as e:            
+            if isinstance(e, Server5xxError):
+                global_d = fetch.d
+                sstate_mirrors = global_d.getVar('SSTATE_MIRRORS') or ""
+                new_mirrors = []
+                '''
+                    Add mirror filtering — eliminate those that caused errors (.mirror_host) !!!
+                '''
+                new_value = " ".join(new_mirrors)
+                global_d.setVar('SSTATE_MIRRORS', new_value)          
+                logger.warning("Removed mirror %s from SSTATE_MIRRORS due to server error", e.mirror_host)
+                continue
+            else:
+                raise
+    '''
+    After this, it is necessary to change d via setVar so that when calling try_mirrors, mirrors that return a server error do not appear.
+    '''
     return None
 
 def trusted_network(d, url):
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 7e43d3bc97..7675267659 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -401,6 +401,25 @@ class Wget(FetchMethod):
                 with opener.open(r, timeout=100) as response:
                     pass
             except (urllib.error.URLError, ConnectionResetError, TimeoutError) as e:
+                errno_code = None
+                if hasattr(e, 'errno') and e.errno:
+                    errno_code = e.errno
+                elif hasattr(e, 'reason') and hasattr(e.reason, 'errno') and e.reason.errno:
+                    errno_code = e.reason.errno
+                # Server (network) errors
+                server_side_errors = {
+                    errno.ECONNREFUSED,
+                    errno.ETIMEDOUT,
+                    errno.EHOSTUNREACH,
+                    errno.ENETUNREACH,
+                    errno.ECONNABORTED,
+                    errno.ECONNRESET,
+                }
+
+                if errno_code in server_side_errors:
+                    # Return None to have information one level higher about why it was not possible 
+                    # to get the file -- if there was a server error, then None
+                    return None  
                 if try_again:
                     logger.debug2("checkstatus: trying again")
                     return self.checkstatus(fetch, ud, d, False)

