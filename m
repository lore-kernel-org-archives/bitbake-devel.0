Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.9600.1617811555037261674
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Apr 2021 09:05:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DvLPQZHD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id k128so9313684wmk.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Apr 2021 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fhe5nis+6BH77bIZGblxSwXNHCZ4hhLVBXuFfI7w1nc=;
        b=DvLPQZHDciFQp8SHLgi2a+3/qqU7tJ1U50hVXXXaplc6RI7K37DYfz3WgYuxn+dQ8o
         DIwZtGWO4tGEkn3y6GROWZCJstkAXtOaGdlXUvd9dUswxbQYyqv1Rn1tEDRSTr/bwg4k
         jXGMiyYBYYwzwjf49vg9+SKPDfSl0d/W7BYJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fhe5nis+6BH77bIZGblxSwXNHCZ4hhLVBXuFfI7w1nc=;
        b=KJUes4JKeQ4p3NTAPTq9IgSzy88s8iSzKCbOR+NbKH6JrJrMWqug+kWWG3S/nK/UC3
         JfEjca+I/hWkvlgaabDkdSRhxslA6vqvMz4babFusL7mpuH4nXIhS7lMDM4h0F832fRB
         RFED+VdU1NWWFPNFis+KozhnL2A6BGIrqektEu6pKCKbwOZvGY0e+CbpldPNz3dWzYQA
         1eoxIr7Kbc5J2bwekqE7cY9ALV9tU6mwqoOcTDWlPst4en4Z+pXB8o6n4mWOBSsmTL4q
         wB9F0e2DtiCdT3uT1joAGwbU0NZ4z9LQn+iOymneMMvsrDLl4qra+RewYZ1E46niicsn
         5G7w==
X-Gm-Message-State: AOAM531Hw9S4Aqrq2fq1W1Ar5OUq0EYLujZNiMcg4HLal5gwMUjk4jZd
	fw3ZjvN/SfZksE0rl1eYvKZZyQ==
X-Google-Smtp-Source: ABdhPJy4QnI7g1KKz6hFUC4uO4fXNlnwZlvSgwkWQhIGHe1fufitqXH+v55JWYQLie8ZKzGqBvB5ZA==
X-Received: by 2002:a05:600c:3325:: with SMTP id q37mr3964213wmp.45.1617811553524;
        Wed, 07 Apr 2021 09:05:53 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:82e4:10af:e1ba:c8de? ([2001:8b0:aba:5f3c:82e4:10af:e1ba:c8de])
        by smtp.gmail.com with ESMTPSA id d123sm9337857wmd.26.2021.04.07.09.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:05:53 -0700 (PDT)
Message-ID: <53c07da6cd95fdf97d86e64efb888a16b57e2c61.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] still confused about valid wildcarding for bbappend files
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Mark Hatle <mark.hatle@kernel.crashing.org>, BitBake developer list
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 07 Apr 2021 17:05:52 +0100
In-Reply-To: <e6ccc6d4-ebb-22e4-ca87-e1cf328a2ed6@crashcourse.ca>
References: <e66c2878-5f82-394b-e6a-ccd45dc44c73@crashcourse.ca>
	  <4d45946c-442a-53eb-53e9-b480a2b83112@kernel.crashing.org>
	  <5166362-3350-5421-72c5-3eea3ca947fe@crashcourse.ca>
	 <3984862b382b08d5da05f740d86075d8f2acd322.camel@linuxfoundation.org>
	 <e6ccc6d4-ebb-22e4-ca87-e1cf328a2ed6@crashcourse.ca>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2021-04-07 at 05:02 -0400, Robert P. J. Day wrote:
> On Tue, 6 Apr 2021, Richard Purdie wrote:
> 
> > On Tue, 2021-04-06 at 12:34 -0400, Robert P. J. Day wrote:
> > > On Tue, 6 Apr 2021, Mark Hatle wrote:
> > 
> > As Mark says, the above is what is documented and meant to work. 
> > Easiest way to figure this out is to check what the code actually
> > implements to handle it. The code (from cooker.py) says:
> > 
> >     def get_file_appends(self, fn):
> >         """
> >         Returns a list of .bbappend files to apply to fn
> >         """
> >         filelist = []
> >         f = os.path.basename(fn)
> >         for b in self.bbappends:
> >             (bbappend, filename) = b
> >             if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
> >                 filelist.append(filename)
> >         return tuple(filelist)
> > 
> > so it actually truncates the expression at the first % and ignores 
> > anything after the first one. That is there to chop the bbappend off
> > but can obviously chop off more.
> > 
> > meta-security/recipes-kernel/linux/linux-%_5.%.bbappend
> > may as well be:
> > meta-security/recipes-kernel/linux/linux-%.bbappend
> > 
> > so matches a bit more than expected and
> > 
> > meta-anaconda/recipes-gnome/gtk+/gtk+3_%.%.%.bbappend
> > is effectively
> > meta-anaconda/recipes-gnome/gtk+/gtk+3_%.bbappend
> 
>   ok, i can submit a patch to clarify that in the bitbake user manual,
> with the understanding that it's *strongly* encouraged to use this
> feature for wildcarding the version number only.

The only guarantee we're making is the one we've documented, the rest is an 
implementation detail. It answers your question about what those bbappends
actually do but I really don't want to document the implementation details
as that then becomes the required behaviour.

Cheers,

Richard


