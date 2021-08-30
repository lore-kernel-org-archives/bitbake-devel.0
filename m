Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web09.2876.1630355857317449008
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Aug 2021 13:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L9Rw5VqY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso853204wmi.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Aug 2021 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=b6DrXS8khYavefCriFueFixi9h6/sdZymgPjcwVaqkw=;
        b=L9Rw5VqYHObVBla29heKos6ReA0ULKUun0MttYj42KLU90wppSG8zutKxjMz1Pry8f
         JOzX0qx+LjOWFoMTu53ch1qoDn/l9KmzqagjwipJfaJpRqRizs1jXSkSIpzJe4C8jn0q
         AJT9NLoT7fTq7YPxx7v0k4azBNgENTCYimlrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=b6DrXS8khYavefCriFueFixi9h6/sdZymgPjcwVaqkw=;
        b=trfuyAcpZ2+lZ5J1BlA0l5jopJBWjxn9q7e6HaBbVsQILpbx5n2Thtr++2P8gC4nEL
         ZibjxjDxwP9JT/jEItG5RvkGccl5ENJNbq1Fw4tpFIGAEvvMtM19uXYCIvbLyDSfrSbS
         G2Y/LkrRh4occ9bMVPLrTAwKwBh3wb77+pB+IURSOnPAsmrUFapOllDQU102CCaUIxj3
         Mg0Oz3G369/fwHJMkBA910tGpkmxzUwfNJkg4eAoQ4Mk8Wj5F/S5eFB+tMTo2QB8cUvv
         +kN8M+VnPdsFchjXEXJwJDDfJgS+qg/PFyJ9egJAa494QHfBmGagBN1hakITnexyKLIU
         2jPw==
X-Gm-Message-State: AOAM533G93QFvtMgYi2AWkUrk0xcHpidzvQ5XhSpGhc+njNjnYHxJki0
	cy2PQy4MKEMbEmFx9goKC2Dmsa2y5r3SPw==
X-Google-Smtp-Source: ABdhPJzuauOzZH3ympqPN4DBjtxokjkRccnIl9J9qeTwvlt9HjO0Jpx9QzYhFJr1kL7OIB9fnNQ9Zg==
X-Received: by 2002:a05:600c:3556:: with SMTP id i22mr805168wmq.104.1630355855945;
        Mon, 30 Aug 2021 13:37:35 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:e840:dd4f:b947:28bf? ([2001:8b0:aba:5f3c:e840:dd4f:b947:28bf])
        by smtp.gmail.com with ESMTPSA id u8sm501128wmq.45.2021.08.30.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:37:35 -0700 (PDT)
Message-ID: <381bd257581076645eb07f4bbc42d62fd92d6d17.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][RFC][PATCH] bitbake: fetch2: correct PREMIRROR URI
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Scott Weaver <weaverjs@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 30 Aug 2021 21:37:34 +0100
In-Reply-To: <20210830035630.3634069-1-weaverjs@gmail.com>
References: <20210830035630.3634069-1-weaverjs@gmail.com>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2021-08-29 at 23:56 -0400, Scott Weaver wrote:
> When downloadfilename is defined in a recipe's SRC_URI and a PREMIRROR is also
> defined for that URI, the downloadfilename is appended to the mirror URI and it
> should not be appended.
> 
> Three new fetch bitbake-selftest tests were added to test downloadfilename
> scenarios.
> 
> [YOCTO #13039]
> 
> Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> ---
> 
> This fix is for BZ13039.
> 
> downloadfilename is defined as "the filename used when storing the downloaded
> file" under the definition of SRC_URI [1].
> This definition appears to be echoed in 44.3.2 where it says downloadfilename
> "allows the name of the downloaded file to be specified" [2]. Although, the
> second definition isn't as clear and could be interpreted to mean that the
> name of the file to be downloaded can be specified. Which, if intentional,
> would not match the first definition.
> 
> I believe that the first definition is the correct definition of
> downloadfilename.
> 
> I've added three new tests to bitbake-selftest's fetch testsuite.
> 
> Executed against the master branch, the following new tests fail (see patch):
> 
> test_fetch_premirror_specify_downloadfilename_regex_uri() fails because
> the fetcher attempts to download the downloadfilename.
> 
> test_fetch_premirror_specify_downloadfilename_specific_uri() was added
> to address BZ13039 and is expected to fail.
> 
> These tests pass when executed with this patch applied.
> 
> However, this change breaks the test that I have commented out in the patch
> which is executed by MirrorUriTest.test_urireplace.
> I don't believe this is a valid test because a mirror is normally the location
> where an artifact can be found and should not specify the filename itself.

I'm afraid I have to disagree on that.

If someone specifies a full URL in a mirror definition, they expect it to map to
that specific url. We need to find a way to fix your corner case but keep
complete mappings working.

Cheers,

Richard



