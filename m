Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
	[209.85.128.46])
	by mail.openembedded.org (Postfix) with ESMTP id DF3A77F33E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:54 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id b24so5980285wmj.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=OHtUGX/Br4eAgwmyJV/rfUeX/iRxbMjwKHRGaArUQ+I=;
	b=Uh8Kwq/5zy6uNFn8Otv7LBMbtPOLGeE+occSYx6bRNN8PSGEDDy50+UP+Xioy3Hu3W
	LEBJFZmaUr6U708Kje0AbaeZHGt5lJ1E5dAeZCOSFh4doi0ZtDG0N1F4OsNWWJh8lG/5
	FNwtY44kc0HVM8Flf7Z81SHLPppO4tnx0CIVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=OHtUGX/Br4eAgwmyJV/rfUeX/iRxbMjwKHRGaArUQ+I=;
	b=s+sDOK2t7LqOyBDwOHy6W9/Txm/+5ayw65GsiwHRRLyerB0aqSS9a1FbIGUlJ5jaC/
	khOr3vx4nJ0mYf3dTdOSMRvYEjO3r11+5vbGFXmcPvrd0GCWZ6IoTUyMYxi3xnjGjwAj
	P/8CfRtwm5m5SKAu+nPOiU593QiFXzmI97CKJEC4jbuGDe7vvVzXEM7Kks4HQ0EfQ4r1
	ORlpMZPSMdjAjCuIMAhZ4Wu3EZq7LLSwHtXa2l7+GdkPX5fCD2IMeoURVmvNo3kPhFUd
	un6E3bbElb7J3UeHfLBb4dTlIa6khpNXrPW7+zyaYyNvfyYkYMsdlsKU03EsNiiNyHGh
	9UnA==
X-Gm-Message-State: APjAAAWGfmYttsx0qqOCCfatA+9VPHIx9CJnAD0gNl/vEpD/cT0TImOE
	ZUmEFne7tOauc6j0Y3+C/4t/gDyM1f4=
X-Google-Smtp-Source: APXvYqwOyebED6x/X0KJPGQ/GFBmCRFxGGv4aB+0F+wTpyF/MWabhKxy14BZhU3tj7ycKqSYJX6/OA==
X-Received: by 2002:a1c:2397:: with SMTP id j145mr6685815wmj.69.1569587635452; 
	Fri, 27 Sep 2019 05:33:55 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:45 +0100
Message-Id: <20190927123347.19276-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 7/9] runqueue: Save unihashes more frequently
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:56 -0000
Content-Transfer-Encoding: 8bit

There are some runqueue code paths where the unihash cache would not be
saved where for example only parsing or an occurred. Save the cache at the
end of runqueue generation to ensure entries are cached.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 29bfd65e0b..31de3ed1cf 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1443,6 +1443,7 @@ class RunQueue:
                 self.state = runQueueComplete
             else:
                 self.state = runQueueSceneInit
+                bb.parse.siggen.save_unitaskhashes()
 
         if self.state is runQueueSceneInit:
             self.rqdata.init_progress_reporter.next_stage()
-- 
2.20.1


