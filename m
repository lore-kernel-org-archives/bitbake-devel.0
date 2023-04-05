Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE05C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 16:26:29 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.135099.1680711985338256643
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 09:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20210112 header.b=P478BkCk;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: akuster808@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-17ebba88c60so39070114fac.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680711984; x=1683303984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zz0YEPDcTXnJgwZU42vBYWRiPbBG/F84CXBp5JkA3fw=;
        b=P478BkCkeX/eBJAow5vIOM1+8aM47EaFDLrsd5WOeGEayHTky4nMJqxBcWhldAtdpl
         U/mrh4kKIpb+qPKA3ir3NCurStd98m4g+Q5rN2vW98xj7aDywiW7K3bBHDCzKEKGtHo7
         MhRn61x4/ENAeTIkKX1iYK8rJF91sOO9qi26NDJZdi4Smse7Vnnz/YCnfBxKTc84U8ry
         0M6LB3/VfIrm2HzOeWIc21/wZBc/Joy2yuJ5tN/FSSBA3UYVlquFIQFphmHOwPZWkTq5
         /E97T893OdfOQ5nDqB+3cNvc7FHkEjox5TW6ZbVFkd+1NYKXQMEM4v/z/Nk8veJa1QW+
         GVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680711984; x=1683303984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz0YEPDcTXnJgwZU42vBYWRiPbBG/F84CXBp5JkA3fw=;
        b=IAtsUmyJUgJFiYgzr2hq/Kf4KbIuwFaGp18RHE/6Ej7i0ARd5/HB6iN+rAUOjJLJRB
         L/KbcrOcgaa7rFg/kRx0du8YU2uO3LnNBLZFzHmrUgTs2enDdVV6+Ujp+ajejNYDZ4GH
         YkR5vIarwsMW8kKP42ls9taegs3gD9xkC5ZlWnneZf0/sfBlKFUVA3uR8gx7I3iPV8Aq
         LA5ehJGMoQewGG5V9xQqf8URbJIq1/s/KtFCc1ak20A1JqxcOTRDr1SGzHdVLcRX/jxD
         +efb1TN6HsQxASCfO2O27EZB04YkmkVoCk5qaxNP+Y+QoEukvcm2myTxmOTGCTfRyDOh
         1yKA==
X-Gm-Message-State: AAQBX9fKO47+umrRFv6X97dLz/4rjrMZ2a8kf3Nnww9VFSReMRcsSUFy
	P7WPs9zCNn/gfT2Ro9Ikf/Q=
X-Google-Smtp-Source: AKy350YPRQDihj2VcVtj36mUEMvWNvSQTEmeodGTj1QyNNX5toiFzBkd/befUPvDMNR1PvUnJo6cAg==
X-Received: by 2002:a05:6870:6302:b0:17a:f617:e26c with SMTP id s2-20020a056870630200b0017af617e26cmr1691041oao.11.1680711984559;
        Wed, 05 Apr 2023 09:26:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:9190:ba10:36f6:c20d:238e:7162? ([2600:1700:9190:ba10:36f6:c20d:238e:7162])
        by smtp.gmail.com with ESMTPSA id ax40-20020a05687c022800b0017243edbe5bsm5977694oac.58.2023.04.05.09.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:26:24 -0700 (PDT)
Message-ID: <a1a3ca96-3cd2-10b7-4dee-59bfc2163d7e@gmail.com>
Date: Wed, 5 Apr 2023 12:26:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at
 once
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>,
 bitbake-devel@lists.openembedded.org
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
 <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
 <68045681-5481-80f5-30f4-e15616503dcd@mvista.com>
 <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
 <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
 <d3bdc504-a8d2-b925-cfd4-78655df7e4cd@mvista.com>
 <CA+cAker7RbVScDT_C8PmsRJ_03dXCx62WwGDRQbtSnkSBe1ujw@mail.gmail.com>
From: akuster808 <akuster808@gmail.com>
In-Reply-To: <CA+cAker7RbVScDT_C8PmsRJ_03dXCx62WwGDRQbtSnkSBe1ujw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 16:26:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14658



