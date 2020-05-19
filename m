Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.9376.1589885973051653006
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 May 2020 03:59:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FiPn3Pz9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id h4so2575061wmb.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2020 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=2R6lQR7yrqwL0DlkENOmFt3g9S20ZxuPyJ6IzVHHbBg=;
        b=FiPn3Pz9D0zwFzlyAwTBF1hcijKo5NHYXojST9GGNLG0SsajyQ4YEc9dZI2q5cvRqf
         /rmACwRXRvrGl+nDZ7ePxx2AuTYQfVr85zCpxfjyhd1rWScZTn77qL34rj4ZUXXrMqw7
         Ec86wcgH7OF+ZD1eKR2H0HbK2rFaonWzlONrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2R6lQR7yrqwL0DlkENOmFt3g9S20ZxuPyJ6IzVHHbBg=;
        b=KLBogebfNWvOPyTdqwE8KW2gpGfEoeDsKItSmPRIAsoF2H0REuTpia03VY12ER5p27
         5brFfQqhxsWQL18OLcgq4JkESjootaKXCNtB0OJY54TiDapC4hRECxyiel3Na6BKPdiQ
         XllXa6yqYmL1EmLdf0T73q6Nj2WHSoDx7izTGrGn01UKguDBjUtW7sLQRph3mTr0r/vV
         fOw85zTcAv2YtEynwkrr35vhojWnbauVVTe5v6H7M7oal2+ZhS6leqv8jV/vHzU23fD/
         uBL62UJKXN38WboErQDVfP5NV1bn98pjtcncFhG4JobQ/qPW1fWba2go5xCCSDT+HDgD
         HdaQ==
X-Gm-Message-State: AOAM530IUFTv4OrPJKlY9zBTnVpCL5ryDFkcZwR+SyyxD22qFTmD5u1e
	BZ0CIqtjgvZ54KmWxWGAE3eKUGJJIZs=
X-Google-Smtp-Source: ABdhPJzPTwlzKPeVEc/38m2rDXoz+jizdz/rf3h1E+sqgko3rRcbO+RSYO8tE+G1NDnIfNswyPECmg==
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr4782988wmj.176.1589885971354;
        Tue, 19 May 2020 03:59:31 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id c17sm20781321wrn.59.2020.05.19.03.59.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:59:30 -0700 (PDT)
Message-ID: <124b9b904c15e0dfea51d941bf234f89596d4aff.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] any point in defining classname_functionname() if not exporting it?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 May 2020 11:59:29 +0100
In-Reply-To: <alpine.LFD.2.21.2005051010500.15969@localhost.localdomain>
References: <alpine.LFD.2.21.2005051010500.15969@localhost.localdomain>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-05-05 at 10:25 -0400, Robert P. J. Day wrote:
>   still in BB manual, section 3.5.6, "Flexible Inheritance for Class
> Functions", that section makes perfect sense but it's not clear if
> there is any value to defining a function of the form
> classname_functionmame() if you're not going to export it with
> EXPORT_FUNCTIONS.
> 
>   case in point -- cmake.bbclass. at bottom of file, we see some
> perfectly reasonable exporting:
> 
> EXPORT_FUNCTIONS do_configure do_compile do_install
> do_generate_toolchain_file
> 
> but if you grep, there is an additional function being defined of
> that
> form:
> 
> cmake_do_generate_toolchain_file() {
> cmake_do_configure() {
> cmake_runcmake_build() {             <-- this one
> cmake_do_compile()  {
> cmake_do_install() {
> 
> sure, that function is invoked internally in that class file, but
> without being exported, is there any reason that function has a
> "cmake_" prefix?

It makes it clear it comes from the cmake class? Namespacing is useful
even if EXPORT_FUNCTIONS isn't involved.

Cheers,

Richard

