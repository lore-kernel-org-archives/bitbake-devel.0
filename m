Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id BFB9965D6E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 11:50:07 +0000 (UTC)
Received: by wifw1 with SMTP id w1so27416921wif.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to
	:message-id; bh=ynEuFlU3im0ARG333bvhEyrwCc+OIEX6gvon2eex0rs=;
	b=DydP1bLO/YwvBMTGNhgfvT2btHicl8UEJLByZwj+tu9FNFmFLGSE4XRPPqklAYbRty
	5y4dM3Dwi/wb1ROoHLhggT7h6PlNY2zAstNQRejlfeP5eCbHf3vjqkM2o5StOhhKTwil
	23qBz8vuudQWgnZxUanYUFgCwJ3WogApgr1vY/rP3ap/GgH9ffR0+erm0f2U4WwQlVbU
	C27tVGXHGxCCz/s17sLb9+qmjU73x/AHDDb6KV+YmKZoxu5U0Cg8HPfOn4ayW6QY/HL5
	W3A/yXIHf4dwxSV7hN08XzW+Dh9JTo31cmqqncdcNTs3UKGd/pXL4p2iQYifF2i6hojI
	PyAA==
X-Received: by 10.180.100.197 with SMTP id fa5mr39782040wib.65.1432641008485; 
	Tue, 26 May 2015 04:50:08 -0700 (PDT)
Received: from [10.37.177.125] (089144201125.atnat0010.highway.a1.net.
	[89.144.201.125]) by mx.google.com with ESMTPSA id
	ww1sm21391898wjb.14.2015.05.26.04.50.06
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 26 May 2015 04:50:07 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <1432636862.404.1.camel@linuxfoundation.org>
References: <1432636862.404.1.camel@linuxfoundation.org>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Tue, 26 May 2015 13:49:56 +0200
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <C9291DC4-9CC9-4946-B964-B66D79783E2A@gmail.com>
Subject: Re: [PATCH] data: Clean up expandKeys None value	handling
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
X-List-Received-Date: Tue, 26 May 2015 11:50:09 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

On May 26, 2015 12:41:02 PM GMT+02:00, Richard Purdie <richard.purdie@linuxfoundation.org> wrote:
>This comparison is interesting even in the case of empty vales.
>Enabling
>this warning actually found a bug in the metadata in avahi. Make the
>code handle None specifically and also remove the dead code path in the
>second if statement.

LGTM, but I cannot approve it.
Thanks for the fix!

Cheers,
>
>Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
>diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
>index 0d9da4c..e7557aa 100644
>--- a/bitbake/lib/bb/data.py
>+++ b/bitbake/lib/bb/data.py
>@@ -157,9 +157,9 @@ def expandKeys(alterdata, readdata = None):
>             continue
>         todolist[key] = ekey
>         newval = alterdata.getVar(ekey, 0)
>-        if newval:
>+        if newval is not None:
>             val = alterdata.getVar(key, 0)
>-            if val is not None and newval is not None:
>+            if val is not None:
>bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key,
>val, ekey, newval))
> 
>     # These two for loops are split for performance to maximise the



