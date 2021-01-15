Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.91.1610733945334421381
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Jan 2021 10:05:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fhs4Ie5G;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id d26so10163503wrb.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Jan 2021 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=OG03ubsSglpaoWmYPiKuHJ9fEBxBKQAmInEZYmFn8Y4=;
        b=fhs4Ie5GJstX/1y4A0BoGtyko3br/RmpN2xHC4GistcPiu3zZLwTjX1NeEdWRSyqO8
         sPDfSBdmkmm1rDjdwG6egRK4KS9tEOYB6kRt743x+0m2eZ36O7pILW/zGTTKA8O0Ijm5
         qYSJnkUQkbFRbViNl2f+AGHH95ZS4zrFXzPjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OG03ubsSglpaoWmYPiKuHJ9fEBxBKQAmInEZYmFn8Y4=;
        b=MZD/O6Jyp56nOT3tKD9mUPSOI53OK9tENztyQ4nwVP2nk9q6jwwnyL7IRRj2chVdNr
         h/oJwkNIJP93eKLORsU/dsW0dysNNI2XLnGns8YeGazrEr3zf4GuwojgrsLB0xGZPI5J
         PqkWFwwnM7nKYAMYwsXDpgKblR6/A55goEw0GSjMCz4o9GLtXki9NEhp9DVH+QcBFLgK
         rpA0QYAmnaOG0L6tDh/DV5GkcmLB++hltt8Dq0pteWAm3I0S1epqS6aonbOPM2OunRPI
         4fmiiPniXNNOXmRHfsk7C7VjyxAF/FSx+jYIolQWVly4NnhJfUUKfA5wxmVEnTU93wED
         +iZw==
X-Gm-Message-State: AOAM531SYx4CKSd4ipIZqbKQ5g7r/B+g/KgS2E2I+IYpv+dp2Qyw6AAH
	ihRZ4i08OLefsr23+9XD8I6t+w==
X-Google-Smtp-Source: ABdhPJwgi9KDLbGltfqomEcOi9GbO66zy/tH1tBAGLKHfHuAEq1yF9LiOenciRmH4+tcEoNsG+ot/w==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr14162991wru.120.1610733943964;
        Fri, 15 Jan 2021 10:05:43 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:974a:2423:c71:b423? ([2001:8b0:aba:5f3c:974a:2423:c71:b423])
        by smtp.gmail.com with ESMTPSA id c13sm12097930wml.44.2021.01.15.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:05:43 -0800 (PST)
Message-ID: <1965f946aa345b7a820c94194c8011de0cd64bdc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Perforce.py tar filename
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Katu Txakur <katutxakurra@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2021 18:05:40 +0000
In-Reply-To: <CAM1ZcoWA6pT9iVunDREWGNMCY8DbbF_diUB_O_epnDLQsQspbg@mail.gmail.com>
References: 
	<CAM1ZcoWA6pT9iVunDREWGNMCY8DbbF_diUB_O_epnDLQsQspbg@mail.gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-01-15 at 15:38 +0000, Katu Txakur wrote:
> Hi,
> 
> The file 
> https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2/perforce.py
> that fetches code from Perforce repositories sets the name of the tar
> file stored in the downloads folder in line 136:
>     ud.localfile = d.expand('%s_%s_%s.tar.gz' % (cleanedhost,
> cleanedpath, ud.revision))
> It only cares about the path but not the 'module' where it will be
> mapped. I had two recipes that map the same folder, but each had a
> destination folder with a different name. When building an image
> containing both recipes, the second one took the tar file in the
> downloads folder created by the first one. As a consequence, the
> mapping was wrong and the image failed to build.
> 
> I fixed it by adding the module to the name of the path. Is this a
> bug or a design decision?

Sounds like a bug to me, a patch to fix it would be welcome.

Cheers,

Richard

