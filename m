Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8DB55606E8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 09:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4Q9wnxB028453; Tue, 26 May 2015 10:59:57 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id P-EiWIfIuNQz; Tue, 26 May 2015 10:59:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4Q9xixO028466
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 May 2015 10:59:55 +0100
Message-ID: <1432634384.404.0.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Tue, 26 May 2015 10:59:44 +0100
In-Reply-To: <D4CFEBC3-6C2F-4142-9DB2-9BCACFA3DE07@gmail.com>
References: <1432540432.29515.12.camel@linuxfoundation.org>
	<D4CFEBC3-6C2F-4142-9DB2-9BCACFA3DE07@gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Tue, 26 May 2015 09:59:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2015-05-26 at 11:56 +0200, Bernhard Reutner-Fischer wrote:
> On May 25, 2015 9:53:52 AM GMT+02:00, Richard Purdie <richard.purdie@linuxfoundation.org> wrote:
> >By doing this we can take advantage of the expansion cache before
> >starting write operations on the data store.
> >
> >Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> >
> >diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> >index 82eefef..218998a 100644
> >--- a/bitbake/lib/bb/data.py
> >+++ b/bitbake/lib/bb/data.py
> >@@ -156,17 +156,17 @@ def expandKeys(alterdata, readdata = None):
> >         if key == ekey:
> >             continue
> >         todolist[key] = ekey
> >+        newval = alterdata.getVar(ekey, 0)
> >+        if newval:
> >+            val = alterdata.getVar(key, 0)
> >+            if val is not None and newval is not None:
> 
> newval cannot ever be None in this if.

True, to be fair I just moved the code although I probably was
responsible for the original too.

I'll tweak it, thanks.

Cheers,

Richard



