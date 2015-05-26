Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id D8B2265C78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 09:56:15 +0000 (UTC)
Received: by wizk4 with SMTP id k4so71168742wiz.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to
	:message-id; bh=sUdVD0ENy9fShjqXlhyrvmjMdLYcrnPszC89R8Z5dss=;
	b=XIhf2ExwsmBH5a/SVh8PjLxzWdetLP2NmAy9rAlA4rhTs3Ym3qpFj62KoA3LnQ6XUv
	QrjsgoSGW4nuTwCCgrf6ySzEJxnC4aXaI9lzF/a2fREM4sTgOP0gNymhdvtJOLv3bmDS
	Uc9WtGHlZy/ImxwPXggP/Gw9LZXWgqCx9kpwDpnPTKRXVFryiV+N0yRs7NT16zY4wrqj
	5YDTdI+G9i1nZY65tQ/vPS+cmxt6x2s+V3f/DjsLKnnF11OUBJaO/3JxYp8ikEa3kqS/
	YrRHGgQR21nK2itMFlOIsa02nOnGu4hcxfFnBuWxECODNUgQp3P2C7rTQsH3LkFiqDzS
	CqAA==
X-Received: by 10.180.38.70 with SMTP id e6mr30639059wik.91.1432634176053;
	Tue, 26 May 2015 02:56:16 -0700 (PDT)
Received: from [10.37.177.125] (089144201125.atnat0010.highway.a1.net.
	[89.144.201.125])
	by mx.google.com with ESMTPSA id n1sm16044147wix.0.2015.05.26.02.56.14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 26 May 2015 02:56:15 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <1432540432.29515.12.camel@linuxfoundation.org>
References: <1432540432.29515.12.camel@linuxfoundation.org>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Tue, 26 May 2015 11:56:10 +0200
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <D4CFEBC3-6C2F-4142-9DB2-9BCACFA3DE07@gmail.com>
Subject: Re: [PATCH] data: Move warning code to the first loop	for performance
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
X-List-Received-Date: Tue, 26 May 2015 09:56:17 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

On May 25, 2015 9:53:52 AM GMT+02:00, Richard Purdie <richard.purdie@linuxfoundation.org> wrote:
>By doing this we can take advantage of the expansion cache before
>starting write operations on the data store.
>
>Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
>diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
>index 82eefef..218998a 100644
>--- a/bitbake/lib/bb/data.py
>+++ b/bitbake/lib/bb/data.py
>@@ -156,17 +156,17 @@ def expandKeys(alterdata, readdata = None):
>         if key == ekey:
>             continue
>         todolist[key] = ekey
>+        newval = alterdata.getVar(ekey, 0)
>+        if newval:
>+            val = alterdata.getVar(key, 0)
>+            if val is not None and newval is not None:

newval cannot ever be None in this if.

Thanks,
>+                bb.warn("Variable key %s (%s) replaces original key %s
>(%s)." % (key, val, ekey, newval))
> 
>     # These two for loops are split for performance to maximise the
>     # usefulness of the expand cache
> 
>     for key in todolist:
>         ekey = todolist[key]
>-        newval = alterdata.getVar(ekey, 0)
>-        if newval:
>-            val = alterdata.getVar(key, 0)
>-            if val is not None and newval is not None:
>-                bb.warn("Variable key %s (%s) replaces original key %s
>(%s)." % (key, val, ekey, newval))
>         alterdata.renameVar(key, ekey)
> 
> def inheritFromOS(d, savedenv, permitted):



