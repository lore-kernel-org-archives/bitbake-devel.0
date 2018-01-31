Return-Path: <nathan@nathanrossi.com>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
	by mail.openembedded.org (Postfix) with ESMTP id EA05D7874D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 15:07:36 +0000 (UTC)
Received: by mail-pg0-f67.google.com with SMTP id s9so10255381pgq.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Jan 2018 07:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=nathanrossi.com; s=google;
	h=date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=MarguXmhPdxorVSmkaBl/PwHCaWeYkihphXYoNVEg7A=;
	b=SsncKkOBueMasntVwRfDmx8c+nzJ0DLbGK+/b0GOJIOV0BhDVp6b54cwEG65eq4wtT
	DHvSrS12vi3qZ0n1boXZPMXBz6mh41TBUdo/DlO9ErwKA7nGTvbaZVGexWMX3ge4KInP
	9VkTayRPBWjxcuFqQKGhJ1LT3tSqrp20Cr3A8icMuWP3s4cjFspOXqm1BJ0uII8pM9HI
	3+PulCODfancUNXYnRc7/dPyX1toBY65cFr4ndrNvJTEF8k5T3IWHLOTJe0pDEBOuoRc
	SotuHUWfak4do1HALMfxrrZghTJy+oeQe/59MhkJ9SC7op9Vt5HmCyDHHbQJOlKgPPP0
	tVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=MarguXmhPdxorVSmkaBl/PwHCaWeYkihphXYoNVEg7A=;
	b=o7wU2F5ojA/vwfK8nba6smKMzXDXXM45R3Y8z75V6vWokZUPlhSTienymGLy0WgFxq
	BUlUCIa3dexTcdFG98nHHNeQ51JjSX3VmDo0VX6KZPxrKX6aooXD8QQgz3O654CZliR/
	Md7bI4ewXTDG2QDDE26us0NJaxG2ISnvCUF5YpAgDIonHMqtavbCbZcYpP/ze75SE3J+
	byGHuVcl7ESbW4JQjLg0RgQ+gxuKOUQUFr/RSgLCDp3Zpn9s+odMyKtGtpOHBbwd8QWy
	x/u/R1G5e4yGpnq0uu6LP5bthTUEeONIIyKlHPt73wLepu5rf5AAFm9tdRY/e5RSD7rx
	AGNw==
X-Gm-Message-State: AKwxytfHGUWQvIAJRX2vVskXdrujuDZvLs2ukyLlJXd3WukOolOV6f5C
	uZfWcPz6cDKE+wTpSNx2OzUOoRKT/W0=
X-Google-Smtp-Source: AH8x226J7wo+6TjInKD2Nrk0kgqHqDIJZWmUHhHbKOfr38zwuff0HLYwUTcrvizgZCjB1Ku3yFMwqw==
X-Received: by 2002:a17:902:7841:: with SMTP id
	e1-v6mr9108883pln.130.1517411257820; 
	Wed, 31 Jan 2018 07:07:37 -0800 (PST)
Received: from [127.0.1.1] ([101.163.12.83]) by smtp.gmail.com with ESMTPSA id
	q73sm9134691pfl.37.2018.01.31.07.07.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 31 Jan 2018 07:07:37 -0800 (PST)
Date: Thu, 01 Feb 2018 01:07:28 +1000
Message-Id: <20180131150728.20962-1-nathan@nathanrossi.com>
From: Nathan Rossi <nathan@nathanrossi.com>
To: bitbake-devel@lists.openembedded.org
MIME-Version: 1.0
Subject: [PATCH] fetch2: Handle missing donestamp file when content is valid
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
X-List-Received-Date: Wed, 31 Jan 2018 15:07:37 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In order to allow users to manually populate the download directory with
valid content change the assumption that missing the donestamp file
means unfetched content.

This allows users to populate the download dir without needing to create
dummy .done files such that a user does not need a PREMIRROR when using
BB_NO_NETWORK to provide valid content files in the download directory.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
 lib/bb/fetch2/__init__.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 6bd040493e..7f290bb930 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -643,16 +643,13 @@ def verify_donestamp(ud, d, origud=None):
     if not ud.needdonestamp or (origud and not origud.needdonestamp):
         return True
 
-    if not os.path.exists(ud.donestamp):
-        return False
-
     if (not ud.method.supports_checksum(ud) or
         (origud and not origud.method.supports_checksum(origud))):
-        # done stamp exists, checksums not supported; assume the local file is
-        # current
-        return True
+        # if done stamp exists and checksums not supported; assume the local
+        # file is current
+        return os.path.exists(ud.donestamp)
 
-    if not os.path.exists(ud.localpath):
+    if not os.path.exists(ud.localpath) and os.path.exists(ud.donestamp):
         # done stamp exists, but the downloaded file does not; the done stamp
         # must be incorrect, re-trigger the download
         bb.utils.remove(ud.donestamp)
@@ -662,7 +659,7 @@ def verify_donestamp(ud, d, origud=None):
     # Only re-use the precomputed checksums if the donestamp is newer than the
     # file. Do not rely on the mtime of directories, though. If ud.localpath is
     # a directory, there will probably not be any checksums anyway.
-    if (os.path.isdir(ud.localpath) or
+    if os.path.exists(ud.donestamp) and (os.path.isdir(ud.localpath) or
             os.path.getmtime(ud.localpath) < os.path.getmtime(ud.donestamp)):
         try:
             with open(ud.donestamp, "rb") as cachefile:
-- 
2.15.1


