Return-Path: <kristian.amlie@cfengine.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 50DB06FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Jan 2016 09:40:32 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id f206so203645274wmf.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Jan 2016 01:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cfengine.com; s=google;
	h=to:from:subject:message-id:date:user-agent:mime-version
	:content-type; bh=WZhFT2nV09rpVjKs1enoAtJFnG+cieWfS0TPAuhTvOo=;
	b=h3sgJO4nRCWsfRoS41lQPIzFC+6egW1AGmv5b3rAhxOgaLmwKz307K+0tddxU+rwvK
	6/FLSGqE+W55ItELWz5x8bNklSAkIL/4Tn+ZUEKL0pIiLDhi9A/kIZcFTez6fvDmG+BF
	PKAbULCwiQbclwcEj9AARRFlsLbv2COXf2D40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:to:from:subject:message-id:date:user-agent
	:mime-version:content-type;
	bh=WZhFT2nV09rpVjKs1enoAtJFnG+cieWfS0TPAuhTvOo=;
	b=c7+M7pFfVGcM/YhDKB/eUfIEIHFn3WRXMPU++9kaBZ9kq5/ooY8zJPVPjRnN1QYAZ2
	Zx9F3wKybo3diFP/rt7OyazZUIVhb6xMihviraD0GCASr6Pkwdoq5PsBhM11/gGashof
	qg3kMU45bzZWJplwjIG81ZAMbvbGnKocfWuOeyoNU7GFNZCbPmLe13ZlBtyTKunnuRx+
	FS/hj2lIo7iQZmC0LlGFiw4AZi69ZvTvOmceAPwQ3Xuqjl71Q0Yqd4K0NcGwcDp8TsoX
	G4PGc/drSBlAKrmV/7F8T+Aa/JrGvmQjnRwBZAEhU0vxGRtaFBajvaO6XkPtWzuG2Fdo
	wQwg==
X-Gm-Message-State: ALoCoQl1+LxmUaPofIkbliCa0hinuod5GhoDNdQA7nxFBgebml//Pusw8L6SrOjlU6hSiiwvutcg28AxN+A1SlFWSirmp3kPFg==
X-Received: by 10.28.125.147 with SMTP id y141mr11790004wmc.18.1452505232947; 
	Mon, 11 Jan 2016 01:40:32 -0800 (PST)
Received: from [10.25.0.170] ([195.159.140.90])
	by smtp.googlemail.com with ESMTPSA id
	z65sm11920033wmg.10.2016.01.11.01.40.31
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 11 Jan 2016 01:40:32 -0800 (PST)
To: bitbake-devel@lists.openembedded.org
From: Kristian Amlie <kristian.amlie@cfengine.com>
Message-ID: <5693788E.3060007@cfengine.com>
Date: Mon, 11 Jan 2016 10:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.4.0
MIME-Version: 1.0
Subject: Patch to add missing "errno" module import.
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
X-List-Received-Date: Mon, 11 Jan 2016 09:40:33 -0000
X-Groupsio-MsgNum: 6847
Content-Type: multipart/mixed; boundary="------------040200070006050206070907"

--------------040200070006050206070907
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The patch should be self explanatory.

-- 
Kristian

--------------040200070006050206070907
Content-Type: text/x-patch;
 name="0001-lib-bb-fetch2-git.py-Add-missing-errno-module-import.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-lib-bb-fetch2-git.py-Add-missing-errno-module-import.pa";
 filename*1="tch"

From 0be670809c610469ad0d9f4e1975b46dd7bb7023 Mon Sep 17 00:00:00 2001
From: Kristian Amlie <kristian.amlie@mender.io>
Date: Mon, 11 Jan 2016 10:32:28 +0100
Subject: [PATCH] lib/bb/fetch2/git.py: Add missing "errno" module import.

This goes undetected most of the time, but when updating a repository,
if the ud.fullmirror file is not present, you end up getting an
exception instead of carrying on because the errno module is not
loaded (specifically "if exc.errno != errno.ENOENT").

Signed-off-by: Kristian Amlie <kristian.amlie@mender.io>
---
 bitbake/lib/bb/fetch2/git.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 4a32a31..9c04da0 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -69,6 +69,7 @@ Supported SRC_URI options are:
 import os
 import re
 import bb
+import errno
 from   bb    import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
-- 
1.7.9.5


--------------040200070006050206070907--
