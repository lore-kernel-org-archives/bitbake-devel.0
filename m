Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C53C433EF
	for <webhook@archiver.kernel.org>; Fri,  6 May 2022 14:20:48 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web08.10175.1651846839344228631
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 May 2022 07:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=VbAqvgrm;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.27, mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 92DE25C015C;
	Fri,  6 May 2022 10:20:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 06 May 2022 10:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1651846838; x=1651933238; bh=itqOLOEdJ8x1vupENosBcaALK
	MwY8Pl79KUiF0NRa20=; b=VbAqvgrmofFWdHw9Ow/8jU77YGR7pAduhpXrib3qM
	e2437tz2PxqQ3DQYYll2RZkHXOFAR1evhzDFZu44o0WZ79P6MRxjwEqp/c+pJk7n
	12/USRKg9jtLdJVtPsimDu2Xnvozpd+81WLJcAWgj9XaB4saIz/F2B/V2eoj1vvz
	xzDFvfemV93G5oUrlv0xTN6feaYsjsM7Ul8bRr2+lCh/o7yGZ3GCLrpujyN39tjf
	+/wuCbHCLJTEDVB/XSjZmFsLkZCzIJzxl8riAlhIMzm93wwwXsg2EpV3b/JK+TH/
	/Ab0WiVzCRoR4+7PxNi7v+doApFsIoBFgADugmmaOvL9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1651846838; x=1651933238; bh=i
	tqOLOEdJ8x1vupENosBcaALKMwY8Pl79KUiF0NRa20=; b=KgTQszHFK4SS/k/W9
	/TeBBillbSy9Io8L8DQDdOD3MKUao0C8ce6ng4ax3FkSvVPleFIQJpP1/h7j4bTP
	oHcjiYzLMTbA1ml+TGdKErrdSxFYco1jX8vyt0CFNbqNVEGuMSGLwCXhT/8E1Fmj
	Rf5cVpcRxw9RUF/J/1FrU+uXCLSBovzCZmkBRA7p1F79Drz5d2HolJshyQxabPrb
	UQfzABtDNh1uU/7cMOvuKSPUvxMp8k++1HP99/OAbxfnSajhvq+h863AYkkOS6Sp
	rz4MIySVGnzJwQ+PdoD4SAeDhQovu5xxsg3u5ARbcejtchyzoXC+x3M/LOqI8Q4R
	SdMJg==
X-ME-Sender: <xms:ti51YoawCRlcdF9yC_8yEq4YsbhB6KFW_pvyK-9RrdTMAoDc6vTnjQ>
    <xme:ti51YjapNpUxDTp-h40jUPJhzh4GcZp-Y-nvMjiJUZogMZWzmlxUBUMfzKQNJvDA-
    1EfYPAHsq_U6dcaT78>
X-ME-Received: 
 <xmr:ti51Yi_odG2c85MY-53yxAqyiuoNwtLIYUcUVuPj3uq3k0cq7brHIV7G4Hm9QllYYwt55mZBIe9qHnqJkXBTEWo>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheprfgrvhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhf
    fhdrnhgvtheqnecuggftrfgrthhtvghrnhepieejgfeiieehtedtgfduheehgfdtfeeftd
    elffevleffieehkeffteevkeekkeejnecuffhomhgrihhnpehuthhilhhsrdhtohenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghvvghlse
    iihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:ti51YiqCmLXw9Pd0J7SjzOD-B-bipxGON6E3PwlLlRyrGzcQPXCsAw>
    <xmx:ti51Yjrs3P3-41tJQvr4vRDX4aLznn5F9NYVKkDgG44AmYDUs53uaQ>
    <xmx:ti51YgRNqyUoiMkMDA1qY-qkBw_djqzbCiReIVREvd3WJUU1DTkq1g>
    <xmx:ti51YsDo6SL_UBFpN0mUH1RO5Pq-kSixkHEuTVqdAQHsVtSzLF1GZw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 May 2022 10:20:37 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH v3 1/3] Honour BB_FETCH_PREMIRRORONLY option
Date: Fri,  6 May 2022 16:17:33 +0200
Message-Id: <20220506141733.3298-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 May 2022 14:20:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13674

This should fix [Yocto 13353] and related to [Yocto 13233] as well.
Previously if git repo mirror has been updated in between of two builds
fetcher of the second build didn't try updated mirror but switched to
git clone from upstream instead. This is problem for offline builds.
Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
specified by the mirror doesn't contain SRC_REV.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/fetch2/__init__.py | 2 ++
 lib/bb/fetch2/git.py      | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ac557176..c99cd104 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1745,6 +1745,8 @@ class Fetch(object):
                             done = False
 
                 if premirroronly:
+                    if not done:
+                        raise FetchError("Failed to download premirror {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREMIRRORS")))
                     self.d.setVar("BB_NO_NETWORK", "1")
 
                 firsterr = None
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index bdcfa497..e556f297 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -353,10 +353,12 @@ class Git(FetchMethod):
         if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
             ud.localpath = ud.fullshallow
             return
-        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
+        if os.path.exists(ud.fullmirror) and self.try_premirror(ud, d) and self.need_update(ud, d):
             bb.utils.mkdirhier(ud.clonedir)
             runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
-
+            if self.need_update(ud, d) and bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
+                    raise bb.fetch2.FetchError("Premirror doesn't contain revisions {} and "\
+                            "upstream cannot be used due to BB_FETCH_PREMIRRORONLY setting".format(ud.revisions))
         repourl = self._get_repo_url(ud)
 
         # If the repo still doesn't exist, fallback to cloning it
-- 
2.35.1


