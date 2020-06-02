Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.415.1591129994925233199
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Jun 2020 13:33:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=doIKDrhf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id q25so4493193wmj.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Jun 2020 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=DhcC737kDA6pr+tLj3N3nPGmXOH7EN1T1GVjjdyAN6c=;
        b=doIKDrhfJ8FzDYaSj7VW7kWRV9oMBX59NbiRDRgK/HiB1VwF+8LSLCBVsU0qAUw1Kl
         +WsrfbPqr8bIF4gai1zfhHLQkdoais0bL9UqTvTy9c38XE8S2/QOv+lC3akbjGgHLGsn
         wHGqJ9qigr8S1oGNliWspDfFd9X8Uib6JWOW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DhcC737kDA6pr+tLj3N3nPGmXOH7EN1T1GVjjdyAN6c=;
        b=oNLApLgJbMgkMU05SoK9+jpx8XKdEsArJ4yWLh7IcPwsDvYr54Xt5ecGNIzqmCE5B+
         ++qMffxf3NIgeuOKYVN85rjgC5t6+Zw6X8n2GN94yq3XMxMLQqbrlP7Zm+6QAWLJ5ahy
         LyU6eyZdW8LhxoTZLaehuBJXiFL2MkV6wFqq8WZO9dlWLM1dNT0nAGUS3z4XHt2zI1zD
         ilxaBeBCR+vCd5WcRhAs/F4a6N45Kjf+OVkiLYyOHRCvd5JD8p/JHr8R1GiEdaSuRqqu
         gQS7hkc3PdGl31hweJP0gdlp2qjd7c/d5mJJB1w/p3cqsqpKPkK6xD+1tzzhELgvxybt
         CCjg==
X-Gm-Message-State: AOAM532wy3Dum0MvHruvkz0prG5odmammny6Ay8sjjrdJ3NiKYTTns28
	hDJVI1fMLCkULuxGxAZy1KUO+Q==
X-Google-Smtp-Source: ABdhPJwUSrcdVlF/q4jkAocmIBXPy8mTBJV+mHtSgMjcjyVqVfj8ePcT7qKGUfE0vLDxVKh8XroQHQ==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr5961172wme.26.1591129992577;
        Tue, 02 Jun 2020 13:33:12 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id c25sm1119128wmb.44.2020.06.02.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 13:33:11 -0700 (PDT)
Message-ID: <c09767aec839d97043c4ea31be35038f282410ea.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Task names in bitbake-diffsigs output
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Barker <pbarker@konsulko.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 02 Jun 2020 21:33:08 +0100
In-Reply-To: <CAM9ZRVuraU8rtGy2oDxrF1shUORXLSHU=F0T5H9jkEf3_RZ7Hg@mail.gmail.com>
References: 
	<CAM9ZRVuraU8rtGy2oDxrF1shUORXLSHU=F0T5H9jkEf3_RZ7Hg@mail.gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-02 at 19:37 +0100, Paul Barker wrote:
> Running bitbake-diffsigs today to debug why sstate was not being
> reused gave the following output:
> 
> NOTE: Starting bitbake server...
> runtaskdeps changed:
> [-
> autoconf/autoconf_2.69.bb:do_populate_sysroot:virtual:native:/w/layer
> s/poky/meta/recipes-devtools/autoconf/autoconf_2.69.bb
> automake/automake_1.16.1.bb:do_populate_sysroot:virtual:native:/w/lay
> ers/poky/meta/recipes-devtools/automake/automake_1.16.1.bb
> bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/pok
> y/meta/recipes-extended/bzip2/bzip2_1.0.8.bb
> file/file_5.38.bb:do_fetch:virtual:native:/w/layers/poky/meta/recipes
> -devtools/file/file_5.38.bb
> gnu-config/gnu-
> config_git.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/
> recipes-devtools/gnu-config/gnu-config_git.bb,
> +autoconf/autoconf_2.69.bb:do_populate_sysroot:virtual:native:/builds
> /SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-
> devtools/autoconf/autoconf_2.69.bb
> automake/automake_1.16.1.bb:do_populate_sysroot:virtual:native:/build
> s/SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-
> devtools/automake/automake_1.16.1.bb
> file/file_5.38.bb:do_fetch:virtual:native:/builds/SanCloudLtd/meta-
> sancloud/layers/poky/meta/recipes-devtools/file/file_5.38.bb
> gnu-config/gnu-
> config_git.bb:do_populate_sysroot:virtual:native:/builds/SanCloudLtd/
> meta-sancloud/layers/poky/meta/recipes-devtools/gnu-config/gnu-
> config_git.bb,
> 'libtool/libtool-native_2.4.6.bb:do_populate_sysroot',
> -zlib/zlib_1.2.11.bb:do_populate_sysroot:virtual:native:/w/layers/pok
> y/meta/recipes-core/zlib/zlib_1.2.11.bb,
> +zlib/zlib_1.2.11.bb:do_populate_sysroot:virtual:native:/builds/SanCl
> oudLtd/meta-sancloud/layers/poky/meta/recipes-
> core/zlib/zlib_1.2.11.bb]
> Number of task dependencies changed
> Dependency on task
> bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/pok
> y/meta/recipes-extended/bzip2/bzip2_1.0.8.bb
> was removed with hash
> 94572189ef6d0c9fd878611865331a20e71d33e294c9949de7146a1923c4175f
> 
> What's confusing there is that the bulk of the output is noise due to
> the paths to various recipes being changed.
> 
> It got me thinking, where are those long task names like
> "bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/po
> ky/meta/recipes-extended/bzip2/bzip2_1.0.8.bb"
> being generated? Why do they include the full path to the recipe?

The paths are to make things human readable, the code itself cares
whether it has the same set of hashes or not. If the sorted (based upon
the basename of the file) set of hashes differ, the checksum will
differ. If we just show that the hashes differ its useless to the user
to debug.

> Instead of including the full paths could we prefix the recipe path
> with the collection name ()ince those are unique but won't change if
> you move the layers around)? So instead you'd have something like
> "bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:core:recipes
> -extended/bzip2/bzip2_1.0.8.bb".

You're assuming that a collection can't have the same recipe filename
within it multiple times. It can :/.

> If that's not too insane, and someone can point me at the code which
> generates those task names I'd be happy to try patching it myself.

There are definitely things we can do to better filter the output. The
tools lean towards more verbose than not and were implemented as being
quick/simple. If it sees things are different, it will say so but the
code doesn't actually calculate what is different, it doesn't actually
care or need to know that if you see what I mean.

What it needs to do is pair up the hashes which match, exclude those,
then print the differences.

We can truncate the pathnames but then the code can potentially be
confusing in other ways. If the basehash differs, the output hashes
will differ anyway so you could argue it shouldn't be shown but that
information can still sometimes be useful too. Its hard to win.

The code is in lib/bb/siggen.py and has some support from
meta/lib/oe/sstatesig.py

Cheers,

Richard



