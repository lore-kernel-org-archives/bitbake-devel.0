Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.14591.1626612435968849316
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Jul 2021 05:47:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JkX2kIko;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id l7so18047059wrv.7
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Jul 2021 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=eq4VdezEVjNCVF65FyCQGD6Wio5POWbkhQZAYiZYL60=;
        b=JkX2kIko1RWuy84zZhtgTkfvYA1LcXpu1DF/fd9fMrwBejSRfaOQ7pVulwEBdoOh+7
         k9lWfMcgNUw3EA9PYaVBqzmWV6f0L+SENPgRoN+5UPo4e4Jwg2MklweP/NfiyF7tu1CD
         /Ouw/u56Zywe6KMY2GAR3EvGrbuC28tGazsQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=eq4VdezEVjNCVF65FyCQGD6Wio5POWbkhQZAYiZYL60=;
        b=g4SlbAmDKf4XEP/ARr6gN8LY3ijx4izemzyDaw5S7E8bObk9K6+SGntvk/KcuHVSzj
         VCTM/ntNYeoPlQoV8kwE6D2uErq0ZGrVTS4NaacFj2lbOrF/IkXczMVoXxb0nBYW408G
         amIVvvC6+XkKrjI088nNnvgZpD+yM5jRXik/og8ivY+BG1VE8waCDmWBgVqHO2qckz/3
         NtfZcVwn4lAYayeAmoHAcA5PDwfxbtrsCf1/0z9yYLFp5wj8VgKF8tF26jbqYtJ9BqOk
         ykAH6DHjqIptMVJbs8WhmO77DDlC8VexDiC6i+kdCJQIqIwRBxSvquFMNBPY+Ha0fVp5
         PrSg==
X-Gm-Message-State: AOAM531rH5uUeun1cplDsWDjmAiEgmMuAo4EljQNI34xwFdo7OU48ilT
	nfmWTpIfIGqkxAUmSpgrb/u0DWt7exTETQ==
X-Google-Smtp-Source: ABdhPJxacGRUorkhQUh8tO2bk/RXYC7Bui38C8ZRKWgYQ0OahOR8rjz3xm42N54XXqWwSniIbhkUnA==
X-Received: by 2002:adf:a2c3:: with SMTP id t3mr23812549wra.223.1626612434386;
        Sun, 18 Jul 2021 05:47:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5ff5:ebf1:b0ff:a94a? ([2001:8b0:aba:5f3c:5ff5:ebf1:b0ff:a94a])
        by smtp.gmail.com with ESMTPSA id 12sm17699943wme.28.2021.07.18.05.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 05:47:14 -0700 (PDT)
Message-ID: <e0aef0bd428729d70c5b1ee4bb5df3fcadcfd02d.camel@linuxfoundation.org>
Subject: Override syntax change proposal
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 18 Jul 2021 13:47:11 +0100
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi All,

I now have an actual proposed plan for changing override syntax which I hope
will mitigate the issues raised in the previous discussion as far a is possible
whilst still letting the project move forward.

Firstly, I'd like to merge a patch I sent to the bitbake list:

https://lists.openembedded.org/g/bitbake-devel/topic/patch_data_smart_parse/84285770

This patch allows bitbake to accept ":" in variable/function names. It is designed
to be simple and could be easily backported to previous bitbake versions. At the
very least I'd like to do that for master, allowing at least OE-Core master branch 
to start using an explicit override syntax.

I'd like to go further and suggest we backport to older bitbake versions (back to 
dunfell?) so that anyone using metadata over multiple versions could continue to
do so.

I'm hoping the above isn't too controversial and would at least let us move forward
to trying to improve.

The next steps beyond that are a little trickier as they start to require the change.
The next logical move is to require ":" as the separator for current master branches.
I believe it is reasonable to do this if we can show how layers can be converted and 
have a way for older layers to continue to work with master.

There is a script I wrote and linked to (~100 lines of python) which with some
priming about the overrides in use in a layer (which a layer maintainer should know), 
is able to automatically convert a layer. For oe-core+meta-yocto+docs+bitbake, that
is 9000+ changes but the script seems reliable if not very nice code. I did end up
adding a handful of manual fixes but that was for python code manipulating variables
which most layers wouldn't have, in general the core is way more complex than most
layers.

This means that people with older layers trying to work with master now have two
options:

a) they convert to use ":" and update to a version of bitbake with the above tweak
   to allow it to accept that (no behaviour change)
b) they dynamically translate their layer with a script when testing with master

Given those options two options both being shown to be viable, I think this
is enough to allow us to proceed and update the syntax on shorter timescales such
as during this release, ready for the next LTS.

In working out compatibility pieces, I don't have any optimisations using the 
new syntax yet, or a plan worked out for what we can do beyond this other that ideas
and my previous experiments. Some changes "feel" right and this one definitely does 
as a good move in it's own right regardless of whether we ultimately can improve 
syntax or not. I'm therefore keen to proceed.

Cheers.

Richard



