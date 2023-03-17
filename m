Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8FDC6FD1D
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 06:28:06 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.13418.1679034475974468413
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 23:27:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=CIph06JU;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id b10so4039604lfb.9
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 23:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679034474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iUwL0RImwI9mLeVWVjFY4VrbJIO02jn1a4+P6jzHtb4=;
        b=CIph06JUEVmgsLWu/H16YST6M8EvEHFU/etGVy9ZYEaFS6vprk91/0JhR9DnIPsM5g
         gI8Rf0YjLQVm/0i3yJJw/IKE9b9lq4aEDjIrljp9IVIT0/izzU8pfHgxGef9rOLqsCXs
         OJv0rNqdawISPzukDBh4fBEg8A0StgIGj9P6y4svoSdMif+1qqWJ87ti038WiHzgxiNl
         /fjnctuKEoOqrtR9xMUVuocL6M3pu1VhJbFlcLQsYubZ+0SGit+8EGb+M19ac8s+Wsmt
         MxRSaIzl28TsD2qhcaoKq8ZoUgb8nfFOMpUik3ZbG9ai8XZVja2RIfRVZ62sF+EvXV2D
         8zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679034474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUwL0RImwI9mLeVWVjFY4VrbJIO02jn1a4+P6jzHtb4=;
        b=BMKCu5u7Kgf1vieCgEZhun0C5/umIW55zhsC3oUjoAtW+gIfyZL5W/9YFGVkqCRdLc
         6but+WSh/uyom12lj0rCwSfDj9yNahcWqipW6w+cXxSm5aF6I1WF2fvvMZkiZDiSpsOm
         Cp3mjau0Y8PhmHOIaaPPm27B+6T3hf77xxCWgQkSGlfi93RRJHfgR2oHSsg0sDjVjCg/
         xmqo/n3VAngKZ7LfVEAgJSscTGGWXOWttdLQEsDsqEPR2z6Gy2XymfzgvduGnoKHBFCs
         2lBLjN3E4SQYfiYIPUBclcC2M7BwGLg+1pgfHcZWf33IZWjFtPbnkt18ZzrGG+F4FUpG
         A+3g==
X-Gm-Message-State: AO0yUKUFgSJjdMVlOzJMcmf2JqRbFs6xd6sW8q3bPPx9FumTMQQl+bY4
	MU0/A/MSvynpBAcRG+5kSYqGV1KwiExgLREJljQ=
X-Google-Smtp-Source: AK7set+aGms2gWvyvrTSz+UnQCWSbn0lkPb2HkZ4jMRV9kMoMbifGIhONGFZxLmGItEWL3FtxTQLepW4IMu5LEYiZSU=
X-Received: by 2002:a05:6512:502:b0:4db:38ba:618d with SMTP id
 o2-20020a056512050200b004db38ba618dmr3927508lfb.12.1679034473855; Thu, 16 Mar
 2023 23:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230316121249.28209-1-frederic.martinsons@gmail.com>
 <20230316121249.28209-2-frederic.martinsons@gmail.com> <202303162224382628594e@mail.local>
In-Reply-To: <202303162224382628594e@mail.local>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Fri, 17 Mar 2023 07:27:41 +0100
Message-ID: <CA+cAkeoPQSJqV_dJB_soCsd8av0u54C6BAx0zgXMcX3wC1eHBQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] python3-bcrypt: add crates checksums
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000613f1205f712ad6c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 06:28:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14598

--000000000000613f1205f712ad6c
Content-Type: text/plain; charset="UTF-8"

Argh :/

