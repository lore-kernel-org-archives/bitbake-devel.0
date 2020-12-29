Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web08.18642.1609279070727137773
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Dec 2020 13:57:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stwcx.xyz header.s=fm3 header.b=kJ70xpfo;
 spf=pass (domain: stwcx.xyz, ip: 66.111.4.27, mailfrom: patrick@stwcx.xyz)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 115805C012F;
	Tue, 29 Dec 2020 16:57:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 29 Dec 2020 16:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=fm3; bh=BSJFgJkRypEh9
	ZrslIQmNWAUsRZEOIXywTuvV8WpyDo=; b=kJ70xpfo5f/2m/OHIZMZgot54XjzF
	5ki00Cv9euXGS9nZ/NBoKFBvo/q4qChp7pcGLdY5QIDV/SjTulA2lkxM5x1yxga2
	0AUZj3rIwd6wiJf77LQzRA7zaDIISEC01V8MqJg2zuPbk4n99x2yo5zVHGRp59A3
	1mXnYeOAHpk29v08hvlEyM2gXMHY/jBbRRgDx8UTp8xaPFNB8jVtLGA8UEeP3rig
	0s1OBpC05LyPXyHOjivMlXTCYW4uRB8fFi0XFlev/LZxsiQzWfRdoa8NTYTfqFSQ
	JUe2EugIC6oodv03QbAyDHPJWUfc8gZKJ00Q/lrWPZyaJbQnq/vCkY/Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=BSJFgJkRypEh9ZrslIQmNWAUsRZEOIXywTuvV8WpyDo=; b=n5nr3Z1T
	xHoprtPU+gfeofebWjlxIG4ANJm+k2ofg+S8MsqVyKfUQQFRnWSf5EmZ1x7WMMXb
	UxTPtK1WNtln/JgG6T8+OaCynAad7o12pANXc8tfJC70zi96WZLuHK0YZQ/ErGgP
	tx/3mtzdBFxLBBb7gmGNS2WPu6UAYMe8eF3KV1ds9W5CO9U4O6UFT3vC41Oml5T6
	zfxlJKMmCKoOyPC7ogqRo0Kh8sJSfM8W7yCsMKey0s17nzAcOWanX8F8oM/tw1yV
	60jK2QHVCUcWK2DLw8v6LlrRHE2X6e8POczD/QRDGO1huVvZ5zNvcDrF7Lpw7aQ/
	ut61eAQZOE3yGQ==
X-ME-Sender: <xms:XabrXyaZGFYX0d3W-yvPeBKlkSKxszpe1l22DBcvruZbt4hkgIzkyg>
    <xme:XabrX1Z1Dy2ptZ9R88WtVbwE7vfh3Jr9D3s8UOOe3AFM0TLkNUQUdyMJcZHhhf4o6
    XGSR5YJ4X3UtpXpMW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvuddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghkucghihhl
    lhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrh
    hnpeduhfdvieejffeuvedvveetkeeltedvffeuhffhgeduhfdvieetudfgheeivedvieen
    ucfkphepudeiiedrudejiedruddvuddrudefleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:XabrX8-RqMnfV1hxDwEhNQuJp8DlaEANv2HyIrbMBSwyIaZ0ztkYMA>
    <xmx:XabrX0p7fYEDKp6wKQeVVU_jqFzU4K2FiUwy6cYgkA79x2XI1w96pQ>
    <xmx:XabrX9q-re-hzfs0nHJIWt4CuiytmK7PHrK6OCDieZbjTNCtIAt_5w>
    <xmx:XqbrX_G8EDj2njCMhXReS9pZ6JVEWWRFnTVzmuv3cRFA3Bu42ONVMw>
Received: from localhost (mobile-166-176-121-139.mycingular.net [166.176.121.139])
	by mail.messagingengine.com (Postfix) with ESMTPA id 682331080064;
	Tue, 29 Dec 2020 16:57:49 -0500 (EST)
From: "Patrick Williams" <patrick@stwcx.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Patrick Williams <patrick@stwcx.xyz>
Subject: [PATCH v3] fetch2/wget: include parameters in URL
Date: Tue, 29 Dec 2020 15:57:46 -0600
Message-Id: <20201229215746.69819-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201229151316.165171-1-patrick@stwcx.xyz>
References: <20201229151316.165171-1-patrick@stwcx.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wget fetcher currently silently drops all parameters and has
been that way since it was originally introduced in fetch via 080eb8764.
This prevents use in SOURCE_MIRROR_URL and SRC_URI which require
additional parameters.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 lib/bb/fetch2/wget.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index e6d9f528..80baf04a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -99,7 +99,14 @@ class Wget(FetchMethod):
         if ud.user and ud.pswd:
             fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user, ud.pswd)
 
-        uri = ud.url.split(";")[0]
+        # Join the URL components together.
+        urls = ud.url.split(";")
+        if len(urls) == 1:
+            uri = urls[0]
+        else:
+            uri = urls[0] + "?" + "&".join(urls[1:])
+            fetchcmd += " -O '%s/%s'" % (d.getVar("DL_DIR"), urls[0].split("/")[-1])
+
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
             fetchcmd += d.expand(" -c -P ${DL_DIR} '%s'" % uri)
-- 
2.26.2

