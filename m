Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD027C61DB6
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 08:59:48 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17566.1787648387993553583
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 01:59:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OOFUFCTP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1441944f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787648386; x=1788253186; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vrbDELCDfNNf166RlzHNHYAK40jdcV60dpYaOFKq+Bo=;
        b=OOFUFCTPgiD7JvW5v8ekUSGz6qW9l91tPBWBXGT07dKIXEcyS26Q+7542pPXd74BaH
         pjYO/BniSzZQ7ExSktTmXi7wjfWZ0sAsNFHI+fQeL3papIh1wG0EH+9qkwE0AGMdltIr
         RT2v3cvTatwnXgvNtHff5g/l+r6g+aOTpG3IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648386; x=1788253186;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vrbDELCDfNNf166RlzHNHYAK40jdcV60dpYaOFKq+Bo=;
        b=bGerjdDuhvppBhYQ+YYL7h0SM68x86zZwG++0AHfKvC2ZOHuO/vpRFxYIjraHsOAI+
         EM31jwJlNMESyNUR5e7i8IXHLaJZ/ohYuEbM6e2CJvOhOMhgIBOjtJ7INXOUQDMU66PQ
         woOkB0vtPQwlnz9CbsJBzz5B1ULiDbMYWLZSBgelXbrDsdqcxcvh8/ZAHQ+/y8tg6ewC
         LGbLYBCt3j2a1KOka/ywqKaY5LtRxYPBhfunjajP3dvGLJpw01xztj3zo/GZnFBnZe/F
         9jSyhrf0NqoC71175aggAQpJC/HkVoqjoHDOlM6s4Od7pPX6pQMZ4PDP30sOFa++c8id
         aQtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFHRuRyfJcHENHrepAhb90iIeFYfDP4egnANDVjaxp78UUfpbrzZZDIuy4FlMyj7Br8ltRUCtxLPEGJd3E@lists.openembedded.org
X-Gm-Message-State: AFuF++laew5oJcHVOZk0fo8Wl24575vVymZVyHGBdkA5CcUDIdo9dXvI
	wFXa9g16FoFf/oyO7Q8a8Q5ivpVQSsrzGml15T4w1T6/EU+aA7rcu0d4YJEBO+1noqk=
X-Gm-Gg: AR+sD10h4+cxypqBk86Z46PGKV1QEiIZsH5KQT89GmTCdC0h2p+AsWbfc/Th1FYF4xw
	8V2J9EbqiitM/9OoNwR0c10NcVLfyOoIYhn0vO+d/v0CeuLyliKl7rfDOk/DOvxIzKcTC8wEzbQ
	xKjBvhdJuIC6eY5YjpwT3JchAKixg/e27XO0rOmn08heyaDFrR7f1ibEUkNwCi3cx1U6nE+z6l9
	3sULFXXmWuDuvgDbmvGJlnufCi8L7opR8tbMaxPM7Xv7WZ3pI8zusbvyuaSTO12HqFGytlOJIIy
	hFh2Ad6NLDNaUZk+Bo23ufVhG1L+5yuUMjduxh7SPLquJrsC0XCt4dDAW/tEcWHLwivj4hp4/Ko
	lIH7kh9racvzupa57utZR340AYzlIN8zZmD8vwxi0aGzONG0UG0LX+YX2dLR/Oci+SxbL6336Tk
	LQdFVT79eJLsws7V2B4GOkSNwWWDUS7dnkJTHp6VddqHi6gwcQrF8W8FGJUDSq05Z99/Ln07/zS
	5GdSpTbQvPmD91p859vHVMYW7uChACtJQy0RS98sSg2VwakYSs+Dg==
X-Received: by 2002:a05:6000:200c:b0:47f:96e6:70a with SMTP id ffacd0b85a97d-482c0b0b360mr36736493f8f.0.1787648385863;
        Tue, 25 Aug 2026 01:59:45 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1d9d:dbf1:7ccf:7617? ([2001:8b0:aba:5f3c:1d9d:dbf1:7ccf:7617])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c0ad06sm11230399f8f.27.2026.08.25.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:59:44 -0700 (PDT)
