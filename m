Return-Path: <anibal.limon@linaro.org>
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
	[209.85.167.196])
	by mail.openembedded.org (Postfix) with ESMTP id B785F6D458
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Oct 2019 18:42:41 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id k9so15704615oib.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Oct 2019 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=5BjdIQkui8C1FAbi7kwNRXKXY9zDhkKKGbDrI7AGv0M=;
	b=aVQh/v4d7QKPqjhvn7fUnOCauXx9u2zFZ2fugUHasHN36DGyNE7yH4FPrSol4+HhKM
	BZoHRqous8ZNEZKTvpVEMloVNmLVGgphkN0+7dqTT8Cqkv/dPisP/oFKLZe35OdAdKhf
	vXrgzwjHvLskuH90moWlgEvZytpgydpyPKfSawd5T/X82K8Ql9irU3HxmBLzXZ8QBnZR
	YGaghHzR1ROVDtpvjl0lMAHn3xMkp275ELCuYq6QT7z7gvvEE9+LlIKQvbV2WL1ihCMR
	zKYa+LwjsLkB6KKhmYmDlsiK+P9Z4L2FdBcBGyDDHxJRxFQWDS1kuIUcXM9WXpfZ7IPe
	PASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=5BjdIQkui8C1FAbi7kwNRXKXY9zDhkKKGbDrI7AGv0M=;
	b=OmAjiYLQGYqPxfC4Uun4YUGdDzgqshs4YY3pMPwrIEorP1M6JW50zFG1KJUyEAfn4o
	bFgW9kSZBNQfd1RDvu6CqCSJBsO2iFe49IGjMErvT3yPV5rjLmVQG182ko3Oi+Fj2cwf
	aucXURHoaUSUu68vos4mxeNsN0US8FXJuFpMyeUqa79b8zkWd23ql7x8gCRUkGpCUslw
	BaQnq0g8Qn2iTEltP6fD25UzWvVil8CnOPdcY2qjaeZ+w782c3W8qeKLMXdFZIPG7TZ6
	d9sThn2NA5sQYakZQeP8A5Jd3v72j2MxdU9eUgGWCgNQDZJZBou8KfHP63tzRhm7dcFL
	pxqA==
X-Gm-Message-State: APjAAAXRjKGh275WmYyKpunOr7SHx3t99o3sO21BNUYzQVSFaE7Obxu/
	gn0pSi6rq3uGFnMaxedZ7fZxiM0z5p8=
X-Google-Smtp-Source: APXvYqz+KIyZ8DGe+Bl0QmccgTN3xI2cJsQcxtui/XcluVRoS8yozuW2VgeBMvqwtz87ABH+doHUng==
X-Received: by 2002:aca:5dd5:: with SMTP id r204mr4890147oib.73.1570560162420; 
	Tue, 08 Oct 2019 11:42:42 -0700 (PDT)
Received: from blackbox.rga.ip ([2806:109f:4:c458:908a:c7ff:fe6a:e9f5])
	by smtp.gmail.com with ESMTPSA id
	f205sm5915372oib.11.2019.10.08.11.42.41
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 08 Oct 2019 11:42:42 -0700 (PDT)
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Oct 2019 13:45:12 -0500
Message-Id: <20191008184512.20130-1-anibal.limon@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Subject: [RFC][WIP][PATCHv1] lib/bb/checksum.py: Speed-up checksum gen when directory is git
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
X-List-Received-Date: Tue, 08 Oct 2019 18:42:42 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In some cases people/organizations are using a SRC_URI with
file:///PATH_TO_DIR that contains a git repository for different
reasons, it is useful when want to do an internal build without
clone sources from outside.

This could consume a lot of CPU time because the current taskhash
generation mechanism didn't identify that the folder is a VCS
(git, svn, cvs) and makes the cksum for every file including the
.git repository in this case.

There are different ways to improve the situation,

* Add protocol=gitscm in file:// SRC_URI but the taskhash is
  calculated before the fetcher identifies the protocol, will require
  some changes in bitbake codebase.
* This patch: When directory is a git repository (contains .git)
  use HEAD rev + git diff to calculate checksum instead of do it
  in every file, that is hackish because make some assumptions about
  .git directory contents.
* Variant of this patch: Make a list of VCS directories (.git, .svn,
  .cvs) and take out for cksum calculations, same as before making
  assumptions about the . folders content.

Signed-off-by: Aníbal Limón <anibal.limon@linaro.org>
---
 lib/bb/checksum.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 5bc8a8fc..ee125cb5 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -86,6 +86,19 @@ class FileChecksumCache(MultiProcessCache):
             return checksum
 
         def checksum_dir(pth):
+            git_dir = os.path.join(pth, '.git')
+            if os.path.exists(git_dir):
+                import subprocess, hashlib
+                m = hashlib.md5()
+                head = subprocess.check_output("cd %s && git rev-parse HEAD" % pth, shell=True)
+                diff = subprocess.check_output("cd %s && git diff" % pth, shell=True)
+                m.update(head)
+                if diff:
+                    m.update(diff)
+
+                return [(pth, m.hexdigest())]
+
+
             # Handle directories recursively
             if pth == "/":
                 bb.fatal("Refusing to checksum /")
-- 
2.23.0


