Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A50C6FA8B
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 14:54:14 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.8392.1663944849734370031
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Sep 2022 07:54:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fszuqjoP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id c11so343006wrp.11
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Sep 2022 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=uGLDRIYuamaRE7by4giTVxrg/CZQ+C7z/STUWJignY4=;
        b=fszuqjoPKZYSkZiHE0hib93fUYDP0TjJ00Awby8mV1xqBcBiPMAKWN9766ZEObrOaK
         bzQuWsgj/hLFyBTJgjeHgWZ5EWwxrsNjHSbdXuN8/iX0hjLvXXQf1P1cWp+6yvGnKeZE
         J2uoiL7NpIRfk4cb9qJ2xcAxGw3355gq4ezGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=uGLDRIYuamaRE7by4giTVxrg/CZQ+C7z/STUWJignY4=;
        b=2WEKYY3Wm/cRjGWFPVGHz2c00pHhSmboRACatJEIKoCQ9/AtGyszWZ1VwVritGw8Yy
         nyWeUmKX3UoRzqihOBpoXzD2An3hm9Hb1duid4GPFt+XvAneJwekUiRmDyp7Nbap0kG5
         8ZnwkiDr3QlUQcwPuSQ24BMYT3/thEExTmjskOeQ7BaQxVBp5uacONatn4LOIYvME9Et
         qVKoXRXVkdgIV5+cG3E03z1ug4/FmrefN/J5AKXCBzh97k1uoZxCPvzcF8aiJnYQy4Qd
         adI2yXN4Wk6EO+UziLKISaORDbM6TSfJ+hVpkSvO+oiZ2ITQjfPdVf7cUBs8feaEE/70
         Dycw==
X-Gm-Message-State: ACrzQf12LVJuPIIyzX7JaPDaPzmJS0LlRY9FJFcu5iFASEQVwkj+IN3P
	b8gng6PRY4EObJSuHd0O63ctVw==
X-Google-Smtp-Source: 
 AMsMyM75CPtUp7fdK0XhlB7H94VIjker9BULtEyfeCAASKxoy74k6fdQgHVuNPAZJP8evG15aMAgYw==
X-Received: by 2002:a5d:5a14:0:b0:22a:25be:7f69 with SMTP id
 bq20-20020a5d5a14000000b0022a25be7f69mr5442361wrb.662.1663944847974;
        Fri, 23 Sep 2022 07:54:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7946:c7c6:1ddc:ce8e?
 ([2001:8b0:aba:5f3c:7946:c7c6:1ddc:ce8e])
        by smtp.gmail.com with ESMTPSA id
 bg34-20020a05600c3ca200b003b4ff30e566sm8504626wmb.3.2022.09.23.07.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:54:07 -0700 (PDT)
Message-ID: 
 <c88684a7e0becc8137066edfce1c13f493fcdd33.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] utils: Enable the loopback interface in
 disable_network()
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 23 Sep 2022 15:54:06 +0100
In-Reply-To: <ce3bdf3377094bd6aa9afea17735ec48@axis.com>
References: <20220923101613.1096056-1-pkj@axis.com>
	 <e66ec2ca23ac7ce7e5be44aaacaeb2f6d1ab779b.camel@linuxfoundation.org>
	 <ce3bdf3377094bd6aa9afea17735ec48@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Sep 2022 14:54:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13992

On Fri, 2022-09-23 at 14:42 +0000, Peter Kjellerstedt wrote:
>=20
>=20
> Ok. I hope it is then ok that I add a new task varflag "network-
> loopback"=20
> (or maybe even just "loopback"?) E.g.:
>=20
> diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
> index 7be39370b3..4115604d99 100755
> --- a/bitbake/bin/bitbake-worker
> +++ b/bitbake/bin/bitbake-worker
> @@ -267,6 +267,8 @@ def fork_off_task(cfg, data, databuilder,
> workerdata, fn, task, taskname, taskha
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if bb.utils.is_local_=
uid(uid):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0logger.debug("Attempting to disable network
> for %s" % taskname)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0bb.utils.disable_network(uid, gid)
> +                        if the_data.getVarFlag(taskname, 'network-
> loopback', False):
> +                            bb.utils.loopback_up()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0logger.debug("Skipping disable network for
> %s since %s is not a local uid." % (taskname, uid))
>=20
> With that in place, I see no drawbacks compared to always=20
> enabling the loopback interface in disable_network() since=20
> setting, e.g., do_compile[network-loopback] =3D "1" will make=20
> sure it is only enabled when actually needed, compared to,=20
> e.g., doing it in an anonymous Python function.=20

Setting it in a prefunc doesn't look that bad once you have a function
for it?

python enable_loopback () {
    bb.utils.loopback_up()
}

do_compile[prefuncs] +=3D "enable_loopback"


On the subject of naming, it may be clearer as something like:

bb.utils.enable_loopback_networking()

as we need to think about how this looks without context we have in
these patches.

Cheers,

Richard



