Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
 by mx.groups.io with SMTP id smtpd.web08.13336.1609365809514827333
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Dec 2020 14:03:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@stwcx.xyz header.s=fm3 header.b=tSylMsLx;
 spf=pass (domain: stwcx.xyz, ip: 64.147.123.25, mailfrom: patrick@stwcx.xyz)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id CEBA5906;
	Wed, 30 Dec 2020 17:03:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 30 Dec 2020 17:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=fm3; bh=vj2c6Q6NHhgGe
	hkcwVhtV0Bm+moPTtKTYpTbIEQZV6I=; b=tSylMsLxII9QEuFTjTaTft6rh09VQ
	lmiWDGxo2K91JoRMNF5z8Uy9TDkAjKKx55TPf/aeEoZpvni8YLk1BCdJbzTT0igO
	GtDA2jpwrCfxufM8NocijTAbZsSQwMXEAqs+S14UW54QFEahBpVfdG8ux1WQlhca
	F7IFrY7NhcVjSJCEPU+8ebju9YXf/AZTeP0PNi/KFzBvHKC0m2gTlaCxg2WY7Nz1
	3N86TdLXGmXreGCNemvVcXbSyO6ZiUSd8fkZHcuxq7BG0eJRvpLyPlZ3t6oG+zxl
	4IPrXkO7STLjb2Qsgcxh8hEXAuxAaWckrvwL3U/DvM06ZkNwvOFehZXVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=vj2c6Q6NHhgGehkcwVhtV0Bm+moPTtKTYpTbIEQZV6I=; b=HDCjRxpZ
	o1HvI4OKuG0UMrUM0PHSvaPN5O7XwYfg57e2TqqsE4yNPs+5kwhaH8nRGYX/pJzX
	D2SJYZLjG4Ri0JD8MiaumBIdYXYL+wa3u8oD3oywXR+onUu41lBcqoN2dNxtxo0X
	Cde73mmTgw9fUtl3Oc8ZTLCzlo8KvOgnP4rX+RnoPl7lNAHblEKm93ozSmQtyOxH
	dVHXKlJTypfef/jkyJgp/5RcFopvL+9fBRFA31yxxSvchYitdTBtkq2ddtwyDTbb
	PawiZLWLuOF5Fg604+R06aTSs2IQnhEo4TDKpWnS9QzcUjWV/7TSNFjsq9jAoZSL
	XwjmTScwk5sojw==
X-ME-Sender: <xms:LvnsXyhMdkC3o-1x-Zt4cNrt7m3Sh6RGPQ8Bxt34ebsBk0YZ-QrnMQ>
    <xme:LvnsXzB5oOde_k6eafP0X3QYcBaXTIclesWYFheC5L9aFWlFZ-yjuEC3CBitAjLGU
    jv5yeWkg-v8iB0GwJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvfedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghkucghihhl
    lhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrh
    hnpeduhfdvieejffeuvedvveetkeeltedvffeuhffhgeduhfdvieetudfgheeivedvieen
    ucfkphepudeiiedrudejiedruddvfedrudejkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:LvnsX6ER1Ru8b0J5pbNCrHF3OZjA3fF8nlQMVgDOUeMGpVK2yKreQA>
    <xmx:LvnsX7ST3mo4TeCTszsIIP3K2pY_j922y2u09-XBJhcbqNfGoe0UaA>
    <xmx:LvnsX_xfrPfGWEXhaK-G_6zIlqYX0eaMLB96pNeHecre-E1Ac7PH1A>
    <xmx:L_nsXwuiqEqgs1U63-znxFOk9cPjQEv08ZNAc4p9taAW6Mu-6B--vg>
Received: from localhost (mobile-166-176-123-178.mycingular.net [166.176.123.178])
	by mail.messagingengine.com (Postfix) with ESMTPA id 780AF24005B;
	Wed, 30 Dec 2020 17:03:26 -0500 (EST)
From: "Patrick Williams" <patrick@stwcx.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Patrick Williams <patrick@stwcx.xyz>
Subject: [PATCH v4] fetch2/wget: include parameters in URL
Date: Wed, 30 Dec 2020 16:03:23 -0600
Message-Id: <20201230220323.727622-1-patrick@stwcx.xyz>
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
 lib/bb/fetch2/wget.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index e6d9f528..0019f10c 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -91,7 +91,14 @@ class Wget(FetchMethod):
 
         fetchcmd = self.basecmd
 
-        if 'downloadfilename' in ud.parm:
+        # Join the URL components together.
+        url_parts = ud.url.split(";")
+        if len(url_parts) == 1:
+            uri = url_parts[0]
+        else:
+            uri = url_parts[0] + "?" + "&".join(url_parts[1:])
+
+        if 'downloadfilename' in ud.parm or len(url_parts) != 1:
             localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile)
             bb.utils.mkdirhier(os.path.dirname(localpath))
             fetchcmd += " -O %s" % shlex.quote(localpath)
@@ -99,7 +106,6 @@ class Wget(FetchMethod):
         if ud.user and ud.pswd:
             fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user, ud.pswd)
 
-        uri = ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
             fetchcmd += d.expand(" -c -P ${DL_DIR} '%s'" % uri)
@@ -441,7 +447,7 @@ class Wget(FetchMethod):
                     valid = 1
                 elif self._vercmp(version, newver) < 0:
                     version = newver
-                
+
         pupver = re.sub('_', '.', version[1])
 
         bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
-- 
2.26.2

