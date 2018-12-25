Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id 61ABE6010B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Dec 2018 11:55:38 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id y139so12745382wmc.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Dec 2018 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=hQ/Xa2LYTnIy7iJ0cX9rLGxg0IAcmQ67Ozp6dbClX2A=;
	b=Yc/6FBd0AtKATeL+JjC3kLIOSgJQV8u8F9nr2AJ+o6O+QlPsZ8PDTGltnBvr/hEEc6
	Ghm8WncBMKXx/yYGfNN2e3UD0d8SIWV3chCzc6kwaScUwwXBu1ndV4aNyZByJMz5wDqW
	Zr0MhHFcgMeshUFN3Fr7F9B0SqD+fUgxGkkoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hQ/Xa2LYTnIy7iJ0cX9rLGxg0IAcmQ67Ozp6dbClX2A=;
	b=gcH4CS9HB8ddAvHClWAvyjpGryrcRnZCG0J9gPNcS8up558bwzM3SmCqL/c7xf9D9u
	HJ5HofksgRGRyRZyEPkrtwh/O9OSNmuQKsA4PXtpzcpWzpr+xcePYtJBpILsTAsEQ1Vj
	Y/Qy5t70aH5EMbicADfqk9gQfGLj5uvGdAQOubck8cdMN5h7mNcQo3od36Tmf7d3SCyG
	eexWUNP/di1Pqun9KIa5ufgQSuzX2KdVG6tn06ekxw0EWosjMCR30MApUvUnwaogrRdq
	cOEByf86y6Bq1Pr5qRmTwxsWLaNsWpgdc7N0Tksw2mZ7MxDL1+WjlVIRdE1gLpl4t9w1
	EoXQ==
X-Gm-Message-State: AA+aEWat+ux9R0bc/zRNMkUbvOrFZhMZtoVSOpOGEIJ33NsfHuClXfuK
	v/6gGy8A9yslN3DbeNyhcRsJoAgu1QE=
X-Google-Smtp-Source: ALg8bN77C+vp7dX+ws/GYm2ZzozKQsAztUEwJwMjQzr/Inc0JnoUVc1MRQNcXhY1dosZCTkAlKMVUQ==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr15900783wma.114.1545738938800;
	Tue, 25 Dec 2018 03:55:38 -0800 (PST)
Received: from hex.config (5751ab90.skybroadband.com. [87.81.171.144])
	by smtp.gmail.com with ESMTPSA id m4sm26068209wmi.3.2018.12.25.03.55.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 25 Dec 2018 03:55:38 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Dec 2018 11:55:32 +0000
Message-Id: <20181225115533.10018-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181225115533.10018-1-richard.purdie@linuxfoundation.org>
References: <20181225115533.10018-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/4] process: Handle EWOULDBLOCK in socket connect
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
X-List-Received-Date: Tue, 25 Dec 2018 11:55:38 -0000
Content-Transfer-Encoding: 8bit

Now that we set a timeout for the socket, it can return EWOULDBLOCK
if a signal or other event happens to wake up even if we don't timeout.

If this happens, retry the connection, else we simply see it quickly
loop through the retries and abort the connection in a very short
interval.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index f1fbe3313c..1e4b51e35e 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -479,7 +479,14 @@ def connectProcessServer(sockname, featureset):
     try:
         try:
             os.chdir(os.path.dirname(sockname))
-            sock.connect(os.path.basename(sockname))
+            finished = False
+            while not finished:
+                try:
+                    sock.connect(os.path.basename(sockname))
+                    finished = True
+                except IOError as e:
+                    if e.errno == errno.EWOULDBLOCK:
+                        pass
         finally:
             os.chdir(cwd)
 
-- 
2.19.1