On 4/5/23 8:51 AM, Frédéric Martinsons wrote:
> What is the problem of having name there?

I deleted both alloc-no-stdlib and autocfg Cargo.* files and 
update_crates worked. I appears is missed a bunch that I manually added.

I got is building again.

Thanks for your help.

- Armin
>
> The bitbake fetcher (master) handles that.
>
> Le mer. 5 avr. 2023, 14:25, akuster <akuster@mvista.com> a écrit :
>
>
>
>     On 4/5/23 1:20 AM, Frédéric Martinsons wrote:
>     > I looked at the suricata recipe in meta-security and it didn't use
>     > cargo-update-recipes.bbclass
>     >
>     > You should modify your rust recipes to use this class and have
>     access
>     > to "bitbake -c update_crates" .
>     >
>     > You can take some examples from , i.e python3-cryptography in
>     > openembedded-core or python3-pyruvate
>     > in meta-python.
>     >
>     > The first issue you'll encounter is some kind of
>     bootstrapping (since
>     > update_crates needs to fetch
>     > to be able to write checksum but the fetcher needs the checksum
>     ...).
>     > With this error , you'll
>     > see all the data you need to add to the suricata-crates.inc.
>     >
>     > For curiosity, I tested locally the modification of suricata and it
>     > seems that this package embeds
>     > unexpected Cargo.lock format (in
>     > rust/vendor/alloc-no-stdlib/Cargo.lock) which doesn't contain
>     > a source entry (the package doesn't have any dependency).
>
>     I deleted the Cargo.* in the offending crates ( I found another)
>     and I
>     was able to finish running the update_creates. I notice "name" is now
>     part of the crates URI and the SRC_URI hashes. It wont build now
>     but I
>     think I can work around that.
>
>     - armin
>     >
>     > I don't know how to handle such a file (simply ignore it in the
>     class
>     > instead of raising an error ?)
>     >
>     >
>     > On Tue, 4 Apr 2023 at 23:35, Martin Jansa
>     <martin.jansa@gmail.com> wrote:
>     >
>     >     On Tue, Apr 4, 2023 at 11:08 PM akuster <akuster@mvista.com>
>     wrote:
>     >
>     >
>     >
>     >         On 4/4/23 1:07 PM, Martin Jansa wrote:
>     >         > On Tue, Apr 4, 2023 at 6:50 PM akuster
>     <akuster@mvista.com>
>     >         wrote:
>     >         >
>     >         >
>     >         >
>     >         >     On 4/1/23 11:21 AM, Frederic Martinsons wrote:
>     >         >     > From: Frederic Martinsons
>     <frederic.martinsons@gmail.com>
>     >         >     >
>     >         >     > Instead of only display the first and stop.
>     >         >     > For recipe (crago based) that can contains several
>     >         artifacts
>     >         >     > to fetch with their checksum, it will
>     particularly handy
>     >         >     > to display all of missing one.
>     >         >     >
>     >         >     > An example of error message would be
>     >         >
>     >         >     I am confused. Is this patch supposed to add the pkg
>     >         version or
>     >         >     not?  I
>     >         >     am not seeing any. Any ideas?
>     >         >
>     >         >
>     >         > name parameter with pkg version was added to bbclass in:
>     >         >
>     >
>     https://git.openembedded.org/openembedded-core/commit/?id=1795e98a04ad09b011afcc7cc3bf6dc49475b19a
>     >         >
>     >         > this change only allows all missing/incorrect checksums to
>     >         be showsn
>     >         > at the same time, instead of one checksum per do_fetch
>     failure.
>     >
>     >         I get multiple hashes for the same package.
>     >
>     >         SRC_URI[wasi.sha256sum] =
>     >  "1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f"
>     >         SRC_URI[wasi.sha256sum] =
>     >  "cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519"
>     >
>     >         so why no version info after the pkg name?
>     >
>     >
>     >     Did you regenerate the SRC_URIs with updated bbclass? It
>     works for
>     >     me as in:
>     >
>     https://github.com/shr-project/meta-webosose/commit/84dc9f3cc3dd85facde07ccddce0b9f2bcd90d39
>     >
>


