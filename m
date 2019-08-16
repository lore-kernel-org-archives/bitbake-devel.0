Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5B3F27F2F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 14:46:02 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id g67so4285407wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=mA/DbJZuuTzbBRgNmT6IqcsJcCmVxObn5JjmRCwXVRY=;
	b=PVIh1sdecjby+nB6VxT758uVSP29BulDzTuG15mxhfrOI3LSIdBlu+X5W0q4Fvp/DA
	dYr+tTHeo2eqbCu1P6fpPJ7fchGKrOWD4bAQKeEi/sfXd7iMvqSiqVvwRpAAogN1Bwm5
	UmhI7wv4U14qYdJ6TBMDwplh0ASNXSnEgm6ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=mA/DbJZuuTzbBRgNmT6IqcsJcCmVxObn5JjmRCwXVRY=;
	b=Oy/lt7d5H3AQChj1W7LZ1QcugZASsJkEUD2ELo89q6ADaIy/UD2sAEQf6K/cS/6EfN
	MrxM6dl5a3Iwmz0weQug/oT4Vjua/M1iCd10iGCFHaBxBO41/JPJVWm5DaXcjEIIjOvR
	g3ewV1R/83tBJN6DA9fZMUvcU0r/0f4WMsJTOLtnFe+4HmRkmYJiXrDMN6XDQ2jBv1V9
	ryZ+1bEWa2+/JgYS3CdgwI62LljzQeghn4Gv8nIILcoJxDATG2SUQHKZ8zFoh7x/iA++
	BN7LrMqZ5LRu47t0Cm/ozz+6kyzZrs4DoBVfF5wegqgIQU1qwqu0wENI4A6JBZEeL5l2
	u4gA==
X-Gm-Message-State: APjAAAUXZxaYqqBRtGA8rvLWKqtMs7OwAVj9ASFdah9iJeKZwt6m4zre
	rc+Arx4w8ZcNzwxL+bGIAOVsQ5sY8qp56Q==
X-Google-Smtp-Source: APXvYqzabhC2Ef7FON4+cnSDmlbYaowudn5Dk7ED+/VpmTyQs0nzZVquH/qB3ijjIMzG16d/pckL4g==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr249506wmk.97.1565966762640;
	Fri, 16 Aug 2019 07:46:02 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	q3sm6126651wma.48.2019.08.16.07.46.01
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 16 Aug 2019 07:46:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 15:46:00 +0100
Message-Id: <20190816144601.20352-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/2] cookerdata: Delay the setup of the siggen slightly to allow metadata defined siggens
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
X-List-Received-Date: Fri, 16 Aug 2019 14:46:02 -0000
Content-Transfer-Encoding: 8bit

If we define a metadata siggen it can fail due to the early init here. Move
slightly later to avoid those failures which allows fixes in OE to the
check-layer script related to the hash equiv siggen.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 144e803b4f..96a8e6beee 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -268,11 +268,11 @@ class CookerDataBuilder(object):
 
     def parseBaseConfiguration(self):
         try:
-            bb.parse.init_parser(self.basedata)
             self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
 
             if self.data.getVar("BB_WORKERCONTEXT", False) is None:
                 bb.fetch.fetcher_init(self.data)
+            bb.parse.init_parser(self.data)
             bb.codeparser.parser_cache_init(self.data)
 
             bb.event.fire(bb.event.ConfigParsed(), self.data)
-- 
2.20.1


