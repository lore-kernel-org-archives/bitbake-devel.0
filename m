Return-Path: <sujith.h@gmail.com>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
	[209.85.220.193])
	by mail.openembedded.org (Postfix) with ESMTP id 5403871B0F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 09:57:35 +0000 (UTC)
Received: by mail-qk0-f193.google.com with SMTP id h201so16769700qke.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 01:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Mz45ZVdmwb7JHdmDJzWMIxy7gMJzbBrFeDoGy702psI=;
	b=Yn1mARSSBgg/wby3RLssIGcaWpF3P4ml6CDW0CFSh6S+oU4d3Xz96YSN3ms0oIXgzx
	X/2LVnLMV3SIHD7I9usgId5ZjYrJb3rRAu7OjF95cbfYUbiQDY6fCetaBM97+uIhioUV
	sNrthpJzt9oQ1nfyyoa2MVmBEc5LhzyNwhqWdMuJW9UtfCVomewOkwdzKpafBAsVf2zJ
	U2A8WUY1yI0Q9OHguwxto6rdXdC7ZYwgX03Ofo7jpHhKq2Diqmpeca8i3fDbKtnhC9Xc
	8eULCZn546LLFNh5jBXmfoFVGCrXE62/sZ5udg2gLbMCei6Es8nZu97/sV0DCjvn2//z
	9RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Mz45ZVdmwb7JHdmDJzWMIxy7gMJzbBrFeDoGy702psI=;
	b=mMV4Mjwzh+JT7G8nWi+WPWTrHi8B36fWZaw0ZrnYmsO8+/ilUXHxFZkxsc3DXQ3jrl
	cSVnToc3gscouhyKFp72/IDUKEwelQBBiz9uYGFCKqzilw6tFEtZzqOwrcyFM4K4+pC5
	c15WAC/JWGWMKQVsDNzSQMum2qJ+WA298c4vmQuK1Ho9hF9E05SGniGe0Vg4KqA0yDmO
	hK5Moo2tqXjEsPPBZL+asPrIq9+MORpP7qg+HVJYtm9jJ5pNaImAbv37Ad5vHbOkavvJ
	/apueacSROfzvJk2x2MW/JgCtyDS+Sq/2q0roSTUX7VxD6Gn93ozTxaEWfieVfsw8+C2
	iw2g==
X-Gm-Message-State: AKaTC03MvTiN5CAkW1Qf8Vbe1HsMQnbK+fsFymXYZfAaHIcTM+SFrJxWlH40qDFGHewh+A==
X-Received: by 10.55.110.69 with SMTP id j66mr25977887qkc.92.1480413457185;
	Tue, 29 Nov 2016 01:57:37 -0800 (PST)
Received: from kdekidd0.inp-wifi.mentorg.com ([139.181.35.34])
	by smtp.gmail.com with ESMTPSA id
	m129sm30414129qkb.48.2016.11.29.01.57.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 29 Nov 2016 01:57:36 -0800 (PST)
From: Sujith Haridasan <sujith.h@gmail.com>
X-Google-Original-From: Sujith Haridasan <Sujith_Haridasan@mentor.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Nov 2016 15:27:29 +0530
Message-Id: <3bd6cc67f0c3973b554f0a77e1db5b96318bea82.1480412829.git.sujith.h@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1480412829.git.sujith.h@gmail.com>
References: <cover.1480412829.git.sujith.h@gmail.com>
Subject: [PATCH 1/1] bitbake: cooker: convert type which needs to be marshalled
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
X-List-Received-Date: Tue, 29 Nov 2016 09:57:36 -0000

From: Sujith H <sujith.h@gmail.com>

We assume that the value taken by variable v can be string,
integer or any type which can be marshalled by xmlrpc. This
change would help us to convert the non marshallable types
to string. So that we don't get exception from xmlrpc.

[YOCTO #10740]

Signed-off-by: Sujith H <sujith.h@gmail.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index c08af45..1dab450 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1488,7 +1488,7 @@ class BBCooker:
                 v = self.data.getVar(k, expand)
                 if not k.startswith("__") and not isinstance(v, bb.data_smart.DataSmart):
                     dump[k] = {
-    'v' : v ,
+    'v' : repr(v) ,
     'history' : self.data.varhistory.variable(k),
                     }
                     for d in flaglist:
-- 
1.9.1


