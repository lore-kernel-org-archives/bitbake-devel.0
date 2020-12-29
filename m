Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web10.17699.1609276649790628022
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Dec 2020 13:17:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stwcx.xyz header.s=fm3 header.b=Sqw0X7dT;
 spf=pass (domain: stwcx.xyz, ip: 66.111.4.27, mailfrom: patrick@stwcx.xyz)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 127C45C0156;
	Tue, 29 Dec 2020 16:17:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 29 Dec 2020 16:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=fm3; bh=t/5bF8aJzBhDL
	wp2aArZRKIDfYUAXSTSXP81R3C08Fg=; b=Sqw0X7dTIPNZPwblVPQpUcsP8+IyF
	azOP5R2EUpoFsUovV8WRDXiv2wzUEyBZAV66johfTM8FWPLwGYXU9rhZctL2ZDT0
	4/n56mrZhErqbH9kMYpB5xinx7/gEkJoJg0AodEqutt7SXz/kj2v2Zyr5f7BKXf3
	3GIqgdAGHAUgZmjPLW6wyw+WYKDC33q8Nt3Oyb/lBguVH5Hzo0IIhFUihxMGuxua
	Hndnqa43EKsxHMhxIQKWjgPyYaJNv7Ehk+L64dDofwSLt9vsprLBSM5t8XmTiTtr
	bGlIJQh74p8+k9KTKDOZKeUOpC9oo9UNod6dqsK31JYety+Ku8DrQFLXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=t/5bF8aJzBhDLwp2aArZRKIDfYUAXSTSXP81R3C08Fg=; b=DLU0WguM
	rmomLb7/rCH1iYyD2gGL5zv9xmbXOMJjtLQ8DP1miIPkvramUJotCmRFG2H6RAYa
	RFl13fgr2BF7JEMH7Z+SgTGj4rhvHcLKIwV8L4XXibz6VNVw4ts4u+ZMW+bhqfaU
	2G/JMYyFG7IXbDiSxWpWnONDlevewfI1+OTlY6jgj2RI0cfsFW2gpA+otn9dWTCa
	PG26jnWBuzbuKXvpx6RHoBYi9cb2hxFl+oWcdqf8U0D6MarUAa1Azui6WAuFF/no
	9wt52w3jqDtz758aVGaL7enhNb+NL/xyqzD3QeMN1kOwOPXrwlpnmJvYCA2yID3D
	MAdL6/U5kwuwEA==
X-ME-Sender: <xms:6JzrX1bO2ydCQX4mXOMoko5vN2eQJwxOG-ZAjkSGJlUnQaaFziYHCg>
    <xme:6JzrX8Y6NoeRr5Kd-knnrEtNK3Y4IZvd3kfyxjqW1iLriDgsH3iVXyzvyzCah9vDq
    ycYjsuXe6OuqRNPiEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghkucghihhl
    lhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrh
    hnpeduhfdvieejffeuvedvveetkeeltedvffeuhffhgeduhfdvieetudfgheeivedvieen
    ucfkphepudeiiedrudejiedruddvuddrudefleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:6JzrX39CzSR2BPRkrJj1rJgW2LyBPxYLAa0PKhtWH1saeoa5bSNiSw>
    <xmx:6JzrXzrWGsmqmsBZCxL4IZ364JjebGx_bg5Gznb35212FYXnvoX1qw>
    <xmx:6JzrXwoXocKw2nBK3yHQDTjEdD6TWG-gDBzWdYki3M1LAGsQoBvADQ>
    <xmx:6ZzrX2HA4AT4WPQ015BAfUWgUde29SERYN9cwjQIApZkcKWj-dgCMQ>
Received: from localhost (mobile-166-176-121-139.mycingular.net [166.176.121.139])
	by mail.messagingengine.com (Postfix) with ESMTPA id 562AD1080059;
	Tue, 29 Dec 2020 16:17:28 -0500 (EST)
From: "Patrick Williams" <patrick@stwcx.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Patrick Williams <patrick@stwcx.xyz>
Subject: [PATCH v2] fetch2/wget: include parameters in URL
Date: Tue, 29 Dec 2020 15:16:57 -0600
Message-Id: <20201229211657.32034-1-patrick@stwcx.xyz>
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
index e6d9f528..d9432c5b 100644
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
+            fetchcmd += " -O '%s'" % urls[0].split("/")[-1]
+
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
             fetchcmd += d.expand(" -c -P ${DL_DIR} '%s'" % uri)
-- 
2.26.2

