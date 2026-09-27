Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65340C9830E
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 07:46:58 +0000 (UTC)
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32881.1790495201560456896
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Sep 2026 00:46:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Yugda2iI;
 spf=pass (domain: smile.fr, ip: 74.125.225.99, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so1338900f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 00:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790495200; x=1791100000; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dh8XAfyBiEqNjj/hoh7yhL2Z4aYhIihMsXEh3JFHXDY=;
        b=Yugda2iIX3pnXYO9qdsnhwoBe3hpSYdTpxoKxMUngHf60VZdB7v8ZYoPp0CrImDP8k
         8DPi1+7LznWgc6HrCPkehCsP9dkvZMPXBGhJ5a0Cz/XPBzz9N+zqrEUUu0dGVNdqe5YZ
         wQHkS9ly+56shuOU1klfNYQS0y0u1bczdju44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495200; x=1791100000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dh8XAfyBiEqNjj/hoh7yhL2Z4aYhIihMsXEh3JFHXDY=;
        b=IsfW+evV7PneB8yFIRzTp3te+z558hbdTVcQJmtYEsFDIenGEIukhbLJK7bAzsPMxG
         Eg6uwPxfTkowDG8AlPp47DvS/+torfebCwfwiCY1ow7EvZHYbYqtrSZYO8w/mpI0hdl2
         B5MIK/nFKRzoimVN1bOD5SXjXc1zp4YMwegkd/dyJC7SQKBGTtQrtVXKD5YWAh5YH7Z2
         Hs8Tx3titMgweF9+bml0IBsav3q+XG2f7/dneMzoDhmw4sTVtwNmX78Rg6MFWknrm75f
         tKd/lLWhYKYU5uQEGR/dON30eudPdDRvH/WtbmqaQPgU3voaOVXOmRo5wjlLLGQEz0pu
         iZ3Q==
X-Gm-Message-State: AFq9FYLjDWzlDOrp93JP8mx8Sw4Sm3u81GNeuP5yJJHkY8xfsSz9qUh4
	r2BGO+eoMs5Ca5Zl9QTdQ2UKKr3PROpWzsWoWy2SdRpjSfwM+NoCWB+PdkJiWmz88Y36lbOQJm3
	5TRuG+r0=
X-Gm-Gg: AYBFou1NydUNmNNIJDfFyeu0nCDZJBV23L4WMicajFJ3Xquus69bh6kPQgGxc4Zax51
	WeVoOuIwGQlm5sHpOu5Bbup2u1nmhcp9Nfo2A5ObotvJSFNEAGknn9F4FtgGwdBmVbZMTwMGyzf
	NdO3fSOr44u7fJ4jmPszsKIuH5FF6FZwy246Qkb8qC8Oyv7bkwuA9+i6lorh8lZ6R22bpDZzjvx
	5XeMab+Jnuy+ylX+jZ0ja957eDYOkCljF/OoEIHNd6se9vZlz0fP5i6Z2djb5j7lcfJ2kVbLz6/
	qk8dsnqQyLJT+iIXx0vipu6RUeCPP/1401/xyjhcVAek/sfNczzS03XO15oLZ1uvJ8ky5FcqpVy
	f1sdohDtXQjEitzn/AufVNSocdFNu4+iE90ZUKsfenCLCXC/DHwdzcmRmjfdLVWVz85bpgPk25/
	XxRXdEHNkG3tt7IQ0s42aEqVMA42+m7TIL4WKlWSx49jThGGFnTW0LzMVuqfi96srgAoUViMPl6
	50wa3O4llmSSrLbGdy3Po2e1jQBKsYMyHoiGqNHPfOIKuw448uxzVvRVLUW4ZAMwybpAp9shw==
X-Received: by 2002:a05:6000:40e1:b0:487:27f6:a4cd with SMTP id ffacd0b85a97d-488716a5fb3mr18846694f8f.29.1790495199749;
        Sun, 27 Sep 2026 00:46:39 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm18485266f8f.2.2026.09.27.00.46.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:46:39 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 4/6] fetch/wget: Handle long filenames correctly
Date: Sun, 27 Sep 2026 09:46:33 +0200
Message-ID: <65f17fdeeebfc0213cf2c809d08f7c4129fbe355.1790495161.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790495160.git.yoann.congal@smile.fr>
References: <cover.1790495160.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 07:46:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20263

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Long filenames, which may happen through sstate, were being handled incorrectly
as they could exceed max path lengths when '.tmp' was added.

Handle those cases by using slightly shorter filenames if that happens for the
intermediate tmp file.

[YOCTO #16293]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit da1fcdf15c647a2a718ae921e261a76e451b442a)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/wget.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index c292dfe7e..58f1a86e7 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -105,7 +105,10 @@ class Wget(FetchMethod):
         fetchcmd = self.basecmd
 
         dldir = os.path.realpath(d.getVar("DL_DIR"))
-        localpath = os.path.join(dldir, ud.localfile) + ".tmp"
+        # Where we ultimately want the file
+        finalpath = os.path.join(dldir, ud.localfile)
+        # A temp location while processing, keeping in mind max path lengths
+        localpath = finalpath[:250] + ".tmp"
         bb.utils.mkdirhier(os.path.dirname(localpath))
         fetchcmd += " --output-document=%s" % shlex.quote(localpath)
 
@@ -142,7 +145,7 @@ class Wget(FetchMethod):
 
         # Remove the ".tmp" and move the file into position atomically
         # Our lock prevents multiple writers but mirroring code may grab incomplete files
-        os.rename(localpath, localpath[:-4])
+        os.rename(localpath, finalpath)
 
         return True
 

