Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B671CCF2C1
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 15:34:24 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8372.1792251259729888640
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Oct 2026 08:34:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZTSRdLaY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso530116f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792251258; x=1792856058; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RoQtv+9ckyr2YB0CWl9ywXNsyQzCKEd+ll21kjsE2qY=;
        b=ZTSRdLaYVj9SnsJPtumweeevwRuKiUdkbKDJX12+HZsb90H1tXa3hrofTig8FYwBaE
         /RdDJMX2fHjaOm1LGbgsHOqJ9s76a5atNKCPT0U0eJwnp76cNwGcR02Jb/shtsQkUU5P
         8LKWR5+4aWgHIY3P3Nw7v25fxlS67TzGeAa28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792251258; x=1792856058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RoQtv+9ckyr2YB0CWl9ywXNsyQzCKEd+ll21kjsE2qY=;
        b=J8KpI8C06QTxYR4gE3Nk1P1g2R0eaJm1ZvgHUPCa9QlL63/2Fy02LgYqGCLRs5woNV
         5IlwtFRqKXwLinnIPdtnYZ7bB0qSvFTjpKbS6Ns1Yzcpg/+v/luhwFklMQ3cfehzzIZP
         1SI3Z5tikSbVsLBWvMFuvo3YO1RNrQplXIRRkx+maqIufEXUPgugORLhkR7AnLWc7tOl
         zmgGZWr2vmzSvhebOLEpI9k0fRlaNjsP22guCDoFDen5dQeakvaQ4F6rJ3brIaPwVVUh
         J/+SQCdB/u80w/OiXUE5SE2VbSz+ELy2VYTB9sZajPIR9w8DHBAWVMybuIyJyzaQhvva
         PF7w==
X-Gm-Message-State: AFq9FYImT1evFxGSDz6RrB4Vdb9g6tOkViQ1oOMS0jWEs9TLz6n/8S9j
	K8QHQ8MmBR5Hbj/+phdROrLmEzOgUWYHcq/wyzKu1CZ41iIcFAr5vN+2/TceRkiW76wkSXK+oOt
	eidOXjF8=
X-Gm-Gg: AYBFou3LP2GEZ3G5DiTkgrxKVgRQJM9bU0jOxHTNUBWCDn/CK8xu/2aa7VFUTCVMkZo
	9xsyuKLJi6+n13JJ9KDQ7kjrOUDCdE5oKCpz2c1o6jx/SncRK4/lwl6MUCi+pWXbaZBfyw1yxeO
	PnoYUdxCyDwlxZy1WfE+dsJlgpyXu/fi/OJl5I0xGFgVLkEEpQdoF/+MXUGIV41L8O1srFs4o1q
	qOwwXqaM2QOf4LhV5Ma6fuCVNiUFSasVJh3hxKFYarh8JgBTgdxUZuitYxFPM/mE5t6uecu+vS+
	2MiYPm4ogDWyIxnT8UujTo5I0qsQftjMB89+gJE7MPn7fnIyp64jz7PH9DLuoZmlczbv+5K6l5U
	iuofgiQFKM8sCVXPCX9IRpJCUN5f2529YsDo5JZEoDP6z67czi72B6Qa6I35C0v1u4CHEKo7Cb3
	lDHVECY+iF94xPuLoxhVrQGwxtI7kT85n6LljRQ5O26CpG8ENKqfTqVhURFby1J5Y4sFx/XZt0q
	RQMYD+peAxA51tUkYPJHZdGJMM=
X-Received: by 2002:a5d:64cd:0:b0:488:79a2:3232 with SMTP id ffacd0b85a97d-48e07f9c8aemr5248197f8f.31.1792251257902;
        Sat, 17 Oct 2026 08:34:17 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:471d:9ae9:4cd8:a378])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50d1bcsm12015775f8f.54.2026.10.17.08.34.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:34:17 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] wget: Work around wget2 bugs in Range handling and --continue
Date: Sat, 17 Oct 2026 16:34:16 +0100
Message-ID: <20261017153416.78661-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 15:34:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20357

wget v2 has bugs with --continue and -O with servers that don't support Range: headers
such as python's simple http.server. Whilst likely not widely used in production,
this breaks some of our selftests.

For now, skip the continue option with wget v2+.

Bug filed upstream: https://gitlab.com/gnuwget/wget2/-/work_items/728

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch/wget.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
index b464fcfbe97..c554f162c04 100644
--- a/lib/bb/fetch/wget.py
+++ b/lib/bb/fetch/wget.py
@@ -127,6 +127,11 @@ class Wget(FetchMethod):
 
         fetchcmd = self.basecmd.copy()
 
+        wget2 = False
+        version = subprocess.check_output(fetchcmd + ["--version"], text=True)
+        if "Wget2" in version:
+             wget2 = True
+
         dldir = os.path.realpath(d.getVar("DL_DIR"))
         # Where we ultimately want the file
         finalpath = os.path.join(dldir, ud.localfile)
@@ -150,7 +155,11 @@ class Wget(FetchMethod):
                 fetchcmd.append("--password=" + ud.pswd)
 
         uri = ud.url.split(";")[0]
-        fetchcmd.append("--continue")
+        # wget2 has bugs with --continue and -O with servers that don't support Range: headers
+        # so we skip that for now with wget v2+
+        # https://gitlab.com/gnuwget/wget2/-/work_items/728
+        if not wget2:
+            fetchcmd.append("--continue")
         fetchcmd.append("--directory-prefix=" + dldir)
         fetchcmd.append(uri)
         self._runwget(ud, d, fetchcmd, False)

