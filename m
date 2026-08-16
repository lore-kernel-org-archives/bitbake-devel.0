Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F8C5B572
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 22:18:51 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18871.1786918720894537112
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Aug 2026 15:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hSQl0X+x;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso20089755e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 16 Aug 2026 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786918719; x=1787523519; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nA5p0CxZ9xdiXXB1rjV500ylsPS0HeUuR4EIILC6D8w=;
        b=hSQl0X+xGMK11tGeqQ/npaMX01M1qGtHZlVtfUhbddmmFWn8BpoexjXtm3Mtp3VMAe
         AO3w0pPKv6CLFw8tBYkpwEpW8TDTJnt+MPlK61DCkTyrYPxUCyTjwdFOPFx+hx7I45LX
         txt2/B2LcO7JgB5sWkgCXq/uaBA8GTyBGYELMHpRYOZXxqx69XpsddCxAaeA+Ef3T8dl
         XcV37jJzVCMcmj387bM5WjdGTiLFcWPh6NhGI71T8Hy5e+peUafm2znDNhpSB4/WN21B
         fEJigqgH1nO/aEZXlCun+Qys6uanvVB3kvup18CFW0NjjyCiUTp4iqq837834QX0mJDU
         8NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786918719; x=1787523519;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nA5p0CxZ9xdiXXB1rjV500ylsPS0HeUuR4EIILC6D8w=;
        b=BgUyciPg7xBnpnDarLh0ChM2eb+pV/zh0rRkJ8noskylGJS3dsy8TdscPh5NmBBCME
         fMMaYmQt7dpxrBN5WGAkvk+ylMQ4Ahi9g4rF81U2aNbSozLcGt245WtbZkFkS9gY4zh4
         rardF+/WbyK0uH58g/LfhZ0nj8Ejrt0Pff/+qMmH34+Ikc6u4ySuchdnR9sf+SUHhQRk
         WHJ31Db6Lr3fQKLRfJVpaSHVOKyxF6Vp2OKQKsgEeOCb63v90qxuQwvE7Xfw9GKiZKoa
         0Z7iKlYLK4oO8waHQxRgh96l0xjYd0zYA6pfLtNDub1fRa+aeoJgU1Q1J/ij6qYKT2oe
         9CYw==
X-Forwarded-Encrypted: i=1; AHgh+RqUX6RiOWBQsO1XJIxtxBGiuK1SeLss3BCeM+F3VO9BcNCtTTX6DgBi5sRB7LlBBje4S9p44H2RwaACbI3u@lists.openembedded.org
X-Gm-Message-State: AOJu0YzDTZaTAyaC+drt64v5enLl3mJiSmZBVVnzkLzxsqZjUz99O0jo
	8Rx2ZNK7yEzSZVN7+aRat+Qj+xrpINxi9E0baST18tEc6BDBdLtkECRY
X-Gm-Gg: AR+sD10nIDtI+eCCSr7frt0o0hcTgjxCJS4nrj7jwaWxiZlIgsfpXQFa3Dm0snlWoE4
	eyq/+5zn7a4jPd9hSxit/UgzP53oLb88pLNyr1lauktpLXoAjSHcMSAPcO+SCA/elCdnJqmwcej
	k9XJ4l0j6EegMaqcKK5Kh9qU4r2yTCaR1At7qqdEbb8rje+R0tAcRnQ0hfn0wgmYdg7vEdaTYdV
	t67mMzSEPrtlvNFbLARGLP2Jl78xjduh6rGurAdAGJLa1/YH2utArBLIIzhhrblelRk+xn6QZS7
	M+n5tvMoMzZqSGTlHB0nmCfwqiryeyGyGussPZWLMQie3jsRTARbdQ1I5M1JAHuWcMOehYvnthg
	yOxv8I+3QMU7NmW1BPNkNK0ONwnNJBPD9Xg99Hz6AoqBqc2F+ZJWz6F6+0FiU0AUFFm5wAxbu3j
	8cai9E2ZXIi5P6rBERqatomy58/CWVXsqPdlADxJJ4B+y6IzchAPeYNA/omecTVAmvGw32s9LyS
	zYkEVFogCTG7e+dHD3ajITNUnXv3sKh6nTj
X-Received: by 2002:a7b:c015:0:b0:499:80d0:8b73 with SMTP id 5b1f17b1804b1-49987927ebfmr264232255e9.4.1786918718902;
        Sun, 16 Aug 2026 15:18:38 -0700 (PDT)
Received: from ?IPv6:2a02:169:59a6:0:55c4:f628:91f3:4287? ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b278fbsm150247205e9.2.2026.08.16.15.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 15:18:38 -0700 (PDT)
Message-ID: <735a570a2022800fd4e4b2d33402e0a2e1e5f64d.camel@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/7] cooker: fix bitbake -b silently
 ignoring bbappends
From: adrian.freihofer@gmail.com
To: richard.purdie@linuxfoundation.org, adrian.freihofer@siemens.com, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2026 00:18:38 +0200
In-Reply-To: <79d9178d92f476b3571cc8038b2ebbf7583a03aa.camel@linuxfoundation.org>
References: <20260815134722.497586-1-adrian.freihofer@siemens.com>
		 <20260815134722.497586-2-adrian.freihofer@siemens.com>
	 <79d9178d92f476b3571cc8038b2ebbf7583a03aa.camel@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Aug 2026 22:18:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19967

On Sat, 2026-08-15 at 22:39 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Sat, 2026-08-15 at 15:46 +0200, Adrian Freihofer via
> lists.openembedded.org wrote:
> > From: Adrian Freihofer <adrian.freihofer@siemens.com>
> >=20
> > "bitbake -b <recipe.bb>" builds the recipe without applying any of
> > its
> > .bbappend files.
> >=20
> > buildFileInternal() resolves appends via
> > self.collections[mc].get_file_appends(fn), but self.collections[mc]
> > is
> > only ever filled in by collect_bbfiles(), called from updateCache()
> > -
> > a path -b deliberately skips. matchFiles(), the one -b-path
> > function
> > that does call collect_bbfiles(), built a fresh CookerCollectFiles
> > into
> > a throwaway local instead of self.collections[mc], so the append
> > list
> > stayed empty (or, on a memory-resident server, stale from the last
> > full parse - e.g. missing a devtool/externalsrc workspace .bbappend
> > added since). Nothing warns that the built metadata differs from
> > disk.
> >=20
> > Make matchFiles() refresh self.collections[mc] itself so the later
> > append lookup for the same fn sees the same fresh collection.
> >=20
> > AI-Generated: Uses GitHub Copilot
> >=20
> > Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> > ---
> > =C2=A0lib/bb/cooker.py | 6 ++++--
> > =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> I've not checked but doesn't this only add limited collections data
> so
> whilst it fixes -b, it potentially corrupts the cache for the non -b
> cases?

I tried to add a test case
  test_run_prepared_task_recipecache_self_heals
  see https://lists.openembedded.org/g/bitbake-devel/message/19965
which proves that this works as expected with v2:
https://lists.openembedded.org/g/bitbake-devel/message/19964

Regards,
Adrian

>=20
> This is definitely something we should fix, I just want to make sure
> this doesn't corrupt something else. I suspect it deliberately
> doesn't
> write to self...
>=20
> Cheers,
>=20
> Richard
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19957):
> https://lists.openembedded.org/g/bitbake-devel/message/19957
> Mute This Topic: https://lists.openembedded.org/mt/120763373/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

