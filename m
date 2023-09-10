Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E135FC71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 19:39:41 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.43135.1694374771610056803
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 12:39:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KFWEstAG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so30066125e9.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694374770; x=1694979570; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qFa0ZF0zALck/ACsqf06by+enOHpIfYGy6lFGhiem10=;
        b=KFWEstAGRQptkxmLSF9WLk5iYsgg6ZFlmebKfCkHjq5Dsz9Bkb6g1gikqWneMPQ6id
         o/DJ1CHkLwpVjnUfoEHZrDuegtlN2TvMXoJXELj6qL3roHm3eygcgwV7XePcodG/Lyxd
         +8naSpNmJYkmJpXgJQHP+KPSJfWdvl8BJjf/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694374770; x=1694979570;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFa0ZF0zALck/ACsqf06by+enOHpIfYGy6lFGhiem10=;
        b=Z6YJm8UmWMB03kv0T6XaJ4cxcYpXud0A0LaffiNmK7toN+jbJQJtCKQtS59W1ETZF9
         dl0YHkVhaODo4pvcp/kcAE1NB+vfJ+5tICHvKYulegqiS2GiibvFD51RC7yLx9r5fgAA
         tR3qdZKWJN8icdfh5GUXivDlXAtdUvNhAnIAc1H5lluxaUM5fn7o4BOydBI3ym1kaJbi
         yibXgJRkDTiA2gA0E+5r60vGEJPZzIiCuJxfHNn+uH/EOUuaji3vgchAnJIBetprnPTH
         9dpVPb80OedK2y8vK0qLeZp+0f+wDajCY+Xlvs7x7NYtq0t5DFCB5BQBsvVyOy0UNEJI
         SVNA==
X-Gm-Message-State: AOJu0YxDIZJRTUhQzeAyDgR5NCQVZePGmO2Vcgv+qkNvzs4SPEGaDuBY
	QNQrtlvg+G2vYgbZnW+eyNVKKQ==
X-Google-Smtp-Source: AGHT+IEdQgSKwffNZH6uvSVNgrVHAYDqpYvrxXfVgw8c1TTqqcwOS5DejCm53MrKRdKpSpLpBFI1sg==
X-Received: by 2002:a5d:50c5:0:b0:314:475:bc6b with SMTP id f5-20020a5d50c5000000b003140475bc6bmr5580928wrt.18.1694374769925;
        Sun, 10 Sep 2023 12:39:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5580:ed73:9c6:f365? ([2001:8b0:aba:5f3c:5580:ed73:9c6:f365])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm8010601wrv.111.2023.09.10.12.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 12:39:29 -0700 (PDT)
Message-ID: <6b53c884a639874842e401f9a628caeb9a0ba259.camel@linuxfoundation.org>
Subject: Re: [EXTERNAL] [bitbake-devel] [PATCH] bitbake-worker: remove the
 network flag
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Randolph Sapp <rs@ti.com>, alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, denis@denix.org, reatmon@ti.com
Date: Sun, 10 Sep 2023 20:39:27 +0100
In-Reply-To: <572bd389-882a-43b0-a4cd-2d5db774ce3c@ti.com>
References: <17839F967B1914BA.4559@lists.openembedded.org>
	 <572bd389-882a-43b0-a4cd-2d5db774ce3c@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 19:39:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15022

On Sun, 2023-09-10 at 14:31 -0500, Randolph Sapp wrote:
> On 9/10/23 14:14, Randolph Sapp via lists.openembedded.org wrote:
> > From: Randolph Sapp <rs@ti.com>
> >=20
> > The network flag does not respect proxies as the fetch stage does [1].
> > As such it only works for some users at the whim of the recipe writer.
> >=20
> > This introduces an issue downstream as the build results are now
> > dependent on the network architecture of the builder, the recipe in
> > question, and the combination of proxy variables they choose to export
> > in addition to the normal host variables that affect builds (host tool
> > version, build environment, etc).
> >=20
> > This is far more indeterminate than a build system that properly export=
s
> > proxy variables. If abuse of the network tag is an issue, then the
> > network tag should be removed in it's current state.
> >=20
> > [1] https://lists.openembedded.org/g/bitbake-devel/topic/100924096
> >=20
> > Signed-off-by: Randolph Sapp <rs@ti.com>
> > ---
> >=20
> > The logical followup to my last patch, even if it does seem a little ex=
treme.
> >=20
> >   bin/bitbake-worker                                    | 11 +++++-----=
-
> >   .../bitbake-user-manual-metadata.rst                  |  6 ------
> >   2 files changed, 5 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> > index 451e6926..71ff0516 100755
> > --- a/bin/bitbake-worker
> > +++ b/bin/bitbake-worker
> > @@ -270,12 +270,11 @@ def fork_off_task(cfg, data, databuilder, workerd=
ata, extraconfigdata, runtask):
> >  =20
> >                   bb.utils.set_process_name("%s:%s" % (the_data.getVar(=
"PN"), taskname.replace("do_", "")))
> >  =20
> > -                if not bb.utils.to_boolean(the_data.getVarFlag(tasknam=
e, 'network')):
> > -                    if bb.utils.is_local_uid(uid):
> > -                        logger.debug("Attempting to disable network fo=
r %s" % taskname)
> > -                        bb.utils.disable_network(uid, gid)
> > -                    else:
> > -                        logger.debug("Skipping disable network for %s =
since %s is not a local uid." % (taskname, uid))
> > +                if bb.utils.is_local_uid(uid):
> > +                    logger.debug("Attempting to disable network for %s=
" % taskname)
> > +                    bb.utils.disable_network(uid, gid)
> > +                else:
> > +                    logger.debug("Skipping disable network for %s sinc=
e %s is not a local uid." % (taskname, uid))
> >  =20
> >                   # exported_vars() returns a generator which *cannot* =
be passed to os.environ.update()
> >                   # successfully. We also need to unset anything from t=
he environment which shouldn't be there
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b=
/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > index 58975f4c..b35c332c 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > @@ -1519,12 +1519,6 @@ functionality of the task:
> >      released. You can use this variable flag to accomplish mutual
> >      exclusion.
> >  =20
> > --  ``[network]``: When set to "1", allows a task to access the network=
. By
> > -   default, only the ``do_fetch`` task is granted network access. Reci=
pes
> > -   shouldn't access the network outside of ``do_fetch`` as it usually
> > -   undermines fetcher source mirroring, image and licence manifests, s=
oftware
> > -   auditing and supply chain security.
> > -
> >   -  ``[noexec]``: When set to "1", marks the task as being empty, with
> >      no execution required. You can use the ``[noexec]`` flag to set up
> >      tasks as dependency placeholders, or to disable tasks defined
> >=20
> >=20
> >=20
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#15017): https://lists.openembedded.org/g/bitbake-de=
vel/message/15017
> > Mute This Topic: https://lists.openembedded.org/mt/101278873/7094281
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [rs@t=
i.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >=20
>=20
> Do not merge this obviously. It breaks the fetch stage in it's current=
=20
> form. I just wanted to start another discussion. (The proper solution=20
> would have to be some explicit exclusions for processes in the do_fetch=
=20
> task.)

By sending this patch you're antagonising the maintainer, I'm not sure
that will help achieve what you want.

Cheers,

Richard

