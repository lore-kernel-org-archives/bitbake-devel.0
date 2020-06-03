Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web12.9070.1591171865337479771
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2020 01:11:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YA43yjUd;
 spf=pass (domain: konsulko.com, ip: 209.85.167.171, mailfrom: paul.barker@konsulko.com)
Received: by mail-oi1-f171.google.com with SMTP id a137so1064085oii.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2020 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQuokL0PP7w8D2TZLNyJThfLsm6vV4+D/myHxZ2tzl4=;
        b=YA43yjUdIm2R6OVfokKKvr+7LCLfrjg5nHjBKkJ8LlMdKHsgV6fDNmbV0PAiXUkHbL
         UAwYgW1lWBQGYdIV7iCm5PNchx8RFXrkPv80FTuaXrLK4o0s8gChjeWPAxCZwElNhvhy
         3YX1op6pCB46QBPJjDW1gevm4U7kD7PzGxbDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQuokL0PP7w8D2TZLNyJThfLsm6vV4+D/myHxZ2tzl4=;
        b=IqNGsk5ktyGZ5v8kXcQK4FLDJ6VgN+ualHV3cuj6g9EHPLrvffMMl9GFVwvyjA9F8M
         BKrK1Uaf8lsFBhxKeTBYj7zLpheOwc/aJe3GDx2uhh5SicapHylRtqiMg6IyxG+QVrBH
         nT/9M/Ex7PX+ZZ/8pFe4Gfi5FRh+okj3kAVHIbFW3eYnlyUx+vE2LXpDaKaiMBJ9mL6D
         qBLReQh+Hum0JfUWHrpwdcgCq+jSmL3IiFtB5jzMaGf49NdFYTeJp4KRVz4YI8rLkfcv
         5P67B/0AVE9SNeb5WefozlRs53el9/XecwNSaT1yQwAMF6bhPyOxr4QcH5aYh/372gs4
         j7Xw==
X-Gm-Message-State: AOAM532n+hNA4s8756cXyP8IOix5DApzi8PWURiFJkhdHxbbOB2Oi3Gj
	aHyr1M0OesonnygU/W3WRlhOG+/lmdzUZUiB+7DRcA==
X-Google-Smtp-Source: ABdhPJzdbWuqVe10SFnRqK3/+4BFvQMZomRT3lQOsIO78I+sJX2OynBxnZMK4PYSbeuFftC2OuMUJw8bwPAvz339z9k=
X-Received: by 2002:a54:439a:: with SMTP id u26mr5143178oiv.6.1591171864620;
 Wed, 03 Jun 2020 01:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9ZRVuraU8rtGy2oDxrF1shUORXLSHU=F0T5H9jkEf3_RZ7Hg@mail.gmail.com>
 <c09767aec839d97043c4ea31be35038f282410ea.camel@linuxfoundation.org>
