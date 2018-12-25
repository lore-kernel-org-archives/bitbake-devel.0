Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id B15A06010B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Dec 2018 11:55:35 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id f81so13427386wmd.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Dec 2018 03:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ztfWrIYW9gXd3KyNtT7rzgFsxdjK7fx5wQGYScyEIk0=;
	b=MIWstEgNHtsdU9q4P4ihlD5v0tht0CdAULjl/9QdLsJfulv2Sct2D3kkqj/VqBHtIJ
	/c9P8CZ0EBqUdZfz3iqHVg2ufitHHfD6A5Bxv4ZSkJY3ww1mikFSZaUjY17tCBPmW9QL
	etYcvin88FlphNWx2LcgYSNaDdhMaPaIwleQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ztfWrIYW9gXd3KyNtT7rzgFsxdjK7fx5wQGYScyEIk0=;
	b=Vf5jDjwmaeVmNtR93C2QajdB0X/ZJcJjfYJfVKVMtONJoGYTBKXJNjzmKKebbBpvSo
	Prl6W9VeelTYAt3xjMHiySudlUpaO1QNkGZyMxlvQvmbcIcuSiwlY2igiZHIp88MSOpx
	zn9xZVUQCBFVvQsBu+BsIN/PDviZAyu5OIEEdX77XIFAYKgIcKQjPuCFMFCsARlMcRes
	OYVhO+vDvmfHkoUq5F0yCSlScQ9BrrbABaYBNYzsV+kNuFeJ6uvcqXEL89GNl2Z49E0x
	VaYctuxIKhzw9zFc/IIlSIffQvpaRBxCk3YKbrujEuBSm3NJ0rrPvXlQx2lx2VSGf3pP
	Gpmg==
X-Gm-Message-State: AJcUukfatz4JrrpwAfcRFY0GWXpXwqda6OMkcmEbpFORHL6BjrNIFmh2
	uMfNd5N+lDbKAGab5un7G3PDeVlHq44=
X-Google-Smtp-Source: AFSGD/VA9PoRzE9dCtUyMEN9nTK022t+MSKKlQjtV7839OfIxyqlaGWtDVpcRWqbZhjWbKN9CHfoXw==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr14991412wmi.58.1545738936050; 
	Tue, 25 Dec 2018 03:55:36 -0800 (PST)
Received: from hex.config (5751ab90.skybroadband.com. [87.81.171.144])
	by smtp.gmail.com with ESMTPSA id m4sm26068209wmi.3.2018.12.25.03.55.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 25 Dec 2018 03:55:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Dec 2018 11:55:30 +0000
Message-Id: <20181225115533.10018-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH 1/4] process.py: Set socket timeout to 10 seconds
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
X-List-Received-Date: Tue, 25 Dec 2018 11:55:36 -0000
Content-Transfer-Encoding: 8bit

The current value of 2 seconds has shown to be short in
wider testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index f7d07266cf..f1fbe3313c 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -474,7 +474,7 @@ def connectProcessServer(sockname, featureset):
     readfd = writefd = readfd1 = writefd1 = readfd2 = writefd2 = None
     eq = command_chan_recv = command_chan = None
 
-    sock.settimeout(2)
+    sock.settimeout(10)
 
     try:
         try:
-- 
2.19.1


