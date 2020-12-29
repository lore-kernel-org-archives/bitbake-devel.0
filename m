Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
 by mx.groups.io with SMTP id smtpd.web11.12848.1609254806743989788
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Dec 2020 07:13:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stwcx.xyz header.s=fm3 header.b=XPLTc0Jx;
 spf=pass (domain: stwcx.xyz, ip: 66.111.4.25, mailfrom: patrick@stwcx.xyz)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 0B3A45C0117;
	Tue, 29 Dec 2020 10:13:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 29 Dec 2020 10:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=fm3; bh=RpIO1BjupKxiwcfYNreGOlaavP
	BXdiFR+WwQezhR8Qs=; b=XPLTc0JxhwqPcheP25N7XoC7WJIsg520Xdb/oimMCa
	9IAS2NrtU7S+lH8XB98Ai9+eFqS7o3ICMZa2g+hh+4B+LZxG4dLi0782oKeQy3Ca
	/jaiGX5RIhSJuP8yQcp0/XWlFzLBO0yP6zdwf23RAysH560fsTSF9TBERWGRNxTI
	r3Oq3IRwrQ0Cp4m0HTwgF2CdZUspCBjptDlnCQkz3LCBMSXTZQFW2anzxOMN8jom
	8ov0SWoZIvIVROgWFqEK+qwhSBoK4jS3eyMLnng/j6X6XmuV/1lnMhnfXAHPiR+H
	uEiIovar0ltgvc8+F3/qzmUjWoEOmSeB4eaPtHD/7hvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RpIO1BjupKxiwcfYN
	reGOlaavPBXdiFR+WwQezhR8Qs=; b=LNmm4+M5g1TOdpVDTE4BhBX7FXb/z6Zuu
	QLjdWbfQLnt7mFKqZVE5HQc/VSpVpmzCpUkTGPiKiA9gwNJq817AK9nUPYtBTMOU
	FDR/G3eaxqA3snT1kXycKEIeiG/AdjvWgVmvc2TFBDLweUF/SXCQFgE2c1DAqTJ9
	F0gzN9gRHrMnbIzpP2iJ+AQay8gvhmBabW7CrNIdCdFe1gY2SClfgTuIz/nEIMq6
	n5lKWNtFExEMIyI+uEf9Pebx2qLvgKKjmgnf2Tcw6Cv/jX1Wzrylx6d1khOkoYV0
	yVTi4JvT03hON69nxM2sNQywyAIFmO8NYMAaGu4YDCqE3GEseHQEw==
X-ME-Sender: <xms:lUfrX1dO_BoPa34ZXADsG6FkcerXhMBqYrR-gAdV1WfrssMIIDq9Vg>
    <xme:lUfrXzOh-R2-U0Hh4CPWlZWlIZx9jQgT1eWskvSt1HNb8VK5YRAGfSebN8olQqhD_
    ipsURNsDNjqS8v7kWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvuddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgr
    mhhsuceophgrthhrihgtkhesshhtfigtgidrgiihiieqnecuggftrfgrthhtvghrnheptd
    eludegheejteelheduudegkeehleetfeekiedtfefgleeifeelhefgveejhfffnecukfhp
    peejiedrvdehtddrkeegrddvfeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:lUfrX-jMgdbpOgAkFB-5FMCHsiL8t-IN5StlSmwzID--tYBRpPJJQQ>
    <xmx:lUfrX-8aIE7GClzIHHvapsGFjPm_nDHQYK74tjYmzutzZSXKSaorJg>
    <xmx:lUfrXxv2dW7uUfehtB93ZRJ7GFgMJW_tRiteywonDx3aPXCx4TjQcA>
    <xmx:lkfrX26nb1FJ_7rKESK26OybN7DUa0KcXTZ1gS3xRLZjXY99RLLgww>
Received: from localhost (76-250-84-236.lightspeed.austtx.sbcglobal.net [76.250.84.236])
	by mail.messagingengine.com (Postfix) with ESMTPA id 409221080057;
	Tue, 29 Dec 2020 10:13:25 -0500 (EST)
From: "Patrick Williams" <patrick@stwcx.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Patrick Williams <patrick@stwcx.xyz>
Subject: [PATCH] fetch2/wget: include paramters in URL
Date: Tue, 29 Dec 2020 09:13:16 -0600
Message-Id: <20201229151316.165171-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wget fetcher currently silently drops all parameters and has
been that way since it was originally introduced in fetch via 080eb8764.
This prevents use in SOURCE_MIRROR_URL and SRC_URI which require
additional parameters.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 lib/bb/fetch2/wget.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index e6d9f528..d41d7408 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -99,7 +99,13 @@ class Wget(FetchMethod):
         if ud.user and ud.pswd:
             fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user, ud.pswd)
 
-        uri = ud.url.split(";")[0]
+        # Join the URL components together.
+        urls = ud.url.split(";")
+        if len(urls) == 1:
+            uri = urls[0]
+        else:
+            uri = urls[0] + "?" + "&".join(urls[1:])
+
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
             fetchcmd += d.expand(" -c -P ${DL_DIR} '%s'" % uri)
-- 
2.26.2

