Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web09.2726.1630532893709033067
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Sep 2021 14:48:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NAUI9K53;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so499636wmh.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Sep 2021 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cIr940ENAGWWkHVa3BI4+Fivngog7xlC58zpXhJfxBE=;
        b=NAUI9K53VUuTEMePoQWWb5SqUpo1ELc3iHeDyRvui6n3Sb6bG3W4faXjIzJVM8VMCw
         hgt3v83azaQfmLL1KRz4Em2gH1jrtW7yTFKVjYIl/aEnTbJWjstwqNPtpW3d1IBL/Jh6
         WsPm6U1vo/rJwstSYWEX2u85YLPDkTxPr2wd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cIr940ENAGWWkHVa3BI4+Fivngog7xlC58zpXhJfxBE=;
        b=G4GPXJYFLZgL0PoaFSNdf54FMrxeYrYasohndjk8/Yb35/QZfnnfQPbsChhp+Tl9J5
         oif7ZTV4GNVdXPxIlUeoFNaXnHL9Y1H4UApuM/SO0j+3Yudu4DaPzgghh2OdYJ+D9cKV
         Rb97Vd5ZmB/4r13OA6RDDu3xC4Z4FbYwgvoGNwvMCLfaM6g9Hjumkzz5yRxDiV1Zk/Lk
         ZOI9vMbrWqtCgwrqDPYhIcuIsZen88nnNZtLcPyoll0tacINARWM4xYFG9pa+41pPK2E
         IqCLcGVb2psimKpd4UXJlUpIE/AuKNWWD1xku7bHddICwviFBPX5baVS/LkZvNPg/rHT
         2tXQ==
X-Gm-Message-State: AOAM532oF6K9z0oTtBGyGm5laKvTEYtdyBpHmHUQRghpRsZ+egViD4oU
	8Ejy3h8B3AGU5rfetQ2/aTNBHw==
X-Google-Smtp-Source: ABdhPJzeEp7q6OTLSuu0D1IzlbFXMLjSs7C4oYQ1YGsjbfZ7QcpxjOozkcwEp3R2dyRlQWoZdkzn+Q==
X-Received: by 2002:a05:600c:3b9c:: with SMTP id n28mr27286wms.184.1630532892102;
        Wed, 01 Sep 2021 14:48:12 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5a99:997:84da:190e? ([2001:8b0:aba:5f3c:5a99:997:84da:190e])
        by smtp.gmail.com with ESMTPSA id x11sm584647wmk.21.2021.09.01.14.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 14:48:11 -0700 (PDT)
Message-ID: <6a79e01d5b0ccdf43546528662a119bbb0ffaf68.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/1] RFC Bug in PREMIRROR
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@kernel.crashing.org>, Vishal Patel
	 <vishal.patel@xilinx.com>, bitbake-devel@lists.openembedded.org
Cc: mark.hatle@xilinx.com
Date: Wed, 01 Sep 2021 22:48:11 +0100
In-Reply-To: <b510348a-a95f-fab8-d756-e2bb15b57bf4@kernel.crashing.org>
References: <20210901194456.2642587-1-vishal.patel@xilinx.com>
	 <e648cf6d7d613e0ee1d5ad7b3ff0d8b0d332e6db.camel@linuxfoundation.org>
	 <b510348a-a95f-fab8-d756-e2bb15b57bf4@kernel.crashing.org>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2021-09-01 at 16:46 -0500, Mark Hatle wrote:
> 
> On 9/1/21 4:40 PM, Richard Purdie wrote:
> > On Wed, 2021-09-01 at 12:44 -0700, Vishal Patel wrote:
> > > I think we found a bug in the PREMIRROR system where if both a remote and local
> > > PREMIRROR is defined, as well as BB_NO_NETWORK = '1', the system will fail with
> > > 
> > > bb.fetch2.NetworkAccess: Network access disabled through BB_NO_NETWORK (or set indirectly due to use of BB_FETCH_PREMIRRORONLY)
> > > 
> > > instead of trying the next PREMIRROR which is a local file:// based one.
> > > The attached patch only adds a test case for the issue, but does not fix the problem.
> > > If anyone can point me to where to fix the problem, I can work on this.
> > 
> > Thanks for the testcase, that does at least make this easy to see.
> > 
> > Running the test, it is clear from the trace that after trying a mirror, the
> > bb.fetch2.NetworkAccess exception is fatal and stops any other url from being
> > tried. That does seem not to be what the user would want.
> > 
> > I was going to let you debug that but I did quickly try this:
> > 
> > 
> > diff --git a/bitbake/lib/bb/fetch2/__init__.py
> > b/bitbake/lib/bb/fetch2/__init__.py
> > index 914fa5c0243..65d8c38af76 100644
> > --- a/bitbake/lib/bb/fetch2/__init__.py
> > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > @@ -1034,7 +1034,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
> >          return ud.localpath
> >  
> >      except bb.fetch2.NetworkAccess:
> > -        raise
> > +        return False
> >  
> >      except IOError as e:
> >          if e.errno in [errno.ESTALE]:
> > 
> > and found that does make your test case pass. It also doesn't regress any other
> > test that I spotted in quick testing.
> > 
> > I'm not sure if that is the correct fix, I'd need to think about it a bit more. 
> > 
> > The question is whether if you disable the networking, you want errors on
> > network access or want the accesses disabled. Some people do want to know if the
> > network is used when disabled and BB_NO_NETWORK may mean different things to
> > different people.
> 
> I thought in the past it just skipped them but stored a message or something
> about the networkaccess.. then if it couldn't find anything it THEN displayed
> the message.
> 
> roughly:
> 
> try... ohh network?  capture exception
> try next...
> try next...
> nothing found, print exception message (and since it's PREMIRROR don't fail,
> continue to regular download and then MIRROR)

It does that about general failures but network access is different. Some users
expect it to fail immediately for any access.

Cheers,

Richard

