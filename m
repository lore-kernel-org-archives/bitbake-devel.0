Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web09.779.1632245421151606377
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 10:30:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=z9u7mNq8;
 spf=softfail (domain: sakoman.com, ip: 209.85.221.51, mailfrom: steve@sakoman.com)
Received: by mail-wr1-f51.google.com with SMTP id w29so41536190wra.8
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Sep 2021 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lrsmr5BEwjIUZwaPeNszOxCgJ35a5SxyLJMWYR5a9u0=;
        b=z9u7mNq8zgwqkB9hHOmDoBlJ1frg2EuwX91JDjUryQKgNU2oP9wWpL5vWqo3BFiM9L
         jtAEIqiIzsBBz4K57liJtHZ9AoXE5UyXv7cSUyQxAWa4aMYfpP93kYbmOkp3Jo1QXCxj
         rSVELvW9EnpzQz2tROoYMB3uy7+wWpo1nK4soTGCAGLZYvZLkVmc0/eH9k7unfrzwtKa
         HlvttQXvuYlejfFCjvgdQawSHGEKiQlRzegjL9IMg36d6+2LbK2pn8sl4z4+SMFeyrga
         llappA9dsdrYpQCSDf7hRMXEayYSb3WsT2MpYDQcszkZYHX47SsUZL1lJOtxENjeXNyO
         z5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lrsmr5BEwjIUZwaPeNszOxCgJ35a5SxyLJMWYR5a9u0=;
        b=vFJNeO0Kp7sv6dRVlOPQCo6OPXBa2gkWd75yuSLw3lpicWcfAFCVaiscmFgqdqzW0+
         OKKFAGcsdBMuQbT5MPevsQlG87wQxhAmFYV9TNHJ8Dozt251wsrCxB7QZ+xCBW1wnzvS
         NMGqNIvTNdyrmdqW0b9f8+k9MhofNiV8kBCpczK8GTvwb2+EGnPHwndAzVWWRnnVr01E
         ntrsVxoXDK1EuNfCavewdfChOLrb7yfC4hxt+qYqqSTU4XT17Din2/DB2kM+v1+K2XyN
         HWPoNa7H4GBgXw8vGAXNu+c/mq9nG0duvmXbfsv6YCciLDUAl0Kklnvmvl5p50VWQeXz
         sKuA==
X-Gm-Message-State: AOAM533wnD1JnpLhetrUobyy3hft1efhpdCcMyDtJhc2y1ezzmcbS34+
	k271tYbFirBmDUp5sxP+KSHTnNuDWudFJ6EQgr/pBw==
X-Google-Smtp-Source: ABdhPJxg2qrflc2RJBDILuWLLgmLDqnaKBPq20/IJ2u/Tq8EpCMjRtQMmMvG4qGKa2zvgNXkRMRGAQLBaEwMUgrBjII=
X-Received: by 2002:a7b:c459:: with SMTP id l25mr6049089wmi.60.1632245419162;
 Tue, 21 Sep 2021 10:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632212181.git.anuj.mittal@intel.com> <CA+chaQfenZRTfeWsPieee10fQSw4Um3xj8SQW+WoPaSyNonjuw@mail.gmail.com>
In-Reply-To: <CA+chaQfenZRTfeWsPieee10fQSw4Um3xj8SQW+WoPaSyNonjuw@mail.gmail.com>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Tue, 21 Sep 2021 07:30:07 -1000
Message-ID: <CAOSpxdZ2AeGOWhA_aJggERzxYMycA1nk+ct8DTVzyYfeQsy0Vg@mail.gmail.com>
Subject: Re: [bitbake-devel] [hardknott][PATCH 0/8] Review request
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Anuj Mittal <anuj.mittal@intel.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 21, 2021 at 7:23 AM Martin Jansa <martin.jansa@gmail.com> wrote:
>
> LGTM
>
> For next round of bitbake patches, can you please include 3 bitbake changes from:
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=14542
> ?
>
> All 3 (fc58ad84a9deb2620ad90611684dad65dafedb11 e2c1afda4cb8023ed4ffeb5dc5bee4f0055659a8 9eee9fd4f2f96789ad2b037e74d561bdc1426856) apply cleanly on bitbake 1.46, 1.48 and 1.50.
>
> +Steve Sakoman to consider for dunfell as well.

I've been testing those (and a few others), so they will be in my next
set of bitbake patches for review.

Steve

>
> Thanks
>
> On Tue, Sep 21, 2021 at 10:35 AM Anuj Mittal <anuj.mittal@intel.com> wrote:
>>
>> Please review these changes for hardknott/1.50. Tested with oe-core and
>> no related problems seen.
>>
>> https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2625
>>
>> Thanks,
>>
>> Anuj
>>
>> The following changes since commit 4d83d9103d9225a2ac42c0f3dfada2f5cf140b68:
>>
>>   build: Catch and error upon circular task references (2021-09-16 22:17:07 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://push.openembedded.org/bitbake-contrib stable/1.50-next
>>
>> Martin Jansa (1):
>>   cooker/process: Fix typos in exiting message
>>
>> Richard Purdie (7):
>>   cookerdata: Show error for no BBLAYERS in bblayers.conf
>>   cookerdata: Improve missing core layer error message
>>   data_smart: Improve error display for handled exceptions
>>   runqueue: Clean up task stats handling
>>   bitbake-worker: Improve error handling
>>   cookerdata: Show a readable error for invalid multiconfig name
>>   runqueue/knotty: Improve UI handling of setscene task counting
>>
>>  bin/bitbake-worker       | 10 ++++++----
>>  lib/bb/cooker.py         |  2 +-
>>  lib/bb/cookerdata.py     |  7 +++++++
>>  lib/bb/data_smart.py     |  2 ++
>>  lib/bb/runqueue.py       | 43 +++++++++++++++++++++++-----------------
>>  lib/bb/server/process.py |  2 +-
>>  lib/bb/ui/knotty.py      |  2 +-
>>  lib/bb/ui/uihelper.py    |  4 ++--
>>  8 files changed, 45 insertions(+), 27 deletions(-)
>>
>> --
>> 2.31.1
>>
>>
>> 
>>
