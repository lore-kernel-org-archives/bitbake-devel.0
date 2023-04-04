Return-Path: <ernstp@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED84BC6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 23:45:34 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web10.117987.1680651933095956760
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Apr 2023 16:45:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20210112 header.b=o2evubzR;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: ernstp@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id r14so19822852oiw.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680651932; x=1683243932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u6VWbLIzWvJt5v/VrR/TfhrAFEr6Z3FaoMa6B1t3Cg4=;
        b=o2evubzRHBOEZTTODXNzlwTuBrGGee0hR42Nts+qoB9D9WaYisY0O/N0LLZTKaZ0jy
         Tt7karJpDwK75HaQYsOrdSFS4Irj+MYiRrSIR0uEyR8orcYQCarjHRCY7Peyx37Cm0pj
         W0o4d3O9JnGVrRM0x4xSjiyqjIoL3ok/AzCKXJPGHHFp6VqzEObnML247pspGWQQxy0D
         0P5kyvPUUCSd2rfuTxJdmYjmkBzJGpNIPxitd1eFlJRgRenTqXF3i8z9XIPJSa1Vkiw1
         8W4KK4+KlQgSiBxs/cRF/pqZBAZFMszwEc0qZU4aWrqlf7ChuxMD7S8+5nG3OShZ96d3
         +4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680651932; x=1683243932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6VWbLIzWvJt5v/VrR/TfhrAFEr6Z3FaoMa6B1t3Cg4=;
        b=3d8glDiDBrIUBmD4IVfXclyGaB8FDeyyNA1aXaoXHL7nWMBh4MpJpfGa4TW+fEtF5v
         C06nvbtzTbZn0uxpSQKdahQyC93LXUS2DwyoOZoPk1ej1ttQehfEYCTSdMBBgJE2HCW6
         jFX2regoarGokMrqfJJfnF0uMY+mombs525MbbPvxxhKIy1K0LnVM5+DedaTbP1fp3g1
         cD6rnnKRBJy7AsYCmGI/QzmujqR7y/rUEdQv3nhJCv9vIBJU7Wt0wmA/UI3C8diqxbdy
         wpTYz/uKUd3JMMoQ9iVqNQJOF1qNAVjt14NjP0f/g7i1wUlUFcJvm1ZCyyPNoUHfZT3K
         qO8w==
X-Gm-Message-State: AAQBX9d1saMSp69qyJGCk07X53vydCdDbv56ekzcfZbSCm6myxfWrsTB
	/uFnhdHkA5OsLt3J3ySfJGFjJbPFwH5k4l8qQ1M=
X-Google-Smtp-Source: AKy350aqVMIMcJYGtIdxXNXh9DU7IDBQiWQjJx70sf6L9SI15gRXttFrz9Otj83ZM/AGgrFd0seFDPqOXKqV7lK/e3k=
X-Received: by 2002:a05:6808:2b0d:b0:388:5e96:2f6a with SMTP id
 fe13-20020a0568082b0d00b003885e962f6amr355356oib.0.1680651932310; Tue, 04 Apr
 2023 16:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <43210b1ce3260a74b29f28db3125aad206612ac9.camel@infinera.com>
In-Reply-To: <43210b1ce3260a74b29f28db3125aad206612ac9.camel@infinera.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Wed, 5 Apr 2023 01:45:21 +0200
Message-ID: <CAD=4a=VVXxX-OW2sSzsNaji8uqRsp15yxkYpgDZUgdwFqsK-qQ@mail.gmail.com>
Subject: Re: [bitbake-devel] building python-inflect ?
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 23:45:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14638

I think you want to add
inherit python_setuptools_build_meta

Regards
//Ernst

Den tis 4 apr. 2023 kl 22:21 skrev Joakim Tjernlund
<Joakim.Tjernlund@infinera.com>:
>
> Trying to make a .bb for python-inflect, https://github.com/jaraco/inflect but this pkg
> does not have a setup.py, only a setup.cfg
>
> I do not speak python and cannot work out what to do, I got(can someone help me fill in the missing part?):
>
> SUMMARY = "A port of Ruby on Rails' inflection to Python."
> HOMEPAGE = "https://pypi.org/project/inflect"
> LICENSE = "MIT"
> SECTION = "devel/python"
> #LIC_FILES_CHKSUM = "file://LICENSE;md5=2fb6fa1a6f1792d78de19ad1bb653c31"
> LIC_FILES_CHKSUM = "file://LICENSE;md5=7a7126e068206290f3fe9f8d6c713ea6"
>
> SRC_URI[md5sum] = "e7aad8f161ee9c85c7d125af69ae661f"
> SRC_URI[sha256sum] = "f1a6bcb0105046f89619fde1a7d044c612c614c2d85ef182582d9dc9b86d309a"
>
> inherit pypi ptest
>
> SRC_URI +=" \
>         file://run-ptest \
> "
> #DEPENDS = "python3-pydantic"
> RDEPENDS:${PN} = "python3-pydantic"
>
> RDEPENDS:${PN}_ptest +=" \
>         ${PYTHON_PN}_pytest \
> "
>
> do_install_ptest() {
>         cp -f ${S}/test_inflection.py ${D}${PTEST_PATH}/
> }
>
>
> RDEPENDS:${PN} += "${PYTHON_PN}-pytest"
>
> BBCLASSEXTEND = "native nativesdk"
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14634): https://lists.openembedded.org/g/bitbake-devel/message/14634
> Mute This Topic: https://lists.openembedded.org/mt/98068636/4947266
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [ernstp@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

