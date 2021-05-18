Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web08.384.1621354384371919919
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 09:13:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=JHUMaZaF;
 spf=pass (domain: gmail.com, ip: 209.85.215.178, mailfrom: raj.khem@gmail.com)
Received: by mail-pg1-f178.google.com with SMTP id y32so7336132pga.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 May 2021 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IKnBPc3mkKtGqiOc4JWpfMSsDRt6SD7MM0h5/rdlJ20=;
        b=JHUMaZaFmb1ccM2fJ9bCFTsdCFPGKEbG2vVrRmpPNmsWNEP2gFX29B7g1DO2Z6FKCk
         SXLJAsWyknvIBCsGcFG5OKNnAMhC6O0n3R9NsqNmcMwHxSxbcrfKcQIzK39tWzoOfX+Q
         jjY5de0HSvUAicsfAE5+j1ZNyxiaD+2Uv7mwrqkagQgmwF9gC467dwSot1+jApCxCMr5
         IK4loJDVZ4DWruYyTwpRNAiAvfKhM4NR34kC8OEAWw4F4/Hf5XRwyarkl4J2fsUBy5N+
         e6i5f/aDM5ejVVoFmEBP/JQuQQ1wSQeqBd3pkNRNyjh5/yqP295gye8XeaD1XCnjlm94
         XV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IKnBPc3mkKtGqiOc4JWpfMSsDRt6SD7MM0h5/rdlJ20=;
        b=tbsnVOwuL3hjr+5XjSgnwbY/Z0a2tHoGjcuZ2oZF2UCf/4JGhMfzZOec3lAmRApEXy
         S/Z96OdFU/4ikEqzVNe4SoWJf8SV4oxXLXlCqyPxSiUEZ2UAPy3fFcZYxMKHeeEZgL8Y
         nA9/yf4pCsR/WX4ukiyJAj5TZytO9Zu7PesFcwjYWOYpQdskjatFeUYhQna6QufjjgF8
         tUBh/8cequR/nRIDLGdcx7rnhQnlOFLPHcQ/46E/x22+nHaWrORreRZInnkdoLHpUkoD
         moA2jBZpO6FhoC87XjCaKL4A9StdGTn5rTp4gWgRNWMBaljshiUsvz2g2Oj11xk9ZDSV
         z1UQ==
X-Gm-Message-State: AOAM531qJB2h8tz0ZoEDn4hOMSctdTjm5gT8sN6FUEvTfZJMv7vMDKiX
	c81jP51lim8tydqoYJFfG/2/5yhsplPz/w==
X-Google-Smtp-Source: ABdhPJzI8kZGMdWZ71a9y/01NtlJkGZNtV0+ycTuIKH5NIH9mJsDTQJMxSPmCvkSqeEces8MpQlxHg==
X-Received: by 2002:a65:60d8:: with SMTP id r24mr5849438pgv.226.1621354383520;
        Tue, 18 May 2021 09:13:03 -0700 (PDT)
Return-Path: <raj.khem@gmail.com>
Received: from ?IPv6:2601:646:9200:a0f0::a746? ([2601:646:9200:a0f0::a746])
        by smtp.gmail.com with ESMTPSA id h76sm13509927pfe.161.2021.05.18.09.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 09:13:03 -0700 (PDT)
Subject: Re: [bitbake-devel] Disable Reproducible Build - reg
To: Daniel Selvan <daniel.selvan@jasmin-infotech.com>,
 Konrad Weihmann <kweihmann@outlook.com>
Cc: poky <poky@lists.yoctoproject.org>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <141358386.90607893.1621323974188.JavaMail.zimbra@jasmin-infotech.com>
 <1180155480.90839930.1621324248815.JavaMail.zimbra@jasmin-infotech.com>
 <AM9PR09MB46424A47140676C11DAD16D2A82C9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <1263831117.91201115.1621324764469.JavaMail.zimbra@jasmin-infotech.com>
From: "Khem Raj" <raj.khem@gmail.com>
Message-ID: <d3ce10b6-4630-031c-d4d7-f8d46bb14e1c@gmail.com>
Date: Tue, 18 May 2021 09:12:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1263831117.91201115.1621324764469.JavaMail.zimbra@jasmin-infotech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 5/18/21 12:59 AM, Daniel Selvan wrote:
> Hi,
> 
> I already added the line "BUILD_REPRODUCIBLE_BINARIES = '0'" in by local.conf yet if I try to add __DATE__ I get the following error: "error: macro "__DATE__" might prevent reproducible builds [-Werror=date-time]"
> 
> Can you comment on this?

we internally enabled this option via adding it to TARGET_CC_ARCH in 
meta/classes/reproducible_build.bbclass

TARGET_CC_ARCH_append_class-target = " -Wdate-time"


perhaps change it to

TARGET_CC_ARCH_append_class-target = 
"${@oe.utils.ifelse(d.getVar('BUILD_REPRODUCIBLE_BINARIES') == '1', ' 
-Wdate-time', '')}
"

would you mind testing it out ? and if it works for you then send a 
patch to oe-core

> 
> Kind regards,
> 
> 
> Daniel Selvan D.
> 
> 
> 
> 
> 
> 