In-Reply-To: <c09767aec839d97043c4ea31be35038f282410ea.camel@linuxfoundation.org>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Wed, 3 Jun 2020 09:10:53 +0100
Message-ID: <CAM9ZRVtjx3u9qbt2Kwa-XvAxT8GTuOnR8uN=WhB4cyC-LGfiZw@mail.gmail.com>
Subject: Re: [bitbake-devel] Task names in bitbake-diffsigs output
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2020 at 21:33, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Tue, 2020-06-02 at 19:37 +0100, Paul Barker wrote:
> > Running bitbake-diffsigs today to debug why sstate was not being
> > reused gave the following output:
> >
> > NOTE: Starting bitbake server...
> > runtaskdeps changed:
> > [-
> > autoconf/autoconf_2.69.bb:do_populate_sysroot:virtual:native:/w/layer
> > s/poky/meta/recipes-devtools/autoconf/autoconf_2.69.bb
> > automake/automake_1.16.1.bb:do_populate_sysroot:virtual:native:/w/lay
> > ers/poky/meta/recipes-devtools/automake/automake_1.16.1.bb
> > bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/pok
> > y/meta/recipes-extended/bzip2/bzip2_1.0.8.bb
> > file/file_5.38.bb:do_fetch:virtual:native:/w/layers/poky/meta/recipes
> > -devtools/file/file_5.38.bb
> > gnu-config/gnu-
> > config_git.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/
> > recipes-devtools/gnu-config/gnu-config_git.bb,
> > +autoconf/autoconf_2.69.bb:do_populate_sysroot:virtual:native:/builds
> > /SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-
> > devtools/autoconf/autoconf_2.69.bb
> > automake/automake_1.16.1.bb:do_populate_sysroot:virtual:native:/build
> > s/SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-
> > devtools/automake/automake_1.16.1.bb
> > file/file_5.38.bb:do_fetch:virtual:native:/builds/SanCloudLtd/meta-
> > sancloud/layers/poky/meta/recipes-devtools/file/file_5.38.bb
> > gnu-config/gnu-
> > config_git.bb:do_populate_sysroot:virtual:native:/builds/SanCloudLtd/
> > meta-sancloud/layers/poky/meta/recipes-devtools/gnu-config/gnu-
> > config_git.bb,
> > 'libtool/libtool-native_2.4.6.bb:do_populate_sysroot',
> > -zlib/zlib_1.2.11.bb:do_populate_sysroot:virtual:native:/w/layers/pok
> > y/meta/recipes-core/zlib/zlib_1.2.11.bb,
> > +zlib/zlib_1.2.11.bb:do_populate_sysroot:virtual:native:/builds/SanCl
> > oudLtd/meta-sancloud/layers/poky/meta/recipes-
> > core/zlib/zlib_1.2.11.bb]
> > Number of task dependencies changed
> > Dependency on task
> > bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/pok
> > y/meta/recipes-extended/bzip2/bzip2_1.0.8.bb
> > was removed with hash
> > 94572189ef6d0c9fd878611865331a20e71d33e294c9949de7146a1923c4175f
> >
> > What's confusing there is that the bulk of the output is noise due to
> > the paths to various recipes being changed.
> >
> > It got me thinking, where are those long task names like
> > "bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/po
> > ky/meta/recipes-extended/bzip2/bzip2_1.0.8.bb"
> > being generated? Why do they include the full path to the recipe?
>
> The paths are to make things human readable, the code itself cares
> whether it has the same set of hashes or not. If the sorted (based upon
> the basename of the file) set of hashes differ, the checksum will
> differ. If we just show that the hashes differ its useless to the user
> to debug.
>
> > Instead of including the full paths could we prefix the recipe path
> > with the collection name ()ince those are unique but won't change if
> > you move the layers around)? So instead you'd have something like
> > "bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:core:recipes
> > -extended/bzip2/bzip2_1.0.8.bb".
>
> You're assuming that a collection can't have the same recipe filename
> within it multiple times. It can :/.
>
> > If that's not too insane, and someone can point me at the code which
> > generates those task names I'd be happy to try patching it myself.
>
> There are definitely things we can do to better filter the output. The
> tools lean towards more verbose than not and were implemented as being
> quick/simple. If it sees things are different, it will say so but the
> code doesn't actually calculate what is different, it doesn't actually
> care or need to know that if you see what I mean.
>
> What it needs to do is pair up the hashes which match, exclude those,
> then print the differences.
>
> We can truncate the pathnames but then the code can potentially be
> confusing in other ways. If the basehash differs, the output hashes
> will differ anyway so you could argue it shouldn't be shown but that
> information can still sometimes be useful too. Its hard to win.
>
> The code is in lib/bb/siggen.py and has some support from
> meta/lib/oe/sstatesig.py

Reading through your reply and the code I see what's going on a bit
better now. The full paths need to be there so they can be used in
things like error messages. What we need to do is prevent them from
causing confusion in bitbake-diffsigs.

I'll take another look at this in the next few days and see what I can do.

Thanks,

-- 
Paul Barker
Konsulko Group