Message-ID: <bb2d438e38745bd6679bbad08aa826f2c07019fa.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/8] cooker: fix bitbake -b silently
 ignoring bbappends
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: adrian.freihofer@siemens.com, bitbake-devel@lists.openembedded.org
Date: Tue, 25 Aug 2026 09:59:43 +0100
In-Reply-To: <20260816221507.155861-2-adrian.freihofer@siemens.com>
References: <20260816221507.155861-1-adrian.freihofer@siemens.com>
	 <20260816221507.155861-2-adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 08:59:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20032

On Mon, 2026-08-17 at 00:14 +0200, Adrian Freihofer via lists.openembedded.=
org wrote:
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>=20
> "bitbake -b <recipe.bb>" builds the recipe without applying any of its
> .bbappend files.
>=20
> buildFileInternal() resolves appends via
> self.collections[mc].get_file_appends(fn), but self.collections[mc] is
> only ever filled in by collect_bbfiles(), called from updateCache() -
> a path -b deliberately skips. matchFiles(), the one -b-path function
> that does call collect_bbfiles(), built a fresh CookerCollectFiles into
> a throwaway local instead of self.collections[mc], so the append list
> stayed empty (or, on a memory-resident server, stale from the last
> full parse - e.g. missing a devtool/externalsrc workspace .bbappend
> added since). Nothing warns that the built metadata differs from disk.
>=20
> Make matchFiles() refresh self.collections[mc] itself so the later
> append lookup for the same fn sees the same fresh collection.
>=20
> AI-Generated: Uses GitHub Copilot
>=20
> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> ---
> =C2=A0lib/bb/cooker.py | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 4b6ba3196..108551a60 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1322,8 +1322,10 @@ You can also remove the BB_HASHSERVE_UPSTREAM sett=
ing, but this may result in si
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if bf.startswith("/") or=
 bf.startswith("../"):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
bf =3D os.path.abspath(bf)
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 collections =3D {mc: CookerCo=
llectFiles(self.bbfile_config_priorities, mc)}
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filelist, masked, searchdirs =
=3D collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.datab=
uilder.mcdata[mc])
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # The only place the "bitbake=
 -b" path fills in the bbappends which
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # buildFileInternal() then re=
ads back from self.collections[mc].
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.collections[mc] =3D Cook=
erCollectFiles(self.bbfile_config_priorities, mc)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filelist, masked, searchdirs =
=3D self.collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.=
databuilder.mcdata[mc])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
os.stat(bf)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
bf =3D os.path.abspath(bf)

I've had some time to stare at the code and I'm not convinced this is
the right way to fix things.

self.collections is usually setup by parseConfiguration, which does so:

    def parseConfiguration(self):
        [...]
        self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
        self.collections =3D {}
        for mc in self.multiconfigs:
            self.collections[mc] =3D CookerCollectFiles(self.bbfile_config_=
priorities, mc)

The call site you're patching in matchFiles() is only called by
matchFile(). matchFile() can be called as a tinfoil command directly,
by buildFileInternal() or by showEnvironment(). The last two both call
parseConfiguration() before matchFile.

matchFile from command.py set "matchFile.needconfig =3D False" so that
does not need a configuration. I'm not seeing anything using the
matchFile api call so perhaps we could just change needconfig to True.

The bottom line is that tinfoil probably needs that
CookerCollectFiles() call but the rest don't, self.collections should
be ok for the others.

The collect_bbfiles() call is harder. That comes from updateCache()
when parsing finishes, so it needs a full recipe parse.

Looking at the code in collect_bbfiles(), I'm not convinced it does
need a full parse first, it can run without that. The code in that
function is horrible as it sets self.overlayed and self.bbappends but
also gives return values.

My feeling is that the function should either return values, or set
self.* things, but not both. We might be able to make collect_bbfiles
run earlier in parseConfiguration and then skip calling it at all in
matchFiles if it is already available?

Regardless, just making this unconditionally overwrite self.collections
is definitely not an improvement to the current mess, it will just make
it harder to disentangle things later...

Cheers,

Richard