I tested with poky master (don't know if it was the right thing to do). Did
you apply
https://patchwork.yoctoproject.org/project/bitbake/patch/20230315131513.50635-1-frederic.martinsons@gmail.com/

and
https://patchwork.yoctoproject.org/project/bitbake/patch/20230316121215.28151-1-frederic.martinsons@gmail.com/
on bitbake ?

Sorry for that, I am not used to this workflow for submitting patches
through mails so I surely have made
mistakes and made things not clear
with dependencies between bitbake , openembedded-core and meta-openembedded.



On Thu, 16 Mar 2023 at 23:24, Alexandre Belloni <
alexandre.belloni@bootlin.com> wrote:

> Hi,
>
> I carry this patch but this fails on the AB:
>
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5059/steps/13/logs/stdio
>
> ERROR: python3-bcrypt-4.0.1-r0 do_fetch: No checksum specified for
> '/srv/autobuilder/autobuilder.yocto.io/current_sources/autocfg-1.1.0.crate',
> please add at least one to the recipe:
> SRC_URI[sha256sum] =
> "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> ERROR: python3-bcrypt-4.0.1-r0 do_fetch: Bitbake Fetcher Error:
> NoChecksumError('Missing SRC_URI checksum', '
> https://crates.io/api/v1/crates/autocfg/1.1.0/download')
>
> On 16/03/2023 13:12:48+0100, Frederic Martinsons wrote:
> > From: Frederic Martinsons <frederic.martinsons@gmail.com>
> >
> > Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
> > ---
> >  .../python/python3-bcrypt-crates.inc          | 149 ++++++++++++------
> >  1 file changed, 100 insertions(+), 49 deletions(-)
> >
> > diff --git a/meta/recipes-devtools/python/python3-bcrypt-crates.inc
> b/meta/recipes-devtools/python/python3-bcrypt-crates.inc
> > index 65c7765f0c..1ff66269c4 100644
> > --- a/meta/recipes-devtools/python/python3-bcrypt-crates.inc
> > +++ b/meta/recipes-devtools/python/python3-bcrypt-crates.inc
> > @@ -1,53 +1,104 @@
> >  # Autogenerated with 'bitbake -c update_crates python3-bcrypt'
> >
> > +# from src/_bcrypt/Cargo.lock
> >  SRC_URI += " \
> > -        crate://crates.io/autocfg/1.1.0 \
> > -        crate://crates.io/base64/0.13.0 \
> > -        crate://crates.io/bcrypt/0.13.0 \
> > -        crate://crates.io/bcrypt-pbkdf/0.8.1 \
> > -        crate://crates.io/bitflags/1.3.2 \
> > -        crate://crates.io/block-buffer/0.10.3 \
> > -        crate://crates.io/blowfish/0.9.1 \
> > -        crate://crates.io/byteorder/1.4.3 \
> > -        crate://crates.io/cfg-if/1.0.0 \
> > -        crate://crates.io/cipher/0.4.3 \
> > -        crate://crates.io/cpufeatures/0.2.5 \
> > -        crate://crates.io/crypto-common/0.1.6 \
> > -        crate://crates.io/digest/0.10.5 \
> > -        crate://crates.io/generic-array/0.14.6 \
> > -        crate://crates.io/getrandom/0.2.7 \
> > -        crate://crates.io/indoc/0.3.6 \
> > -        crate://crates.io/indoc-impl/0.3.6 \
> > -        crate://crates.io/inout/0.1.3 \
> > -        crate://crates.io/instant/0.1.12 \
> > -        crate://crates.io/libc/0.2.134 \
> > -        crate://crates.io/lock_api/0.4.9 \
> > -        crate://crates.io/once_cell/1.15.0 \
> > -        crate://crates.io/parking_lot/0.11.2 \
> > -        crate://crates.io/parking_lot_core/0.8.5 \
> > -        crate://crates.io/paste/0.1.18 \
> > -        crate://crates.io/paste-impl/0.1.18 \
> > -        crate://crates.io/pbkdf2/0.10.1 \
> > -        crate://crates.io/proc-macro-hack/0.5.19 \
> > -        crate://crates.io/proc-macro2/1.0.46 \
> > -        crate://crates.io/pyo3/0.15.2 \
> > -        crate://crates.io/pyo3-build-config/0.15.2 \
> > -        crate://crates.io/pyo3-macros/0.15.2 \
> > -        crate://crates.io/pyo3-macros-backend/0.15.2 \
> > -        crate://crates.io/quote/1.0.21 \
> > -        crate://crates.io/redox_syscall/0.2.16 \
> > -        crate://crates.io/scopeguard/1.1.0 \
> > -        crate://crates.io/sha2/0.10.6 \
> > -        crate://crates.io/smallvec/1.10.0 \
> > -        crate://crates.io/subtle/2.4.1 \
> > -        crate://crates.io/syn/1.0.102 \
> > -        crate://crates.io/typenum/1.15.0 \
> > -        crate://crates.io/unicode-ident/1.0.4 \
> > -        crate://crates.io/unindent/0.1.10 \
> > -        crate://crates.io/version_check/0.9.4 \
> > -        crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> > -        crate://crates.io/winapi/0.3.9 \
> > -        crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> > -        crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> > -        crate://crates.io/zeroize/1.5.7 \
> > +    crate://crates.io/autocfg/1.1.0 \
> > +    crate://crates.io/base64/0.13.0 \
> > +    crate://crates.io/bcrypt/0.13.0 \
> > +    crate://crates.io/bcrypt-pbkdf/0.8.1 \
> > +    crate://crates.io/bitflags/1.3.2 \
> > +    crate://crates.io/block-buffer/0.10.3 \
> > +    crate://crates.io/blowfish/0.9.1 \
> > +    crate://crates.io/byteorder/1.4.3 \
> > +    crate://crates.io/cfg-if/1.0.0 \
> > +    crate://crates.io/cipher/0.4.3 \
> > +    crate://crates.io/cpufeatures/0.2.5 \
> > +    crate://crates.io/crypto-common/0.1.6 \
> > +    crate://crates.io/digest/0.10.5 \
> > +    crate://crates.io/generic-array/0.14.6 \
> > +    crate://crates.io/getrandom/0.2.7 \
> > +    crate://crates.io/indoc/0.3.6 \
> > +    crate://crates.io/indoc-impl/0.3.6 \
> > +    crate://crates.io/inout/0.1.3 \
> > +    crate://crates.io/instant/0.1.12 \
> > +    crate://crates.io/libc/0.2.134 \
> > +    crate://crates.io/lock_api/0.4.9 \
> > +    crate://crates.io/once_cell/1.15.0 \
> > +    crate://crates.io/parking_lot/0.11.2 \
> > +    crate://crates.io/parking_lot_core/0.8.5 \
> > +    crate://crates.io/paste/0.1.18 \
> > +    crate://crates.io/paste-impl/0.1.18 \
> > +    crate://crates.io/pbkdf2/0.10.1 \
> > +    crate://crates.io/proc-macro-hack/0.5.19 \
> > +    crate://crates.io/proc-macro2/1.0.46 \
> > +    crate://crates.io/pyo3/0.15.2 \
> > +    crate://crates.io/pyo3-build-config/0.15.2 \
> > +    crate://crates.io/pyo3-macros/0.15.2 \
> > +    crate://crates.io/pyo3-macros-backend/0.15.2 \
> > +    crate://crates.io/quote/1.0.21 \
> > +    crate://crates.io/redox_syscall/0.2.16 \
> > +    crate://crates.io/scopeguard/1.1.0 \
> > +    crate://crates.io/sha2/0.10.6 \
> > +    crate://crates.io/smallvec/1.10.0 \
> > +    crate://crates.io/subtle/2.4.1 \
> > +    crate://crates.io/syn/1.0.102 \
> > +    crate://crates.io/typenum/1.15.0 \
> > +    crate://crates.io/unicode-ident/1.0.4 \
> > +    crate://crates.io/unindent/0.1.10 \
> > +    crate://crates.io/version_check/0.9.4 \
> > +    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> > +    crate://crates.io/winapi/0.3.9 \
> > +    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> > +    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> > +    crate://crates.io/zeroize/1.5.7 \
> >  "
> > +
> > +SRC_URI[autocfg.sha256sum] =
> "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> > +SRC_URI[base64.sha256sum] =
> "904dfeac50f3cdaba28fc6f57fdcddb75f49ed61346676a78c4ffe55877802fd"
> > +SRC_URI[bcrypt.sha256sum] =
> "a7e7c93a3fb23b2fdde989b2c9ec4dd153063ec81f408507f84c090cd91c6641"
> > +SRC_URI[bcrypt-pbkdf.sha256sum] =
> "f4ef233ffa9cb9c7820b2b0e9efd0821ed180e866c9120ec9f45518659742074"
> > +SRC_URI[bitflags.sha256sum] =
> "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
> > +SRC_URI[block-buffer.sha256sum] =
> "69cce20737498f97b993470a6e536b8523f0af7892a4f928cceb1ac5e52ebe7e"
> > +SRC_URI[blowfish.sha256sum] =
> "e412e2cd0f2b2d93e02543ceae7917b3c70331573df19ee046bcbc35e45e87d7"
> > +SRC_URI[byteorder.sha256sum] =
> "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
> > +SRC_URI[cfg-if.sha256sum] =
> "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> > +SRC_URI[cipher.sha256sum] =
> "d1873270f8f7942c191139cb8a40fd228da6c3fd2fc376d7e92d47aa14aeb59e"
> > +SRC_URI[cpufeatures.sha256sum] =
> "28d997bd5e24a5928dd43e46dc529867e207907fe0b239c3477d924f7f2ca320"
> > +SRC_URI[crypto-common.sha256sum] =
> "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
> > +SRC_URI[digest.sha256sum] =
> "adfbc57365a37acbd2ebf2b64d7e69bb766e2fea813521ed536f5d0520dcf86c"
> > +SRC_URI[generic-array.sha256sum] =
> "bff49e947297f3312447abdca79f45f4738097cc82b06e72054d2223f601f1b9"
> > +SRC_URI[getrandom.sha256sum] =
> "4eb1a864a501629691edf6c15a593b7a51eebaa1e8468e9ddc623de7c9b58ec6"
> > +SRC_URI[indoc.sha256sum] =
> "47741a8bc60fb26eb8d6e0238bbb26d8575ff623fdc97b1a2c00c050b9684ed8"
> > +SRC_URI[indoc-impl.sha256sum] =
> "ce046d161f000fffde5f432a0d034d0341dc152643b2598ed5bfce44c4f3a8f0"
> > +SRC_URI[inout.sha256sum] =
> "a0c10553d664a4d0bcff9f4215d0aac67a639cc68ef660840afe309b807bc9f5"
> > +SRC_URI[instant.sha256sum] =
> "7a5bbe824c507c5da5956355e86a746d82e0e1464f65d862cc5e71da70e94b2c"
> > +SRC_URI[libc.sha256sum] =
> "329c933548736bc49fd575ee68c89e8be4d260064184389a5b77517cddd99ffb"
> > +SRC_URI[lock_api.sha256sum] =
> "435011366fe56583b16cf956f9df0095b405b82d76425bc8981c0e22e60ec4df"
> > +SRC_URI[once_cell.sha256sum] =
> "e82dad04139b71a90c080c8463fe0dc7902db5192d939bd0950f074d014339e1"
> > +SRC_URI[parking_lot.sha256sum] =
> "7d17b78036a60663b797adeaee46f5c9dfebb86948d1255007a1d6be0271ff99"
> > +SRC_URI[parking_lot_core.sha256sum] =
> "d76e8e1493bcac0d2766c42737f34458f1c8c50c0d23bcb24ea953affb273216"
> > +SRC_URI[paste.sha256sum] =
> "45ca20c77d80be666aef2b45486da86238fabe33e38306bd3118fe4af33fa880"
> > +SRC_URI[paste-impl.sha256sum] =
> "d95a7db200b97ef370c8e6de0088252f7e0dfff7d047a28528e47456c0fc98b6"
> > +SRC_URI[pbkdf2.sha256sum] =
> "271779f35b581956db91a3e55737327a03aa051e90b1c47aeb189508533adfd7"
> > +SRC_URI[proc-macro-hack.sha256sum] =
> "dbf0c48bc1d91375ae5c3cd81e3722dff1abcf81a30960240640d223f59fe0e5"
> > +SRC_URI[proc-macro2.sha256sum] =
> "94e2ef8dbfc347b10c094890f778ee2e36ca9bb4262e86dc99cd217e35f3470b"
> > +SRC_URI[pyo3.sha256sum] =
> "d41d50a7271e08c7c8a54cd24af5d62f73ee3a6f6a314215281ebdec421d5752"
> > +SRC_URI[pyo3-build-config.sha256sum] =
> "779239fc40b8e18bc8416d3a37d280ca9b9fb04bda54b98037bb6748595c2410"
> > +SRC_URI[pyo3-macros.sha256sum] =
> "00b247e8c664be87998d8628e86f282c25066165f1f8dda66100c48202fdb93a"
> > +SRC_URI[pyo3-macros-backend.sha256sum] =
> "5a8c2812c412e00e641d99eeb79dd478317d981d938aa60325dfa7157b607095"
> > +SRC_URI[quote.sha256sum] =
> "bbe448f377a7d6961e30f5955f9b8d106c3f5e449d493ee1b125c1d43c2b5179"
> > +SRC_URI[redox_syscall.sha256sum] =
> "fb5a58c1855b4b6819d59012155603f0b22ad30cad752600aadfcb695265519a"
> > +SRC_URI[scopeguard.sha256sum] =
> "d29ab0c6d3fc0ee92fe66e2d99f700eab17a8d57d1c1d3b748380fb20baa78cd"
> > +SRC_URI[sha2.sha256sum] =
> "82e6b795fe2e3b1e845bafcb27aa35405c4d47cdfc92af5fc8d3002f76cebdc0"
> > +SRC_URI[smallvec.sha256sum] =
> "a507befe795404456341dfab10cef66ead4c041f62b8b11bbb92bffe5d0953e0"
> > +SRC_URI[subtle.sha256sum] =
> "6bdef32e8150c2a081110b42772ffe7d7c9032b606bc226c8260fd97e0976601"
> > +SRC_URI[syn.sha256sum] =
> "3fcd952facd492f9be3ef0d0b7032a6e442ee9b361d4acc2b1d0c4aaa5f613a1"
> > +SRC_URI[typenum.sha256sum] =
> "dcf81ac59edc17cc8697ff311e8f5ef2d99fcbd9817b34cec66f90b6c3dfd987"
> > +SRC_URI[unicode-ident.sha256sum] =
> "dcc811dc4066ac62f84f11307873c4850cb653bfa9b1719cee2bd2204a4bc5dd"
> > +SRC_URI[unindent.sha256sum] =
> "58ee9362deb4a96cef4d437d1ad49cffc9b9e92d202b6995674e928ce684f112"
> > +SRC_URI[version_check.sha256sum] =
> "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
> > +SRC_URI[wasi.sha256sum] =
> "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
> > +SRC_URI[winapi.sha256sum] =
> "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
> > +SRC_URI[winapi-i686-pc-windows-gnu.sha256sum] =
> "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
> > +SRC_URI[winapi-x86_64-pc-windows-gnu.sha256sum] =
> "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> > +SRC_URI[zeroize.sha256sum] =
> "c394b5bd0c6f669e7275d9c20aa90ae064cb22e75a1cad54e1b34088034b149f"
> > --
> > 2.34.1
> >
>
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14585):
> https://lists.openembedded.org/g/bitbake-devel/message/14585
> > Mute This Topic: https://lists.openembedded.org/mt/97648804/3617179
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alexandre.belloni@bootlin.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

--000000000000613f1205f712ad6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Argh :/<div><br></div><div>I tested with poky master (don&=
#39;t know if it was the right thing to do). Did you apply</div><div><a hre=
f=3D"https://patchwork.yoctoproject.org/project/bitbake/patch/2023031513151=
3.50635-1-frederic.martinsons@gmail.com/">https://patchwork.yoctoproject.or=
g/project/bitbake/patch/20230315131513.50635-1-frederic.martinsons@gmail.co=
m/</a>=C2=A0<br></div><div>and=C2=A0<a href=3D"https://patchwork.yoctoproje=
ct.org/project/bitbake/patch/20230316121215.28151-1-frederic.martinsons@gma=
il.com/">https://patchwork.yoctoproject.org/project/bitbake/patch/202303161=
21215.28151-1-frederic.martinsons@gmail.com/</a></div><div>on bitbake ?</di=
v><div><br></div><div>Sorry for that, I am not used to this workflow for su=
bmitting patches through mails so I surely have made</div><div>mistakes and=
 made things not clear</div><div>with dependencies between bitbake , openem=
bedded-core and meta-openembedded.</div><div><br></div><div><br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, 16 Mar 2023 at 23:24, Alexandre Belloni &lt;<a href=3D"mailto:alexandre.=
belloni@bootlin.com">alexandre.belloni@bootlin.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
I carry this patch but this fails on the AB:<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/83/build=
s/5059/steps/13/logs/stdio" rel=3D"noreferrer" target=3D"_blank">https://au=
tobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5059/steps/13/logs/=
stdio</a><br>
<br>
ERROR: python3-bcrypt-4.0.1-r0 do_fetch: No checksum specified for &#39;/sr=
v/autobuilder/<a href=3D"http://autobuilder.yocto.io/current_sources/autocf=
g-1.1.0.crate" rel=3D"noreferrer" target=3D"_blank">autobuilder.yocto.io/cu=
rrent_sources/autocfg-1.1.0.crate</a>&#39;, please add at least one to the =
recipe:<br>
SRC_URI[sha256sum] =3D &quot;d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55=
e3529ffa43161b97fa&quot;<br>
ERROR: python3-bcrypt-4.0.1-r0 do_fetch: Bitbake Fetcher Error: NoChecksumE=
rror(&#39;Missing SRC_URI checksum&#39;, &#39;<a href=3D"https://crates.io/=
api/v1/crates/autocfg/1.1.0/download" rel=3D"noreferrer" target=3D"_blank">=
https://crates.io/api/v1/crates/autocfg/1.1.0/download</a>&#39;)<br>
<br>
On 16/03/2023 13:12:48+0100, Frederic Martinsons wrote:<br>
&gt; From: Frederic Martinsons &lt;<a href=3D"mailto:frederic.martinsons@gm=
ail.com" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Frederic Martinsons &lt;<a href=3D"mailto:frederic.mart=
insons@gmail.com" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt;<b=
r>
&gt; ---<br>
&gt;=C2=A0 .../python/python3-bcrypt-crates.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 149 ++++++++++++------<br>
&gt;=C2=A0 1 file changed, 100 insertions(+), 49 deletions(-)<br>
&gt; <br>
&gt; diff --git a/meta/recipes-devtools/python/python3-bcrypt-crates.inc b/=
meta/recipes-devtools/python/python3-bcrypt-crates.inc<br>
&gt; index 65c7765f0c..1ff66269c4 100644<br>
&gt; --- a/meta/recipes-devtools/python/python3-bcrypt-crates.inc<br>
&gt; +++ b/meta/recipes-devtools/python/python3-bcrypt-crates.inc<br>
&gt; @@ -1,53 +1,104 @@<br>
&gt;=C2=A0 # Autogenerated with &#39;bitbake -c update_crates python3-bcryp=
t&#39;<br>
&gt;=C2=A0 <br>
&gt; +# from src/_bcrypt/Cargo.lock<br>
&gt;=C2=A0 SRC_URI +=3D &quot; \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/autoc=
fg/1.1.0" rel=3D"noreferrer" target=3D"_blank">crates.io/autocfg/1.1.0</a> =
\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/base6=
4/0.13.0" rel=3D"noreferrer" target=3D"_blank">crates.io/base64/0.13.0</a> =
\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/bcryp=
t/0.13.0" rel=3D"noreferrer" target=3D"_blank">crates.io/bcrypt/0.13.0</a> =
\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/bcryp=
t-pbkdf/0.8.1" rel=3D"noreferrer" target=3D"_blank">crates.io/bcrypt-pbkdf/=
0.8.1</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/bitfl=
ags/1.3.2" rel=3D"noreferrer" target=3D"_blank">crates.io/bitflags/1.3.2</a=
> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/block=
-buffer/0.10.3" rel=3D"noreferrer" target=3D"_blank">crates.io/block-buffer=
/0.10.3</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/blowf=
ish/0.9.1" rel=3D"noreferrer" target=3D"_blank">crates.io/blowfish/0.9.1</a=
> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/byteo=
rder/1.4.3" rel=3D"noreferrer" target=3D"_blank">crates.io/byteorder/1.4.3<=
/a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/cfg-i=
f/1.0.0" rel=3D"noreferrer" target=3D"_blank">crates.io/cfg-if/1.0.0</a> \<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/ciphe=
r/0.4.3" rel=3D"noreferrer" target=3D"_blank">crates.io/cipher/0.4.3</a> \<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/cpufe=
atures/0.2.5" rel=3D"noreferrer" target=3D"_blank">crates.io/cpufeatures/0.=
2.5</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/crypt=
o-common/0.1.6" rel=3D"noreferrer" target=3D"_blank">crates.io/crypto-commo=
n/0.1.6</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/diges=
t/0.10.5" rel=3D"noreferrer" target=3D"_blank">crates.io/digest/0.10.5</a> =
\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/gener=
ic-array/0.14.6" rel=3D"noreferrer" target=3D"_blank">crates.io/generic-arr=
ay/0.14.6</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/getra=
ndom/0.2.7" rel=3D"noreferrer" target=3D"_blank">crates.io/getrandom/0.2.7<=
/a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/indoc=
/0.3.6" rel=3D"noreferrer" target=3D"_blank">crates.io/indoc/0.3.6</a> \<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/indoc=
-impl/0.3.6" rel=3D"noreferrer" target=3D"_blank">crates.io/indoc-impl/0.3.=
6</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/inout=
/0.1.3" rel=3D"noreferrer" target=3D"_blank">crates.io/inout/0.1.3</a> \<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/insta=
nt/0.1.12" rel=3D"noreferrer" target=3D"_blank">crates.io/instant/0.1.12</a=
> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/libc/=
0.2.134" rel=3D"noreferrer" target=3D"_blank">crates.io/libc/0.2.134</a> \<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/lock_=
api/0.4.9" rel=3D"noreferrer" target=3D"_blank">crates.io/lock_api/0.4.9</a=
> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/once_=
cell/1.15.0" rel=3D"noreferrer" target=3D"_blank">crates.io/once_cell/1.15.=
0</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/parki=
ng_lot/0.11.2" rel=3D"noreferrer" target=3D"_blank">crates.io/parking_lot/0=
.11.2</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/parki=
ng_lot_core/0.8.5" rel=3D"noreferrer" target=3D"_blank">crates.io/parking_l=
ot_core/0.8.5</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/paste=
/0.1.18" rel=3D"noreferrer" target=3D"_blank">crates.io/paste/0.1.18</a> \<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/paste=
-impl/0.1.18" rel=3D"noreferrer" target=3D"_blank">crates.io/paste-impl/0.1=
.18</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pbkdf=
2/0.10.1" rel=3D"noreferrer" target=3D"_blank">crates.io/pbkdf2/0.10.1</a> =
\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/proc-=
macro-hack/0.5.19" rel=3D"noreferrer" target=3D"_blank">crates.io/proc-macr=
o-hack/0.5.19</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/proc-=
macro2/1.0.46" rel=3D"noreferrer" target=3D"_blank">crates.io/proc-macro2/1=
.0.46</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pyo3/=
0.15.2" rel=3D"noreferrer" target=3D"_blank">crates.io/pyo3/0.15.2</a> \<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pyo3-=
build-config/0.15.2" rel=3D"noreferrer" target=3D"_blank">crates.io/pyo3-bu=
ild-config/0.15.2</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pyo3-=
macros/0.15.2" rel=3D"noreferrer" target=3D"_blank">crates.io/pyo3-macros/0=
.15.2</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pyo3-=
macros-backend/0.15.2" rel=3D"noreferrer" target=3D"_blank">crates.io/pyo3-=
macros-backend/0.15.2</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/quote=
/1.0.21" rel=3D"noreferrer" target=3D"_blank">crates.io/quote/1.0.21</a> \<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/redox=
_syscall/0.2.16" rel=3D"noreferrer" target=3D"_blank">crates.io/redox_sysca=
ll/0.2.16</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/scope=
guard/1.1.0" rel=3D"noreferrer" target=3D"_blank">crates.io/scopeguard/1.1.=
0</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/sha2/=
0.10.6" rel=3D"noreferrer" target=3D"_blank">crates.io/sha2/0.10.6</a> \<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/small=
vec/1.10.0" rel=3D"noreferrer" target=3D"_blank">crates.io/smallvec/1.10.0<=
/a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/subtl=
e/2.4.1" rel=3D"noreferrer" target=3D"_blank">crates.io/subtle/2.4.1</a> \<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/syn/1=
.0.102" rel=3D"noreferrer" target=3D"_blank">crates.io/syn/1.0.102</a> \<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/typen=
um/1.15.0" rel=3D"noreferrer" target=3D"_blank">crates.io/typenum/1.15.0</a=
> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/unico=
de-ident/1.0.4" rel=3D"noreferrer" target=3D"_blank">crates.io/unicode-iden=
t/1.0.4</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/unind=
ent/0.1.10" rel=3D"noreferrer" target=3D"_blank">crates.io/unindent/0.1.10<=
/a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/versi=
on_check/0.9.4" rel=3D"noreferrer" target=3D"_blank">crates.io/version_chec=
k/0.9.4</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/wasi/=
0.11.0+wasi-snapshot-preview1" rel=3D"noreferrer" target=3D"_blank">crates.=
io/wasi/0.11.0+wasi-snapshot-preview1</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/winap=
i/0.3.9" rel=3D"noreferrer" target=3D"_blank">crates.io/winapi/0.3.9</a> \<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/winap=
i-i686-pc-windows-gnu/0.4.0" rel=3D"noreferrer" target=3D"_blank">crates.io=
/winapi-i686-pc-windows-gnu/0.4.0</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/winap=
i-x86_64-pc-windows-gnu/0.4.0" rel=3D"noreferrer" target=3D"_blank">crates.=
io/winapi-x86_64-pc-windows-gnu/0.4.0</a> \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/zeroi=
ze/1.5.7" rel=3D"noreferrer" target=3D"_blank">crates.io/zeroize/1.5.7</a> =
\<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/autocfg/1.1.0" rel=
=3D"noreferrer" target=3D"_blank">crates.io/autocfg/1.1.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/base64/0.13.0" rel=
=3D"noreferrer" target=3D"_blank">crates.io/base64/0.13.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/bcrypt/0.13.0" rel=
=3D"noreferrer" target=3D"_blank">crates.io/bcrypt/0.13.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/bcrypt-pbkdf/0.8.1"=
 rel=3D"noreferrer" target=3D"_blank">crates.io/bcrypt-pbkdf/0.8.1</a> \<br=
>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/bitflags/1.3.2" rel=
=3D"noreferrer" target=3D"_blank">crates.io/bitflags/1.3.2</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/block-buffer/0.10.3=
" rel=3D"noreferrer" target=3D"_blank">crates.io/block-buffer/0.10.3</a> \<=
br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/blowfish/0.9.1" rel=
=3D"noreferrer" target=3D"_blank">crates.io/blowfish/0.9.1</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/byteorder/1.4.3" re=
l=3D"noreferrer" target=3D"_blank">crates.io/byteorder/1.4.3</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/cfg-if/1.0.0" rel=
=3D"noreferrer" target=3D"_blank">crates.io/cfg-if/1.0.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/cipher/0.4.3" rel=
=3D"noreferrer" target=3D"_blank">crates.io/cipher/0.4.3</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/cpufeatures/0.2.5" =
rel=3D"noreferrer" target=3D"_blank">crates.io/cpufeatures/0.2.5</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/crypto-common/0.1.6=
" rel=3D"noreferrer" target=3D"_blank">crates.io/crypto-common/0.1.6</a> \<=
br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/digest/0.10.5" rel=
=3D"noreferrer" target=3D"_blank">crates.io/digest/0.10.5</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/generic-array/0.14.=
6" rel=3D"noreferrer" target=3D"_blank">crates.io/generic-array/0.14.6</a> =
\<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/getrandom/0.2.7" re=
l=3D"noreferrer" target=3D"_blank">crates.io/getrandom/0.2.7</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/indoc/0.3.6" rel=3D=
"noreferrer" target=3D"_blank">crates.io/indoc/0.3.6</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/indoc-impl/0.3.6" r=
el=3D"noreferrer" target=3D"_blank">crates.io/indoc-impl/0.3.6</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/inout/0.1.3" rel=3D=
"noreferrer" target=3D"_blank">crates.io/inout/0.1.3</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/instant/0.1.12" rel=
=3D"noreferrer" target=3D"_blank">crates.io/instant/0.1.12</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/libc/0.2.134" rel=
=3D"noreferrer" target=3D"_blank">crates.io/libc/0.2.134</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/lock_api/0.4.9" rel=
=3D"noreferrer" target=3D"_blank">crates.io/lock_api/0.4.9</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/once_cell/1.15.0" r=
el=3D"noreferrer" target=3D"_blank">crates.io/once_cell/1.15.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/parking_lot/0.11.2"=
 rel=3D"noreferrer" target=3D"_blank">crates.io/parking_lot/0.11.2</a> \<br=
>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/parking_lot_core/0.=
8.5" rel=3D"noreferrer" target=3D"_blank">crates.io/parking_lot_core/0.8.5<=
/a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/paste/0.1.18" rel=
=3D"noreferrer" target=3D"_blank">crates.io/paste/0.1.18</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/paste-impl/0.1.18" =
rel=3D"noreferrer" target=3D"_blank">crates.io/paste-impl/0.1.18</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pbkdf2/0.10.1" rel=
=3D"noreferrer" target=3D"_blank">crates.io/pbkdf2/0.10.1</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/proc-macro-hack/0.5=
.19" rel=3D"noreferrer" target=3D"_blank">crates.io/proc-macro-hack/0.5.19<=
/a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/proc-macro2/1.0.46"=
 rel=3D"noreferrer" target=3D"_blank">crates.io/proc-macro2/1.0.46</a> \<br=
>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pyo3/0.15.2" rel=3D=
"noreferrer" target=3D"_blank">crates.io/pyo3/0.15.2</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pyo3-build-config/0=
.15.2" rel=3D"noreferrer" target=3D"_blank">crates.io/pyo3-build-config/0.1=
5.2</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pyo3-macros/0.15.2"=
 rel=3D"noreferrer" target=3D"_blank">crates.io/pyo3-macros/0.15.2</a> \<br=
>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/pyo3-macros-backend=
/0.15.2" rel=3D"noreferrer" target=3D"_blank">crates.io/pyo3-macros-backend=
/0.15.2</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/quote/1.0.21" rel=
=3D"noreferrer" target=3D"_blank">crates.io/quote/1.0.21</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/redox_syscall/0.2.1=
6" rel=3D"noreferrer" target=3D"_blank">crates.io/redox_syscall/0.2.16</a> =
\<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/scopeguard/1.1.0" r=
el=3D"noreferrer" target=3D"_blank">crates.io/scopeguard/1.1.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/sha2/0.10.6" rel=3D=
"noreferrer" target=3D"_blank">crates.io/sha2/0.10.6</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/smallvec/1.10.0" re=
l=3D"noreferrer" target=3D"_blank">crates.io/smallvec/1.10.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/subtle/2.4.1" rel=
=3D"noreferrer" target=3D"_blank">crates.io/subtle/2.4.1</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/syn/1.0.102" rel=3D=
"noreferrer" target=3D"_blank">crates.io/syn/1.0.102</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/typenum/1.15.0" rel=
=3D"noreferrer" target=3D"_blank">crates.io/typenum/1.15.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/unicode-ident/1.0.4=
" rel=3D"noreferrer" target=3D"_blank">crates.io/unicode-ident/1.0.4</a> \<=
br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/unindent/0.1.10" re=
l=3D"noreferrer" target=3D"_blank">crates.io/unindent/0.1.10</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/version_check/0.9.4=
" rel=3D"noreferrer" target=3D"_blank">crates.io/version_check/0.9.4</a> \<=
br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/wasi/0.11.0+wasi-sn=
apshot-preview1" rel=3D"noreferrer" target=3D"_blank">crates.io/wasi/0.11.0=
+wasi-snapshot-preview1</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/winapi/0.3.9" rel=
=3D"noreferrer" target=3D"_blank">crates.io/winapi/0.3.9</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/winapi-i686-pc-wind=
ows-gnu/0.4.0" rel=3D"noreferrer" target=3D"_blank">crates.io/winapi-i686-p=
c-windows-gnu/0.4.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/winapi-x86_64-pc-wi=
ndows-gnu/0.4.0" rel=3D"noreferrer" target=3D"_blank">crates.io/winapi-x86_=
64-pc-windows-gnu/0.4.0</a> \<br>
&gt; +=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/zeroize/1.5.7" rel=
=3D"noreferrer" target=3D"_blank">crates.io/zeroize/1.5.7</a> \<br>
&gt;=C2=A0 &quot;<br>
&gt; +<br>
&gt; +SRC_URI[autocfg.sha256sum] =3D &quot;d468802bab17cbc0cc575e9b053f41e7=
2aa36bfa6b7f55e3529ffa43161b97fa&quot;<br>
&gt; +SRC_URI[base64.sha256sum] =3D &quot;904dfeac50f3cdaba28fc6f57fdcddb75=
f49ed61346676a78c4ffe55877802fd&quot;<br>
&gt; +SRC_URI[bcrypt.sha256sum] =3D &quot;a7e7c93a3fb23b2fdde989b2c9ec4dd15=
3063ec81f408507f84c090cd91c6641&quot;<br>
&gt; +SRC_URI[bcrypt-pbkdf.sha256sum] =3D &quot;f4ef233ffa9cb9c7820b2b0e9ef=
d0821ed180e866c9120ec9f45518659742074&quot;<br>
&gt; +SRC_URI[bitflags.sha256sum] =3D &quot;bef38d45163c2f1dde094a7dfd33ccf=
595c92905c8f8f4fdc18d06fb1037718a&quot;<br>
&gt; +SRC_URI[block-buffer.sha256sum] =3D &quot;69cce20737498f97b993470a6e5=
36b8523f0af7892a4f928cceb1ac5e52ebe7e&quot;<br>
&gt; +SRC_URI[blowfish.sha256sum] =3D &quot;e412e2cd0f2b2d93e02543ceae7917b=
3c70331573df19ee046bcbc35e45e87d7&quot;<br>
&gt; +SRC_URI[byteorder.sha256sum] =3D &quot;14c189c53d098945499cdfa7ecc635=
67cf3886b3332b312a5b4585d8d3a6a610&quot;<br>
&gt; +SRC_URI[cfg-if.sha256sum] =3D &quot;baf1de4339761588bc0619e3cbc0120ee=
582ebb74b53b4efbf79117bd2da40fd&quot;<br>
&gt; +SRC_URI[cipher.sha256sum] =3D &quot;d1873270f8f7942c191139cb8a40fd228=
da6c3fd2fc376d7e92d47aa14aeb59e&quot;<br>
&gt; +SRC_URI[cpufeatures.sha256sum] =3D &quot;28d997bd5e24a5928dd43e46dc52=
9867e207907fe0b239c3477d924f7f2ca320&quot;<br>
&gt; +SRC_URI[crypto-common.sha256sum] =3D &quot;1bfb12502f3fc46cca1bb51ac2=
8df9d618d813cdc3d2f25b9fe775a34af26bb3&quot;<br>
&gt; +SRC_URI[digest.sha256sum] =3D &quot;adfbc57365a37acbd2ebf2b64d7e69bb7=
66e2fea813521ed536f5d0520dcf86c&quot;<br>
&gt; +SRC_URI[generic-array.sha256sum] =3D &quot;bff49e947297f3312447abdca7=
9f45f4738097cc82b06e72054d2223f601f1b9&quot;<br>
&gt; +SRC_URI[getrandom.sha256sum] =3D &quot;4eb1a864a501629691edf6c15a593b=
7a51eebaa1e8468e9ddc623de7c9b58ec6&quot;<br>
&gt; +SRC_URI[indoc.sha256sum] =3D &quot;47741a8bc60fb26eb8d6e0238bbb26d857=
5ff623fdc97b1a2c00c050b9684ed8&quot;<br>
&gt; +SRC_URI[indoc-impl.sha256sum] =3D &quot;ce046d161f000fffde5f432a0d034=
d0341dc152643b2598ed5bfce44c4f3a8f0&quot;<br>
&gt; +SRC_URI[inout.sha256sum] =3D &quot;a0c10553d664a4d0bcff9f4215d0aac67a=
639cc68ef660840afe309b807bc9f5&quot;<br>
&gt; +SRC_URI[instant.sha256sum] =3D &quot;7a5bbe824c507c5da5956355e86a746d=
82e0e1464f65d862cc5e71da70e94b2c&quot;<br>
&gt; +SRC_URI[libc.sha256sum] =3D &quot;329c933548736bc49fd575ee68c89e8be4d=
260064184389a5b77517cddd99ffb&quot;<br>
&gt; +SRC_URI[lock_api.sha256sum] =3D &quot;435011366fe56583b16cf956f9df009=
5b405b82d76425bc8981c0e22e60ec4df&quot;<br>
&gt; +SRC_URI[once_cell.sha256sum] =3D &quot;e82dad04139b71a90c080c8463fe0d=
c7902db5192d939bd0950f074d014339e1&quot;<br>
&gt; +SRC_URI[parking_lot.sha256sum] =3D &quot;7d17b78036a60663b797adeaee46=
f5c9dfebb86948d1255007a1d6be0271ff99&quot;<br>
&gt; +SRC_URI[parking_lot_core.sha256sum] =3D &quot;d76e8e1493bcac0d2766c42=
737f34458f1c8c50c0d23bcb24ea953affb273216&quot;<br>
&gt; +SRC_URI[paste.sha256sum] =3D &quot;45ca20c77d80be666aef2b45486da86238=
fabe33e38306bd3118fe4af33fa880&quot;<br>
&gt; +SRC_URI[paste-impl.sha256sum] =3D &quot;d95a7db200b97ef370c8e6de00882=
52f7e0dfff7d047a28528e47456c0fc98b6&quot;<br>
&gt; +SRC_URI[pbkdf2.sha256sum] =3D &quot;271779f35b581956db91a3e55737327a0=
3aa051e90b1c47aeb189508533adfd7&quot;<br>
&gt; +SRC_URI[proc-macro-hack.sha256sum] =3D &quot;dbf0c48bc1d91375ae5c3cd8=
1e3722dff1abcf81a30960240640d223f59fe0e5&quot;<br>
&gt; +SRC_URI[proc-macro2.sha256sum] =3D &quot;94e2ef8dbfc347b10c094890f778=
ee2e36ca9bb4262e86dc99cd217e35f3470b&quot;<br>
&gt; +SRC_URI[pyo3.sha256sum] =3D &quot;d41d50a7271e08c7c8a54cd24af5d62f73e=
e3a6f6a314215281ebdec421d5752&quot;<br>
&gt; +SRC_URI[pyo3-build-config.sha256sum] =3D &quot;779239fc40b8e18bc8416d=
3a37d280ca9b9fb04bda54b98037bb6748595c2410&quot;<br>
&gt; +SRC_URI[pyo3-macros.sha256sum] =3D &quot;00b247e8c664be87998d8628e86f=
282c25066165f1f8dda66100c48202fdb93a&quot;<br>
&gt; +SRC_URI[pyo3-macros-backend.sha256sum] =3D &quot;5a8c2812c412e00e641d=
99eeb79dd478317d981d938aa60325dfa7157b607095&quot;<br>
&gt; +SRC_URI[quote.sha256sum] =3D &quot;bbe448f377a7d6961e30f5955f9b8d106c=
3f5e449d493ee1b125c1d43c2b5179&quot;<br>
&gt; +SRC_URI[redox_syscall.sha256sum] =3D &quot;fb5a58c1855b4b6819d5901215=
5603f0b22ad30cad752600aadfcb695265519a&quot;<br>
&gt; +SRC_URI[scopeguard.sha256sum] =3D &quot;d29ab0c6d3fc0ee92fe66e2d99f70=
0eab17a8d57d1c1d3b748380fb20baa78cd&quot;<br>
&gt; +SRC_URI[sha2.sha256sum] =3D &quot;82e6b795fe2e3b1e845bafcb27aa35405c4=
d47cdfc92af5fc8d3002f76cebdc0&quot;<br>
&gt; +SRC_URI[smallvec.sha256sum] =3D &quot;a507befe795404456341dfab10cef66=
ead4c041f62b8b11bbb92bffe5d0953e0&quot;<br>
&gt; +SRC_URI[subtle.sha256sum] =3D &quot;6bdef32e8150c2a081110b42772ffe7d7=
c9032b606bc226c8260fd97e0976601&quot;<br>
&gt; +SRC_URI[syn.sha256sum] =3D &quot;3fcd952facd492f9be3ef0d0b7032a6e442e=
e9b361d4acc2b1d0c4aaa5f613a1&quot;<br>
&gt; +SRC_URI[typenum.sha256sum] =3D &quot;dcf81ac59edc17cc8697ff311e8f5ef2=
d99fcbd9817b34cec66f90b6c3dfd987&quot;<br>
&gt; +SRC_URI[unicode-ident.sha256sum] =3D &quot;dcc811dc4066ac62f84f113078=
73c4850cb653bfa9b1719cee2bd2204a4bc5dd&quot;<br>
&gt; +SRC_URI[unindent.sha256sum] =3D &quot;58ee9362deb4a96cef4d437d1ad49cf=
fc9b9e92d202b6995674e928ce684f112&quot;<br>
&gt; +SRC_URI[version_check.sha256sum] =3D &quot;49874b5167b65d7193b8aba156=
7f5c7d93d001cafc34600cee003eda787e483f&quot;<br>
&gt; +SRC_URI[wasi.sha256sum] =3D &quot;9c8d87e72b64a3b4db28d11ce29237c2461=
88f4f51057d65a7eab63b7987e423&quot;<br>
&gt; +SRC_URI[winapi.sha256sum] =3D &quot;5c839a674fcd7a98952e593242ea400ab=
e93992746761e38641405d28b00f419&quot;<br>
&gt; +SRC_URI[winapi-i686-pc-windows-gnu.sha256sum] =3D &quot;ac3b87c636204=
26dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6&quot;<br>
&gt; +SRC_URI[winapi-x86_64-pc-windows-gnu.sha256sum] =3D &quot;712e227841d=
057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f&quot;<br>
&gt; +SRC_URI[zeroize.sha256sum] =3D &quot;c394b5bd0c6f669e7275d9c20aa90ae0=
64cb22e75a1cad54e1b34088034b149f&quot;<br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
<br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#14585): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/14585" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.openembedded.org/g/bitbake-devel/message/14585</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/97648804=
/3617179" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.o=
rg/mt/97648804/3617179</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org=
/g/bitbake-devel/unsub</a> [<a href=3D"mailto:alexandre.belloni@bootlin.com=
" target=3D"_blank">alexandre.belloni@bootlin.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; <br>
<br>
<br>
-- <br>
Alexandre Belloni, co-owner and COO, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
</blockquote></div>

--000000000000613f1205f712ad6c--

