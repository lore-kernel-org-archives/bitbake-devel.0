Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.2614.1630532460620146004
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Sep 2021 14:41:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ftQKhyOf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id g135so751026wme.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Sep 2021 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XlZdp3mYwFtQIXpjDfv/kQoHsVREThkw2O4vgUeV+QA=;
        b=ftQKhyOf/ynsxquOlCBdYBD6FrCOSweitH/95+v1fkzAU8mEBpcMZLms0/dukMnSp+
         HmgoHeKwYpyG9RKkueEYdAkTgtMmqs+UPoODkjcr013+g7Of9ciebF69oWPc1OixNlI3
         IsmGbHw8ZzlR5y5Eh7f4CR1ZT/PbEzdAd5upE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XlZdp3mYwFtQIXpjDfv/kQoHsVREThkw2O4vgUeV+QA=;
        b=QDvGafP4HXNBrC9vo6gO4ApJe7qwiRElkfFWbdHJ3YWam21oBfY7iq9kBjlYdemSAj
         oXTZXInyYrtoBIJrrFXBbKtSZDK1lEaxEy1yaI63q1tSKfIEbeduLyuvVbDi2d555IX/
         lS6ulYQP35BtpxHQaXLLLI1fDaHMwQ2K6EGGvdaGT1w4FxFUxrEMWppERXVgCp7Fl+Jd
         XCgA9SqgHHu63vBwTlx6jM4hB5xfiwLKAbS6h+VSCetLhsEW4JQYYW9pDmum8RknmBTE
         YNDF1DnF3CykV6s1Blce+qYbc1KGyxMtg+mPNtmPxTnpzjlbjBB2AhLEAQv5FsbYxhuu
         x6uA==
X-Gm-Message-State: AOAM5300sedRRz+9jxtKNu+Yd+1st1HyX5XrCY2xDemz9zZ7I84Nml01
	gwaCI0qQ1qMoflHhxrvVpmZ+jw==
X-Google-Smtp-Source: ABdhPJzoeLBmln3oWWSRsK6mRPwRfR4PXfN0cjxSn4VRh7nP7KLAm3p7SvT3SUGBjlP1oZ+5AgUo9Q==
X-Received: by 2002:a05:600c:3b26:: with SMTP id m38mr1300410wms.155.1630532458876;
        Wed, 01 Sep 2021 14:40:58 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5a99:997:84da:190e? ([2001:8b0:aba:5f3c:5a99:997:84da:190e])
        by smtp.gmail.com with ESMTPSA id s12sm609076wru.41.2021.09.01.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 14:40:58 -0700 (PDT)
Message-ID: <e648cf6d7d613e0ee1d5ad7b3ff0d8b0d332e6db.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/1] RFC Bug in PREMIRROR
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Vishal Patel <vishal.patel@xilinx.com>, 
	bitbake-devel@lists.openembedded.org
Cc: mark.hatle@xilinx.com
Date: Wed, 01 Sep 2021 22:40:57 +0100
In-Reply-To: <20210901194456.2642587-1-vishal.patel@xilinx.com>
References: <20210901194456.2642587-1-vishal.patel@xilinx.com>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2021-09-01 at 12:44 -0700, Vishal Patel wrote:
> I think we found a bug in the PREMIRROR system where if both a remote and local
> PREMIRROR is defined, as well as BB_NO_NETWORK = '1', the system will fail with
> 
> bb.fetch2.NetworkAccess: Network access disabled through BB_NO_NETWORK (or set indirectly due to use of BB_FETCH_PREMIRRORONLY)
> 
> instead of trying the next PREMIRROR which is a local file:// based one.
> The attached patch only adds a test case for the issue, but does not fix the problem.
> If anyone can point me to where to fix the problem, I can work on this.

Thanks for the testcase, that does at least make this easy to see.

Running the test, it is clear from the trace that after trying a mirror, the
bb.fetch2.NetworkAccess exception is fatal and stops any other url from being
tried. That does seem not to be what the user would want.

I was going to let you debug that but I did quickly try this:


diff --git a/bitbake/lib/bb/fetch2/__init__.py
b/bitbake/lib/bb/fetch2/__init__.py
index 914fa5c0243..65d8c38af76 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1034,7 +1034,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         return ud.localpath
 
     except bb.fetch2.NetworkAccess:
-        raise
+        return False
 
     except IOError as e:
         if e.errno in [errno.ESTALE]:

and found that does make your test case pass. It also doesn't regress any other
test that I spotted in quick testing.

I'm not sure if that is the correct fix, I'd need to think about it a bit more. 

The question is whether if you disable the networking, you want errors on
network access or want the accesses disabled. Some people do want to know if the
network is used when disabled and BB_NO_NETWORK may mean different things to
different people.

Cheers,

Richard

