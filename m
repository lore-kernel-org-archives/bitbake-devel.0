Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id BF6826B06A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2018 14:02:21 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id s14so5805251wmh.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2018 06:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=D7qhXG7pmK9iesP53VkPruNSkjSpCsVHEzrm1BEB5Fc=;
	b=BasSJdA700Fn9QglAo+ksp2Q+GxXme7okNvOSpPA+Q6ZTYuvut9/NXVngDvb1STuu1
	PzmTW4p6rBXb2OB4gWccO6OajhrM5VJmxheGogZ/nFW46prpgZkKAVAvSRJ74ty9RSs9
	wcnZVGtmfIjLjUHWsTvYenXOwlBBF7fK/OzCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=D7qhXG7pmK9iesP53VkPruNSkjSpCsVHEzrm1BEB5Fc=;
	b=Y42eN1HKtlMAjdYcqZOD1NurwNtusQ+C+3wmyFDcFft2+UJqpFcMQr68Ijwopji7xo
	8JKEqvpApJZw4sUapKeAxLccPE1LA9/FWwrhoRbyvGLuiUcSrcDO2aDgRGMs61VhL5Ew
	IMm9UHMjSMuLsUXlSJ5AQawc32w6MLBKUr330xQtu5gwjK/yX/f+hfAVcBbYbH/Y7QdS
	ISFmVupYhmulleabpVo/LPa5LkzkJvcFG0vdXo3YSh1x0SZWv2D3LwLoObCnkrkRg217
	8c0i4QyMQK4X88T5rm98yoF41JB7J1YKJfUBhjRDmE0x/UbXjQbW5cdFli6A2RVqt3Gw
	C4Bg==
X-Gm-Message-State: AA+aEWZ8b9si+39L+OaKUjNwFJ2O7+KMg8MDmkm+7yDtzoo5VdFFIqYe
	w7yszXHKX+/xhYkwCl5tZ/0rH2DVBSowPg==
X-Google-Smtp-Source: AFSGD/V+ZHDTi7XGx+IM9AAQljnZo5KpxjmYLikfYKeZ5pjxnlH08FMhLf/UXaPHlIOVTYzXGIaFgA==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr3202934wmm.52.1544796141503; 
	Fri, 14 Dec 2018 06:02:21 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	y13sm5859489wrw.85.2018.12.14.06.02.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 14 Dec 2018 06:02:20 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Dec 2018 14:02:17 +0000
Message-Id: <20181214140219.1553-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH 1/3] data_smart: Add missing regexp markup
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
X-List-Received-Date: Fri, 14 Dec 2018 14:02:22 -0000
Content-Transfer-Encoding: 8bit

Fix some further python3 warnings about unescaped regexs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 67af38050e..297a2f45b4 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -39,10 +39,10 @@ from bb.COW  import COWDictBase
 logger = logging.getLogger("BitBake.Data")
 
 __setvar_keyword__ = ["_append", "_prepend", "_remove"]
-__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>[^A-Z]*))?$')
+__setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>[^A-Z]*))?$')
 __expand_var_regexp__ = re.compile(r"\${[^{}@\n\t :]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
-__whitespace_split__ = re.compile('(\s)')
+__whitespace_split__ = re.compile(r'(\s)')
 
 def infer_caller_details(loginfo, parent = False, varval = True):
     """Save the caller the trouble of specifying everything."""
-- 
2.19.1


