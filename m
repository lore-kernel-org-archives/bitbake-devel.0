Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 5347E6010B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Dec 2018 11:55:37 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id p6so13453985wmc.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Dec 2018 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=g4FHLSbG8wxktfbr7cINo7JM5F47OMTDt0SIbhzO4YY=;
	b=g4k71bBqxK5IBSkjUak/BWKrpnaTVE/Xy1FJ4ZmA0MlhlGGoNdzj5If3a6B4FiN8XM
	NxdzXuSg2Qqt3meixGFIvCLpd+sfYM6pfLJ5XAi5NevlLFsXnS/1Aqar43NrYF5g+zbr
	D5az6uuVaFKTYwj0KSJrpzLMckChEuOMP8CTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=g4FHLSbG8wxktfbr7cINo7JM5F47OMTDt0SIbhzO4YY=;
	b=TLqRGSrzoSqJczqAl+AMAnw0TfxA8gDj4mCmRTY+nB12FlZF+YB/+Ey8K4VuW/qD/Y
	kQOTFzHXo8zuK4oKe/ajf3AHmmb8dLLsICtD7zBMIXbqH1MaN44hfo7+4ql0yteTHIJk
	GA6GiajtSgxogAscqiGhO4CXhBBkYvMUmSNg0ZZ3cWHZlmLGq/eOOKc0byV/U7H0joPE
	ulYskvi3P4jiro+TNJ6xhwZQ5i0sxvA3OO2jFumK4B+LURnRthuTa1ABt9zuNuS0F1Cx
	m8mWOijzyjnB63T9PvbwOAHu//gCjMaDQoM1PNM574JDQUcOzXMyBEIvQxUo87oX78YI
	oekA==
X-Gm-Message-State: AJcUukcHqmxZv3BAB15MTcyEZvBdmT1vAbmYUBlhqs9fNg1Wiod6IBCl
	Cz4lyrQKRnUghKK+pegRDJA+2JlaDcU=
X-Google-Smtp-Source: AFSGD/V2z82aABOB4OjJGrr9YCfA9TAZKCUxqRTq4JbA4M71DCVf1B0Y7aWPeDoNsR1Qxrg/Hv4JyQ==
X-Received: by 2002:a1c:b14:: with SMTP id 20mr15568616wml.103.1545738937589; 
	Tue, 25 Dec 2018 03:55:37 -0800 (PST)
Received: from hex.config (5751ab90.skybroadband.com. [87.81.171.144])
	by smtp.gmail.com with ESMTPSA id m4sm26068209wmi.3.2018.12.25.03.55.36
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 25 Dec 2018 03:55:36 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Dec 2018 11:55:31 +0000
Message-Id: <20181225115533.10018-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181225115533.10018-1-richard.purdie@linuxfoundation.org>
References: <20181225115533.10018-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/4] main: When retrying the connection, show the attempt number
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
X-List-Received-Date: Tue, 25 Dec 2018 11:55:37 -0000
Content-Transfer-Encoding: 8bit

The current bitbake output makes it hard to know which retry is being
attempted. Add this information to the output to make it clearer.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 7dc953da66..41dd3b9e03 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -475,10 +475,11 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                 if not retries:
                     raise
                 retries -= 1
+                tryno = 8 - retries
                 if isinstance(e, (bb.server.process.ProcessTimeout, BrokenPipeError)):
-                    logger.info("Retrying server connection...")
+                    logger.info("Retrying server connection (#%d)..." % tryno)
                 else:
-                    logger.info("Retrying server connection... (%s)" % traceback.format_exc())
+                    logger.info("Retrying server connection (#%d)... (%s)" % (tryno, traceback.format_exc()))
             if not retries:
                 bb.fatal("Unable to connect to bitbake server, or start one")
             if retries < 5:
-- 
2.19.1


